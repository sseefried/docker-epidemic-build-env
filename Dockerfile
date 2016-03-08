FROM sseefried/debian-wheezy-ghc-android
MAINTAINER sean.seefried@gmail.com

USER androidbuilder
ENV BASE /home/androidbuilder/build
RUN mkdir -p $BASE
WORKDIR $BASE

#
# Install ant
#

USER root

#
# I live in Australia so change the mirror to one more appropriate
# to where you live.
#
run echo "deb http://mirror.aarnet.edu.au/debian wheezy main" > /etc/apt/sources.list
run echo "deb-src http://mirror.aarnet.edu.au/debian wheezy main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install ant openjdk-6-jdk -y
RUN wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz
RUN cd .. && tar xzf build/android-sdk_r24.2-linux.tgz
RUN chown -R androidbuilder:androidbuilder /home/androidbuilder/android-sdk-linux

# Switch back to androidbuilder user
USER androidbuilder

#
# Add environment script
#
ADD scripts/set-env.sh $BASE/

#
# Install Android SDK platform tools, build tools and API
#
ADD scripts/install-android-sdk-platform-tools.sh $BASE/
RUN ./install-android-sdk-platform-tools.sh
ADD scripts/install-android-sdk-build-tools.sh $BASE/
RUN ./install-android-sdk-build-tools.sh
ADD scripts/install-android-api-12.sh $BASE/
RUN ./install-android-api-12.sh

#
# Build cpufeatures library
#
ADD scripts/build-cpufeatures.sh $BASE/
RUN ./build-cpufeatures.sh

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


#
# Cabal install text-1.2.0.0
#

ADD scripts/cabal-install-text.sh $BASE/
RUN ./cabal-install-text.sh

#
# Cabal install vector-0.10.12.1
#

ADD scripts/cabal-install-vector.sh $BASE/
ADD scripts/vector-0.10.12.1.patch $BASE/
RUN ./cabal-install-vector.sh

#
# Add cabal setup wrapper
#

ADD scripts/arm-linux-androideabi-cabal-setup.sh /home/androidbuilder/.ghc/android-14/arm-linux-androideabi-4.8/bin/

#
# Clone & build hsSDL2
#

ADD scripts/clone-hsSDL2.sh $BASE/
RUN ./clone-hsSDL2.sh
ADD scripts/build-hsSDL2.sh $BASE/
RUN ./build-hsSDL2.sh

#
# Clone & build hs-sdl2-mixer
#

ADD scripts/clone-hs-sdl2-mixer.sh $BASE/
RUN ./clone-hs-sdl2-mixer.sh
ADD scripts/build-hs-sdl2-mixer.sh $BASE/
RUN ./build-hs-sdl2-mixer.sh


#
# cabal install gtk2hs-buildtoosa (for host compiler)
#

ADD scripts/cabal-install-gtk2hs-buildtools.sh $BASE/
RUN ./cabal-install-gtk2hs-buildtools.sh

#
# Build all epidemic dependencies
#

ADD scripts/cabal-install-hs-cairo-dependencies.sh $BASE/
RUN ./cabal-install-hs-cairo-dependencies.sh

#
# Build Cairo Haskell binding
#

ADD scripts/clone-hs-cairo.sh $BASE/
RUN ./clone-hs-cairo.sh
ADD scripts/build-hs-cairo.sh $BASE/
RUN ./build-hs-cairo.sh

#
# Build Haskell Chipmunk binding, Hipmunk
#

ADD scripts/clone-Hipmunk.sh $BASE/
RUN ./clone-Hipmunk.sh
ADD scripts/build-Hipmunk.sh $BASE/
RUN ./build-Hipmunk.sh

#
# Build OpenGLRaw
#

ADD scripts/clone-OpenGLRaw.sh $BASE/
RUN ./clone-OpenGLRaw.sh
ADD scripts/build-OpenGLRaw.sh $BASE/
RUN ./build-OpenGLRaw.sh

#
# Clone Epidemic
#

ADD scripts/clone-epidemic-game.sh $BASE/
RUN ./clone-epidemic-game.sh

#
# Clone android-build-epidemic-apk
#

ADD scripts/clone-android-build-epidemic-apk.sh $BASE/
RUN ./clone-android-build-epidemic-apk.sh
