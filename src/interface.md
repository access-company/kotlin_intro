# インターフェース

インターフェースについて記載します。

## ゴール

以下を理解していること。

* 基本的なインターフェースの作り方、使い方
* プロパティ
* interface をオーバーライドしてクラスを作る
* デリゲーション

## インターフェース

* インターフェースとは？
  * abstract なクラスに近いが、状態 (バッキングフィールド) を持つことができないクラス
  * プロパティ、メソッドを持たせることができるが、いずれも abstract になる
  * コンストラクタを持たせることはできない

* 定義の仕方

```kotlin
// interface と書いて宣言する
// Greeter (挨拶するひと) インターフェース
interface Greeter {
    // プロパティ、メソッドを持たせられるが、いずれも abstract
    // 強制的に abstract になるので、abstract は書かないでも良い (書いても良いが冗長)
    // また、メンバは全て public 扱いになる

    val language: String
    fun sayHello(target: String)
}
```

* 実装の仕方
  * クラスを作ってインターフェースを継承する
  * abstract なものをひととおりオーバーライドする (interface を実装する、と呼ぶ)

```kotlin
// Greeter interface を実装する EnglishGreeter クラス
class EnglishGreeter : Greeter {
    // val language と fun sayHello を
    // オーバーライドしないとコンパイルが通らない
    override val language = "English"
    override fun sayHello(target: String) {
        println("Hello! $target!")
    }
}
```

* ちなみに、クラスの継承はひとつまでなのに対し、インターフェースは複数継承することができる 

```kotlin

// インターフェースがふたつ以上あったとして...
interface Cookie {
    ...
}

interface Chocolate {
    ...
}

// クラスは複数のインターフェースを継承して実装することができる
class Sweet : Cookie, Chocolate {
    ...
    // Cookie、Chocolate に含まれるメンバを
    // 全てオーバーライドする (実装する) 必要がある
}
```

* デフォルト実装
  * インターフェースに含まれるメソッドを実装しておくことができる
  * 継承した側でオーバーライドしない場合、デフォルト実装が使われる

```kotlin
interface Greeter {
    // デフォルト実装をもったメソッド
    fun sayHello(target: String) {
        println("Hello $target!")
    }
}

class EnglishGreeter : Greeter {
    // sayHello の実装を省略
}

fun main(args: Array<String>) {
    val g: Greeter = EnglishGreeter()
    g.sayHello("takeshi") // Hello takeshi!
}
```

* クラスデリゲーション
  * 継承の問題点として、以下のようなものがある
    * こじらせるとクラスがどんどん大きくなってしまう (共通機能をつめこみたくなる)
    * スーパークラスの変更はただちにサブクラスに影響する (変更の影響範囲を小さくできない)
  * 継承せずに別クラスに処理を委譲するやり方をデリゲーションと呼ぶ

```kotlin
// 継承するパターン

// インターフェースの定義
interface Greeter {
    fun sayHello()
    fun sayHello(target: String)
}

// 英語で挨拶クラス
open class EnglishGreeter : Greeter {
    open fun sayHello() {
        // 名前を省略したら anonymous さんに挨拶する
        sayHello("anonymous")
    }

    open fun sayHello(target: String) {
        println("Hello, $target!")
    }
}

// 名前を指定されたときはすごい挨拶をする
// 英語で挨拶クラスを継承して拡張した
class EnglishGreeterGreatAgain : EnglishGreeter {
    override sayHello(target: String) {
        // スーパークラスの実装を呼び出す
        super.sayHello("$target great again!") // Hello $target great again!
    }
}

fun main(args: Array<String>) {
    val g = EnglishGreeterGreatAgain()
    g.sayHello("America") // Hello America great again!
    g.sayHello("Japan")   // Hello Japan great again!
    g.sayHello("Germany") // Hello Germany great again!
    g.sayHello("")        // Hello anonymous great again ← ！？
}
```

* 継承で一部分だけ拡張したつもりでいたが、  
結局のところはスーパークラスの実装への依存があり、制御が難しい場合がある
* スーパークラスをいじれれば良いが、そうでない場合は思い通りにできない場合も

```kotlin
// 委譲するパターン

class EnglishGreeterGreatAgain : Greeter {
    // 継承ではなく、メンバとして値を持つ
    private val g: Greeter = EnglishGreeter()

    override fun sayHello() {
        // 単にメソッドを呼び出す
        g.sayHello()
    }

    override fun sayHello(target: String) {
        // 拡張してメソッドを呼び出す
        g.sayHello("Hello $target great again!")
    }
}

fun main(args: Array<String>) {
    val g = EnglishGreeterGreatAgain()
    g.sayHello("America") // Hello America great again!
    g.sayHello("Japan")   // Hello Japan great again!
    g.sayHello("Germany") // Hello Germany great again!
    g.sayHello("")        // Hello anonymous!
}
```

* 通常、委譲するほうが継承するよりもコードは多くなる傾向がある
  * 上の例の場合、`sayHello()` も `sayHello(target: String)` も要実装になっている
  * ところが、Kotlin の場合、委譲してもコード量を増やさない技が備わっている

```kotlin
// コンストラクタで Greeter をとりつつ、"Greeter by greeter" と指定して継承
// override してない部分は greeter に委譲するという意味になる
class EnglishGreeterGreatAgain(private val greeter: Greeter): Greeter by greeter {
    // override fun sayHello() は実装しない (= greeter に委譲)

    // 拡張したいところだけ override
    override fun sayHello(target: String) {
        greeter.sayHello("Hello $target great again!")
    }
}

fun main(args: Array<String>) {
    val eg = EnglishGreeter()
    val g = EnglishGreeterGreatAgain(eg)
    g.sayHello("America") // Hello America great again!
    g.sayHello("Japan")   // Hello Japan great again!
    g.sayHello("Germany") // Hello Germany great again!
    g.sayHello("")        // Hello anonymous!
}
```

* インターフェースがあると嬉しい場面
  * インターフェースを実装したクラスは、  
  インターフェースのほうの「型」として扱うことができる

```kotlin
// Greeter インターフェース
interface Greeter {
    fun sayHello(target: String)
}

// Greeter インターフェースを受け取って呼び出すだけの関数
fun greeting(g: Greeter, target:String) {
    g.sayHello(target)
}

// 日本語で挨拶
class JapaneseGreeter : Greeter {
    override fun sayHello(target: String) {
        println("こんにちは、$target さん！")
    }
}

// 英語で挨拶
class EnglishGreeter : Greeter {
    override fun sayHello(target: String) {
        println("Hello, $target!")
    }
}

// ドイツ語で挨拶
class GermanyGreeter : Greeter {
    override fun sayHello(target: String) {
        println("Guten morgen, $target!")
    }
}

fun main(args: Array<String>) {
    // greeting 関数は Greeter インターフェースを実装したクラスを
    // 引数にとるので、以下はいずれも有効な書き方
    greeting(JapaneseGreeter("world")) // こんにちは、world！
    greeting(EnglishGreeter("world"))  // Hello, world!
    greeting(GermanyGreeter("world"))  // Guten morgen, world!
}
```

* 実装の中身を入れ替えたいときに便利
  * テスト用に常に OK を返すだけのクラスにしたい
  * SQLite を使っていたが Postgres に変更したい
  * 等など
