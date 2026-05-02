#!/bin/bash

LFS=${LFS:-"/mnt/lfs"}
YBLD=${YBLD:-"/ybuild"}
SRC=${SRC:-"$LFS/$YBLD/sources"}
wgetfile="wget-list-systemd"
touch $YBLD/sha256sums

while IFS=' ' read -r url; do
	[[ $url == \#* ]] && continue

    file=$(basename ${url})
    if [[ ! -f "${SRC}/${file}" ]]; then
        echo "Getting: ${file}"
        wget -c -nc -P ${SRC} ${url}
    fi

    if [[ -f "${SRC}/${file}" ]]; then
        sha256=$(sha256sum "${SRC}/${file}" | awk '{print $1}')
		echo $sha256 >> $YBLD/sha256sums
    else
        echo "${file} Does Not Exist At ${SRC}"
    fi

done < ${wgetfile}
