current_timestamp=$(date +%Y-%m-%d_%H.%M.%S)
log_dir="$HOME/logs/docker/base-xfce/$current_timestamp"

mkdir -p $log_dir

host_ip_cmd=($(echo $(hostname -I) | tr ' ' '\n'))
proxy_ip="${host_ip_cmd[0]}"
proxy_port="3128"
# Replace Proxy with company proxy:
proxy="http://$proxy_ip:$proxy_port"
echo "Using proxy: $proxy"
echo "Log Dir: $log_dir"

docker build -f Dockerfile.base.3.xfce -t ackdev/secure_proxy_securitas-wall-base-xfce:2019-09-22-r1 . \
	--build-arg http_proxy="$proxy" --build-arg https_proxy="$proxy" 2>&1 | tee "$log_dir/docker_build.out"
