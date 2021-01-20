provider "aws" {
  region = "us-east-1"
}

module "create_ec2" { 
source = "github.com/gpolicante/ec2_terra.git"

#(optional playbook link)
playbook_link = ""
token_bitly = ""
#pass ami-id custom or name to SO
ami  = "" 
instancetype = ""
subnet = ["", "", ""]
name = ["", "", ""]
sshkey = ""
tags = { 
  
  "Creation_to" = "Gabriel"

  }

size = ""
sg = [""]
}

module "create-sshkey" { 
source = "github.com/gpolicante/keyssh_terra.git"
keyname = ""
keypublic = ""

}


module "create-lb" { 
source = "github.com/gpolicante/lb_terra.git"

lbname = ""

internal = ""  
lbtype = ""
lbsg = [""]
lbsubnet = ["", ""] 


nametargetgroup = ""
portlb = ""
portinstance = ""
protocol = "" 
vpcid = ""
target_type = ""
# quieres instance to moddule create ec2 ? yes use "${module.create_ec2.instance_id}" , no use list with instance id 
instanceid = ""


}


module "create-ecr" { 
source = "github.com/gpolicante/ecr_terra.git"
imagename = ""


}


module "create-eks" { 
source  = "github.com/gpolicante/eks_terra.git"


clustername = ""
arnrole_cluster = ""
rolearnfargate = ""
fargetname = ""
subnetcluster = ["", ""] 
subnetprivatefargate = ["",""]
sgcluster = [""]

}