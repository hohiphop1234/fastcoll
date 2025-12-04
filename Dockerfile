FROM brimstone/debian:sid AS builder

RUN apt-get update && apt-get install -y build-essential libboost-all-dev

COPY . /fastcoll

WORKDIR /fastcoll

RUN g++ -O3 -DBOOST_TIMER_ENABLE_DEPRECATED *.cpp -lboost_filesystem -lboost_program_options -lboost_system \
    -o fastcoll -static \
 && strip fastcoll

FROM scratch

COPY --from=builder /fastcoll/fastcoll /fastcoll

ENTRYPOINT ["/fastcoll"]
