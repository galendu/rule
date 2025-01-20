#!/bin/bash

mkdir -p sing/geo/geosite
mkdir -p sing/geo/geoip
mkdir -p sing/geo-lite/geoip

func_down(){
local url=$1 
local target_path=$2 
local temp_file=$(mktemp) # 下载文件到临时路径 
curl -o "$temp_file" "$url" # 替换目标路径中的文件 
mv "$temp_file" "$target_path"
}


func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/category-ai-chat-!cn.srs "sing/geo/geosite/category-ai-chat-!cn.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/youtube.srs "sing/geo/geosite/youtube.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/google.srs  "sing/geo/geosite/google.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/github.srs   "sing/geo/geosite/github.srs"     
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/telegram.srs  "sing/geo/geosite/telegram.srs"  
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/tiktok.srs     "sing/geo/geosite/tiktok.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/netflix.srs     "sing/geo/geosite/netflix.srs"   
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/apple.srs     "sing/geo/geosite/apple.srs"     
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/microsoft.srs      "sing/geo/geosite/microsoft.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/onedrive.srs     "sing/geo/geosite/onedrive.srs"  
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/geolocation-!cn.srs "sing/geo/geosite/geolocation-!cn.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/cn.srs      "sing/geo/geosite/cn.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/private.srs  "sing/geo/geosite/private.srs "
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geoip/google.srs    "sing/geo/geoip/google.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geoip/telegram.srs  "sing/geo/geoip/telegram.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geoip/netflix.srs   "sing/geo/geoip/netflix.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo-lite/geoip/apple.srs "sing/geo-lite/geoip/apple.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geoip/cn.srs     "sing/geo/geoip/cn.srs"
func_down https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geoip/private.srs "sing/geo/geoip/private.srs"
