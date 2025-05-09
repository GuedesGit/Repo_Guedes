# Order Inserter Console App

This project demonstrates three ways to insert orders into a SQL Server database:

1. Simple insert (1 by 1)
2. Dapper batch insert
3. SqlBulkCopy insert

It also benchmarks each method using `Stopwatch`.

---

## 🧰 Requirements

- .NET SDK
- SQL Server
- Dapper (`dotnet add package Dapper`)

---

## 🗄️ Database Setup

### Step 1: Run the SQL scripts

1. Create the database `OrderDb` (or whatever you choose).
2. Execute the scripts in the `Scripts` folder in this order:

```bash
sqlcmd -S localhost -d OrderDb -i Scripts/CreateOrdersTable.sql
sqlcmd -S localhost -d OrderDb -i Scripts/SeedData.sql
