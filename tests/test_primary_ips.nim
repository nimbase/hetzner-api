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

suite "primary_ips serialization":
  test "round-trips GetPrimaryIpsResponse":
    let obj = hetzner.GetPrimaryIpsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetPrimaryIpsResponse)) == openjson.toJson(obj)

  test "round-trips PostPrimaryIpsResponse":
    let obj = hetzner.PostPrimaryIpsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostPrimaryIpsResponse)) == openjson.toJson(obj)

  test "round-trips GetPrimaryIpsIdResponse":
    let obj = hetzner.GetPrimaryIpsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetPrimaryIpsIdResponse)) == openjson.toJson(obj)

  test "round-trips PutPrimaryIpsIdResponse":
    let obj = hetzner.PutPrimaryIpsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutPrimaryIpsIdResponse)) == openjson.toJson(obj)

suite "primary_ips endpoints":
  test "GET /primary_ips":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getPrimaryIps("test", "test", "test", {})

  test "GET /primary_ips/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getPrimaryIpsId(1)

  test "DELETE /primary_ips/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deletePrimaryIpsId(1)

