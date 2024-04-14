{
  nodejs,
  mkYarnPackage,
  fetchYarnDeps,
  fetchFromGitHub,
}:

mkYarnPackage rec {
  pname = "angular-language-server";
  version = "17.3.1";

  src = fetchFromGitHub {
    owner = "angular";
    repo = "vscode-ng-language-service";
    rev = "v${version}";
    hash = "sha256-wDGh0TdNPA98hpCCI/OGVX8ChR9T4urvemVB6VF85Yk=";
  };

  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-YNDdYO6T/2ASVhw2I6zKb37f+uCrwV2UIPU6LYMZ6a0=";
  };

  buildPhase = ''
    runHook preBuild

    yarn --offline tsc -p common/tsconfig.json
    yarn --offline tsc -p server/tsconfig.json

    yarn --offline esbuild \
      --format=cjs \
      --platform=node \
      --sourcemap=external \
      --external:path \
      --footer:js="require = requireOverride" \
      --resolve-extensions=".js" \
      --bundle \
      --outfile=dist/server/banner.js \
      dist/server/src/banner.js

    yarn --offline esbuild \
      --format=cjs \
      --platform=node \
      --sourcemap=external \
      --external:path \
      --external:fs \
      --external:typescript/lib/tsserverlibrary \
      --external:vscode-languageserver \
      --external:vscode-uri \
      --external:jsonrpc \
      --external:vscode-languageserver-textdocument \
      --external:languageservice \
      --resolve-extensions=".js"\
      --banner:js=dist/server/banner.js \
      --bundle \
      --outfile=dist/server/index.js \
      dist/server/src/server.js

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp deps/ng-template/dist/server/index.js $out
    cp deps/ng-template/server/bin/ngserver $out/bin
    substituteInPlace $out/bin/ngserver \
      --replace '/usr/bin/env node' ${nodejs}/bin/node

    runHook postInstall
  '';

  doDist = false;
}
