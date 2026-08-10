# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-10T04:22:05+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetLoadBalancersIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostLoadBalancersIdActionsAddServiceRequest = object
    destination_port: int64
    health_check: JsonNode
    http: Option[JsonNode]
    listen_port: int64
    protocol: string
    proxyprotocol: bool
  PostLoadBalancersIdActionsAddServiceResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsAddTargetRequest = object
    ip: Option[JsonNode]
    label_selector: Option[JsonNode]
    server: Option[JsonNode]
    `type`: string
    use_private_ip: Option[bool]
  PostLoadBalancersIdActionsAddTargetResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsAttachToNetworkRequest = object
    ip: Option[string]
    network: float64
  PostLoadBalancersIdActionsAttachToNetworkResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsChangeAlgorithmRequest = object
    `type`: string
  PostLoadBalancersIdActionsChangeAlgorithmResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsChangeDnsPtrRequest = object
    dns_ptr: Option[string]
    ip: string
  PostLoadBalancersIdActionsChangeDnsPtrResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsChangeProtectionRequest = object
    delete: Option[bool]
  PostLoadBalancersIdActionsChangeProtectionResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsChangeTypeRequest = object
    load_balancer_type: string
  PostLoadBalancersIdActionsChangeTypeResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsDeleteServiceRequest = object
    listen_port: float64
  PostLoadBalancersIdActionsDeleteServiceResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsDetachFromNetworkRequest = object
    network: float64
  PostLoadBalancersIdActionsDetachFromNetworkResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsDisablePublicInterfaceResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsEnablePublicInterfaceResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsRemoveTargetRequest = object
    ip: Option[JsonNode]
    label_selector: Option[JsonNode]
    server: Option[JsonNode]
    `type`: string
  PostLoadBalancersIdActionsRemoveTargetResponse* = object
    action: JsonNode
  PostLoadBalancersIdActionsUpdateServiceRequest = object
    destination_port: int64
    health_check: JsonNode
    http: Option[JsonNode]
    listen_port: int64
    protocol: string
    proxyprotocol: bool
  PostLoadBalancersIdActionsUpdateServiceResponse* = object
    action: JsonNode
  GetLoadBalancersIdActionsActionIdResponse* = object
    action: JsonNode
  LoadBalancerActionSortOption* = enum
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

  LoadBalancerActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getLoadBalancersIdActions*(client: HetznerClient, id: int64,
                                sort: set[LoadBalancerActionSortOption] = {},
                                status: set[LoadBalancerActionStatusOption] = {}): Future[GetLoadBalancersIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Load Balancer. You can sort the results by
  ## using the `sort` URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/load_balancers/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancersIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsAddService*(client: HetznerClient, id: int64,
                                           body: PostLoadBalancersIdActionsAddServiceRequest): Future[PostLoadBalancersIdActionsAddServiceResponse] {.async.} =
  ## Adds a service to a Load Balancer.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                       | Description
  ## |
  ## |----------------------------|--------------------------------------------------
  ## -------|
  ## | `source_port_already_used` | The source port you are trying to add is already
  ## in use |

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/add_service", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsAddServiceResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsAddTarget*(client: HetznerClient, id: int64,
                                          body: PostLoadBalancersIdActionsAddTargetRequest): Future[PostLoadBalancersIdActionsAddTargetResponse] {.async.} =
  ## Adds a target to a Load Balancer.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                                    | Description
  ## |
  ## |-----------------------------------------|-------------------------------------
  ## ------------------------------------------------------------------|
  ## | `cloud_resource_ip_not_allowed`         | The IP you are trying to add as a
  ## target belongs to a Hetzner Cloud resource                          |
  ## | `ip_not_owned`                          | The IP you are trying to add as a
  ## target is not owned by the Project owner                            |
  ## | `load_balancer_not_attached_to_network` | The Load Balancer is not attached to
  ## a network                                                        |
  ## | `robot_unavailable`                     | Robot was not available. The caller
  ## may retry the operation after a short delay.                      |
  ## | `server_not_attached_to_network`        | The server you are trying to add as
  ## a target is not attached to the same network as the Load Balancer |
  ## | `target_already_defined`                | The Load Balancer target you are
  ## trying to define is already defined                                  |

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/add_target", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsAddTargetResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsAttachToNetwork*(client: HetznerClient, id: int64,
                                                body: PostLoadBalancersIdActionsAttachToNetworkRequest): Future[PostLoadBalancersIdActionsAttachToNetworkResponse] {.async.} =
  ## Attach a Load Balancer to a Network.
  ##
  ## **Call specific error codes**
  ##
  ## | Code                             | Description
  ## |
  ## |----------------------------------|--------------------------------------------
  ## ---------------------------|
  ## | `load_balancer_already_attached` | The Load Balancer is already attached to a
  ## network                    |
  ## | `ip_not_available`               | The provided Network IP is not available
  ## |
  ## | `no_subnet_available`            | No Subnet or IP is available for the Load
  ## Balancer within the network |

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/attach_to_network", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsAttachToNetworkResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsChangeAlgorithm*(client: HetznerClient, id: int64,
                                                body: PostLoadBalancersIdActionsChangeAlgorithmRequest): Future[PostLoadBalancersIdActionsChangeAlgorithmResponse] {.async.} =
  ## Change the algorithm that determines to which target new requests are sent.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/change_algorithm", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsChangeAlgorithmResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsChangeDnsPtr*(client: HetznerClient, id: int64,
                                             body: PostLoadBalancersIdActionsChangeDnsPtrRequest): Future[PostLoadBalancersIdActionsChangeDnsPtrResponse] {.async.} =
  ## Changes the hostname that will appear when getting the hostname belonging to the
  ## public IPs (IPv4 and IPv6) of this Load Balancer.
  ##
  ## Floating IPs assigned to the Server are not affected by this.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/change_dns_ptr", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsChangeDnsPtrResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsChangeProtection*(client: HetznerClient,
                                                 id: int64,
                                                 body: PostLoadBalancersIdActionsChangeProtectionRequest): Future[PostLoadBalancersIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of a Load Balancer.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsChangeType*(client: HetznerClient, id: int64,
                                           body: PostLoadBalancersIdActionsChangeTypeRequest): Future[PostLoadBalancersIdActionsChangeTypeResponse] {.async.} =
  ## Changes the type (Max Services, Max Targets and Max Connections) of a Load
  ## Balancer.
  ##
  ## **Call specific error codes**
  ##
  ## | Code                         | Description
  ## |
  ## |------------------------------|------------------------------------------------
  ## -----------------|
  ## | `invalid_load_balancer_type` | The Load Balancer type does not fit for the
  ## given Load Balancer |

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/change_type", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsChangeTypeResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsDeleteService*(client: HetznerClient, id: int64,
                                              body: PostLoadBalancersIdActionsDeleteServiceRequest): Future[PostLoadBalancersIdActionsDeleteServiceResponse] {.async.} =
  ## Delete a service of a Load Balancer.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/delete_service", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsDeleteServiceResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsDetachFromNetwork*(client: HetznerClient,
                                                  id: int64,
                                                  body: PostLoadBalancersIdActionsDetachFromNetworkRequest): Future[PostLoadBalancersIdActionsDetachFromNetworkResponse] {.async.} =
  ## Detaches a Load Balancer from a network.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/detach_from_network", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsDetachFromNetworkResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsDisablePublicInterface*(client: HetznerClient,
                                                       id: int64): Future[PostLoadBalancersIdActionsDisablePublicInterfaceResponse] {.async.} =
  ## Disable the public interface of a Load Balancer. The Load Balancer will be not
  ## accessible from the internet via its public IPs.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                                      | Description
  ## |
  ## |-------------------------------------------|-----------------------------------
  ## ---------------------------------------------|
  ## | `load_balancer_not_attached_to_network`   |  The Load Balancer is not attached
  ## to a network                                |
  ## | `targets_without_use_private_ip`          | The Load Balancer has targets that
  ## use the public IP instead of the private IP |

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/disable_public_interface")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsDisablePublicInterfaceResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsEnablePublicInterface*(client: HetznerClient,
                                                      id: int64): Future[PostLoadBalancersIdActionsEnablePublicInterfaceResponse] {.async.} =
  ## Enable the public interface of a Load Balancer. The Load Balancer will be
  ## accessible from the internet via its public IPs.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/enable_public_interface")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsEnablePublicInterfaceResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsRemoveTarget*(client: HetznerClient, id: int64,
                                             body: PostLoadBalancersIdActionsRemoveTargetRequest): Future[PostLoadBalancersIdActionsRemoveTargetResponse] {.async.} =
  ## Removes a target from a Load Balancer.

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/remove_target", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsRemoveTargetResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancersIdActionsUpdateService*(client: HetznerClient, id: int64,
                                              body: PostLoadBalancersIdActionsUpdateServiceRequest): Future[PostLoadBalancersIdActionsUpdateServiceResponse] {.async.} =
  ## Updates a Load Balancer Service.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                       | Description
  ## |
  ## |----------------------------|--------------------------------------------------
  ## -------|
  ## | `source_port_already_used` | The source port you are trying to add is already
  ## in use |

  let res = await client.httpPOST(fmt"/load_balancers/{id}/actions/update_service", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersIdActionsUpdateServiceResponse)
  else:
    raise newException(HetznerClientError, body)

proc getLoadBalancersIdActionsActionId*(client: HetznerClient, id: int64,
                                        actionId: int64): Future[GetLoadBalancersIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action for a Load Balancer.

  let res = await client.httpGET(fmt"/load_balancers/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancersIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
