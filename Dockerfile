FROM fedora
RUN dnf install -y fio jq

COPY /fio-rand-RW*.fio /run_fio.sh /workdir/

RUN mkdir /cow/ && \
    chgrp -R 0 /cow/ && \
    chmod -R g+rwX /cow/

RUN chgrp -R 0 /workdir/ && \
    chmod -R g+rwX /workdir/ && \ 
    chmod 777 /workdir/run_fio.sh

WORKDIR /workdir

ENTRYPOINT ["fio"]
CMD ["--output", "/emptydir/fio.out.json", "--output-format=json", "/fio/fio-rand-RW.fio"]
