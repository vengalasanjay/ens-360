region = "us-east-2"
project = "ens360"
environment = "dev"
bucketname = "dashboard-sl-non-prod-3456"
rolename = "sentrics"
sentrics_role_arn = "arn:aws:iam::059643481773:role/sentrics"
glue_job_script_locations = [
  "ens360-dashboard-c1-dev-01",
  "ens360-dashboard-pg-dev-01",
  "ens360-dashboard-sl-dev-01",
  "ens360-dashboard-oc-dev-01",
  "ens360-dashboard-loc-dev-01",
  "ens360-dashboard-pc-dev-01"
]
bucket_name = "dashboard-sl-non-prod-345"
crawlers = [
  {
    name       = "ens360-dashboard-crawler-dev-01"
    s3_targets = [
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/sl/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/display_names/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/resident_care_type/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/sl/loc_hierarchy_alarms/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/sl/loc_hierarchy_outlier_alarms/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/onboarded_data/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/peer_groups/",
      "s3://dashboard-sl-non-prod-345/target/Ensure360/dev/ens360-transformations-dev/c1/",
      "s3://dashboard-sl-non-prod-345/target/rls/dev/personalized_email_rls/",
      "s3://dashboard-sl-non-prod-345/target/rls/dev/rls/"
    ]
    db_name = "ens360-dashboard-db-dev-01"
  }
]
lambda_function_name = "ensure360-dashboard-qs-dev-dev-01"
sfn_role = "step_function_role"
sfn_policy = "step_function_policy_sentrics"
state_machines = [
  {
    name       = "ens-360-dashboard-wf-dev"
    definition = <<EOF
{
  "Comment": "First State Machine",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Pass",
      "Result": "Hello from the first state machine!",
      "End": true
    }
  }
}
EOF
  },
  {
    name       = "ens-360-dashboard-wf-dev-02"
    definition = <<EOF
{
  "Comment": "Second State Machine",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Pass",
      "Result": "Hello from the second state machine!",
      "End": true
    }
  }
}
EOF
  }
]
