# Spread 연산자 (...)

Spread 연산자(`...`)를 사용하면 **리스트나 컬렉션을 다른 컬렉션 안에 펼쳐서 삽입**할 수 있다.

---

## 기본 사용법

```dart
final header = [Text('머리'), Text('머리1')];
final body = [Text('바디 1'), Text('바디 2')];

// 두 리스트를 합쳐서 하나의 리스트에 포함
final all = [
  ...header,
  Divider(),
  ...body,
];
```

- `...`으로 리스트의 요소를 풀어서 삽입
- 여러 리스트를 하나로 합칠 때 편리

---

## Null-aware Spread (`...?`)

리스트가 `null`일 수 있는 경우 `...?`를 사용한다.

```dart
List<Widget>? extraButtons;  // null일 수 있는 리스트

final actions = [
  ElevatedButton(child: Text('확인'), onPressed: () {}),
  ...?extraButtons,  // null이면 무시하고, 값이 있으면 펼쳐서 포함 (에러 없음)
];
```

---

## 연산자 비교

| 연산자 | 설명 |
|--------|------|
| `...` | 리스트/Set/Map을 펼쳐서 삽입 |
| `...?` | null이면 무시, 값이 있으면 펼쳐서 삽입 |

---

> 💡 **관련 링크**: [Collection if/for 보기](./collection_if_for.md) | [Cascade 연산자 보기](./cascade_operator.md)
