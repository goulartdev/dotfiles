{
  lib,
  zlib,
  makeWrapper,
  duckdb,
}:
let
  libPath = lib.makeLibraryPath [ zlib ];
in
duckdb.overrideAttrs (old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [ makeWrapper ];
  postInstall =
    old.postInstall or ""
    + ''
      wrapProgram $out/bin/duckdb --prefix "LD_LIBRARY_PATH" : "${libPath}"
    '';
})
