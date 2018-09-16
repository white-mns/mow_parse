# 霧戦争5期データ小屋　解析プログラム
霧戦争5期データ小屋は[MIST OF WAR](http://blacktea.sakura.ne.jp/mistofwar/)を解析して得られるデータを扱った情報サイトです。  
このプログラムは霧戦争5期データ小屋で実際に使用している解析・DB登録プログラムです。  
データ小屋の表示部分については[別リポジトリ](https://github.com/white-mns/mow_rails)を参照ください。

# サイト
実際に動いているサイトです。  
[霧戦争5期データ小屋](http://tkg.mn-s.net/mow_5)

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
（実際に稼働してる環境ではdataはシンボリックリンクにしていて、`/var/tkg/mow_5/utf`に圧縮ファイルを置いています)

第一回更新なら

    ./execute.sh 1

とします。
再更新が行われていた場合、その更新回の中で最も新しい更新結果を実行します。
2つ目の引数を指定すると、どの再更新のデータを取得するかまで指定できます。
再更新なしなら、

    ./execute.sh 1 0

最更新が1回あって圧縮ファイルが`002_1.zip`となっている場合、その数字に合わせて

    ./execute.sh 2 1

とします。
上手く動けばoutput内に中間ファイルcsvが生成され、指定したDBにデータが登録されます。
ConstData.pm`及び`ConstData_Upload.pm`で実行する項目、ENoの指定を行えます。

## DB設定
`source/DbSetting.pm`にサーバーの設定を記述します。  
DBのテーブルは[Railsアプリ側](https://github.com/white-mns/mow_rails)で`rake db:migrate`して作成しています。

## ライセンス
本ソフトウェアはMIT Licenceを採用しています。 ライセンスの詳細については`LICENSE`ファイルを参照してください。
