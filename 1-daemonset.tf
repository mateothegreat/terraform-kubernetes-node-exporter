resource "kubernetes_daemonset" "exporter" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        selector {

            match_labels = {

                app = var.name

            }

        }

        template {

            metadata {

                labels = {

                    app = var.name

                }

            }

            spec {

                host_network = true
                host_pid     = true

                security_context {

                    run_as_non_root = true
                    run_as_user     = 65534

                }

                container {

                    name  = var.name
                    image = var.image

                    args = [

                        "--web.listen-address=0.0.0.0:9100",
                        "--path.sysfs=/host/sys",
                        "--path.rootfs=/host/root",
                        "--no-collector.arp",
                        "--no-collector.hwmon",
                        "--no-collector.wifi",
                        "--collector.filesystem.mount-points-exclude=^/(dev|proc|sys|var/lib/docker/.+|var/lib/kubelet/pods/.+)($|/)",
                        "--collector.netclass.ignored-devices=^(veth.*|[a-f0-9]{15})$",
                        "--collector.netdev.device-exclude=^(veth.*|[a-f0-9]{15})$"

                    ]

                    port {

                        container_port = 9100
                        name           = "http"
                        protocol       = "TCP"

                    }

                    resources {

                        limits = {

                            cpu    = "250m"
                            memory = "180Mi"

                        }

                        requests = {

                            cpu    = "102m"
                            memory = "180Mi"

                        }

                    }

                    volume_mount {

                        name              = "sys"
                        mount_path        = "/host/sys"
                        mount_propagation = "HostToContainer"
                        read_only         = true

                    }

                    volume_mount {

                        name              = "root"
                        mount_path        = "/host/root"
                        mount_propagation = "HostToContainer"
                        read_only         = true

                    }

                }

                volume {

                    name = "sys"

                    host_path {

                        path = "/sys"

                    }

                }

                volume {

                    name = "root"

                    host_path {

                        path = "/"

                    }

                }

            }

        }

    }

}
