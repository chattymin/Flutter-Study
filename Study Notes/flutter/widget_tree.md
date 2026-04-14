# Widget Tree

Flutter의 UI는 **위젯이 트리(Tree) 구조**로 구성된다.  
부모 위젯이 자식 위젯을 포함하고, 그 자식이 또 자식을 가지는 **계층 구조**이다.

---

## Widget Tree란?

```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text('제목')
    └── Body
        └── Center
            └── Column
                ├── Text('Hello')
                └── ElevatedButton
                    └── Text('Click')
```

- 모든 위젯은 **부모-자식 관계**로 연결
- 최상위에는 `MaterialApp` 또는 `CupertinoApp`이 위치
- 트리가 깊어질수록 UI가 세밀해짐

---

## 3가지 트리

Flutter 내부에서는 실제로 3가지 트리가 동작한다.

| 트리 | 설명 |
|------|------|
| **Widget Tree** | 개발자가 작성하는 UI 설계도 (설정값) |
| **Element Tree** | Widget Tree의 인스턴스, 생명주기 관리 |
| **Render Tree** | 실제 화면에 그려지는 레이아웃/페인팅 담당 |

```
Widget Tree    →   Element Tree    →   Render Tree
(설계도)            (인스턴스)            (실제 렌더링)
```

- 개발자는 **Widget Tree만 신경** 쓰면 됨
- Flutter 프레임워크가 나머지를 자동으로 처리

### 진짜 신경안써도 돼요?
그럴리가요.   
성능을 챙기려면 각 Tree가 어떻게 동작하는지 알고, 원리에 맞게 구현해야 해요.   
> 💡 **관련 링크**: [자세히 보러 가기](./widget_tree_struct.md)


---

## 리빌드 (Rebuild)

- 상태가 변경되면 **Widget Tree가 다시 생성**됨
- 하지만 Element Tree와 Render Tree는 **변경된 부분만 업데이트** (효율적)
- 이것이 Flutter가 빠른 이유

---

## 좋은 Widget Tree를 위한 팁

1. **트리를 너무 깊게 만들지 않기** → 가독성 저하
2. **위젯을 작은 단위로 분리하기** → 재사용성 향상
3. **`const` 위젯 사용하기** → 불필요한 리빌드 방지

```dart
// ❌ 너무 깊은 중첩
Scaffold(body: Center(child: Padding(child: Container(child: Column(...)))))

// ✅ 위젯을 분리
Scaffold(body: _buildContent())

Widget _buildContent() {
  return Center(
    child: Column(...),
  );
}
```

---

> 💡 **관련 링크**: [Widget 보기](./widget.md) | [Stateless & Stateful Widget 보기](./stateless_stateful.md)
