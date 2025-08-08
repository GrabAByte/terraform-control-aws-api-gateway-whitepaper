attributes = [
  {
    name = "Object"
    type = "S"
  },
  {
    name = "Timestamp"
    type = "N"
  }
]

# VPC
nacl_rules = [
  {
    rule_number = 100
    protocol    = "6"
    rule_action = "allow"
    egress      = true
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },
  {
    rule_number = 110
    protocol    = "6"
    rule_action = "allow"
    egress      = true
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  },
  {
    rule_number = 110
    protocol    = "6"
    rule_action = "allow"
    egress      = false
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },
  {
    rule_number = 150
    protocol    = "6"
    rule_action = "allow"
    egress      = false
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  },
  {
    rule_number = 200
    protocol    = "-1"
    rule_action = "deny"
    egress      = false
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  },
  {
    rule_number = 200
    protocol    = "-1"
    rule_action = "deny"
    egress      = true
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }
]
