resource "kubernetes_service" "exporter" {

    metadata {

        name      = "node-exporter"
        namespace = "kube-system"

    }

    spec {

        cluster_ip = "None"

        selector = {

            app = "node-exporter"

        }

        port {

            name        = "http"
            port        = 9100
            target_port = 9100

        }

    }

}
