###  

```bash

openssl genpkey -algorithm RSA -out cer/key.pem
openssl req -new -key /cer/key.pem -out cer/csr.pem -subj "/CN=xx.xx.xx.xx"
openssl req -new -key cer/key.pem -out cer/csr.pem -subj "/CN=xx.xx.xx.xx"
openssl x509 -req -days 365 -in cer/csr.pem -signkey cer/key.pem -out cer/certificate.pem
openssl x509 -in cer/certificate.pem -text -noout
openssl x509 -noout -modulus -in certificate.pem | openssl md5
openssl rsa -noout -modulus -in key.pem | openssl md5
```
```json

    {
      "type": "trojan",
	  "tag": "ss",
      "server": "xx.xx.xx.xx",
      "server_port": 18081,
      "password": "xx",
      "tls": {
        "enabled": true,
        "server_name": "xx.xx.xx.xx",
        "insecure": true, 
        "utls": {
          "enabled": true,
		  "fingerprint": "chrome"
        }
      },
      "multiplex": {
        "enabled": true
      }
    }
```