# A `Dockerfile` for provisioning a build environment for Epidemic

## Introduction

[Epidemic](https://github.com/sseefried/open-epidemic-game) is a game about exponential growth
written in Haskell.

But building it for mobile devices ain't that easy.

Apart from requiring a [GHC](http://haskell.org/ghc) cross-compiler, you must cross-compile
various C libraries and then build cross-compiled versions of all the Haskell libraries which,
unfortunately, doesn't work out of the box for some libraries when installing them with
[Cabal](https://www.haskell.org/cabal/).

So, with tha aid of [Docker](https://www.docker.com) I wrote a Dockerfile to build a fully
fledged Android build environment. This builds on earlier work that I did in the
[`docker-build-ghc-android`](https://github.com/sseefried/docker-build-ghc-android) repo.
`docker-build-ghc-android` just builds a GHC 7.8.3 cross-compiler targetting ARMv7, while this
repo builds all the C and Haskell libraries required to build Epidemic.

In conjunction with [`android-build-epidemic-apk`](https://github.com/sseefried/android-build-epidemic-apk)
you can build an APK for installation on your Android device.

## Installation

### (Optional) Build `debian-wheezy-ghc-android`

You probably only want to do this if for some reason you can't download
`sseefried/debian-wheezy-ghc-android` from the
[Docker Hub](https://registry.hub.docker.com/search?q=library) registry. It's rather large
at 1.1G.

### Build with Docker

At the command line simply type:

    $ docker build .

This will take a while to build. First it must download the Docker image
`sseefried/debian-wheezy-ghc-android` (about 1.1G) and then must download, clone and build
a bunch of libraries. Go get a coffee, drink it, go for a long walk and then come back.
Once it's finished type:

    $ docker images

You will get something like:

    REPOSITORY                            TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    <none>                                <none>              3b16cf90e485        6 minutes ago       5.923 GB
    ...

If you want you can tag the image with something memorable like:

    docker tag <image id> epidemic-build-env

You now have two options for building and installing Epidemic.

### Option A: Build, copy APK and install

You can simply run an interactive shell and build the APK inside a running container.


    $ docker run -it epidemic-build-env /bin/bash
    androidbuilder@283089ad80b9:~/build$ cd android-build-epidemic-apk

Now follow the instructions in the `README.md` [here](https://github.com/sseefried/android-build-epidemic-apk)

The `adb` tool is not installed in the image so once you have built the APK you will want to exit
out of the running container and then copy the APK to your local machine (which presumably has `adb`
installed in it).

In a fresh shell (in another terminal window) type:

     $ docker ps

You'll get something like:

    CONTAINER ID        IMAGE                       COMMAND             CREATED              STATUS                  PORTS               NAMES
    d4a82703a3a9        epidemic-build-env:latest   "/bin/bash"         About a minute ago   Up 57     seconds                           dreamy_ptolemy

This will give you a container ID (`d4a82703a3a9` or `dreamy_ptolemy` here).

     $ docker cp dreamy_ptolemy:/home/androidbuilder/build/android-build-epidemic-apk/bin/com.declarative.games.epidemic.beta-debug.apk .

You can now install this APK with

     $ adb install -r com.declarative.games.epidemic.beta-debug.apk

### Option B: Share a local directory, build, and install

Another option to is checkout [`android-build-epidemic-apk`](https://github.com/sseefried/android-build-epidemic-apk)
locally and then *share* this directory with a running container.

    $ git clone https://github.com/sseefried/android-build-epidemic-apk
    $ docker run -v /local/path/to/android-build-epidemic-apk:/home/androidbuilder/build/android-build-epidemic-apk -it epidemic-build-env /bin/bash

(This will overwrite the directory in the Docker container.)

Now, inside the interactive shell in the running container, follow the instructions in the
`README.md` [here](https://github.com/sseefried/android-build-epidemic-apk)

Once you are done the APK will be in `/local/path/to/android-build-epidemic-apk/bin`, and
you can install it at will with:

     $ adb install -r com.declarative.games.epidemic.beta-debug.apk

## Guiding principles of the Dockerfile

Here I outline some of the guiding principles behind the design of the `Dockerfile`.

* Download specific versions of libraries. Check them against a SHA1 hash.
* cabal install specific versions of libraries
* git clone specific commits of repositories

This way we increase the likelihood that the Docker will complete the build into the future.

### Why so many small scripts?

I call these *scriptlets*. Apart from logically structuring the `Dockerfile` so that each library is
built in isolation, this also means I can take advantage of Docker's cache which is a form of
filesystem checkpointing. See the next question.

### Why do you `ADD` a script just before `RUN`nning it?

This made developing this build script that much easier. While developing a specific *scriptlet* I
didn't want to have to build from the beginning each time a made a small change. Docker's caching of
sub-images meant that I could start building again from the point where a scriptlet changed and know
with 100% certainty that the filesystem was in *exactly* the same state it was the last time I tried
to build from that point. As a consequence the structure of "adding before running" also makes this
`Dockerfile` more maintainable.
