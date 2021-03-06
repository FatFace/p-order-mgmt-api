%dw 2.0
output application/json
---

{
  "manifests": payload.manifests map (manifest,indexOfM) -> 
    {
      "route-id": manifest.'route-id',
      "item-id": manifest.'item-id',
      "barcode": Mule::lookup("common-template-check-digit-lookup-flow", manifest.barcode),
      "carrier-consignment-id": manifest.'carrier-consignment-id',
      "container-id": manifest.'container-id',
      "site-id": manifest.'site-id',
      "location-id": manifest.'location-id',
      "quantity": manifest.quantity,
      "shipping-date": (manifest.'shipping-date') as LocalDateTime {format: "yyyyMMddHHmmss"} as String {format: "yyyy-MM-dd'T'HH:mm:ss"},
      "order-no": manifest.'order-no',
      "carrier-id": manifest.'carrier-id',
      "status": manifest.status
    } 
}
