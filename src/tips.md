# その他豆知識

その他、豆知識を記載します。

## ゴール

以下について理解していること

* ObjectとCompanion Object
* 演算子オーバーロード
* 等価、同値 (`===` と `==`)
* 分解宣言
* 列挙型
* 例外
* 再起呼び出しと末尾再起呼び出し最適化
* ローカル関数
* coroutine
* apply
* also
* by lazy

※一部は時間の都合上、記載省略

## ObjectとCompanion Object

### Object

Objectは一言で言えば「シングルトン（Singleton）なクラス」だが、ここでは使用例を見せながら説明する。

**どこからでも呼び出せるログ出力関数**が欲しいとしよう。

今まで習った内容を使って書くとこうなる。

```kotlin
class Logger {
    val TAG = "MyApp"
    fun debug(text: String) {
        println("$TAG: $text")
    }
}

fun main() {
    println("Logging to ${Logger().TAG}.")
    Logger().debug("print")
}
```

出力結果
```
Logging to MyApp.
MyApp: print
```

ただし、このコードには問題があって、`Logger().`で毎回異なるインスタンス（オブジェクトの実体）が作られる。この例だと`main`の中で2回作られている。

もし、`debug`があちこちから大量に呼ばれたら…たちまちインスタンスが乱立して、メモリを圧迫し、アプリの動作が重くなるだろう。

それを避けるため、クラスを`object`識別子で定義する。

```kotlin
object Logger {
    val TAG = "MyApp"
    fun debug(text: String) {
        println("$TAG: $text")
    }
}

fun main() {
    println("Logging to ${Logger.TAG}.")
    Logger.debug("print")
}
```

こうすると、クラス`Logger`と変数`TAG`は**何回呼ばれても常に同じインスタンス**を返す。何度呼ばれても、メモリ圧迫量は変わらない。これがシングルトン。

呼び出し方は`Logger.`に変わる。

### Companion Object

さて、上記の例だと、`TAG`も`debug`もシングルトンとして生成されるが、時には`TAG`だけに適用したい場合もある。

その場合、`companion object`識別子を使うと、`TAG`を`Logger`クラスに属するシングルトン変数、つまり「定数」にできる。

```kotlin
class Logger(outputFilePath: String) {
    
    companion object {
    	val TAG = "MyApp"
    }
    
    fun debug(text: String) {
        // TODO 実際はoutputFilePathにファイル出力するよう作り替える
        println("$TAG: $text")
    }
}

fun main() {
    println("Logging to ${Logger.TAG}.")
    Logger("/log.txt").debug("print")
}
```

`main`を見ると、`Logger`は普通のクラスだが、`TAG`はシングルトンであることがわかる。

実際、Key/Valueを扱い、Keyだけが定数、という実装がよくある。

また、Androidでは画面から他画面のデータ渡しでリクエストコードやKey/ValueペアのBundleを使うので、そういうときCompanion Objectはよく使われる。

### 余談

勘のいい人なら気づいたであろうが、この例の場合、実はクラスを使わず`debug()`を実装する方法もある。

```kotlin
val TAG = "MyApp"

fun debug(text: String) {
    println("$TAG: $text")
}

fun main() {
    debug("print")
}
```

このようにトップレベル関数を使うのが一番シンプルである。

今までの例は、シングルトンをわかりやすく説明するためである。

また、Javaを知ってる人なら`static`があるじゃないかと思うかもしれないが、`static`はKotlinでは使えない。

静的なものは非オブジェクトだから、オブジェクト指向の言語において不要だろうという言語設計思想のため。

### まとめ

* Objectは、「クラス/変数として毎回同じインスタンスを返したい場合」に使う
* Companion Objectは、「毎回同じインスタンスを返す変数（定数）をクラスに持たせたい場合」に使う

と覚えておこう。

## 列挙型

定数を列挙する場合に便利な書き方。

```kotlin
enum class Kanto {
    IBARAGI,
    TOCHIGI,
    GUNMA,
    SAITAMA,
    CHIBA,
    TOKYO,
    KANAGAWA
}

fun main() {
    println("Kanto Prefecture List: ")
    for (prefecture in Kanto.values()) {
        println(prefecture)
    }
    println("I'm living in ${Kanto.TOKYO}.")
}
```

## 例外

異常が起こった場合、関数は例外をスローできる。関数の呼び出し元では、その例外をキャッチして処理できる。

```kotlin
fun validation(percentage: Int) {
    if (percentage !in 0..100) {
        throw IllegalArgumentException("A percentage must be between 0 and 100 [parameter: $percentage]")
    }
}

fun main() {
    validation(101)
}
```

値が0〜100の範囲に収まっていない場合は、IllegalArgumentExceptionをスローする。

```
Exception in thread "main" java.lang.IllegalArgumentException: A percentage must be between 0 and 100 [parameter: 101]
 at FileKt.validation (File.kt:3) 
 at FileKt.main (File.kt:8) 
 at FileKt.main (File.kt:-1) 
```

## 再帰呼び出し

* 普通の再帰呼び出し

```kotlin
// Long のリストを引数にとって合計を返す関数
// sum 関数内で sum 自身を呼び出している
fun sum(numbers: List<Long>): Long =
    if (numbers.isEmpty()) 0
    else numbers.first() + sum(numbers.drop(1))

// 上記のコードは引数に渡した配列が超長い場合などにちゃんと動かなくなる
// (stack overflow してしまう)
sum((1L..123456).toList()) // stack overflow しちゃう！
```

* 末尾呼び出し最適化

```kotlin
// 再帰的に関数を呼び出す場合において、その関数呼び出しが関数の一番最後にくる場合、
// 「末尾呼び出し最適化 (Tail Call Optimization)」と呼ばれる最適化を行うことができる
// * 関数定義の頭に tailrec をつける
// * 再帰呼び出しを関数の最後にもっていく
tailrec fun sum(numbers: List<Long>, acc: Long = 0): Long = // ← tailrec というのをつけた
    if (numbers.isEmpty()) acc
    else sum(numbers.drop(1), acc + numbers.first()) // sum の再帰呼び出しが関数の最後にきている

// 動く！
sum((1L..123456).toList())
```

## ローカル関数

* ローカル関数は関数の中に関数を定義できる仕組み
  * 他の関数からは呼び出すことができない (関数内にスコープを限定)
  * 以下はローカル関数と再帰呼出しの組み合わせ

```kotlin
fun sum(numbers: List<Long>): Long {
    // 引数を 2 つとる関数をローカル関数化し、
    // 外面を良く (引数 1 個で済むように) した
    tailrec fun go(numbers: List<Long>, acc: Long): Long = 
        if (numbers.isEmpty()) acc
        else go(numbers.drop(1), acc + numbers.first())

    return go(numbers, 0)
}
```

## apply

* オブジェクトに対し、プロパティの変更を一括適用する

```kotlin
class Company (
    var name: String,
    var numberOfEmployees: Int = 0
)

fun main(args: Array<String>) {
    val c = Company("ACCESS", 310).apply {
        // 今年の新卒社員数を加算
        numberOfEmployees += 15
    }
    val s = "${c.name} has ${c.numberOfEmployees} employees."
	println(s) // ACCESS has 325 employees.
}
```

* プロパティの数が多い場合、`c.xxx = yyy`みたいな記述を繰り返す手間が省ける

## also

* applyと似てるが、alsoはラムダ式の中で別の名前を付けることができる
  * デフォルトはit
  * つまり、applyの場合はラムダ式の内外で`this`の指す先が異なるが、alsoを使うと同じになる
* letとも似てるが、letは最後の行を返すのに対し、alsoは元のオブジェクトを返す

```kotlin
val s = "access".also { it.toUpperCase() }
println(s) //=> ACCESS
```


## by lazy

* 遅延プロパティと呼ばれる
* 最初にアクセスがあった時に、ラムダの中身を計算し、最終行の値をvalに保持する
  * それ以降は、単に保持された結果を返す

```kotlin
val greetMessage: String by lazy {
    println("First time!")
    "Hello!"
}

fun main(args: Array<String>) {
    println(greetMessage) // "First time!\nHello!"
    println(greetMessage) // "Hello!"
}
```

* 実際は、画面の起動時には設定できないけど、更新時にはじめて設定できるものとかに使う
  * それはvarでも実装できるが、by lazyの場合valにできるのが利点
