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
  GetLoadBalancersResponse* = object
    load_balancers: seq[JsonNode]
    meta: JsonNode
  PostLoadBalancersRequest = object
    algorithm: JsonNode
    labels: Option[JsonNode]
    load_balancer_type: string
    location: Option[string]
    name: string
    network: Option[int64]
    network_zone: Option[string]
    public_interface: Option[bool]
    services: Option[seq[JsonNode]]
    targets: Option[seq[JsonNode]]
  PostLoadBalancersResponse* = object
    action: JsonNode
    load_balancer: JsonNode
  GetLoadBalancersIdResponse* = object
    load_balancer: JsonNode
  PutLoadBalancersIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutLoadBalancersIdResponse* = object
    load_balancer: JsonNode
  GetLoadBalancersIdMetricsResponse* = object
    metrics: JsonNode
  LoadBalancerSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"

  LoadBalancerTypeOption* = enum
    typeOpenConnections = "open_connections"
    typeConnectionsPerSecond = "connections_per_second"
    typeRequestsPerSecond = "requests_per_second"
    typeBandwidth = "bandwidth"


proc getLoadBalancers*(client: HetznerClient,
                       sort: set[LoadBalancerSortOption] = {},
                       name: string = default(string),
                       labelSelector: string = default(string)): Future[GetLoadBalancersResponse] {.async.} =
  ## Gets all existing Load Balancers that you have available.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  q["name"] = $name
  q["label_selector"] = $labelSelector
  let res = await client.httpGET("/load_balancers", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancersResponse)
  else:
    raise newException(HetznerClientError, body)

proc postLoadBalancers*(client: HetznerClient, body: PostLoadBalancersRequest): Future[PostLoadBalancersResponse] {.async.} =
  ## Creates a Load Balancer.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                                    | Description
  ## |
  ## |-----------------------------------------|-------------------------------------
  ## ------------------------------------------------------------------|
  ## | `cloud_resource_ip_not_allowed`         | The IP you are trying to add as a
  ## target belongs to a Hetzner Cloud resource                          |
  ## | `ip_not_owned`                          | The IP is not owned by the owner of
  ## the project of the Load Balancer                                  |
  ## | `load_balancer_not_attached_to_network` | The Load Balancer is not attached to
  ## a network                                                        |
  ## | `robot_unavailable`                     | Robot was not available. The caller
  ## may retry the operation after a short delay.                      |
  ## | `server_not_attached_to_network`        | The server you are trying to add as
  ## a target is not attached to the same network as the Load Balancer |
  ## | `source_port_already_used`              | The source port you are trying to
  ## add is already in use                                               |
  ## | `target_already_defined`                | The Load Balancer target you are
  ## trying to define is already defined                                  |

  let res = await client.httpPOST("/load_balancers", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostLoadBalancersResponse)
  else:
    raise newException(HetznerClientError, body)

proc getLoadBalancersId*(client: HetznerClient, id: int64): Future[GetLoadBalancersIdResponse] {.async.} =
  ## Gets a specific Load Balancer object.

  let res = await client.httpGET(fmt"/load_balancers/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancersIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putLoadBalancersId*(client: HetznerClient, id: int64,
                         body: PutLoadBalancersIdRequest): Future[PutLoadBalancersIdResponse] {.async.} =
  ## Updates a Load Balancer. You can update a Load Balancer’s name and a Load
  ## Balancer’s labels.
  ##
  ## Note that when updating labels, the Load Balancer’s current set of labels will
  ## be replaced with the labels provided in the request body. So, for example, if
  ## you want to add a new label, you have to provide all existing labels plus the
  ## new label in the request body.
  ##
  ## Note: if the Load Balancer object changes during the request, the response will
  ## be a “conflict” error.

  let res = await client.httpPUT(fmt"/load_balancers/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutLoadBalancersIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteLoadBalancersId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a Load Balancer.

  let res = await client.httpDELETE(fmt"/load_balancers/{id}")
  return res

proc getLoadBalancersIdMetrics*(client: HetznerClient, id: int64,
                                `type`: set[LoadBalancerTypeOption] = {},
                                start: string, `end`: string,
                                step: string = default(string)): Future[GetLoadBalancersIdMetricsResponse] {.async.} =
  ## You must specify the type of metric to get: `open_connections`,
  ## `connections_per_second`, `requests_per_second` or `bandwidth`. You can also
  ## specify more than one type by comma separation, e.g.
  ## `requests_per_second,bandwidth`.
  ##
  ## Depending on the type you will get different time series data:
  ##
  ## |Type | Timeseries | Unit | Description |
  ## |---- |------------|------|-------------|
  ## | open_connections | open_connections | number | Open connections |
  ## | connections_per_second | connections_per_second | connections/s | Connections
  ## per second |
  ## | requests_per_second | requests_per_second | requests/s | Requests per second |
  ## | bandwidth | bandwidth.in | bytes/s | Ingress bandwidth |
  ## || bandwidth.out | bytes/s | Egress bandwidth |
  ##
  ## Metrics are available for the last 30 days only.
  ##
  ## If you do not provide the step argument we will automatically adjust it so that
  ## 200 samples are returned.
  ##
  ## We limit the number of samples to a maximum of 500 and will adjust the step
  ## parameter accordingly.

  var q = initOrderedTable[string, string]()
  for v in `type`: q["type"] = $v
  q["start"] = $start
  q["end"] = $`end`
  q["step"] = $step
  let res = await client.httpGET(fmt"/load_balancers/{id}/metrics", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancersIdMetricsResponse)
  else:
    raise newException(HetznerClientError, body)
