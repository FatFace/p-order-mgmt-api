%dw 2.0
output application/json
---

{
  "orders": vars.ecommOrders.orders map (orderE, indexOfOrderE) ->
    {
      "route-id": orderE.'route-id',
      "status": orderE.status,
      "shipping-date": (orderE.'shipping-date') as LocalDateTime {format: "yyyyMMddHHmmss"} as String {format: "yyyy-MM-dd'T'HH:mm:ss"},
      "order-no": orderE.'order-no',
      "order_lines": orderE map (orderL, indexOfOrderL) -> 
        {
          "item-id": orderL.'item-id',
          "quantity": orderL.quantity,
          "barcode": orderL.barcode
        }
      
    }
  
}

