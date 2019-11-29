%dw 2.0
output application/json
---
{
	"orders": vars.aptosOriginalPayload.orders map (ord, indOford)  -> {
		(vars.soLookupValue filter (($."order-no") == ord."order-no") map {
		'legal-entity': ord.'legal-entity' as String,
		'order-no': ord.'order-no' as String,
		'order-date': if (ord.'order-date' != null) 'order-date' else "" as DateTime,
		'source': ord.source as String,
		'currency': if (ord.currency != null) ord.currency else "",
		'delivery-mode': $."lookup-key",
		'language': ord.language,
		'store': {
			'store-id': ord.store."store-id",
			'store-code': $."lookup-value"
		},
		customer: {
			'customer-id': if (ord.customer."customer-id" != null)ord.customer."customer-id" else "",
			'first-name': ord.customer.'first-name',
			'last-name': ord.customer.'last-name',
			'fullname': if (ord.customer.fullname != null) ord.customer.fullname else "",
			'telephone': if (ord.customer.telephone != null) ord.customer.telephone else "",
			'email': if (ord.customer.email != null) ord.customer.email else "",
			'shipping-address': {
				'street': if (ord.customer.'shipping-address'.street != null) ord.customer.'shipping-address'.street else "",
				'city': if (ord.customer.'shipping-address'.city != null) ord.customer.'shipping-address'.city else "",
				'postcode': if (ord.customer.'shipping-address'.postcode != null) ord.customer.'shipping-address'.postcode else "",
				'county': if (ord.customer.'shipping-address'.county != null) ord.customer.'shipping-address'.county else "",
				'state': if (ord.customer.'shipping-address'.state != null) ord.customer.'shipping-address'.state else "",
				'country': if (ord.customer.'shipping-address'.country != null) ord.customer.'shipping-address'.country else ""
			}
		},
		orderlines: ord.orderlines map (ordl, indOfOrdl) -> {
			'tax-amount': if (ordl.'tax-amount' != null) ordl.'tax-amount' else "",
			'amount': if (ordl.amount != null) ordl.amount else "",
			'item-id': if (ordl.'item-id' != null) ordl.'item-id' else "",
			'item-name': if (ordl.'item-name' != null) ordl.'item-name' else "",
			'tax-rate': if (ordl.'tax-rate' != null) ordl.'tax-rate' else "",
			'sales-price': ordl.'sales-price',
			'barcode': if(ordl.barcode != null) ordl.barcode else "",
			'quantity': ordl.quantity,
			promotions: {
				'promotion-id': if (ordl.'promotion-id' != null) ordl.'promotion-id' else "",
				discount: if (ordl.discount != null) ordl.discount else ""
			}
		},
		payments: ord.payments map (pay, indOfPay) -> {
			'amount': if (pay.amount != null) pay.amount else "",
			'payment-mode': if (pay.'payment-mode' != null) pay.'payment-mode' else "",
			'payment-mode-card': {
				'card-number': pay.'payment-mode-card'.'card-number'
			}
		}
		
		
		})
		
	}
}