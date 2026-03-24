{ config, pkgs, ... }: let 
  moonlight-web-stream = pkgs.callPackage ./moonlight-web-stream.nix {};
in {
  config = {
    xdg.dataFile."moonlight-web-stream/static".source = "${moonlight-web-stream}/static";
    
    home.packages = [
      (pkgs.stdenv.mkDerivation {
        name = "mws";
        src = null;
        unpackPhase = "true";
        nativeBuildInputs = [pkgs.makeWrapper];
        installPhase = ''
          makeWrapper "${moonlight-web-stream}/bin/web-server" $out/bin/mws \
            --run "mkdir --parents ${config.xdg.dataHome}/.local/share/moonlight-web-stream" \
            --chdir "${config.xdg.dataHome}/.local/share/moonlight-web-stream"
        '';
      })
    ];
  };
}
