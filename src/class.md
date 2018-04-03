# クラス

クラスについて記載します。

## ゴール

以下について理解すること。

* 基本的なクラスの作り方、使い方
* メソッド
* プロパティ
* コンストラクタとイニシャライザ
* エクステンション

## クラスの作り方と使い方

* クラスって？
  * 別講義「オブジェクト指向」にてまあまあ細かく紹介する予定
  * ざっくり言えば「変数と関数を集めてオブジェクトの雛形として使う」ためのもの

* クラスを定義する
  * 以下、クラスにプロパティとメソッドを持たせる例。

```kotlin
// Person (人) クラス
class Person {
    // プロパティ (名前)
    var name: String = ""

    // プロパティ (年齢、カスタムセッター付き)
    var age: Int = 0
        set(i) =
            if (i < 0) {
                println("invalid argument. only positive value can be specified to age property.")
                // field という変数で代入する。age = 0 とやると…？
                field = 0 
            } else {
                field = i
            }

    // プロパティ (名前の長さ、カスタムゲッター付き)
    val nameLength: Int
        get(): Int {
            return name.length
        }

    // メソッド (20歳以上かどうかを返す)
    fun isAdult(): Boolean {
        if (age >= 20) {
            return true
        }
        return false
    }
}
```

* クラスの使い方 (インスタンス化)

```kotlin
fun main(args: Array<String>) {
    // Person クラスのインスタンス化
    val pankona = Person()

    // プロパティに値をセット
    pankona.name = "yosuke akatsuka"
    pankona.age  = 35

    // プロパティの値を参照する
    println(pankona.name)       // yosuke akatsuka
    println(pankona.age)        // 35
    println(pankona.nameLength) // 15

    // メソッドの呼び出し
    if (pankona.isAdult()) {
        println("pankona belongs to adult team")
    } else {
        println("pankona belongs to young team")
    }
}
```

* lateinit

* this

* コンストラクタ

* イニシャライザ

## クラスの拡張

* 拡張関数

* 拡張プロパティ


## データクラス

* data class の定義

* data class の使い方

* data class を使うと嬉しい場面
