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
// ヒトを表すクラス
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
  * クラスからオブジェクトを生成することをインスタンス化という

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

* バッキングフィールド
  * 値を実際に置かれている領域のこと
  * カスタムゲッターを置くとバッキングフィールドはなくなる
  * プロパティと呼んでいるのは、バッキングフィールドにアクセスするための窓口

```kotlin

// ヒトを表すクラス (再掲)
class Person {
    // これらのプロパティはバッキングフィールドを持つ
    var name: String = ""
    var age: Int = 0

    // カスタムゲッターを設定
    // 本プロパティにはバッキングフィールドがない
    val nameLength: Int
        get() = name.length
}
```

* lateinit
  * バッキングフィールドをもつプロパティは、宣言と同時に値を入れる (初期化) が必須
  * ただ、それだと困る場合があるので初期化を遅らせる `lateinit` という仕組みがある
  * `lateinit` は `var` にのみつけられる
  * `lateinit` をつけていて値の初期化を行う前にプロパティにアクセスすると
  `kotlin.UninitializedPropertyAccessException` という例外がスローされる
  * Android アプリの開発においては割と多様される (諸説ある)

```kotlin
// コンパイルが通らないヒトを表すクラス
class Person {
    // これらのプロパティはバッキングフィールドを持つ
    // そのため、以下のように宣言時に初期化をしないとコンパイルエラーになる
    var name: String  // コンパイルエラー！
    var age: Int      // コンパイルエラー！
}
```

```kotlin
// lateinit を使ってコンパイルが通るヒトを表すクラス
class Person {
    // lateinit を使うと、宣言時に初期化しなくて良い
    lateinit var name: String
    lateinit var age: Int
}

fun main(args: Array<String>) {
    val p = Person()

    // p.name は未初期化なので、このまま触ると
    // kotlin.UninitializedPropertyAccessException が発生
    println(p.name) 
}
```

* this
  * クラス内で別のプロパティ、メソッドにアクセスする際に使える
  * 省略しても良い。

```kotlin
// ヒトを表すクラス (再掲)
class Person {
    var name: String = ""
    var age: Int = 0
    val nameLength: Int
        get() = this.name.length // ← this をつけて name を参照
}
```

* コンストラクタ
  * インスタンスを生成する際に、各プロパティの初期化を補助する仕組み

```kotlin
// ヒトを表すクラス
// コンストラクタの書き方はこう。
class Person constructor(n: String, a: Int) {
    var name: String = n
    var age: Int = a
}

fun main(args: Array<String>) {
    // コンストラクタを用いたインスタンスの初期化
    val p = Person("yosuke akatsuka", 35)
    println(p.name) // yosuke akatsuka
    println(p.age)  // 35
}
```

```kotlin
// ヒトを表すクラス
// コンストラクタに val、var を伴うことで、そのままプロパティとして扱うこともできる。
class Person constructor(val name: String, val age: Int)

fun main(args: Array<String>) {
    // 前の例と同じように使える
    val p = Person("yosuke akatsuka", 35)
    println(p.name) // yosuke akatsuka
    println(p.age)  // 35
}
```



* イニシャライザ

## クラスの拡張

* 拡張関数

* 拡張プロパティ


## データクラス

* data class の定義

* data class の使い方

* data class を使うと嬉しい場面
