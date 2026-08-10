# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetImagesResponse* = object
    images: seq[JsonNode]
    meta: JsonNode
  GetImagesIdResponse* = object
    image: JsonNode
  PutImagesIdRequest = object
    description: Option[string]
    labels: Option[JsonNode]
    `type`: Option[string]
  PutImagesIdResponse* = object
    image: JsonNode
  ImageSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"

  ImageTypeOption* = enum
    typeSystem = "system"
    typeSnapshot = "snapshot"
    typeBackup = "backup"
    typeApp = "app"

  ImageStatusOption* = enum
    statusAvailable = "available"
    statusCreating = "creating"


proc getImages*(client: HetznerClient, sort: set[ImageSortOption] = {},
                `type`: set[ImageTypeOption] = {},
                status: set[ImageStatusOption] = {},
                boundTo: string = default(string),
                includeDeprecated: bool = default(bool),
                name: string = default(string),
                labelSelector: string = default(string)): Future[GetImagesResponse] {.async.} =
  ## Returns all Image objects. You can select specific Image types only and sort the
  ## results by using URI parameters.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in `type`: q["type"] = $v
  for v in status: q["status"] = $v
  q["bound_to"] = $boundTo
  q["include_deprecated"] = $includeDeprecated
  q["name"] = $name
  q["label_selector"] = $labelSelector
  let res = await client.httpGET("/images", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetImagesResponse)
  else:
    raise newException(HetznerClientError, body)

proc getImagesId*(client: HetznerClient, id: int64): Future[GetImagesIdResponse] {.async.} =
  ## Returns a specific Image object.

  let res = await client.httpGET(fmt"/images/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetImagesIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putImagesId*(client: HetznerClient, id: int64, body: PutImagesIdRequest): Future[PutImagesIdResponse] {.async.} =
  ## Updates the Image. You may change the description, convert a Backup Image to a
  ## Snapshot Image or change the Image labels. Only Images of type `snapshot` and
  ## `backup` can be updated.
  ##
  ## Note that when updating labels, the current set of labels will be replaced with
  ## the labels provided in the request body. So, for example, if you want to add a
  ## new label, you have to provide all existing labels plus the new label in the
  ## request body.

  let res = await client.httpPUT(fmt"/images/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutImagesIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteImagesId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes an Image. Only Images of type `snapshot` and `backup` can be deleted.

  let res = await client.httpDELETE(fmt"/images/{id}")
  return res
