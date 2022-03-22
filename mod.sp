mod "awscfn_compliance" {
  # Hub metadata
  title         = "AWS CloudFormation Compliance"
  description   = "Run compliance and security controls to detect AWS CloudFormation resources deviating from security best practices prior to deployment in your AWS accounts."
  color         = "#844FBA"
  #documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/awscfn-compliance.svg"
  categories    = ["aws", "compliance", "iac", "security"]

  opengraph {
    title       = "Steampipe Mod to Analyze AWS CloudFormation"
    description = "Run compliance and security controls to detect AWS CloudFormation resources deviating from security best practices prior to deployment in your AWS accounts."
    image       = "/images/mods/turbot/awscfn-compliance-social-graphic.png"
  }
}