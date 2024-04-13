
What It Is: The lookup function is used to retrieve the value of a map based on a key, with an optional default value if the key is not found.

Syntax:


```
lookup(map, key, [default])

```

# map:
 A map from which to retrieve a value.
# key: 
The key corresponding to the value you want to retrieve.
# default: 
Optional. The default value returned if the key does not exist in the map.

# Use Case Example:
The lookup function is particularly useful for configurations that need to vary based on external inputs or conditions, such as different settings for different deployment environments.

Terraform Example

```
variable "instance_type_map" {
  type    = map(string)
  default = {
    dev     = "t3.micro"
    staging = "t3.medium"
    prod    = "t3.large"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = lookup(var.instance_type_map, var.environment, "t3.micro")

  tags = {
    Name = "Server-${var.environment}"
  }
}

```

In this scenario, the lookup function determines the instance type based on the deployment environment. It provides a default value in case the environment does not have a specific entry in the map.