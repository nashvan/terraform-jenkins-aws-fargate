# ----------------------------------------------------------
# Jenkins Master
# ----------------------------------------------------------
module "ecs_jenkins" {
  source = "./modules/jenkins_ecs_service"

  environment           = var.environment
  app_name              = "jenkins"
  application_id        = local.application_id
  cost_centre           = local.cost_centre
  service_name          = local.service_name

  container_count       = 1
  container_port        = 8080
  JenkinsJNLPPort       = 50000
  health_check_path     = "/login"
  record_set_name       = local.account_config["record_set_name"]
  # cluster_name          = "krd-jenkins-develop-ecs-cluster"
  # cluster_arn           = data.aws_ecs_cluster.ecs_cluster.arn
  prefix_name           = "${local.service_name}-${local.app_name}-${var.environment}"

  tags = {
    ApplicationID = local.application_id
    CostCentre    = local.cost_centre
    ServiceName   = local.service_name
    Environment   = var.environment
  }
}

output "jenkins_url" {
  value = module.ecs_jenkins.load_balancer_dns_name
}

# ----------------------------------------------------------
# Extra IAM policy 
# ----------------------------------------------------------