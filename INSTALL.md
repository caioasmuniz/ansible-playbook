# Instruções para utilização dos *scripts*

## Tipo de conexão à *internet*

Para a utilização do serviço de acesso remoto, é necessário que o dispositivo que hospede este serviço seja acessível pela internet através de um IP público e possua um *firewall* configurável, de forma a permitir conexões do tipo *inbound* a algumas portas específicas. A depender do tipo de conexão à internet local do usuário, o serviço pode ser instalado no próprio servidor local, ou em um servidor secundário, hospedado na nuvem, que servirá como ponto de entrada da rede.

### IP dinâmico

Caso o endereço IP da interface *WAN* do roteador da rede local seja igual ao IP público do usuário (o IP público pode ser checado através do site: [whatismypublicip.com](https://www.whatismypublicip.com/)), a conexão à internet é do tipo **IP dinâmico**.
Neste caso, o serviço de *VPN* pode ser instalado no próprio servidor local, dispensando o uso do servidor secundário.

### *CG-NAT*

Caso o endereço *WAN* do roteador diferente do IP público do usuário, a conexão à internet é do tipo ***CG-NAT*** (*Carrier Grade NAT*). Isto significa que ocorre ao menos uma camada de tradução de endereço de rede entre o roteador local e o IP público do usuário, impedindo que os dispositivos sejam acessíveis por conexões externas.

Uma forma de contornar este problema é através da hospedagem do serviço de *VPN* em um servidor em nuvem, acessivel através de um IP público e o estabelecimento de uma conexão persistente, utilizando um túnel *VPN*, entre este e o servidor local. Desta forma, clientes conectados ao serviço de *VPN* podem acessar a rede local de forma remota, utilizando o servidor em nuvem como intermediário da conexão.

## *Hardware* necessário

Esta coleção de *scripts* é feita com o objetivo de apresentar certa flexibilidade com relação aos serviços à serem provisionados. Desta forma, os requisitos de *hardware* podem variar de acordo com as necessidades e preferências do usuário. Com isto em vista, segue a lista de dispositivos necessários para a utilização dos *scripts*, bem como a especificação do *hardware* utilizado nos testes:

### *Workstation*

Um computador utilizando um sistema operacional *Linux* (serão apresentadas instruções para instalação em distribuições *Ubuntu* e *Archlinux*); com acesso à internet e conexão *SSH* estabelecida entre os outros dispositivos da lista. Este dispositivo será o nó de controle de *Ansible*, sendo responsável pela execução dos *playbooks* que, por sua vez, se comunicam com a infraestrutura da rede (*home server* e *VPS*) utilizando o protocolo *SSH*. O *hardware* utilizado nos testes é:
  
- Modelo: Notebook *Dell Inspiron* 5402
- Sistema Operacional: *ArchLinux*
- *CPU*: *Intel Core i5-1135G7*
- *RAM*: 8 GB de memória *DDR4* à 3200MT/s
- *GPU*: *Intel Iris Xe Graphics TigerLake-LP GT2*
- Armazenamento:
  - 2 *SSD*s de 256 GB

### *Home Server*

Um computador utilizando um sistema operacional *Linux* (serão apresentadas instruções para instalação em distribuições *Ubuntu* e *Archlinux*); com acesso à internet (de preferência cabeado), que servirá como servidor local, responsável pela hospedagem dos serviços provisionados. A especificação do *hardware* utilizado nos testes é:
  
- Sistema Operacional: *ArchLinux*
- *CPU*: *Intel Core* i5-3330
- *RAM*: 6 GB de memória *DDR3* à 1333MT/s
- *GPU*: *NVIDIA GeForce GT* 710 com 1 GB de *VRAM*
- Armazenamento:
  - 2 *HDDs* de 1 TB
  - 1 *HDD* de 500 GB

### *VPS* (opcional)

Servidor hospedado em nuvem responsável pela hospedagem do serviço de *VPN* caso a conexão à internet local do usuário seja do tipo *CG-NAT*.

Neste projeto, optou-se pela utilização de um servidor virtual privado (também conhecido pela sigla em inglês *VPS - virtual private server*) hospedado utilizando o plano **sempre gratuito** de *OCI - Oracle Cloud Infrastructure*.

#### Instruções para o provisionamento de uma instância em *OCI*

1. Criar uma conta em *OCI* através do link: [signup.cloud.oracle.com](https://signup.cloud.oracle.com)

2. Inicializar uma nova instância em: [cloud.oracle.com/compute/instances/create](https://cloud.oracle.com/compute/instances/create), as configurações recomendadas para esta são:
    - **Imagem:** *Canonical Ubuntu* 22.04
    - **Forma:** *Ampere* VM.Standard.A1.Flex
      - **OCPU**: 1
      - **Memória**: 1GB
    - **Adicionar chaves *SSH***: Copiar chave pública `id_ed25519.pub`, gerada em: [geração de chaves](#setup-de-chaves-ssh)

3. Acessar o painel de configurações de rede em: [cloud.oracle.com/networking/vcn](https://cloud.oracle.com/networking/vcn)

A especificação da instância utilizada nos testes é:

- Virtualização: *KVM - Kernel Virtual Machine*
- Sistema Operacional: *Ubuntu 22.04.1 LTS aarch64*
- *CPU*: *ARM AMPERE* 1 *core OCPU*
- *RAM*: 6 GB
- *Shape*: *VM.Standard.A1.Flex*
- Armazenamento:
  - 47 GB de *Block Storage*

## Preparação do ambiente para execução dos *scripts*

### *Workstation*

Este é o dispositivo responsável por executar os *scripts Ansible*. Portanto, é o único que necessita ter a ferramenta instalada. Além disso, também deve possuir uma conexão *SSH* estabelecida e autenticada tanto com o *home server*, quanto com o *VPS*. Segue-se instruções de instalação do *Ansible* e *setup* de par de chaves para conexão *SSH*.

#### Instalando pacotes necessários

##### Ubuntu

    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible git ssh

##### Archlinux

    sudo pacman -S ansible git openssh

#### Configuração de chaves *SSH*

Nesta etapa, será gerado o par de chaves de criptografia assimétrica a ser utilizado para autenticação das conexões *SSH* entre o *workstation* e os outros servidores a serem provisionados.

Um par de chaves pode ser gerado com:

    ssh-keygen -t ed25519

Este comando criará dois arquivos na pasta `~/.ssh`, chamados `id_ed25519` (chave privada, que não deve ser compartilhada) e `id_ed25519.pub` (chave pública, pode ser compartilhada).

Como uma forma de simplificar a configuração das chaves *SSH*, pode-se fazer o *upload* da chave pública (`id_ed25519.pub`) para a plataforma *GitHub*. Isso se fará útil pois esta chave [pode ser importada com facilidade durante a instalação do sistema operacional do *home_server*](link-para-parte-do-tutorial).

O *upload* da chave pública pode ser realizado através do *link*: [GitHub Keys](https://github.com/settings/keys)

#### *Download* do repositório com os *scripts*

Em um terminal, clonar o repositório utilizando:

    git clone https://github.com/caioasmuniz/ansible-playbook.git
    cd ansible-playbook

Criar um arquivo `inventory.yml` a partir do modelo `inventory.yml.example` utilizando:

    cp inventory.yml.example inventory.yml

Editar o arquivo `inventory.yml`, alterando os campos indicados de acordo com o ambiente de execução, seguindo as instruções presentes nos comentários de cada campo.

``` yaml
# inventory.yml.example
all:
  vars:
    auth_credentials: # name:hashed-password formated string for traefik's basicAuth middleware (used to access traefik's, wireguard-server's and vaultwarden's dashboards). Generate with: htpasswd -n user
    # example format caio:$apr1$uqKQpe59$5wAjFRqzcOpUhUvhHLjp8.
    email: # email used in traefik's HTTPS certificate 
    duckdns_token: # token used to verify duckdns' domain ownership through DNS challenge for CA-signed certificate
    duckdns_domain: # subdomain registered on duckdns to be used
  hosts:
    vps:
      ansible_user: # user to be used by ansible to login via SSH to this host
      ansible_host: # Host IP of the device to be used by ansible to login via SSH
      domain_name: "{{ duckdns_domain }}.duckdns.org" # the desired domain name used for accessing the services in this host, it defaults to using the supplied duckdns_domain
      docker_dir: /docker/config # path to directory to store the deployed services settings 
    home_server:
      ansible_user: # user to be used by ansible to login via SSH to this host
      ansible_host: # Host IP of the device to be used by ansible to login via SSH
      domain_name: "local.{{ duckdns_domain }}.duckdns.org" # the desired domain name used for accessing the services in this host, it defaults to using the supplied duckdns_domain
      media_dir: "/home/{{ ansible_user }}/library" # path to directory to store media files for the media server related services (bazarr, lidarr, sonarr, radarr, transmission and jellyfin)
      docker_dir: "/home/{{ ansible_user }}/.config" # path to directory to store the deployed services settings
      extra_hosts: # other devices/services the user would like to be able to access through either the supplied domain_name (by adding a DNS record for it on Pi-hole) or  server's home dashboard.
        - host: # Host IP of the device 
          domain_name: router.{{ domain_name }} # desired domain_name to be used for this host 
          display_name: "OpenWRT Main" # name displayed on homepage's dashboard for this host 
          description: "LuCI Dashboard for Primary Router" #description displayed on homepage's dashboard for this host 
          icon: "openwrt" # NAME of the icon to be used on homepage on this host available icons present in ttps://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/png
```
