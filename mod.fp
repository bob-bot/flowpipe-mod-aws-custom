mod "aws_custom_pipelines" {
  title       = "Custom AWS Flowpipe Pipelines"
  description = "Wrapper pipeline to run custom Flowpipe pipelines across Steampipe connections"
  require {
    mod "github.com/turbot/flowpipe-mod-aws" {
      version = "*"
    }
  }
}