# Flutter의 3개 트리 구조

## 개요

Flutter는 화면을 그리기 위해 3개의 트리를 동시에 유지한다.

```
Widget Tree       Element Tree      Render Tree
(설계도)          (인스턴스/연결)    (실제 레이아웃/페인팅)

Text('hello')  →  StatelessElement → RenderParagraph
Column()       →  StatelessElement → RenderFlex
Container()    →  StatelessElement → RenderDecoratedBox
```

---

## 각 트리의 역할

### Widget Tree — 불변 설계도

- 상태 변경 시 새 인스턴스를 만들어도 부담이 없을 만큼 **가볍다**
- Dart 객체에 불과하며, `build()`가 호출될 때마다 새로 생성된다
- `const` 위젯은 동일 인스턴스를 재사용하므로 재생성 자체가 없다

```dart
// Widget은 그냥 데이터 클래스에 가깝다
class Text extends Widget {
  final String data; // 불변
  const Text(this.data);
}
```

### Element Tree — 살아있는 인스턴스, 핵심 판단 레이어

- Widget과 RenderObject를 **연결**하는 중간 관리자
- 이전 Widget과 새 Widget을 **비교(reconciliation)**한다
- "같은 타입이면 재사용, 다른 타입이면 교체" 여부를 결정한다
- Widget 생명주기를 관리한다

### Render Tree — 실제로 화면에 그리는 객체 (가장 비쌈)

- `layout()` → `paint()` → `composite()` 순서로 실행
- 실제 픽셀 계산을 수행하므로 **생성/수정 비용이 크다**
- Element가 재사용되면 프로퍼티만 업데이트되고, RenderObject는 유지된다

---

## setState() 호출 시 실제로 일어나는 일

```
1. setState() 호출
        ↓
2. Widget Tree 재생성 (build() 재호출) — 가볍고 부담 없음
        ↓
3. Element Tree가 새 Widget과 기존 Widget을 비교
   ┌─────────────────────────────────────────┐
   │  같은 타입 + 같은 Key?                     │
   │  → Element 재사용, Widget만 교체           │
   │  → RenderObject에 변경된 프로퍼티만 전달      │
   │                                         │
   │  타입 또는 Key 다름?                       │
   │  → Element 폐기, 새로 생성                 │
   │  → RenderObject도 새로 생성 (비쌈)          │
   └─────────────────────────────────────────┘
        ↓
4. Render Tree는 dirty 마킹된 노드만 layout/paint
```

---

## 시나리오별 동작

### ① 초기 빌드

- Widget, Element, RenderObject 전부 새로 생성
- 가장 비용이 큰 경우

### ② 텍스트 값만 변경 (가장 흔한 케이스)

```dart
// 변경 전
Text('hello')
// 변경 후
Text('world')
```

```
Widget:       새 Text('world') 인스턴스 생성
Element:      타입 동일(Text) → 재사용, updateRenderObject() 호출
RenderObject: text 프로퍼티만 업데이트 → dirty 마킹
나머지:       Column, Icon 등 → 아무것도 안 함 (skip)
```

### ③ 위젯 타입 변경 (비쌈)

```dart
// 변경 전
Text('hello')
// 변경 후
Icon(Icons.star)
```

```
Widget:       새 Icon() 인스턴스 생성
Element:      타입 불일치 → 기존 Element 폐기, 새 Element 생성
RenderObject: createRenderObject() 호출 → 새로 생성 (비쌈!)
```

### ④ const 위젯 (가장 효율적)

```dart
const Text('hello') // 동일 인스턴스 재사용
```

```
Widget:       동일 인스턴스 → 재생성 없음
Element:      identical() 체크에서 즉시 통과 → 비교 스킵
RenderObject: 아무것도 안 함 → layout/paint 비용 0
```

---

## updateRenderObject()가 핵심

Element가 재사용될 때 Flutter 내부적으로 이 메서드가 호출된다.
**RenderObject를 새로 만들지 않고, 프로퍼티만 갱신**하는 것이 핵심이다.

```dart
// Flutter SDK 내부 (개념)
class RenderObjectElement extends Element {
  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    widget = newWidget;
    // RenderObject 인스턴스는 그대로, 프로퍼티만 업데이트
    widget.updateRenderObject(this, renderObject);
  }
}

// Text 위젯의 경우
void updateRenderObject(BuildContext context, RenderParagraph renderObject) {
  renderObject
    ..text = textSpan        // 바뀐 값만 세팅
    ..textAlign = textAlign
    ..textDirection = textDirection;
  // RenderObject 인스턴스는 그대로!
}
```

---

## 시나리오별 요약 표

| 상황 | Widget | Element | RenderObject |
|---|---|---|---|
| 초기 빌드 | 새로 생성 | 새로 생성 | 새로 생성 |
| 타입 동일, 값 변경 | 새로 생성 | **재사용** | 프로퍼티만 업데이트 |
| 타입 동일, 값 동일 | 새로 생성 | **재사용** | 아무것도 안 함 |
| 타입 변경 | 새로 생성 | 교체 | **새로 생성** |
| `const` 동일 인스턴스 | 재생성 없음 | 비교 스킵 | 아무것도 안 함 |

---

## Compose와 비교

| | Compose | Flutter |
|---|---|---|
| 재실행 단위 | `@Composable` 함수 | `Widget` (build 메서드) |
| 의존성 추적 | 컴파일러가 자동 추적 | 개발자가 rebuild 경계 설계 |
| skip 조건 | `@Stable`/`@Immutable` + 파라미터 동일 | `const` 또는 Element 재사용 |
| 핵심 비용 | 불필요한 recomposition | RenderObject 생성/수정 |

---

## 실무에서 기억할 것

```dart
// ✅ Widget 생성은 아낌없이 해도 된다 — Dart GC가 잘 처리
// ✅ Flutter 팀도 "small widgets으로 쪼개라"를 권장하는 이유가 이것

// ✅ const 위젯 — 가능한 모든 곳에 붙인다
child: const MyWidget()

// ✅ Key — 리스트에서 Element 재사용을 보장
ListView.builder(
  itemBuilder: (ctx, i) => ItemWidget(key: ValueKey(items[i].id), item: items[i]),
)

// ✅ setState 범위 최소화 — 상태를 작은 위젯으로 분리
// ✅ RepaintBoundary — 자주 바뀌는 위젯을 별도 레이어로 분리
```

모든 최적화 패턴(`const`, `Key`, 위젯 분리, `RepaintBoundary`)은 결국
**"RenderObject 건드리는 횟수를 줄여라"** 는 하나의 목표로 귀결된다.