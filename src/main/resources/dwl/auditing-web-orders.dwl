%dw 2.0
output application/json
---
{
    "message-correlation-id": vars.messageCorrelationId,
    "transaction-start-time": vars.transactionStartTime,
    "lines": payload.orders map {
            "primary-key": $.'order-no',
            "secondary-key": "",
            "log-payload": {
            	"content-type": "application/json",
            	"data": $
            }
        }
}