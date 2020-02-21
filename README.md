# Kotlin introduction

Kotlin 導入のための資料です。  
GitHub pages を使ってホスティングしています。  
https://access-company.github.io/kotlin_intro/

## ドキュメントのビルド方法

### 必要なツール

* npm

### ビルド方法

* リポジトリをクローンします。
* トップディレクトリにて、以下のコマンドを実行します。

```bash
$ make
```

* ドキュメントが `docs` ディレクトリに生成されます。  
(参照する場合は、docs ディレクトリを何らかの形でホスティングしてください)

### トラブルシューティング

```
Error: Couldn't locate plugins "codeblock-filename", Run 'gitbook install' to install plugins from registry.
```

と出力された場合、npm経由でプラグインをインストールしてください。
```
npm i gitbook-plugin-codeblock-filename
```