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
* also
* by lazy

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


