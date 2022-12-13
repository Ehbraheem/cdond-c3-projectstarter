stacks = `aws cloudformation list-stacks --query "StackSummaries[*].StackName" \
  --stack-status-filter DELETE_FAILED \
  --no-paginate --output text --profile udacity`

stacks = stacks.chomp.split("\t")

stacks.each do |stack|
  puts "--- Deleting stack #{stack} ---"
  workflow = stack.split('-').last
  puts "Workflow: #{workflow}"

  puts "Deleting S3 bucket udapeople-#{workflow}"
  system("aws s3 rm 's3://udapeople-#{workflow}' --recursive --profile udacity") rescue nil

  puts "Deleting CloudFormation stack udapeople-backend-#{workflow}"
  system("aws cloudformation delete-stack --stack-name 'udapeople-backend-#{workflow}' --profile udacity") rescue nil

  puts "Deleting CloudFormation stack udapeople-frontend-#{workflow}"
  system("aws cloudformation delete-stack --stack-name 'udapeople-frontend-#{workflow}' --profile udacity") rescue nil

  puts "--- Deleted stack #{stack} ---"
end
