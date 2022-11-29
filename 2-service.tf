resource "kubernetes_service" "exporter" {

    metadata {

        name      = var.name
        namespace = var.namespace

    }

    spec {

        cluster_ip = "None"

        selector = {

            app = var.name

        }

        port {

            name        = "http"
            port        = 9100
            target_port = 9100

        }

    }

}
