terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "redis" {
  name = "redis:alpine"
}

resource "docker_container" "redis_container" {
  name  = "redis-container"
  image = docker_image.redis.image_id
}

resource "docker_image" "mysql" {
  name = "mysql:8.0"
}

resource "docker_container" "mysql_container" {
  name  = "mysql-container"
  image = docker_image.mysql.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=password123"
  ]

  ports {
    internal = 3306
    external = 3307
  }
}
