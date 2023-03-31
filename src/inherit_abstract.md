# 継承・抽象クラス

クラスの継承・抽象クラスについて記載します。

## ゴール

以下を理解していること。

* 継承の振る舞い
* 抽象クラスの使い方、抽象クラスの存在意義
* オーバーライドの仕方 (`open`)
* 可視性 (`public`、`internal`、`private`、`protected`)

## 継承

* 継承とは
  * ざっくり言えば「あるクラスの性質を別のクラスに引き継ぐ」ための仕組み

* クラスを継承

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // ヒトクラス
    class Person(val name: String) {
        // 名前の長さを返すプロパティ
        val nameLength: Int
            get() = name.length

        // どこで生まれたかを返すメソッド
        fun bornFrom() = "unknown"
    }

    val p = Person("Tonio Nagauzzi")
    println(p.name)         // Tonio Nagauzzi
    println(p.nameLength)   // 14
    println(p.bornFrom())   // unknown
    //sampleEnd
}
```

* ヒトクラスを継承してみる
  * このままでは継承はできなくて、`open` をつける必要がある
  * 継承すると、メソッド一式とプロパティ一式を継承先は引き継ぐ

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // open がついて継承可能になったヒトクラス
    open class Person(val name: String) {
        // 名前の長さを返すプロパティ
        val nameLength: Int
            get() = name.length

        // どこで生まれたかを返すメソッド
        fun bornFrom() = "unknown"
    }

    // ヒトクラスを継承して男クラスと女クラスを作る
    // (コンストラクタに val がついてない点に注意)
    class Man(name: String) : Person(name)
    class Woman(name: String) : Person(name)

    // ヒトクラスを使う
    val p = Person("p")
    println(p.nameLength) // 1
    println(p.bornFrom()) // unknown

    // 継承した各クラスを使う
    // 各々、Person から引き継いだプロパティが利用できる
    val m = Man("bob")
    println(m.name)       // bob  
    println(m.nameLength) // 3  
    println(m.bornFrom()) // unknown

    val w = Woman("alice")
    println(w.name)        // alice
    println(w.nameLength)  // 5
    println(w.bornFrom())  // unknown
    //sampleEnd
}
```

* メンバのオーバーライド
  * プロパティ、メソッドを継承先で上書きする仕組み
  * オーバーライドするためには、オーバーライドするプロパティ、メソッドに `open` をつける

```kotlin
fun main(args: Array<String>) {
    //sampleStart
    // open がついて継承可能になったヒトクラス
    open class Person(val name: String) {
        // open がついて継承が可能になった名前の長さを返すプロパティ
        open val nameLength: Int
            get() = name.length

        // open がついて継承が可能になったどこで生まれたかを返すメソッド
        open fun bornFrom() = "unknown"
    }

    // ヒトクラスを継承して男クラスと女クラスを作る
    class Man(name: String) : Person(name) {
        // nameLength を Man 用の振る舞いにオーバーライド
        override val nameLength: Int
            get() {
                print("$name (man) ") // 名前の後ろに (man) を表示するようにした
                return name.length
            }

        // bornFrom を Man 用の振る舞いにオーバーライド
        override fun bornFrom() = "mud" // 土から生まれた

        fun doShibakari() {
            println("山へ芝刈りに")
        }
    }

    class Woman(name: String) : Person(name) {
        // nameLength を Woman 用の振る舞いにオーバーライド
        override val nameLength: Int
            get() {
                print("$name (woman) ") // 名前の後ろに (woman) を表示するようにした
                return name.length
            }

        // bornFrom を Woman 用の振る舞いにオーバーライド
        override fun bornFrom() = "rib" // 肋骨から生まれた

        fun doSentaku() {
            println("川へ洗濯に")
        }
    }

    // ヒトクラスを使う
    val p = Person("p")
    println(p.nameLength) // 1
    println(p.bornFrom()) // unknown

    // 継承した各クラスを使う
    // 各々、オーバーライドしたメソッドとプロパティを使ってみる
    val m = Man("bob")
    println(m.name)       // bob  
    println(m.nameLength) // bob (man) 3  
    println(m.bornFrom()) // mud
    // Man 専用メソッド
    m.doShibakari()       // 山へ芝刈りに

    val w = Woman("alice")
    println(w.name)        // alice
    println(w.nameLength)  // alice (woman) 5
    println(w.bornFrom())  // rib
    // Woman 専用メソッド
    w.doSentaku()          // 川へ洗濯に
    //sampleEnd
}
```

* スーパータイプとサブタイプ
  * `Man` と `Woman` は継承元のクラスである `Person` として扱うことができる

```kotlin
fun main(args: Array<String>) {
    open class Person(val name: String) {
        // open がついて継承が可能になった名前の長さを返すプロパティ
        open val nameLength: Int
            get() = name.length

        // open がついて継承が可能になったどこで生まれたかを返すメソッド
        open fun bornFrom() = "unknown"
    }
    
    class Man(name: String) : Person(name) {
        // nameLength を Man 用の振る舞いにオーバーライド
        override val nameLength: Int
            get() {
                print("$name (man) ") // 名前の後ろに (man) を表示するようにした
                return name.length
            }

        // bornFrom を Man 用の振る舞いにオーバーライド
        override fun bornFrom() = "mud" // 土から生まれた

        fun doShibakari() {
            println("山へ芝刈りに")
        }
    }

    class Woman(name: String) : Person(name) {
        // nameLength を Woman 用の振る舞いにオーバーライド
        override val nameLength: Int
            get() {
                print("$name (woman) ") // 名前の後ろに (woman) を表示するようにした
                return name.length
            }

        // bornFrom を Woman 用の振る舞いにオーバーライド
        override fun bornFrom() = "rib" // 肋骨から生まれた

        fun doSentaku() {
            println("川へ洗濯に")
        }
    }

    //sampleStart
    // 継承先 (サブタイプ) を、
    // 継承元 (スーパータイプ) の変数に入れる
    val m: Person = Man("bob")

    // Person (継承元) が持っているプロパティ、メソッドにはアクセスできる
    // 実装は Man (継承先) に従う
    println(m.name)         // bob
    println(m.bornFrom())   // mud
    m.doShibakari()         // m はあくまで Person なので doShibakari は使えない (コンパイルエラー)
    //sampleEnd
}
```

* 最後の行は `(m as Man).doShibakari()` とダウンキャストすればコンパイルできる

## 抽象クラス

* 抽象クラスを使うと嬉しい場面
  * サブクラスにオーバーライドを強制する仕組み
  * `abstract` をつけたメソッドやプロパティは、サブクラスで必ずオーバーライドする必要がある

```kotlin
fun main(args: Array<String>) {
    abstract class Person() {
        // どこから生まれたかメソッドを抽象メソッドにする。
        // abstract の場合、スーパークラスでは実装を書かなくてよい。
        // なお、abstract がついてる場合はオーバーライドすることが前提なので、
        // open もつけなくて良い
        abstract fun bornFrom(): String
    }

    class Man() : Person() {
        // スーパークラスでは abstract がついているメソッドなので、
        // サブクラスでオーバーライドしないとコンパイルエラーになる
        override fun bornFrom() = "mud"
    }

    class Woman() : Person() {
        // こっちもオーバーライドする
        override fun bornFrom() = "rib"
    }

    // 使い方
    val p: Person = Person()    // Person は abstract なのでインスタンス化はできない
    val m: Person = Man()       // これは OK
    val w: Person = Woman()     // これも OK

    println(m.bornFrom())       // mud
    println(w.bornFrom())       // rib
}
```

## 可視性

* この章ではブラウザ上でのコード実行はできません。実行機能はパッケージ分けに対応していないから

* パッケージ
  * パッケージ (`package`) とはクラスを分類する仕組み。基本的に全てのクラスはどこかのパッケージに属している
  * パッケージを指定しない場合、デフォルトのパッケージ (名前はない) に属することになる

```kotlin
//sampleStart
// パッケージを宣言。車パッケージとする
package io.access.car

// 以下、本ファイルに書くクラス、関数は io.access.car パッケージに属する

class Car(val name: String)

fun greet() {
    // ...
}
//sampleEnd

fun main(args: Array<String>) {
    greet()
}
```

* 他のパッケージから io.access.car パッケージを参照する場合、import 文を用いて利用したいパッケージをインポートする必要がある

```kotlin
// Begin Car.kt

package io.access.car

class Car(val name: String)

// End Car.kt

// Begin Store.kt

//sampleStart
// 上記の車パッケージとは別のパッケージ。店パッケージとする
package io.access.store

// car をインポートすると Car を使うことができる
// 以下の書き方をすると io.access.car パッケージに含まれるクラス全てがインポートされる
import io.access.car.*

class Store {
    val car = Car()
}
//sampleEnd

fun main(args: Array<String>) {
    Store(car: Car(name = "Fairlady"))
}

// End Store.kt
```

* インポートしたクラスに `as` を使って別名をつけることもできる
  * クラス名が別のパッケージに含まれるクラスと重複したときなどに有用
  * クラス名が長い場合に短くしたりという使い方も

```kotlin
// Begin Car.kt

package io.access.car

class Car(val name: String)

// End Car.kt

// Begin Store.kt

//sampleStart
package io.access.store

// as を使ってインポートしたクラスに別名をつける
import io.access.car.Car as MyCar

class Store {
    // MyCar として利用できる
    val car = MyCar()
}
//sampleEnd

fun main(args: Array<String>) {
    Store(car: MyCar(name = "Fairlady"))
}

// End Store.kt
```

* トップレベルの宣言における可視性の指定
  * 宣言したクラスについて、他のパッケージ、他のクラスからどの程度参照可能にするかどうかを指定できる
  * トップレベルでの宣言 (クラスや関数の外での宣言を指す) に対しては、`public`、`internal`、`private` が選択できる
  * 何も記載しなかった場合、`public` 扱いになる

```kotlin
// Begin Sample.kt
//sampleStart
// サンプルパッケージがあったとして
package sample

// 以下のように関数が宣言されていたとする

// public はパッケージ外からもファイル外からもアクセス可能 (デフォルト)
public fun publicFunc() { println("public!") }

// private は同一ファイル内からのみアクセス可能
private fun privateFunc() { println("private!") }

// internal は同一モジュールからのみアクセス可能
// モジュールというのは Maven、Gradle のプロジェクト単位
// 外部には公開したくないが内側では広く使いたい、みたいなときに用いる
internal fun internalFunc() { println("internal!") }
//sampleEnd
// End Sample.kt

// Begin Main.kt
import sample

fun main(args: Array<String>) {
    publicFunc()
    privateFunc()
    internalFunc()
}
// End Main.kt
```

```kotlin
// Begin Sample.kt

package sample

public fun publicFunc() { println("public!") }
private fun privateFunc() { println("private!") }
internal fun internalFunc() { println("internal!") }

// End Sample.kt

// Begin Main.kt
//sampleStart
import sample

fun main(args: Array<String>) {
    publicFunc()   // コンパイル OK
    privateFunc()  // コンパイル NG
    internalFunc() // 場合による
}
//sampleEnd
// End Main.kt
```

* クラス内部の宣言の場合
  * トップレベルの宣言時に使える 3 種に加えて、`protected` を使うことができる
  * `private` は同一クラス内からのみアクセス可能
  * `protected` は `private` に近いが、サブクラスからもアクセス可能

```kotlin
//sampleStart
// スーパークラス
open class Person {
    private fun privateMethod() {}
    protected fun protectedMethod() {}
    internal fun internalMethod() {}
    public fun publicMethod() {}
}

// サブクラス
class Woman: Person() {
    fun function() {
        privateMethod()  // コンパイル NG
        publicMethod()   // コンパイル OK
        internalMethod() // 場合による
        protectedMethod()  // コンパイル OK
    }
}

// 関係ないクラス
class Foot {
    fun function() {
        val p = Person()
        p.protectedMethod() // コンパイル NG
        p.publicMethod()    // コンパイル OK
        p.internalMethod()  // 場合による
    }
}
//sampleEnd

fun main(args: Array<String>) {
    Foot().function()
}
```
