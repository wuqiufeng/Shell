#!/bin/bash
OUT_FILE=/home/work/web/resource/upload/updatefile_temp/
de_comp()
{
	FNAME=$1
	[ ! -e "$FNAME" ] && echo "NO file to decrypt" && exit 1
	echo "==> decompressing"
	openssl des3 -d -salt -k 123ace -in $FNAME | tar -xz -C $OUT_FILE &> /dev/null && exit 0 || exit 2
}

de_comp "$@"
