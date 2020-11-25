# snippet

### URL 
AWS：https://snippets-webdev.com/  
Heroku：https://snippets-for-webdevel.herokuapp.com/  
※ゲストユーザーとしてログインすることができます。

### アプリ概要

Webエンジニアを目指す初心者の人が、  
学習したコード内容を気軽にメモとして投稿することができ、  
他人に公開し、共有することができるサービスです。  

<img width="1443" alt="img" src="https://user-images.githubusercontent.com/65392082/96006377-62b7a900-0e78-11eb-9e64-d7479ee0db6a.png">

## 作成した経緯
Webエンジニアを目指す初心者の人が、  
技術ブログに投稿するほどでもない簡単なコード内容を  
メモとして投稿することができ、それを他人が見たりお気に入りすることができる  
Webサービスを作ってみようと思い、こちらのアプリを作成しました。

## アプリのポイント
- 初めてRailsでCRUD処理を実装して制作したアプリ
- AWSにデプロイ（Herokuにもデプロイしています）
- フロント側のプログラムをjQueryに頼らず、プレーンなJavaScriptのみで制作
- 直感的に分かるデザインを心がけて作成（bootstrapやjQueryを使用せずに自分でデザインしました）
- RSpecを使用してテストコードの実装（100件以上実施）
- ajaxでいいねやフォロー機能を実装
- GitHubに定期的にpushをし、バージョン管理された状態で作成
- 現在も開発中です

## 環境
- macOS Catalina 10.15.5
- Visual Studio Code
- ruby 2.6.6
- rails 6.0.3.2
- postgresql

### 本番環境
AWS （ VPC | RDS | EC2 | Route 53 | ACM | ALB | S3 | IAM | CloudFront ）  
Webサーバ：Nginx

### gem
- devise 4.7.2
- carrierwave
- MiniMagick
- font-awesome-sass
- impressionist
- ransack
- kaminari

## ER図
![snippets](https://user-images.githubusercontent.com/65392082/96097885-74e32700-0f0c-11eb-8834-416845698bc0.png)



