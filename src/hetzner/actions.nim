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
  GetActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  GetActionsIdResponse* = object
    action: JsonNode
  ActionSortOption* = enum
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

  ActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getActions*(client: HetznerClient, id: int64 = default(int64),
                 sort: set[ActionSortOption] = {},
                 status: set[ActionStatusOption] = {}): Future[GetActionsResponse] {.async.} =
  ## Returns all Action objects. You can `sort` the results by using the sort URI
  ## parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  q["id"] = $id
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET("/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc getActionsId*(client: HetznerClient, id: int64): Future[GetActionsIdResponse] {.async.} =
  ## Returns a specific Action object.

  let res = await client.httpGET(fmt"/actions/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetActionsIdResponse)
  else:
    raise newException(HetznerClientError, body)
