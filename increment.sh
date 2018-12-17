
#!/bin/bash


gid=5073;#create new gid
next_gid=$[$gid+1]
sed -i '' -e "/#create new gid$/s/=.*#/=$next_gid;#/" ${0}
echo $gid > gid
