resource "aws_ecs_service" "apache"{
  name = var.name
  cluster = var.cluster
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 0
  desired_count = var.desired_count
  launch_type = var.launch_type
  task_definition = var.task_definition
  
  network_configuration {
    assign_public_ip = true
    security_groups = var.security_groups
    subnets = var.subnets
    
  }
  load_balancer  {
    target_group_arn = var.target_group_arn
    container_name   = "${lookup(var.lb_target_group, "container_name", var.name)}"
    container_port   = "${lookup(var.lb_target_group, "container_port", 80)}"
  }
  
}