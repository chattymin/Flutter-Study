# Null Safety

Dart는 **Null Safety**를 기본으로 지원한다.  
변수가 `null`이 될 수 있는지 없는지를 타입 시스템으로 명확히 구분한다.

---

## nullable vs non-nullable

```dart
String name = 'Flutter';   // non-nullable — null 될 수 없음
String? nickname;           // nullable — null이 될 수 있음 (기본값 null)
```

| 구분 | 예시 | null 허용 |
|------|------|-----------|
| non-nullable | `String name` | ❌ 불가 |
| nullable | `String? name` | ✅ 가능 |

---

## null을 안전하게 다루는 방법

```dart
// ?. 안전 호출 (Safe Call)
print(nickname?.length);   // null이면 null 반환

// ?? null 병합 연산자 (Null Coalescing)
print(nickname ?? '익명'); // null이면 기본값 사용

// ??= null일 때만 할당
nickname ??= '기본닉';     // nickname이 null일 때만 할당

// ! 강제 언래핑 (null이 아님을 보장할 때만 사용)
print(nickname!.length);   // null이면 런타임 에러 발생 (주의!)
```

### 연산자 정리

| 연산자 | 이름 | 설명 |
|--------|------|------|
| `?.` | 안전 호출 | null이면 null 반환, 아니면 호출 |
| `??` | null 병합 | null이면 오른쪽 기본값 사용 |
| `??=` | null 할당 | null일 때만 값 할당 |
| `!` | 강제 언래핑 | null이 아님을 단언 (오용 시 에러) |

---

## 왜 Null Safety가 중요한가?

- null 참조로 인한 런타임 에러를 **컴파일 타임에 미리 방지**
- 코드만 봐도 해당 변수가 null이 될 수 있는지 바로 파악 가능
- Flutter 앱의 안정성을 높이는 핵심 개념

---

> 💡 **관련 링크**: [타입 종류 보기](./types.md) | [클래스 보기](./class.md)
