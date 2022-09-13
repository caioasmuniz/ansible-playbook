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

**Work in Progress...**
