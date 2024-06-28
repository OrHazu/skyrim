This Terraform configuration sets up an AWS infrastructure for an EKS (Elastic Kubernetes Service) cluster along with supporting resources.

These include a few AWS objects:
- VPC (eks-vpc) - using the terraform-aws-modules/vpc/aws module from the Terraform Registry.
- EKS Cluster - kubernetes
- Node group - in order to create that we iterate over a variable called var.node_groups and use the object list inside. this variable can easily contain more nodes if desired.
- An S3 Remote Backend for the state file.

We also have multiple K8S objects:

- The deployment, which utilizes the DockerImage I created and pushed to Docker Hub ("orhaz/bluered:v1.1")
- A LoadBalancer which directs port 80 from your browser to port 8080 on whichever available resource.
- The namespace - bluered.

Actions needed from the end user before usage:

1. Create an S3 bucket for the remote state prior to running everything.
2. Fill the S3 bucket details within the providers.tf file.
3. Make sure you have an AWS CLI credential file set up as per https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html.
4. Update your profile within the providers.tf file.

Actions needed in order to deploy the app:

1. Go to the TF directory, run 'terraform init',
2. 'terraform plan', review the infrastructure.
3. terraform apply

And you're done! within your AWS console, find the load balancer that was created (k8s.tf), copy the DNS and paste it into your browser.
This should show you a simple webpage.

If you wish to use the EKS context locally, please use the following command, and fill in for the details:

aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME --kubeconfig $KUBECONFIG_PATH --profile $AWS_PROFILE
