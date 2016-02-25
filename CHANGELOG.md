# Changelog

## 0.2.0 (2016-02-25)

* Enhancements
  * Add `JOSE.__crypto_fallback__` which can be set directly or with the `JOSE_CRYPTO_FALLBACK` environment variable.  EdDSA and EdDH algorithms not natively supported are disabled by default.
  * Support [OKP](https://tools.ietf.org/html/draft-ietf-jose-cfrg-curves) key type with the following curves:
    * `Ed25519` (external [RbNaCl](https://github.com/cryptosphere/rbnacl) or fallback supported)
    * `Ed25519ph` (external [RbNaCl](https://github.com/cryptosphere/rbnacl) or fallback supported)
    * `X25519` (external [RbNaCl](https://github.com/cryptosphere/rbnacl) or fallback supported)
    * `Ed448` (no external, but fallback supported)
    * `Ed448ph` (no external, but fallback supported)
    * `X448` (no external, but fallback supported)
  * Support [SHA-3](https://en.wikipedia.org/wiki/SHA-3) functions for use with `Ed448` and `Ed448ph`.
  * Add `JOSE::JWK#shared_secret` for computing the shared secret between two `EC` or `OKP` keys.

## 0.1.0 (2015-11-24)

* Initial Release

* Algorithm Support
  * JSON Web Encryption (JWE) [RFC 7516](https://tools.ietf.org/html/rfc7516)
    * `"alg"` [RFC 7518 Section 4](https://tools.ietf.org/html/rfc7518#section-4)
      * `RSA1_5`
      * `RSA-OAEP`
      * `RSA-OAEP-256`
      * `A128KW`
      * `A192KW`
      * `A256KW`
      * `dir`
      * `ECDH-ES`
      * `ECDH-ES+A128KW`
      * `ECDH-ES+A192KW`
      * `ECDH-ES+A256KW`
      * `A128GCMKW`
      * `A192GCMKW`
      * `A256GCMKW`
      * `PBES2-HS256+A128KW`
      * `PBES2-HS384+A192KW`
      * `PBES2-HS512+A256KW`
    * `"enc"` [RFC 7518 Section 5](https://tools.ietf.org/html/rfc7518#section-5)
      * `A128CBC-HS256`
      * `A192CBC-HS384`
      * `A256CBC-HS512`
      * `A128GCM`
      * `A192GCM`
      * `A256GCM`
    * `"zip"` [RFC 7518 Section 7.3](https://tools.ietf.org/html/rfc7518#section-7.3)
      * `DEF`
  * JSON Web Key (JWK) [RFC 7517](https://tools.ietf.org/html/rfc7517)
    * `"alg"` [RFC 7518 Section 6](https://tools.ietf.org/html/rfc7518#section-6)
      * `EC`
      * `RSA`
      * `oct`
  * JSON Web Signature (JWS) [RFC 7515](https://tools.ietf.org/html/rfc7515)
    * `"alg"` [RFC 7518 Section 3](https://tools.ietf.org/html/rfc7518#section-3)
      * `HS256`
      * `HS384`
      * `HS512`
      * `RS256`
      * `RS384`
      * `RS512`
      * `ES256`
      * `ES384`
      * `ES512`
      * `PS256`
      * `PS384`
      * `PS512`
      * `none`