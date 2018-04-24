# exercise の解答例

各 exercise の解答例を記載します。  

## exercise (1) - Hello World!

* 答えとなるソースコードは既に載せているので省略。

## exercise (1) - Fizz Buzz

* if を使った例

```kotlin
fun fizzbuzz() {
    for (i in 1..100) {
            if (i % 15 == 0) {
                println("fizzbuzz")
            } else if (i % 5  == 0) {
                println("buzz")
            } else if (i % 3  == 0) {
                println("fizz")
            } else {
                println("$i")
            }
        }
    }
}
```

* when を使った例

```kotlin
fun fizzbuzz() {
    for (i in 1..100) {
        when {
            i % 15 == 0 -> println("fizzbuzz")
            i % 5  == 0 -> println("buzz")
            i % 3  == 0 -> println("fizz")
            else        -> println("$i")
        }
    }
}
```

* テストをやりやすくすることを考えた場合
  * こんな感じでどうでしょうね？

```kotlin
fun fizzbuzz() {
    for (i in 1..100) {
        println(getFizzBuzzString(i))
    }
}

fun getFizzBuzzString(i: Int) = 
    when {
        i % 15 == 0 -> "fizzbuzz"
        i % 5  == 0 -> "buzz"
        i % 3  == 0 -> "fizz"
        else        -> "$i"
    }
}
```

* 元のコードがテストしにくい理由
  * `fizzbuzz` という関数は入力も出力もないので、呼び出した結果が妥当かを判断するすべがない
* どうすればテストしやすくなるか？
  * "ある入力に対して期待する出力がある"状態がテストしやすい
  * 入力と出力を取れる部分を切り出してテスト可能な状態にすればよい

* 以下、テストコードの例

```kotlin
@Test
fun testFizzbuzz() {
    data class TestCase(val input: Int, val want: String)
    val tcs = arrayOf(
            TestCase(1, "1"),
            TestCase(2, "2"),
            TestCase(3, "fizz"),
            TestCase(4, "4"),
            TestCase(5, "buzz"),
            TestCase(6, "fizz"),
            TestCase(7, "7"),
            TestCase(8, "8"),
            TestCase(9, "fizz"),
            TestCase(10, "buzz"),
            TestCase(11, "11"),
            TestCase(12, "fizz"),
            TestCase(13, "13"),
            TestCase(14, "14"),
            TestCase(15, "fizzbuzz"),
            TestCase(30, "fizzbuzz")
            TestCase(45, "fizzbuzz")
    )

    for (tc in tcs) {
        assertEquals(fizzbuzz(tc.input), tc.want)
    }
}
```

## exercise (1) - うるう年

* ちょっと複雑な条件式になりそうだが、うまく書けましたでしょうか
  * 一行で表すとこんな感じでしょうか。

```kotlin
fun isLeapYear(year : Int) = 
    year % 4 == 0 && year % 100 != 0 || year % 400 == 0
```

* テストも書いてみました。

```kotlin
@Test
fun testIsLeapYear() {
    data class TestCase(val input: Int, val want: Boolean)
    val tcs = arrayOf(
            TestCase(1600, true),
            TestCase(2000, true),
            TestCase(2004, true),
            TestCase(2008, true),
            TestCase(2400, true),
            TestCase(1700, false),
            TestCase(1800, false),
            TestCase(1900, false),
            TestCase(2100, false),
            TestCase(2200, false),
            TestCase(2300, false),
            TestCase(2500, false),
            TestCase(2600, false)
    )

    for (tc in tcs) {
        assertEquals(isLeapYear(tc.input), tc.want)
    }
}
```

## exercise (1) - 累乗

* ループさせればとりあえず解けると思います。
  * 普通に書くと `var` を使っていくコードになるかな、と。

```kotlin
fun power(a: Int, n: Int) : Long {
    var ret: Long = 1
    for (i in 1..n) {
        ret *= a
    }
    return ret
}
```

* 関数の再起呼び出しで実装することもできる
  * `n` が大きいとスタックオーバーフローを起こしてしまう
  * スタックオーバーフロー問題を解決するには"末尾再起最適化"という技が使えるが、ここでは割愛

```kotlin
fun power(a: Int, n: Int) : Long = 
        if (n == 1) a.toLong()
        else a * power(a, n - 1)
```

## exercise (2) - 奇数か偶数か

* `Int` を拡張してみる練習
  * `this` を使う必要がある

```kotlin
fun Int.isOdd() = this % 2 == 0
fun Int.isEven() = !this.isOdd()
```

## exercise (2) - n 面のサイコロ

* クラスの基本的な使い方の練習
  * コンストラクタの利用、メソッドの定義、内部状態の変更、を行う必要がある

```kotlin
import java.util.Random

class Dice(val n: Int, var rollCount: Int = 0) {
    fun roll(): Int {
        rollCount++
        if (rollCount > 100) {
            throw Exception("I was broken!")
        }
        return Random().nextInt(n) + 1
    }
}
```

* テストコードはこんな感じでどうでしょうか。

```kotlin
import org.junit.Test
import kotlin.test.assertEquals

class DiceTest {
    @Test
    fun testRoll() {
        val d = Dice(12)
        for (i in 1..100) {
            val ret = d.roll()
            assert(ret >= 1)
            assert(ret <= 12)
        }

        try {
            d.roll()
        } catch(e:Exception) {
            assertEquals(e.message, "I was broken!")
        }
    }
}
```

## exercise (2) - 呼び出した回数をカウントする

* カスタムセッターを生やしてみる問題
  * 見慣れない書き方かもしれないので目を慣らしておく
  * `field` を使ってバッキングフィールドを更新する

```kotlin
class MyCustomClass {
    var counter = 0
    var propertyWithCounter = 0
            set(i: Int) {
                field = i
                counter++
            }
}
```

* テストコード例
  * 値をセットした回数だけカウンターが増えていく
  * 先述のケースの場合、ゲットしたときは値が変わらないので注意

```kotlin
import org.junit.Test
import kotlin.test.assertEquals

class MyCustomClassTest {
    @Test
    fun testMyCustomSetter() {
        val c = MyCustomClass()

        assertEquals(c.counter, 0)
        c.propertyWithCounter = 123
        assertEquals(c.propertyWithCounter, 123)
        c.propertyWithCounter = 456
        assertEquals(c.propertyWithCounter, 456)
        c.propertyWithCounter = 789
        assertEquals(c.propertyWithCounter, 789)
        assertEquals(c.counter, 3)
    }
}
```

## exercise (2) - 世界のナベアツ

* 今までの色々組み合わせ

```kotlin
class Nabeatsu() {
    var count = 0
    fun next(): String {
        count++
        val ret = when {
            count % 3 == 0 -> "aho"
            "$count".contains("3") -> "aho"
            else -> "$count"
        }
        return ret
    }
}
```

* テストコード

```kotlin
import org.junit.Test
import kotlin.test.assertEquals

class NabeatsuTest {
    @Test
    fun testNabeatsu() {
        val tcs = arrayOf("1", "2", "aho", "4", "5", "aho", "7", "8", "aho", "10",
                "11", "aho", "aho", "14", "aho", "16", "17", "aho", "19", "20",
                "aho", "22", "aho", "aho", "25", "26", "aho", "28", "29", "aho",
                "aho", "aho", "aho", "aho", "aho", "aho", "aho", "aho", "aho", "40")

        val n = Nabeatsu()
        for (tc in tcs) {
            assertEquals(tc, n.next())
        }
    }
```

* ところで、先述のコードだと10000番目のテスト、とかがやりにくい
  * 10000回目のテストをするためには10000回 `next` を呼ばなければならない…？
    * セカンダリコンストラクタを使う
    * コンストラクタにデフォルト値を持たせる、等でもいいかも

```kotlin
class Nabeatsu() {
    var count = 0

    // セカンダリコンストラクタを追加し、
    // カウンタの始まり位置を指定できるようにした
    constructor(c: Int) : this() {
        count = c
    }

    fun next(): String {
        count++
        val ret = when {
            count % 3 == 0 -> "aho"
            "$count".contains("3") -> "aho"
            else -> "$count"
        }
        return ret
    }
}
```

```kotlin
    @Test
    fun testNabeatsu10000() {
        // セカンダリコンストラクタを使って初期カウンタ値を設定
        val n = Nabeatsu(9998)
        assertEquals("aho", n.next())
        assertEquals("10000", n.next())
    }
}
```

## exercise (3) - ヌルとの戦い

* Null安全を駆使すると、Java のコードより簡単に安全なコードが書けるアピール

```kotlin
fun sendMessageToClient(client: Client?, message: String?, mailer: Mailer) {
    // ? による安全呼び出しの連結
    val email = client?.personalInfo?.email

    // if 文によるスマートキャスト
    if (email != null && message != null) {
        mailer.sendMessage(email, message)
    }
}

class Client(val personalInfo: PersonalInfo?)
class PersonalInfo(val email: String?)
interface Mailer {
    fun sendMessage(email: String, message: String)
}
```
