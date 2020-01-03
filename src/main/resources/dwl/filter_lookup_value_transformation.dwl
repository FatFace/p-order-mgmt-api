%dw 2.0
output application/json skipNullOn = "everywhere"
fun lookupdata(data) = payload.lookups filter (($."lookup-key") == data."delivery-mode") reduce $$
---

vars.originalPayload.'pick-orders' map (value) ->{
	"routeId" : value."route-id",
	"lookup-value" : if(lookupdata(value) != null and isEmpty(lookupdata(value)) != true) lookupdata(value)."lookup-value" else ''
}
