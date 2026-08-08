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

suite "locations serialization":
  test "round-trips GetLocationsResponse":
    let obj = hetzner.GetLocationsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLocationsResponse)) == openjson.toJson(obj)

  test "round-trips GetLocationsIdResponse":
    let obj = hetzner.GetLocationsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLocationsIdResponse)) == openjson.toJson(obj)

suite "locations endpoints":
  test "GET /locations":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLocations("test")

  test "GET /locations/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLocationsId(1)

