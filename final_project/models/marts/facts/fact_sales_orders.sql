-- fact_sales_orders: FM only (~10,466 rows)
-- Source: fm_orders JOIN fm_order_details

WITH order_details AS (
    SELECT
        od.order_id,
        od.product_id,
        od.order_qty,
        o.customer_id,
        o.order_datekey,
        o.shipped_datekey,
        o.ship_via
    FROM {{ ref('stg_fm_order_details') }} od
    JOIN {{ ref('stg_fm_orders') }} o
        ON od.order_id = o.order_id
),

-- Get vendor_id from products
products AS (
    SELECT product_id, product_vendor_id
    FROM {{ ref('stg_fm_products') }}
),

dim_c AS (SELECT CustomerKey, BKCustomerID FROM {{ ref('dim_customer') }} WHERE Division = 'FudgeMart'),
dim_p AS (SELECT ProductKey, BKProductID FROM {{ ref('dim_product') }} WHERE Division = 'FudgeMart'),
dim_v AS (SELECT VendorKey, BKVendorID FROM {{ ref('dim_vendor') }})

SELECT
    c.CustomerKey,
    p.ProductKey,
    od.order_datekey AS DateKey,
    v.VendorKey,
    od.order_id AS BKOrderID,
    od.order_id || '-' || od.product_id AS BKOrderDetailID,
    od.order_qty AS OrderQty,
    od.shipped_datekey AS ShippedDateKey,
    od.ship_via AS ShipVia,
    'FudgeMart' AS Division
FROM order_details od
JOIN products pr ON od.product_id = pr.product_id
JOIN dim_c c ON od.customer_id = c.BKCustomerID
JOIN dim_p p ON od.product_id::VARCHAR = p.BKProductID
JOIN dim_v v ON pr.product_vendor_id = v.BKVendorID
