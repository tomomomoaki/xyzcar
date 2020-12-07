# README

# アプリケーション概要
自動車レビュー、モデルチェンジ情報の閲覧をすることができます。
トップページ上部の検索フォーム、または、サイドバーの絞り込みフォームから閲覧したいレビューを探すことができます。
トップページ右上の「新規登録」からユーザー登録をすることができます。
ユーザー登録することで、レビューの投稿、レビュー詳細画面から、コメントの投稿をすることができます。

# 使用した技術
- サーバーサイド：ruby
- フレームワーク：ruby on rails
- フロントエンド：HTML, CSS, JavaScript
- インフラ：AWS(S3, Route53, EC2, ACM)  
- DB：MySQL
- ソース管理：Git
- その他：レビューとタグを同時に保存するため、フォームオブジェクトパターンを採用

# アプリケーション名
# car-xyz

- URL：https://car-xyz.com/

# テスト用アカウント
- ID       : tarou@gmail.com
- PASSWORD : 123qaz

# 目指した課題解決
自動車を実際に購入してみると、不満点が多かったという問題に対して、購入する前から、実際に乗った方からの情報を入手することで、より多くの情報の中で自動車を選ぶことができます。また、数多くある自動車の種類から、自分の好みにあった自動車の存在を知ることができます。車が好きでカスタムなどをしている人たちの発信の場になります。
メーカー様は自社の自動車のレビューをみることができます。


# 要件定義
|  優先順位<br/>（高：3、中：2、低：1） | 機能 | 目的 | 詳細 | ストーリー(ユースケース) | 見積もり（所要時間） |
| --- | --- | --- | --- | --- | --- |
|  3 | ユーザー管理 | ログインした人が投稿できる | deviseの導入 | ログインした者だけが、レビュー投稿、レビューコメントができ、ログインしていない者は、レビュー、コメントの閲覧のみできる。 | 7h |
|  3 | car投稿 | 自動車のレビューを投稿する | new,createの定義、carsテーブル、tagsテーブル、その中間テーブルのcar_tagsテーブルの3つに保存するため、フォームオブジェクトパターンを用いる。 | トップページのレビューを投稿するボタンからレビューを作成し、成功した場合は、保存してトップページへ遷移する。失敗した場合はエラーメッセージを表示して、投稿画面に戻る。 | 7h |
|  3 | レビュー一覧表示 | レビューを閲覧することができる | index編集、1ページで最大14個のレビューを表示し、それ以上のレビューがある場合は、kaminariを導入して、ページを分ける | 投稿されたレビューが新しいものから順に表示される。画像がない場合は「NoImage」画像を表示させる。レビューの画像、タイトルをクリックすると、レビュー詳細ページへ、ユーザー名をクリックすると、ユーザー詳細ページへ遷移する。 | 7h |
|  2 | 車種検索 | タグ、キーワード、メーカー、ボディタイプ、車名から閲覧したい車の情報を絞る | search,typeの定義 | トップページのヘッダーからタグ、キーワード検索ができる。サイドバーからメーカー、車種、ボディタイプの絞り込みをかけることができる。searchページに遷移し、絞り込んだレビューを一覧表示する。 | 7h |
|  1 | ユーザー詳細 | どんなユーザーなのか詳細を作り、閲覧できる | users#showの定義 | 各ページのユーザーの名前を押すと、そのユーザーの詳細画面に遷移する。ユーザーの自己紹介、投稿数、そのユーザーが投稿したレビューが一覧表示される。 | 3h |
|  2 | レビューの編集、削除 | 作ったレビューを編集削除できる | edit,update,deleteの定義 | 投稿した者だけに編集、削除ボタンが現れ、誤った内容を編集、削除できる | 4h |
|  3 | コメント機能 | レビューに対してコメントできる | comments#createの定義 | レビューに対して質問したり、会話できる | 5h |
|  3 | レビュー詳細 | レビューの詳細情報を閲覧することができる | showの定義 | 複数枚画像が投稿されている場合は、画像も一覧表示され画像をクリックすることで、拡大表示ができる。レビューに投稿時に記述した全ての情報が表示される。ページ下部にコメントフォームがあり、ログインユーザーはコメントをすることができる。 |  |
|  1 | モデルチェンジ情報 | 新車情報や、モデルチェンジ情報も載せて、いつどのような車が誕生するかも知らせる | スクレイピングで、https://bestcarweb.jp/tags/マイナーチェンジ、の情報を掲載する | トップページの上部にリンクが5つ表示され、リンクをクリックすると、そのサイトへ遷移する。 | 7h |
|  2 | AWSへ画像を保存 | herokuへデプロイした後も、画像を表示させる | AWSのS3にバケットを作成し、そこに画像ファイルを保存する | レビューに画像を添付した場合は、画像がS3に保存される | 7h |
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
| maker_id           | string     | null: false                   |
| car_name           | string     | null: false                   |
| body_type_id       | string     | null: false                   |
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
https://i.gyazo.com/6d7da5e46c472e34f993c0734ec997a5.png

# 画面遷移図
https://gyazo.com/045b7534f3c278a3315d78e76f9d80a0
