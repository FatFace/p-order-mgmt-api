%dw 2.0
output application/json skipNullOn ='everywhere'
---
{
	'orders': vars.aptosOriginalPayload.orders map (rep, indOfRep)  -> {
		(vars.soLookupValue filter (($."order-no") == rep."order-no") map {
		'order-no': rep.'order-no',
		'order-date': if (rep.'order-date' != null) rep.'order-date' else "" as DateTime,
		'currency': rep.currency,
		'legal-entity': rep.'legal-entity' as String,
		'language': rep.language,
		'source': rep.source,
		'delivery-mode': $."lookup-key",
		'store': {
			'store-id': rep.store.'store-id',
			'store-code': $."lookup-value"
		},
		customer: {
			'customer-id': rep.customer.'customer-id',
			'fullname': rep.customer.fullname,
			'first-name': rep.customer.'first-name',
			'last-name': rep.customer.'last-name',
			'telephone': rep.customer.telephone,
			'email': rep.customer.email,
			'shipping-address': {
				'address-1': rep.customer.'shipping-address'.street,
				'city': rep.customer.'shipping-address'.city,
				'postcode': rep.customer.'shipping-address'.postcode,
				'county': rep.customer.'shipping-address'.county,
				'state': rep.customer.'shipping-address'.state,
				'country': rep.customer.'shipping-address'.country
			}
		},
		orderlines: rep.orderlines map (ordl, indOfOrdl) -> {
			'item-id': ordl.'item-id',
			'item-name': ordl.'item-name',
			'sales-price': ordl.'sales-price',
			'barcode': Mule::lookup("common-template-check-digit-lookup-flow", ordl.barcode),
			'quantity': ordl.quantity,
			'amount': ordl.amount,
			'tax-amount': ordl.'tax-amount',
			'tax-rate': ordl.'tax-rate',
			'line-item-number': ordl.'line-item-number',
			'promotions': ordl.promotions map (prm, iprm) -> {
					'promotion-id': prm.'promotion-id',
					'discount': prm.discount
					}
		},
		payments: rep.payments map (pay, indOfPay) -> {
			'amount': pay.amount,
			'payment-mode': pay.'payment-mode',
			'payment-mode-card': {
				'card-number': pay.'payment-mode-card'.'card-number'
			}
		},
		'tender': {
        'authorisation': rep.tender.authorisation
      	}
		})
	}
}