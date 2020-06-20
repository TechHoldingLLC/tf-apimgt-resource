# locals {
 
#   ROLES = ["developer", "analyst", "manager"]
#   POLICIES = ["arn:1", "arn:2", "arn:3"]
 
#   list = flatten([for role_item in local.ROLES :
#     [for policy_item in local.POLICIES : {
#       "${role_item}-${policy_item}" = {
#         role  = role_item
#         policy = policy_item
#       }
#       }
#     ]
#   ])
 
#   map = { for item in local.list :
#     keys(item)[0] => values(item)[0]
#   }
 
# }


# locals {
#   list = flatten([for v in var.svc_version :
#     [for r in v.routes : {
      
#     }]
#   ])
# }