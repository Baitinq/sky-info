{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, astro, base, hpack, lib }:
      mkDerivation {
        pname = "sky-info";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [ astro base ];
        libraryToolDepends = [ hpack ];
        executableHaskellDepends = [ astro base ];
        testHaskellDepends = [ astro base ];
        prePatch = "hpack";
        homepage = "https://github.com/githubuser/sky-info#readme";
        license = lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in
  drv.env
