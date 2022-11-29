variable "name" {

    type        = string
    default     = "node-exporter"
    description = "daemon name"

}

variable "namespace" {

    type        = string
    default     = "node-exporter"
    description = "daemon namespace"

}

variable "image" {

    type        = string
    default     = "quay.io/prometheus/node-exporter:v1.4.0"
    description = "daemon docker image"

}
