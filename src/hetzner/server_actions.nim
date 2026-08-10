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
  GetServersIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostServersIdActionsAddToPlacementGroupRequest = object
    placement_group: int64
  PostServersIdActionsAddToPlacementGroupResponse* = object
    action: JsonNode
  PostServersIdActionsAttachIsoRequest = object
    iso: string
  PostServersIdActionsAttachIsoResponse* = object
    action: JsonNode
  PostServersIdActionsAttachToNetworkRequest = object
    alias_ips: Option[seq[string]]
    ip: Option[string]
    network: int64
  PostServersIdActionsAttachToNetworkResponse* = object
    action: JsonNode
  PostServersIdActionsChangeAliasIpsRequest = object
    alias_ips: seq[string]
    network: int64
  PostServersIdActionsChangeAliasIpsResponse* = object
    action: JsonNode
  PostServersIdActionsChangeDnsPtrRequest = object
    dns_ptr: Option[string]
    ip: string
  PostServersIdActionsChangeDnsPtrResponse* = object
    action: JsonNode
  PostServersIdActionsChangeProtectionRequest = object
    delete: Option[bool]
    rebuild: Option[bool]
  PostServersIdActionsChangeProtectionResponse* = object
    action: JsonNode
  PostServersIdActionsChangeTypeRequest = object
    server_type: string
    upgrade_disk: bool
  PostServersIdActionsChangeTypeResponse* = object
    action: JsonNode
  PostServersIdActionsCreateImageRequest = object
    description: Option[string]
    labels: Option[JsonNode]
    `type`: Option[string]
  PostServersIdActionsCreateImageResponse* = object
    action: JsonNode
    image: JsonNode
  PostServersIdActionsDetachFromNetworkRequest = object
    network: int64
  PostServersIdActionsDetachFromNetworkResponse* = object
    action: JsonNode
  PostServersIdActionsDetachIsoResponse* = object
    action: JsonNode
  PostServersIdActionsDisableBackupResponse* = object
    action: JsonNode
  PostServersIdActionsDisableRescueResponse* = object
    action: JsonNode
  PostServersIdActionsEnableBackupResponse* = object
    action: JsonNode
  PostServersIdActionsEnableRescueRequest = object
    ssh_keys: Option[seq[int64]]
    `type`: Option[string]
  PostServersIdActionsEnableRescueResponse* = object
    action: JsonNode
    root_password: string
      ## Password that will be set for this Server once the Action succeeds
  PostServersIdActionsPoweroffResponse* = object
    action: JsonNode
  PostServersIdActionsPoweronResponse* = object
    action: JsonNode
  PostServersIdActionsRebootResponse* = object
    action: JsonNode
  PostServersIdActionsRebuildRequest = object
    image: string
  PostServersIdActionsRebuildResponse* = object
    action: JsonNode
    root_password: string
      ## New root password when not using SSH keys
  PostServersIdActionsRemoveFromPlacementGroupResponse* = object
    action: JsonNode
  PostServersIdActionsRequestConsoleResponse* = object
    action: JsonNode
    password: string
      ## VNC password to use for this connection (this password only works in combination
      ## with a wss_url with valid token)
    wss_url: string
      ## URL of websocket proxy to use; this includes a token which is valid for a
      ## limited time only
  PostServersIdActionsResetResponse* = object
    action: JsonNode
  PostServersIdActionsResetPasswordResponse* = object
    action: JsonNode
    root_password: string
      ## Password that will be set for this Server once the Action succeeds
  PostServersIdActionsShutdownResponse* = object
    action: JsonNode
  GetServersIdActionsActionIdResponse* = object
    action: JsonNode
  ServerActionSortOption* = enum
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

  ServerActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getServersIdActions*(client: HetznerClient, id: int64,
                          sort: set[ServerActionSortOption] = {},
                          status: set[ServerActionStatusOption] = {}): Future[GetServersIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Server. You can `sort` the results by using the
  ## sort URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/servers/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServersIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsAddToPlacementGroup*(client: HetznerClient, id: int64,
                                              body: PostServersIdActionsAddToPlacementGroupRequest): Future[PostServersIdActionsAddToPlacementGroupResponse] {.async.} =
  ## Adds a Server to a Placement Group.
  ##
  ## Server must be powered off for this command to succeed.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |-------------------------------|-----------------------------------------------
  ## -----------------------|
  ## | `server_not_stopped`          | The action requires a stopped server
  ## |

  let res = await client.httpPOST(fmt"/servers/{id}/actions/add_to_placement_group", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsAddToPlacementGroupResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsAttachIso*(client: HetznerClient, id: int64,
                                    body: PostServersIdActionsAttachIsoRequest): Future[PostServersIdActionsAttachIsoResponse] {.async.} =
  ## Attaches an ISO to a Server. The Server will immediately see it as a new disk.
  ## An already attached ISO will automatically be detached before the new ISO is
  ## attached.
  ##
  ## Servers with attached ISOs have a modified boot order: They will try to boot
  ## from the ISO first before falling back to hard disk.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/attach_iso", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsAttachIsoResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsAttachToNetwork*(client: HetznerClient, id: int64,
                                          body: PostServersIdActionsAttachToNetworkRequest): Future[PostServersIdActionsAttachToNetworkResponse] {.async.} =
  ## Attaches a Server to a network. This will complement the fixed public Server
  ## interface by adding an additional ethernet interface to the Server which is
  ## connected to the specified network.
  ##
  ## The Server will get an IP auto assigned from a subnet of type `server` in the
  ## same `network_zone`.
  ##
  ## Using the `alias_ips` attribute you can also define one or more additional IPs
  ## to the Servers. Please note that you will have to configure these IPs by hand on
  ## your Server since only the primary IP will be given out by DHCP.
  ##
  ## **Call specific error codes**
  ##
  ## | Code                             | Description
  ## |
  ## |----------------------------------|--------------------------------------------
  ## ---------------------------|
  ## | `server_already_attached`        | The server is already attached to the
  ## network                         |
  ## | `ip_not_available`               | The provided Network IP is not available
  ## |
  ## | `no_subnet_available`            | No Subnet or IP is available for the Server
  ## within the network        |
  ## | `networks_overlap`               | The network IP range overlaps with one of
  ## the server networks         |

  let res = await client.httpPOST(fmt"/servers/{id}/actions/attach_to_network", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsAttachToNetworkResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsChangeAliasIps*(client: HetznerClient, id: int64,
                                         body: PostServersIdActionsChangeAliasIpsRequest): Future[PostServersIdActionsChangeAliasIpsResponse] {.async.} =
  ## Changes the alias IPs of an already attached Network. Note that the existing
  ## aliases for the specified Network will be replaced with these provided in the
  ## request body. So if you want to add an alias IP, you have to provide the
  ## existing ones from the Network plus the new alias IP in the request body.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/change_alias_ips", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsChangeAliasIpsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsChangeDnsPtr*(client: HetznerClient, id: int64,
                                       body: PostServersIdActionsChangeDnsPtrRequest): Future[PostServersIdActionsChangeDnsPtrResponse] {.async.} =
  ## Changes the hostname that will appear when getting the hostname belonging to the
  ## primary IPs (IPv4 and IPv6) of this Server.
  ##
  ## Floating IPs assigned to the Server are not affected by this.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/change_dns_ptr", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsChangeDnsPtrResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsChangeProtection*(client: HetznerClient, id: int64,
                                           body: PostServersIdActionsChangeProtectionRequest): Future[PostServersIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of the Server.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsChangeType*(client: HetznerClient, id: int64,
                                     body: PostServersIdActionsChangeTypeRequest): Future[PostServersIdActionsChangeTypeResponse] {.async.} =
  ## Changes the type (Cores, RAM and disk sizes) of a Server.
  ##
  ## Server must be powered off for this command to succeed.
  ##
  ## This copies the content of its disk, and starts it again.
  ##
  ## You can only migrate to Server types with the same `storage_type` and equal or
  ## bigger disks. Shrinking disks is not possible as it might destroy data.
  ##
  ## If the disk gets upgraded, the Server type can not be downgraded any more. If
  ## you plan to downgrade the Server type, set `upgrade_disk` to `false`.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |-------------------------------|-----------------------------------------------
  ## -----------------------|
  ## | `invalid_server_type`         | The server type does not fit for the given
  ## server or is deprecated   |
  ## | `server_not_stopped`          | The action requires a stopped server
  ## |

  let res = await client.httpPOST(fmt"/servers/{id}/actions/change_type", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsChangeTypeResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsCreateImage*(client: HetznerClient, id: int64,
                                      body: PostServersIdActionsCreateImageRequest): Future[PostServersIdActionsCreateImageResponse] {.async.} =
  ## Creates an Image (snapshot) from a Server by copying the contents of its disks.
  ## This creates a snapshot of the current state of the disk and copies it into an
  ## Image. If the Server is currently running you must make sure that its disk
  ## content is consistent. Otherwise, the created Image may not be readable.
  ##
  ## To make sure disk content is consistent, we recommend to shut down the Server
  ## prior to creating an Image.
  ##
  ## You can either create a `backup` Image that is bound to the Server and therefore
  ## will be deleted when the Server is deleted, or you can create an `snapshot`
  ## Image which is completely independent of the Server it was created from and will
  ## survive Server deletion. Backup Images are only available when the backup option
  ## is enabled for the Server. Snapshot Images are billed on a per GB basis.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/create_image", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsCreateImageResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsDetachFromNetwork*(client: HetznerClient, id: int64,
                                            body: PostServersIdActionsDetachFromNetworkRequest): Future[PostServersIdActionsDetachFromNetworkResponse] {.async.} =
  ## Detaches a Server from a network. The interface for this network will vanish.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/detach_from_network", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsDetachFromNetworkResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsDetachIso*(client: HetznerClient, id: int64): Future[PostServersIdActionsDetachIsoResponse] {.async.} =
  ## Detaches an ISO from a Server. In case no ISO Image is attached to the Server,
  ## the status of the returned Action is immediately set to `success`

  let res = await client.httpPOST(fmt"/servers/{id}/actions/detach_iso")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsDetachIsoResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsDisableBackup*(client: HetznerClient, id: int64): Future[PostServersIdActionsDisableBackupResponse] {.async.} =
  ## Disables the automatic backup option and deletes all existing Backups for a
  ## Server. No more additional charges for backups will be made.
  ##
  ## Caution: This immediately removes all existing backups for the Server!

  let res = await client.httpPOST(fmt"/servers/{id}/actions/disable_backup")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsDisableBackupResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsDisableRescue*(client: HetznerClient, id: int64): Future[PostServersIdActionsDisableRescueResponse] {.async.} =
  ## Disables the Hetzner Rescue System for a Server. This makes a Server start from
  ## its disks on next reboot.
  ##
  ## Rescue Mode is automatically disabled when you first boot into it or if you do
  ## not use it for 60 minutes.
  ##
  ## Disabling rescue mode will not reboot your Server — you will have to do this
  ## yourself.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/disable_rescue")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsDisableRescueResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsEnableBackup*(client: HetznerClient, id: int64): Future[PostServersIdActionsEnableBackupResponse] {.async.} =
  ## Enables and configures the automatic daily backup option for the Server.
  ## Enabling automatic backups will increase the price of the Server by 20%. In
  ## return, you will get seven slots where Images of type backup can be stored.
  ##
  ## Backups are automatically created daily.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/enable_backup")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsEnableBackupResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsEnableRescue*(client: HetznerClient, id: int64,
                                       body: PostServersIdActionsEnableRescueRequest): Future[PostServersIdActionsEnableRescueResponse] {.async.} =
  ## Enable the Hetzner Rescue System for this Server. The next time a Server with
  ## enabled rescue mode boots it will start a special minimal Linux distribution
  ## designed for repair and reinstall.
  ##
  ## In case a Server cannot boot on its own you can use this to access a Server’s
  ## disks.
  ##
  ## Rescue Mode is automatically disabled when you first boot into it or if you do
  ## not use it for 60 minutes.
  ##
  ## Enabling rescue mode will not
  ## [reboot](https://docs.hetzner.cloud/#server-actions-soft-reboot-a-server) your
  ## Server — you will have to do this yourself.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/enable_rescue", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsEnableRescueResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsPoweroff*(client: HetznerClient, id: int64): Future[PostServersIdActionsPoweroffResponse] {.async.} =
  ## Cuts power to the Server. This forcefully stops it without giving the Server
  ## operating system time to gracefully stop. May lead to data loss, equivalent to
  ## pulling the power cord. Power off should only be used when shutdown does not
  ## work.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/poweroff")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsPoweroffResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsPoweron*(client: HetznerClient, id: int64): Future[PostServersIdActionsPoweronResponse] {.async.} =
  ## Starts a Server by turning its power on.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/poweron")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsPoweronResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsReboot*(client: HetznerClient, id: int64): Future[PostServersIdActionsRebootResponse] {.async.} =
  ## Reboots a Server gracefully by sending an ACPI request. The Server operating
  ## system must support ACPI and react to the request, otherwise the Server will not
  ## reboot.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/reboot")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsRebootResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsRebuild*(client: HetznerClient, id: int64,
                                  body: PostServersIdActionsRebuildRequest): Future[PostServersIdActionsRebuildResponse] {.async.} =
  ## Rebuilds a Server overwriting its disk with the content of an Image, thereby
  ## **destroying all data** on the target Server
  ##
  ## The Image can either be one you have created earlier (`backup` or `snapshot`
  ## Image) or it can be a completely fresh `system` Image provided by us. You can
  ## get a list of all available Images with `GET /images`.
  ##
  ## Your Server will automatically be powered off before the rebuild command
  ## executes.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/rebuild", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsRebuildResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsRemoveFromPlacementGroup*(client: HetznerClient,
                                                   id: int64): Future[PostServersIdActionsRemoveFromPlacementGroupResponse] {.async.} =
  ## Removes a Server from a Placement Group.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/remove_from_placement_group")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsRemoveFromPlacementGroupResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsRequestConsole*(client: HetznerClient, id: int64): Future[PostServersIdActionsRequestConsoleResponse] {.async.} =
  ## Requests credentials for remote access via VNC over websocket to keyboard,
  ## monitor, and mouse for a Server. The provided URL is valid for 1 minute, after
  ## this period a new url needs to be created to connect to the Server. How long the
  ## connection is open after the initial connect is not subject to this timeout.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/request_console")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsRequestConsoleResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsReset*(client: HetznerClient, id: int64): Future[PostServersIdActionsResetResponse] {.async.} =
  ## Cuts power to a Server and starts it again. This forcefully stops it without
  ## giving the Server operating system time to gracefully stop. This may lead to
  ## data loss, it’s equivalent to pulling the power cord and plugging it in again.
  ## Reset should only be used when reboot does not work.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/reset")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsResetResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsResetPassword*(client: HetznerClient, id: int64): Future[PostServersIdActionsResetPasswordResponse] {.async.} =
  ## Resets the root password. Only works for Linux systems that are running the qemu
  ## guest agent. Server must be powered on (status `running`) in order for this
  ## operation to succeed.
  ##
  ## This will generate a new password for this Server and return it.
  ##
  ## If this does not succeed you can use the rescue system to netboot the Server and
  ## manually change your Server password by hand.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/reset_password")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsResetPasswordResponse)
  else:
    raise newException(HetznerClientError, body)

proc postServersIdActionsShutdown*(client: HetznerClient, id: int64): Future[PostServersIdActionsShutdownResponse] {.async.} =
  ## Shuts down a Server gracefully by sending an ACPI shutdown request. The Server
  ## operating system must support ACPI and react to the request, otherwise the
  ## Server will not shut down.

  let res = await client.httpPOST(fmt"/servers/{id}/actions/shutdown")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostServersIdActionsShutdownResponse)
  else:
    raise newException(HetznerClientError, body)

proc getServersIdActionsActionId*(client: HetznerClient, id: int64,
                                  actionId: int64): Future[GetServersIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action object for a Server.

  let res = await client.httpGET(fmt"/servers/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServersIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
