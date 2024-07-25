# SDR (Study Definition Repository) AWS Infrastructure

This project contains Terraform configurations to deploy the SDR (Study Definition Repository) infrastructure on AWS. It's a port of the original Azure-based infrastructure to AWS services.

## Project Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   ├── ecs_cluster/
│   ├── ecs_service/
│   ├── lambda/
│   ├── api_gateway/
│   ├── dynamodb/
│   ├── secrets_manager/
│   └── cloudwatch/
├── env/
│   └── dev.tfvars
└── README.md
```

- `main.tf`: The main Terraform configuration file that brings together all the modules.
- `variables.tf`: Defines all the input variables for the main configuration.
- `outputs.tf`: Defines the outputs from the main configuration.
- `modules/`: Contains all the modularized Terraform configurations for different AWS services.
- `env/`: Contains environment-specific variable files.

## Azure to AWS Service Mapping

This project maps Azure services to their AWS equivalents as follows:

1. Resource Group -> No direct equivalent (uses tags for grouping)
2. Virtual Network (VNet) -> Amazon VPC
   - Subnets -> AWS Subnets
   - Network Security Group -> Security Groups
3. API Management -> Amazon API Gateway
4. App Service -> AWS Elastic Container Service (ECS)
5. Function App -> AWS Lambda
6. Cosmos DB -> Amazon DynamoDB
7. Key Vault -> AWS Secrets Manager
8. Log Analytics Workspace -> Amazon CloudWatch
9. Application Insights -> AWS X-Ray (not implemented in this version)
10. Azure Container Registry -> Amazon Elastic Container Registry (ECR) (not implemented in this version)
11. Service Bus -> Amazon Simple Queue Service (SQS) (not implemented in this version)
12. Azure AD -> AWS Cognito or IAM (not implemented in this version)

## Modules Overview

1. `vpc`: Sets up the Virtual Private Cloud, including subnets and security groups.
2. `ecs_cluster`: Creates an ECS cluster for running containerized applications.
3. `ecs_service`: Deploys an ECS service and task definition.
4. `lambda`: Sets up a Lambda function for serverless compute.
5. `api_gateway`: Creates an API Gateway to manage and secure APIs.
6. `dynamodb`: Sets up a DynamoDB table for NoSQL database storage.
7. `secrets_manager`: Creates a Secrets Manager secret for storing sensitive information.
8. `cloudwatch`: Sets up CloudWatch resources for monitoring and logging.

## Usage

1. Ensure you have Terraform installed and AWS CLI configured with appropriate credentials.

2. Initialize the Terraform working directory:
   ```
   terraform init
   ```

3. Create a `dev.tfvars` file in the `env/` directory with your specific variable values.

4. Review the planned changes:
   ```
   terraform plan -var-file=env/dev.tfvars
   ```

5. Apply the changes:
   ```
   terraform apply -var-file=env/dev.tfvars
   ```

## Customization

You can customize the deployment by modifying the variables in the `dev.tfvars` file or by adjusting the configurations in the individual module files.

## Notes

This port is STILL in progress! Thus far, this port provides the bare minimum to successfully access any materials from the SDR within AWS.

- This infrastructure is a basic port of the SDR from Azure to AWS. Depending on your specific requirements, you may need to add or modify resources.
- Some Azure services don't have direct equivalents in AWS. In these cases, we've used the closest AWS service or omitted them if not critical.
- Ensure you've properly secured your AWS credentials and Terraform state files, especially when storing sensitive information.

## Contributing

wip :D

## License

wip :D 