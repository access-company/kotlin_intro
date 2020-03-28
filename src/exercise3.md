# Exercise (3)

## ヌルと戦うJavaプログラマーにKotlinを教えよう！

あなたの部署には、Kotlinをまったく知らないJava開発者のN内さんがいます。

N内さんは、上司の指示でJavaのコードをKotlinに書き直して、あなたにレビューをお願いして来ました。

N内さんは「**漏れなくnullチェックできてるし！！**」と自信満々だが、そのコードはビルドすら通りません。

あなたは呆れ顔で、このコードを修正してあげる必要があります。

### 問題
正しい出力結果
```
To: antonio@abc-company.com
message: Hello, Antonio!
```
が出るよう、以下のコードを**できる限り短く読みやすく**修正してください。

* `if`を使うのは1回まで

```kotlin
class Client (val personalInfo: PersonalInfo?)

class PersonalInfo (val email: String?)

interface Mailer {
    fun sendMessage(email: String, message: String)
}

class CosmosMailer: Mailer {
    override fun sendMessage(email: String, message: String){
        println("To: $email\nmessage: $message")
    }
}

fun sendMessageToClient(client: Client?, message: String?, mailer: Mailer) {
    if (client == null || message == null) {
        return
    }

    val personalInfo: PersonalInfo = client.personalInfo
    if (personalInfo == null) {
        return
    }

    val email: String = personalInfo.email
    if (email == null) {
        return
    }

    mailer.sendMessage(email, message)
}

fun main(args: Array<String>) {
    val personalInfo: PersonalInfo = PersonalInfo(email: "antonio@abc-company.com")
    val client: Client = Client(personalInfo: personalInfo)
    val mailer: Mailer = CosmosMailer()
    sendMessageToClient(
            client: client,
            message: "Hello, Antonio!",
            mailer: mailer
    )
}
```

* 参考までに、下記が移植前の Java コードの一部
  * 引数のアノテーションによると、`client`、`message` は `null` の可能性がある
  * 引数のアノテーションによると、`mailer` は null の可能性がない
  * 途中で `null` に出くわしたらに何もせず `return` している

```java: Java
public void sendMessageToClient(
    @Nullable Client client,
    @Nullable String message,
    @NonNull Mailer mailer) {
    if (client == null || message == null) return;

    PersonalInfo personalInfo = client.getPersonalInfo();
    if (personalInfo == null) return;

    String email = personalInfo.getEmail();
    if (email == null) return;

    mailer.sendMessage(email, message);
}
```
