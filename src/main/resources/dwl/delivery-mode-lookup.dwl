%dw 2.0
output application/json skipNullOn = "everywhere"
fun lookupdata(data) = payload.lookups filter (($."lookup-key") == (if(data."delivery-mode" == "" or data."delivery-mode" == null ) ("Empty") else data."delivery-mode")) reduce $$
---

vars.aptosOriginalPayload.'orders' map (value) ->{
	
	"order-no" : value."order-no",
	"lookup-value" : lookupdata(value)."lookup-value"  
}