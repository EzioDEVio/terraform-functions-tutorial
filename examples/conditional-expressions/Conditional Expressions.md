
1. Conditional Expressions
What They Are: Conditional expressions allow you to perform conditional logic within your Terraform configurations. This is similar to "if-else" statements in traditional programming languages.

Syntax:
```
condition ? true_val : false_val

```

condition: A boolean expression that evaluates to either true or false.
true_val: The value that is returned if the condition is true.
false_val: The value that is returned if the condition is false.
Use Case Example:
You can use conditional expressions to choose different configurations based on the deployment environment. For example, you might want a larger instance size for production environments compared to development environments.

Terraform Example:

```
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"

  tags = {
    Name = "Server-${var.environment}"
  }
}

```

In this example, the instance type of an AWS EC2 instance is determined based on the value of the var.environment. If it equals "prod", a larger instance type is used.