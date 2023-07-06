#node构建
FROM node:16.17.0 as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

#nginx 发布
FROM nginx
WORKDIR /app
COPY --from=build /app/dist /usr/share/nginx/html
RUN echo 'echo init ok!!'
EXPOSE 80
ENTRYPOINT nginx -g "daemon off;"