#!/bin/bash

echo "检测当前的网络接口..."
ip link show

read -p "输入切换网卡，不输入默认跳过: " user_input

if [ -n "$user_input" ]; then
    echo "正在将网卡名称替换为 $user_input..."
    find ./scripts -type f ! -name "*.md" -exec sed -i "s/tun0/$user_input/g" {} \;
fi

find . -type f ! -name "*.md" ! -name "*.*" -exec chmod +x {} \;

echo "正在将 scripts 目录下的文件复制到 /usr/local/bin..."
find ./scripts/ -type f ! -name "*.md" -exec cp {} /usr/local/bin/ \;

if [ ! -d "/usr/local/share/privEsc" ]; then
    echo "目标目录 /usr/local/share/privEsc 不存在，正在创建..."
    sudo mkdir -p /usr/local/share/privEsc
fi

echo "正在将 privEsc 目录下的文件复制到 /usr/local/share/privEsc..."
find ./privEsc -type f ! -name "*.md" -exec cp --parents {} /usr/local/share/privEsc/ \;

echo "所有操作完成！"
