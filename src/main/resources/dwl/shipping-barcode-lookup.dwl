%dw 2.0
output application/json skipNullOn = "everywhere"
fun lookupdata(data) = payload.lookups filter (($."lookup-key") == (if(data.barcode == "" or data.barcode == null) ("Empty") else data.barcode)) reduce $$
---

(vars.aptosOriginalPayload.'orders' map (value) ->{
	data:(value.'orderlines' map (orderline) ->{

	"order-no" : value."order-no",
	"barcode": orderline.barcode,
	"lookup-value" : lookupdata(orderline)."lookup-value"
})

}).data reduce $$