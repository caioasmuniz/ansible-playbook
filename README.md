# Ansible-Playbook

Este repositório contém uma coleção de *scripts*, usando *Ansible*, para o provisionamento de um *home server*. Além disso, também provisionam uma forma de acesso remoto à rede local do usuário, utilizando um serviço de VPN instalado em um servidor na nuvem, como um *VPS - Virtual Private Server*. São provisionados os seguintes serviços:

## Traefik

*Proxy* reverso. Age como ponto de entrada dos pacotes HTTP/HTTPS dos serviços (portas 80 e 443), adicionando funcionalidades à esses serviços, como:

- Suporte à HTTPS para serviços que não o suportam nativamente
- Suporte à autenticação/*SSO* (*Single Sign-On*)
- Redirecionamento automático de HTTP para HTTPS
- Gerenciamento e Auto-renovação de certificados digitais, assinados por *Let's Encrypt*

## Pi-Hole

Servidor *DNS*(*Domain Name System*). Age como um bloqueador de anúncios em toda a rede local, sob o princípio de *DNS sinkhole*, ou seja, envia endereços não-roteáveis para um conjunto específico de domínios, neste caso, provedores de anúncios como, por exemplo, o *Google Ads*.

  Também é utilizado nesta aplicação como um servidor de *DNS* local, sendo capaz de resolver endereços internos da rede local, permitindo o acesso aos serviços utilizando um nome de domínio/subdomínio como `home.lan`, ao invés de um endereço IP como `192.168.10.35`.

## Media Server

Um conjunto de serviços integrados com a função de **requisição**, **obtenção**, **indexação** e **reprodução** de diversos tipos de mídia. Os serviços utilizados, bem como suas respectivas funções na cadeia de gerenciamento de mídia são:

### Jellyseerr

Serviço responsável pela **requisição** dos arquivos de mídia. Através de sua interface, os usuários podem requerir por programas de TV ou filmes à serem obtidos por outros serviços da cadeia.

### Radarr, Sonarr, Lidarr

Os três serviços têm a função de **requisição** e **indexação** dos arquivos de mídia. Isso se baseia na busca em indexadores pelos arquivos requisitados (tanto através da *interface web* da aplicação, quanto de outros serviços, como o **jellyseerr**), de acordo com metados relevantes a aquele tipo de mídia. Cada um dos três aplicativos é focado em um tipo de mídia, sendo estes:

- **Radarr:** Voltado para obtenção de filmes;
- **Lidarr:** Voltado para músicas;
- **Sonarr:** Voltado para séries, seriados, programas de TV e *anime*.

### Prowlarr

Este é o serviço responsável por gerenciar os indexadores utilizados na busca de arquivos nos aplicativos Radarr, Sonarr e Lidarr; proporcionando uma forma centralizada para gerência destes indexadores através de sua **interface web**.

### Transmission

Cliente *BitTorrent*. Na cadeia de gerenciamento de mídia, é o responsável pela **obtenção** dos arquivos encontrados nos serviços Radarr, Sonarr e  Lidarr.

### Jellyfin

Serviço reponsável pela **reprodução** dos títulos já obtidos nas etapas anteriores da cadeia de gerência de mídia. Através de sua *interface web*, os usuários podem pesquisar e reproduzir os títulos de suas bibiliotecas.

**Work in Progress...**
