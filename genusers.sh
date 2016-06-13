#!/bin/sh

USERS="$(seq 11 21)"

genuser() {
cat <<-EOF
[$1]
secret=$1
host=dynamic

EOF
}

for u in $USERS; do
r=$(( $u + 20 ))
genuser $u
genuser $r
done
