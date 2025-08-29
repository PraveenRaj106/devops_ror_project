#!/bin/bash
echo "ECS_CLUSTER=app-nginx" >> /etc/ecs/ecs.config
echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;