#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts q: option
do
  case "${option}"
  in
    q) QUIET=${OPTARG};;
  esac
done

url='https://github.com/xxh/linuxdeploy-plugin-python/releases/download/continuous/xonsh-master-x86_64.AppImage'
appimage_name='xonsh'

rm -rf $build_dir
mkdir -p $build_dir

for f in entrypoint.sh xonshrc.xsh
do
    cp $CDIR/$f $build_dir/
done

cd $build_dir

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

if [ -x "$(command -v wget)" ]; then
  wget $arg_q $arg_progress $url -O $appimage_name
elif [ -x "$(command -v curl)" ]; then
  curl $arg_s -L $url -o $appimage_name
else
  echo Install wget or curl
fi

chmod +x $appimage_name