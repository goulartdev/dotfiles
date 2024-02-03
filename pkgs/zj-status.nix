{ 
  fetchFromGitHub, 
  rustPlatform, 
  wasm-pack, 
  rust-bin,
  perl,
  openssl,
  gcc,
  pkg-config
}:

rustPlatform.buildRustPackage rec {
  name = "zjstatus";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "dj95";
    repo = "zjstatus";
    rev = "v${version}";
    sha256 = "sha256-8Q8gMswElfoyt7CL+S3wdpgmUVYm/aRLoGEfqf4fcIU=";
  };

  cargoHash = "sha256-pSlTR4YhFFrw6+VBGPx/6+zUyehw1J1H3WIE8ww7Zyw=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    perl
    openssl
    gcc
    wasm-pack
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" ];
      targets = [ "wasm32-unknown-unknown" ];
    })
  ];

}
