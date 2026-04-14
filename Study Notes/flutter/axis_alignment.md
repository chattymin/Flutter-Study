# AxisAlignment

Column과 Row에서 자식 위젯들을 **어떻게 정렬할지** 결정하는 속성이다.

---

## MainAxisAlignment

주축(Column: 세로, Row: 가로)을 따라 자식 위젯들을 정렬한다.

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [ ... ],
)
```

### 종류 및 시각화 (Column 기준)

```
start              center             end
┌──────────┐      ┌──────────┐      ┌──────────┐
│ [A]      │      │          │      │          │
│ [B]      │      │   [A]    │      │          │
│ [C]      │      │   [B]    │      │   [A]    │
│          │      │   [C]    │      │   [B]    │
│          │      │          │      │   [C]    │
└──────────┘      └──────────┘      └──────────┘

spaceBetween       spaceAround        spaceEvenly
┌──────────┐      ┌──────────┐      ┌──────────┐
│ [A]      │      │          │      │          │
│          │      │ [A]      │      │   [A]    │
│ [B]      │      │          │      │          │
│          │      │ [B]      │      │   [B]    │
│ [C]      │      │          │      │          │
└──────────┘      │ [C]      │      │   [C]    │
                  │          │      │          │
                  └──────────┘      └──────────┘
```

| 값 | 설명 |
|------|------|
| `start` | 시작점에 몰아서 배치 (기본값) |
| `center` | 중앙에 배치 |
| `end` | 끝점에 몰아서 배치 |
| `spaceBetween` | 첫/끝은 가장자리에, 나머지 균등 분배 |
| `spaceAround` | 각 위젯 주변에 균등한 여백 (양 끝은 절반) |
| `spaceEvenly` | 모든 간격이 완전 균등 |

---

## CrossAxisAlignment

교차축(Column: 가로, Row: 세로)을 따라 자식 위젯들을 정렬한다.

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [ ... ],
)
```

### 종류 및 시각화 (Column 기준)

```
start              center             end                stretch
┌──────────┐      ┌──────────┐      ┌──────────┐      ┌──────────┐
│[A]       │      │   [A]    │      │       [A]│      │[AAAAAAAA]│
│[BB]      │      │  [BB]    │      │      [BB]│      │[BBBBBBBB]│
│[CCC]     │      │  [CCC]   │      │     [CCC]│      │[CCCCCCCC]│
└──────────┘      └──────────┘      └──────────┘      └──────────┘
```

| 값 | 설명 |
|------|------|
| `start` | 시작점에 정렬 |
| `center` | 중앙에 정렬 (기본값) |
| `end` | 끝점에 정렬 |
| `stretch` | 교차축 방향으로 꽉 채움 |
| `baseline` | 텍스트 기준선에 맞춤 (Row에서 주로 사용) |

---

## 실전 예시

```dart
// 카드형 레이아웃
Column(
  crossAxisAlignment: CrossAxisAlignment.start,  // 왼쪽 정렬
  children: [
    Text('제목', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Text('부제목', style: TextStyle(color: Colors.grey)),
  ],
)

// 하단 버튼 배치
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 양 끝 배치
  children: [
    TextButton(child: Text('취소'), onPressed: () {}),
    ElevatedButton(child: Text('확인'), onPressed: () {}),
  ],
)
```

---

## 요약 정리

| 속성 | Column에서의 방향 | Row에서의 방향 |
|------|-------------------|---------------|
| `mainAxisAlignment` | ↕ 세로 정렬 | ↔ 가로 정렬 |
| `crossAxisAlignment` | ↔ 가로 정렬 | ↕ 세로 정렬 |

---

> 💡 **관련 링크**: [Column & Row 보기](./column_row.md) | [Container & SizedBox 보기](./container_sizedbox.md)
