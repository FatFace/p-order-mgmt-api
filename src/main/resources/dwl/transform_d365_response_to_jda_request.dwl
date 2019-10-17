%dw 2.0
output application/json
---
{
	orders: payload.'pick-orders' map ( pickorder , indexOfPickorder ) -> {
		"order-type": pickorder."delivery-mode",
		"order-date": pickorder."order-date",
		"pick-id": pickorder."route-id",
		"ship-by-date": pickorder."delivery-date",
		"purchase-order": pickorder."order-no",
		"line-price": sum(pickorder.orderlines.amount) as String + pickorder."net-amount",
		"delivery-charges": pickorder.charges,
		"dispatch_method": pickorder."delivery-mode",
		"customer-id": pickorder.customer."customer-id",
		"del-name": pickorder.customer.fullname,
		"del-contact-email": pickorder.customer.email,
		"del-contact-phone1": pickorder.customer.telephone,
		"del-address1": pickorder.customer."shipping-address"."address-1",
		"del-town": pickorder.customer."shipping-address".town,
		"del-post": pickorder.customer."shipping-address".postcode,
		"del-county": pickorder.customer."shipping-address".county,
		"del-country": pickorder.customer."shipping-address".country,
		"inv-name": pickorder.customer.fullname,
		"inv-contact-address1": pickorder.customer."billing-address"."address-1",
		"inv-contact-town": pickorder.customer."billing-address".town,
		"inv-contact-post": pickorder.customer."billing-address".postcode,
		"inv-contact-county": pickorder.customer."billing-address".county,
		"inv-contact-country": pickorder.customer."billing-address".country,
		"order-lines": pickorder.orderlines map ( orderline , indexOfOrderline ) -> {
			"line-id" : 100 + indexOfOrderline +1,
			"qty-ordered": orderline.quantity,
			"product-barcode": orderline.barcode,
			"line-price": orderline."sales-price",
			"product-name": orderline."item-name",
			"internal-sales-order-number": pickorder."shipment-id"
		}
	}
}