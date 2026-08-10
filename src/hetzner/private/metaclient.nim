# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# using the awesome [Nimbase CLI](https://github.com/nimbase/nimbase)
#
# Generated at: 2026-08-10T04:22:05+00:00
# License: MIT

import std/[asyncdispatch, httpclient, tables,
        strutils, sequtils, times, uri]

import pkg/openparser/json


export asyncdispatch, httpclient, json, tables, sequtils, times


type
  HetznerClient* = ref object of RootObj
    baseUri*: string
    httpClient*: AsyncHttpClient
    apiKey*: string

  QueryTable* = OrderedTable[string, string]

  HetznerClientError* = object of CatchableError

proc `$`*(query: QueryTable): string =
  if query.len > 0:
    add result, "?"
    add result, join(query.keys.toSeq.mapIt(it & "=" & query[it]), "&")

proc initHetznerClient*(apiKey: string): HetznerClient =
  new(result)
  result.baseUri = "https://api.hetzner.cloud/v1/"
  result.httpClient = newAsyncHttpClient()
  result.httpClient.headers = newHttpHeaders({
    "Accept": "application/json",
    "Authorization": "Bearer " & apiKey
  })
  result.apiKey = apiKey

proc httpGet*(client: HetznerClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.get(url)

proc httpGet*(client: HetznerClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.get(url)

proc httpPost*[T](client: HetznerClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.post(url, toJson(body))

proc httpPost*(client: HetznerClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.post(url)

proc httpPost*(client: HetznerClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.post(url)

proc httpPut*[T](client: HetznerClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPut,
    body = toJson(body))

proc httpPut*(client: HetznerClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPut)

proc httpPut*(client: HetznerClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.request(url, httpMethod = HttpPut)

proc httpDelete*[T](client: HetznerClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpDelete,
    body = toJson(body))

proc httpDelete*(client: HetznerClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpDelete)

proc httpDelete*(client: HetznerClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.request(url, httpMethod = HttpDelete)

proc httpPatch*[T](client: HetznerClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPatch,
    body = toJson(body))

proc httpPatch*(client: HetznerClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPatch)
