include "common" {
  path   = find_in_parent_folders()
  expose = true
  merge_strategy = "deep"
}

terraform {
  source = "../../modules//dep"
}
