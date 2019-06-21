module Test.HTTPure.RequestSpec where

import Prelude

import Data.Tuple as Tuple
import Foreign.Object as Object
import Test.Spec as Spec

import HTTPure.Headers as Headers
import HTTPure.Method as Method
import HTTPure.Request as Request
import HTTPure.Version as Version

import Test.HTTPure.TestHelpers as TestHelpers
import Test.HTTPure.TestHelpers ((?=))

fromHTTPRequestSpec :: TestHelpers.Test
fromHTTPRequestSpec = Spec.describe "fromHTTPRequest" do
  Spec.it "contains the correct method" do
    mock <- mockRequest
    mock.method ?= Method.Post
  Spec.it "contains the correct path" do
    mock <- mockRequest
    mock.path ?= [ "test" ]
  Spec.it "contains the correct query" do
    mock <- mockRequest
    mock.query ?= Object.singleton "a" "b"
  Spec.it "contains the correct headers" do
    mock <- mockRequest
    mock.headers ?= Headers.headers mockHeaders
  Spec.it "contains the correct body" do
    mock <- mockRequest
    mock.body ?= "body"
  Spec.it "contains the correct httpVersion" do
    mock <- mockRequest
    mock.httpVersion ?= Version.HTTP1_1
  where
    mockHeaders = [ Tuple.Tuple "Test" "test" ]
    mockHTTPRequest =
      TestHelpers.mockRequest "1.1" "POST" "/test?a=b" "body" mockHeaders
    mockRequest = mockHTTPRequest >>= Request.fromHTTPRequest

requestSpec :: TestHelpers.Test
requestSpec = Spec.describe "Request" do
  fromHTTPRequestSpec
