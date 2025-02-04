#!/bin/bash
REPO_OWNER="galendu"
REPO_NAME="private"
WORKFLOW_ID="sing-box.yml"
BRANCH="main"
GITHUB_TOKEN=""
SUB_ADDR=""
CONFIG="https://raw.githubusercontent.com/galendu/rule/refs/heads/master/config/singbox-new/config_tun_v2_1.11.json"
DATE=`date +%s`
cd /etc/sing-box/
# 触发GitHub Actions
curl -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/workflows/$WORKFLOW_ID/dispatches \
  -d "{
	\"ref\": \"$BRANCH\",
	\"inputs\": {
		\"subscriptionAddress\": \"$SUB_ADDR\",
		\"stencilFile\": \"$CONFIG\",
		\"client\": \"$1\"
	}
}"
# 等待流水线运行完成（需要根据实际需求添加延迟或轮询逻辑）
sleep 40
# 获取流水线制品
ARTIFACTS_URL=$(curl -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs | jq -r '.workflow_runs[0].artifacts_url')

# 下载制品
curl -L -H "Authorization: token $GITHUB_TOKEN" $ARTIFACTS_URL | jq -r '.artifacts[].archive_download_url' | while read url; do
  curl -L -O -H "Authorization: token $GITHUB_TOKEN" "$url"
done
mv config.json config.json.bck-$DATE
unzip zip
rm -rf zip
