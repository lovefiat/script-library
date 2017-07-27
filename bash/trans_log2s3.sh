#!/bin/bash

#####################################################################
#
# サンプルスクリプト: S3ログ転送
#
#####################################################################

CMD="aws s3 mv"
BUCKET=bucket-name

# プレフィックスなどに使う EC2/InstanceId
ORIGIN=`bash get_instanceid.sh`

# 元情報の定義
SRCDIR=/var/log/tomcat
FILT=catalina.*.log

# その他の定義
DSTDIR=s3://${BUCKET}/tomcat/${ORIGIN}/logs
FILE_AR=()

# 引数取り込み
if [ $# -eq 3 ] ; then
  if [ $1 = "-test" ] ; then
    # -test 引数
    CMD="echo TEST$ "${CMD}
    SRCDIR=$2
    FILT=$3
  elif [ $1 = "-exec" ] ; then
    # -exec 引数
    SRCDIR=$2
    FILT=$3
  else
    echo "Usage: $0 [-exec|-test] src_dir filter"
    exit 1
  fi
else
  # 引数に不備
  echo "Usage: $0 [-exec|-test] src_dir filter"
  exit 1
fi

# ソースディレクトリより特定ファイルのリストを得る
if [ -f $SRC ] ; then
  SRC=$SRCDIR/$FILT
  for filepath in $SRC; do
    FILE_AR+=($filepath)
    echo $filepath
  done
fi

# 得られたリストよりもっとも新しいもの以外を移動する
declare -i NUM=${#FILE_AR[@]}-1
FILE_AR=("${FILE_AR[@]:0:$NUM}")

for i in ${FILE_AR[@]} ; do
  $CMD $i $DSTDIR/
done

exit 0
