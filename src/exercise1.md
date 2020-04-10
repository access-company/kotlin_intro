# Exercise (1)

## Hello World!

まずはこれ！ソースをコンパイルしてとりあえず動かすところまでやってみよう！

* 環境構築の方法については、[開発環境の構築](./development_environment.md) を参照のこと。
* 最初のプロジェクトを作成したら、以下のソースコードを書いて、Run してみよう！

```kotlin
fun main(args: Array<String>) {
    println("Hello world!")
}
```

* もしAndroid StudioでKotlinTrainingプロジェクトを使っている場合は、SampleTest.ktに以下のように書こう！

```kotlin
@Test
fun testExercise() {
    println("Hello world!")
}
```

## Fizz Buzz

基本的な文法、関数の使い方を抑えたところで、以下の練習をやってみよう！

* 入力は 1〜100
* 3の倍数の時は「Fizz」を出力
* 5の倍数の時は「Buzz」を出力
* 3の倍数かつ5の倍数の時は「FizzBuzz」を出力
* それ以外のときはそのまま数字を出力

* 出力例

```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
...
FizzBuzz
91
92
Fizz
94
Buzz
Fizz
97
98
Fizz
Buzz
```

* ポイント
  * `if` 文、`for` ループが使えれば解けるはず
  * `when` を使って短く書いたりもできる

```kotlin
fun main(args: Array<String>) {
    for (i in 1..100) {
        // 実装する
    }
}
```

* ところで上記のコードだと単体テストが書きにくい...
  * どのようにしたら単体テストが書きやすくなるか？
  * 単体テストも書いてみよう！

```kotlin
// 単体テスト例
// * fizzbuzz テスト用のクラスを新規に作って書いてもいい
// * 既存のテストクラスにメソッドを追加してもよい

package io.access.kotlintraining

import org.junit.Test
import kotlin.test.assertEquals

class FizzBuzzTest {
    @Test
    fun testFizzBuzz() {
        // TODO: テストを書く
        // assertEquals 等の assert 系 function を使おう
        // 以下の kotlin.test パッケージのリファレンスも参照のこと
        // https://kotlinlang.org/api/latest/kotlin.test/kotlin.test/index.html
    }
}
```

## うるう年

入力された数字を西暦としたときに、うるう年かどうか判定する関数を書いてみよう！

* 入力は 0 以上の `Int`
* うるう年ならば `true`、そうでないならば `false` を返す
* ところでうるう年って？
  * 年が 4 で割り切れる場合、その年はうるう年として扱う。  
  ただし、100 で割り切れてかつ 400 で割り切れない年は除く
  * 1700、1800、1900、2100、2200、2300、2500、2600 はうるう年ではない
  * 1600、2000、2400 はうるう年
* 単体テストも書いてみよう！

```kotlin
// うるう年かどうかを判定する関数
fun isLeapYear(y: Int): Boolean {
    // TODO: 実装する
}
```

## 累乗

数字をふたつ引数にとって (`a`、`n` とする)、a の n 乗を返す関数を書いてみよう！

* 入力は `a`、`n` 共に任意の数 (正の数でも負の数でも浮動小数点でも OK) とする
* …とすると考慮することが非常に増えるので、ここではひとまず、いずれも正の整数とする
  * 余裕があったら浮動小数点も取れるようにしてみよう！

```kotlin
fun power(a: Int, n: Int): Long {
    if (a < 0 || n < 0) {
        println("inputs must be positive. return 0")
        return 0
    }
    // TODO: 実装する
}
```

