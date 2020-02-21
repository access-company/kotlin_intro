# Kotlin について

## 生い立ち

* JetBrains 社が中心となって開発を行っているプログラミング言語
* 2011年夏に発表。現在は OSS ([github のリポジトリ](https://github.com/JetBrains/kotlin)) として開発されている
  * ライセンスは Apache 2.0
* 2020年2月現在、Kotlin はバージョン 1.3
  * [1.3.61](https://github.com/JetBrains/kotlin/releases/tag/v1.3.61) が最新、[1.3.70 EAP](https://discuss.kotlinlang.org/t/kotlin-1-3-70-early-access-preview/15876) あたりが出ている

## どんな言語か

* JVM 言語
  * コンパイルすると Java バイトコードになる
  * Scala、Groovy なんかも JVM 言語
* Java 互換 100％
  * Java で作られたライブラリを呼び出すことができる
  * 逆に、Kotlin で作られたライブラリを Java から呼び出すこともできる
  * なので、「Java か Kotlin か」ではなく、共存が可能
* 静的型付け
  * (コンパイルしない系の言語に比べて) コンパイル時に誤りが発見されるという利点
* オブジェクト指向
  * いわゆる C++、Java 等と同様で、クラスベースのオブジェクト指向言語
* Android Studio 3.0 で標準サポート
  * 初期 (2016〜2018年頃) はもっぱら Android のアプリ作成に用いられていた
  * 徐々に他のプラットフォーム、サーバーサイド、Web、システムプログラミングでも使われ始めた
* モダンな言語仕様
  * 型推論、ラムダ式、トレイトなど
* (Kotlin 1.2 から) JavaScript へのトランスパイルもサポート

## Java ではなくて Kotlin を使う理由

* Java より記述が簡潔
  * 型推論、ラムダ式、スマートキャスト、等の言語仕様
* Java より安全
  * Null安全、キャスト周りの安全性
* Kotlin は新しい
  * Java にはモダンな言語仕様を入れにくい。下位互換をサポートしなければならないという事情
  * Kotlin は比較的新しいので、いわゆるしがらみが少なく、モダンな言語仕様をサポートしやすい

