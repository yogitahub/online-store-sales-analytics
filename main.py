import mysql.connector
import csv

import mysql.connector

# Database connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="sales_analytics"
)

cursor = conn.cursor()

print("\n--- ONLINE STORE SALES ANALYTICS ---\n")

# 1. Total Store Revenue
cursor.execute("""
    SELECT SUM(o.quantity * p.price)
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
""")
total_revenue = cursor.fetchone()[0]
print(f"Total Store Revenue: ₹{total_revenue}")

print("-" * 50)

# 2. Top-Selling Product
cursor.execute("""
    SELECT p.product_name, SUM(o.quantity) AS total_units
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY total_units DESC
    LIMIT 1
""")
product, units = cursor.fetchone()
print(f"Top-Selling Product: {product} ({units} units sold)")

print("-" * 50)

# 3. Product-wise Revenue Report
cursor.execute("""
    SELECT 
        p.product_name,
        SUM(o.quantity) AS total_quantity,
        SUM(o.quantity * p.price) AS revenue
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY revenue DESC
""")

print("Product-wise Sales Report:")
for row in cursor.fetchall():
    product_name, quantity, revenue = row
    print(f"{product_name} | Units Sold: {quantity} | Revenue: ₹{revenue}")

print("-" * 50)

# 4. Best Customer
cursor.execute("""
    SELECT c.name, SUM(o.quantity * p.price) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON o.product_id = p.product_id
    GROUP BY c.name
    ORDER BY total_spent DESC
    LIMIT 1
""")
customer, spent = cursor.fetchone()
print(f"Best Customer: {customer} (Spent ₹{spent})")

# Export product-wise sales report to CSV
cursor.execute("""
    SELECT 
        p.product_name,
        SUM(o.quantity) AS total_quantity,
        SUM(o.quantity * p.price) AS total_revenue
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY total_revenue DESC
""")

rows = cursor.fetchall()

with open("sales_report.csv", "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)

    # CSV Header
    writer.writerow(["Product Name", "Total Quantity Sold", "Total Revenue"])

    for row in rows:
        writer.writerow(row)

print("\nSales analytics report saved as sales_report.csv")


conn.close()
