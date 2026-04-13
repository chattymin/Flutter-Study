# 클래스 (Class)

Dart는 **객체지향 언어**로, 클래스를 통해 데이터와 동작을 묶어 관리한다.

---

## 기본 클래스

```dart
class User {
  final String name;
  final int age;

  // 생성자 — Named Parameter + this
  User({required String name, required this.age});

  // getter — 계산된 속성
  String get info => '$name ($age)';
}

final user = User(name: 'Minasel', age: 24);
print(user.info); // Minasel (24)
```

### 주요 개념

| 개념 | 설명 |
|------|------|
| `final` 필드 | 한 번 할당 후 변경 불가 |
| `required` | Named Parameter를 필수로 지정 |
| `this.필드` | 생성자 파라미터를 필드에 자동 할당 |
| `get` | 계산된 값을 속성처럼 접근 |

---

## Named Constructor (이름 있는 생성자)

기본 생성자 외에 **이름을 붙인 추가 생성자**를 만들 수 있다.  
특정 상황에 맞는 객체 생성 방식을 명확하게 표현할 수 있다.

```dart
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});

  // Named Constructor — 게스트 유저 생성
  User.guest() : name = '게스트', age = 0;

  // Named Constructor — JSON에서 생성
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];
}
```

### 사용 예시

```dart
final user1 = User(name: 'Min', age: 25);              // 기본 생성자
final user2 = User.guest();                             // 게스트 ①
final user3 = User.fromJson({'name': 'Min', 'age': 24}); // JSON에서 생성
```

### Named Constructor가 유용한 경우

| 상황 | Named Constructor |
|------|-------------------|
| 기본값이 정해진 객체 | `User.guest()` |
| JSON/Map 파싱 | `User.fromJson(json)` |
| 복사 생성 | `User.copy(other)` |

---

> 💡 **관련 링크**: [함수 보기](./functions.md) | [Null Safety 보기](./null_safety.md)
