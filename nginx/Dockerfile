FROM nginx

WORKDIR /etc/nginx

COPY ["./nginx/api_gateway.conf", "./nginx/api_json_errors.conf", "./nginx/keys.conf", "./nginx/nginx.conf", "./nginx/upstreams.conf", "./"]
COPY ./nginx/conf.d ./conf.d

RUN apt-get update && apt-get install vim openssl -y
RUN rm -f ./conf.d/default.conf
RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=oke/PU=dxdev3/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt

RUN mv localhost.dev.crt /etc/ssl/certs/
RUN mv localhost.dev.key /etc/ssl/private/
RUN chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key

RUN ln -sf /dev/stdout /var/log/nginx/access.log \ 
  && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]