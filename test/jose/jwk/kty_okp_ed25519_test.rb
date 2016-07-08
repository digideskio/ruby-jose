require 'test_helper'

class JOSE::JWK::KTY_OKP_Ed25519Test < Minitest::Test

  SECRET_JWK_JSON = "{\"crv\":\"Ed25519\",\"d\":\"TghhpzoRLQXOLyyN1GN0ft-TPS0ZYnS_QmRkgLUU5n0\",\"kty\":\"OKP\",\"x\":\"h3eN6RqbqjO24jScv4PirOtJGq-P0qECYA7MdbwFo2o\"}"
  PUBLIC_JWK_JSON = "{\"crv\":\"Ed25519\",\"kty\":\"OKP\",\"x\":\"h3eN6RqbqjO24jScv4PirOtJGq-P0qECYA7MdbwFo2o\"}"

  def test_generate_key
    jwk_secret = JOSE::JWK.generate_key([:okp, :Ed25519])
    refute_equal JOSE::JWK.thumbprint(jwk_secret), JOSE::JWK.thumbprint(JOSE::JWK.generate_key(jwk_secret))
  end

  def test_property_of_sign_and_verify
    property_of {
      Tuple.new([
        gen_jwk_use_sig('Ed25519'),
        SecureRandom.random_bytes(range(0, size))
      ])
    }.check { |tuple|
      jwk_secret = tuple[0][0]
      jwk_public = tuple[0][1]
      plain_text = tuple[1]
      signed_binary = JOSE::JWK.sign(plain_text, jwk_secret).compact
      verified, payload, = JOSE::JWK.verify(signed_binary, jwk_public)
      assert verified
      assert_equal plain_text, payload
    }
  end

  def test_property_of_to_openssh_key_and_from_openssh_key
    property_of {
      gen_jwk_kty_okp(:Ed25519)
    }.check { |tuple|
      jwk_secret = tuple[0]
      assert_equal jwk_secret, JOSE::JWK.from_openssh_key(JOSE::JWK.to_openssh_key(jwk_secret))
    }
  end

  def test_signer
    plain_jwk = JOSE::JWK.from(SECRET_JWK_JSON)
    assert_equal JOSE::Map['alg' => 'EdDSA'], JOSE::JWK.signer(plain_jwk)
    extra_jwk = plain_jwk.merge({'alg' => 'Ed25519', 'use' => 'sig'})
    assert_equal JOSE::Map['alg' => 'Ed25519'], JOSE::JWK.signer(extra_jwk)
    public_jwk = JOSE::JWK.from(PUBLIC_JWK_JSON)
    assert_raises(ArgumentError) { JOSE::JWK.signer(public_jwk) }
  end

  def test_verifier
    plain_jwk = JOSE::JWK.from(SECRET_JWK_JSON)
    assert_equal ['Ed25519', 'EdDSA'], JOSE::JWK.verifier(plain_jwk)
    extra_jwk = plain_jwk.merge({'alg' => 'Ed25519', 'use' => 'sig'})
    assert_equal ['Ed25519'], JOSE::JWK.verifier(extra_jwk)
  end

  def test_key_encryptor
    secret_jwk = JOSE::JWK.from_binary(SECRET_JWK_JSON)
    key_encryptor = secret_jwk.kty.key_encryptor(secret_jwk.fields, 'test')
    assert_equal 'PBES2-HS256+A128KW', key_encryptor['alg']
  end

end
