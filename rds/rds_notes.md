# RDS
[secrets](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1)

### The crux
Pretty sure the answers in the link are going to be ***refer to files*** and ***use environemnt variables*** plus *some vault* that I will probably not buy into. Ideally could use something like a ```.env``` file with keys and values to whick one can refer.

### The overall advice:
1. Pre1-requisite #1: Don’t Store Secrets in Plain Text
1. Pre-requisite #2: Keep Your Terraform State Secure
1. Technique #1: Environment Variables
1. Technique #2: Encrypted Files (e.g., KMS, PGP, SOPS)
1. Technique #3: Secret Stores (e.g., Vault, AWS Secrets manager)

### Terraform is not secure because of .tfstate files:
So .gitignore on all terraform result files (already done ). That works for independent developer. But the more general solution is use an encrypeted Terraform backend.

1. Solution 1 Environment variables
For me, that means create a .sh file to set all the required secrets as environment variables.
***rds.main.tf:***
```tf
username = var.username
password = var.password
```
***secret_env.sh:***
```sh
export TF_VAR username=Guilligan
export TF_VAR password=password123
```
