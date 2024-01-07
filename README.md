# eks_project_1

# Pre-Requisites
1. Use latest  version of AWS Cli because EKS Cluster Access Management support added in 2.15.3 release


AWS CLI Commands for EKS Cluster Access Management
================================================================================================
* aws eks update-cluster-config --region us-east-1 --name "eksdemocluster" --access-config authenticationMode=API_AND_CONFIG_MAP

* aws eks create-access-entry --region us-east-1 --cluster-name "eksdemocluster" --principal-arn "arn:aws:iam::047946443426:role/CodeBuildEKSRole" --type "STANDARD"

* aws eks list-access-policies --region us-east-1

* aws eks --region us-east-1 associate-access-policy --cluster-name "eksdemocluster" --principal-arn "arn:aws:iam::047946443426:role/CodeBuildEKSRole" --access-scope type=cluster --policy-arn "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

================================================================================================

# Reference Documents
 * https://aws.github.io/aws-eks-best-practices/security/docs/iam/

 * https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst
 
 * https://devopslearning.medium.com/ci-cd-pipeline-for-eks-using-codecommit-codebuild-codepipeline-and-elastic-container-100f4b85e434

 * https://medium.com/@adrianarba/ci-cd-defined-through-terraform-using-aws-codepipeline-aws-codecommit-and-aws-codebuild-12ade4d9cfa3
================================================================================================

# DONT FORGET TO ALLOW YOUR IP IN INBOUND RULES OF YOUR NODE