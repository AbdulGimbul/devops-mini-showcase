terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

resource "local_file" "provision_report" {
  content  = "Infrastructure provisioned successfully at ${timestamp()}."
  filename = "${path.module}/provision_report.txt"
}

output "report_filename" {
  value = local_file.provision_report.filename
}