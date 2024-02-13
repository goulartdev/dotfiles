{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "keyb";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "kencx";
    repo = "keyb";
    rev = "v${version}";
    sha256 = "sha256-XfVYF1fetR3ZZ3n5ozgxaRE/l+AgiLaZy4G/YGDdDyU=";
  };

  vendorHash = "sha256-81x5PcH2rN3x5R5AClRYQwz03agJ0nCX8bFKzWUy84U=";

  ldflags = [
    "-s" "-w"
    "-X main.Version=${version}"
    "-X main.Commit=${version}"
  ];

  meta = with lib; {
    description = "Create and view custom hotkey cheatsheets in the terminal";
    homepage = "https://github.com/kencx/keyb";
    license = licenses.mit;
  };
}
