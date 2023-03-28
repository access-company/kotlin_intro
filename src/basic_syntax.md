# 基本的な文法

Kotlin の基本的な文法について記載します。

## ゴール

以下について、使い方を理解すること。

* 変数宣言 (`var`、`val`)
* 基本的なデータ型
* 基本的なデータ構造 (文字列、配列、リスト、セット、マップ、レンジ)
* 条件分岐 (`if`、`when`)
* ループ (`while`、`for`)

## Kotlin Playground

ブラウザ上でコードを書いて動作確認できます。

* https://play.kotlinlang.org

このサイトにも Playground のスクリプトを埋め込んでいます。

```kotlin
fun main(args: Array<String>) {
    println("Hello world!")
}
```
↑ためしに`Hello あなたの名前!`に書き変えて、緑矢印を押してください。

## いろんな型

主に使われる型と、値の例を以下に記載

* 数値型

| 型名     | ビット幅 | 用途       | 例                 | 備考                                                   |
|----------|----------|------------|--------------------|--------------------------------------------------------|
| `Byte`   | 8 bit    | 整数       | 0x0f, 0b0101, 123  | -128 ~ 127                                             |
| `Short`  | 16 bit   | 整数       | 0x0f, 0b0101, 1234 | -32,768 ~ 32767                                        |
| `Int`    | 32 bit   | 整数       | 0x0f, 0b0101, 1234 | -2,147,483,648 ~ 2,147,483,647                         |
| `Long`   | 64 bit   | 整数       | 123456789L         | -9,223,372,036,854,775,808 ~ 9,223,372,036,854,775,807 |
| `Float`  | 32 bit   | 浮動小数点 | 123.456F           | 単精度浮動小数点                                       |
| `Double` | 64 bit   | 浮動小数点 | 123.456            | 倍精度不動小数点                                       |

* ちなみに、数値は読みやすさ向上のために任意の位置に `_` を補った書き方ができる
  * Int の最大値 →  `2_147_483_674`
  * クレジットカード番号 → `1234_5678_9012`
  * マイナンバー → `987_65_4321`
  * 16進数を 1 byte ずつ区切る → `0xFF_EE_DD_CC`
  * 2進数を 1 byte ずつ区切る → `0b11010101_01011111_01010101`

* その他の基本型

| 型名      | 用途                                       | 例                                             |
|-----------|--------------------------------------------|------------------------------------------------|
| `Char`    | 文字                                       | 'a', 'b', '0', '\u8d64'                        |
| `String`  | 文字列                                     | "hello", "How are you!"                        |
| `Boolean` | 真偽値                                     | true, false                                    |
| `Unit`    | "ない"ことを表す (Java の `void` にあたる) | `fun hoge(): Unit`<br>(戻り値がない関数の定義) |

## 変数

* `val`
  * `val` で宣言した変数は、あとから値の変更 (再代入) ができない。
  * 変数を扱う際には、可能な限りは `val` を用いたほうが良い。
    * `var` はコードの読みにくさやバグを招きやすい。

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // val 変数名: 型 = 式

    val foo: Int = 123
    val bar: String = "Hello"

    println("foo=$foo, bar=$bar")
    //sampleEnd
}
```

* `var`
  * `var` で宣言した変数は再代入が可能。

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // var 変数名: 型 = 式

    var foo: Int = 123
    var bar: String = "Hello"

    // あとから値が変えられる

    foo = 100
    bar = "World!"

    println("foo=$foo, bar=$bar")
    //sampleEnd
}
```

## 型推論

* Kotlin コンパイラに、右辺から変数の型を推論してもらうことができる。
* 型推論を行う場合は、型名を省略して代入を行う。

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    val age  = 35       // age の型は Int になる

    var name = "access" // name の型は String になる
    name = 12           // name の型は String なのでコンパイルエラーになる

    println("name=$name, age=$age")
    //sampleEnd
}
```

## オブジェクト

オブジェクトとは？→クラスのページで詳しく触れる。

* 文字列 (String)
  * 文字列を表すオブジェクト。
  * 色々なメソッド、プロパティが取り揃えられている。
  * [String - Kotlin Programming Language (公式 API Reference)](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-string/index.html)

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    val str = "access"

    println(str.length)         // 6
    println(str.capitalize())   // "Access"
    println(str.isEmpty())      // false

    // 文字列の連結

    val str2 = "Hello " + str + " !"    // + を使った連結
    println(str2) // "Hello access !"

    val str3 = "Good evening $str!"     // String テンプレートを使った連結
    println(str3) // "Good evening access!

    val str4 = "Good night ${str}!"     // String テンプレートを使った連結
    println(str4) // "Good night access!

    val str5 = "1 + 1 = ${1 + 1}"       // String テンプレートを使った計算
    println(str5) // "1 + 1 = 2"
    //sampleEnd
}
```

* 配列

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // 配列を作るには arrayOf を使う
    // 配列の中身の型は推論される
    // 以下は String の配列ということにされる
    val array = arrayOf("access", "company", "com")
    println(array[0])   // "access"
    println(array[1])   // "company"
    println(array[2])   // "com"

    // 配列の要素を後から変更することもできる
    array[2] = "jp"
    println(array[2])   // "jp"

    // 配列に後から要素を足したり減らしたりすることはできない
    //sampleEnd
}
```

* リスト

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // listOf でリストを作る。
    val list = listOf<Int>(1, 2, 3)

    // 配列と同じように要素アクセスできる
    println(list[0])    // 1

    // 単なるリストは要素の値を変更できない
    // 要素の値を変更可能なリストが欲しい場合は MutableList を使う
    // listOf を mutableListOf に変えてみよう
    list[0] = 100   // コンパイルエラー
    println(list[0])

    // MutableList なら要素を足したり減らしたりもできる
    list.removeFirst()
    list.add(4)
    println(list)
    //sampleEnd
}
```

* セット

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // セットは「重複のない」集合を扱う場合に用いる
    val intSet = setOf(1, 2, 3, 4, 1, 3, 2)
    println(intSet) // [1, 2, 3, 4]

    // 単なるセットは要素の値を変更できない
    // 要素を追加したり削除したりする場合は MutableSet を用いる
    // setOf を mutableSetOf に変えてみよう
    intSet += 5 // コンパイルエラー
    println(intSet)

    // セットは要素の順番を保証しないので、配列みたいな添字での要素アクセスはできない
    // intSet[2] を intSet.toList() に変えてみよう
    println(intSet[2]) // コンパイルエラー
    //sampleEnd
}
```

* マップ

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // マップはキーと値のペアを保持するコレクション
    // 以下は <String, Int> という形のペアを保持できるマップ
    val map = mapOf(1 to "access", 2 to "company", 3 to "com")
    println(map[1]) // "access"
    println(map[2]) // "company"
    println(map[3]) // "com"
    println(map[4]) // null

    // ご多分に漏れず、単なるマップは値の変更ができない
    // 要素の値を変更可能なマップが欲しい場合は MutableMap を使う
    // mapOf を mutableMapOf に変えてみよう
    map[1] = "fuga" // コンパイルエラー
    println(map[1])
    //sampleEnd
}
```

* レンジ
  * `..` を使って範囲を表すことができる

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // 1..10 で、 1〜10 の範囲を示す

    // in を使って、指定した値が範囲内にあるかチェックする
    println(5 in 1..10)     // true
    println(100 in 1..10)   // false

    // range もオブジェクトなので変数に入れたりできる
    val r = 1..10
    println(5 in r) // true

    // レンジからリストを得ることができる
    val list = r.toList()
    println(list)   // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    //sampleEnd
}
```

## 条件分岐

* if
  * 条件分岐に用いる
  * else を伴うことで「式」として用いることが可能 (変数に代入したりできる)

```kotlin
fun main(args: Array<String>) {
    //sampleStart
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
    println(result) // 5 is in range

    // else if で次々つなげることも可能
    val age = 7
    val fee = if (age > 12) {
        "大人料金"
    } else if (age >= 6) {
        "小人料金"
    } else {
        "無料"
    }
    println("$age 歳は $fee")
    //sampleEnd
}
```

* when
  * switch 文のようなもの (なお Kotlin に switch はない)
  * if と同じく、else を伴うことで「式」として用いることが可能

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // オーソドックスな when の使い方
    val n = 5
    when (n) {
        1    -> println("access")
        2, 3 -> println("company")
        else -> println("com")
    }
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // is を用いた型チェック
    // 値の代入もできる
    val n = 5
    val type = when (n) {
        is Int -> "$n is Int"
        else   -> "$n is not Int"
    }
    println(type)   // 5 is Int
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // when のあとに値を伴わない書き方もできる
    val n = 5
    when {
        // 以下、条件に一致したものがどれかひとつ実行される
        // 評価は上から順番に行われる
        n % 15 == 0 -> println("fizzbuzz")
        n % 5 == 0 -> println("buzz")
        n % 3 == 0 -> println("fizz")
        else -> println("$n")
    }
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // 定数以外も用いることができる
    val n = 5
    when {
        n in 1..5 -> println("access")  // レンジ
        n > 5     -> println("company")
        else      -> println("com")
    }
    //sampleEnd
}
```

## ループ

* while

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // while による繰り返し
    var count1 = 0
    while (count1 < 5) {
        // 繰り返したい処理
        count1++
    }
    println(count1)
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // do-while も使えます
    // 単なる while は繰り返し 0 回 (＝何もしない) もできるが、
    // do-while の場合はまず do の中身を一度実行してから繰り返す
    var count2 = 0
    do {
        // 繰り返したい処理
        count2++
    } while(count2 < 5) // 5 を 0 にして確認しよう
    println(count2)
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // 無限ループ
    while (true) {
        // 繰り返したい処理
        println("押しちゃ駄目だ、押しちゃ駄目だ、押しちゃ駄目だ、押しちゃ駄目だ、押しちゃ駄目だ")
    }
    //sampleEnd
}
```

* for

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // for 文で繰り返し実行が可能なのは、
    // イテレータを提供するオブジェクト (配列、リスト、レンジ、等)
    
    // Int の配列の場合
    val ints = arrayOf(1, 2, 3)
    for (n in ints) {   // 要素名 in イテレータオブジェクト
        println(n)  // 1, 2, 3 が順番に出力される
    }
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // レンジを使う場合
    var sum = 0
    for (n in 1..10) {
        sum += n
    }
    println(sum)    // 55
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // リストを使う場合
    var sum = 0
    val list = (1..10).toList()
    for (n in list) {
        sum += n
    }
    println(sum)    // 55
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // 途中でループを抜けたり (break)
    // 次のループまでスキップしたり (continue)
    var count = 0
    while (true) {
        count++
        if (count == 10) {
            break // while ループを抜ける
        }
        if (count % 3 == 0) {
            println("3の倍数です！")
            continue // 後ろの処理を行わずに次のループを開始する
        }
        println(count)
    }
    //sampleEnd
}
```

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // ループが多重の場合は、
    // どのループを抜けるかラベルで指定する
    outer@ for (i in 1..10) { // ← outer というラベルをつけたところ
        for (j in 1..10) {
            println("i=$i, j=$j")
            if ((i+j) % 3 == 0) {
                println("Break!")
                break@outer // 外側のループを抜ける
                // break のように何も指定しない場合、内側のループを抜ける
            }
        }
    }
    //sampleEnd
}
```
