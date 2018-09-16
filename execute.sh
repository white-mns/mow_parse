#!/bin/bash

CURENT=`pwd`	#実行ディレクトリの保存
cd `dirname $0`	#解析コードのあるディレクトリで作業をする

#------------------------------------------------------------------
# 更新回数、再更新番号の定義確認、設定


# 更新回数の指定がない場合h処理しない
if [ -z "$1" ]; then
    exit
fi

RESULT_NO=`printf "%03d" $1`
GENERATE_NO=$2

# 再更新番号の指定がない場合、もっとも再更新番号の大きいファイルを探索して実行する
if [ -z "$2" ]; then
    for ((GENERATE_NO=5;GENERATE_NO >=0;GENERATE_NO--)) {
        
        if [ $GENERATE_NO -eq 0 ]; then
            ZIP_NAME=${RESULT_NO}
        else
            ZIP_NAME=${RESULT_NO}_$GENERATE_NO
        fi

        echo "test $ZIP_NAME"
        if [ -f ./data/utf/${ZIP_NAME}.zip ]; then
            echo "execute $ZIP_NAME"
            break
        fi
    }
fi

if [ $GENERATE_NO -eq 0 ]; then
    ZIP_NAME=${RESULT_NO}
else
    ZIP_NAME=${RESULT_NO}_$GENERATE_NO
fi

#------------------------------------------------------------------

#本家に圧縮結果がアップロードされる定期更新ゲームの場合はwgetでダウンロードする
#wget -O data/orig/result${RESULT_NO}_$GENERATE_NO.zip http://www.sssloxia.jp/result${RESULT_NO}.zip  

# 元ファイルを変換し圧縮
if [ -f ./data/utf/${ZIP_NAME}.zip ]; then
    
    cd ./data/utf

    echo "unzip orig..."
    unzip -q ./${ZIP_NAME}.zip
    
    cd ../../

fi

# 圧縮ファイルが展開されていれば処理の実行
if [ -d ./data/utf/${ZIP_NAME} ]; then
    
    # 解析処理の実行
    perl ./GetData.pl $1 $GENERATE_NO
    perl ./UploadParent.pl $1 $GENERATE_NO
    
    # UTFファイルを圧縮
    cd ./data/utf/

    echo "rm utf..."
    rm  -r ${ZIP_NAME}
        
    cd ../../

fi

cd $CURENT  #元のディレクトリに戻る
