{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, nix-update-script
  # build dependencies
, setuptools
  # dependencies
, requests
}:

buildPythonPackage rec {
  pname = "pydracor";
  version = "2.0.0";
  pyproject = true;
  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-7W3J1CTP/6s9kYb3o870ovtnKqTY2dy+O7CY247ZQeI=";
  };

  build-system = [ setuptools ];
  dependencies = [ requests ];

  # Disable tests because all of them touch the network
  doCheck = false;

  pythonImportsCheck = [
    "pydracor"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Python package which provides access to the DraCor API";
    homepage = "https://github.com/dracor-org/pydracor";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ vji ];
  };
}
