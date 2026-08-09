# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T00:17:48+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetSshKeysResponse* = object
    meta: JsonNode
    ssh_keys: seq[JsonNode]
  PostSshKeysRequest = object
    labels: Option[JsonNode]
    name: string
    public_key: string
  PostSshKeysResponse* = object
    ssh_key: JsonNode
  GetSshKeysIdResponse* = object
    ssh_key: JsonNode
  PutSshKeysIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutSshKeysIdResponse* = object
    ssh_key: JsonNode
  SshKeySortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"


proc getSshKeys*(client: HetznerClient, sort: set[SshKeySortOption] = {},
                 name: string = default(string),
                 fingerprint: string = default(string),
                 labelSelector: string = default(string)): Future[GetSshKeysResponse] {.async.} =
  ## Returns all SSH key objects.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  q["name"] = $name
  q["fingerprint"] = $fingerprint
  q["label_selector"] = $labelSelector
  let res = await client.httpGET("/ssh_keys", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetSshKeysResponse)
  else:
    raise newException(HetznerClientError, body)

proc postSshKeys*(client: HetznerClient, body: PostSshKeysRequest): Future[PostSshKeysResponse] {.async.} =
  ## Creates a new SSH key with the given `name` and `public_key`. Once an SSH key is
  ## created, it can be used in other calls such as creating Servers.

  let res = await client.httpPOST("/ssh_keys", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostSshKeysResponse)
  else:
    raise newException(HetznerClientError, body)

proc getSshKeysId*(client: HetznerClient, id: int64): Future[GetSshKeysIdResponse] {.async.} =
  ## Returns a specific SSH key object.

  let res = await client.httpGET(fmt"/ssh_keys/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetSshKeysIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putSshKeysId*(client: HetznerClient, id: string, body: PutSshKeysIdRequest): Future[PutSshKeysIdResponse] {.async.} =
  ## Updates an SSH key. You can update an SSH key name and an SSH key labels.
  ##
  ## Please note that when updating labels, the SSH key current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.

  let res = await client.httpPUT(fmt"/ssh_keys/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutSshKeysIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteSshKeysId*(client: HetznerClient, id: string): Future[AsyncResponse] {.async.} =
  ## Deletes an SSH key. It cannot be used anymore.

  let res = await client.httpDELETE(fmt"/ssh_keys/{id}")
  return res
