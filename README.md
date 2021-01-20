# stack infra clean

Esta stack foi criada com o intuito de facilitar a utilização do terraform em infraestruturas como codigo.

## Installation

A seguir, o passo a passo para automatizar sua infraestrutrura.

```bash
git clone https://github.com/gpolicante/short.git
cd short/
aws configure 
### Agora utilize suas creentiais para executar a stack #####
vim stacks.tf
```

## Modulos
Vamos conhecer os modulos disponiveis, você poderá utilizar 1 ou todos simultaneamente, de acordo com a sua necessidade : 
- criar ec2 
- criar chave de ssh
- criar ecr 
- criar load balancer e targetgroup 
- criar cluster de kubernetes 

# create_ec2
O modulo create_ec2 vai criar uma ou mais instancias da aws para você , vamos agora entender
```bash


 playbook_link = ""
# Caso você queira executar alguma playbook
# dentro da sua maquina ou conjunto de maquina é só colocar o  link da playbook,
# segue uma de exemplo: https://github.com/gpolicante/playbook_short.git
# devera ter o arquivo playbook.yaml na raiz do repositorio 
# exemplo de utilização: 
playbook_link = "https://github.com/gpolicante/playbook_short.git"


 ami  = "" 
# O ami serve para você colocar o ami-id de uma imagem customizada 
# ou somente o sistema operacional que você queira, 
# os sistemas operacionais disponiveis sao: 
# Windows
# Ubuntu
# amzn
# Suse
# caso queira uma imagem customizada e so colocar o ami id e show !!!
# segue 2 exemplos de caso de uso: 
ami  = "Ubuntu" 
# OR 
ami  = "ami-12345567654" 


 instancetype = ""
# o tipo da instancia, como t2.medium, m5.large e etc... 
# um exemplo de uso: 
instancetype = "t2.medium"

 subnet = ["", "", ""]
# quais subnets suas maquinas vao ficar ou qual, se vc quer somente 01 basta colocar 1 subnet
# agora se vc quer alta ddisponibilidade dividia em 2 subnets e so colocar as 2 subnets que vc 
# queira
# exemplo de uso: 
subnet = ["subnet-9sdfsdfc2", "subnet-bvccvbec3", "subnet-9abbbf2"]
# OR
subnet = ["subnet-9a7a9fc2"]

# OBS, as subnets trabalham como .together ou seja, se vc colocar 2 subnet, devera colocar 2 name 
# de instancia porque ele iria criar 2 maquinas, 
# se vc quer as maquinas tudo na mesma subnet e so repetir o nome da subnet

 name = ["", "", ""]
# Nome das instancias que vc esta afim de criar no seu ambiente 
# exemplo de uso: 
name = ["master-minia", "slave-minia", "slave-minia"]
# OR
name = ["minia"]

# OBS a subnet e name devem trabalhar em conjunto, segue exemplo: 
#
# subnet = ["subnet-9sdfsdfc2", "subnet-bvccvbec3", "subnet-9abbbf2"]
# name = ["master-minia", "slave-minia", "slave-minia"]

 sshkey = ""
# Qual a chave dde ssh que vc quer que a maquina utilize, pode ser uma que ja exista
# ou o nome da que vc vai criar utilizando o modulo que esta ai em baixo de criar chave
# exemplo de uso: 
sshkey = "minia"

 tags = { 
  

   }
# caso vc queira criar tags prontas para o seu ambiente , 
# aquelas tags de referencia da amazon sabe ? 
# exemplo de uso: 
tags = { 
  
  "Creation_to" = "Gabriel"
  "environment" = "prod"
  "adjoin" = "no"

  }


 size = ""
# tamanho do ssd, ele vai criar com o ssd normal la, gp2 e é em GB esse numero
# exemplo de uso: 
size = "100"

 sg = [""]
# lista dos security group que vc quer no seu ambiente, e em lista entao pode ser mais de 1
# exemplo de uso: 
sg = ["sg-0sadsdsa49066d3cfd"]
#OR
sg = ["sg-031cc2049066d3cfd","sg-12343555gfdfd"]
```

# create-sshkey
O modulo create  sshkey cria chave de ssh automatico para ti, se vc pedir para criar aqui e pedir para utilizar no modulo ec2 ele automaticamente vai primeiro criar a chave e depois criar a  maquina, para nn dar erro de chave nn criada.
```bash
- 
keyname = ""
# Nome da chave de ssh que vc quer criar
# exemplo de uso: 
keyname = "minia"

keypublic = ""
# chave publica para ficar armazenada na aws e depois ir nas maquinas 
# como eu gero o par de chaves ? ssh-keygen é o comando que gera chave
# ai vc pega a chave PUBLICA , com o  conteúdo dela vc cola aqui 
# exemplo de uso: 
keypublic = "ssh-rsa ASDASDSAD..."
```

# create-lb
Esse modulo cria um load balancer para ti e se vc quiser, pode interligar as instancias criadas no modulo ec2 com o load balancer automaticamente.
OBS: este modulo não esta finalizado 100% , ainda falta alguns pontos como: 
- habilitar SSL 
- targetgroup em lista para criar mais de 1 
```bash

lbname = ""
# O nome do loadbalancer
# exemplo de uso: 
lbname = "lbminia"

internal = ""  
# o internal vc vai falar se é um loadbalancer publico ou privado
# os valores sao false ou true
# true = subnet privada
# false  = subnet publica
# exemplo dde uso: 
internal = "false"


lbtype = ""
# O tipo do loadbalancer, pode ser network ou application
# caso de uso: 
lbtype = "application"

lbsg = [""]
# Lista de security group que ira ser atrelado ao load balancer, lembrando que esse sg tem que ter
# acesso as instancias e a regra para as pessoas chegarem nele. 
# exemplo de uso: 
lbsg = ["sg-031cc2049066d3cfd"]


lbsubnet = ["", ""] 
# as subnets que vao ficar no lb, elas podem ser as mesmas das ec2 ou nao, 
# o melhor dos mundos e as ec2 ficarem em subnet privada e o lb nas publicas
# mas a gente sabe que o mundo nn e magico 
#OBS precisa ser no minimo 2 se for o application


nametargetgroup = ""
# Agora vamos criar o target group que vc vai atrelar no lb, ai ele cria so 1 
# nas proximas atualizacoes eu crio para criar um ou mais 
# nesta variavel vc vai colocar o nome dele 
# exemplo de uso: 
nametargetgroup = "miniaapp"



portlb = ""
# Qual a porta que o seu loadbalancer vai fornecer para o mundo 
# exemplo de uso: 
portlb = "80"

portinstance = ""
# A porta que o loadbalancer vai chegar na instancia , a porta  que esta sendo fornecida na maquina
# caso de uso: 
portinstance = "80"



protocol = "" 
# protocolo da instancia, se vc quiser um protocolo diferente de HTTP ou HTTPS use TCP
# caso de uso: 
protocol = "HTTP" 

vpcid = ""
# vpcid onde esta as instancias que foram criadas 
# caso de uso: 
vpcid = "vpc-ea85fs138e"

target_type = ""
# se vc quer redirecionar para instancia ou IP , os valores aceitos sao instance OR ip
# caso de uso : 
target_type = "instance"

```

# create-ecr
Esse modulo ira criar um repositorio para ti do ECR da amazon
OBS: os seguintes itens ainda estao em desenvolvimento: 
- criar uma serie de repositorios em lista
- tratar as saídas de erros 
```bash
imagename = ""
# por favor né ? nome da imagem poxa haaha
# uso de caso: 
imagename = "minia"

```

# create-eks
Este modulo cria um cluster de EKS com fargate profile no namespace default
```bash
 clustername = ""
# nome do cluster que sera criado
# caso de uso: 
clustername = "eks_minia"

 arnrole_cluster = ""
# Quando o cluster subir ele precisa de uma role , Qual é o arn role do cluster
# caso de uso: 
arnrole_cluster = "arn:aws:iam::IDDCOUNT:role/eks-policante"

 rolearnfargate = ""
# Aqui é a mesma ideia da role do cluster, mas o cluster precisa de permissao para servicos da aws
# o do fargate agr vai do que vc vai usar, no minimo acesso ao ECR precisa , 
# mas ae e so ler a doc da aws das roles que ta tudo certo 
# exemplo de uso: 
rolearnfargate = "arn:aws:iam::IDCOUNT:role/eksctl-1E3J"


 fargetname = ""
# Nome do cluster de fargate que vc vai criar 
# lembrando que fargate e o serveless do eks 
# caso de uso:
fargetname = "batatinha"

 subnetcluster = ["", ""] 
# subnet do cluster, essa subnet pode ser publica ou privada, vc escolhe
# se usar fargate deixa tudo privado
# se usar ec2 ae recomendo usar publica e privada aqui
# caso de uso: 
subnetcluster = ["subnet-9a7fdfa9fc2", "subnet-b5dfdfbc7ec3"] 

 subnetprivatefargate = ["",""]
#subnet do fargate, essa subnet precisa ser privada
# caso de uso: 
 subnetprivatefargate = ["subnet-9a7fdfa9fc2", "subnet-b5dfdfbc7ec3"] 

 sgcluster = [""]
# o security group para os caras se conversarem e chegarem nos seus containers 
# caso de uso: 
sgcluster = ["sg-03df1cc2049066d3cfd"]
```

# Como utilizar  ? 

Basta você descomentar os modulos que você gostaria de usar, 
preencher as variaveis e executar os comandos: 

```bash

terraform init 
# para baixar os modulos 
terraform plan
# para verificar se as variaveis que vc preencheu estao corretas
terraform apply 
# faz o deploy da porra toda. 

```
