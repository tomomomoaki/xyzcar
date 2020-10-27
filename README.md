# README

# アプリケーション名
# car-car

# アプリケーション概要
car-carでは、自動車に乗っていない人が、実際に自動車に乗っている人のレビューを見ることができます。
写真などで自動車の見た目や、良いところ、悪いところ、自動車のカスタムについて投稿することができます。
コメントで、実際に乗っている人に質問することもできます。

- URL

# テスト用アカウント
- ID : 
- PASSWORD : 

# 利用方法
実際に自動車に乗った人や、自動車のオーナーから、触れてみないと分からない、乗ってみないと分からない情報を入手することができます。

# 目指した課題解決
自動車を実際に購入してみると、不満点が多かったという問題に対して、購入する前から、実際に乗った方からの情報を入手することで、より多くの情報の中で自動車を選ぶことができます。また、数多くある自動車の種類から、自分の好みにあった自動車の存在を知ることができます。車が好きでカスタムなどをしている人たちの発信の場になります。
メーカー様は自社の自動車のレビューをみることができます。


# 要件定義
|  優先順位<br/>（高：3、中：2、低：1） | 機能 | 目的 | 詳細 | ストーリー(ユースケース) | 見積もり（所要時間） |
| --- | --- | --- | --- | --- | --- |
|  3 | ユーザー管理 | ログインした人が投稿できる | deviseの導入 | ログインしていないユーザーは、レビューコメントの閲覧のみ、 | 7h |
|  3 | car投稿 | 自動車のレビューを投稿する | new,create実装 | indexのnewcarボタンからレビューを作成し、作成したレビューはindexに表示される | 7h |
|  3 | レビュー一覧表示 | レビューを閲覧することができる | index編集 | 投稿されたレビューが新しいものから順に表示される | 7h |
|  2 | 車種検索 | タグから閲覧したい車の情報を絞る | タグを用いて、メーカー、車種、ボディタイプの3つを絞れる | indexにメーカー、車種、ボディタイプの3種類のボタンがあり、それを押すと、そのタグのレビューだけをindexに表示する。 | 7h |
|  1 | ユーザー詳細 | どんなユーザーなのか詳細を作り、閲覧できる | 乗っている車や、好きな車を書いてどういう人なのか把握できるようにする | ユーザーの名前を押すと、ユーザー詳細画面に行ける。ユーザーの名前はレビューやコメントに表示しておく。 | 3h |
|  2 | レビューの編集、削除 | 作ったレビューを編集削除できる | edit,update,delete実装 | 投稿した者だけに編集、削除ボタンが現れ、誤った内容を編集、削除できる | 4h |
|  3 | コメント機能 | レビューに対してコメントできる | comment機能実装 | レビューに対して質問したり、会話できる | 5h |
|  1 | 見た目 | レビューが見やすいように | HTMLを編集する | わかりやすいコマンドの形、シンプルな表示にする | 7h |
|  1 | モデルチェンジ情報 | 新車情報や、モデルチェンジ情報も載せて、いつどのような車が誕生するかも知らせる | 調べて、できそうだったらやる | indexにネットで拾った新車情報のリンクをのせる | 7h |
|  1 | 複数枚画像添付 | レビューに複数枚画像を添付できて、よりレビューがわかりやすいようにする | 調べて、できそうだったらやる | 画像を複数枚一緒に添付して投稿 | 3h |

# テーブル設計


## users テーブル

| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| nickname          | string  | null: false |
| email             | string  | null: false |
| encrypted_password| string  | null: false |
| favorite_car      | string  |             |
| introduction      | text    |             |

### Association

- has_many :cars
- has_many :comments

## cars テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| title              | string     | null: false                   |
| text               | text       | null: false                   |
| maker              | string     | null: false                   |
| car_name           | string     | null: false                   |
| body_type          | string     | null: false                   |
| user               | references | null: false, foreign_key: true|

### Association

- belongs_to :user
- has_many :comments
- has_many :car_tags
- has_many :tags, through: :car_tags

## tags テーブル

| Column          | Type       | Options         |
| --------------- | ---------- | --------------- |
| name            | string     | null: false     |

### Association

- has_many :car_tags
- has_many :cars, through: :car_tags

## car_tags テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| car             | references | null: false, foreign_key :true |
| tag             | references | null: false, foreign_key :true |


### Association

- has_many :cars
- has_many :tags


## comments テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| text            | text       |                                |
| user            | references | null: false, foreign_key :true |
| car             | references | null: false, foreign_key :true |


### Association

- belongs_to :user
- belongs_to :car

# ER図
https://gyazo.com/dd48494f834f122bd94bf04aac9cf037

# 画面遷移図
https://gyazo.com/de921a28513580d364dd2ca928684285