terraform_version_constraint  = ">= 1.0.0, < 2.0.0"
terragrunt_version_constraint = ">= 0.38.0, < 0.39.0"

# setup state for each module
remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/states/${path_relative_to_include()}_terragrunt.tfstate"
  }
}

# we generate backend state for each module, because tf will ignore tg backend if it wasn't already set
generate "terraform" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "local" {}
}
EOF
}

# here we will decrypt state files and encrypt them on most operations
# we cant specify all as value for commands so should specify each command
terraform {
  before_hook "decrypt_states" {
    commands    = ["plan", "apply", "init", "import", "state", "destroy", "output"]
    execute     = ["bash", "-c", "mv states/prod/dep_terragrunt.tfstate1 states/prod/dep_terragrunt.tfstate"]
    working_dir = "${get_parent_terragrunt_dir()}"
  }

  after_hook "encrypt_states" {
    commands     = ["plan", "apply", "init", "import", "state", "destroy", "output"]
    execute      = ["bash", "-c", "mv states/prod/dep_terragrunt.tfstate states/prod/dep_terragrunt.tfstate1"]
    working_dir  = "${get_parent_terragrunt_dir()}"
    run_on_error = true
  }
}
