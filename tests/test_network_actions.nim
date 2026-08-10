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

suite "network_actions serialization":
  test "round-trips GetNetworksIdActionsResponse":
    let obj = hetzner.GetNetworksIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetNetworksIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksIdActionsAddRouteResponse":
    let obj = hetzner.PostNetworksIdActionsAddRouteResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksIdActionsAddRouteResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksIdActionsAddSubnetResponse":
    let obj = hetzner.PostNetworksIdActionsAddSubnetResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksIdActionsAddSubnetResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksIdActionsChangeIpRangeResponse":
    let obj = hetzner.PostNetworksIdActionsChangeIpRangeResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksIdActionsChangeIpRangeResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksIdActionsChangeProtectionResponse":
    let obj = hetzner.PostNetworksIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksIdActionsDeleteRouteResponse":
    let obj = hetzner.PostNetworksIdActionsDeleteRouteResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksIdActionsDeleteRouteResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksIdActionsDeleteSubnetResponse":
    let obj = hetzner.PostNetworksIdActionsDeleteSubnetResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksIdActionsDeleteSubnetResponse)) == openjson.toJson(obj)

  test "round-trips GetNetworksIdActionsActionIdResponse":
    let obj = hetzner.GetNetworksIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetNetworksIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "network_actions endpoints":
  test "GET /networks/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getNetworksIdActions(1, {}, {})

  test "GET /networks/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getNetworksIdActionsActionId(1, 1)

