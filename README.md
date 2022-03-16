# Kotlin introduction

Kotlin 導入のための資料です。  
GitHub pages を使ってホスティングしています。  
https://access-company.github.io/kotlin_intro/

## ドキュメントのビルド方法

### Minimum

#### 必要なツール

* npm
* [HonKit](https://github.com/honkit/honkit)
  * `npm install -g honkit`
* GitBook各種プラグイン
  * [Dockerfile](./Dockerfile#L6)を参考に入れてください


#### ビルド方法

* リポジトリをクローンします。
* トップディレクトリにて、以下のコマンドを実行します。

```bash
$ make
```

* ドキュメントが `docs` ディレクトリに生成されます。  
* 参照する場合は、docs ディレクトリを何らかの形でホスティングしてください。

### おすすめ（Docker利用）

#### 必要なツール

1. [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. [VSCode](https://code.visualstudio.com/)
3. [Remote Containers](https://code.visualstudio.com/docs/remote/containers-tutorial#_install-the-extension)
4. [docker-sync](https://docker-sync.readthedocs.io/en/latest/index.html#) via `gem install docker-sync`（[Ruby](https://www.ruby-lang.org/ja/documentation/installation/)も必要）

#### ビルド準備

1. VSCodeでkotlin_introフォルダを開く
2. VSCodeのターミナル→新しいターミナル
3. `docker-sync start`
4. VSCodeの左下端<img src="./src/assets/images/vscode_remote_container.png" width=140 />をタップ
5. Reopen in Containerを選択

#### ビルド方法

1. Dockerコンテナ内で`make`を実行

ドキュメントがDockerコンテナ内の`docs`に生成され、ホスト側にもsyncされます。

#### プレビュー方法

1. Dockerコンテナ内で`http-server docs`を実行
2. http://localhost:8080/ をブラウザで開く

### トラブルシューティング

```
Error: Couldn't locate plugins "codeblock-filename", Run 'gitbook install' to install plugins from registry.
```

と出力された場合、npm経由でプラグインをインストールしてください。
```
npm i -g gitbook-plugin-codeblock-filename
```
