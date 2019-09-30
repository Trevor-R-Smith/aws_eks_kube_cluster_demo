# aws_eks_kube_cluster_demo

To use the this you first cd into the modules file and run a terraform init.

This will create a terraform.tf file in root folder with a s3 bucket and Dynamo DB lock.

Once you have created the backend you need to go into the root folder and run terraform init

This is now store your terraform state inside of your s3 bucket.

This module add a eks-cluster and a RDS instance so it can take 20-30mins to complete the full deployment.
