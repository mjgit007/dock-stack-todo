variable "TAG" {
  default = "latest"
}

group "default" {
  targets = ["app"]
}

target "app" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = ["getting-started-todo-app:${TAG}"]
}
