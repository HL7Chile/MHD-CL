FROM nginx:alpine
ARG IG_VERSION
COPY output /usr/share/nginx/html
COPY output/package.tgz /usr/share/nginx/html/${IG_VERSION}/package.tgz
