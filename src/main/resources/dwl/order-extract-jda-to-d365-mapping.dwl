%dw 2.0
output application/json
---

{
  "orders": payload.orders map (orderE, indexOfOrderE) ->
    {
      "route-id": orderE.'route-id',
      "status": orderE.status,
      "shipping-date": orderE.'shipping-date',
      "order-no": orderE.'order-no',
      "order_lines": orderE map (orderL, indexOfOrderL) -> 
        {
          "item-id": orderL.'item-id',
          "quantity": orderL.quantity,
          "barcode": orderL.barcode
        }
      
    }
  
}

