/**
*# EKS Getting Started
*
* This is taken from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html
*
* See that guide for additional information.
*
* # Istio
* Deploy the istio examples by running the following code:
*  ```
*  kubectl label namespace default istio-injection=enabled
*  kubectl apply -f files/istio-helloworld.yaml
*  kubectl apply -f files/istio-helloworld-gateway.yaml
*  ```
* Find the istio ingress gateway URL with the following code:
* ```
* kubectl get svc istio-ingressgateway --namespace istio-system -o jsonpath={.status.loadBalancer.ingress[0].hostname}  --kubeconfig [kubeconfig filename]
* ```
* Browse to http://[istio-ingressgateway]/hello
*
* # Parameters
*/

locals {

  cluster_name = "${var.resource_prefix}-cluster"
  node_name    = "${var.resource_prefix}-node"
}
