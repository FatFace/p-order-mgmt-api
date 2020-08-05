%dw 2.0
output application/json
fun getLookupModeOfDelivery(order) = vars.lookupModeOfDelivery filter($.'order-no' == order.'order-no') reduce $$
---
{
		"data-area-id": vars.originalPayload.'data-area-id',
		 "route-id" : vars.originalPayload.'route-id',
		"order-type": vars.originalPayload.'order-type',
		"order-no" : vars.originalPayload.'order-no',
		"order-date" : if(vars.originalPayload.'order-date' != null and vars.originalPayload.'order-date' != "") vars.originalPayload.'order-date' else null,
		"modified-date": if(vars.originalPayload.'modified-date' != null and vars.originalPayload.'modified-date' != "") vars.originalPayload.'modified-date' else null,
		"customer" : {
			"email" : vars.originalPayload.customer.email,
			"billing-address" : {
				"name": vars.originalPayload.customer.'billing-address'.name,
				"postcode": vars.originalPayload.customer.'billing-address'.postcode,
				"street": vars.originalPayload.customer.'billing-address'.street,
				"city": vars.originalPayload.customer.'billing-address'.city,
				"contact-number" : vars.originalPayload.customer.'billing-address'.'contact-number',
				"description": vars.originalPayload.customer.'billing-address'.description,
				"state" : vars.originalPayload.customer.'billing-address'.state,
				"country": vars.originalPayload.customer.'billing-address'.country,
				"county": vars.originalPayload.customer.'billing-address'.county,
			},
			"shipping-address" : {
				"name": vars.originalPayload.customer.'shipping-address'.name,
				"postcode": vars.originalPayload.customer.'shipping-address'.postcode,
				"street": vars.originalPayload.customer.'shipping-address'.street,
				"country": vars.originalPayload.customer.'shipping-address'.country,
				"description": vars.originalPayload.customer.'shipping-address'.description,
				"city": vars.originalPayload.customer.'shipping-address'.city,
				"county": vars.originalPayload.customer.'shipping-address'.county,
				"state": vars.originalPayload.customer.'shipping-address'.state
			}
		},
		"sales-origin": vars.originalPayload.'sales-origin',
		"discount": vars.originalPayload.discount,
		"vat-group": vars.originalPayload.'vat-group',
		"invoice-amount": vars.originalPayload.'invoice-amount',
		"currency": vars.originalPayload.currency,
		"sales-table-rec-id": vars.originalPayload.'sales-table-rec-id',
		"vat-amount": vars.originalPayload.'vat-amount',
		'delivery-mode' : vars.originalPayload.'delivery-mode',
		"customer-id": vars.originalPayload.'customer-id',
		"rma-no": vars.originalPayload.'rma-no',
		"net-amount" : if(vars.originalPayload.'net-amount' != null and vars.originalPayload.'net-amount' != "") vars.originalPayload.'net-amount' as Number else 0,
		"sales-pool": vars.originalPayload.'sales-pool',
		"third-party-order-id": vars.originalPayload.'third-party-order-id',
		"orginal-sales-order-id": vars.originalPayload.'orginal-sales-order-id',
		"store-origin-id": vars.originalPayload.'store-origin-id',
		"calculated-vat-amount": vars.originalPayload.'calculated-vat-amount' ,
		"xcmc-customer-id": vars.originalPayload.'xcmc-customer-id',
		"cust-acct": vars.originalPayload.'cust-acct',
		"sales-table-id": vars.originalPayload.'sales-table-id',
		"sales-status": vars.originalPayload.'sales-status',
		"return-status": vars.originalPayload.'return-status',
        'orderlines' : vars.originalPayload.orderlines map (orderline) ->{
           "data-area-id": orderline.'data-area-id',
			"sales-order": orderline.'sales-order',
			"line-id": orderline.'line-id',
			"package-slip-id": orderline.'package-slip-id',
			"version": orderline.version,
			"discount":  orderline.discount,
			'delivery-mode' : getLookupModeOfDelivery(vars.originalPayload).'lookup-value',
			"fullfillment-status": orderline.'fullfillment-status',
			"sales-container-id": orderline.'sales-container-id',
			"remaining": orderline.remaining,
			"quantity" :  orderline.quantity ,
			"delivered-quantity": orderline.'delivered-quantity',
			"cancelled-quantity":  orderline.'cancelled-quantity' ,
			"vat-group": orderline.'vat-group',
			"item-id": orderline.'item-id',
			"base-price": orderline.'base-price',
			"delivery-remainder": orderline.'delivery-remainder',
			"invent-trans-id": orderline.'invent-trans-id',
			"invoice-remainder":  orderline.'invoice-remainder' ,
			"created-date":   orderline.'created-date' ,
			"disposition-code": orderline.'disposition-code',
			"modified-date":  orderline.'modified-date' ,
			"on-order":  orderline.'on-order' ,
			"carrier": orderline.carrier,
			"carrier-tracking-id": orderline.'carrier-tracking-id',
			"personalize-text" : orderline.'personalize-text',
			"personalize-text-color" : orderline.'personalize-text-color',
			"promotions" : [{
				"promotion-id" : orderline.promotions[0].'promotion-id'
			}],
			"warehouse": {
				"warehouse-id": orderline.warehouse.'warehouse-id'
			},
			"product" : {
				"skus" : orderline.product.skus map (skuline) -> {
					"barcode" : if(skuline.barcode != null and skuline.barcode != "") skuline.barcode else "",
					"product-id" : skuline.'product-id',
					"name" : skuline.name,
					"colour" : skuline.colour,
					"size"  : skuline.size,
					"fit" : skuline.fit
				}
			}
        },
        'product-line-items': vars.originalPayload.'product-line-items' map (productline) ->{
            (productline)
        },
        'payment' : vars.originalPayload.payment map (payments) ->{
            (payments)
        }
}