# Instruções para utilização dos *scripts*

## Materiais necessários

Esta coleção de *scripts* é feita com o objetivo de apresentar certa flexibilidade com relação aos serviços à serem provisionados. Desta forma, os requisitos de *hardware* podem variar de acordo com as necessidades e preferências do usuário. Com isto em vista, segue a lista de dispositivos necessários para a utilização dos *scripts*, bem como a especificação do *hardware* utilizado nos testes:

### *Workstation*

Um computador com acesso à internet e conexão *SSH* estabelecida entre os outros dispositivos da lista. Este dispositivo será o nó de controle de *Ansible*, sendo responsável pela execução dos *playbooks* que, por sua vez, se comunicam com a infraestrutura da rede (*home server* e *VPS*) utilizando o protocolo *SSH*. O *hardware* utilizado nos testes é:
  
- Modelo: Notebook *Dell Inspiron* 5402
- *CPU*: *Intel Core* i5-1135G7
- *RAM*: 8 GB de memória *DDR4* à 3200MT/s
- *GPU*: Integrada *Intel Iris Xe Graphics TigerLake-LP GT2*
- Armazenamento:
  - 2 *SSDs* de 256 GB

### *Home Server*

Um computador com acesso à internet (de preferência cabeado), que servirá como *home server*, ou seja, será o servidor que hospedará a maioria dos serviços provisionados. A especificação do *hardware* utilizado nos testes é:
  
- *CPU*: *Intel Core* i5-3330
- *RAM*: 6 GB de memória *DDR3* à 1333MT/s
- *GPU*: *NVIDIA GeForce GT* 710 com 1 GB de *VRAM*
- Armazenamento:
  - 2 *HDDs* de 1 TB
  - 1 *HDD* de 500 GB

### *VPS* (opcional)

Caso o usuário opte pela utilização do serviço de acesso remoto, será necessária a utilização de um dispositivo que que funcionará como intemediário da conexão entre clientes remotos. Para tal, este dispositivo deve ser acessível através de um IP público e possuir um *firewall* configurável, de forma a permitir conexões do tipo *inbound* a algumas de suas portas.

Desta forma, recomenda-se o uso de um serviço de *VPS - virtual private server* (servidor virtual privado) para este caso, pois a maioria dos serviços deste tipo oferecem essas funcionalidades.
  
Para os testes, foi utilizado um *VPS* hospedado utilizando o [plano *Always Free* de *OCI - Oracle Infrastructure*](https://www.oracle.com/cloud/free/). A especificação da instância utilizada nos testes é:

- Virtualização: *KVM - Kernel Virtual Machine*
- *CPU*: *ARM AMPERE* 1 *core OCPU*
- *RAM*: 6 GB
- *Shape*: *VM.Standard.A1.Flex*
- Armazenamento:
  - 47 GB de *Block Storage*

## Preparação do ambiente para execução dos *scripts*

### *Workstation*

Este é o dispositivo responsável por executar os *scripts Ansible*. Portanto, é o único que necessita ter a ferramenta instalada. Além disso, também deve possuir uma conexão *SSH* estabelecida e autenticada tanto com o *home server*, quanto com o *VPS*. Segue-se instruções de instalação do *Ansible* e *setup* de par de chaves para conexão *SSH*.

#### Sistema Operacional

É recomendada a utilização de um sistema operacional do tipo *Linux* para o *workstation* (instalada diretamente em *hardware* ou através de virtualização). Serão apresentadas instruções para instalação em distribuições ***Ubuntu*** e ***Archlinux***.

#### Instalando Ansible

##### Ubuntu

    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible

##### Archlinux

    sudo pacman -S ansible

#### *Setup* de chaves *SSH*

Nesta etapa, será gerado o par de chaves de criptografia assimétrica a ser utilizado para autenticação das conexões *SSH* entre o *workstation* e os outros servidores a serem provisionados.

Um par de chaves pode ser gerado com:

    ssh-keygen -t ed25519

Este comando criará dois arquivos na pasta `~/.ssh`, chamados `id_ed25519` (chave privada, **NUNCA** deve ser compartilhada) e `id_ed25519.pub` (chave pública, pode ser compartilhada sem problema).

Como uma forma de simplificar a configuração das chaves *SSH*, pode-se fazer o *upload* da chave pública (`id_ed25519.pub`) para a plataforma *GitHub*. Isso se fará útil pois esta chave [pode ser importada com facilidade durante a instalação do sistema operacional do *home_server*](link-para-parte-do-tutorial).

O *upload* da chave pública pode ser realizado através do *link*: [GitHub Keys](https://github.com/settings/keys)
