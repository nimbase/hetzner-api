# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T04:08:19+00:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "pricing serialization":
  test "round-trips GetPricingResponse":
    let obj = hetzner.GetPricingResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetPricingResponse)) == openjson.toJson(obj)

suite "pricing endpoints":
  test "GET /pricing":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getPricing()

