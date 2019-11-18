%dw 2.0
output application/json
var manifestOrderNoArray = vars.manifestData.manifests map $.'order-no'
---
payload.orders filter (manifestOrderNoArray contains $.'order-no') map $
