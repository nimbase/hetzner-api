# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T00:17:48+00:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "floating_ip_actions serialization":
  test "round-trips GetFloatingIpsIdActionsResponse":
    let obj = hetzner.GetFloatingIpsIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFloatingIpsIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostFloatingIpsIdActionsAssignResponse":
    let obj = hetzner.PostFloatingIpsIdActionsAssignResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFloatingIpsIdActionsAssignResponse)) == openjson.toJson(obj)

  test "round-trips PostFloatingIpsIdActionsChangeDnsPtrResponse":
    let obj = hetzner.PostFloatingIpsIdActionsChangeDnsPtrResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFloatingIpsIdActionsChangeDnsPtrResponse)) == openjson.toJson(obj)

  test "round-trips PostFloatingIpsIdActionsChangeProtectionResponse":
    let obj = hetzner.PostFloatingIpsIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFloatingIpsIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips PostFloatingIpsIdActionsUnassignResponse":
    let obj = hetzner.PostFloatingIpsIdActionsUnassignResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFloatingIpsIdActionsUnassignResponse)) == openjson.toJson(obj)

  test "round-trips GetFloatingIpsIdActionsActionIdResponse":
    let obj = hetzner.GetFloatingIpsIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFloatingIpsIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "floating_ip_actions endpoints":
  test "GET /floating_ips/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFloatingIpsIdActions(1, {}, {})

  test "POST /floating_ips/{id}/actions/unassign":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postFloatingIpsIdActionsUnassign(1)

  test "GET /floating_ips/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFloatingIpsIdActionsActionId(1, 1)

