provider "kubernetes" {

    config_path = "~/.kube/config"

}

module "test" {

    source    = "../"
    namespace = "default"

}
