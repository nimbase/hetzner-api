# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetServersResponse* = object
    meta: JsonNode
    servers: seq[JsonNode]
  PostServersRequest = object
    automount: Option[bool]
    datacenter: Option[string]
    firewalls: Option[seq[JsonNode]]
    image: string
    labels: Option[JsonNode]
    location: Option[string]
    name: string
    networks: Option[seq[int64]]
    placement_group: Option[int64]
    public_net: Option[JsonNode]
    server_type: string
    ssh_keys: Option[seq[string]]
    start_after_create: Option[bool]
    user_data: Option[string]
    volumes: Option[seq[int64]]
  PostServersResponse* = object
    action: JsonNode
    next_actions: seq[JsonNode]
    root_password: string
      ## Root password when no SSH keys have been specified
    server: JsonNode
  GetServersIdResponse* = object
    server: JsonNode
  PutServersIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutServersIdResponse* = object
    server: JsonNode
  DeleteServersIdResponse* = object
    action: JsonNode
  GetServersIdMetricsResponse* = object
    metrics: JsonNode
  ServerSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"

  ServerStatusOption* = enum
    statusInitializing = "initializing"
    statusStarting = "starting"
    statusRunning = "running"
    statusStopping = "stopping"
    statusOff = "off"
    statusDeleting = "deleting"
    statusRebuilding = "rebuilding"
    statusMigrating = "migrating"
    statusUnknown = "unknown"

  ServerTypeOption* = enum
    typeCpu = "cpu"
    typeDisk = "disk"
    typeNetwork = "network"


proc getServers*(client: HetznerClient, name: string = default(string),
                 labelSelector: string = default(string),
                 sort: set[ServerSortOption] = {},
                 status: set[ServerStatusOption] = {}): Future[GetServersResponse] {.async.} =
  ## Returns all existing Server objects

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  q["label_selector"] = $labelSelector
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET("/servers", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServersResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServers*(client: HetznerClient, body: PostServersRequest): Future[PostServersResponse] {.async.} =
  ## Creates a new Server. Returns preliminary information about the Server as well
  ## as an Action that covers progress of creation.

  let res = await client.httpPOST("/servers", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersResponse)
  else:
    raise newException(HetznerClientError, body)

proc getServersId*(client: HetznerClient, id: int64): Future[GetServersIdResponse] {.async.} =
  ## Returns a specific Server object. The Server must exist inside the Project

  let res = await client.httpGET(fmt"/servers/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServersIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putServersId*(client: HetznerClient, id: int64, body: PutServersIdRequest): Future[PutServersIdResponse] {.async.} =
  ## Updates a Server. You can update a Server’s name and a Server’s labels.
  ## Please note that Server names must be unique per Project and valid hostnames as
  ## per RFC 1123 (i.e. may only contain letters, digits, periods, and dashes).
  ## Also note that when updating labels, the Server’s current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.

  let res = await client.httpPUT(fmt"/servers/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutServersIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteServersId*(client: HetznerClient, id: int64): Future[DeleteServersIdResponse] {.async.} =
  ## Deletes a Server. This immediately removes the Server from your account, and it
  ## is no longer accessible.

  let res = await client.httpDELETE(fmt"/servers/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, DeleteServersIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc getServersIdMetrics*(client: HetznerClient, id: int64,
                          `type`: set[ServerTypeOption] = {}, start: string,
                          `end`: string, step: string = default(string)): Future[GetServersIdMetricsResponse] {.async.} =
  ## Get Metrics for specified Server.
  ##
  ## You must specify the type of metric to get: cpu, disk or network. You can also
  ## specify more than one type by comma separation, e.g. cpu,disk.
  ##
  ## Depending on the type you will get different time series data
  ##
  ## | Type    | Timeseries              | Unit      | Description
  ## |
  ## |---------|-------------------------|-----------|-------------------------------
  ## -----------------------|
  ## | cpu     | cpu                     | percent   | Percent CPU usage
  ## |
  ## | disk    | disk.0.iops.read        | iop/s     | Number of read IO operations
  ## per second              |
  ## |         | disk.0.iops.write       | iop/s     | Number of write IO operations
  ## per second             |
  ## |         | disk.0.bandwidth.read   | bytes/s   | Bytes read per second
  ## |
  ## |         | disk.0.bandwidth.write  | bytes/s   | Bytes written per second
  ## |
  ## | network | network.0.pps.in        | packets/s | Public Network interface
  ## packets per second received |
  ## |         | network.0.pps.out       | packets/s | Public Network interface
  ## packets per second sent     |
  ## |         | network.0.bandwidth.in  | bytes/s   | Public Network interface
  ## bytes/s received            |
  ## |         | network.0.bandwidth.out | bytes/s   | Public Network interface
  ## bytes/s sent                |
  ##
  ## Metrics are available for the last 30 days only.
  ##
  ## If you do not provide the step argument we will automatically adjust it so that
  ## a maximum of 200 samples are returned.
  ##
  ## We limit the number of samples returned to a maximum of 500 and will adjust the
  ## step parameter accordingly.

  var q = initOrderedTable[string, string]()
  for v in `type`: q["type"] = $v
  q["start"] = $start
  q["end"] = $`end`
  q["step"] = $step
  let res = await client.httpGET(fmt"/servers/{id}/metrics", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServersIdMetricsResponse)
  else:
    raise newException(HetznerClientError, body)
