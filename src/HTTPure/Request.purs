module HTTPure.Request
  ( Request
  , fromHTTPRequest
  ) where

import Prelude

import Effect.Aff as Aff
import Node.HTTP as HTTP

import HTTPure.Body as Body
import HTTPure.Headers as Headers
import HTTPure.Method as Method
import HTTPure.Path as Path
import HTTPure.Query as Query
import HTTPure.Version as Version

-- | The `Request` type is a `Record` type that includes fields for accessing
-- | the different parts of the HTTP request.
type Request =
  { fullPath ∷ String
  , method ∷ Method.Method
  , path ∷ Path.Path
  , query ∷ Query.Query
  , headers ∷ Headers.Headers
  , body ∷ String
  , httpVersion ∷ Version.Version
  }

-- | Given an HTTP `Request` object, this method will convert it to an HTTPure
-- | `Request` object.
fromHTTPRequest ∷ HTTP.Request → Aff.Aff Request
fromHTTPRequest request = do
  body ← Body.read request
  pure $
    { fullPath: HTTP.requestURL request
    , method: Method.read request
    , path: Path.read request
    , query: Query.read request
    , headers: Headers.read request
    , body
    , httpVersion: Version.read request
    }
