variable "aws" {
  type = object({
    region     = string
    account_id = string
    author     = string
  })

  default = {
    region     = "ap-northeast-2"
    account_id = "900521233259"
    author     = "Beaver"
  }
}

variable "env_variable" {
  type = object({
    s3 = object({
      bucket_name = string
    })
    lambda = object({
      function_name = string
    })
  })
}

variable "lambda" {
  type = object({
    jar_name = string
    handler  = string
    runtime  = string
  })

  default = {
    jar_name = "HelloWorldFunction.jar"
    handler  = "helloworld.App::handleRequest"
    runtime  = "java17"
  }
}
