# その他豆知識

その他、豆知識を記載します。

## ゴール

以下について理解していること

* 演算子オーバーロード
* 等価、同値 (`===` と `==`)
* 分解宣言
* 列挙型
* 例外
* 再起呼び出しと末尾再起呼び出し最適化
* ローカル関数
* coroutine
* apply
* also
* by lazy

※一部は時間の都合上、記載省略

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
// 「末尾呼び出し最適化 (Tail Call Optimization)」と呼ばれる最適化を行うことができる
// * 関数定義の頭に tailrec をつける
// * 再帰呼び出しを関数の最後にもっていく
tailrec fun sum(numbers: List<Long>, acc: Long = 0): Long = // ← tailrec というのをつけた
    if (numbers.isEmpty()) acc
    else sum(numbers.drop(1), acc + numbers.first()) // sum の再帰呼び出しが関数の最後にきている

// 動く！
sum((1L..123456).toList())
```

## ローカル関数

* ローカル関数は関数の中に関数を定義できる仕組み
  * 他の関数からは呼び出すことができない (関数内にスコープを限定)
  * 以下はローカル関数と再帰呼出しの組み合わせ

```kotlin
fun sum(numbers: List<Long>): Long {
    // 引数を 2 つとる関数をローカル関数化し、
    // 外面を良く (引数 1 個で済むように) した
    tailrec fun go(numbers: List<Long>, acc: Long): Long = 
        if (numbers.isEmpty()) acc
        else go(numbers.drop(1), acc + numbers.first())

    return go(numbers, 0)
}
```

## apply

* オブジェクトに対し、プロパティの変更を一括適用する

```kotlin
class Company (
    var name: String,
    var numberOfEmployees: Int = 0
)

fun main(args: Array<String>) {
    val c = Company("ACCESS", 310).apply {
        // 今年の新卒社員数を加算
        numberOfEmployees += 15
    }
    val s = "${c.name} has ${c.numberOfEmployees} employees."
	println(s) // ACCESS has 325 employees.
}
```

* プロパティの数が多い場合、`c.xxx = yyy`みたいな記述を繰り返す手間が省ける

## also

* applyと似てるが、alsoはラムダ式の中で別の名前を付けることができる
  * デフォルトはit
  * つまり、applyの場合はラムダ式の内外で`this`の指す先が異なるが、alsoを使うと同じになる
* letとも似てるが、letは最後の行を返すのに対し、alsoは元のオブジェクトを返す

```kotlin
val s = "access".also { it.toUpperCase() }
println(s) //=> ACCESS
```


## by lazy

* 遅延プロパティと呼ばれる
* 最初にアクセスがあった時に、ラムダの中身を計算し、最終行の値をvalに保持する
  * それ以降は、単に保持された結果を返す

```kotlin
val greetMessage: String by lazy {
    println("First time!")
    "Hello!"
}

fun main(args: Array<String>) {
    println(greetMessage) // "First time!\nHello!"
    println(greetMessage) // "Hello!"
}
```

* 実際は、画面の起動時には設定できないけど、更新時にはじめて設定できるものとかに使う
  * それはvarでも実装できるが、by lazyの場合valにできるのが利点