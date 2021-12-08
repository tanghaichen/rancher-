# !/bin/bash
SERVERS="10.42.0.123"
PASSWORD=111111


auto_gen_ssh_key() {
    expect -c "set timeout -1;
    	spawn ssh-keygen;
	expect {
	    *(/root/.ssh/id_rsa)* {send -- \r;exp_continue;}
		*passphrase)* {send -- \r;exp_continue;}
		*again*	{send -- \r;exp_continue;}
		*(y/n)* {send -- y\r;exp_continue;}
		*password:* {send -- $PASSWORD\r;exp_continue;}
		eof         {exit 0;}
	}";
}

auto_ssh_copy_id() {
	expect -c "set timeout -1;
    	spawn ssh-copy-id $1;
	expect {
	    *(yes/no)*  {send -- yes\r;exp_continue;}
	    *password:* {send -- $2\r;exp_continue;}
	    eof         {exit 0;}
	}";
}

auto_copy_id_to_all() {
	for SERVER in `cat  $ser`
    do
         auto_ssh_copy_id $SERVER $PASSWORD
    done
}

ser=$1/ips.txt

auto_gen_ssh_key
auto_copy_id_to_all