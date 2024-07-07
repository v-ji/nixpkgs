{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, nix-update-script
, hatchling
, hatch-requirements-txt
, aiohttp
}:

buildPythonPackage rec {
  pname = "pyytlounge";
  version = "2.0.0";
  pyproject = true;
  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-/Dei7Io4TqstXv2W96LA/WKdPBLWfd56fccS46cjY+0=";
  };

  build-system = [ hatchling hatch-requirements-txt ];
  dependencies = [ aiohttp ];

  pythonImportsCheck = [
    "pyytlounge"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Python YouTube lounge API";
    homepage = "https://github.com/FabioGNR/pyytlounge";
    changelog = "https://github.com/FabioGNR/pyytlounge/releases/tag/v${version}";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ vji ];
  };
}
