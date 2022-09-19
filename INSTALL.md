# Instruções para utilização dos *scripts*

## 1. Materiais necessários

Esta coleção de *scripts* é feita com o objetivo de apresentar certa flexibilidade com relação aos serviços à serem provisionados. Desta forma, os requisitos de *hardware* necessários podem variar de acordo com as necessidades e preferências do usuário. Com isto em vista, segue a lista de dispositivos necessários para a utilização dos *scripts*, bem como as especificações de *hardware* dos mesmos, utilizadas nos testes:

- Um computador com acesso à internet (de preferência cabeado), que servirá como *home server*. A especificação do *hardware* utilizado nos testes é:
  
  - *CPU*: *Intel Core* i5-3330
  - *RAM*: 6 GB de memória *DDR3* à 1333MT/s
  - *GPU*: *NVIDIA GeForce GT* 710 com 1 GB de *VRAM*
  - Armazenamento:
    - 2 *HDDs* de 1 TB
    - 1 *HDD* de 500 GB

- Um computador com acesso à internet e conexão *SSH* estabelecida entre os outros dispositivos da lista. Este dispositivo será o responsável pela execução dos *playbooks* de *ansible*, que por sua vez, se comunicam com a infraestrutura da rede (*home server* e *VPS*) utilizando o protocolo *SSH*. O *hardware* utilizado nos testes é:
  
  - Modelo: Notebook *Dell Inspiron* 5402
  - *CPU*: *Intel Core* i5-1135G7
  - *RAM*: 8 GB de memória *DDR4* à 3200MT/s
  - *GPU*: Integrada *Intel Iris Xe Graphics TigerLake-LP GT2*
  - Armazenamento:
    - 2 *SSDs* de 256 GB

- Caso o usuário opte pela utilização do serviço de acesso remoto, será necessária a utilização de um dispositivo que que funcionará como intemediário da conexão entre clientes remotos e o *home server*. Para isso, este dispositivo ser acessível através de um IP público e possuir um *firewall* configurável, de forma a permitir conexões do tipo *inbound* a algumas de suas portas.

  Desta forma, recomenda-se o uso de um serviço de *VPS - virtual private server* (servidor virtual privado) para este caso, pois a maioria dos serviços deste tipo oferecem essas funcionalidades.
  
  Para os testes, foi utilizado um *VPS* hospedado utilizando o [plano *Always Free* de *OCI - Oracle Infrastructure*](https://www.oracle.com/cloud/free/). A especificação da instância utilizada nos testes é:

  - Virtualização: *KVM - Kernel Virtual Machine*
  - *CPU*: *ARM AMPERE* 1 *core OCPU*
  - *RAM*: 6 GB
  - *Shape*: *VM.Standard.A1.Flex*
  - Armazenamento:
    - 47 GB de *Block Storage*
