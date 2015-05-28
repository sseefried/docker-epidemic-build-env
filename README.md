# Guiding principles of the Dockerfile

* Download specific versions of libraries. Check them against a SHA1 hash.
* cabal install specific versions of libraries
* git clone specific commits of repositories

This way we increase the likelihood that the Docker will complete the build into the future.

## Why so many small scripts?

I call these *scriptlets*. Apart from logically structuring the `Dockerfile` so that each library is
built in isolation, this also means I can take advantage of Docker's cache which is a form of
filesystem checkpointing. See the next question.

## Why do you `ADD` a script just before `RUN`nning it?

This made developing this build script that much easier. While developing a specific *scriptlet* I
didn't want to have to build from the beginning each time a made a small change. Docker's caching of
sub-images meant that I could start building again from the point where a scriptlet changed and know
with 100% certainty that the filesystem was in *exactly* the same state it was the last time I tried
to build from that point. As a consequence the structure of "adding before running" also makes this
`Dockerfile` more maintainable.
