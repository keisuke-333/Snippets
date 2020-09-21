source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

# ログイン機能
gem 'devise'

# 日本語化
gem 'rails-i18n', '~> 6.0'
gem 'devise-i18n'

# 画像投稿機能
gem 'carrierwave'

# 画像ファイルの加工
gem 'mini_magick'

# Font Awesome
gem 'font-awesome-sass'

# Markdown
gem 'redcarpet'

# シンタックスハイライト
gem 'coderay'

# PV数を計算
gem 'impressionist'

# 検索機能
gem 'ransack'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end