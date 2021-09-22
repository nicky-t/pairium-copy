# pairium

# 開発手順
## mainブランチの変更を取り込む
mainブランチにいることを確認してから、下記のコマンドを実行する。
```
git pull origin main
```

## developブランチに移動
下記のコマンドで、developブランチに移動する。
```
git checkout develop
```

## developブランチの変更を取り込む
developブランチにいることを確認してから、下記のコマンドを実行し、remoteの状態をlocalに反映する。
```
git pull origin develop
```

## ブランチ変更
developブランチにいることを確認してから、下記コマンドを実行し、新しいブランチを作成し、そこで作業を行う。
```
git checkout -b ブランチ名
```
ブランチ名の例
Androidのレイアウト修正なら
fix/android-layout

# firebaseファイルをもらう
firebase連携ファイルをもらう

# データベース設計
[スプレッドシート](https://docs.google.com/spreadsheets/d/1ZBetK7beXLwCXxTZh8YPdbwQPvq-PXV17RRlyFay9_s/edit#gid=1093654298 "データベース設計")