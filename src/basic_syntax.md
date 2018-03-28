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

* リスト

* セット

* マップ

* レンジ

## 条件分岐

* if

* when

## ループ

* while

* for




