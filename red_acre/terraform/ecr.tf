resource "aws_ecr_repository" "red-acre-ecr" {
  name = "red-acre-flask-app"
  # Well, immutable is ALWAYS better, but we will use `latest` here, so meh. Go with that.
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

