# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T04:08:19+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetCertificatesResponse* = object
    certificates: seq[JsonNode]
    meta: JsonNode
  PostCertificatesRequest = object
    certificate: Option[string]
    domain_names: Option[seq[string]]
    labels: Option[JsonNode]
    name: string
    private_key: Option[string]
    `type`: Option[string]
  PostCertificatesResponse* = object
    action: JsonNode
    certificate: JsonNode
  GetCertificatesIdResponse* = object
    certificate: JsonNode
  PutCertificatesIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutCertificatesIdResponse* = object
    certificate: JsonNode
  CertificateSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"

  CertificateTypeOption* = enum
    typeUploaded = "uploaded"
    typeManaged = "managed"


proc getCertificates*(client: HetznerClient,
                      sort: set[CertificateSortOption] = {},
                      name: string = default(string),
                      labelSelector: string = default(string),
                      `type`: set[CertificateTypeOption] = {}): Future[GetCertificatesResponse] {.async.} =
  ## Returns all Certificate objects.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  q["name"] = $name
  q["label_selector"] = $labelSelector
  for v in `type`: q["type"] = $v
  let res = await client.httpGET("/certificates", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetCertificatesResponse)
  else:
    raise newException(HetznerClientError, body)

proc postCertificates*(client: HetznerClient, body: PostCertificatesRequest): Future[PostCertificatesResponse] {.async.} =
  ## Creates a new Certificate.
  ##
  ## The default type **uploaded** allows for uploading your existing `certificate`
  ## and `private_key` in PEM format. You have to monitor its expiration date and
  ## handle renewal yourself.
  ##
  ## In contrast, type **managed** requests a new Certificate from *Let's Encrypt*
  ## for the specified `domain_names`. Only domains managed by *Hetzner DNS* are
  ## supported. We handle renewal and timely alert the project owner via email if
  ## problems occur.
  ##
  ## For type `managed` Certificates the `action` key of the response contains the
  ## Action that allows for tracking the issuance process. For type `uploaded`
  ## Certificates the `action` is always null.

  let res = await client.httpPOST("/certificates", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostCertificatesResponse)
  else:
    raise newException(HetznerClientError, body)

proc getCertificatesId*(client: HetznerClient, id: int64): Future[GetCertificatesIdResponse] {.async.} =
  ## Gets a specific Certificate object.

  let res = await client.httpGET(fmt"/certificates/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetCertificatesIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putCertificatesId*(client: HetznerClient, id: int64,
                        body: PutCertificatesIdRequest): Future[PutCertificatesIdResponse] {.async.} =
  ## Updates the Certificate properties.
  ##
  ## Note that when updating labels, the Certificate’s current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.
  ##
  ## Note: if the Certificate object changes during the request, the response will be
  ## a “conflict” error.

  let res = await client.httpPUT(fmt"/certificates/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutCertificatesIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteCertificatesId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a Certificate.

  let res = await client.httpDELETE(fmt"/certificates/{id}")
  return res
