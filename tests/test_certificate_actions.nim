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

suite "certificate_actions serialization":
  test "round-trips GetCertificatesIdActionsResponse":
    let obj = hetzner.GetCertificatesIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetCertificatesIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostCertificatesIdActionsRetryResponse":
    let obj = hetzner.PostCertificatesIdActionsRetryResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostCertificatesIdActionsRetryResponse)) == openjson.toJson(obj)

  test "round-trips GetCertificatesIdActionsActionIdResponse":
    let obj = hetzner.GetCertificatesIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetCertificatesIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "certificate_actions endpoints":
  test "GET /certificates/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getCertificatesIdActions(1, {}, {})

  test "POST /certificates/{id}/actions/retry":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postCertificatesIdActionsRetry(1)

  test "GET /certificates/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getCertificatesIdActionsActionId(1, 1)

