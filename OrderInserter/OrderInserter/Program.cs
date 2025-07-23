using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using Microsoft.Data.SqlClient;
using Dapper;
using OrderInserter.Models;

namespace OrderInserter
{
    // =========================
    // Main Program
    // =========================
    static class Program
    {
        const string connectionString = "Server=MASTERGUEDESPC;Database=DummyDB;Trusted_Connection=True;Encrypt=True;TrustServerCertificate=True;";

        static void Main(string[] args)
        {
            Console.OutputEncoding = System.Text.Encoding.UTF8;

            const int count = 10000;
            var orders = GenerateOrders(count);

            ClearOrdersTable();

            Console.WriteLine($"Inserting {count} orders...\n");

            var results = new List<BenchmarkResult>
            {
                Measure("Simple Insert (One by One)", () => InsertSimple(orders)),
                Measure("Dapper Batch Insert", () => InsertDapperBatch(orders)),
                Measure("SqlBulkCopy", () => InsertWithBulkCopy(orders))
            };

            Console.WriteLine("\n📊 Benchmark Results:\n");
            PrintBenchmarkResults(results);

            Console.WriteLine("\nAll done! 🎉");
        }

        // =========================
        // Benchmark Utilities
        // =========================
        static BenchmarkResult Measure(string label, Action action)
        {
            var stopwatch = Stopwatch.StartNew();
            action();
            stopwatch.Stop();
            return new BenchmarkResult(label, stopwatch.ElapsedMilliseconds);
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

        // =========================
        // Data Generation & Cleanup
        // =========================
        static List<Order> GenerateOrders(int count)
        {
            var rnd = new Random();
            return Enumerable.Range(1, count)
                .Select(i => new Order
                {
                    Number = i,
                    Price = Math.Round((decimal)(rnd.NextDouble() * 99 + 1), 2)
                }).ToList();
        }

        static void ClearOrdersTable()
        {
            using var connection = new SqlConnection(connectionString);
            connection.Open();
            connection.Execute("DELETE FROM Orders");
            Console.WriteLine("🧹 Orders table cleared.\n");
        }

        // =========================
        // Insert Methods
        // =========================
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
            table.Columns.Add(new DataColumn("Number", typeof(int)) { AllowDBNull = false });
            table.Columns.Add(new DataColumn("Price", typeof(decimal)) { AllowDBNull = false });

            foreach (var order in orders)
            {
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
}
