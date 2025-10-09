LICENSE_FLAGS_ACCEPTED += ""

PACKAGECONFIG:remove = "x264 x265 xvid theora vorbis vpx pulseaudio alsa faac faad opus openssl"

EXTRA_OECONF += "--disable-doc"

