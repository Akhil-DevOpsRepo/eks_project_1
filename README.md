# eks_project_1


Requirement
1. latest  version of AWS Cli because EKS Cluster Access Management support added in 2.15.3 release
https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst

2.15.3
======

* api-change:``cloud9``: Updated Cloud9 API documentation for AL2023 release
* api-change:``eks``: Add support for EKS Cluster Access Management.

AWS commands
================================================================================================
* aws eks list-access-policies --region us-east-1

* aws eks update-cluster-config --region us-east-1 --name "eksdemocluster" --access-config authenticationMode=API_AND_CONFIG_MAP

* aws eks create-access-entry --region us-east-1 --cluster-name "eksdemocluster" --principal-arn "arn:aws:iam::047946443426:role/CodeBuildEKSRole" --type "STANDARD"

* aws eks --region us-east-1 associate-access-policy --cluster-name "eksdemocluster" --principal-arn "arn:aws:iam::047946443426:role/CodeBuildEKSRole" --access-scope type=cluster --policy-arn "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"