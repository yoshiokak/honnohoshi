# 本の星

## 本の星とは

本の星というサービスは、本の平均評価を1つのサイトで調べると評価に偏りがある場合があるため、複数サイトでの平均評価を知りたいが、その際にそれぞれのサイトで調べるのが面倒という問題を解決したい、複数サイトの本の平均星評価を知りたい人向けの、本の星評価横断検索サービスです。

ユーザーはISBNを入力すると、複数サイトでのその本の星評価を見ることができ、自分で複数のサイトを検索して本の星評価を調べるのとは違って、ISBNの入力のみで複数サイトの本の星評価を知ることができる事が特徴です。

## インストール

`$ ./bin/setup`

`$ rails server`

## テスト

`$ bundle exec rake test && bundle exec rake test:system`

## Lint

`rubocop -A`

## API

本アプリではRakuten API(https://webservice.rakuten.co.jp/)とAmazon Price API(https://api.rakuten.net/ajmorenodelarosa/api/amazon-price1)を使用しています。

それぞれで取得したAPI Keyを以下の環境変数にセットしてください。

```
RAKUTEN_APP_ID =
RAKUTEN_AFFILIATE_ID =
X_RAPIDAPI_KEY =
```
