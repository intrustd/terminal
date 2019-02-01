{ libwebsockets, openssl, json_c, libuv, pkgconfig, cmake, xxd, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "ttyd-${version}";
  version = "1.4.2";

  src = fetchFromGitHub {
    owner = "tsl0922";
    repo = "ttyd";
    rev = version;
    sha256 = "119c3whq3yl3kiyk39lj0plhq62jvcrmas7zpdfbbjw1vrjmg6gj";
  };

  buildInputs = [ libwebsockets openssl json_c libuv ];
  nativeBuildInputs = [ cmake pkgconfig xxd ];

  meta = with stdenv.lib; {
    description = "Expose a TTY over websockets";
    homepage = https://github.com/tsl0922/ttyd/releases;
    license = licenses.mit;
  };
}
