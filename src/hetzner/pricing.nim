# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[json]
import ./private/metaclient

type
  GetPricingResponse* = object
    pricing: JsonNode

proc getPricing*(client: HetznerClient): Future[GetPricingResponse] {.async.} =
  ## Returns prices for all resources available on the platform. VAT and currency of
  ## the Project owner are used for calculations.
  ##
  ## Both net and gross prices are included in the response.

  let res = await client.httpGET("/pricing")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetPricingResponse)
  else:
    raise newException(HetznerClientError, body)
