### server https to localhost

`/server/ssl` - certificate files
Should use git bash to run `generate-certificates.sh` so that it will generate `ca.crt` (import to chrome browser `https certificates manager`), `server.crt`, `server.key` ...


### client https to localhost

`.env` file setting
```
HTTPS=true
```
