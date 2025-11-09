resource "aws_iam_group" "groups" {
  for_each = toset(var.group_names)
  name     = each.value
}

locals {
  # Create a flattened list of {group, policy}
  group_policy_pairs = flatten([
    for group, policy_list in var.group_policies : [
      for policy in policy_list : {
        group  = group
        policy = policy
      }
    ]
  ])

  # Convert list → map for "for_each"
  # Map key becomes: group-policyname
  group_policy_map = {
    for pair in local.group_policy_pairs :
    "${pair.group}-${replace(pair.policy, ":", "_")}" => pair
  }
}

resource "aws_iam_group_policy_attachment" "group_policy_attachments" {
  for_each = local.group_policy_map

  group      = aws_iam_group.groups[each.value.group].name
  policy_arn = each.value.policy
}
