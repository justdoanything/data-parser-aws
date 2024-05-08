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

variable "cloud_front" {
  type = object({
    distribution_comment = string
  })

  default = {
    distribution_comment = "beaver cloud front distribution"
  }
}

variable "env_variable" {
  type = object({
    s3 = object({
      bucket_name = string
    })
  })
}
