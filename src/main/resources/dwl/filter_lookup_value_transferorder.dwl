%dw 2.0
output application/json
---
(flatten(vars.lookupResponse.lookups groupBy ($.lookup_id) pluck($)) map {
    ($."lookup-key"): ($."lookup-value")
} reduce ((item, accumulator) -> item ++ accumulator)) distinctBy ($$)