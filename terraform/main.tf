provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "null_resource" "apply_yaml" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/../kubernetes/new_app.yaml"
  }
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
