# This resource block deploys an nginx Helm chart from the bitnamicharts OCI registry.
resource "helm_release" "nginx" {
  count = 0

  name       = "nginx"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "nginx"

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}
