# Handicrafts
​
## サイト概要
### サイトテーマ
- 手芸が好きな人の為のWebコミュニティサイトです。
- 裁縫、編み物など…心をこめて作った作品を投稿して、手芸が好きな人たち同士で繋がることが目的です。

​
### テーマを選んだ理由
昔から何かものを作るのが好きで、手芸は身近な存在でした。<br>
特にビーズでマスコットを作るのが好きで、好きなビーズ作家さんの著作本を購入し、材料を揃えて作品作りに励み、喜んでもらえるのが嬉しくて、作った作品は家族や友人、お世話になった恩師や職場の先輩にプレゼントしておりました。</br>
作品は時々ですが、記録用に携帯で写真を取っていたが、機種変した際にデータがなくなってしまった為、自分の記録用として手軽に投稿できるサイトがあったらいいなと感じました。<br>
手芸屋で買い物をする際、材料の買い忘れや同じものをダブって買ってしまうことが多々ある為、買い物リストが欲しいと思いました。効率的に材料の調達ができると感じ、便利だと感じました。<br>
自分の身近には手芸を趣味にしている人がいない為、共通の価値観を持った人たち同士で繋がって、情報共有ができたらいいなと感じた為、このテーマにいたしました。

​
### ターゲットユーザ
- 手芸が好きで、自分が作った作品を記録したい人
- 手作り作品をみるのが好きな人
- 自分の作品を投稿して、沢山の人に見てもらいたい人

​
### 主な利用シーン
- 作品ができた時、作品の制作過程も見て貰いたい時
- 他の人の作品をみたい時、作品にいいねしたり、コメントしてコミュニケーションを取りたい時
- ほしいものリストに予め必要な材料を登録し、買い物時に参照する
​
## 設計書
- ER図 https://drive.google.com/file/d/1kTSICqwEXwSdXddehIAUI21xSslOpHjN/view?usp=sharing
- テーブル定義書 https://docs.google.com/spreadsheets/d/1cdcaO13dq5yUSRDSqQJaQzxegPfrUw64k55eI1RJ35w/edit?usp=sharing
- アプリケーション詳細設計書 https://docs.google.com/spreadsheets/d/1ekRzDt0TM3dsoxOFtKeq6Qi0trZrUH-7ikuo_4XWmqA/edit?usp=sharing

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- フリーイラスト素材として以下を使用
- イラストAC https://www.ac-illust.com/main/detail.php?id=429991

## 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能　画像投稿(image_processing)
- ページネーション機能(kaminari)
- タグ機能(acts-as-taggable-on)
- いいね機能
- コメント機能
- 検索機能

## 実装機能リスト
- https://docs.google.com/spreadsheets/d/1PPYfcgGkP5LEQdmtT1gCPrd7qdEFJ3nACYgIQNNVHrU/edit?usp=sharing