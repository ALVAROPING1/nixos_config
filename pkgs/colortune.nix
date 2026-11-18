{
  python3Packages,
  fetchFromGitHub,
  qt5,
}:

python3Packages.buildPythonApplication rec {
  pname = "colortune";
  version = "1.0.0";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "Xtratter";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-0zEzoOVvFx6AuzTdXawlfpedSZ4TACJ+k38wXI/+QV0=";
  };

  propagatedBuildInputs = [
    python3Packages.pyqt5
    qt5.wrapQtAppsHook
  ];

  dontBuild = true;
  postPatch = ''
    substituteInPlace "src/${pname}" \
      --replace "'Гамма', 50, 150" "'Gamma', 10, 500" \
      --replace 'Насыщенность' 'Saturation' \
      --replace 'Сброс' 'Reset'
  '';
  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "Small GUI utility to adjust gamma and saturation of the screen on KDE Plasma 6 (Wayland)";
    homepage = "https://github.com/Xtratter/${pname}";
    changelog = "https://github.com/Xtratter/${pname}/releases/tag/v${version}";
  };
}
