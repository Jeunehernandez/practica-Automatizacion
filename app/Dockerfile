# Dockerfile
FROM ubuntu:latest

# Actualizar el sistema y instalar dependencias
RUN apt-get update && \
    apt-get install -y apache2 cowsay

# Crear archivo y carpetas de ejemplo
RUN echo "Este es un archivo de ejemplo" > /var/www/html/index.html && \
    mkdir /var/www/html/mi_carpeta

# Iniciar el servicio apache en el contenedor
RUN service apache2 start

# Crear un script y ejecutarlo
RUN echo '#!/bin/bash' > /usr/local/bin/mi_script.sh && \
    echo 'cowsay "Hola desde el contenedor Docker"' >> /usr/local/bin/mi_script.sh && \
    chmod +x /usr/local/bin/mi_script.sh

# Ejecutar el script
CMD ["/usr/local/bin/mi_script.sh"]
