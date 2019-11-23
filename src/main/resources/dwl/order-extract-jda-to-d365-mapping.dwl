%dw 2.0
output application/json
---

{
  "orders": payload.orders map 
  {
  	  "route-id": $.'route-id',
      "status": $.status,
      "shipping-date": ($.'shipping-date') as LocalDateTime {format: "yyyyMMddHHmmss"} as String {format: "yyyy-MM-dd'T'HH:mm:ss"},
      "order-no": $.'order-no',
      "orderlines": $.order_lines map (ol,indexOfOL) ->{
      	  "item-id": ol.'item-id',
          "quantity": ol.quantity,
          "barcode": ol.barcode
      }
  } 
}