FROM debian:stable-slim
MAINTAINER OIVAS7572
RUN echo OIVAS7572
COPY . .
COPY requirements.txt .

# If you want to run any other commands use "RUN" before.

RUN apt update > aptud.log && apt install -y wget python3 python3-pip p7zip-full build-essential git > apti.log
RUN python3 -m pip install --no-cache-dir -r requirements.txt > pip.log

RUN git clone https://github.com/official-stockfish/Stockfish.git
WORKDIR /Stockfish/src/
RUN make -j build ARCH=x86-64-sse41-popcnt
WORKDIR ../../
RUN cp /Stockfish/src/stockfish . && rm -r Stockfish && mv stockfish chess-engine


RUN chmod +x chess-engine


CMD python3 lichess-bot.py -u

