
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
    "servers": [ #一组dns服务器
        "tag": "", # DNS 服务器的标签
        "address": "", # System: local TCP: tcp://1.0.0.1 8.8.8.8 UDP: udp://8.8.4.4 TLS:tls://dns.google HTTPS: https://1.1.1.1/dns-query QUTC: quic://dns.adguard.com  HTTP3: https://1.1.1.1/dns-query
        # Rcode: rcode://refused (屏蔽dns请求,在dns层面进行屏蔽)
            # success 无错误
            # format_error 请求格式错误
            # server_failure 服务器错误 
        # DHCP: dhcp://auto 或 dhcp://en0
        "address_resolver": "", # 如果用了域名,用于解析本 DNS 服务器的域名的另一个 DNS 服务器的标签
        "address_strategy": "", # 用于解析本 DNS 服务器的域名的策略 可以解析为 ipv4 ipv6 或者ipv4 优先..
        "strategy": "", #做dns请求的时候  ipv4 ipv6 或者ipv4 优先..
        "detour": "", #那个出栈方式查询dns
        "client_subnet": "" 
    ],
    "rules": [
      
    ],
    "final": "", #默认dns服务器的标签,默认使用第一个服务器。
    "strategy": "", #可选值: prefer_ipv4 prefer_ipv6 ipv4_only ipv6_only
    "disable_cache": false, #禁用dns的缓存,不建议通过sing-box做
    "disable_expire": false, #缓存过期时间
    "independent_cache": false, #是否启用独立的缓存
    "cache_capacity": 0,
    "reverse_mapping": false, #dns反向解析是否开启
    "client_subnet": "", #带有指定ip前缀的扩展dns的记录添加到查询中去, 192.168.0.1/24 前缀匹配,应用于cdn
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
      "tag": "hk2"
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

## 常用的代理模式  
redirect/tproxy iptables/nftables

iptables -t mangle -A XRAY -p tcp -j TPROXY --on-port 12345 --tproxy-mark 1
iptables -t mangle -A XRAY -p udp -j TPROXY --on-port 12345 --tproxy-mark 1
### tun
tun ip rule,route table
tun模式增加的内容
tun端口
ip rule
route tables

主路由表
ip route show table main

ip route show table 2022

[root@Kwrt:09:17 PM /etc/sing-box] # ip rule list
0:	from all lookup local
9000:	from all to 172.20.0.0/30 lookup 2022
9001:	from all lookup 2022 suppress_prefixlength 0
9002:	not from all dport 53 lookup main suppress_prefixlength 0
9002:	from all ipproto icmp goto 9010
9002:	from all iif tun0 goto 9010
9003:	not from all iif lo lookup 2022
9003:	from 0.0.0.0 iif lo lookup 2022
9003:	from 172.20.0.0/30 iif lo lookup 2022
9010:	from all nop
32766:	from all lookup main
32767:	from all lookup default

ip route 
192.168.10.16/28 lookup main