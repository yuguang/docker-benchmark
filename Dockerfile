FROM m0elnx/ubuntu-32bit
ADD . /code
WORKDIR /code
RUN ./setup.sh
RUN ./run.sh
RUN ./collect.sh
