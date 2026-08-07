provider "aws" {

region = "us-east-2"

}
variable "teams" {

default = {

dev = ["ravi", "bob"]
test = ["alice", "marc"]

}

}

# function to get all users from the teams variable
# name of fucntion is flatten 
# flatten function will take the list of lists and return a single list of all users
# single list => ["ravi", "bob", "alice", "marc"]

locals {
  all_users = flatten(values(var.teams))
}
# ["ravi", "bob", "alice", "marc"]

resource "aws_iam_group" "myusergroup" {
for_each = var.teams
name = each.key

}

# function length = length function will return the number of elements in the list

resource "aws_iam_user" "myusers" {

  count = length(local.all_users)  # we will get the value as 4 => count = 4

  name = local.all_users[count.index]

# local.all_users[count.index] = Go to local.all_users list 
#and get the value at index 0,1,2,3 => ravi,bob,alice,marc

# join function = join function will join the list of strings with a separator and return a single string
  tags = {
    team = join("-", keys(var.teams))  # each user will have tag like dev,test
  }
  # The tag will use the join function to join the keys of the teams variable with a hyphen (-) separator.
  # the output will be like team = dev-test
}


resource "aws_iam_group_membership" "mygroupmembers" {

for_each = var.teams
# here we are using for_each to iterate over the teams variable and 
# create a group membership for each team.
name = "${each.key}-members"
# here we are using the each.key to get the name of the team and append -members to it.
users = each.value
# here we are using the each.value to get the list of users for each team
# and assign them to the group membership.

group = aws_iam_group.myusergroup[each.key].name
# here we are using the each.key to get the name of the team
# and use it to get the name of the group from the aws_iam_group resource.
}
