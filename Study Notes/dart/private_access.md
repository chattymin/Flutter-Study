# private 접근 제어자 (_)

Dart에서는 **언더스코어(`_`)로 시작하는 이름이 private**를 의미한다.  
Java나 Kotlin의 `private` 키워드 대신, 네이밍 컨벤션으로 접근을 제어한다.

---

## 기본 사용법

```dart
class User {
  String name;           // public — 어디서든 접근 가능
  String _secret;        // private — 같은 파일 내에서만 접근 가능

  User(this.name, this._secret);
}
```

---

## 핵심 포인트

| 구분 | 접두사 | 접근 범위 |
|------|--------|-----------|
| public | 없음 (`name`) | 어디서든 접근 가능 |
| private | `_` (`_secret`) | **같은 파일(라이브러리) 내**에서만 접근 |

---

## 주의사항

- Dart의 private은 **클래스 단위가 아니라 파일(라이브러리) 단위**
- 같은 파일 안에 있으면 다른 클래스에서도 `_` 멤버에 접근 가능
- 다른 파일에서는 `_`로 시작하는 멤버에 접근 불가

---

> 💡 **관련 링크**: [클래스 보기](./class.md) | [변수와 타입 보기](./variables.md)
