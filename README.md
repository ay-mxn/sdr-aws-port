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
│   ├── cloudwatch/
│   ├── ecr/
│   ├── sqs/
│   ├── cognito/
│   └── iam/
├── env/
│   └── dev.tfvars
└── README.md
```

## Modules Overview

1. `vpc`: Sets up the Virtual Private Cloud, including subnets and security groups.
2. `ecs_cluster`: Creates an ECS cluster for running containerized applications.
3. `ecs_service`: Deploys an ECS service and task definition.
4. `lambda`: Sets up Lambda functions for serverless compute.
5. `api_gateway`: Creates an API Gateway to manage and secure APIs.
6. `dynamodb`: Sets up DynamoDB tables for NoSQL database storage.
7. `secrets_manager`: Creates Secrets Manager secrets for storing sensitive information.
8. `cloudwatch`: Sets up CloudWatch resources for monitoring and logging.
9. `ecr`: Creates Elastic Container Registry repositories for storing Docker images.
10. `sqs`: Sets up Simple Queue Service queues for message processing.
11. `cognito`: Creates Cognito User Pools and Identity Pools for user authentication.
12. `iam`: Sets up IAM roles and policies for secure access to AWS resources.

## Prerequisites

1. AWS CLI installed and configured with appropriate credentials.
2. Terraform (version 0.14 or later) installed.
3. An S3 bucket for storing Terraform state (optional, but recommended for team environments).

## Deployment Instructions

1. Clone this repository:
   ```
   git clone https://github.com/ay-mxn/sdr-aws-port.git
   cd sdr-aws-port
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Create a `terraform.tfvars` file in the root directory and fill in the required variables. You can use `env/dev.tfvars` as a template.

4. Review the planned changes:
   ```
   terraform plan -var-file=terraform.tfvars
   ```

5. Apply the changes:
   ```
   terraform apply -var-file=terraform.tfvars
   ```

## Important Considerations

1. **Cost Management**: Be aware that running this infrastructure in AWS will incur costs. Review the AWS pricing for each service used and set up billing alerts.

2. **Security**: 
   - Ensure that your AWS credentials are kept secure and not committed to version control.
   - Review and adjust the IAM roles and policies to adhere to the principle of least privilege.
   - Enable MFA for all IAM users.

3. **Networking**: 
   - The VPC module sets up a network architecture. Ensure it aligns with your security requirements.
   - Consider using VPC endpoints for enhanced security.

4. **Data Privacy**: 
   - Be mindful of data residency requirements when choosing AWS regions.
   - Enable encryption at rest for sensitive data in DynamoDB and S3.

5. **Monitoring and Logging**: 
   - Review the CloudWatch alarms and adjust thresholds as needed.
   - Set up log retention policies that comply with your data retention requirements.

6. **Scalability**: 
   - The ECS and Lambda configurations allow for scalability. Monitor usage and adjust capacity as needed.

7. **Disaster Recovery**: 
   - Consider setting up cross-region replication for critical data.
   - Implement regular backups and test restore procedures.

8. **Compliance**: 
   - Ensure your AWS setup complies with relevant regulations (e.g., HIPAA, GDPR).
   - Use AWS Config and AWS Security Hub for compliance monitoring.

## Cleaning Up

To avoid incurring unnecessary costs, remember to destroy the resources when they're no longer needed:

```
terraform destroy -var-file=terraform.tfvars
```

## Notes

This port is STILL in progress! Thus far, this port provides the bare minimum to successfully access any materials from the SDR within AWS.

- This infrastructure is a basic port of the SDR from Azure to AWS. Depending on your specific requirements, you may need to add or modify resources.
- Some Azure services don't have direct equivalents in AWS. In these cases, we've used the closest AWS service or omitted them if not critical.
- Ensure you've properly secured your AWS credentials and Terraform state files, especially when storing sensitive information.

## Contributing

wip :D

## License

wip :D 