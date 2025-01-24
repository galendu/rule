## sing-box配置方法  
### 通过github-action进行sing-box配置文件的生成  

### tproxy 

```bash
## 拦截数据包
ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100

iptables -t managle -N PROXY
iptables -t managle -A PROXY -d 255.255.255.255/32 -j RETURN
iptables -t managle -A PROXY -d 192.168.200.0/24 -j RETURN #内网流量不走代理
iptables -t managle -A PROXY -d 192.168.12.0/24 -j RETURN # wan口流量不走代理
iptables -t managle -A PROXY -p tcp -j TPROXY --on-port 1080 --on-ip 127.0.0.1 --tproxy-mark 1
iptables -t managle -A PROXY -p udp -j TPROXY --on-port 1080 --on-ip 127.0.0.1 --tproxy-mark 1
iptables -t managle -A PREROUTING -j PROXY

iptabels -t managle -I PROXY 2 -d 192.168.12.0/24 -j RETURN
iptabels -t managle -I PROXY -d 255.255.255.255/32 -j RETURN

## 代理本机流量--代理自己
iptables -t managle -N PROXY_SELF
iptables -t managle -A PROXY_SELF -d 255.255.255.255/32 -j RETURN
iptables -t managle -A PROXY_SELF -d 192.168.200.0/24 -j RETURN #内网流量不走代理
iptables -t managle -A PROXY_SELF -d 192.168.12.0/24 -j RETURN # wan口流量不走代理
#iptables -t managle -A PROXY_SELF -d 远端服务器IP/32 -j RETURN
#标记代理流量 sing-box不需要配置
#iptables -t managle -A PROXY_SELF -m mark --mark 0xff -j RETURN
#避免回环--uid,gid
#iptables -t managle -A PROXY_SELF -m owner -uid-owner|--gid-owner -j RETURN
iptables -t managle -A PROXY_SELF -j MARK --set-mark 1
iptables -t managle -A OUTPUT -j PROXY_SELF
```
