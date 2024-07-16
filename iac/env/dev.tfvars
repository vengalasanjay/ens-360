project = "ens360"
environment = "dev"
bucketname = "sentrics-dev-01"
rolename = "sentrics"
iam_role_arn = 
glue_job_script_locations = [
  "ens360-dashboard-c1-dev-01",
  "ens360-dashboard-pg-dev-01",
  "ens360-dashboard-sl-dev-01",
  "ens360-dashboard-oc-dev-01",
  "ens360-dashboard-loc-dev-01",
  "ens360-dashboard-pc-dev-01"
]
bucket_name = "dashboard-sl-non-prod-345"
crawlers = "ens360-dashboard-crawler-dev-01"
