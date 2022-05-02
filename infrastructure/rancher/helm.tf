# Helm resources

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  repository       = "https://charts.jetstack.io"
  name             = "cert-manager"
  chart            = "cert-manager"
  version          = "v${var.cert_manager_version}"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

# Install Rancher helm chart
resource "helm_release" "rancher_server" {
  depends_on = [
    helm_release.cert_manager,
  ]

  repository       = "https://releases.rancher.com/server-charts/latest"
  name             = "rancher"
  chart            = "rancher"
  version          = var.rancher_version
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = "${var.rancher_sub_domain}.${var.rancher_root_domain}"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin"
  }

  set {
    name  = "ingress.tls.source"
    value = "letsEncrypt"
  }

  set {
    name  = "letsEncrypt.email"
    value = var.lets_encrypt_email
  }

  set {
    name  = "letsEncrypt.ingress.class"
    value = "traefik"
  }
}
