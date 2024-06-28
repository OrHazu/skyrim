This Terraform configuration sets up an AWS infrastructure for an EKS (Elastic Kubernetes Service) cluster along with supporting resources.

These include:
• VPC (eks-vpc) - using the terraform-aws-modules/vpc/aws module from the Terraform Registry.

• EKS Cluster - kubernetes

• Node group - in order to create that we iterate over a variable called var.node_groups and use the object list inside. this variable can easily contain more nodes if desired.

• Container repository (ECR) called pythontestapp.

• We're using an S3 Remote Backend for the state file.

• 41 objects should be created once hitting apply. Please use "terraform plan" before to review.


Actions needed from the end user before usage:

1. Create an S3 bucket for the remote state prior to running eveything.
2. Fill the S3 bucket details within the providers.tf file.
3. Make sure you have an AWS CLI credenial file set up as per https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html.
4. Update your profile within the providers.tf file.

Actions needed in order to deploy the app:

1. Go to the TF directory, run 'terraform init', 'terraform plan', review the infrastructure and apply it.
2. While terraform deploys the infrastructure, go to the app directoy. If you want to copy the app into your own repo run:
    - docker pull orhaz/bluered:v1.0
    - docker tag orhaz/bluered:v1.0 <target repo>:<target tag>
  If you want to build this without coping into your repo, simply run:
    - docker run orhaz/bluered:v1.0 -p <local port>:8080
    Note: we're using 8080 in this command because this is what the application listens to.
3. 
