-- dim_vendor: FM only (9 rows)
SELECT
    ROW_NUMBER() OVER (ORDER BY vendor_id) AS VendorKey,
    vendor_id AS BKVendorID,
    vendor_name AS VendorName,
    vendor_phone AS VendorPhone,
    vendor_website AS VendorWebsite
FROM {{ ref('stg_fm_vendors') }}
