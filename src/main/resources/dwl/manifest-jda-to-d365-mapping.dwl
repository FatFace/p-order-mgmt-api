%dw 2.0
output application/json
---

{
  "WMSPickingRegistration": payload.manifests  map (payloadMF,indexOfMF) -> 
 	{
      "WMSPickingRouteID": payloadMF.'route-id',
      	"itemId": payloadMF.'item-id',
      "ItemBarCode": payloadMF.barcode,
      "SalesCarrierTrackingId": payloadMF.'carrier-consignment-id',
      "SalesContainer": payloadMF.'container-id',
      "InventSiteId": payloadMF.'site-id',
      "InventLocationId": payloadMF.'location-id',
      "WMSLocationId": "",
      "Qty": payloadMF.quantity,
      "SalesShippingDate": payloadMF.'shipping-date',
      "SalesId": payloadMF.'order-no',
      "SalesCarrierId":payloadMF.'carrier-id',
      "WHSInventStatusId": payloadMF.status,
      "LineTotal": 1.00,
      "closePick": "YES"
     
    }
    
 }
 
