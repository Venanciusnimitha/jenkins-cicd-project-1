# Use official HTTPD image
FROM httpd:latest

# Copy index.html to the Apache directory
COPY index.html /usr/local/apache2/htdocs/

# Run HTTPD in the foreground
CMD ["httpd-foreground"]

