# 변수와 타입 (Variables & Types)

Dart에서 변수를 선언하는 방법은 여러 가지가 있다.  
특히 **변경 불가 변수**를 선언할 때 `final`과 `const`를 사용하는데, 둘의 차이를 이해하는 것이 중요하다.

---

## final

```dart
final String country = '대한민국';
```

- **런타임 상수** : 프로그램이 실행되는 도중 한 번 할당된 후 변경 불가
- 선언 시 반드시 초기화하지 않아도 되며, 나중에 한 번만 할당 가능
- 실행 시점에 값이 결정되어도 괜찮음

---

## const

```dart
const double gravity = 9.8;
const String appName = 'MyApp';
```

- **컴파일 타임 상수** : 컴파일 시점에 값이 완전히 고정됨
- 반드시 컴파일 시점에 알 수 있는 값이어야 함 (ex. 계산식, 리터럴 등)
- `final`보다 더 강한 불변성을 보장

---

## final vs const 비교

| 구분 | `final` | `const` |
|------|---------|---------|
| 상수 확정 시점 | 런타임 (실행 중) | 컴파일 타임 (빌드 시) |
| 변경 가능 여부 | 한 번 할당 후 불가 | 절대 불가 |
| 사용 예시 | API 응답값, DateTime.now() | 고정 문자열, 고정 숫자 |

---

## `var` vs 타입 명시

```dart
var name = 'Flutter';     // 타입 추론 → String으로 확정
String name = 'Flutter';  // 타입 명시
```

- `var`는 초기값으로 타입을 추론하며, 이후 같은 타입의 값만 재할당 가능
- 타입을 명시하면 코드 가독성이 높아짐


## 그러면 언제 타입을 명시해야하나?
```dart
// ✅ 타입이 명확히 추론되면 var 써도 무방
var user = User(name: 'Patrick');
var list = <String>[];

// ✅ 타입이 복잡하거나 명시성이 중요하면 explicit
Map<String, List<int>> groupedData = {};

// dynamic 됨!!!
var x; 
```

### dynamic이 뭐에요?
```dart
var x;        // dynamic으로 추론
x = 42;       // ✅
x = 'hello';  // ✅ dynamic이라 타입 바꿔도 됨
x = [1,2,3];  // ✅ 이것도 됨

x = 'hello';
print(x + 1); // ✅ 컴파일은 통과 — dynamic이라 컴파일러가 검사 안 함 -> 💥 런타임 에러 — String + int 불가
```



> 💡 **관련 링크**: [타입 종류 보기](./types.md)
