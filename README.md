# Inventory Management Infrastructure



## Initialize

If the bucket and table are not created, run the command below

```
aws s3api create-bucket --bucket inventory-infra-terraform-state-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2


aws s3api put-bucket-versioning --bucket inventory-infra-terraform-state-bucket --versioning-configuration Status=Enabled

aws dynamodb create-table \
    --table-name terraform-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
```

## Run

```
terraform init -backend-config="backend-dev.hcl"

terraform plan -var-file="env/dev.tfvars"
terraform apply -var-file="env/dev.tfvars"

```
## Debug (Optional)

### Delete images manually before delete repository
```
aws ecr batch-delete-image \
    --repository-name dotnet-api \
    --image-ids "$(aws ecr list-images --repository-name dotnet-api --region us-west-2 --query 'imageIds[*]' --output json)" \
    --region us-west-2

aws ecr delete-repository --repository-name <repository-name> --region us-west-2


```
### Restore tfstate in S3 bucket

Get all versions of tfstate files in S3 bucket
```
aws s3api list-object-versions \
  --bucket inventory-infra-terraform-state-bucket \
  --prefix env/dev/terraform.tfstate

```

Identify the Stored Checksum in DynamoDB 

```
aws dynamodb get-item   --table-name terraform-lock   --key '{"LockID": {"S": "inventory-infra-terraform-state-bucket/env/dev/terraform.tfstate-md5"}}' --region us-west-2
```

Download version object of tfstate file

```
aws s3api get-object \
  --bucket inventory-infra-terraform-state-bucket \
  --key env/dev/terraform.tfstate \
  --version-id JXlAR6bYnPVCUGdhakgReyXA1tdYNoE3 \
  terraform.tfstate
```

Upload the tfstate file

```
aws s3 cp terraform.tfstate s3://inventory-infra-terraform-state-bucket/env/dev/terraform.tfstate

```