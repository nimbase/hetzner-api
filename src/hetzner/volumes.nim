# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetVolumesResponse* = object
    meta: JsonNode
    volumes: seq[JsonNode]
  PostVolumesRequest = object
    automount: Option[bool]
    format: Option[string]
    labels: Option[JsonNode]
    location: Option[string]
    name: string
    server: Option[int64]
    size: int64
  PostVolumesResponse* = object
    action: JsonNode
    next_actions: seq[JsonNode]
    volume: JsonNode
  GetVolumesIdResponse* = object
    volume: JsonNode
  PutVolumesIdRequest = object
    labels: Option[JsonNode]
    name: string
  PutVolumesIdResponse* = object
    volume: JsonNode
  VolumeStatusOption* = enum
    statusAvailable = "available"
    statusCreating = "creating"

  VolumeSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"


proc getVolumes*(client: HetznerClient, status: set[VolumeStatusOption] = {},
                 sort: set[VolumeSortOption] = {},
                 name: string = default(string),
                 labelSelector: string = default(string)): Future[GetVolumesResponse] {.async.} =
  ## Gets all existing Volumes that you have available.

  var q = initOrderedTable[string, string]()
  for v in status: q["status"] = $v
  for v in sort: q["sort"] = $v
  q["name"] = $name
  q["label_selector"] = $labelSelector
  let res = await client.httpGET("/volumes", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetVolumesResponse)
  else:
    raise newException(HetznerClientError, body)

proc postVolumes*(client: HetznerClient, body: PostVolumesRequest): Future[PostVolumesResponse] {.async.} =
  ## Creates a new Volume attached to a Server. If you want to create a Volume that
  ## is not attached to a Server, you need to provide the `location` key instead of
  ## `server`. This can be either the ID or the name of the Location this Volume will
  ## be created in. Note that a Volume can be attached to a Server only in the same
  ## Location as the Volume itself.
  ##
  ## Specifying the Server during Volume creation will automatically attach the
  ## Volume to that Server after it has been initialized. In that case, the
  ## `next_actions` key in the response is an array which contains a single
  ## `attach_volume` action.
  ##
  ## The minimum Volume size is 10GB and the maximum size is 10TB (10240GB).
  ##
  ## A volume’s name can consist of alphanumeric characters, dashes, underscores, and
  ## dots, but has to start and end with an alphanumeric character. The total length
  ## is limited to 64 characters. Volume names must be unique per Project.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                                | Description
  ## |
  ## |-------------------------------------|-----------------------------------------
  ## ------------|
  ## | `no_space_left_in_location`         | There is no volume space left in the
  ## given location |

  let res = await client.httpPOST("/volumes", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostVolumesResponse)
  else:
    raise newException(HetznerClientError, body)

proc getVolumesId*(client: HetznerClient, id: int64): Future[GetVolumesIdResponse] {.async.} =
  ## Gets a specific Volume object.

  let res = await client.httpGET(fmt"/volumes/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetVolumesIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putVolumesId*(client: HetznerClient, id: string, body: PutVolumesIdRequest): Future[PutVolumesIdResponse] {.async.} =
  ## Updates the Volume properties.
  ##
  ## Note that when updating labels, the volume’s current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.

  let res = await client.httpPUT(fmt"/volumes/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutVolumesIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteVolumesId*(client: HetznerClient, id: string): Future[AsyncResponse] {.async.} =
  ## Deletes a volume. All Volume data is irreversibly destroyed. The Volume must not
  ## be attached to a Server and it must not have delete protection enabled.

  let res = await client.httpDELETE(fmt"/volumes/{id}")
  return res
