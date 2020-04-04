FROM nginx:1.17.9

RUN rm /usr/share/nginx/html/index.html

# Copy source code to working directory
COPY index.html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD [ "nginx", "index.html" ]