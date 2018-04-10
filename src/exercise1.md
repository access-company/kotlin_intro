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

### ポイント

* `if` 文、`for` ループが使えれば解けるだろう
* `when` を使って短く書いたりもできる
* 単体テストも書いてみよう
