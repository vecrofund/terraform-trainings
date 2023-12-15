resource "aws_iam_group" "group-one" {
  name = "group-one"
}
resource "aws_iam_user" "user-one" {
  name = "user-one"
  depends_on = [aws_iam_group.group-one]
}