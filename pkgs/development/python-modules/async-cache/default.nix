{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, nix-update-script
}:

buildPythonPackage rec {
  pname = "async-cache";
  version = "1.1.1";
  disabled = pythonOlder "3.3";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-gaqczRn7BnhKrzC9XyBD3Aoj/D6Zi5PQwsF9GvmAM5M=";
  };

  pythonImportsCheck = [
    "cache"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Caching solution for asyncio";
    homepage = "https://github.com/iamsinghrajat/async-cache";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ vji ];
  };
}
