FROM yuguang/benchmark
ADD . /scripts
WORKDIR /scripts
RUN chmod +x *.sh
