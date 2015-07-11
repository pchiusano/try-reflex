{ system ? null }:

let extendHaskellPackages = haskellLib: haskellPackages:
      with haskellLib; haskellPackages.override {
      overrides = self: super: {
        reflex = self.callPackage ./reflex {};
        reflex-dom = self.callPackage ./reflex-dom {};
        reflex-todomvc = self.callPackage ./reflex-todomvc {};
        active = overrideCabal super.active (drv: {
          version = "0.1.0.19";
          sha256 = "1zzzrjpfwxzf0zbz8vcnpfqi7djvrfxglhkvw1s6yj5gcblg2rcw";
          doCheck = false;
        });
        thyme = overrideCabal super.thyme (drv: {
          doCheck = false;
        });
        orgmode-parse = overrideCabal super.orgmode-parse (with self; drv: {
          version = "0.1.0.4";
          sha256 = "098zl8nyph459zyla0y2mkqiy78zp74yzadrnwa6xv07i5zs125h";
          buildDepends = [
            aeson attoparsec free hashable text thyme unordered-containers
          ];
          testDepends = [
            aeson attoparsec hashable HUnit tasty tasty-hunit text thyme
            unordered-containers
          ];
          doCheck = false;
        });
        twitter-types = overrideCabal super.twitter-types (drv: {
          doCheck = false;
        });
        twitter-types-lens = overrideCabal super.twitter-types-lens (drv: {
          doCheck = false;
        });
        HaskellForMaths = overrideCabal super.HaskellForMaths (drv: {
          version = "0.4.8";
          sha256 = "0yn2nj6irmj24j1djvnnq26i2lbf9g9x1wdhmcrk519glcn5k64j";
          buildDepends = [ self.semigroups ] ++ drv.buildDepends; # For some reason, without the spurious import of self.semigroups, HaskellForMaths will fail to build the environment for HaskellForMaths on ghcjs (it works on ghc)
        });
      };
    };

  makeReflexPkgSet = nixpkgs: let
      f = extendHaskellPackages nixpkgs.haskell-ng.lib;
    in {
      inherit nixpkgs;
      ghc7101 = f nixpkgs.haskell-ng.packages.ghc7101;
      ghcjs = f nixpkgs.haskell-ng.packages.ghcjs;
    };

  stockNixpkgs = import ./nixpkgs ({
    config.allowUnfree = true;
  } // (if system == null then {} else { inherit system; }));

in makeReflexPkgSet stockNixpkgs
