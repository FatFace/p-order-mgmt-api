%dw 2.0
output application/json
fun getLookupModeOfDelivery(order) = vars.lookupModeOfDelivery filter($.'order-no' == order.'order-no') reduce $$
---
{
    'route-id' : vars.originalPayload.'route-id',
    'order-type' : vars.originalPayload.'order-type',
    'order-no' : vars.originalPayload.'order-no',
    'currency' : vars.originalPayload.'currency',
    'net-amount' : vars.originalPayload.'net-amount',
    'vat-amount' : vars.originalPayload.'vat-amount',
    'sales-status' : vars.originalPayload.'sales-status',
    'customer' :{
        'email' : vars.originalPayload.customer.'email',
        'billing-address' : {
            'first-name' : vars.originalPayload.customer.'billing-address'.'first-name',
            'last-name' : vars.originalPayload.customer.'billing-address'.'last-name',
            'street' : vars.originalPayload.customer.'billing-address'.street,
            'city' : vars.originalPayload.customer.'billing-address'.city,
			'postcode' : vars.originalPayload.customer.'billing-address'.postcode,
			'state' : vars.originalPayload.customer.'billing-address'.state,
			'country' : vars.originalPayload.customer.'billing-address'.country,
			'contact-number' : vars.originalPayload.customer.'billing-address'.'contact-number'
        },
		'shipping-address' : {
			'first-name' : vars.originalPayload.customer.'shipping-address'.'first-name',
			'last-name' : vars.originalPayload.customer.'shipping-address'.'last-name',
			'street' : vars.originalPayload.customer.'shipping-address'.street,
			'city' : vars.originalPayload.customer.'shipping-address'.city,
			'postcode' : vars.originalPayload.customer.'shipping-address'.postcode,
			'county' : vars.originalPayload.customer.'shipping-address'.county,
			'country' : vars.originalPayload.customer.'shipping-address'.country
		},
        'delivery-mode' : getLookupModeOfDelivery(vars.originalPayload).'lookup-value',
        'order-date': vars.originalPayload.'order-date',
        'orderlines' : vars.originalPayload.orderlines map (orderline) ->{
            (orderline)
        },
        'product-line-items': vars.originalPayload.'product-line-items' map (productline) ->{
            (productline)
        },
        'payment' : vars.originalPayload.payment map (payments) ->{
            (payments)
        }
    }
}