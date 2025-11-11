region = "ap-south-1"

vpc_name = "eneryA"

private_subnet_ids = [
  "subnet-06416bc1a2a357e2c",
  "subnet-0b99a713fe4f0c735"
]

# public_subnet_name_filter = "eneryA*"   # Since "eneryA*" matches both.

directory_dns_name = "corp.example.com"

directory_admin_password = "pass@123"


fsx_security_group_id = "sg-04050cf587048f7d0"
fsx_size = 32
fsx_throughput = 32

/*
agent_name = "datasync-agent-1"
activation_key = "88TAN-BGHAQG-XXXX"   # From your agent screen

# SMB source (on-prem or PC)
smb_server = "192.168.43.167"
smb_subdir = "/DemoShare"
smb_user = "datasyncuser"
smb_password = "Test@123"

# FSx destination
fsx_location_sg_arn = "arn:aws:ec2:ap-south-1:xxxx:security-group/sg-yyyy"
fsx_subdir  = "/share"
fsx_user    = "admin"                 # username ONLY
fsx_password = "Password@123"
fsx_domain  = "corp.example.com"

task_name = "smb-to-fsx"
run_now = true

*/
