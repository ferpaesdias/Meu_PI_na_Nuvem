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

---

<br/>

## Pré-requisitos e criação do ambiente

- Ter o [Terraform instalado](https://developer.hashicorp.com/terraform/install).
- Ter o [Azure CLI instalado](https://learn.microsoft.com/pt-br/cli/azure/what-is-azure-cli).

<br>

## Modo de uso

Antes de começar, você precisa criar uma chave pública/privada para acessar as VMs via SSH. No Linux, use o comando abaixo para criar o par de chaves pública/privada:

```bash
ssh-keygen -m PEM -N '' -f ~/.ssh/id_rsa
``` 

<br>

### Configuração do AZ CLI

O Terraform precisa saber em qual Subscription você vai criar o ambiente. Existe várias [formas de definir a Subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) que será utilizada. Nós vamos definir a Subscription usando a variável `ARM_SUBSCRIPTION_ID`.  

<br>

Faça o login no Azure CLI
```azurecli
az login
```
Será aberto uma página navegador solicitando login.

<br>

Faça uma lista de suas Subscriptions:
```azurecli
az account list --output table
```

<br>

A saída do comando será parecida com esta:
```
Name           CloudName    SubscriptionId                        TenantId                              State    IsDefault
-------------  -----------  ------------------------------------  ------------------------------------  -------  -----------
Pago pelo Uso  AzureCloud   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy  Enabled  True
```

<br>


Exporte a variável `ARM_SUBSCRIPTION_ID` com o ID da Subscription que deseja utilizar:

```shell
export ARM_SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

<br>

### Clone do Git

Faça o clone deste repositório na sua máquina:

```git
git clone https://github.com/ferpaesdias/Meu_PI_na_Nuvem.git
```

<br>

Acesse o diretório do repositório:

```git
cd Meu_PI_na_Nuvem
```


<br>

### Criação do ambiente


Inicialize o Terraform:

```shell
terraform init -upgrade
```

<br>

Exporte a variável `ARM_SUBSCRIPTION_ID`:

```shell
export ARM_SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

<br>

Crie um Terraform Plan. O comando abaixo criará um Plan de nome `tfplan_k8s_vms`:

```shell
terraform plan -out tfplan_meuprojeto
```

<br>

Aplique a configuração do Plan `tfplan_k8s_vms`:

```shell
terraform apply tfplan_k8s_vms
```

<br>

Quando terminar a execução do `terraform apply` será exibido o acesso SSH das VMs e o custo, em dólar, por hora de cada VM.    

Mesmo depois que a execução do `terraform apply` estiver finalizada, aguarde alguns minutos para concluir a instalação dos programas nas VMs.

<br>


Quando terminar de usar o ambiente você pode destruí-lo para não ter gastos desnecessários:

```shell
terraform destroy
```
Digite `yes` quando for solicitado.

<br>

> [!NOTE]
> Ao destruir o ambiente todos os dados serão apagados.
