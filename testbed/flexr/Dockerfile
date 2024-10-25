FROM jheo4/flexr:focal

ARG WORK_DIR=/home/newuser/

RUN mkdir -p $WORK_DIR/FleXR/build

WORKDIR $WORK_DIR/FleXR/build

RUN cmake .. && make -j 4

WORKDIR $WORK_DIR/FleXR
