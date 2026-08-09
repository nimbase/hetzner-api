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

suite "load_balancers serialization":
  test "round-trips GetLoadBalancersResponse":
    let obj = hetzner.GetLoadBalancersResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancersResponse)) == openjson.toJson(obj)

  test "round-trips PostLoadBalancersResponse":
    let obj = hetzner.PostLoadBalancersResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostLoadBalancersResponse)) == openjson.toJson(obj)

  test "round-trips GetLoadBalancersIdResponse":
    let obj = hetzner.GetLoadBalancersIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancersIdResponse)) == openjson.toJson(obj)

  test "round-trips PutLoadBalancersIdResponse":
    let obj = hetzner.PutLoadBalancersIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutLoadBalancersIdResponse)) == openjson.toJson(obj)

  test "round-trips GetLoadBalancersIdMetricsResponse":
    let obj = hetzner.GetLoadBalancersIdMetricsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancersIdMetricsResponse)) == openjson.toJson(obj)

suite "load_balancers endpoints":
  test "GET /load_balancers":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancers({}, "test", "test")

  test "GET /load_balancers/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancersId(1)

  test "DELETE /load_balancers/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteLoadBalancersId(1)

  test "GET /load_balancers/{id}/metrics":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancersIdMetrics(1, {}, "test", "test", "test")

