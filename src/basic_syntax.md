# 基本的な文法

Kotlin の基本的な文法について記載します。

## ゴール

以下について、使い方を理解すること。

* 変数宣言 (`var`、`val`) 
* 基本的なデータ型
* 基本的なデータ構造 (文字列、配列、リスト、セット、マップ、レンジ)
* 条件分岐 (`if`、`when`)
* ループ (`while`、`for`)

## いろんな型

* 数値型

* その他の基本型

## 変数

* `val`
  * `val` で宣言した変数は、あとから値の変更 (再代入) ができない。
  * 変数を扱う際には、可能な限りは `val` を用いたほうが良い。

```kotlin
// val 変数名: 型 = 式

val foo: Int = 123
val bar: String = "Hello"
```


* `var`
  * `var` で宣言した変数は再代入が可能。

```kotlin
// var 変数名: 型 = 式

val foo: Int = 123
val bar: String = "Hello"

// あとから値が変えられる

foo = 100
bar = "World!"
```

## 型推論

* Kotlin コンパイラに、右辺から変数の型を推論してもらうことができる。
* 型推論を行う場合は、型名を省略して代入を行う。

```kotlin
val age  = 35       // age の型は Int になる

var name = "access" // name の型は String になる
name = 12           // name の型は String なのでコンパイルエラーになる
```

## オブジェクト

* 文字列 (String)
  * 文字列を表すオブジェクト。
  * 色々なメソッド、プロパティが取り揃えられている。
  * [String - Kotlin Programming Language (公式 API Reference)](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)

```kotlin
val str = "access"

str.length      // 6
str.captalize() // "Access"
str.isEmpty()   // false

// 文字列の連結

val str2 = "Hello " + str + " !"  // + を使った連結
str2 // "Hello access !"

val str3 = "Good night ${str}!"   // String テンプレートを使った連結
str3 // "Good night access!
```

* 配列

```kotlin
// 配列を作るには arrayOfNulls を使う
// Int の配列の場合は以下のような書き方
val ints = arrayOfNulls<Int>(10)

// 各要素への値の代入
// (再代入も可能)
ints[0] = 10
ints[1] = 20

// 中身はこうなる
ints[0] // 10
ints[1] // 20
ints[2] // null

// 要素数の取得には size プロパティを使う
ints.size // 10

// arrayOf で書くと型推論される
// 以下は String の配列ということにされる
val array = arrayOf{"access", "company", "com"}
array[0] // "access"
array[1] // "company"
array[2] // "com"
```

* リスト

```kotlin
// listOf でリストを作る。
val list = listOf<Int>(1, 2, 3)

// 配列と同じように要素アクセスできる
list[0] // 1

// 単なるリストは要素の値を変更できない
// 要素の値を変更可能なリストが欲しい場合は MutableList を使う
list[0] = 100 // コンパイルエラー
```

* セット

```kotlin
// セットは「重複のない」集合を扱う場合に用いる
val intSet = setOf(1, 2, 3, 4, 1, 3, 2)
intSet // [1, 2, 3, 4]

// 単なるセットは要素の値を変更できない
// 要素を追加したり削除したりする場合は MutableSet を用いる
intSet += 5 // コンパイルエラー

// セットは要素の順番を保証しないので、配列みたいな添字での要素アクセスはできない
intSet[2] // コンパイルエラー
```

* マップ

```kotlin
// マップはキーと値のペアを保持するコレクション
// 以下は <String, Int> という形のペアを保持できるマップ
val map = mapOf(1 to "access", 2 to "company", 3 to "com")
map[1] // "access"
map[2] // "company"
map[3] // "com"
map[4] // null

// ご多分に漏れず、単なるマップは値の変更ができない
// 要素の値を変更可能なマップが欲しい場合は MutableMap を使う
map[1] = "fuga" // コンパイルエラー
```

* レンジ
  * `..` を使って範囲を表すことができる

```kotlin
1..10 // 1〜10 の範囲を示す

// in を使って、指定した値が範囲内にあるかチェックする
5 in 1..10   // true
100 in 1..10 // false

// range もオブジェクトなので変数に入れたりできる
val r = 1..10
5 in r // true

// レンジからリストを得ることができる
val list = r.toList()
list // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

```

## 条件分岐

* if
  * 条件分岐に用いる
  * else を伴うことで「式」として用いることが可能 (変数に代入したりできる)

```kotlin
val r = 1..10
if (5 in r) {
    println("5 is in range")
}

// 式として用いて変数に代入することも可能
val n = 5
val result = if (n in r) {
    "$n is in range"
} else {
    // 式として用いるときには else 必須
    "$n is not in range"
}
result // 5 is in range

// else if で次々つなげることも可能
val fee = if (age > 12) {
    "大人料金"
} else if (age >= 6) {
    "小人料金"
} else {
    "無料"
}
```

* when
  * switch 文のようなもの
  * if と同じく、else を伴うことで「式」として用いることが可能

```kotlin
// オーソドックスな when の使い方
val n = 5
when (n) {
    1    -> "access"
    2, 3 -> "company"
    else -> "com"

}

// 定数以外も用いることができる
when (n) {
    in 1..5              -> "access"
    isGreaterThanFive(n) -> "company"
    else                 -> "com"
}

// is を用いた型チェック
// 値の代入もトライ
val type = when (n) {
    is Int    -> "$n is Int"
    else      -> "$n is not Int"
}
type // 5 is Int
```

## ループ

* while

* for




