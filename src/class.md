# クラス

クラスについて記載します。

## ゴール

以下について理解すること。

* オブジェクト指向
* 基本的なクラスの作り方、使い方
* メソッド
* プロパティ
* コンストラクタとイニシャライザ
* エクステンション

## オブジェクト指向とクラス

* 突然出てきた用語…まず「オブジェクト」って？
  * 物や事柄すべてのこと。人間とか、木とかもオブジェクト
  * プログラミング的には、データと関数の集合体
* 「クラス」って？
  * オブジェクトの設計図
* なぜクラスが要るの？
  * 同じオブジェクトを毎回ゼロから組み立てるのは大変だから
* オブジェクト指向って？
  * オブジェクトをクラスやインスタンスで表現し、効率よくアプリ全体を組み立てようって考え方
  * インスタンスについては、すぐ後で説明する
* 継承、インタフェース、カプセル化の理解も大事だが、ここでは省略
* [以前の研修で使われてた資料](https://docs.google.com/presentation/d/1pzKUl1rqM-dd7fMYNRovbitPcFttHjkSfJGtPHp2j9w/edit#slide=id.p)（参考までに）

…と、これだけでは伝わらないと思うので、具体例へ

### 家計簿アプリを作る場合、どうする？

* 機能が多いので、収支履歴機能、残高機能、口座機能、と機能別に設計するのが望ましい

<img src=./assets/images/class_sample.png />

* 収支履歴クラス、残高クラス、口座クラス、さらにユーザー情報クラスと分割
  * それぞれに必要なデータ(変数)と処理(関数)を持たせる。データだけのクラス、処理だけのクラスもあり得る
  * クラスは、1つの機能を持ったプチOS、とイメージしてもよい
* クラスだけでは、データを保持できない。画面を表示してる間はデータを保持する必要がある
* そこでアプリは、クラスをコンピューターメモリ上に生産し、データ保持可能にする。その生産物が**インスタンス**
  * オブジェクトと呼ぶこともある
* アプリは、必要なインスタンスを参照しながら、家計簿として振る舞う
  * 例えば、残高と収支履歴のインスタンスを使って今月の家計簿を表示するなど

## クラスの作り方と使い方

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
    pankona.age  = 37

    // プロパティの値を参照する
    println(pankona.name)       // yosuke akatsuka
    println(pankona.age)        // 37
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
// コンストラクタの書き方は従来はこう。
class Person constructor(n: String, a: Int) {
    var name: String = n
    var age: Int = a
}

fun main(args: Array<String>) {
    // コンストラクタを用いたインスタンスの初期化
    val p = Person("yosuke akatsuka", 37)
    println(p.name) // yosuke akatsuka
    println(p.age)  // 37
}
```

```kotlin
// ヒトを表すクラス
// コンストラクタに val、var を伴うことで、そのままプロパティとして扱うこともできる。
class Person constructor(val name: String, val age: Int)

fun main(args: Array<String>) {
    // 前の例と同じように使える
    val p = Person("yosuke akatsuka", 37)
    println(p.name) // yosuke akatsuka
    println(p.age)  // 37
}
```

```kotlin
// ヒトを表すクラス
// ちなみに、constructor の文字は省略が可能 (先述のものと意味は同じ)
class Person (val name: String, val age: Int)
```

* コンストラクタの色々
  * クラス名の横にコンストラクタを書く場合、それを「primary constructor」と呼ぶ。
  * クラスの中にふたつめ以上のコンストラクタを書く場合、それ (ら) を「secondary constructor」と呼ぶ。
  * primary constructor がある場合、secondary constructor は primary constructor を呼び出す必要がある。
  * primary constructor に処理は書けないが、secondary constructor には処理が書ける。
  * primary constructor で処理が書きたい場合は、後述のイニシャライザを用いる。

```kotlin
// ヒトを表すクラス
// 別引数を持つ2つ目のコンストラクタを定義することもできる
class Person (val name: String, val age: Int) {
    // 引数なしのコンストラクタを定義
    // this を使って ↑ のコンストラクタを呼び出す
    constructor() : this("anonymous", 999) {
        println("this is secondary constructor!")
    }
}
```

* イニシャライザ
  * primary constructor が解決された後に呼び出される部分
  * constructor では足りない初期化処理を行う場合はここでやる
  * エラー処理 (例外を発生させる) のであればここで

```kotlin
// ヒトを表すクラス
class Person(val name: String, val age: Int) {
    init {
        // 条件を満たさない場合は例外をスロー
        // java.lang.IllegalArgumentException: Failed requirement.
        require(age >= 0)
    }
}

fun main(args: Array<String>) {
    val p = Person("pankona", -10) // 例外発生
}
```

## クラスの拡張

* 拡張関数
  * 既存のクラスにメソッドを追加する仕組み

```kotlin
// 文字列の長さを取得する関数を普通に作ると
fun strlen(str: String) = str.length

fun main(args: Array<String>) {
    strlen("hogehoge") // 8
}
```

```kotlin
// 文字列の長さを返す関数 size を String クラスに生やす
// オブジェクトへの参照を得るには this が使える (省略可)
fun String.size() = this.length

fun main(args: Array<String>) {
    "hogehoge".size() // 8
}
```

* 拡張プロパティ
  * 既存のクラスの拡張はメソッドのみならず、プロパティの追加もできる。
  * ただしバッキングフィールドは追加できない。

```kotlin
// 文字列の長さを返すプロパティを生やす
val String.size: Int
    get() = this.length

fun main(args: Array<String>) {
    "hogehoge".size // 8
}
```

## データクラス

* data class の定義
  * クラスを単にデータの塊として表現したいときに用いる
  * 通常のクラス定義の頭に `data` をつける

```kotlin
// ヒトクラス (data が頭にくっついている)
data class Person(val name: String, val age: Int)
```

* data class の特徴

```kotlin
// 同じ名前と年齢を与える
val p1 = Person("access", 37)
val p2 = Person("access", 37)

// 以下は true になる
p1 == p2    // true

// println に渡すといい感じに表示される
println(p1) // Person(name = access, age = 37)

// copy 等の便利メソッドが生える
val p3 = p1.copy()
println(p3) // Person(name = access, age = 37)

// copy は一部のプロパティだけついでに変更したりもできる
val p4 = p1.copy(age = 17)
println(p4) // Person(name = access, age = 15)
```

* data class を使うと嬉しい場面
  * 通常のクラスを用いると、上記の比較は `p1` と `p2` はイコール判定されない
  * `copy` 等の便利メソッドを自動的に生やしてくれる
  * 以下は通常のクラスとの違い

```kotlin
// ヒトクラス
class Person(val name: String, val age: Int)

// 同じ名前と年齢を与える
val p1 = Person("access", 37)
val p2 = Person("access", 37)

// p1 と p2 は、「値は同じかもしれないが違うオブジェクト」なので
// 下記の評価結果は false になる
p1 == p2 // false

// println に渡しても内容は表示されない
println(p1) // Line_5$Person@3bd42f5b

// copy メソッドがないのでコピーできない
val p3 = p1.copy() // メソッドがないのでエラー

// 以下をやると参照のコピーになる (p1 を変更すると p4 も変更される)
val p4 = p1
```
