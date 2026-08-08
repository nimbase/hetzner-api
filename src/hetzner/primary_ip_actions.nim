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
  PostPrimaryIpsIdActionsAssignRequest = object
    assignee_id: int64
    assignee_type: string
  PostPrimaryIpsIdActionsAssignResponse* = object
    action: JsonNode
  PostPrimaryIpsIdActionsChangeDnsPtrRequest = object
    dns_ptr: Option[string]
    ip: string
  PostPrimaryIpsIdActionsChangeDnsPtrResponse* = object
    action: JsonNode
  PostPrimaryIpsIdActionsChangeProtectionRequest = object
    delete: Option[bool]
  PostPrimaryIpsIdActionsChangeProtectionResponse* = object
    action: JsonNode
  PostPrimaryIpsIdActionsUnassignResponse* = object
    action: JsonNode

proc postPrimaryIpsIdActionsAssign*(client: HetznerClient, id: int64,
                                    body: PostPrimaryIpsIdActionsAssignRequest): Future[PostPrimaryIpsIdActionsAssignResponse] {.async.} =
  ## Assigns a Primary IP to a Server.
  ##
  ## A Server can only have one Primary IP of type `ipv4` and one of type `ipv6`
  ## assigned. If you need more IPs use Floating IPs.
  ##
  ## The Server must be powered off (status `off`) in order for this operation to
  ## succeed.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |------------------------------
  ## |-------------------------------------------------------------- |
  ## | `server_not_stopped`          | The server is running, but needs to be powered
  ## off            |
  ## | `primary_ip_already_assigned` | Primary ip is already assigned to a different
  ## server          |
  ## | `server_has_ipv4`             | The server already has an ipv4 address
  ## |
  ## | `server_has_ipv6`             | The server already has an ipv6 address
  ## |

  let res = await client.httpPOST(fmt"/primary_ips/{id}/actions/assign", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostPrimaryIpsIdActionsAssignResponse)
  else:
    raise newException(HetznerClientError, body)

proc postPrimaryIpsIdActionsChangeDnsPtr*(client: HetznerClient, id: int64,
                                          body: PostPrimaryIpsIdActionsChangeDnsPtrRequest): Future[PostPrimaryIpsIdActionsChangeDnsPtrResponse] {.async.} =
  ## Changes the hostname that will appear when getting the hostname belonging to
  ## this Primary IP.

  let res = await client.httpPOST(fmt"/primary_ips/{id}/actions/change_dns_ptr", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostPrimaryIpsIdActionsChangeDnsPtrResponse)
  else:
    raise newException(HetznerClientError, body)

proc postPrimaryIpsIdActionsChangeProtection*(client: HetznerClient, id: int64,
                                              body: PostPrimaryIpsIdActionsChangeProtectionRequest): Future[PostPrimaryIpsIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of a Primary IP.
  ##
  ## A Primary IP can only be delete protected if its `auto_delete` property is set
  ## to `false`.

  let res = await client.httpPOST(fmt"/primary_ips/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostPrimaryIpsIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc postPrimaryIpsIdActionsUnassign*(client: HetznerClient, id: int64): Future[PostPrimaryIpsIdActionsUnassignResponse] {.async.} =
  ## Unassigns a Primary IP from a Server.
  ##
  ## The Server must be powered off (status `off`) in order for this operation to
  ## succeed.
  ##
  ## Note that only Servers that have at least one network interface (public or
  ## private) attached can be powered on.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                              | Description
  ## |
  ## |----------------------------------
  ## |-------------------------------------------------------------- |
  ## | `server_not_stopped`              | The server is running, but needs to be
  ## powered off            |
  ## | `server_is_load_balancer_target`  | The server ipv4 address is a loadbalancer
  ## target              |

  let res = await client.httpPOST(fmt"/primary_ips/{id}/actions/unassign")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostPrimaryIpsIdActionsUnassignResponse)
  else:
    raise newException(HetznerClientError, body)
