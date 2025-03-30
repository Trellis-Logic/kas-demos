#!/bin/sh
rtn=0
failtext="ERROR: "
failure() {
    echo "${failtext} $1"
    rtn=1
}

checklink() {
    rootfsdir=$1
    targetdir=/data/symlinks$rootfsdir
    [ -h ${rootfsdir} ] || failure "${rootfsdir} not setup as symlink"
    target=$(realpath $(dirname $rootfsdir)/$(readlink ${rootfsdir}))
    [ "${target}" == "${targetdir}" ] || failure "${rootfsdir} pointing to ${target} instead of expected ${targetdir}"
}

cat /etc/mtab  | grep '^overlay /home' || failure "home overlay does not exist"
cat /etc/mtab | awk '{ if ($2 == "/") { print } else { next } }' | grep "ro" || failure "rootfs is not read only"

datapart_size_blocks=$(df  /data | awk '{ print $4 }' | tail -n 1)
[ $datapart_size_blocks -gt 1000000 ] || failure "/data partition is ${datapart_size_blocks}, did growfs fail?"

checklink /var/log
checklink /etc/ssh/keys

if [ $rtn -eq 0 ]; then
    echo "All tests succeeded"
else
    echo "At least one test failed"
fi 
exit $rtn
