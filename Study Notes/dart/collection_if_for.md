# Collection 내부 if, for 구문

Dart에서는 **컬렉션(List, Set, Map) 내부에서 직접 if와 for를 사용**할 수 있다.  
다른 언어에서는 별도로 처리해야 하는 것을 Dart에서는 매우 간결하게 표현한다.

---

## 다른 언어와의 비교

```dart
// JavaScript: 배열 뒤 → 조건을 따로 처리해야 함
// JS: [...items, isAdmin && adminItem].filter(Boolean)
// Kotlin: buildList { add(x); if (isAdmin) add(adminItem) }
```

---

## Dart — 컬렉션 내부 if & for

```dart
final items = [
  Text('A'),
  Text('B'),
  Text('C'),
  if (isAdmin) Text('관리자'),     // isAdmin이 true일 때만 포함
  for (var tab in extraTabs) Text(tab),  // 반복 가능
];
```

- 별도의 메서드 호출 없이 **선언적으로 조건부/반복 요소 추가**
- Flutter 위젯 트리 작성 시 특히 유용

---

## 핵심 포인트

| 문법 | 설명 |
|------|------|
| `if (조건) 요소` | 조건이 참일 때만 컬렉션에 포함 |
| `for (var x in list) 요소` | 리스트를 순회하며 요소 추가 |

- `if-else`도 사용 가능: `if (조건) A else B`
- **중첩**도 가능 (if 안에 for, for 안에 if 등)

---

> 💡 **관련 링크**: [Spread 연산자 보기](./spread_operator.md) | [Cascade 연산자 보기](./cascade_operator.md)
