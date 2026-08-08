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

suite "load_balancer_actions serialization":
  test "round-trips GetLoadBalancersIdActionsResponse":
    let obj = hetzner.GetLoadBalancersIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancersIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsAddServiceResponse":
    let obj = hetzner.PostLoadBalancersIdActionsAddServiceResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsAddServiceResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsAddTargetResponse":
    let obj = hetzner.PostLoadBalancersIdActionsAddTargetResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsAddTargetResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsAttachToNetworkResponse":
    let obj = hetzner.PostLoadBalancersIdActionsAttachToNetworkResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsAttachToNetworkResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsChangeAlgorithmResponse":
    let obj = hetzner.PostLoadBalancersIdActionsChangeAlgorithmResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsChangeAlgorithmResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsChangeDnsPtrResponse":
    let obj = hetzner.PostLoadBalancersIdActionsChangeDnsPtrResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsChangeDnsPtrResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsChangeProtectionResponse":
    let obj = hetzner.PostLoadBalancersIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsChangeTypeResponse":
    let obj = hetzner.PostLoadBalancersIdActionsChangeTypeResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsChangeTypeResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsDeleteServiceResponse":
    let obj = hetzner.PostLoadBalancersIdActionsDeleteServiceResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsDeleteServiceResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsDetachFromNetworkResponse":
    let obj = hetzner.PostLoadBalancersIdActionsDetachFromNetworkResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsDetachFromNetworkResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsDisablePublicInterfaceResponse":
    let obj = hetzner.PostLoadBalancersIdActionsDisablePublicInterfaceResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsDisablePublicInterfaceResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsEnablePublicInterfaceResponse":
    let obj = hetzner.PostLoadBalancersIdActionsEnablePublicInterfaceResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsEnablePublicInterfaceResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsRemoveTargetResponse":
    let obj = hetzner.PostLoadBalancersIdActionsRemoveTargetResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsRemoveTargetResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersIdActionsUpdateServiceResponse":
    let obj = hetzner.PostLoadBalancersIdActionsUpdateServiceResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersIdActionsUpdateServiceResponse)) == openjson.toJson(obj)

  test "round-trips GetLoadBalancersIdActionsActionIdResponse":
    let obj = hetzner.GetLoadBalancersIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancersIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "load_balancer_actions endpoints":
  test "GET /load_balancers/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancersIdActions(1, {}, {})

  test "POST /load_balancers/{id}/actions/disable_public_interface":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postLoadBalancersIdActionsDisablePublicInterface(1)

  test "POST /load_balancers/{id}/actions/enable_public_interface":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postLoadBalancersIdActionsEnablePublicInterface(1)

  test "GET /load_balancers/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancersIdActionsActionId(1, 1)

