# ジェネリクス

ジェネリクスについて記載します。

## ゴール

以下を理解していること。

* ジェネリクスの使い方、使いどころ
  * ジェネリック関数
  * ジェネリック制約

## ジェネリクス

* ジェネリクスとは
  * 利用する型を仮で書いておいて、実際の型はあとから指定するという記述方法。
  * 任意の型をパラメータにしたいときはどのような書き方ができるか？ 

```kotlin
// value というプロパティを持った Container というクラスを仮定
// value の型は Any

class Container(val value: Any)

fun main(args: Array<String>) {
    // 値を入れるとき
    val intContainer: Container = Container(10)       // OK
    val strContainer: Container = Container("hello!") // OK

    // 値を取り出すとき
    // as ◯◯ をつけてキャストする必要がある
    val i = intContainer.value as Int      // OK
    val s = strContainer.value as String   // OK

    // ところがキャストは失敗する可能性がある
    val i2 = intContainer.value as String  // 実行時に ClassCastException の例外を吐かれる
}
```

* 上記の例の場合、ClassCastException が出ないように作るのはプログラマの責任
  * ジェネリクスを使うと、コンパイル時に妥当かチェックしてもらえる


```kotlin
// any を使わず、ジェネリクスを使った場合
// value の型は <T> として仮置きしている

class Container<T>(val value: T)

fun main(args: Array<String>) {
    // 値を入れるとき
    val intContainer: Container<Int> = Container<Int>(10)

    // 値を取り出すときにキャスト不要
    // キャスト不要なので ClassCastException も起こらない
    val i: Int = intContainer.value 

    // 使い方が違っていればコンパイル時にエラーになる
    val s: String =  intContainer.value // コンパイルエラー
}
```

* ジェネリック関数
  * ジェネリクスは関数、メソッド、プロパティにも適用できる

```kotlin
// data クラスにしてみる
data class Container<T>(val value: T)

// 関数にジェネリクスを用いる場合
fun <T> box(value: T): Container<T> {
    return Container(value)
}

val <T> T.string: String
    get() = toString()

fun main(args: Array<String>) {
    val container = box<Int>(100)
    println(container.string) // Container(value=100)
}
```

* ジェネリック制約
  * ジェネリクスでは任意の型を扱うことができるが、  
  「何らかのクラスのサブクラスだけに制限したい」という制限も可能

```kotlin
interface IFA
interface IFB
class A<T>()
class B<T : IFA>() // IFA interface を継承した T に限る

fun main(args: Array<String>) {
    A<IFA>() // OK
    A<IFB>() // OK
    B<IFA>() // OK
    B<IFB>() // error: type argument is not within its bounds: should be subtype of 'IFA'
}
```

* `where` を使って制約を複数にすることもできる

```kotlin
interface IFA
interface IFB
interface IFC: IFA, IFB // IFC は IFA、IFB を継承

class A<T> where T : IFA, T: IFB  // T は IFA のサブクラスかつ IFB のサブクラスに限る

fun main(args: Array<String>) {
    A<IFA>() // error: type argument is not within its bounds: should be subtype of 'IFB'
    A<IFB>() // error: type argument is not within its bounds: should be subtype of 'IFA'
    A<IFC>() // OK
}
```

* 以下については記載を省略
  * 変位指定
  * スター投影
  * 具象型
