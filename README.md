# Inventory Management Infrastructure




```
aws s3api create-bucket --bucket inventory-infra-terraform-state-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2


aws s3api put-bucket-versioning --bucket inventory-infra-terraform-state-bucket --versioning-configuration Status=Enabled

aws dynamodb create-table \
    --table-name terraform-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
```



```
aws ecr batch-delete-image \
    --repository-name dotnet-api \
    --image-ids "$(aws ecr list-images --repository-name dotnet-api --region us-west-2 --query 'imageIds[*]' --output json)" \
    --region us-west-2

aws ecr delete-repository --repository-name <repository-name> --region us-west-2


```