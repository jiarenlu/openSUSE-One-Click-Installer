#!/bin/bash

# 修改语言为英语，确保命令的输出都是英语，这样对命令输出的处理就不会出错了
OLD_LANG=$LANG
export LANG=default
SCRIPT_DIR=$(dirname $0)

if [ ! -f $SCRIPT_DIR/README.md ]; then
  wget -nd -c -P $SCRIPT_DIR --no-check-certificate --no-cookies  "https://raw.github.com/cdadar/openSUSE-One-Click-Installer/master/README.md"
fi
if [ ! -f $SCRIPT_DIR/ooci.conf ]; then
  wget -nd -c -P $SCRIPT_DIR --no-check-certificate --no-cookies  "https://raw.github.com/cdadar/openSUSE-One-Click-Installer/master/ooci.conf"
fi

cat "$SCRIPT_DIR/README.md"
read -p "你确定继续吗？ (Y|n) : " confirm_continue

if [ -z "$confirm_continue" ]; then
  confirm_continue="Y"
fi
if [ "$confirm_continue" == "n" -o "$confirm_continue" == "no" ]; then
  exit
fi

sudo zypper -n in -l lsb-release


. $SCRIPT_DIR/ooci.conf

OSVER=$(lsb_release -r|awk '{print $2}')
ARCH=$(uname -m)

TMP_DIR=`mktemp -d`

# 禁用 cd 源
if [ "$disable_cd_repo" != "0" ]; then
  CD_REPO_ID=`zypper lr -u | awk -F'[|+]'  '$6 ~ /^\s*cd:\/\// {print $1}'`

  if [ -n "$CD_REPO_ID" ]; then
      sudo zypper mr -d $CD_REPO_ID
  fi
fi

# 添加软件源
# w32codec-all 需要该源
#sudo zypper --gpg-auto-import-keys ar -c  http://packman.inode.at/suse/openSUSE_Leap_$OSVER/ packman

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/home:/opensuse_zh/openSUSE_Leap_$OSVER/ opensusu_zh

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/home:/jiarenlu/openSUSE_Leap_$OSVER/ jiarenlu
#sudo zypper --gpg-auto-import-keys ar http://repo.fdzh.org/chrome/ google-chrome-stable

#sudo zypper --gpg-auto-import-keys ar -c https://download.opensuse.org/repositories/Virtualization/openSUSE_Leap_$OSVER/ virtualization

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/editors/openSUSE_Leap_$OSVER/ editors 

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/M17N:/fonts/openSUSE_Leap_$OSVER/  M17N:fonts

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/devel:/languages:/nodejs/openSUSE_Leap_$OSVER/ nodejs

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/devel:/languages:/php/openSUSE_Leap_$OSVER/ php

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_$OSVER/ go

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/devel:/languages:/rust/openSUSE_Leap_$OSVER/ rust

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/devel:/tools/openSUSE_Leap_$OSVER/ devel:tools

#sudo zypper --gpg-auto-import-keys ar -c http://download.opensuse.org/repositories/server:/mail/openSUSE_Leap_$OSVER/ mail

#sudo zyppr --gpg-auto-import-keys ar -c  http://download.opensuse.org/repositories/server:/database:/postgresql/openSUSE_Leap_$OSVER postgresql

#sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

#sudo zypper addrepo -g -f https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# 刷新软件源并更新系统
sudo zypper --gpg-auto-import-keys ref

sudo zypper -n update -l

sudo zypper -n in -l nodejs8

sudo zypper -n in -l emacs emacs-el

sudo zypper -n in -l etags

sudo zypper -n in -l ctags

sudo zypper -n in -l fd

sudo zypper -n in -l global

sudo zypper -n in -l git

# 压缩，解压 rar 文件
sudo zypper -n in -l rar unrar

# 支持 7zip 压缩包
sudo zypper -n in -l p7zip

# 安装了该包后 ark 打开一些 windows 下创建的 zip 时不再乱码
# 这些 zip 包中的文件名实际上是以 GBK 编码的
sudo zypper -n in -l unzip-rcc

sudo zypper -n in -l gcc-c++ gcc

sudo zypper -n in -l cmake

sudo zypper -n in -l clang llvm-devel

sudo zypper -n in -l tmux 

sudo zypper -n in -l vim

# sudo zypper -n in -l xsel

sudo zypper -n in -l xclip

sudo zypper -n in -l aspell

sudo zypper -n in -l sbcl

sudo zypper -n in -l osc rpmdevtools

sudo zypper -n in -l the_silver_searcher

sudo zypper -n in -l ripgrep

sudo zypper -n in -l docker docker-compose

sudo zypper -n in -l xterm

sudo zypper -n in -l mu4e

# sudo zypper -n in -l sublime-text

sudo zypper -n in -l noto-serif-sc-fonts-full

# sudo zypper -n in -l noto-serif-tc-fonts-full noto-serif-jp-fonts-full noto-serif-kr-fonts-full

sudo zypper -n in -l hack-font

sudo zypper -n in -l postgresql postgresql-server postgresql-contrib postgresql-devel

sudo zypper -n in -l texlive texlive-latex  texlive-xetex texlive-ctex

sudo zypper -n in -l texlive-cjkpunct texlive-wrapfig texlive-capt-of 

sudo zypper -n in -l scrot

sudo zypper -n in -l screenfetch

# sudo zypper -n in jiarenlu:bcloud

sudo zypper -n in -l libnotify-tools

sudo zypper -n in -l redis

sudo zypper -n in -l wqy-bitmap-fonts

sudo zypper -n in -l wqy-microhei-fonts

sudo zypper -n in -l wqy-zenhei-fonts

sudo zypper -n in -l syslog-ng syslog-service

sudo npm install -g yarn

sudo yarn global add  webpack

sudo yarn global add  webpack-cli

sudo yarn global add  gitbook-cli

sudo yarn global add vue-cli

sudo yarn global add angular-cli

sudo yarn global add create-react-app

sudo yarn global add prettier

if [ "$translate_user_dirs_names_from_chinese_to_english" != "0" ]; then
    export LANG=default
    xdg-user-dirs-update --force
    cd ~/桌面/ && ls -A | xargs -i mv -f {} ~/Desktop/ && rmdir ~/桌面
    cd ~/下载/ && ls -A | xargs -i mv -f {} ~/Downloads/ && rmdir ~/下载
    cd ~/模板/ && ls -A | xargs -i mv -f {} ~/Templates/ && rmdir ~/模板
    cd ~/公共/ && ls -A | xargs -i mv -f {} ~/Public/ && rmdir ~/公共
    cd ~/文档/ && ls -A | xargs -i mv -f {} ~/Documents/ && rmdir ~/文档
    cd ~/音乐/ && ls -A | xargs -i mv -f {} ~/Music/ && rmdir ~/音乐
    cd ~/图片/ && ls -A | xargs -i mv -f {} ~/Pictures/ && rmdir ~/图片
    cd ~/视频/ && ls -A | xargs -i mv -f {} ~/Videos/ && rmdir ~/视频
fi


#TODO 将github管理的配置处理