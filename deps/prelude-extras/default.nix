{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "prelude-extras";
  version = "0.4";
  buildDepends = [ base ];
  homepage = "http://github.com/ekmett/prelude-extras";
  description = "Higher order versions of Prelude classes";
  license = stdenv.lib.licenses.bsd3;
}
