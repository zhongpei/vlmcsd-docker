FROM alpine:3.12 as builder
WORKDIR /root
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache git make build-base 
RUN git clone --branch master --single-branch https://github.com/Wind4/vlmcsd.git 
RUN cd vlmcsd/ && make

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
EXPOSE 1688/tcp
CMD [ "/usr/bin/vlmcsd", "-D", "-d" ]
