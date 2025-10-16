package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestVPCModule(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../../modules/vpc",
        Vars: map[string]interface{}{
            "project_name":         "test",
            "vpc_cidr":            "10.0.0.0/16",
            "public_subnet_cidrs":  []string{"10.0.1.0/24", "10.0.2.0/24"},
            "private_subnet_cidrs": []string{"10.0.10.0/24", "10.0.20.0/24"},
            "common_tags":         map[string]string{"Environment": "test"},
        },
    }

    defer terraform.Destroy(t, terraformOptions)

    terraform.InitAndApply(t, terraformOptions)

    vpcId := terraform.Output(t, terraformOptions, "vpc_id")
    assert.NotEmpty(t, vpcId)
}
