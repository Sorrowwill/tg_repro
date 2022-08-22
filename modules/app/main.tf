variable "input" {
  type = string
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

output name {
  value       = "${var.input}-${random_string.random.result}"
}
