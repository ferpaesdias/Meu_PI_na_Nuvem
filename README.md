# Meu PI (Projeto Integrador) na nuvem

<br />

Projetinho para mostrar para os meu queridos alunos como usar o Terraform para colocar o Projeto Integrador no Microsoft Azure.
O PI é um projeto onde os alunos criaram um sistema em PHP com o banco de dados MariaDB.

Neste projeto, o Terraform irá criar 02 máquinas virtuais: uma para o serviço Web e outra para o banco de dados. Quando terminar a execução do Terraform o sistema já estará instalado e será exibido o seu link de acesso.

<br/>

As VMs e o MS Azure serão configuradas das seguinte forma:

- VM 01
  - **Sistema Operacional**: Debian 12 (Bookworm)
  - **Tamanho das VMs**: B1ms (01 vCPU e 02 MB RAM)
  - **Hostname**: server01
  - **Serviços**: Nginx e PHP
  - **IP Interno**: 10.0.0.4  
   
<br/>

- VM 02
  - **Sistema Operacional**: Debian 12 (Bookworm)
  - **Tamanho das VMs**: B1ms (01 vCPU e 02 MB RAM)
  - **Hostname**: server02
  - **Serviços**: MariaDB
  - **IP Interno**: 10.0.0.5

<br/>

- Recursos do MS Azure:
  - **Nome das VMs:**: vm_meuprojeto_server01 e vm_meuprojeto_server02
  - **IPs Públicos**: ippublic_meuprojeto_server01 e ippublic_meuprojeto_server02
  - **Resource Group**: rg_meuprojeto
  - **VNet**: vnet_meuprojeto
  - **Subrede**: subnet_meuprojeto
  - **Placas de rede**: nic_meuprojeto_server01 e nic_meuprojeto_server02
  - **NSG**: nsg_meuprojeto


Nas VMs, a porta 22 (SSH) será alterada para 2222 devido às restrições de acesso impostas pela entidade (escola).

<br/>

> [!NOTE]
> No Microsoft Azure, ao invés de VMs, poderíamos usar recursos PaaS como o **App Services** e o **Azure Database for MySQL flexible servers** mas, neste projeto pretendo usar VMs devido ao conteúdo utilizado em sala de aula. Em outra oportunidade usaremos recursos PaaS. 

<br/>


## Modo de uso

Antes de começar, você precisa criar uma chave pública/privada para acessar as VMs via SSH. No Linux, use o comando abaixo para criar o par de chaves pública/privada:

```bash
ssh-keygen -m PEM -N '' -f ~/.ssh/id_rsa
``` 

