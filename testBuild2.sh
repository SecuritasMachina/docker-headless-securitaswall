CURRENT_TIMESTAMP=$(date +%Y-%m-%d_%H.%M)
logDir="$HOME/logs/docker/secure_proxy_securitas-wall/test-$CURRENT_TIMESTAMP"
mkdir -p $logDir
echo "Log Dir: $logDir"
tmpfile=$(mktemp)
export TEMPDIR=$(mktemp -d)

host_ip_cmd=($(echo $(hostname -I) | tr ' ' '\n'))
proxy_ip="${host_ip_cmd[0]}"
proxy_port="3128"
# Replace Proxy with company proxy:
proxy="http://$proxy_ip:$proxy_port"
echo "Using proxy: $proxy"
CURRENT_TIMESTAMP=$(cat "last_build_ts") 
 
docker run --cap-add=NET_ADMIN -it -e VNC_RESOLUTION=1800x900 \
	-e HTTP_PROXY="$proxy" -e HTTPS_PROXY="$proxy" -e http_proxy="$proxy" \
	-e https_proxy="$proxy" -v $volume_path:/home/hostVolume \
	ackdev/secure_proxy_securitas-wall:$CURRENT_TIMESTAMP
