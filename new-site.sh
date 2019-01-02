#!/bin/bash

# --------------------------------------------------------------
# Este script foi criado visando facilitar a criação de 
# virtualhosts no ambiente de desenvolvimento local.
#
# @author Eliel de Paula <dev@elieldepaula.com.br>
# @license MIT
# --------------------------------------------------------------

echo "Informe o nome do arquivo de configuração (exemplo.conf)"
read filename;

echo "Informe o server-name:"
read server_name;

echo "Informe o diretório público do site:"
read public_directory;

echo "Deseja ativar o site agora? (s ou n)"
read enable_site;

# Processa a criação do arquivo do apache.

cat > "/etc/apache2/sites-available/"$filename << EOF
<VirtualHost *:80>

  # Script gerado pelo configurador de virtualhosts.

	ServerName $server_name 
	ServerAdmin dev@elieldepaula.com.br
	DocumentRoot /home/elieldepaula/Sites/VIRTUALHOSTS/$public_directory
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
EOF

if [ $enable_site == "s" ];
then

  # Ativa o site. 
  
  echo "Ativando o site...";
  echo "127.0.0.1       $server_name" >> /etc/hosts
  
  a2ensite $filename

  echo " ";

  service apache2 restart

  echo "Site criado com sucesso.";

  echo " ";

else 
  echo "Encerrando o script.";
fi

