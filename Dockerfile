FROM debian
RUN apt update
RUN apt install python3.11 python3.11-venv build-essential git curl chrpath -y
RUN curl -sSL https://get.haskellstack.org/ |sh  
RUN useradd -m nonroot
ADD saldo-inflector /home/nonroot/saldo-inflector
ADD saldo-python /home/nonroot/saldo-python
ADD Makefile /home/nonroot/Makefile
RUN chown -R nonroot /home/nonroot
USER nonroot
WORKDIR /home/nonroot
RUN bash -c 'python3 -m venv venv && source venv/bin/activate && pip install --upgrade build wheel'
CMD /usr/bin/bash -c 'source venv/bin/activate; make'
