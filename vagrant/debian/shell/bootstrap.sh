echo "===BOOTSTRAP==="
echo "[Start] Update"
sudo apt -y update
echo "[END] Update"

echo "[Start] Upgrade"
sudo apt -y upgrade
echo "[END] Upgrade"

echo "[Start] Install (vim, wget, curl)"
sudo apt install -y vim wget curl
echo "[END] Install (vim, wget, curl)"