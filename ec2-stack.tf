provider "aws" {
  region = "us-east-1"
}

module "create_ec2" { 
source = "github.com/gpolicante/ec2_terra.git"

playbook_link = ""
token_bitly = ""
# amiid es para cuando quieres una ami custom 
amiid  = "" 
#ostype es como : 
# ubuntu == Ubuntu
# centos / redhat == amzn
# windao == Windows
# suse == Suse
ostype = "Ubuntu"
instancetype = "t2.medium"
subnet = ["", "", ""]
name = ["", "", ""]
sshkey = ""
tags = { 
  
  "Creation_to" = "Gabriel"

  }

size = "100"
sg = [""]
}



module "create-sshkey" { 
source = "github.com/gpolicante/keyssh_terra.git"
keyname = "testminia"
keypublic = ""

}


module "create-lb" { 
source = "github.com/gpolicante/lb_terra.git"

lbname = "lbminia"

internal = "false"  
lbtype = "application"
lbsg = [""]
lbsubnet = ["", ""] 


nametargetgroup = "miniaapp"
portlb = "80"
portinstance = "80"
protocol = "HTTP" 
vpcid = ""
target_type = "instance"
# quieres instance to moddule create ec2 ? yes use "${module.create_ec2.instance_id}" , no use list with instance id 
instanceid = "${module.create_ec2.instance_id}"


}