# Define the Namespace
resource "kubernetes_namespace" "bluered" {
  metadata {
    name = "bluered"
  }
}

# Define the Deployment
resource "kubernetes_deployment" "bluered" {
  metadata {
    name      = "bluered"
    namespace = kubernetes_namespace.bluered.metadata[0].name

    labels = {
      app = "bluered"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "bluered"
      }
    }

    template {
      metadata {
        labels = {
          app = "bluered"
        }
      }

      spec {
        container {
          name  = "bluered"
          image = "orhaz/bluered:v1.1"
          resources {}
        }
      }
    }
  }
}

# Define the Service
resource "kubernetes_service" "bluered" {
  metadata {
    name      = "bluered"
    namespace = kubernetes_namespace.bluered.metadata[0].name
  }

  spec {
    selector = {
      app = "bluered"
    }

    port {
      protocol   = "TCP"
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
