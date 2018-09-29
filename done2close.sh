#!/bin/sh

TOKEN=$1      # Your personal access token (see: https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
DOMAIN=$2     # Your GitLab domain name (ex: example.com)
TARGET=$3     # Either `groups` or `projects`
TARGET_ID=$4  # Either groups id or projects id

PROJECT_ID=$(curl --header "PRIVATE-TOKEN: $TOKEN" \
  "https://gitlab.$DOMAIN/api/v4/$TARGET/$TARGET_ID/issues?labels=Done&state=opened" \
  | jq '[.[].project_id] | @sh' | sed "s/\"//g")

IID=$(curl --header "PRIVATE-TOKEN: $TOKEN" \
  "https://gitlab.$DOMAIN/api/v4/$TARGET/$TARGET_ID/issues?labels=Done&state=opened" \
  | jq '[.[].iid] | @sh' | sed "s/\"//g")

for project_id in ${PROJECT_ID}; do
  PROJECT_ID_ARRAY+=("$project_id")
done

for iid in ${IID}; do
  IID_ARRAY+=("$iid")
done

for index in ${!PROJECT_ID_ARRAY[@]}; do
  curl --request PUT --header "PRIVATE-TOKEN: $TOKEN" "https://gitlab.$DOMAIN/api/v4/projects/${PROJECT_ID_ARRAY[index]}/issues/${IID_ARRAY[index]}?state_event=close&labels="""
  sleep 1
done