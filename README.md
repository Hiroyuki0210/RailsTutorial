# README

## クローン
`$ git clone git@github.com:Hiroyuki0210/RailsTutorial.git`

## gemのインストール
`$ bundle install`

## マイグレーション
`$ rails db:migrate`

## 初期データ投入
`$ rails db:seed`

## 実行
`$ rails server`

http://localhost:3000/ にアクセス。

## ログイン情報
### 管理者
* メールアドレス: example@railstutorial.org
* パスワード: foobar
### 一般ユーザ
* メールアドレス: example-1@railstutorial.org
* パスワード: password

## パスワードリセット
ログインページ http://localhost:3000/login で「forgot password」をクリックすると、パスワードリセット用のページへ行けます。

パスワードリセットの手順
1. メールアドレスを入力する。
1. サーバログにメールが送られてくるので記載されているリンクに飛ぶ。  
  ※httpsと表示されている場合は、httpと変更する
1. パスワードのリセット
