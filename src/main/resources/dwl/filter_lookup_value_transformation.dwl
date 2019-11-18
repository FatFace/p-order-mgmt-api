%dw 2.0
output application/json skipNullOn = "everywhere"
---

vars.originalPayload.'pick-orders' map (value) ->{
(payload.lookups filter (($."lookup-key") == value."delivery-mode") map {

	"routeId" : value."route-id",
	"lookup-value" : $."lookup-value"
} reduce $$)

}
