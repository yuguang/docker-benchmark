FROM yuguang/benchmark
ADD docker-benchmark /scripts
WORKDIR /scripts
RUN ./setup.sh
RUN ./run.sh
RUN ./collect.sh
