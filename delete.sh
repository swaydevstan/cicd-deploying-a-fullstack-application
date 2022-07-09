#!/bin/bash 

# export OLD_WORKFLOW_ID=$(aws cloudformation list-exports --query "Exports[?Name==\`WorkflowID\`].Value" --no-paginate --output text)
# echo $OLD_WORKFLOW_ID

# export STACKS=($(aws cloudformation list-stacks --query "StackSummaries[*].StackName" --stack-status-filter CREATE_COMPLETE --no-paginate --output text))

# echo "Stack names are ${STACKS[@]}"

# if [[ "${STACKS[@]}" =~ "${OldWorkflowID}" ]]

# then
#     echo "Removing stacks/s3 bucket"
#     aws s3 rm "s3://udapeople-${OldWorkflowID}" --recursive
#     aws cloudformation delete-stack --stack-name "udapeople-backend-${OldWorkflowID}"
#     aws cloudformation delete-stack --stack-name "udapeople-frontend-${OldWorkflowID}"
#  fi



export OldWorkflowID=$(aws cloudformation list-exports --query "Exports[?Name==\`WorkflowID\`].Value" --no-paginate --output text)         
echo "${OldWorkflowID}"

export STACKS=($(aws cloudformation list-stacks --query "StackSummaries[*].StackName" --stack-status-filter "CREATE_COMPLETE" --no-paginate --output text)) 
echo Old Workflow Id: "${OldWorkflowID}"

# echo Current Workflow Id: "${CIRCLE_WORKFLOW_ID}"
echo "Stack names are ${STACKS[@]}"

if [[ "${STACKS[@]}" =~ "${OldWorkflowID}" ]]
then 
    echo "Deleting stacks and buckets"
    aws s3 rm "s3://udapeople-${OldWorkflowID}" --recursive
    aws cloudformation delete-stack --stack-name "udapeople-backend-${OldWorkflowID}"
    aws cloudformation delete-stack --stack-name "udapeople-frontend-${OldWorkflowID}"
fi