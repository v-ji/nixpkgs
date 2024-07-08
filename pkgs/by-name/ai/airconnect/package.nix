{ stdenv
, lib
, fetchzip
, nix-update-script
}:

let
  platformName = {
    "i686-linux" = "linux-x86";
    "x86_64-linux" = "linux-x86_64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-darwin" = "macos-x86_64";
    "aarch64-darwin" = "macos-arm64";
  }.${stdenv.hostPlatform.system} or null;
  aircast_binary = "aircast-${platformName}-static";
  airupnp_binary = "airupnp-${platformName}-static";
in
stdenv.mkDerivation rec {
  pname = "airconnect";
  version = "1.8.3";

  src = fetchzip {
    url = "https://github.com/philippe44/AirConnect/releases/download/${version}/AirConnect-${version}.zip";
    stripRoot = false;
    hash = "sha256-SX6h0GzeFcWbHrBENrs5WboF8CqGM6Wi+7AJdRXtUQM=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install ${aircast_binary} $out/bin/aircast
    install ${airupnp_binary} $out/bin/airupnp

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {
    # Use GitHub to check for new releases
    extraArgs = [ "--url" "https://github.com/philippe44/AirConnect" ];
  };

  meta = with lib; {
    description = "Use AirPlay to stream to UPnP/Sonos and Chromecast devices";
    homepage = "https://github.com/philippe44/AirConnect";
    license = licenses.mit;
    # "Packages like e2fsprogs that have multiple executables, none of which can be considered the main program, should not set meta.mainProgram."
    # mainProgram = "aircast";
    platforms = [ "i686-linux" "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    maintainers = with maintainers; [ vji ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}

