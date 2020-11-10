%dw 2.0
output application/json skipNullOn = "everywhere"
---

vars.dmLookupValue map (value) ->{
(payload.lookups filter (($."lookup-key") == value."lookup-value") map {

	"order-no" : value."order-no",
	"lookup-key" : value."lookup-value",
	"lookup-value" : $."lookup-value"
} reduce $$)

}
