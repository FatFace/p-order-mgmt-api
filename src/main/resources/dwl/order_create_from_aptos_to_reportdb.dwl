%dw 2.0
output application/json skipNullOn ='everywhere'
fun getMode(ordno) = vars.soLookupValue filter (($."order-no") == ordno) map $
fun getBarcode(barCode) = vars.sbLookupValue filter ($."barcode" == barCode) map $."lookup-value"
---
{
	'orders': vars.aptosOriginalPayload.orders map (rep, indOfRep)  -> {
		'order-no': rep.'order-no',
		'order-date': if (rep.'order-date' != null) rep.'order-date' else "" as DateTime,
		'currency': rep.currency,
		'legal-entity': rep.'legal-entity' as String,
		'language': rep.language,
		'source': rep.source,
		'delivery-mode': if(getMode(rep."order-no") != null) (getMode(rep."order-no")."lookup-key" reduce $) else '',
		'sales-pool': if(getMode(rep."order-no") != null) (getMode(rep."order-no").'lookup-value' reduce $) else '',
		'store': {
			'store-id': rep.store.'store-id',
			'store-code': rep.store.'store-code'
		},
		customer: {
			'customer-id': rep.customer.'customer-id',
			'fullname': rep.customer.fullname,
			'first-name': rep.customer.'first-name',
			'last-name': rep.customer.'last-name',
			'telephone': rep.customer.telephone,
			'email': rep.customer.email,
			'shipping-address': {
				'street': rep.customer.'shipping-address'.street,
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
			'barcode': (if (ordl.'item-name' != null) (if (lower(ordl.'item-name') contains "delivery") (getBarcode(ordl.barcode) reduce $) else Mule::lookup("common-template-check-digit-lookup-flow", ordl.barcode)) else ""),
			'quantity': ordl.quantity,
			'amount': ordl.amount,
			'tax-amount': ordl.'tax-amount',
			'tax-rate': ordl.'tax-rate',
			'line-item-number': ordl.'line-item-number',
			'promotions': ordl.promotions map (prm, iprm) -> {
					'promotion-id': prm.'promotion-id',
					'discount': abs(prm.discount)
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
	}
}