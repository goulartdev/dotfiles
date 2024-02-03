final: prev:
{
  zj-status = prev.callPackage ./zj-status.nix { };
  vlc = prev.libsForQt5.callPackage ./vlc.nix { };
}
