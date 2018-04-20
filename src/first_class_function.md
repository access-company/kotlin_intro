# ちょっと特殊な関数の使い方

第一級オブジェクトとしての関数について記載します。

## ゴール

以下を理解すること。

* 関数もオブジェクトとして扱える
* 高階関数
* ラムダ式、クロージャ
* インライン関数

## オブジェクトとしての関数

* 関数もオブジェクトの一種

```kotlin
// 関数のオブジェクトを変数に代入する例

// 入力を二乗する関数
fun square(i: Int) = i * i

// 関数のオブジェクトを取得するときは "::" をつける
// println してみる
println(::square) // "fun square(kotlin.Int): kotlin.Int" みたいのが返される

// 変数に代入できる
val func = ::square

square(5) // 25
func(5)   // 25 (square を呼び出したのと同じ)
```

* 関数オブジェクトの型は？

関数オブジェクトもオブジェクトの一種なので「型」がある

```kotlin
// 入力を二乗する関数
fun square(i: Int) = i * i
println(::square) // "fun square(kotlin.Int): kotlin.Int"

// 上の関数は「Int を引数にとって Int を返す関数」という型
// (Int) -> Int と書く

// 「Int を引数にとって Int を返す関数」という変数に代入
val func1: (Int) -> Int = ::square // 型があっていれば代入できる

// 型があってないと代入できない
// 以下の関数は (String) -> Unit という型
fun greet(name: String) = println("Hello $name!")
val func2: (Int) -> Int = ::greet // 型があっていないので代入できない (コンパイルエラー)
```

* 関数を引数として渡したり戻り値にしたり (高階関数)

```kotlin
// 関数を引数にとる関数
// 第二引数には「Int を引数にとる関数」を指定する
fun printWith(ints: List<Int>, printFunc: (Int) -> Unit) {
    for (i in ints) {
        printFunc(i) // 引数でもらった関数を呼び出す
    }
}

// Int を引数にとる関数の例
fun myPrintFunc(i: Int) {
    if (i % 3 == 0) {
        println("3の倍数です!")
    } else {
        pritnln(i)
    }
}

// 関数を引数に指定して呼び出す
printWith((1..10).toList(), ::myPrintFunc)
```

```kotlin
// n 乗を返す関数を生成する関数
fun powerGen(n: Int): (Int) -> Long {
    fun power(num: Int): Long {
        var result: Long = 1
        for (i in 1..n) {
            result *= num
        }
        return result
    }
    return ::power
}

// 入力を 5 乗する関数を生成
val fivePowerOf = powerGen(5)
fivePowerOf(10) // 100000

// 入力を 10 乗する関数を生成
val tenPowerOf = powerGen(10)
tenPowerOf(2)   // 1024
```

## 色々な関数の作り方

* ラムダ式
  * 関数を**定義せずに関数オブジェクトを生成するコード**をラムダ式と呼ぶ。

```kotlin
// 通常の関数オブジェクトを得る方法

// 関数定義
fun square(n: Int): Int {
    n * n
}

// 定義された関数の名前に :: をつけて関数オブジェクトを得る
println(::square) // fun square(kotlin.Int): kotlin.Int
```

```kotlin
// 一方、ラムダ式を使う場合

// 関数の型 = { 引数リスト -> 関数の実装 } という形
val square: (Int) -> Int = { i: Int ->
    i * i // 最後に評価された式が返される。return しなくてよい。
}

println(square)    // (kotlin.Int) -> kotlin.Int
println(::square)  // val Line_2.square: (kotlin.Int) -> kotlin.Int
println(square(3)) // 9
```

```kotlin
// 型推論すると短く書ける

// 「Int を引数にとって Int を返す」を型推論してもらい、
// 関数の型の記載を省略
val square = { i: Int ->
    i * i
}

// 「Int を引数にとる」を型推論してもらい、
// 関数の実装における引数の型を省略
val square: (Int) -> Int = { i ->
    i * i
}

// 引数が一個の場合、「it」と書ける
val square: (Int) -> Int = {
    it * it
}
```

* クロージャ
  * コードを記述したときのスコープで変数が扱える (環境の捕捉、キャプチャを行う) 関数オブジェクトのこと。

```kotlin
// 呼び出すたびに数字を1つ増やす関数を返す
fun genCounterFunc(): ()->Int {
    var count = 0
    // ラムダ式の形で関数オブジェクトを返す
    // 以下の関数オブジェクトは「count 変数をキャプチャ」している
    return {
        count++
    }
}

fun main(args: Array<String>) {
    val func1 = genCounterFunc()
    val func2 = genCounterFunc()

    // func1 を呼び出すたびに、「func1 内の」変数が変更される
    println(func1()) // 0
    println(func1()) // 1
    println(func1()) // 2

    // func1 を呼び出すたびに、「func2 内の」変数が変更される
    println(func2()) // 0
    println(func2()) // 1
    println(func2()) // 2
}
```

* インライン関数
  * 関数がインライン展開 (関数呼び出しの場所に関数定義が挿入されるイメージ) される仕組み。
  * 高階関数の扱いは呼び出しのコストが高いが、インライン関数でより効率よくできる場合がある。

```kotlin
// インライン展開なし

fun log(debug: Boolean = true, message: () -> string) {
    if (debug) {
        println(message())
    }
}

fun main(args: Array<String>) {
    log(/* true, */ { "log message" }) // 表示される
    log(false,      { "log message" }) // 表示されない
}
```

```kotlin
// インライン展開する

inline fun log(debug: Boolean, message: () -> string) {
    if (debug) {
        println(message())
    }
}

// 上述の main 関数は、以下と概ね同義になる。
// debug が true でないときは、関数呼び出しまで到達しないコードになる。
fun main(args: Array<String>) {
    if (true) {
        println("log message") // 表示される
    }
    if (false) {
        println("log message") // 表示されない
    }
}
```

```kotlin
// 非ローカルリターン
// inline 展開を利用して、外側の関数を抜けるテク

// 入力した文字列 (str) の全要素に対して何か (f) する関数
inline fun forEach(str: String, f: (Char) -> Unit) {
    for (c in str) {
        f(c)
    }
}

// 入力した文字列 (str) に数字が含まれているかどうかを返す関数
fun containsDigit(str: String): Boolean {
    forEach(str) {
        if (it.isDigit()) {
            // forEach が inline 展開されるため、
            // この return はラムダ式 (forEach の f 部分) じゃなくて containsDigit を抜ける。
            return true 
        }
    }
    return false
}
```

```kotlin
// inline だが非ローカルリターンしたくない場合は、
// ラベルへのリターンを利用する

// 入力した文字列 (str) に数字が含まれているかどうかを返す関数
fun containsDigit(str: String): Boolean {
    var result = false
    forEach(str) @loop {
        if (it.isDigit()) {
            result = true 
            return@loop // forEach を抜ける
            // return@forEach という書き方も可能
        }
    }
    return result
}
```

* 無名関数
  * ラムダ式のように関数オブジェクトを得るもうひとつの方法
  * inline 展開はできない

```kotlin
// ラムダ式 (再掲)
val square: (Int) -> Int = { i: Int ->
    i * i
}

// 無名関数
// 上記のラムダ式にあたる部分に関数を書くイメージ
val square: (Int) -> Int = fun(i: Int): Int {
    return i * i // ラムダ式と違って要 return 文
}

// 無名関数 省略版
val square: (Int) -> Int = fun(i : Int) = i * i
```


