%dw 2.0
output application/json
---
payload."transfer-orders" map((item,index) -> {
    "record-type": item."record-type",
    "region": vars.vFlattenResponse[item."user-def-note-1"],
    "tag-id": item."tag-id",
    "user-def-note-1": item."user-def-note-1",
    "shipped-dstamp": item."shipped-dstamp",
    "user-def-type-1": item."user-def-note-1",
    "sku-id": item."sku-id",
    "qty-shipped": item."qty-shipped",
    "line-number": item."line-number"
})