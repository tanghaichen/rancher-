# !/bin/bash
SERVERS="10.42.0.123 12"
PASSWORD=111111
abc=$(pwd)
for SERVER in `cat ips.txt`
do
	# 批量创建文件夹
	echo 'no this dir and then will create it.'
	expect -c "set timeout -1;
		spawn ssh root@$SERVER mkdir -p /root/bin/ssh
	expect {
		*password:* {send -- $PASSWORD\r;exp_continue;}
		*(yes/no)* {send -- yes\r;exp_continue;}
		eof         {exit 0;}
	}"
    expect -c "set timeout -1;
		spawn scp ./ssh_non_pwd_login.sh $SERVER:/root/bin/ssh
	expect {
		*password:* {send -- $PASSWORD\r;exp_continue;}
		*(yes/no)* {send -- yes\r;exp_continue;}
		eof         {exit 0;}
	}"
	expect -c "set timeout -1;
		spawn ssh root@$SERVER /root/bin/ssh/ssh_non_pwd_login.sh $abc
	expect {
		*password:* {send -- $PASSWORD\r;exp_continue;}
		*(yes/no)* {send -- yes\r;exp_continue;}
		eof         {exit 0;}
	}"
done
