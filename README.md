# A `Dockerfile` for provisioning a build environment for Epidemic

## Introduction

[Epidemic](https://github.com/sseefried/open-epidemic-game) is a game about exponential growth
written in Haskell.

But building it for mobile devices ain't that easy.

Apart from requiring a [GHC](http://haskell.org/ghc) cross-compiler, you must cross-compile
various C libraries and then build cross-compiled versions of all the Haskell libraries which,
unfortunately, doesn't work out of the box for some libraries when installing them with
[Cabal](https://www.haskell.org/cabal/).

So, with the aid of [Docker](https://www.docker.com) I wrote a script to build a fully
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

Follow the instruction in the `README.md` [here](https://github.com/sseefried/docker-build-ghc-android).

Once you've done that you'll need to tag the resulting image as `sseefried/debian-wheezy-ghc-android`
locally to build the image this `Dockerfile` specifies.

### Build with Docker

At the command line simply type:

    $ docker build .

This will take a while to build. First, unless you performed the previous step, Docker must download
the image `sseefried/debian-wheezy-ghc-android` (about 1.1G). It will then download, clone and build
a bunch of libraries. Go get a coffee, drink it slowly, go for a long walk and then come back.
Once it's finished type:

    $ docker images

You will get something like:

    REPOSITORY                            TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    <none>                                <none>              3b16cf90e485        6 minutes ago       5.923 GB
    ...

You can tag the image with something memorable like:

    docker tag <image id> epidemic-build-env

You now have two options for building and installing Epidemic.

### Option A: Build, copy APK and install

You can simply run an interactive shell and build the APK inside a running container.


    $ docker run -it epidemic-build-env /bin/bash
    androidbuilder@283089ad80b9:~/build$ cd android-build-epidemic-apk

Now follow the instructions in the `README.md` [here](https://github.com/sseefried/android-build-epidemic-apk)

The `adb` tool is not installed in the image so once you have built the APK you will want to
copy the APK to your local machine (which presumably has `adb` installed in it).

Keep the container running. In a fresh shell (in another terminal window) type:

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
you can install it with:

     $ adb install -r com.declarative.games.epidemic.beta-debug.apk

## Want to help beta test the game?

Actually, the version of the game I've released will not be the final version. If you'd like
to stay in the loop then subscribe below.

```html
<!-- Begin MailChimp Signup Form -->
<link href="//cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
  #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
  /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
     We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="//declarative-games.us11.list-manage.com/subscribe/post?u=54d0f22bae13c26ce91e01dc9&amp;id=b1b16cbaf1" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <div id="mc_embed_signup_scroll">
  <label for="mce-EMAIL">Subscribe to receive updates on Epidemic</label>
  <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="email address" required>
    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
    <div style="position: absolute; left: -5000px;"><input type="text" name="b_54d0f22bae13c26ce91e01dc9_b1b16cbaf1" tabindex="-1" value=""></div>
    <div class="clear"><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button"></div>
    </div>
</form>
</div>
```

<!--End mc_embed_signup-->




## Guiding principles of the Dockerfile

Here I outline some of the guiding principles behind the design of the `Dockerfile`.

* Download specific versions of libraries. Check them against a SHA1 hash.
* `cabal install` specific versions of libraries
* `git clone` specific commits of repositories

This way we increase the likelihood that Docker will complete the build into the future.

### Why so many small scripts?

I call these *scriptlets*. Apart from logically structuring the `Dockerfile` so that each library is
built in isolation, this also means I can take advantage of Docker's cache which is a form of
filesystem checkpointing. See a blog
[post](http://lambdalog.seanseefried.com/posts/2014-12-12-docker-build-scripts.html) I wrote on
this. Also see the next question.

### Why do you `ADD` a script just before `RUN`ning it?

This made developing this build script that much easier. While developing a specific *scriptlet* I
didn't want to have to build from the beginning each time I made a small change. Docker's caching of
sub-images meant that I could start building again from the point where a scriptlet changed and know
with 100% certainty that the filesystem was in *exactly* the same state it was the last time I tried
to build from that point. As a consequence the structure of "adding just before running" also makes this
`Dockerfile` more maintainable.
