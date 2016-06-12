FROM f69m/ubuntu32
ADD . /code
WORKDIR /code
RUN ./setup.sh
RUN ./run.sh
RUN ./collect.sh
