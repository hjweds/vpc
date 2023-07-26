terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

# Configure the IBM Provider
provider "ibm" {
  region = "us-south"
}

resource "null_resource" "agent" {
  provisioner local-exec {
    command = <<BASH
    ibmcloud login --apikey ${var.ibmcloud_api_key} -r us-south
    ibmcloud ks cluster config -c cisk8u8d0vhk20k72bog
    kubectl set image -n schematics-job-runtime deployment/jobrunner jobrunner=icr.io/schematics-remote/schematics-job-runner:b899d928-262
    BASH
  }
}