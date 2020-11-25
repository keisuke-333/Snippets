source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

# ログイン機能
gem 'devise'

# 日本語化
gem 'rails-i18n', '~> 6.0'
gem 'devise-i18n'

# 画像投稿機能
gem 'carrierwave'

# 画像保存先をAWS S3にする
gem 'fog-aws'

# 画像ファイルの加工
gem 'mini_magick'

# Font Awesome
gem 'font-awesome-sass'

# PV数を計算
gem 'impressionist'

# 検索機能
gem 'ransack'

# ページネーション
gem 'kaminari'

# Markdown
gem 'qiita-markdown'
gem 'github-linguist'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Rails用のテストフレームワーク
  gem 'rspec-rails'
  # モデルに関するテストデータ作成用
  gem 'factory_bot_rails'
  # ダミーデータの生成
  gem 'faker'
  # デバッグ用
  gem 'pry-byebug'
  gem 'pry-doc'
  # Capistrano用
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-rbenv-vars', '~> 0.1'
  gem 'capistrano3-puma'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end