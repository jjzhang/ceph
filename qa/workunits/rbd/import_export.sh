#!/bin/sh -ex

# create a sparse file
dd if=/bin/sh of=/tmp/img bs=1k count=1 seek=10
dd if=/bin/dd of=/tmp/img bs=1k count=10 seek=100
dd if=/bin/rm of=/tmp/img bs=1k count=100 seek=1000
dd if=/bin/ls of=/tmp/img bs=1k seek=10000
dd if=/bin/ln of=/tmp/img bs=1k seek=100000
dd if=/bin/grep of=/tmp/img bs=1k seek=1000000

rbd rm testimg || true

rbd import $RBD_CREATE_ARGS /tmp/img testimg
rbd export testimg /tmp/img2

cmp /tmp/img /tmp/img2

rm /tmp/img /tmp/img2

echo OK
