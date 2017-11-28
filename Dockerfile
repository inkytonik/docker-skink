# Dockerfile for docker-skink

FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    git \
    mercurial \
    python-pip \
    python3-pip \
    software-properties-common \
    subversion \
    wget \
    unzip

# Install java

RUN apt-get update && apt-get install -y \
   openjdk-8-jdk

# Install sbt
# http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html

RUN echo 'deb https://dl.bintray.com/sbt/debian /' >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
    apt-get update && apt-get install -y \
       sbt

# Install clang

RUN echo 'deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main' >> /etc/apt/sources.list && \
    echo 'deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main' >> /etc/apt/sources.list && \
    wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-get update && apt-get install -y \
        llvm-5.0-dev \
        clang-5.0 && \
    ln -s /usr/bin/clang-5.0 /usr/bin/clang

# Install z3

RUN apt-get install -y z3

# Install Yices

RUN add-apt-repository -y ppa:sri-csl/formal-methods && \
    apt-get update && apt-get install -y \
        yices2

# Install benchexec, including sources to get mergeBenchmarkSets.py
# For released version:
#RUN pip3 install benchexec && \
#    cd /usr/src && \
#    git clone --depth 1 git://github.com/sosy-lab/benchexec.git

# For cutting-edge version:
RUN apt-get install -y python3-lxml && \
    pip3 install git+https://github.com/sosy-lab/benchexec.git && \
    cd /usr/src && \
    git clone --depth 1 git://github.com/sosy-lab/benchexec.git

# Install SV-COMP configuration
# Link to / so /sv-comp paths in bench script work

RUN cd /usr/src && \
    git clone --depth 1 https://github.com/sosy-lab/sv-comp.git && \
    ln -s /usr/src/sv-comp /sv-comp

# Install sv-benchmarks for SV-COMP18 and cutting-edge version
# Link to / so /sv-benchmarks paths in SV-COMP work
# SV-COMP18 ones are used by default but relink /sv-benchmarks to get others:
#   ln -s /usr/src/sv-benchmarks /sv-benchmarks

RUN cd /usr/src && \
    wget -q -O - https://github.com/sosy-lab/sv-benchmarks/archive/svcomp18.tar.gz | tar xvzf - && \
    git clone --depth 1 https://github.com/sosy-lab/sv-benchmarks.git && \
    ln -s /usr/src/sv-benchmarks-svcomp18 /sv-benchmarks

# Install CPAchecker

RUN cd /usr/local/bin && \
    wget https://cpachecker.sosy-lab.org/CPAchecker-1.6.12-svcomp17-unix.tar.bz2 && \
    tar xvjf CPAchecker-1.6.12-svcomp17-unix.tar.bz2 && \
    ln -s CPAchecker-1.6.12-svcomp17-unix CPAchecker

# Install fshell-witness2test

RUN cd /usr/src && \
    apt-get install -y libc6-dev-i386 && \
    git clone https://github.com/tautschnig/fshell-w2t.git && \
    pip install pycparser && \
    cd fshell-w2t && \
    wget https://codeload.github.com/eliben/pycparser/zip/master -O pycparser-master.zip && \
    unzip pycparser-master.zip && \
    cp -rf /usr/src/fshell-w2t/* /usr/local/bin && \
    chmod +x /usr/local/bin/process_witness.py /usr/local/bin/test-gen.sh /usr/local/bin/TestEnvGenerator.pl

# Setup skink-specific stuff
# When running locally for benchexec, Skink working dir will be mounted
# at /skink. Link Test.set to the sv-benchmarks so it can be run relative
# to there.

RUN mkdir /skink && \
    ln -s /skink/Test.set /usr/src/sv-benchmarks/c/Test.set && \
    ln -s /skink/Test.set /usr/src/sv-benchmarks-svcomp18/c/Test.set

WORKDIR /skink
