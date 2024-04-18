{
  buildNpmPackage,
  mkYarnPackage,
  fetchYarnDeps,
  fetchFromGitHub,
}:
let
  version = "17.3.1";
  name = "angular-language-server";
  package = mkYarnPackage rec {
    pname = "${name}-package";
    inherit version;

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
        --external:fs \
        --external:path \
        --external:typescript/lib/tsserverlibrary \
        --external:vscode-languageserver \
        --external:vscode-uri \
        --external:vscode-jsonrpc \
        --external:vscode-languageserver-textdocument \
        --external:vscode-html-languageservice \
        --resolve-extensions=".js"\
        --banner:js="$(cat ./deps/ng-template/dist/server/banner.js)" \
        --bundle \
        --outfile=dist/server/index.js \
        dist/server/src/server.js

      cat deps/ng-template/server/package.json \
        | sed s/0.0.0-PLACEHOLDER/17.3.1/ > deps/ng-template/dist/server/package.json

      cp -r deps/ng-template/server/bin deps/ng-template/dist/server/bin

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/server
      mv deps/ng-template/dist/server/{index.js,package.json,bin} $out/server

      runHook postInstall
    '';

    doDist = false;
  };
in
buildNpmPackage {
  pname = name;
  inherit version;

  src = "${package}/server";

  npmDepsHash = "sha256-17kSwCucqZt7PiioFdtj+mI67osHAQGfjO9B6wDmL0s=";

  postPatch = ''
    cp ${./package-lock.json} ./package-lock.json
  '';

  npmInstallFlags = [ "--omit dev" ];

  dontNpmBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,lib/${name}}
    mv * "$out/lib/${name}"
    ln -s $out/lib/${name}/bin/ngserver $out/bin/ngserver
    chmod 555 $out/lib/${name}/bin/ngserver

    patchShebangs --build $out/lib/${name}/bin/ngserver

    runHook postInstall
  '';

  doDist = false;
}
