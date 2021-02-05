%dw 2.0
output application/json
---
{
    "transfer-orders" : 
    payload."transfer-orders" map ((item,index) -> {
    "transfer-number" : item."transfer-number",
    "line-number" : item."line-number" as Number,
    "sku-id" : item."sku-id",
    "colour" : item."colour",
    "from-warehouse" : item."from-warehouse",
    "item-number" : item."item-number",
    "line-receipt-date" : item."line-receipt-date",
    "receipt-date" : item."receipt-date",
    "received-qty" : item."received-qty",
    "receive-remain" : item."receive-remain",
    "remaining" : item."remaining",
    "shipped-date" : item."shipped-date",
    "shipped-qty" : item."shipped-qty",
    "size" : item."size",
    "style" : item."style",
    "transfer-qty" : item."transfer-qty",
    "to-warehouse" : item."to-warehouse",
    "transform-order-status" : item."transform-order-status",
    "store-flag" : vars.vFlattenResponse[item."to-warehouse"] != null
})
}

