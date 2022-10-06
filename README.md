# Ansible-Playbook

Este repositório contém uma coleção de *scripts*, usando *Ansible*, para o provisionamento de um *home server*. Além disso, também provisionam uma forma de acesso remoto à rede local do usuário, utilizando um serviço de VPN instalado em um servidor na nuvem, como um *VPS - Virtual Private Server*.

Para lista de requisitos de *hardware* e instruções de instalação e *setup* do ambiente, acesse [INSTALL.md](INSTALL.md)

Foram utilizadas as seguintes tecnologias para o desenvolvimento dos *scripts*:

## Ansible

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/ansible.png">

Ansible é uma ferramenta de automação para processos de TI, escrita em *Python*, desenvolvida por *Red Hat*, sendo capaz realizar tarefas como configuração de sistemas e implementação de aplicações.Para isso, utiliza-se de uma conexão *OpenSSH* para comunicação com os dispositivos a serem provisionados.

Dentro da arquitetura de Ansible, existem dois agentes de rede, são eles:

### *Control Node* (Nó de Controle)

É o computador responsável por executar as ferramentas de linha de comando de *Ansible*. Neste projeto, este será referido como *Workstation*.

### *Managed Node* (Nó Gerenciado)

Estes são os dispositivos-alvo dos *scripts*, ou seja, os nós a serem gerenciados por *Ansible*. Neste projeto, os *managed nodes* serão o servidor local (*home server*) e o servidor virtual privado (*VPS*).
<br clear="left"/>

## Traefik

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/traefik.png">

*Proxy* reverso. Age como ponto de entrada dos pacotes HTTP/HTTPS dos serviços (portas 80 e 443), adicionando funcionalidades à esses serviços, como:

- Suporte à HTTPS para serviços que não o suportam nativamente
- Suporte à autenticação/*SSO* (*Single Sign-On*)
- Redirecionamento automático de HTTP para HTTPS
- Gerenciamento e Auto-renovação de certificados digitais, assinados por *Let's Encrypt*
<br clear="left"/>

## Pi-Hole

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/pihole.png">

Servidor *DNS*(*Domain Name System*). Age como um bloqueador de anúncios em toda a rede local, sob o princípio de *DNS sinkhole*, ou seja, envia endereços não-roteáveis para um conjunto específico de domínios, neste caso, provedores de anúncios como, por exemplo, o *Google Ads*.

  Também é utilizado nesta aplicação como um servidor de *DNS* local, sendo capaz de resolver endereços internos da rede local, permitindo o acesso aos serviços utilizando um nome de domínio/subdomínio como `home.lan`, ao invés de um endereço IP como `192.168.10.35`.
<br clear="left"/>

## Nextcloud

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/nextcloud.png">

Serviço que opera como uma nuvem privada, sendo um substituto auto-hospedado à serviços como *Google Drive*, *Dropbox* e *iCloud*. Algumas das funções presentes são:

- *Backup* automático de diretórios utilizando clientes do *Nextcloud*, disponíveis para Android, iOS, Windows, Linux e macOS. Com foco no *backup* automático de fotos nos clientes *mobile* (*Android* e *iOS*), funcionalidade parecida com a apresentada por *Google Photos*;

- Função de gerência e sincronização de calendários, contatos e histórico de ligações, através dos protocolos CardDAV, CalDAV e Webcal.

- Presença de uma *interface web* e aplicativos de clientes com uma experiência que remete à de serviços baseados em nuvem como *Google Drive*.
<br clear="left"/>

## Home Assistant

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/home-assistant.png">

Ferramenta voltada para o controle, gerência, integração e automação de casas inteligentes. Seu objetivo é proporcionar uma *interface* para interação com dispositivos *IoT* de forma local, centralizada e privada. Atualmente, a aplicação conta com cerca de 2000 integrações, que adicionam o suporte a diversos serviços/dispositivos através de *Home Assistant*. Exemplos de integrações são:

- Controle de lâmpadas inteligentes através da *interface* do serviço;
- Controle de reprodução de mídia em dispositivos como TVs através do protocolo DLNA;
- Monitoramento e registro de dados de sensores;
- Criação de automações baseadas em eventos capturados através das integrações.
<br clear="left"/>

## Homepage

<img align="left" width="100" src="https://raw.githubusercontent.com/benphelps/homepage/main/public/favicon.ico">

Este serviço apresenta uma *dashboard* em sua *interface web* com *links* para todos os outros serviços hospedados na rede, servindo como um ponto de entrada para estas aplicações, além de funcionar como um "*hub*" do *home server*.
<br clear="left"/>

## Media Server

Um conjunto de serviços integrados com a função de **requisição**, **obtenção**, **indexação** e **reprodução** de diversos tipos de mídia. Os serviços utilizados, bem como suas respectivas funções na cadeia de gerenciamento de mídia são:

### Jellyseerr

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/jellyseerr.png">

Serviço responsável pela **requisição** dos arquivos de mídia. Através de sua interface, os usuários podem requerir por programas de TV ou filmes à serem obtidos por outros serviços da cadeia.
<br clear="left"/>

### Radarr, Sonarr, Lidarr

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/radarr.png">
<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/sonarr.png">
<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/lidarr.png">

Os três serviços têm a função de **requisição** e **indexação** dos arquivos de mídia. Isso se baseia na busca em indexadores pelos arquivos requisitados (tanto através da *interface web* da aplicação, quanto de outros serviços, como o **jellyseerr**), de acordo com metados relevantes a aquele tipo de mídia. Cada um dos três aplicativos é focado em um tipo de mídia, sendo estes:

- **Radarr:** Voltado para obtenção de filmes;
- **Lidarr:** Voltado para músicas;
- **Sonarr:** Voltado para séries, seriados, programas de TV e *anime*.
<br clear="left"/>

### Prowlarr

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/prowlarr.png">

Este é o serviço responsável por gerenciar os indexadores utilizados na busca de arquivos nos aplicativos Radarr, Sonarr e Lidarr; proporcionando uma forma centralizada para gerência destes indexadores através de sua **interface web**.
<br clear="left"/>

### Transmission

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/transmission.png">

Cliente *BitTorrent*. Na cadeia de gerenciamento de mídia, é o responsável pela **obtenção** dos arquivos encontrados através dos serviços Radarr, Sonarr e  Lidarr.
<br clear="left"/>

### Jellyfin

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/jellyfin.png">

Serviço reponsável pela **reprodução** dos títulos já obtidos nas etapas anteriores da cadeia de gerência de mídia. Através de sua *interface web*, os usuários podem pesquisar e reproduzir os títulos de suas bibiliotecas.
<br clear="left"/>

## Acesso Remoto

<img align="left" width="100" src="https://cdn.jsdelivr.net/gh/walkxhub/dashboard-icons/png/wireguard.png">

Como forma de proporcionar uma forma de acesso remoto aos serviços provisionados, permitindo a utilização destes de fora da rede local, é provisonada uma infraestrutura que utiliza o protocolo de tunelamento *Wireguard* para a criação de um *VPN* (*Virtual Private Network*) entre estes dispositivos remotos e a rede local do *home server* através de um "*hub*", hospedado em um serviço de nuvem.

Tal infraestrutura se faz util para o caso de uma conexão à internet do tipo *CG-NAT* (*Carrier Grade NAT*), onde ocorre uma camada de tradução do endereço de rede entre o *gateway* da rede local e o IP público de saída da conexão.

Para a criação deste serviço de *VPN* em um cenário como o descrito no parágrafo anterior, se faz necessária a utilização de uma topologia *"hub and spoke"*, representada na imagem a seguir, os atores desta topologia e suas respectivas funções são:
<br clear="left"/>

<img align="right" src="https://www.procustodibus.com/images/blog/wireguard-topologies/hub-and-spoke-outline.svg">

- O nó à esquerda na imagem representa o *home server*, que age como um "*spoke*" na rede e mantém uma conexão **contínua** com o nó central.

- O nó central na imagem representa o "*hub*" da rede. Este deve ser hospedado em um dispositivo com acesso a um IP público e um *firewall* configurável, de forma a permitir conexões do tipo *inbound* ao dispositivo. Isto é necessário pois este nó será responsável por aceitar conexões externas (para inicação dos túneis de *VPN*) e roteamento dos pacotes entre os nós conectados à rede. É recomendada a utilização de um serviço de *VPS* para a hospedagem deste serviço.

- O nó à direita na imagem representa um dispositivo móvel, localizado fora da rede local, tentando conectar-se ao *home server*. Este também age como um "*spoke*" na topologia, conectado ao *hub* de forma que pacotes destinados à endereços presentes na rede *VPN* são roteados à partir desta. Este pacote é enviado até o *hub* que, por sua vez, roteia este pacote até o *home server* que mantém uma conexão contínua ao *hub*.
<br clear="left"/>
