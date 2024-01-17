# Exercise (2)

クラスの使い方を抑えたところで、以下の練習をやってみよう！

## 奇数か偶数か

`Int` を拡張して、`isOdd`、`isEven` メソッドを追加してみよう！

* `isOdd` ... 数が奇数であるときに `true` を返し、偶数のときに `false` を返すメソッド
* `isEven` ... 数が偶数であるときに `true` を返し、奇数のときに `false` を返すメソッド

```kotlin
// TODO: isOdd と isEven を拡張メソッドで実装する

fun main(args: Array<String>) {
    val a = 5
    println(a.isOdd())  // true
    println(a.isEven()) // false
}
```

## n 面のサイコロ

サイコロクラス (Dice クラス) にプロパティ、メソッドを使って以下の機能を実装してください

* 「サイコロを振る」メソッド `roll` を備える
  * `roll` は Int をひとつ返すメソッド。返る値は 1 以上 `diceFace` 以下。ただし `diceFace` はコンストラクタの引数で与えられた値。
* 100 回振ると壊れて例外 `Exception("I was broken")` を投げる
  * 以後、`roll` を呼び出すと例外を投げる
  * 別の Dice インスタンスを作ればまた `roll` できる

```kotlin
import kotlin.random.Random

class Dice(private val diceFace: Int) {
    // TODO: class Dice を完成させる

    fun roll(): Int {
        // ヒント：以下は、0〜5 までの値がランダムで返る
        val n = Random.nextInt(6) 
        return n
    }
}

fun main(args: Array<String>) {
    val d = Dice(16)
    for (i in 1..100) {
        println(d.roll()) // 1〜16 までの数字
    }
    println(d.roll()) // Exception
}
```

## 呼び出した回数をカウントする

カスタムセッターを使って、何度呼び出されたかをカウントしてみよう！

```kotlin
class MyCustomClass {
    var counter: Int = 0
    var propertyWithCounter: Int = 0
        /* TODO: ここにカスタムセッターを書く */
}

fun main(args: Array<String>) {
    val p = MyCustomClass()
    p.propertyWithCounter = 123
    p.propertyWithCounter = 456
    p.propertyWithCounter = 789
    println(p.counter) // 3
}
```

## 世界のナベアツ

ところで、世界のナベアツはご存知でしょうか。
* 現在は落語家になっていらっしゃる。高座名は「桂三度」
* 彼の持ちネタ「3の倍数と3が付く数字のときだけアホになります」というのがいっとき (2008年前後と思われる) 流行った
* 詳細は wikipedia 等を参照されたし

ということで、ナベアツクラスを作ってみよう！
* `next` というメソッドを持つ。戻り値は `String`
* ナベアツは内部的にカウンターを持っており、`next` が呼び出されるたびにカウンターを 1 つずつ増やしていく
* 内部カウンターが「3の倍数と3が付く数字のとき」、`next` は `Aho` を返す
* それ以外のときは、カウンターの値を文字列にしたものをそのまま返す

```kotlin
class NabeAtsu {
    // TODO: 実装する

    fun next(): String {
        // TODO: 実装する
    }
}

fun main(args: Array<String>) {
    val n = NabeAtsu()
    for (i in 1..100) {
        println(n.next())
    }
}
```

```bash
# 実行例 (実際は改行されますがスペースの関係で横に書きます)
1 2 Aho 4 5 Aho 7 8 Aho 10 11 Aho Aho 14 Aho 16 17 Aho 19 20 Aho 22 Aho Aho 25 26 Aho 28 29 Aho
Aho Aho Aho Aho Aho Aho Aho Aho Aho 40 41 Aho Aho ...
```
