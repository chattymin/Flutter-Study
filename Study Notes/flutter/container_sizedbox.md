# Container & SizedBox

둘 다 **크기를 지정하거나 공간을 차지**하는 위젯이지만, 용도와 기능이 다르다.

---

## Container

**만능 박스 위젯** — 크기, 색상, 마진, 패딩, 테두리 등 다양한 스타일링이 가능하다.

```dart
Container(
  width: 200,
  height: 100,
  margin: EdgeInsets.all(16),
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(2, 4),
      ),
    ],
  ),
  child: Text('Hello!', style: TextStyle(color: Colors.white)),
)
```

### Container 주요 속성

| 속성 | 설명 |
|------|------|
| `width` / `height` | 크기 지정 |
| `color` | 배경색 (decoration과 동시 사용 불가) |
| `margin` | 외부 여백 |
| `padding` | 내부 여백 |
| `decoration` | 색상, 테두리, 그림자, 둥근 모서리 등 |
| `alignment` | 자식 위젯의 정렬 |

---

## SizedBox

**단순히 크기만 지정**하거나 **빈 공간(여백)을 만들 때** 사용한다.

```dart
// 크기 지정
SizedBox(
  width: 200,
  height: 100,
  child: Text('Hello!'),
)

// 위젯 사이 여백으로 활용
Column(
  children: [
    Text('위'),
    SizedBox(height: 20),   // 세로 20px 간격
    Text('아래'),
  ],
)

// 가로 여백
Row(
  children: [
    Icon(Icons.star),
    SizedBox(width: 8),     // 가로 8px 간격
    Text('별'),
  ],
)
```

---

## Container vs SizedBox 비교

| 구분 | Container | SizedBox |
|------|-----------|----------|
| 크기 지정 | ✅ | ✅ |
| 배경색 | ✅ | ❌ |
| 마진/패딩 | ✅ | ❌ |
| 테두리/그림자 | ✅ (`decoration`) | ❌ |
| 빈 공간(여백) | 가능하지만 무거움 | ✅ **최적** |
| 성능 | 상대적으로 무거움 | 가벼움 |

---

## 언제 뭘 쓸까?

- **여백만 필요** → `SizedBox` ✅
- **배경색, 테두리, 그림자 등 스타일링 필요** → `Container` ✅
- **아무 스타일 없이 크기만 지정** → `SizedBox`가 더 적합

> ⚡ `SizedBox`는 `const`로 선언 가능 → 성능상 유리

---

> 💡 **관련 링크**: [Column & Row 보기](./column_row.md) | [AxisAlignment 보기](./axis_alignment.md)
