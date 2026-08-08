# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:31:24+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetCertificatesIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostCertificatesIdActionsRetryResponse* = object
    action: JsonNode
  GetCertificatesIdActionsActionIdResponse* = object
    action: JsonNode
  CertificateActionSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortCommand = "command"
    sortCommandAsc = "command:asc"
    sortCommandDesc = "command:desc"
    sortStatus = "status"
    sortStatusAsc = "status:asc"
    sortStatusDesc = "status:desc"
    sortProgress = "progress"
    sortProgressAsc = "progress:asc"
    sortProgressDesc = "progress:desc"
    sortStarted = "started"
    sortStartedAsc = "started:asc"
    sortStartedDesc = "started:desc"
    sortFinished = "finished"
    sortFinishedAsc = "finished:asc"
    sortFinishedDesc = "finished:desc"

  CertificateActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getCertificatesIdActions*(client: HetznerClient, id: int64,
                               sort: set[CertificateActionSortOption] = {},
                               status: set[CertificateActionStatusOption] = {}): Future[GetCertificatesIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Certificate. You can sort the results by using
  ## the `sort` URI parameter, and filter them with the `status` parameter.
  ##
  ## Only type `managed` Certificates can have Actions. For type `uploaded`
  ## Certificates the `actions` key will always contain an empty array.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/certificates/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetCertificatesIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postCertificatesIdActionsRetry*(client: HetznerClient, id: int64): Future[PostCertificatesIdActionsRetryResponse] {.async.} =
  ## Retry a failed Certificate issuance or renewal.
  ##
  ## Only applicable if the type of the Certificate is `managed` and the issuance or
  ## renewal status is `failed`.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                                                    | Description
  ## |
  ## |---------------------------------------------------------|---------------------
  ## ------------------------------------------------------|
  ## | `caa_record_does_not_allow_ca`                          | CAA record does not
  ## allow certificate authority                           |
  ## | `ca_dns_validation_failed`                              | Certificate
  ## Authority: DNS validation failed                              |
  ## | `ca_too_many_authorizations_failed_recently`            | Certificate
  ## Authority: Too many authorizations failed recently            |
  ## | `ca_too_many_certificates_issued_for_registered_domain` | Certificate
  ## Authority: Too many certificates issued for registered domain |
  ## | `ca_too_many_duplicate_certificates`                    | Certificate
  ## Authority: Too many duplicate certificates                    |
  ## | `could_not_verify_domain_delegated_to_zone`             | Could not verify
  ## domain delegated to zone                                 |
  ## | `dns_zone_not_found`                                    | DNS zone not found
  ## |
  ## | `dns_zone_is_secondary_zone`                            | DNS zone is a
  ## secondary zone                                              |

  let res = await client.httpPOST(fmt"/certificates/{id}/actions/retry")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostCertificatesIdActionsRetryResponse)
  else:
    raise newException(HetznerClientError, body)

proc getCertificatesIdActionsActionId*(client: HetznerClient, id: int64,
                                       actionId: int64): Future[GetCertificatesIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action for a Certificate. Only type `managed` Certificates
  ## have Actions.

  let res = await client.httpGET(fmt"/certificates/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetCertificatesIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
