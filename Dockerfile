FROM nginx:1.17.9

# Copy source code to working directory
COPY index.html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD [ "nginx", "index.html" ]