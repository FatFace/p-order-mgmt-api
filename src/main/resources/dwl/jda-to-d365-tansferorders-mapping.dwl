%dw 2.0
output application/json
---
payload."transfer-orders" map((item,index) -> {
    "record-type": item."record-type",
    "region": vars.flattenResponse[item."to-warehouse"],
    "tag-id": item."tag-id",
    "to-warehouse": item."to-warehouse",
    "shipped-date": item."shipped-date",
    "item-number": item."item-number",
    "sku-id": item."sku-id",
    "shipped-qty": item."shipped-qty",
    "line-number": item."line-number"
})