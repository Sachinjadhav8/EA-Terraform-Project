aws_region = "us-east-1"
env        = "dev"
user_names = ["Ram", "Sham", "Avi", "Geeta", "Mohan", "Ashavini"]

tags = {
  ManagedBy  = "Terraform"
  Department = "CloudOps"
  Owner      = "AdminTeam"
}

/*
credentials_bucket = "my-secure-credentials-bucket"
*/

group_names = [
  "Admin",
  "Developer",
  "QA",
  "Security",
  "DevOps",
  "Finance",
  "HR",
  "Support",
  "Analytics"
]


group_policies = {
  Admin = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]

  Developer = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]

  QA = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]

  Security = [
    "arn:aws:iam::aws:policy/SecurityAudit"
  ]

  DevOps = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]

  Finance = [
    "arn:aws:iam::aws:policy/job-function/Billing"
  ]

  HR = []

  Support = [
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  ]

  Analytics = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
  ]
}
