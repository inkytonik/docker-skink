# docker-skink

[![Docker Automated build](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg?maxAge=2592000?style=plastic)](https://bitbucket.org/inkytonik/docker-skink)

Docker image for running the Skink program verification tool from Macquarie University.
Contains Java, Scala, sbt plus auxiliary programs such as SMT solvers (e.g., Z3).
Also contains the [benchexec](https://github.com/sosy-lab/benchexec/blob/master/doc/INDEX.md) framework to run Skink under conditions similar to those of the International Software Verification Competition, including the competition benchmark files.

The project `skinklike` is a minimal Scala project that contains all of the Skink dependencies.
We use it to get these dependencies loaded at Docker build time, rather than having to do it in each container created from the image.
