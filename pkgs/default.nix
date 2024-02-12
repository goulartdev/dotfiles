final: prev:
{
  vlc = prev.vlc.override { ffmpeg = prev.ffmpeg_4; };
}
