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
  GetFirewallsIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostFirewallsIdActionsApplyToResourcesRequest = object
    apply_to: seq[JsonNode]
  PostFirewallsIdActionsApplyToResourcesResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostFirewallsIdActionsRemoveFromResourcesRequest = object
    remove_from: seq[JsonNode]
  PostFirewallsIdActionsRemoveFromResourcesResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostFirewallsIdActionsSetRulesRequest = object
    rules: seq[JsonNode]
  PostFirewallsIdActionsSetRulesResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  GetFirewallsIdActionsActionIdResponse* = object
    action: JsonNode
  FirewallActionSortOption* = enum
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

  FirewallActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getFirewallsIdActions*(client: HetznerClient, id: int64,
                            sort: set[FirewallActionSortOption] = {},
                            status: set[FirewallActionStatusOption] = {}): Future[GetFirewallsIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Firewall. You can sort the results by using the
  ## `sort` URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/firewalls/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFirewallsIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFirewallsIdActionsApplyToResources*(client: HetznerClient, id: int64,
                                             body: PostFirewallsIdActionsApplyToResourcesRequest): Future[PostFirewallsIdActionsApplyToResourcesResponse] {.async.} =
  ## Applies one Firewall to multiple resources.
  ##
  ## Currently servers (public network interface) and label selectors are supported.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |-------------------------------|-----------------------------------------------
  ## ----------------|
  ## | `firewall_already_applied`    | Firewall was already applied on resource
  ## |
  ## | `incompatible_network_type`   | The Network type is incompatible for the given
  ## resource       |
  ## | `firewall_resource_not_found` | The resource the Firewall should be attached
  ## to was not found |

  let res = await client.httpPOST(fmt"/firewalls/{id}/actions/apply_to_resources", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFirewallsIdActionsApplyToResourcesResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFirewallsIdActionsRemoveFromResources*(client: HetznerClient, id: int64,
                                                body: PostFirewallsIdActionsRemoveFromResourcesRequest): Future[PostFirewallsIdActionsRemoveFromResourcesResponse] {.async.} =
  ## Removes one Firewall from multiple resources.
  ##
  ## Currently only Servers (and their public network interfaces) are supported.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                                  | Description
  ## |
  ## |---------------------------------------|---------------------------------------
  ## ---------------------------------|
  ## | `firewall_already_removed`            | Firewall was already removed from the
  ## resource                         |
  ## | `firewall_resource_not_found`         | The resource the Firewall should be
  ## attached to was not found          |
  ## | `firewall_managed_by_label_selector`  | Firewall was applied via label
  ## selector and cannot be removed manually |

  let res = await client.httpPOST(fmt"/firewalls/{id}/actions/remove_from_resources", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFirewallsIdActionsRemoveFromResourcesResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFirewallsIdActionsSetRules*(client: HetznerClient, id: int64,
                                     body: PostFirewallsIdActionsSetRulesRequest): Future[PostFirewallsIdActionsSetRulesResponse] {.async.} =
  ## Sets the rules of a Firewall.
  ##
  ## All existing rules will be overwritten. Pass an empty `rules` array to remove
  ## all rules.
  ## The maximum amount of rules that can be defined is 50.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |-------------------------------|-----------------------------------------------
  ## ----------------|
  ## | `firewall_resource_not_found` | The resource the Firewall should be attached
  ## to was not found |

  let res = await client.httpPOST(fmt"/firewalls/{id}/actions/set_rules", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFirewallsIdActionsSetRulesResponse)
  else:
    raise newException(HetznerClientError, body)

proc getFirewallsIdActionsActionId*(client: HetznerClient, id: int64,
                                    actionId: int64): Future[GetFirewallsIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action for a Firewall.

  let res = await client.httpGET(fmt"/firewalls/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFirewallsIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
