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

(省略)

## 色々な関数定義の仕方

* 基本形

```kotlin
// fun で始まる以下の形が基本の関数定義の仕方
fun 関数名(引数リスト): 戻り値の型
```

* 単一の式からなる関数の場合

```kotlin
// Int を 2 つとって足した数を返す関数
// 処理が一個しかない (式が一個) の場合はこんな風に書ける
fun add(a: Int, b: Int): Int = a + b
```

```kotlin
// Int を 2 つとって大きい方を返す関数
// if 文 1 個ということも可能
fun max(a: Int, b: Int): Int = if (a > b) a else b
```

```kotlin
// Int を 2 つとって小さい方を返す関数
// 戻り値の型に型推論が効く
fun min(a: Int, b: Int) = if (a < b) a else b
```

* 文を持つ

```kotlin
// 文を扱うときはこう
// Int を 2 つ引数に取って足し合わせた結果を返しつつ、画面に結果を出す関数
fun addWithPrint(a: Int, b: Int): Int {
    val result = a + b
    println(result)
    return result
}
```

```kotlin
// Int の配列を引数にとって全部足し合わせたものを返す関数
fun sum(ints: Array<Int>): Int {
    var sum = 0
    for (n in ints) {
        sum += n
    }
    return sum
}
```

* 名前付き引数

```kotlin
// どの引数に値を渡すか、引数の名前を指定できる
fun name(first: String, last:String) = println("$first $last")

// 名前を指定せずに呼び出すとき
name("taro", "yamada") // taro yamada

// 名前を指定して呼び出すとき
// 関数定義の順番に従う必要がなく、意味も分かりやすくなる場合もある
name(last: "yamada", first: "taro") // taro yamada
```

* デフォルト引数

```kotlin
// デフォルトの値を指定してくことができる
// 呼び出し時に値を指定しなかった場合はデフォルト値が使われる
fun greet(name: String = "anonymous") {
    println("Hi, $name!")
}

greet()      // Hi, anonymous!
greet("BOB") // Hi, BOB!
```

* 可変長引数

```kotlin
// 引数に "vararg" をつけると可変長 (任意の個数、引数入力が可能) という意味になる
fun sum(vararg ints: Int): Int { // 引数として任意の数の Int をとる
    var sum = 0
    for (n in ints) {
        sum += n
    }
    return sum
}

// 呼び出し例
sum(1, 2, 3, 4) // 10

// 配列を可変長引数として扱ってもらうこともできる
var array = intArrayOf(1, 2, 3, 4, 5)
sum(*array) // * をつけると配列を可変長引数として扱ってもらえる
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
// 「末尾呼び出し最適化」と呼ばれる最適化を行うことができる
// * 関数定義の頭に tailrec をつける
// * 再帰呼び出しを関数の最後にもっていく
tailrec fun sum(numbers: List<Long>, acc: Long = 0): Long = // ← tailrec というのをつけた
    if (numbers.isEmpty()) acc
    else sum(numbers.drop(1), acc + numbers.first()) // sum の再帰呼び出しが関数の最後にきている

// 動く！
sum((1L..123456).toList())
```

* ローカル関数

```kotlin
// 関数の中に関数を定義できる仕組み
// 他の関数からは呼び出すことができない (関数内にスコープを限定)
fun sum(numbers: List<Long>): Long {
    // 引数を 2 つとる関数をローカル関数化し、外面を良く (引数 1 個で済むように) した
    tailrec fun go(numbers: List<Long>, acc: Long): Long = 
        if (numbers.isEmpty()) acc
        else go(numbers.drop(1), acc + numbers.first())

    return go(numbers, 0)
}

```


