module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  az                  = var.az
}

module "iam" {
  source = "./modules/iam"
}

module "cloud_watch" {
  source = "./modules/cloud_watch"
}

module "alb" {
  source = "./modules/alb"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  alb_sg              = module.vpc.alb_sg
}

module "ec2" {
  source = "./modules/ec2"

  instance_type = var.instance_type
  private_subnet_ids  = module.vpc.private_subnet_ids
  ecs_sg              = module.vpc.ecs_sg
  profile_arn         = module.iam.profile_arn
}

module "ecs" {
  source = "./modules/ecs"

  task-role           = var.task-role
  app-img             = var.app-img
  app-container       = var.app-container
  nginx-img           = var.nginx-img
  nginx-container     = var.nginx-container
  log_name            = module.cloud_watch.log_name
  region              = var.region
  tg_arn              = module.alb.tg_arn
  asg_arn             = module.ec2.asg_arn
  task-count          = var.task-count
  network_mode        = var.network_mode

  #DB configuration
  RAILS_ENV           = var.RAILS_ENV
  DB_HOSTNAME         = module.rds.db_host
  DB_NAME             = var.DB_NAME
  DB_USERNAME         = var.DB_USERNAME
  DB_PASSWORD         = var.DB_PASSWORD
  DB_PORT             = var.DB_PORT
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids  = module.vpc.private_subnet_ids
  db_sg               = module.vpc.db_sg

  identifier          = var.identifier
  instance_class      = var.instance_class
  engine              = var.engine
  engine_version      = var.engine_version
  storage             = var.storage
  skip_final_snapshot = var.skip_final_snapshot

  DB_NAME             = var.DB_NAME
  DB_USERNAME         = var.DB_USERNAME
  DB_PASSWORD         = var.DB_PASSWORD

  multi_az           = var.multi_az
  
}