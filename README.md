# [GitLab API] done2close
GitLab の issues でチケット管理をするとき、Done ラベルのついたチケットをまとめて closed したい時に便利なニッチなシェルスクリプトです。

## 使い方
お好きな場所に clone してください。

引数として、以下の 4 つを順番通りに渡してください。
- GitLab のアクセストークン
- ドメイン名（`gitlab.example.com` であれば `example.com`）
- `groups` または `projects`
- groups または projects の ID

```
$ done2close.sh [ACCESS_TOKEN] [DOMAIN_NAME] [groups/projects] [ID] 
```