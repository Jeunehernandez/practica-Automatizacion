#!/bin/bash

# Actualizar el sistema
sudo apt-get update

# Instalar Docker
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list'
sudo apt-get update
sudo apt-get install -y docker-ce

# Iniciar el servicio Docker
sudo systemctl start docker
sudo systemctl enable docker

# Instalar Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Crear el Dockerfile y docker-compose.yml
mkdir -p /vagrant/app
cat <<EOF > /vagrant/app/Dockerfile
# Dockerfile
FROM ubuntu:latest

# Actualizar el sistema y instalar dependencias
RUN apt-get update && \\
    apt-get install -y apache2 cowsay

# Crear archivo y carpetas de ejemplo
RUN echo "Este es un archivo de ejemplo" > /var/www/html/index.html && \\
    mkdir /var/www/html/mi_carpeta

# Iniciar el servicio apache en el contenedor
RUN service apache2 start

# Crear un script y ejecutarlo
RUN echo '#!/bin/bash' > /usr/local/bin/mi_script.sh && \\
    echo 'cowsay "Hola desde el contenedor Docker"' >> /usr/local/bin/mi_script.sh && \\
    chmod +x /usr/local/bin/mi_script.sh

# Ejecutar el script
CMD ["/usr/local/bin/mi_script.sh"]
EOF

cat <<EOF > /vagrant/app/docker-compose.yml
# docker-compose.yml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "80:80"
EOF
