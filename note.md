<img width="725" height="337" alt="屏幕截图 2026-09-02 133051" src="https://github.com/user-attachments/assets/7a9cc4f3-9bc0-4f0e-a3d8-915e49e77cac" />

# Linux Shell
## 1. 文件系统

pwd                         # 显示当前目录

ls                          # 列出文件

ls -la                     # 显示所有文件（包括隐藏文件）及详细信息

cd <目录>                  # 切换目录

cd ..                      # 上级目录

cd -                       # 返回上次目录

## 2. 路径
   
绝对路径：从根 / 开始，如 /home/user/file

相对路径：从当前目录开始，. 表示当前目录，.. 表示上级目录

## 3. 查找文件

ls -l 文件名                    # 查看权限，如 -rwxr-xr-x

chmod +x 文件名                 # 添加执行权限

chmod 755 文件名                # 设置具体权限（rwxr-xr-x）

## 4. ./ 的含义

直接输入程序名时，Shell 只在 PATH 列出的目录中查找；使用 ./程序名 显式指定当前目录，绕过 PATH 搜索。

## 5. 环境变量与 PATH

PATH：冒号分隔的目录列表，Shell 按顺序查找可执行文件。

查看：echo $PATH

临时添加目录：export PATH="/path/to/dir:$PATH"

查看命令位置：which 命令 或 command -v 命令

注意：临时修改只在当前 Shell 有效，永久修改需写入 ~/.bashrc 或 ~/.profile。

## 6. 输入输出流与重定向

stdin（标准输入，0）：默认键盘。

stdout（标准输出，1）：正常输出，默认终端。

stderr（标准错误，2）：错误信息，默认终端。


### 重定向：
command > file          # stdout 写入文件（覆盖）

command >> file         # stdout 追加到文件

command 2> file         # stderr 写入文件

command 2>&1            # stderr 合并到 stdout

command > /dev/null     # 丢弃 stdout


### 管道：

command1 | command2 | command3


### tee：

从 stdin 读取数据，同时输出到终端和文件。

command | tee file.txt


## 7. 文本处理常用命令

grep     # 搜索文本

  -r     # 递归搜索
  
  -l     # 只输出文件名
  
  -c     # 统计匹配行数
  
  -o     # 只输出匹配部分
  
  -E     # 扩展正则表达式

cut      # 按分隔符提取列

  -d     # 指定分隔符
  
  -f     # 指定字段编号

sort     # 排序

  -u     # 去重
  
  -n     # 按数字排序
  
  -r     # 逆序

uniq     # 去重（需先排序）

  -c     # 统计出现次数

wc       # 统计行数、单词数、字节数

  -l     # 只统计行数

head / tail   # 显示文件开头/结尾

  -n     # 指定行数

  ### 常见组合示例：
  
#统计日志中 ERROR 出现次数：
grep -c "ERROR" log.txt

#提取包含 ERROR 的用户并排序去重：
grep "ERROR" log.txt | grep -o "user=[^ ]*" | cut -d'=' -f2 | sort -u

#找出出现次数最多的 IP：
cut -d' ' -f1 access.log | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}'


## 8. Bash 脚本编程

### 基本结构：
#!/usr/bin/env bash #脚本内容

### 变量：
name="value"

echo $name          #注意：不加引号可能被拆分

echo "$name"        #推荐加双引号


### 命令行参数：

$0：脚本名

$1、$2...：第 1、2 个参数

$#：参数个数

$@：所有参数（每个参数独立）

$*：所有参数（作为一个字符串）


### 条件判断：

if [ 条件 ]; then

    #命令
    
elif [ 条件 ]; then

    #命令
    
else

    #命令
    
fi


### 常用条件：

[ -f 文件 ]：文件存在且为普通文件

[ -d 目录 ]：目录存在

[ -x 文件 ]：文件可执行

[ $# -eq 0 ]：参数个数等于 0

[ "$var" = "value" ]：字符串相等


### 循环：

for file in "$@"; do

   echo "$file"
    
done

while [ 条件 ]; do

    #命令
    
done


### 函数：

function_name() {

    #命令
    
}


### 退出状态：

exit 0：成功

exit 1：失败（非零


## 9. 进程管理

ps aux                  # 查看所有进程

ps aux | grep 关键字    # 筛选进程

pgrep -f 关键字         # 按名称查找 PID

kill PID                # 发送 SIGTERM（正常终止）

kill -9 PID             # 发送 SIGKILL（强制终止）


### 后台运行：
在命令末尾加 &，如 ./script.sh &

### 查看后台任务：
jobs

## 问题出现与解决
1. 文件名包含空格

问题：Shell 会将空格作为分隔符，导致文件名被拆分。

解决：

使用引号："My File.txt" 或 'My File.txt'

使用转义：My\ File.txt

脚本中变量加双引号："$file"

2. 权限不足

现象：Permission denied

解决：chmod +x 文件名 添加执行权限。

3. command not found

原因：命令不在 PATH 中。

解决：

使用完整路径或 ./ 执行当前目录程序。

将目录临时加入 PATH：export PATH="$PWD/tools:$PATH"

