
[![Docker Automated build](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg?maxAge=2592000?style=plastic)](https://bitbucket.org/inkytonik/docker-skink)

# docker-skink

Docker image for running the Skink program verification tool from Macquarie University.
Contains Java, Scala, sbt plus auxiliary programs such as SMT solvers (e.g., Z3).
Also contains the [benchexec](https://github.com/sosy-lab/benchexec/blob/master/doc/INDEX.md) framework to run Skink under conditions similar to those of the International Software Verification Competition, including the competition benchmark files.

The Skink archive `skink.tar.gz` used by the Docker file is intended to be a recent snapshot of a Skink working dir so it can approximate what future development will require.
It is used to run sbt to force downloading of dependencies etc at docker build time instead of waiting and slowing things down when the container is used.
The following command can be used to create the snapshot if `skink` is a Skink working directory:

    tar -cvz --exclude '.*' --exclude target -f skink.tar.gz skink
