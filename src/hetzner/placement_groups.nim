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
  GetPlacementGroupsResponse* = object
    meta: JsonNode
    placement_groups: seq[JsonNode]
  PostPlacementGroupsRequest = object
    labels: Option[JsonNode]
    name: string
    `type`: string
  PostPlacementGroupsResponse* = object
    action: JsonNode
    placement_group: JsonNode
  GetPlacementGroupsIdResponse* = object
    placement_group: JsonNode
  PutPlacementGroupsIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutPlacementGroupsIdResponse* = object
    placement_group: JsonNode
  PlacementGroupSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"

  PlacementGroupTypeOption* = enum
    typeSpread = "spread"


proc getPlacementGroups*(client: HetznerClient,
                         sort: set[PlacementGroupSortOption] = {},
                         name: string = default(string),
                         labelSelector: string = default(string),
                         `type`: set[PlacementGroupTypeOption] = {}): Future[GetPlacementGroupsResponse] {.async.} =
  ## Returns all PlacementGroup objects.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  q["name"] = $name
  q["label_selector"] = $labelSelector
  for v in `type`: q["type"] = $v
  let res = await client.httpGET("/placement_groups", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetPlacementGroupsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postPlacementGroups*(client: HetznerClient,
                          body: PostPlacementGroupsRequest): Future[PostPlacementGroupsResponse] {.async.} =
  ## Creates a new PlacementGroup.

  let res = await client.httpPOST("/placement_groups", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostPlacementGroupsResponse)
  else:
    raise newException(HetznerClientError, body)

proc getPlacementGroupsId*(client: HetznerClient, id: int64): Future[GetPlacementGroupsIdResponse] {.async.} =
  ## Gets a specific PlacementGroup object.

  let res = await client.httpGET(fmt"/placement_groups/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetPlacementGroupsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putPlacementGroupsId*(client: HetznerClient, id: int64,
                           body: PutPlacementGroupsIdRequest): Future[PutPlacementGroupsIdResponse] {.async.} =
  ## Updates the PlacementGroup properties.
  ##
  ## Note that when updating labels, the PlacementGroup’s current set of labels will
  ## be replaced with the labels provided in the request body. So, for example, if
  ## you want to add a new label, you have to provide all existing labels plus the
  ## new label in the request body.
  ##
  ## Note: if the PlacementGroup object changes during the request, the response will
  ## be a “conflict” error.

  let res = await client.httpPUT(fmt"/placement_groups/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutPlacementGroupsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deletePlacementGroupsId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a PlacementGroup.

  let res = await client.httpDELETE(fmt"/placement_groups/{id}")
  return res
