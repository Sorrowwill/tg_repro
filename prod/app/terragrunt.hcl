include "common" {
  path   = find_in_parent_folders()
  expose = true
  merge_strategy = "deep"
}

terraform {
  source = "../../modules//app"
}

dependency "dep" {
  config_path = "../dep"
}

inputs = {
  input = "${dependency.dep.outputs.var}"
}