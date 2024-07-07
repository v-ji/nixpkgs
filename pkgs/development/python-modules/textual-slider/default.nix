{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, nix-update-script
, setuptools
, textual
}:

buildPythonPackage rec {
  pname = "textual-slider";
  version = "0.1.2";
  pyproject = true;
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-u2ODMEVZT4SYgHDKJfTh0vOJC04S3OZCWvK0WvJVWDg=";
  };

  build-system = [ setuptools ];
  dependencies = [ textual ];

  pythonImportsCheck = [ "textual_slider" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Textual widget for a simple slider";
    homepage = "https://github.com/TomJGooding/textual-slider";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ vji ];
  };
}
