# 関数

Kotlin の関数について記載します。

## ゴール

以下について理解すること。

* 関数の定義の仕方、使い方
  * 単一の式からなる関数
  * 名前付き引き数、デフォルト引数
  * 可変長引数
  * 再帰呼び出し (末尾呼び出し最適化)
  * ローカル関数

## 関数とは？

* 何か（引数）を入れると、何らかの計算や処理を行って、入れた人に結果（戻り値）を返すもの。それ以上は省略。

## 色々な関数定義の仕方

* 基本形

```kotlin
//sampleStart
// fun で始まる以下の形が基本の関数定義の仕方
// fun 関数名(引数リスト): 戻り値の型
fun add(a: Int, b: Int): Int {
    return a + b
}
//sampleEnd

fun main(args: Array<String>) {
    println("a=1, b=2, add(a, b)=${add(1, 2)}")
}
```

* 単一の式からなる関数の場合

```kotlin
//sampleStart
// Int を 2 つとって足した数を返す関数
// 処理が一個しかない (式が一個) の場合はこんな風に書ける
fun add(a: Int, b: Int): Int = a + b
//sampleEnd

fun main(args: Array<String>) {
    println("a=1, b=2, add(a, b)=${add(1, 2)}")
}
```

```kotlin
//sampleStart
// Int を 2 つとって大きい方を返す関数
// if 文 1 個ということも可能
fun max(a: Int, b: Int): Int = if (a > b) a else b
//sampleEnd

fun main(args: Array<String>) {
    println("a=1, b=2, max(a, b)=${max(1, 2)}")
}
```

```kotlin
//sampleStart
// Int を 2 つとって小さい方を返す関数
// 戻り値の型に型推論が効く
fun min(a: Int, b: Int) = if (a < b) a else b
//sampleEnd

fun main(args: Array<String>) {
    println("a=1, b=2, min(a, b)=${min(1, 2)}")
}
```

* 文を持つ

```kotlin
//sampleStart
// 文を扱うときはこう
// Int を 2 つ引数に取って足し合わせた結果を返しつつ、画面に結果を出す関数
fun addWithPrint(a: Int, b: Int): Int {
    val result = a + b
    println(result)
    return result
}
//sampleEnd

fun main(args: Array<String>) {
    println("a=1, b=2")
    addWithPrint(1, 2)
}
```

```kotlin
//sampleStart
// Int の配列を引数にとって全部足し合わせたものを返す関数
fun sum(ints: Array<Int>): Int {
    var sum = 0
    for (n in ints) {
        sum += n
    }
    return sum
}
//sampleEnd

fun main(args: Array<String>) {
    println("ints=[1, 2, 3, 4], sum(ints)=${sum(arrayOf(1, 2, 3, 4))}")
}
```

* 名前付き引数

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // どの引数に値を渡すか、引数の名前を指定できる
    fun name(first: String, last:String) = println("$first $last")

    // 名前を指定せずに呼び出すとき
    name("taro", "yamada")  // taro yamada

    // 名前を指定して呼び出すとき
    // 関数定義の順番に従う必要がなく、意味も分かりやすくなる場合もある
    name(last = "yamada", first = "taro")   // taro yamada
    //sampleEnd
}
```

* デフォルト引数

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // デフォルトの値を指定してくことができる
    // 呼び出し時に値を指定しなかった場合はデフォルト値が使われる
    fun greet(name: String = "anonymous") {
        println("Hi, $name!")
    }

    greet()         // Hi, anonymous!
    greet("BOB")    // Hi, BOB!
    //sampleEnd
}
```

* 可変長引数

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // 引数に "vararg" をつけると可変長 (任意の個数、引数入力が可能) という意味になる
    fun sum(vararg ints: Int): Int { // 引数として任意の数の Int をとる
        var sum = 0
        for (n in ints) {
            sum += n
        }
        return sum
    }

    // 呼び出し例
    println(sum(1, 2, 3, 4))    // 10

    // 配列を可変長引数として扱ってもらうこともできる
    var array = intArrayOf(1, 2, 3, 4, 5)
    // * をつけると配列を可変長引数として扱ってもらえる
    println(sum(*array))        // 15
    //sampleEnd
}
```
