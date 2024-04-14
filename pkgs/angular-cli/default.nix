{
  lib,
  mkYarnPackage,
  fetchYarnDeps,
  fetchFromGitHub,
}:
let
  versions = lib.versions;
in
mkYarnPackage rec {
  pname = "angular-cli";
  version = "17.3.4";
  experimentalVersion = "0.${versions.major version}0${versions.minor version}.${versions.patch version}";

  src = fetchFromGitHub {
    owner = "angular";
    repo = "angular-cli";
    rev = "v${version}";
    hash = "sha256-wDGh0TdNPA98hpCCI/OGVX8ChR9T4urvemVB6VF85Yk=";
  };

  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-YNDdYO6T/2ASVhw2I6zKb37f+uCrwV2UIPU6LYMZ6a0=";
  };

  buildPhase = ''
    runHook preBuild

    node tools/ng_cli_schema_generator.js packages/angular/cli/lib/config/workspace-schema.json packages/angular/cli/lib/config/schema.json

    for schema in \
      packages/angular/cli/lib/config/workspace-schema.json \
      packages/angular/cli/src/commands/update/*/schema.json \
      packages/angular_devkit/architect/src/*-schema.json \
      packages/angular_devkit/architect/builders/operator-schema.json \
      packages/angular_devkit/build_angular/src/builders/*/schema.json \
      packages/angular_devkit/schematics_cli/*/schema.json \
      packages/angular/pwa/*/schema.json \
      packages/angular/ssr/schematics/*/schema.json \
      packages/schematics/angular/*/schema.json \
      packages/angular_devkit/build_webpack/src/builders/webpack-dev-server/schema.json \
      packages/angular_devkit/build_webpack/src/builders/webpack/schema.json
    do
      for file in $schema; do
        node --no-deprecation tools/quicktype_runner.js $file ''${file%.json}.ts
      done
    done

    yarn tsc -p tsconfig-build.json

    for file in ls packages/*/*/package.json; do
      substitute $file dist/$file \
        --replace '0.0.0-PLACEHOLDER' ${version} \
        --replace '0.0.0-EXPERIMENTAL-PLACEHOLDER' ${experimentalVersion}
    done

    for file in packages/*/*/bin/*; do
      cp --mkpath $file dist/$file
    done

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,libexec/${pname}}

    mv node_modules $out/libexec/${pname}/node_modules
    mv deps/${pname}/dist/packages/angular/cli/* $out/libexec/${pname}

    for dir in $(ls dist/packages/*/* -d); do
      mv $dir $out/libexec/${pname}/node_modules
    done

    patchShebands --build $out/libexec/${pname}/bin/ng.js

    ls -s $out/libexec/${pname}/bin/ng.js bin/ng

    runHook postInstall
  '';

  doDist = false;
}
