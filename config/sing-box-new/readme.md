
## 

```bash
{
  "log": {
    "disabled": false, 
    "level": "info", #日志级别,支持 trace debug info warn error fatal panic
    "output": "box.log",
    "timestamp": true
  },
  "dns": {
    "servers": [
        "tag": "", # DNS 服务器的标签
        "address": "", 
        "address_resolver": "", # 用于解析本 DNS 服务器的域名的另一个 DNS 服务器的标签
        "address_strategy": "", # 用于解析本 DNS 服务器的域名的策略
        "strategy": "", #默认解析策略
        "detour": "", #用于连接到 DNS 服务器的出站的标签
        "client_subnet": ""
    ],
    "rules": [],
    "final": "", #默认dns服务器的标签,默认使用第一个服务器。
    "strategy": "", #可选值: prefer_ipv4 prefer_ipv6 ipv4_only ipv6_only
    "disable_cache": false,
    "disable_expire": false,
    "independent_cache": false,
    "cache_capacity": 0,
    "reverse_mapping": false,
    "client_subnet": "",
    "fakeip": { #虚假ip地址段
        "enabled": true,
        "inet4_range": "198.18.0.0/15",
        "inet6_range": "fc00::/18"
    }
  },
  "endpoints": [],
  "inbounds": [
#     auto_route 自动添加路由
#     sniff 嗅探 tun必须配置为true
    {"type": "tun","address": ["172.20.0.1/30"],"auto_route": true,"sniff": true}
  ],
  "outbounds": [
    {"type": "direct","tag": "direct"},
    {"type": "hysteria2","tag": "site","server": "site.abc.com","server_port": 16060,"password": "yourpassWD","tls": {"enabled": true} },
        {
      "tag": "hk2",
      "type": "trojan",
      "server": "wb.kaiqsz.com",
      "server_port": 47119,
      "password": "a9a3c58c-78fd-42f7-9aac-67adb1019c9f",
      "tls": {
        "enabled": true,
        "insecure": true,
        "server_name": "mm1.redapricotcloud.com"
      }
    },
    {"type": "block","tag": "block"}, #阻塞
    {"type": "dns","tag": "dns-out"} #dns流量的处理,可以直接使用
  ],
    "route": {
    "rules": [
      {"protocol": "dns","outbound": "dns-out"}, # 通过dns-out出去
      {"rule_set": ["geoip-cn"],"outbound": "direct"},
      {"rule_set": ["geosite-gfw"],"outbound": "site"},
      {"rule_set": ["geosite-ads-all"],"outbound": "block"}
    ],
    "rule_set": [
      {"tag":"geoip-cn","type":"remote","format":"binary","url":"https://raw.githubusercontent.com/galendu/meta-rules-dat/sing/geo/geoip/cn.srs","download_detour":"site"},
      {"tag": "geosite-gfw","type": "remote","format": "binary","url": "https://raw.githubusercontent.com/galendu/meta-rules-dat/blob/sing/geo/geosite/gfw.srs","download_detour": "site"},
      {"tag": "geosite-ads-all","type": "remote","format": "binary","url": "https://raw.githubusercontent.com/galendu/meta-rules-dat/blob/sing/geo/geosite/category-ads-all.srs","download_detour": "site"}
    ],
    "auto_detect_interface": true, #turn,避免出现回路必须配置为true
    "final": "direct" #前面的规则都不匹配的时候direct
  },
  "experimental": {}
}
```

**level**
日志等级，可选值：trace debug info warn error fatal panic。  

