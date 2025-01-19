#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "脚本必须以 sudo 权限运行，请使用 sudo 执行该脚本！"
    exit 1
fi

echo "检测本机网络接口..."
ip link show

# 从 ./scripts/stage 文件中定位网卡名称
current_interface=$(grep -oP '# Get current IP on \K\w+' ./scripts/stage)

# 检查是否找到了网卡名称
if [ -n "$current_interface" ]; then
    echo "当前脚本应用的网卡是: $current_interface"
    
    # 提示用户输入新的网卡名称
    read -p "输入切换的网卡（不输入默认跳过）: " user_input
    
    # 如果用户输入了新网卡名称，则进行替换
    if [ -n "$user_input" ]; then
        echo "正在将网卡名称替换为 $user_input..."
        find ./scripts -type f ! -name "*.md" -exec sed -i "s/$current_interface/$user_input/g" {} \;
    fi
else
    echo "未在 ./scripts/stage 文件中找到当前网卡名称，无法进行替换。"
fi

find . -type f ! -name "*.md" -exec chmod +x {} \;

echo "正在将 scripts 目录下的文件复制到 /usr/local/bin..."
find ./scripts -type f ! -name "*.md" -exec cp {} /usr/local/bin/ \;

echo "正在将 privEsc 目录下的文件复制到 /usr/local/share/privEsc..."
find ./privEsc -type f ! -name "*.md" -exec cp --parents {} /usr/local/share/privEsc/ \;

echo "所有操作完成！"
