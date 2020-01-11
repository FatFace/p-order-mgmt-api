%dw 2.0
output application/json
var manifestOrderNoArray = vars.manifestData.manifests map $.'order-no'
---
{
	orders: payload.orders filter (not (manifestOrderNoArray contains $.'order-no')) map $
}