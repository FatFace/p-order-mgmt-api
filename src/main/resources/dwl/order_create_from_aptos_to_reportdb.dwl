%dw 2.0
output application/json
---
{
	"orders": vars.aptosOriginalPayload.orders map (rep, indOfRep)  -> {
		'order-no': rep.'order-no',
		'order-date': rep."order-date" as DateTime,
		'currency': rep.currency,
		'legal-entity': rep.'legal-entity',
		'language': rep.language,
		'source': rep.source,
		'delivery-mode': rep.'delivery-mode',
		'store': {
			'store-id': rep.store."store-id"
		},
		customer: {
			'customer-id': rep.customer."customer-id",
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
			'barcode': ordl.barcode,
			'quantity': ordl.quantity,
			'amount': ordl.amount,
			'tax-amount': ordl.'tax-amount',
			'tax-rate': ordl.'tax-rate'
		},
		payments: rep.payments map (pay, indOfPay) -> {
			'amount': pay.amount,
			'payment-mode': pay.'payment-mode',
			'payment-mode-card': {
				'card-number': pay.'payment-mode-card'.'card-number'
			}
		}
	}
}