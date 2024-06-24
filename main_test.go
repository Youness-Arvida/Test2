package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/aws"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestTerraformAWS(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "../terraform",
  }

  defer terraform.Destroy(t, terraformOptions)

  terraform.InitAndApply(t, terraformOptions)

  bucketName := terraform.Output(t, terraformOptions, "bucketName")

  s3 := aws.NewS3Client(t, "eu-west-3")

  exists := aws.DoesS3BucketExist(t, s3, bucketName)
  assert.True(t, exists)
}
