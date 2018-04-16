# Null安全

Null 安全について記載します。

## ゴール

以下について理解していること。

* Null 安全が必要な背景
* スマートキャスト
* 安全呼び出し演算子 (`?`)
* 強制呼び出し演算子 (`!!`)
* エルビス演算子 (`?:`)
* 安全キャスト

## null って何よ

* `null` そのものの意味は、"空" とか "無" とか。ドイツ語らしい。
* 変数に `null` を入れると、その変数はどこも参照していない (`null` を参照している) 状態になる
* `null` を参照しているオブジェクトのメソッド呼び出しは例外 (`NullPointerException`) を発生させる
  * `NullPointerException` になるのが期待動作ということは基本的になく、概してプログラミングのミスで発生する

* Java のコードで `NullPointerException` が出る例は以下のような場合。
  * 以下、Java のコード例には「Java」と記載 (特に注釈がなければ Kotlin のコード例)

```java: Java
String s = null; // null を入れる
s.toUpperCase(); // NullPointerException 発生
```

## 従来の null との戦い

* NullPointerException と null チェック
  * NullPointerException が起きないように、  
  変数を参照する前に変数が `null` でないかを確認する必要が生じることがしばしばある
  * 実はきっちり対処しようとするとそれなりに手間

```java: Java
// 上述のコード例における NullPointerException を回避する

String s = null;
if (s != null) { // null じゃないことを確認する
    s.toUpperCase();
}
```

* ところが、
  * Java の言語仕様上、変数は基本的に全て null になりうる
  * その点だけ捉えると全ての変数について使う前に null チェックするのが妥当か…？
  * 文脈上、絶対に null でないことが確定しているような場合はチェックするべき？

```java: Java
String s = "hoge";
// s は明らかに null じゃないのでチェックしないで良さそう

String ss = Fuga(); // 文字列か null を返す関数だとしたら
// ss は要チェック
```

* チェックの要・不要を判断するのはプログラマ → 往々にして間違いが起こり得る

* アノテーションによる null 回避という案
  * Android Java では `@NonNull` のようなアノテーションをメソッドに付与できる
  * `@NonNull` をつけておくと、コンパイル時にある程度 `null` にならないことをチェックできる
  * しかし基本的に無力
    * 表明するためのものでありドキュメンテーションの色合いが強い
    * IDE は `@NonNull` なところに `null` になりうる変数を渡すと警告してくれる (こともある)
    * 制約に違反するコードがあってもコンパイルエラーにはしてくれない

```java: Java
// アノテーションによって本メソッドは null を返さないことを表明する
@NonNull
String Fuga() {
    // ...
    return null; // しかし null は返すことはできてしまう (コンパイルエラーではない)
}

// null になりうることも表明できる
@Nullable
String Piyo() {
    // ...
}
```

## null 安全

* そんなわけで null にはさんざん苦戦してきた
  * Kotlin では、**「null になりうるか」「null になりえないか」を「型」で区別している**

```kotlin
// たとえば、以下のコードはコンパイルに失敗する
// String は「null になりえない」型であるから

val s: String = null // error: null can not be a value of a non-null type String
```

```kotlin
// 「null になりえる」型を宣言するためには、? を補う
// 以下はコンパイル OK

val s: String? = null

// ただし、「null になりえる」の状態のままではメソッド、プロパティの呼び出しができない
// error: only safe (?.) or non-null asserted (!!.) calls are
// allowed on a nullable receiver of type String?
s.toUpperCase()

// たとえ値が入っていても同様
val ss: String? = "hoge"

// error: only safe (?.) or non-null asserted (!!.) calls are
// allowed on a nullable receiver of type String?
ss.toUpperCase() 
```

* スマートキャスト
  * 「null になりえる」の状態では、メソッドやプロパティが呼び出せない
  * メソッドやプロパティを呼び出すためには、「null になりえる」の状態から「null になりえない」に変換が必要
  * たとえば if 文による null チェックで対象が「null になりえない」ことが分かれば良い

```kotlin
// スマートキャストを使った「null になりえる」から「null になりえない」への変換

val s: String? = "hoge" // 「null になりえる」状態

if (s != null) { // null チェックすることで s は「null になりえない」になる
    println(s.toUpperCase()) // メソッドが呼び出せる
}
```

* 安全呼び出し
  * 対象が「null だったら null、null じゃなかったら中身」を使うやり方

```kotlin
// ? をつけると「null になりえる」型
val s: String? = "hoge"

// 通常、このままでは s のメソッドを呼べないが、
// ? を補うことで呼び出せる
val u = s?.toUpperCase()

// 上記は以下と同じ処理
val u = if (s != null) {
    s.toUppercase()
} else {
    null
}
```

* メソッドの引数に「null になりうる」を渡す場合

```kotlin
// 以下の関数の引数の型は「null になりえない」という記述
fun greet(name: String) {
    println("hello, $name!")
}

val s: String? = "hoge"
greet(s) // コンパイルエラー

if (s != null) {
    greet(s) // これなら OK
}

```

* 上記のような例の場合に、`let` を用いることができる
  * `let` は任意の型とラムダ式を引数にとり、ラムダ式を呼び出す

```kotlin
val s: String? = "hoge"

// コンパイル OK
// s が null ならラムダ式は呼び出されない
s?.let { greet(it) }
```

* 強制呼び出し
  * `!!` を使うと「null になりうる」を「null になりえない」に強制的に変換する
  * 中身が本当に `null` だったら `NullPointerException` になっちゃうので、基本的に使わないで済ませたい

```kotlin
val s: String? = "hoge"
s!!.toUpperCase() // コンパイルOK、実行も可能
```

```kotlin
val s: String? = null
s!!.toUpperCase() // コンパイルOK、だが実行時に例外 (NullPointerException) を吐く
```

* 強制呼び出し (`!!`) について補足
  * 対象の変数が **100%ヌルでない** ということが分かっているなら使っていいかもしれない
  * が、そういうときにもあえて強制呼び出しオペレータを用いる必要はなく、もっと良い書き方ができるはず

* エルビス演算子
  * null のときに返す値を指定できる

```kotlin
val s: String? = null

s ?: "null です！" // null だったら「null です！」を返す

// 以下と同義
if (s != null) {
    s
} else {
    "null です！"
}
```

* 安全キャスト
  * 型をキャストする際にも `?` が使える
  * キャストに失敗したときに例外ではなくて null が返る

```kotlin
val a: Any = "string" // String を Any に入れる
println(a as String) // String へのキャストは OK ("string" が表示される)
println(a as Int) // java.lang.ClassCastException: java.lang.String cannot be cast to java.lang.Integer
```

```kotlin
val a: Any = "string" // String を Any に入れる
println(a as? String) // String へのキャストは OK ("string" が表示される)
println(a as? Int) // null が表示される
```
