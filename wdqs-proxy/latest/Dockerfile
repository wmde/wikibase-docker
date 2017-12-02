FROM nginx:stable-alpine

COPY entrypoint.sh /entrypoint.sh
COPY wdqs.template /etc/nginx/conf.d/wdqs.template

ENTRYPOINT "/entrypoint.sh"