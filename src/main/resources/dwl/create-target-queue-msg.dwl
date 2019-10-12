%dw 2.0
output application/java
---
{
	delaySeconds: 0,
	body: write(payload, payload.^['mimeType']),
	messageAttributes: {
		"correlationId": {
			"stringValue" : attributes.correlationId.stringValue,
			"dataType" : "String.correlationId"
		} as Object {
			class: "org.mule.extension.sqs.api.model.MessageAttributeValue"
		},
		"targetQueue": {
			"stringValue" : attributes.targetQueue.stringValue,
			"dataType" : "String.targetQueue"
		} as Object {
			class : "org.mule.extension.sqs.api.model.MessageAttributeValue"
		},
		"targetQueueUrl": {
			"stringValue" : attributes.targetQueueUrl.stringValue,
			"dataType" : "String.targetQueueUrl"
		} as Object {
			class : "org.mule.extension.sqs.api.model.MessageAttributeValue"
		},
		"transactionId": {
			"stringValue" : attributes.transactionId.stringValue,
			"dataType" : "String.transactionId"
		} as Object {
			class : "org.mule.extension.sqs.api.model.MessageAttributeValue"
		},
		"transactionStartTime": {
			"stringValue" : attributes.transactionStartTime.stringValue,
			"dataType" : "String.transactionStartTime"
		} as Object {
			class : "org.mule.extension.sqs.api.model.MessageAttributeValue"
		}
	} as Object {
		class: "java.util.HashMap"
	}	
} as Object {
	class: "org.mule.extension.sqs.api.model.Message"
}