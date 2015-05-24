FROM sseefried/debian-wheezy-ghc-android
MAINTAINER sean.seefried@gmail.com

USER androidbuilder
ENV BASE /home/androidbuilder/build
RUN mkdir -p $BASE
WORKDIR $BASE

#
# Add environment script
#
ADD scripts/set-env.sh $BASE/

#
# Build cpufeatures library
#
ADD scripts/build-cpufeatures.sh $BASE/
RUN ./build-cpufeatures.sh

#
# Build zlib
#
# ADD scripts/download-zlib.sh $BASE/
# RUN ./download-zlib.sh $BASE/
# ADD scripts/build-zlib.sh $BASE/
# RUN ./build-zlib.sh

#
# Build libpng
#

ADD scripts/download-libpng.sh $BASE/
RUN ./download-libpng.sh
ADD scripts/build-libpng.sh $BASE/
RUN ./build-libpng.sh

#
# Build pixman
#
ADD scripts/download-pixman.sh $BASE/
RUN ./download-pixman.sh
ADD scripts/build-pixman.sh $BASE/
RUN ./build-pixman.sh

#
# Build freetype
#

ADD scripts/download-freetype.sh $BASE/
RUN ./download-freetype.sh
ADD scripts/build-freetype.sh $BASE/
RUN ./build-freetype.sh


#
# Build cairo
#

ADD scripts/download-cairo.sh $BASE/
RUN ./download-cairo.sh
ADD scripts/build-cairo.sh $BASE/
ADD scripts/locale.h.android $BASE/
RUN ./build-cairo.sh

#
# Build libogg
#

ADD scripts/download-libogg.sh $BASE/
RUN ./download-libogg.sh
ADD scripts/build-libogg.sh $BASE/
RUN ./build-libogg.sh

#
# Build libvorbis
#

ADD scripts/download-libvorbis.sh $BASE/
RUN ./download-libvorbis.sh
ADD scripts/build-libvorbis.sh $BASE/
RUN ./build-libvorbis.sh

#
# Download SDL2 and SDL2_mixer
#
ADD scripts/clone-SDL2-mobile.sh $BASE/
RUN ./clone-SDL2-mobile.sh
ADD scripts/clone-SDL2_mixer-mobile.sh $BASE/
RUN ./clone-SDL2_mixer-mobile.sh
ADD scripts/sdl2-config $BASE/

#
# Build SDL2
#

ADD scripts/build-SDL2-mobile.sh $BASE/
RUN ./build-SDL2-mobile.sh

#
# Build SDL2_mixer
#

ADD scripts/build-SDL2_mixer-mobile.sh $BASE/
RUN ./build-SDL2_mixer-mobile.sh
