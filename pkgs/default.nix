final: prev:
{
  # vlc = prev.vlc.override { ffmpeg = prev.ffmpeg_4; };
  keyb = prev.callPackage ./keyb.nix { };
}
