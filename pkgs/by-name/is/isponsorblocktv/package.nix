{ stdenv
, lib
, fetchFromGitHub
, fetchPypi
, nix-update-script
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "isponsorblocktv";
  version = "2.0.8";
  pyproject = true;
  disabled = python3.pkgs.pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "dmunozv04";
    repo = "iSponsorBlockTV";
    rev = "v${version}";
    hash = "sha256-BtO6KRWgwusmU452r6jA9yS/PST7Y5gstELj5KqEZ/g=";
  };

  build-system = with python3.pkgs; [ hatchling hatch-requirements-txt ];

  # Relax version requirement for textual
  pythonRelaxDeps = [ "textual" ];

  # Remove PyPI argparse depencency, as the project is unmaintained and moved to stdlib
  # See https://github.com/ThomasWaldmann/argparse/
  pythonRemoveDeps = [ "argparse" ];

  dependencies =
    with python3.pkgs;
    [
      aiohttp
      appdirs
      async-cache
      pyytlounge
      rich
      ssdp
      textual
      textual-slider
      xmltodict
    ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "SponsorBlock client for all YouTube TV clients";
    license = lib.licenses.gpl3;
    homepage = "https://github.com/dmunozv04/iSponsorBlockTV/";
    changelog =
      "https://github.com/dmunozv04/iSponsorBlockTV/releases/tag/v${version}";
    mainProgram = "iSponsorBlockTV";
    maintainers = with lib.maintainers; [ vji ];
  };
}
