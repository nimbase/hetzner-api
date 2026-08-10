# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-10T04:22:05+00:00
# License: MIT
import std/[asyncdispatch]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "primary_ip_actions serialization":
  test "round-trips PostPrimaryIpsIdActionsAssignResponse":
    let obj = hetzner.PostPrimaryIpsIdActionsAssignResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostPrimaryIpsIdActionsAssignResponse)) == openjson.toJson(obj)

  test "round-trips PostPrimaryIpsIdActionsChangeDnsPtrResponse":
    let obj = hetzner.PostPrimaryIpsIdActionsChangeDnsPtrResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostPrimaryIpsIdActionsChangeDnsPtrResponse)) == openjson.toJson(obj)

  test "round-trips PostPrimaryIpsIdActionsChangeProtectionResponse":
    let obj = hetzner.PostPrimaryIpsIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostPrimaryIpsIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips PostPrimaryIpsIdActionsUnassignResponse":
    let obj = hetzner.PostPrimaryIpsIdActionsUnassignResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostPrimaryIpsIdActionsUnassignResponse)) == openjson.toJson(obj)

suite "primary_ip_actions endpoints":
  test "POST /primary_ips/{id}/actions/unassign":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postPrimaryIpsIdActionsUnassign(1)

