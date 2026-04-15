# Widget

Flutter에서 **모든 UI 요소는 Widget**이다.  
텍스트, 버튼, 레이아웃, 패딩, 심지어 앱 자체도 위젯이다.

---

## Widget이란?

- Flutter UI를 구성하는 **기본 단위**
- 화면에 보이는 모든 것은 위젯으로 구성됨
- 위젯은 **불변(immutable)** → 상태가 변하면 새로운 위젯을 생성

```dart
// 가장 간단한 위젯 사용 예시
Text('Hello, Flutter!')
```

---

## 위젯의 종류

| 분류 | 설명 | 예시 |
|------|------|------|
| 구조 위젯 | 레이아웃을 결정 | `Column`, `Row`, `Stack` |
| 표시 위젯 | 콘텐츠를 보여줌 | `Text`, `Image`, `Icon` |
| 입력 위젯 | 사용자 입력을 받음 | `TextField`, `Button`, `Checkbox` |
| 스타일 위젯 | 외관을 꾸밈 | `Container`, `Padding`, `DecoratedBox` |

---

## "Everything is a Widget"

Flutter의 핵심 철학은 **모든 것이 위젯**이라는 것이다.

```dart
MaterialApp(           // 앱 자체도 위젯
  home: Scaffold(      // 화면 기본 구조도 위젯
    appBar: AppBar(    // 상단바도 위젯
      title: Text('제목'),  // 텍스트도 위젯
    ),
    body: Center(      // 정렬도 위젯
      child: Text('Hello!'),
    ),
  ),
)
```

---

> 💡 **관련 링크**: [Widget Tree 보기](./widget_tree.md) | [Stateless & Stateful Widget 보기](./stateless_stateful.md)
