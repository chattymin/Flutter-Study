# Dart의 `late` 키워드

## 개념

"지금 당장 초기화 못하지만, 사용 전에 반드시 초기화할게"라는 약속.
Kotlin의 `lateinit`과 동일한 개념이나 차이점이 있다.

초기화 전에 접근하면 런타임 에러가 발생한다.

---

## Kotlin `lateinit`과 비교

| | Kotlin `lateinit` | Dart `late` |
|---|---|---|
| `val` / `final`에 사용 | ❌ | ✅ (`late final`) |
| primitive 타입 | ❌ | ✅ |
| 초기화 전 접근 | 런타임 에러 | 런타임 에러 |
| 초기화 확인 | `::name.isInitialized` | 없음 |

Kotlin이 primitive에 `lateinit`을 못 쓰는 이유는 `null`로 초기화 여부를 체크하는 내부 구현 때문이다.
Dart `late`는 그런 제약이 없다.

---

## 기본 사용

```dart
// 선언만, 초기화는 나중에
late String name;
late int count;

// 초기화 전 접근 → 런타임 에러
print(name); // LateInitializationError: Field 'name' has not been initialized.

// 초기화 후 접근 → 정상
name = 'Patrick';
print(name); // ✅
```

---

## late final — Dart만 가능한 패턴

```dart
// 한 번만 할당 가능, 이후 재할당 불가
late final AnimationController _anim;

@override
void initState() {
  _anim = AnimationController(vsync: this, duration: Duration(seconds: 1));
}

// 재할당 시도 → 런타임 에러
_anim = AnimationController(...); // LateInitializationError
```

`final`이지만 선언 시점에 값이 없을 때 유용하다.
Flutter에서 `initState()`에서 초기화하는 컨트롤러에 자주 쓰인다.

---

## 주요 사용 패턴

### Flutter 컨트롤러 초기화

```dart
class _MyState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final TextEditingController _text;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _text = TextEditingController();
  }

  @override
  void dispose() {
    _anim.dispose();
    _text.dispose();
    super.dispose();
  }
}
```

### 테스트 setUp

```dart
late MyViewModel viewModel;

setUp(() {
  viewModel = MyViewModel(repository: MockRepository());
});

test('increment increases count', () {
  viewModel.increment();
  expect(viewModel.count, 1);
});
```

### 지연 초기화 (lazy initialization)

`late`의 숨겨진 기능 — 초기화 식이 있는 경우 **처음 접근할 때 딱 한 번만 실행**된다.

```dart
// heavyComputation()은 _value에 처음 접근할 때 딱 한 번만 실행됨
late final String _value = heavyComputation();

// 접근 전까지는 실행 안 됨
print(_value); // 이 시점에 처음 실행
print(_value); // 두 번째 접근은 캐시된 값 반환
```

### Kotlin `by lazy`와 비교

동일한 기능이지만 Dart `late`가 더 제한적이다.

```kotlin
// Kotlin — by lazy
val value: String by lazy { heavyComputation() }

// Dart — late final + 초기화식
late final String value = heavyComputation();
```

둘 다 처음 접근 시 1회 실행, 이후 캐시된 값 반환으로 동일하게 동작한다.

**Dart `late`가 부족한 부분 — 스레드 안전 옵션**

```kotlin
// Kotlin은 스레드 안전 모드 선택 가능
val value by lazy { heavyComputation() }                              // 기본값: synchronized
val value by lazy(LazyThreadSafetyMode.NONE) { heavyComputation() }  // 단일스레드용
```

Dart `late`는 이 옵션이 없다. 다만 Dart는 기본적으로 단일 스레드(이벤트 루프) 기반이라
멀티스레드 동시접근 문제 자체가 없어서 실용적으로는 문제없다.
`Isolate`를 써도 메모리를 공유하지 않아 동일하게 안전하다.

**`late final` 없이 쓰면 `by lazy`와 다르다**

```dart
// ❌ final 없이 쓰면 재할당이 가능해져서 lazy 캐시가 깨짐
late String value = heavyComputation();
value = 'world'; // ✅ 재할당 가능 — by lazy와 다른 동작

// ✅ by lazy와 동일하게 쓰려면 반드시 late final
late final String value = heavyComputation();
value = 'world'; // ❌ 런타임 에러
```

| | Kotlin `by lazy` | Dart `late final` (초기화식 있음) |
|---|---|---|
| 처음 접근 시 1회 실행 | ✅ | ✅ |
| 이후 캐시 반환 | ✅ | ✅ |
| 재할당 불가 | ✅ | ✅ |
| 스레드 안전 옵션 | ✅ (3가지 모드) | ❌ (단일스레드라 불필요) |
| `var`에 적용 | ❌ | ✅ (단, lazy 의미 없어짐) |

**결론: `late final` + 초기화식 = `by lazy(LazyThreadSafetyMode.NONE)`**

---

## 주의사항

### isInitialized가 없다

```dart
// Kotlin은 초기화 확인 가능
if (::name.isInitialized) { ... }

// Dart는 방법이 없음 — 접근하면 그냥 에러
// → 100% 초기화가 보장되는 곳에서만 쓸 것
```

### nullable로 대체 가능한 경우엔 쓰지 말 것

```dart
// ❌ 불필요한 late
late String? name;

// ✅ 그냥 nullable로
String? name;
```

### 초기화 보장이 불확실하면 쓰지 말 것

```dart
// ❌ 조건에 따라 초기화가 안 될 수 있음
late String name;
if (condition) {
  name = 'Patrick'; // condition이 false면 초기화 안 됨
}
print(name); // 런타임 에러 위험
```

---

## 요약

- `late` = Kotlin `lateinit`과 동일 개념, 더 유연함
- `late final` = 지연 초기화 + 불변 보장, Dart만 가능
- 초기화 식 있는 `late final` = lazy initialization = Kotlin `by lazy(NONE)`과 동일
- `isInitialized` 없음 → **100% 초기화 보장되는 곳에서만 사용**
- Flutter에서 주 용도: `initState()`에서 초기화하는 컨트롤러