
# Terraform Functions and Expressions Tutorial

This repository provides practical examples and detailed tutorials on using advanced Terraform functions and expressions, such as conditional expressions, local values, and the lookup function.

## Examples

- [Conditional Expressions](./docs/conditional-expressions.md)
- [Local Values](./docs/local-values.md)
- [Lookup Function](./docs/lookup-function.md)

## Usage

To use these examples:
1. Clone this repository.
2. Navigate to any example directory.
3. Run `terraform init` and `terraform apply`.


## Using Environment Variables
One of the safest and most common practices is to use environment variables for sensitive credentials. This method keeps your secrets out of your Terraform files and minimizes the risk of accidental exposure. AWS SDKs (which Terraform uses) automatically look for credentials in environment variables. Here’s how you can set them:

```
export AWS_ACCESS_KEY_ID="your_access_key_here"
export AWS_SECRET_ACCESS_KEY="your_secret_key_here"
export AWS_DEFAULT_REGION="us-gov-west-1"  # Example for AWS GovCloud

```


## How to Deploy for Different Environments
To deploy your EC2 instance in different environments (development, staging, production), you'll specify the environment when running Terraform commands. This can be done in a couple of ways:

# Command Line:
You can provide the environment variable directly on the command line when running terraform apply or terraform plan:

```
terraform apply -var="environment=prod"

```
This command tells Terraform to use the production AMI and instance type as specified in your variables.

# tfvars File:
Alternatively, you can define these variables in a terraform.tfvars file or any .tfvars file, which Terraform automatically loads:

```
environment = "prod"

```

# Running Terraform with tfvars:

By default, Terraform automatically loads all files in the working directory with the names terraform.tfvars or *.auto.tfvars. If you name your file differently, or if you want to specify a different configuration file for a particular execution, use the -var-file flag:

```
terraform apply -var-file="production.tfvars"
```

# Multiple Environments: 

If you are managing multiple environments, you might consider having separate tfvars files for each (e.g., dev.tfvars, staging.tfvars, prod.tfvars). This allows you to easily manage and switch between environments without risk of mixing configurations.



## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your improvements.

