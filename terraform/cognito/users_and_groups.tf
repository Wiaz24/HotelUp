locals {
    UserTypes = [
        "Admin",
        "Client",
        "Cleaner",
        "Janitor",
        "Cook",
        "Receptionist"
    ]
}

resource "aws_cognito_user_group" "user_groups" {
    for_each = local.UserTypes
    name         = "${each.value}s"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user" "users" {
    for_each = local.UserTypes
    user_pool_id = aws_cognito_user_pool.main.id
    username     = lower("${each.value}")
    password = var.cognito_user_password

    attributes = {
        email          = "${lower("${each.value}")}@email.com"
        email_verified = true
    }
}

resource "aws_cognito_user_in_group" "user_in_group" {
    for_each    = local.UserTypes
    user_pool_id = aws_cognito_user_pool.main.id
    group_name   = aws_cognito_user_group.user_groups[each.key].name
    username     = aws_cognito_user.users[each.key].username
}