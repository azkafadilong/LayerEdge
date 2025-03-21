#!/bin/bash
set -e  # Dừng script ngay khi có lỗi

# Hiển thị ASCII Art
echo -e "\033[32m"
cat << "EOF"


 ▄▄       ▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄       ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄       ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
▐░░▌     ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
▐░▌░▌   ▐░▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌      ▀▀▀▀█░█▀▀▀▀ ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌      ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀ 
▐░▌▐░▌ ▐░▌▐░▌▐░▌          ▐░▌       ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌▐░▌    ▐░▌          ▐░▌     ▐░▌       ▐░▌     ▐░▌     
▐░▌ ▐░▐░▌ ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌          ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌ ▐░▌   ▐░▌          ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌     
▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌          ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌          ▐░▌     ▐░░░░░░░░░░░▌     ▐░▌     
▐░▌   ▀   ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌          ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌   ▐░▌ ▐░▌          ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌     
▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌    ▐░▌▐░▌          ▐░▌     ▐░▌       ▐░▌     ▐░▌     
▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌          ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌     ▐░▐░▌          ▐░▌     ▐░▌       ▐░▌ ▄▄▄▄█░█▄▄▄▄ 
▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌          ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌      ▐░░▌          ▐░▌     ▐░▌       ▐░▌▐░░░░░░░░░░░▌
 ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀            ▀       ▀         ▀  ▀         ▀  ▀        ▀▀            ▀       ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀ 
                                                                                                                                            


EOF
echo -e "\033[0m"

# Nhập Private Key từ người dùng
echo -e "\033[33mPlease enter your CLI Node Private Key:\033[0m"
read -rs PRIVATE_KEY  # `-r` giữ nguyên ký tự backslash, `-s` ẩn đầu vào

# Chờ 3 giây
echo "Starting installation..."
sleep 3

# Cập nhật hệ thống
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Cài đặt dependencies
echo "Installing dependencies..."
sudo apt install -y build-essential clang pkg-config git wget

# Kiểm tra và cài đặt Go nếu chưa có
if ! command -v go &>/dev/null; then
    echo "Installing Go..."
    GO_VERSION="1.22.1"
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
    source ~/.profile
    rm -f go${GO_VERSION}.linux-amd64.tar.gz
else
    echo "Go is already installed: $(go version)"
fi

# Clone repository nếu chưa có
if [ ! -d "light-node" ]; then
    echo "Cloning repository..."
    git clone https://github.com/Layer-Edge/light-node.git
fi
cd light-node

# Thiết lập biến môi trường
echo "Setting up environment variables..."
cat > .env <<EOF
GRPC_URL=grpc.testnet.layeredge.io:9090
CONTRACT_ADDR=cosmos1ufs3tlq4umljk0qfe8k5ya0x6hpavn897u2cnf9k0en9jr7qarqqt56709
ZK_PROVER_URL=https://layeredge.mintair.xyz/
API_REQUEST_TIMEOUT=100
POINTS_API=https://light-node.layeredge.io
PRIVATE_KEY='$PRIVATE_KEY'
EOF

# Xây dựng Light Node
echo "Building Light node..."
go mod tidy
go build -o light-node
sleep 3

# Tạo service systemd
echo "Creating Light Node Service file..."
sudo install -m 644 /dev/null /etc/systemd/system/layer-edge.service
sudo bash -c 'cat > /etc/systemd/system/layer-edge.service' <<EOF
[Unit]
Description=Layer Edge Light Node
After=network.target

[Service]
Type=simple
User=$(whoami)
WorkingDirectory=$HOME/light-node
ExecStart=$HOME/light-node/light-node
Restart=always
RestartSec=5
EnvironmentFile=$HOME/light-node/.env
Environment="PATH=/usr/local/go/bin:/usr/bin:/bin:$HOME/.cargo/bin:$HOME/.risc0/bin"

[Install]
WantedBy=multi-user.target
EOF

# Khởi động service
echo "Starting service..."
sudo systemctl daemon-reload
sudo systemctl enable layer-edge
sudo systemctl restart layer-edge

# Hoàn tất cài đặt
echo -e "\033[32mInstallation completed!\033[0m"
echo -e "\033[34mTo view logs:\033[0m"
echo -e "\033[33mLight Node:\033[0m journalctl -fo cat -u layer-edge \033[35m(wait a bit for it to load)\033[0m"
echo -e "\033[34mTo check service status:\033[0m sudo systemctl status layer-edge"
