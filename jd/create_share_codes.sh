#!/bin/sh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets"
export LC_ALL=C

## 按以下格式修改为自己的种豆得豆互助码，每个互助码间使用换行来分开，首尾一对引号
## 如不需要提交此互助码，删除互助码即可
ShareCodesBean="4npkonnsy7xi2k62fqogk7iajgxtj4s27j2bruq
mlrdw3aw26j3xrqoiet4xrq2yp4fgh4hh7t5bda
olmijoxgmjutzelzs6eburwzv3awn47x723bijq"

## 按以下格式修改为自己的东东农场互助码，每个互助码间使用换行来分开，首尾一对引号
## 如不需要提交此互助码，删除互助码即可
ShareCodesFarm="489596bcebf54d68bb3e9c6858b99124
a32c4f30ab2a4240a0295eb7e675422d
927029bf64fc43739b369c0a71d95e15"

## 按以下格式修改为自己的东东萌宠互助码，每个互助码间使用换行来分开，首尾一对引号
## 如不需要提交此互助码，删除互助码即可
ShareCodesPet="MTAxODc2NTEzOTAwMDAwMDAyNzA4ODEyNQ==
MTE1NDQ5OTUwMDAwMDAwMzYxMDQwOTM=
MTAxODExNDYxMTEwMDAwMDAwNDA1NjI2ODk="

## 如果你希望在向服务器提交互助码后反馈提交结果，请补充ServerChan的SCKEY
## 教程：http://sc.ftqq.com/3.version
## 我懒，只做了ServerChan的通知渠道，其他不想做
SCKEY="SCU91656T8b104ca9139f901c9a53d477a3bb2f575f4de444ce081"


################################## 以下勿动 ##################################
## 路径
ShellDir=$(cd $(dirname $0); pwd)
RootDir=$(cd $(dirname $0); cd ..; pwd)
ScriptsDir=${RootDir}/scripts
LogDir=${RootDir}/log
LogFile=${LogDir}/create_share_codes/create_share_codes.log
CreateURLBean="http://api.turinglabs.net/api/v1/jd/bean/create/"
CreateURLFarm="http://api.turinglabs.net/api/v1/jd/farm/create/"
CreateURLPet="http://api.turinglabs.net/api/v1/jd/pet/create/"
URLServerChan="https://sc.ftqq.com/"

## 删除旧的日志，创建新的日志
if [ ! -d ${LogDir}/create_share_codes ]; then
  mkdir -p ${LogDir}/create_share_codes
fi
cd ${LogDir}/create_share_codes/
rm -f ${LogFile}
touch ${LogFile}

# 提交种豆得豆互助码
function CreateCodesBean {
  echo -e "种豆得豆：\n\n" >> ${LogFile}
  for Code in ${ShareCodesBean}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLBean}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo -e "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo -e "\n\n" >> ${LogFile}
}


## 提交东东农场互助码
function CreateCodesFarm {
  echo -e "东东农场：\n\n" >> ${LogFile}
  for Code in ${ShareCodesFarm}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLFarm}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo -e "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo -e "\n\n" >> ${LogFile}
}

## 提交东东萌宠互助码
function CreateCodesPet {
  echo -e "东东萌宠：\n\n" >> ${LogFile}
  for Code in ${ShareCodesPet}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLPet}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo -e "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo -e "\n\n" >> ${LogFile}
}

## 向服务器提交互助码
if [ -n "${ShareCodesBean}" ]; then
  CreateCodesBean
fi

if [ -n "${ShareCodesFarm}" ]; then
  CreateCodesFarm
fi

if [ -n "${ShareCodesPet}" ]; then
  CreateCodesPet
fi

## 向方糖发送消息
if [ -n "${SCKEY}" ]; then
  desp=$(cat ${LogFile})
  wget -q --output-document=/dev/null --post-data="text=互助码提交状态&desp=${desp}" ${URLServerChan}${SCKEY}.send
fi
