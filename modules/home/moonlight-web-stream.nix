{
  fetchFromGitHub,
  callPackage,
  makeRustPlatform,
  buildNpmPackage,
  # dependencies
  perl,
  cmake,
}: let
  fenix = callPackage (fetchFromGitHub {
    owner = "nix-community";
    repo = "fenix";
    rev = "a1b770adbc3f6c27485d03b90462ec414d4e1ce5";
    hash = "sha256-kIRggXyT8RzijtfvyRIzj+zIDWM2fnCp8t0X4BkkTVc=";
  }) {};

  toolchain = fenix.fromToolchainFile {
    dir = "${src}";
    sha256 = "sha256-S4LusOItdSmt4Z+R5llNu9B3h1Lt+BXQuY9BUnl2xFg=";
  };

  rustPlatform = makeRustPlatform {
    rustc = toolchain;
    cargo = toolchain;
  };

  version = "c2ca85a";
  src = fetchFromGitHub {
    owner = "MrCreativ3001";
    repo = "moonlight-web-stream";
    rev = "c2ca85aa4d3fe739cc19e4563b43a9ba50c24ff3";
    hash = "sha256-nsZq2JHj2fKAcr3oxsvCRn1nN7F0OZ+WpC05heBmfMM=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    src = "${src}";
    hash = "sha256-O48N86i0fYOri7Z+W1eF6tVRevAm6xnJw7v+xPNOuiE=";
  };

  frontend = buildNpmPackage {
    name = "moonlight-web-stream";

    inherit version src cargoDeps;

    configurePhase = "true";

    nativeBuildInputs = [
      perl
      cmake
      toolchain
      rustPlatform.cargoSetupHook
      rustPlatform.bindgenHook
    ];

    buildPhase = ''
      npm run build
    '';

    installPhase = ''
      cp -r dist $out
    '';

    npmDepsHash = "sha256-hT/RM9vdq5CYmZJm0kW0OUos/6uhCvxA8uVxkgFHqZI=";
  };
in
  rustPlatform.buildRustPackage (finalAttrs: {
    name = "moonlight-web-stream";

    inherit version src cargoDeps;

    configurePhase = "true";

    nativeBuildInputs = [
      perl
      cmake
      rustPlatform.bindgenHook
    ];

    postInstall = ''
      cp -r ${frontend} $out/static
    '';
  })
