# tf-module.keypair
Terraform module for creating key pair.  This module will create the key, add the generated key to the AWS key pair list, and add the private key(pem file) into the secret manager   

## Usage ##
```hcl-terraform
module "key-openvpn" {
  source  = "git@github.com:bluesentry/tf-module.keypair.git?ref=v2.0.4"
  name    = "openvpn"
  tags    = local.tags
}
```

## Terraform versions ##
Terraform 0.12. Pin module version to ~> v2.0. Code changes are handled in `master` branch

Terraform 0.11. Pin module version to ~> v1.0. Code changes are handled in `v11` branch

## Upgrade Notes ##
v2.0.3:  Starting in v2.0.3 the Secret for storing the private key will end with 4 random characters.  This is to make it unique and support destroying and recreating without getting a Terraform error.  Currently when a secret is destroyed, it is marked for deletion in AWS.  If the Terraform attempts to regenerate, it will error as already existing.

If upgrading an existing environment to use v2.0.3 or later the secret and secret_version will show in the plan as being recreated with the new naming convention, but the private key will remain unchanged.

## Argument Reference ##
The following module level arguments are supported.

* **name** - (Required) The keypair name.

* **tags** - (Optional) The tags assigned to all related resources that can be tagged.dd


## Outputs ##

* **key_name** - The key's name.

* **private_key** - The generated private key (pem file contents)
