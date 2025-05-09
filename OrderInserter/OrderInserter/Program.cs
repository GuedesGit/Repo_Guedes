using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using Microsoft.Data.SqlClient;
using Dapper;

namespace OrderInserter
{
    class Program
    {

        //const string connectionString = "Server=MASTERGUEDESPC;Database=DummyDB;Trusted_Connection=True;Encrypt=False;";

        const string connectionString = "Server=MASTERGUEDESPC;Database=DummyDB;Trusted_Connection=True;Encrypt=True;TrustServerCertificate=True;";
        record BenchmarkResult(string Label, long Milliseconds);

        static void Main(string[] args)
        {
            Console.OutputEncoding = System.Text.Encoding.UTF8;

            const int count = 10000; // Or however many you want
            var orders = GenerateOrders(count);

            ClearOrdersTable();

            Console.WriteLine($"Inserting {count} orders...\n");

            var results = new List<BenchmarkResult>();

            results.Add(Measure("Simple Insert (One by One)", () => InsertSimple(orders)));
            results.Add(Measure("Dapper Batch Insert", () => InsertDapperBatch(orders)));
            results.Add(Measure("SqlBulkCopy", () => InsertWithBulkCopy(orders)));

            Console.WriteLine("\n📊 Benchmark Results:\n");

            PrintBenchmarkResults(results);

            Console.WriteLine("\nAll done! 🎉");
        }

        static void PrintBenchmarkResults(List<BenchmarkResult> results)
        {
            long max = results.Max(r => r.Milliseconds);

            foreach (var result in results)
            {
                int barLength = (int)((result.Milliseconds / (double)max) * 40);
                string bar = new string('█', barLength);
                Console.WriteLine($"{result.Label,-25}: {bar,-40} {result.Milliseconds} ms");
            }
        }

        static void ClearOrdersTable()
        {
            using var connection = new SqlConnection(connectionString);
            connection.Open();
            connection.Execute("DELETE FROM Orders");
            Console.WriteLine("🧹 Orders table cleared.\n");
        }

        static BenchmarkResult Measure(string label, Action action)
        {
            var stopwatch = Stopwatch.StartNew();
            action();
            stopwatch.Stop();
            return new BenchmarkResult(label, stopwatch.ElapsedMilliseconds);
        }

        static List<Order> GenerateOrders(int count)
        {
            var rnd = new Random();
            return Enumerable.Range(1, count)
                .Select(i => new Order
                {
                    Number = i,
                    Price = Math.Round((decimal)(rnd.NextDouble() * 99 + 1), 2) // Safe range: 1.00 to 100.00
                }).ToList();
        }


        static void InsertSimple(List<Order> orders)
        {
            using var connection = new SqlConnection(connectionString);
            connection.Open();

            var sql = "INSERT INTO Orders (Number, Price) VALUES (@Number, @Price)";

            foreach (var order in orders)
            {

                if (order.Price <= 0)
                {
                    Console.WriteLine($"⚠️ Order {order.Number} has invalid price: {order.Price}");
                    continue;
                }

                connection.Execute(sql, order);
            }
        }

        static void InsertDapperBatch(List<Order> orders)
        {
            using var connection = new SqlConnection(connectionString);
            connection.Open();

            var sql = "INSERT INTO Orders (Number, Price) VALUES (@Number, @Price)";
            connection.Execute(sql, orders);
        }

        static void InsertWithBulkCopy(List<Order> orders)
        {
            var table = new DataTable();

            // ✅ Define columns properly and disallow nulls
            var numberColumn = new DataColumn("Number", typeof(int)) { AllowDBNull = false };
            var priceColumn = new DataColumn("Price", typeof(decimal)) { AllowDBNull = false };

            table.Columns.Add(numberColumn);
            table.Columns.Add(priceColumn);

            foreach (var order in orders)
            {
                
                // ✅ Ensure price is valid (not zero or negative)
                if (order.Price <= 0)
                {
                    Console.WriteLine($"⚠️ Skipping order with invalid price: {order.Number} - {order.Price}");
                    continue;
                }

                table.Rows.Add(order.Number, order.Price);
            }

            using var connection = new SqlConnection(connectionString);
            connection.Open();

            using var bulkCopy = new SqlBulkCopy(connection)
            {
                DestinationTableName = "Orders"
            };

            bulkCopy.ColumnMappings.Add("Number", "Number");
            bulkCopy.ColumnMappings.Add("Price", "Price");

            bulkCopy.WriteToServer(table);
        }

    }

    class Order
    {
        public int Number { get; set; }
        public decimal Price { get; set; }
    }
}
