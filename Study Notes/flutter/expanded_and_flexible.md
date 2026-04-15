# Flutter의 `Expanded`와 `Flexible`

## 왜 필요한가

Flutter 레이아웃 시스템의 핵심 원칙은 이것이다.

```
부모가 자식에게 constraints(최소/최대 크기)를 내려줌
자식이 그 안에서 자신의 크기를 결정해서 올려줌
부모가 자식을 배치함
```

`Row` 안의 `Text`는 기본적으로 "나 얼마나 커도 돼?"를 모르는 상태다.
제약 없이 무한정 커지려다 오버플로우 에러가 발생한다.
`Expanded` / `Flexible`이 constraint를 내려줘서 "여기까지만 커도 돼"를 알려주는 역할이다.

---

## Expanded — 남은 공간 무조건 전부 차지

```dart
Row(children: [
  Expanded(
    child: Text('아주 긴 텍스트가 들어와도 넘치지 않고 이 안에서 처리됨'),
  ),
  Icon(Icons.star),
])
```

- `Icon`이 차지하고 남은 공간을 **강제로 전부 채운다**
- 텍스트가 짧아도 공간을 늘려서 채운다
- Android `LinearLayout`의 `weight` / Compose `Modifier.weight()`와 동일한 개념

---

## Flexible — 필요한 만큼만, 최대 남은 공간까지

```dart
Row(children: [
  Flexible(
    child: Text('짧은 텍스트'),
  ),
  Icon(Icons.star),
])
```

- 텍스트가 짧으면 **텍스트 크기만큼만** 차지한다
- 넘칠 것 같으면 그때 줄어든다
- 콘텐츠 크기를 유지하되, 넘침만 방지하는 용도

---

## 나란히 비교

```dart
// Expanded 2개 → 공간을 정확히 반반
Row(children: [
  Expanded(child: Text('왼쪽')),   // 50%
  Expanded(child: Text('오른쪽')), // 50%
])

// Flexible 2개 → 텍스트 길이에 따라 자유롭게
Row(children: [
  Flexible(child: Text('짧음')),           // 텍스트 너비만큼
  Flexible(child: Text('아주아주 긴 텍스트')), // 텍스트 너비만큼, 넘치면 줄어듦
])
```

| | `Expanded` | `Flexible` |
|---|---|---|
| 공간 점유 | 남은 공간 **강제로 전부** | 콘텐츠 크기만큼, **최대** 남은 공간 |
| 콘텐츠가 작을 때 | 공간을 늘려서 채움 | 콘텐츠 크기 그대로 |
| 콘텐츠가 클 때 | 남은 공간 안에서 잘림/줄바꿈 | 남은 공간 안에서 잘림/줄바꿈 |
| 주 용도 | 균등 분할, 공간 채우기 | 넘침 방지 + 자연스러운 크기 유지 |

**한 줄 기억법**
- `Expanded` = "이 공간을 꽉 채워라"
- `Flexible` = "넘치지만 말아라"

---

## flex 파라미터 — 비율 조정

```dart
Row(children: [
  Expanded(flex: 2, child: Text('2/3 차지')), // 전체의 2/3
  Expanded(flex: 1, child: Text('1/3 차지')), // 전체의 1/3
])
```

Android `LinearLayout weight` / Compose `Modifier.weight()`와 완전히 동일한 개념이다.

---

## overflow — 텍스트 처리 방식

`Expanded`/`Flexible`은 **위젯이 차지할 너비를 제한**하고,
텍스트를 어떻게 그리냐는 `Text`의 `overflow` 프로퍼티가 담당한다.
둘은 역할이 다르고 항상 같이 쓴다.

```dart
// Android ellipsize="end"와 동일
Text(
  '아주 긴 텍스트입니다 넘치면 어떻게 될까요',
  overflow: TextOverflow.ellipsis, // → "아주 긴 텍스트..."
  maxLines: 1,
)

// 끝부분이 흐려짐
Text('아주 긴 텍스트', overflow: TextOverflow.fade)

// 그냥 잘라버림
Text('아주 긴 텍스트', overflow: TextOverflow.clip)

// 넘쳐도 그냥 다 보여줌 (기본값)
Text('아주 긴 텍스트', overflow: TextOverflow.visible)
```

### 실무 조합 패턴

```dart
// Flexible로 너비 제한 + overflow로 텍스트 처리
Row(children: [
  Flexible(
    child: Text(
      '아주 긴 제목 텍스트가 들어올 수 있음',
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  ),
  const SizedBox(width: 8),
  const Icon(Icons.arrow_forward),
])
```

> `Flexible`/`Expanded` 없이 `overflow`만 설정하면 Flutter가 너비 계산을 못 해서 에러가 난다.
> **`Flexible`/`Expanded`이 먼저 너비를 확정해줘야 `overflow`가 동작한다.**

---

## Compose와 비교

```kotlin
// Compose — Modifier 체인으로 한 번에
Text(
    text = "긴 텍스트",
    modifier = Modifier.weight(1f),
    overflow = TextOverflow.Ellipsis,
    maxLines = 1
)
```

```dart
// Flutter — 위젯 중첩으로 역할 분리
Flexible(                                    // 크기 제약
  child: Text(
    '긴 텍스트',
    overflow: TextOverflow.ellipsis,          // 텍스트 처리
    maxLines: 1,
  ),
)
```

Compose는 Modifier로 추상화해서 편리하고,
Flutter는 명시적 중첩으로 역할이 분리된다는 철학 차이다.
Flutter 방식은 코드가 길지만 각 위젯의 역할이 명확히 보인다는 장점이 있다.

---

## 언제 붙여야 하나

```dart
// ✅ 거의 항상 붙여야 하는 경우 — Row 안 동적 텍스트
Row(children: [
  Expanded(
    child: Text(userName), // 서버에서 오는 값 → 무조건
  ),
  Icon(Icons.star),
])

// ✅ 안 붙여도 되는 경우 — Column 안 Text
// Column은 수직 방향이라 텍스트가 자연스럽게 줄바꿈됨
Column(children: [
  Text(description), // 넘쳐도 아래로 줄바꿈 → 에러 없음
])

// ✅ 고정 문자열이고 절대 안 넘치는 경우
Row(children: [
  Text('확인'), // 버튼 라벨, 고정값 → 굳이 불필요
  Text('취소'),
])
```

**Row 안에서 동적 텍스트라면 어지간하면 붙이는 게 맞다.**
폰트 크기 변경, 서버 데이터 확장, 다국어 대응 등으로 예상보다 길어지는 경우가 많다.

---

## 성능 차이

**무시해도 될 수준이다.**

```
Expanded/Flexible 추가 시 비용:
- Element 하나 추가      → 미미
- RenderObject 하나 추가 → 미미
- layout 패스 한 번 더   → 미미
```

이걸 아끼려고 빼는 건 의미 없다. 방어적으로 붙이는 게 맞다.

---

## 오버플로우 에러의 실체

Android처럼 앱이 크래시 나지는 않는다. 모드에 따라 다르게 동작한다.

**Debug 모드 — 빨간 화면 + 줄무늬**

```
════════ Exception caught by rendering library ══════
The following assertion was thrown during layout:
A RenderFlex overflowed by 42 pixels on the right.
════════════════════════════════════════════════════
```

화면에 노란/검은 줄무늬가 생기고 오버플로우된 픽셀 수가 표시된다.
앱은 죽지 않고 계속 실행된다.

**Release 모드 — 조용히 깨진 UI**

Release 빌드에서는 assertion이 꺼져서 넘친 부분이 그냥 clip되거나 보이지 않는 채로 배포된다.
사용자는 UI가 이상하다고 느끼지만 크래시는 없다.
Debug에서 바로 눈에 보이는 것과 달리, Release에서는 조용히 깨진 UI로 배포될 수 있어 더 위험하다.

---

## 자주 만나는 constraint 충돌

```dart
// ❌ Column 안에 ListView → 에러
// "Vertical viewport was given unbounded height"
Column(
  children: [
    Text('제목'),
    ListView(...), // Column도 무한, ListView도 무한 → 충돌
  ],
)

// ✅ Expanded로 ListView에 constraint 줘야 함
Column(
  children: [
    Text('제목'),
    Expanded(
      child: ListView(...),
    ),
  ],
)
```

Flutter 입문자가 가장 많이 막히는 패턴이다.
Compose는 `LazyColumn`을 그냥 쓰면 되지만 Flutter는 constraint를 의식해야 한다.

---

## 요약

```
Expanded   → 남은 공간 강제로 전부 차지 (= Compose weight)
Flexible   → 필요한 만큼만, 최대 남은 공간까지
overflow   → 텍스트를 어떻게 그리냐 (= Android ellipsize)
flex       → 비율 조정 (= LinearLayout weight)

Row 안 동적 텍스트  → Expanded/Flexible 방어적으로 붙이기
성능 차이           → 없음
Debug 오류          → 크래시 아님, 줄무늬 UI
Release 오류        → 조용히 깨진 UI → 더 위험
```