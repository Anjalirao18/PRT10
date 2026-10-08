FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

RUN echo '<html><body><h1>PRT - CI/CD Completed Successfully</h1></body></html>' > /usr/share/nginx/html/index.html

EXPOSE 80
