variable "aws_cred" {
  type = object({
    aaccess_key = string,
    secretkey   = string
    region      = string
  })

}
variable "aws_vpc" {
  type = object({
    cidr = string,
    tags = map(string)
  })

}
variable "aws_subnet" {
  type = object({
    cidr            = string,
    availabiltyzone = string,
    tags            = map(string)
  })
}
variable "aws_instance_master" {
  type = object({
    ami          = string,
    instancetype = string
    storagetype  = string
    storage      = number
    tags         = map(string)
  })
}
variable "aws_instance_agent" {
  type = object({
    ami          = string,
    instancetype = string
    storagetype  = string
    storage      = number
    tags         = map(string)
  })
}
