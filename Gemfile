# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem "jekyll"

gem "minimal-mistakes-jekyll"

gem 'jemoji'

gem 'nokogiri', '~> 1.10.8'

group :jekyll_plugins do
    gem "jekyll-feed"
    gem "jekyll-seo-tag"
    gem "jekyll-sitemap"
    gem "jekyll-paginate"
    gem "jekyll-include-cache"
    gem "jekyll-algolia"
    gem "github-pages"
  end