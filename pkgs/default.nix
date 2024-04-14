final: prev:
let
  addPatches =
    pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ patches;
    });
in
{
  zsh-vi-mode = addPatches prev.zsh-vi-mode [ ./zsh-vi-mode-clipboard.patch ];
  angular-language-server = prev.callPackage ./angular-language-server { };
  angular-cli = prev.callPackage ./angular-cli { };
}
