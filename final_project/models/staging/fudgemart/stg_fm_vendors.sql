-- Staging: FudgeMart Vendors (9 rows)
SELECT
    vendor_id,
    vendor_name,
    vendor_phone,
    vendor_website
FROM {{ source('fudgemart_v3', 'fm_vendors') }}
