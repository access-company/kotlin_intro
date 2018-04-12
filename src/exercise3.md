# Exercise (3)

## ヌルとの戦い

以下の Java コードを、Kotlin に置き換えてみよう！  
(ただし、`if` は一回だけ使って良いとする)

* 下記 Java コードのポイント
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

* Kotlin の場合はどうなる？

```kotlin
fun sendMessageToClient(client: Client?, message: String?, mailer: Mailer) {
    // TODO: 実装する
}
```
