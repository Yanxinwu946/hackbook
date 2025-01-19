#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "脚本必须以 sudo 权限运行，请使用 sudo 执行该脚本！"
    exit 1
fi

echo "检测当前的网络接口..."
ip link show

read -p "输入切换网卡，不输入默认跳过: " user_input

if [ -n "$user_input" ]; then
    echo "正在将网卡名称替换为 $user_input..."
    find ./scripts -type f ! -name "*.md" -exec sed -i "s/tun0/$user_input/g" {} \;
fi

find . -type f ! -name "*.md" -exec chmod +x {} \;

echo "正在将 scripts 目录下的文件复制到 /usr/local/bin..."
find ./scripts -type f ! -name "*.md" -exec cp {} /usr/local/bin/ \;

echo "正在将 privEsc 目录下的文件复制到 /usr/local/share/privEsc..."
find ./privEsc -type f ! -name "*.md" -exec cp --parents {} /usr/local/share/privEsc/ \;

echo "所有操作完成！"
