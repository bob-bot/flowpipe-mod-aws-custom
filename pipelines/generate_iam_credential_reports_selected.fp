pipeline "generate_iam_credential_reports_selected" {
  title       = "Generate IAM Credential Reports for Selected Connections"
  description = "Runs the IAM credential report for only the AWS connections specified in the input parameter."

  param "connections" {
    type        = list(connection.aws)
    description = "List of AWS connections to run the report for"
  }

  step "pipeline" "generate_iam_credential_report" {
    for_each = param.connections

    pipeline = aws.pipeline.generate_iam_credential_report

    args = {
      conn = each.value
    }
  }

  # Fixed output - use the correct attribute structure
  output "results" {
    description = "Map of IAM credential report status objects per connection"
    value = {
      for key, result in step.pipeline.generate_iam_credential_report :
      key => result.output.status
    }
  }
}