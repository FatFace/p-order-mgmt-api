%dw 2.0
output application/json
fun getDeliveryMode(orderno) =  vars.lookUpValue filter (($."routeId") == orderno) reduce $$

fun getLinePrice(amount, netAmount) = (amount + netAmount)as Number as String {format : ".##"}
---
{
	orders: vars.originalPayload.'pick-orders' map ( pickorder , indexOfPickorder ) -> {
		"order-type": p('pick.orders.orderType'),
		"order-date": if((pickorder."order-date" as Date) != null) (if(sizeOf(pickorder."order-date" as Date)>=14) ((pickorder."order-date" as Date)[0 to 13]) else (pickorder."order-date" as Date)) else " " as Date,
		"pick-id": if((pickorder."route-id") != null) (if(sizeOf(pickorder."route-id")>=20) ((pickorder."route-id")[0 to 19]) else (pickorder."route-id")) else " ",
		"ship-by-date": if((pickorder."delivery-date" as Date) != null ) (if(sizeOf(pickorder."delivery-date" as Date)>=14) ((pickorder."delivery-date" as Date)[0 to 13]) else (pickorder."delivery-date" as Date)) else " " as Date,
		"purchase-order": if((pickorder."order-no") != null) (if(sizeOf(pickorder."order-no")>=30) ((pickorder."order-no")[0 to 29]) else (pickorder."order-no")) else " ",
		"line-price" : if(pickorder.shipments[0].totals."shippment-total"."net-price" != null)((sum(pickorder.orderlines."tax-amount") + sum(pickorder.orderlines."sales-price") + pickorder.shipments[0].totals."shippment-total"."net-price") as String{format: ".##"}) else "",
		"delivery-charges": if (pickorder.shipments[0].totals."shippment-total"."net-price" !=null) ((pickorder.shipments.totals[0]."shippment-total"."net-price") as Number as String {format : ".##"}) else "",
		"dispatch_method": getDeliveryMode(pickorder."route-id")."lookup-value",
		"customer-id": if((pickorder.customer."customer-id") != null) (if(sizeOf(pickorder.customer."customer-id")>=15) ((pickorder.customer."customer-id")[0 to 14]) else (pickorder.customer."customer-id")) else " ",
		"del-name": if((pickorder.customer.fullname)!= null) (if(sizeOf(pickorder.customer.fullname)>= 50) ((pickorder.customer.fullname)[0 to 49]) else (pickorder.customer.fullname)) else " ",
		"del-contact-email": if((pickorder.customer.email) != null) (if(sizeOf(pickorder.customer.email)>=256) ((pickorder.customer.email)[0 to 255]) else (pickorder.customer.email)) else " ",
		"del-contact-phone1": if((pickorder.customer.telephone)!= null) (if(sizeOf(pickorder.customer.telephone)>=25) ((pickorder.customer.telephone)[0 to 24]) else (pickorder.customer.telephone)) else " ",
		"del-address1": if((pickorder.customer."shipping-address"."address-1") != null) (if(sizeOf(pickorder.customer."shipping-address"."address-1")>=60) ((pickorder.customer."shipping-address"."address-1")[0 to 59]) else (pickorder.customer."shipping-address"."address-1")) else " ",
		"del-address2": if((pickorder.customer."shipping-address"."address-2") != null) (if(sizeOf(pickorder.customer."shipping-address"."address-2")>=60) ((pickorder.customer."shipping-address"."address-2")[0 to 59]) else (pickorder.customer."shipping-address"."address-2")) else " ",
		"del-address3": if((pickorder.customer."shipping-address"."address-3") != null) (if(sizeOf(pickorder.customer."shipping-address"."address-3")>=60) ((pickorder.customer."shipping-address"."address-3")[0 to 59]) else (pickorder.customer."shipping-address"."address-3")) else " ",
		"del-town": if((pickorder.customer."shipping-address".town) != null) (if(sizeOf(pickorder.customer."shipping-address".town)>=60) ((pickorder.customer."shipping-address".town)[0 to 59]) else(pickorder.customer."shipping-address".town)) else "  ",
		"del-post": if(sizeOf(pickorder.customer."shipping-address".postcode)>=20) ((pickorder.customer."shipping-address".postcode)[0 to 19]) else (pickorder.customer."shipping-address".postcode),
		"del-county": if((pickorder.customer."shipping-address".county)!= null) (if(sizeOf(pickorder.customer."shipping-address".county)>=25) ((pickorder.customer."shipping-address".county)[0 to 24]) else (pickorder.customer."shipping-address".county)) else " ",
		"del-country": if((pickorder.customer."shipping-address".country) != null) (if(sizeOf(pickorder.customer."shipping-address".country)>=25) ((pickorder.customer."shipping-address".country)[0 to 24]) else(pickorder.customer."shipping-address".country)) else " ",
		"inv-name": if((pickorder.customer."last-name") != null) (if(sizeOf(pickorder.customer."last-name")>= 50) ((pickorder.customer."last-name")[0 to 49]) else (pickorder.customer."last-name")) else " ",
		"inv-contact-address1": if((pickorder.customer."billing-address"."address-1") != null) (if(sizeOf(pickorder.customer."billing-address"."address-1")>=60) ((pickorder.customer."billing-address"."address-1")[0 to 59]) else(pickorder.customer."billing-address"."address-1")) else " ",
		"inv-contact-name": if((pickorder.customer.fullname)!= null) (if(sizeOf(pickorder.customer.fullname)>= 50) ((pickorder.customer.fullname)[0 to 49]) else (pickorder.customer.fullname)) else " ",
		"inv-contact-town": if((pickorder.customer."billing-address".town) != null) (if(sizeOf(pickorder.customer."billing-address".town)>=60) ((pickorder.customer."billing-address".town)[0 to 59]) else (pickorder.customer."billing-address".town)) else" ",
		"inv-contact-post": if((pickorder.customer."billing-address".postcode) != null) (if(sizeOf(pickorder.customer."billing-address".postcode)>=20) ((pickorder.customer."billing-address".postcode)[0 to 19]) else (pickorder.customer."billing-address".postcode)) else " ",
		"inv-contact-county": if((pickorder.customer."billing-address".county) != null) (if(sizeOf(pickorder.customer."billing-address".county)>=25) ((pickorder.customer."billing-address".county)[0 to 24]) else (pickorder.customer."billing-address".county)) else " ",
		"inv-contact-country": if((pickorder.customer."billing-address".country) != null) (if(sizeOf(pickorder.customer."billing-address".country)>=24) ((pickorder.customer."billing-address".country)[0 to 24]) else (pickorder.customer."billing-address".country)) else " ",
		"order-lines": pickorder.orderlines map ( orderline , indexOfOrderline ) -> {
			"line-id" : (100 + indexOfOrderline +1) as String,
			"qty-ordered": if((orderline.quantity) !=null) (if(sizeOf(orderline.quantity)>=6) ((orderline.quantity)[0 to 5]) else (orderline.quantity)) else " ",
			"product-barcode": if((orderline.barcode) != null) (if(sizeOf(orderline.barcode)>=12) ((orderline.barcode)[0 to 11]) else (orderline.barcode)) else " ",
			"line-price" : if(orderline."tax-amount" != null and orderline."sales-price" !=null) (orderline."tax-amount" + orderline."sales-price") as String {format : ".######"} else "",
			"product-name": if((orderline."item-name") != null) (if(sizeOf(orderline."item-name")>30) ((orderline."item-name")[0 to 29]) else (orderline."item-name")) else " ",
			"internal-sales-order-number": pickorder."order-no",
			"personalize-text" : if(orderline."personalize-text" != null) (orderline."personalize-text") else "",
			"personalize-text-color" : if(orderline."personalize-text-color" != null) (orderline."personalize-text-color") else ""
		},
        "payments": pickorder.payments map{
            "card-number": if($."payment-mode-card"."card-number" != null) ($."payment-mode-card"."card-number") else " "
        }
	}
	
}