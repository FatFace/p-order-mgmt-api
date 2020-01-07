%dw 2.0
output application/json skipNullOn ='everywhere'
fun getMode(ordno) = vars.soLookupValue filter (($."order-no") == ordno) map $
fun getBarcode(barCode) = vars.sbLookupValue filter ($."barcode" == barCode) map $."lookup-value"
---
{
	'orders': vars.aptosOriginalPayload.orders map (ord, indOford)  -> {	
			'legal-entity': ord.'legal-entity' as String,
			'order-no': ord.'order-no' as String,
			'order-date': if (ord.'order-date' != null) ord.'order-date'  else '' as DateTime ,
			'source': ord.source as String,
			'currency': if (ord.currency != null) ord.currency else '',
			'delivery-mode': if(getMode(ord."order-no") != null) (getMode(ord."order-no")."lookup-key" reduce $) else '' ,
			'sales-pool': if(getMode(ord."order-no") != null) (getMode(ord."order-no").'lookup-value' reduce $) else '',
			'language': ord.language,
			'store': {
				'store-id': ord.store.'store-id',
				'store-code': ord.store.'store-code'
			},
			customer: {
				'customer-id': if (ord.customer.'customer-id' != null)ord.customer.'customer-id' else '',
				'first-name': ord.customer.'first-name',
				'last-name': ord.customer.'last-name',
				'fullname': if (ord.customer.fullname != null) ord.customer.fullname else '',
				'telephone': if (ord.customer.telephone != null) ord.customer.telephone else '',
				'email': if (ord.customer.email != null) ord.customer.email else '',
				'shipping-address': {
					'street': if (ord.customer.'shipping-address'.street != null) ord.customer.'shipping-address'.street else '',
					'city': if (ord.customer.'shipping-address'.city != null) ord.customer.'shipping-address'.city else '',
					'postcode': if (ord.customer.'shipping-address'.postcode != null) ord.customer.'shipping-address'.postcode else '',
					'county': if (ord.customer.'shipping-address'.county != null) ord.customer.'shipping-address'.county else '',
					'state': if (ord.customer.'shipping-address'.state != null) ord.customer.'shipping-address'.state else '',
					'country': if (ord.customer.'shipping-address'.country != null) ord.customer.'shipping-address'.country else ''
				},
				'billing-address': {
		          'street': ord.customer.'billing-address'.street,
		          'city': ord.customer.'billing-address'.city,
		          'postcode': ord.customer.'billing-address'.postcode,
		          'country': ord.customer.'billing-address'.country,
		          'state': ord.customer.'billing-address'.state
        		}
			},
			orderlines: ord.orderlines map (ordl, indOfOrdl) -> {
				'tax-amount': if (ordl.'tax-amount' != null) ordl.'tax-amount' else '',
				'amount': if (ordl.amount != null) ordl.amount else '',
				'item-id': if (ordl.'item-id' != null) ordl.'item-id' else '',
				'item-name': if (ordl.'item-name' != null) ordl.'item-name' else '',
				'tax-rate': if (ordl.'tax-rate' != null) ordl.'tax-rate' else '',
				'sales-price': ordl.'sales-price',
				'barcode': (if (ordl.'item-name' != null) (if (lower(ordl.'item-name') contains "delivery") (getBarcode(ordl.barcode) reduce $) else ordl.barcode) else ""),
				'quantity': ordl.quantity,
				'line-item-number': ordl.'line-item-number',
				'promotions': ordl.promotions map (prm, iprm) -> {
					'promotion-id': prm.'promotion-id' default '',
					'discount': abs(prm.discount) default ''
					}
			},
			payments: ord.payments map (pay, indOfPay) -> {
				'amount': if (pay.amount != null) pay.amount else '',
				'payment-mode': if (pay.'payment-mode' != null) pay.'payment-mode' else '',
				'payment-mode-card': {
					'card-number': pay.'payment-mode-card'.'card-number'
				}
			},
			'tender': {
				'authorisation': ord.tender.authorisation
			}

	}
}