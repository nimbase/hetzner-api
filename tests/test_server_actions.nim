# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:31:24+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "server_actions serialization":
  test "round-trips GetServersIdActionsResponse":
    let obj = hetzner.GetServersIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServersIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsAddToPlacementGroupResponse":
    let obj = hetzner.PostServersIdActionsAddToPlacementGroupResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsAddToPlacementGroupResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsAttachIsoResponse":
    let obj = hetzner.PostServersIdActionsAttachIsoResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsAttachIsoResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsAttachToNetworkResponse":
    let obj = hetzner.PostServersIdActionsAttachToNetworkResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsAttachToNetworkResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsChangeAliasIpsResponse":
    let obj = hetzner.PostServersIdActionsChangeAliasIpsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsChangeAliasIpsResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsChangeDnsPtrResponse":
    let obj = hetzner.PostServersIdActionsChangeDnsPtrResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsChangeDnsPtrResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsChangeProtectionResponse":
    let obj = hetzner.PostServersIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsChangeTypeResponse":
    let obj = hetzner.PostServersIdActionsChangeTypeResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsChangeTypeResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsCreateImageResponse":
    let obj = hetzner.PostServersIdActionsCreateImageResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsCreateImageResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsDetachFromNetworkResponse":
    let obj = hetzner.PostServersIdActionsDetachFromNetworkResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsDetachFromNetworkResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsDetachIsoResponse":
    let obj = hetzner.PostServersIdActionsDetachIsoResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsDetachIsoResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsDisableBackupResponse":
    let obj = hetzner.PostServersIdActionsDisableBackupResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsDisableBackupResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsDisableRescueResponse":
    let obj = hetzner.PostServersIdActionsDisableRescueResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsDisableRescueResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsEnableBackupResponse":
    let obj = hetzner.PostServersIdActionsEnableBackupResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsEnableBackupResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsEnableRescueResponse":
    let obj = hetzner.PostServersIdActionsEnableRescueResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsEnableRescueResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsPoweroffResponse":
    let obj = hetzner.PostServersIdActionsPoweroffResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsPoweroffResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsPoweronResponse":
    let obj = hetzner.PostServersIdActionsPoweronResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsPoweronResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsRebootResponse":
    let obj = hetzner.PostServersIdActionsRebootResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsRebootResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsRebuildResponse":
    let obj = hetzner.PostServersIdActionsRebuildResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsRebuildResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsRemoveFromPlacementGroupResponse":
    let obj = hetzner.PostServersIdActionsRemoveFromPlacementGroupResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsRemoveFromPlacementGroupResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsRequestConsoleResponse":
    let obj = hetzner.PostServersIdActionsRequestConsoleResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsRequestConsoleResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsResetResponse":
    let obj = hetzner.PostServersIdActionsResetResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsResetResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsResetPasswordResponse":
    let obj = hetzner.PostServersIdActionsResetPasswordResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsResetPasswordResponse)) == openjson.toJson(obj)

  test "round-trips PostServersIdActionsShutdownResponse":
    let obj = hetzner.PostServersIdActionsShutdownResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersIdActionsShutdownResponse)) == openjson.toJson(obj)

  test "round-trips GetServersIdActionsActionIdResponse":
    let obj = hetzner.GetServersIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServersIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "server_actions endpoints":
  test "GET /servers/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServersIdActions(1, {}, {})

  test "POST /servers/{id}/actions/detach_iso":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsDetachIso(1)

  test "POST /servers/{id}/actions/disable_backup":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsDisableBackup(1)

  test "POST /servers/{id}/actions/disable_rescue":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsDisableRescue(1)

  test "POST /servers/{id}/actions/enable_backup":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsEnableBackup(1)

  test "POST /servers/{id}/actions/poweroff":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsPoweroff(1)

  test "POST /servers/{id}/actions/poweron":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsPoweron(1)

  test "POST /servers/{id}/actions/reboot":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsReboot(1)

  test "POST /servers/{id}/actions/remove_from_placement_group":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsRemoveFromPlacementGroup(1)

  test "POST /servers/{id}/actions/request_console":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsRequestConsole(1)

  test "POST /servers/{id}/actions/reset":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsReset(1)

  test "POST /servers/{id}/actions/reset_password":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsResetPassword(1)

  test "POST /servers/{id}/actions/shutdown":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postServersIdActionsShutdown(1)

  test "GET /servers/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServersIdActionsActionId(1, 1)

