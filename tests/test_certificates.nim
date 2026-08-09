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

suite "certificates serialization":
  test "round-trips GetCertificatesResponse":
    let obj = hetzner.GetCertificatesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetCertificatesResponse)) == openjson.toJson(obj)

  test "round-trips PostCertificatesResponse":
    let obj = hetzner.PostCertificatesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostCertificatesResponse)) == openjson.toJson(obj)

  test "round-trips GetCertificatesIdResponse":
    let obj = hetzner.GetCertificatesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetCertificatesIdResponse)) == openjson.toJson(obj)

  test "round-trips PutCertificatesIdResponse":
    let obj = hetzner.PutCertificatesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutCertificatesIdResponse)) == openjson.toJson(obj)

suite "certificates endpoints":
  test "GET /certificates":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getCertificates({}, "test", "test", {})

  test "GET /certificates/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getCertificatesId(1)

  test "DELETE /certificates/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteCertificatesId(1)

