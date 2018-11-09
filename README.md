# 霧戦争5期データ小屋　解析プログラム
霧戦争5期データ小屋は[MIST OF WAR](http://blacktea.sakura.ne.jp/mistofwar/)を解析して得られるデータを扱った情報サイトです。  
このプログラムは霧戦争5期データ小屋で実際に使用している解析・DB登録プログラムです。  
データ小屋の表示部分については[別リポジトリ](https://github.com/white-mns/mow_rails)を参照ください。

# サイト
実際に動いているサイトです。  
[霧戦争5期データ小屋](https://data.teiki.org/mow_5/)

# 動作環境
以下の環境での動作を確認しています  
  
OS:CentOS release 6.10 (Final)  
DB:MySQL  
Perl:5.10.1  

## 必要なもの

bashが使えるLinux環境。（Windowsで実行する場合、execute.shの処理を手動で行ってください）  
perlが使える環境  
デフォルトで入ってないモジュールを使ってるため、

    cpan DateTime

のようにCPAN等を使ってDateTimeやHTML::TreeBuilderといった足りないモジュールをインストールしてください。

## 使い方
圧縮ファイルをMIST OF WARサイトからダウンロードして`data/utf`に置きます。霧戦争ではここは手動です。  

第一回更新なら

    ./execute.sh 1

とします。
最更新が1回あって圧縮ファイルが`002.zip`、`002_1.zip`となっている場合、その数字に合わせて

    ./execute.sh 2 0
    ./execute.sh 2 1

とすることで再更新前、再更新後を指定することが出来ます。
（ただし、データ小屋では仕様上、再更新前、再更新後のデータを同時に登録しないようにしています）  
上手く動けばoutput内に中間ファイルcsvが生成され、指定したDBにデータが登録されます。  
`ConstData.pm`及び`ConstData_Upload.pm`を書き換えることで、処理を実行する項目を制限できます。
    
    ./_execute_all.sh 1 5

とすると、Vol.1からVol.5までの確定結果を再解析します。

## DB設定
`source/DbSetting.pm`にサーバーの設定を記述します。  
DBのテーブルは[Railsアプリ側](https://github.com/white-mns/mow_rails)で`rake db:migrate`して作成しています。

## ライセンス
本ソフトウェアはMIT Licenceを採用しています。 ライセンスの詳細については`LICENSE`ファイルを参照してください。
