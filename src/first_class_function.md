# ちょっと特殊な関数の使い方

第一級オブジェクトとしての関数について記載します。

## ゴール

以下を理解すること。

* 関数もオブジェクトとして扱える
* 高階関数
* ラムダ式、クロージャ
* インライン関数

## オブジェクトとしての関数

* 関数もオブジェクトの一種

```kotlin
// 関数のオブジェクトを変数に代入する例

// 入力を二乗する関数
fun square(i: Int) = i * i

// 関数のオブジェクトを取得するときは "::" をつける
// println してみる
println(::square) // "fun square(kotlin.Int): kotlin.Int" みたいのが返される

// 変数に代入できる
val func = ::square

square(5) // 25
func(5)   // 25 (square を呼び出したのと同じ)
```

* 関数オブジェクトの型は？

関数オブジェクトもオブジェクトの一種なので「型」がある

```kotlin
// 入力を二乗する関数
fun square(i: Int) = i * i
println(::square) // "fun square(kotlin.Int): kotlin.Int"

// 上の関数は「Int を引数にとって Int を返す関数」という型
// (Int) -> Int と書く

// 「Int を引数にとって Int を返す関数」という変数に代入
val func1: (Int) -> Int = ::square // 型があっていれば代入できる

// 型があってないと代入できない
// 以下の関数は (String) -> Unit という型
fun greet(name: String) = println("Hello $name!")
val func2: (Int) -> Int = ::greet // 型があっていないので代入できない (コンパイルエラー)
```

* 関数を引数として渡したり戻り値にしたり (高階関数)

```kotlin
// 関数を引数にとる関数
// 第二引数には「Int を引数にとる関数」を指定する
fun printWith(ints: List<Int>, printFunc: (Int) -> Unit) {
    for (i in ints) {
        printFunc(i) // 引数でもらった関数を呼び出す
    }
}

// Int を引数にとる関数の例
fun myPrintFunc(i: Int) {
    if (i % 3 == 0) {
        println("3の倍数です!")
    } else {
        pritnln(i)
    }
}

// 関数を引数に指定して呼び出す
printWith((1..10).toList(), ::myPrintFunc)
```

```kotlin
// n 乗を返す関数を生成する関数
fun powerGen(n: Int): (Int) -> Long {
    fun power(num: Int): Long {
        var result: Long = 1
        for (i in 0..n) {
            result *= num
        }
        return result
    }
    return ::power
}

// 入力を 5 乗する関数を生成
val fivePowerOf = powerGen(5)
fivePowerOf(10) // 1000000

// 入力を 10 乗する関数を生成
val tenPowerOf = powerGen(10)
tenPowerOf(2)   // 2048
```

## 色々な関数の作り方

* ラムダ式

* クロージャ

* インライン関数

* 無名関数

