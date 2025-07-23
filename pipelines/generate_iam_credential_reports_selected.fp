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

  output "results" {
    description = "Results from all connections"
    value = step.pipeline.generate_iam_credential_report
  }
}