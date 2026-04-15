# Column & Row

Flutter에서 **위젯을 세로 또는 가로로 배치**할 때 사용하는 핵심 레이아웃 위젯이다.

---

## Column — 세로 배치

자식 위젯들을 **위에서 아래로** 배치한다.

```dart
Column(
  children: [
    Text('첫 번째'),
    Text('두 번째'),
    Text('세 번째'),
  ],
)
```

```
┌──────────┐
│ 첫 번째   │
│ 두 번째   │
│ 세 번째   │
└──────────┘
```

---

## Row — 가로 배치

자식 위젯들을 **왼쪽에서 오른쪽으로** 배치한다.

```dart
Row(
  children: [
    Icon(Icons.star),
    Text('별점'),
    Text('5.0'),
  ],
)
```

```
┌─────────────────────┐
│ ⭐  별점  5.0        │
└─────────────────────┘
```

---

## 주요 속성

| 속성 | 설명 |
|------|------|
| `children` | 자식 위젯 리스트 |
| `mainAxisAlignment` | 주축 정렬 (Column: 세로, Row: 가로) |
| `crossAxisAlignment` | 교차축 정렬 (Column: 가로, Row: 세로) |
| `mainAxisSize` | 주축 크기 (`max` / `min`) |

---

## MainAxis vs CrossAxis

```
Column의 경우:
    mainAxis ↕ (세로)
    crossAxis ↔ (가로)

Row의 경우:
    mainAxis ↔ (가로)
    crossAxis ↕ (세로)
```

| 위젯 | Main Axis (주축) | Cross Axis (교차축) |
|------|-------------------|---------------------|
| Column | ↕ 세로 | ↔ 가로 |
| Row | ↔ 가로 | ↕ 세로 |

---

## 중첩 사용

Column과 Row를 조합하면 복잡한 레이아웃을 구성할 수 있다.

```dart
Column(
  children: [
    Row(
      children: [
        Icon(Icons.person),
        SizedBox(width: 8),
        Text('박동민'),
      ],
    ),
    SizedBox(height: 16),
    Row(
      children: [
        Icon(Icons.email),
        SizedBox(width: 8),
        Text('email@example.com'),
      ],
    ),
  ],
)
```

---

## 주의사항

- Column 안에 `ListView`를 넣으면 에러 → `Expanded`로 감싸야 함
- Row 안에서 `Text`가 넘치면 에러 → `Expanded` 또는 `Flexible` 사용

```dart
Row(
  children: [
    Expanded(child: Text('아주 길~~~~~긴 텍스트도 안전하게')),
    Icon(Icons.check),
  ],
)
```

---

> 💡 **관련 링크**: [AxisAlignment 보기](./axis_alignment.md) | [Container & SizedBox 보기](./container_sizedbox.md)
