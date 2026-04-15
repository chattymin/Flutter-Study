# Stateless Widget & Stateful Widget

Flutter 위젯은 **상태(state) 관리 여부**에 따라 두 종류로 나뉜다.

---

## StatelessWidget

**상태가 없는** 위젯. 한 번 그려지면 스스로 변하지 않는다.

```dart
class Greeting extends StatelessWidget {
  final String name;

  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text('안녕하세요, $name!');
  }
}
```

### 특징
- `build()`만 오버라이드
- 외부에서 전달받은 값으로만 UI 구성
- **변하지 않는 UI**에 적합 (아이콘, 텍스트, 로고 등)

---

## StatefulWidget

**상태가 있는** 위젯. 사용자 인터랙션이나 데이터 변화에 따라 **UI가 동적으로 변한다.**

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('카운트: $_count'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _count++;
            });
          },
          child: Text('증가'),
        ),
      ],
    );
  }
}
```

### 특징
- `StatefulWidget` + `State` 클래스 **두 개가 한 쌍**
- `setState()` 호출 → `build()` 재실행 → UI 업데이트
- **동적으로 변하는 UI**에 적합 (카운터, 폼, 토글 등)

---

## StatelessWidget vs StatefulWidget 비교

| 구분 | StatelessWidget | StatefulWidget |
|------|-----------------|----------------|
| 상태 변경 | ❌ 불가 | ✅ 가능 (`setState`) |
| 클래스 구성 | 1개 | 2개 (Widget + State) |
| `build()` 재호출 | 외부 값 변경 시 | `setState()` 호출 시 |
| 사용 예시 | 고정 텍스트, 아이콘 | 버튼 클릭, 입력 폼, 애니메이션 |

---

## 생명주기 (StatefulWidget)

```
createState() → initState() → build() → setState() → build() → dispose()
```

| 메서드 | 호출 시점 |
|--------|-----------|
| `createState()` | State 객체 생성 |
| `initState()` | 최초 1회 초기화 |
| `build()` | UI 그리기 (setState마다 재실행) |
| `dispose()` | 위젯 제거 시 정리 (리소스 해제) |

---

## 어떤 걸 써야 할까?

> **기본은 StatelessWidget**, 상태 변경이 필요할 때만 StatefulWidget을 쓴다.

---

> 💡 **관련 링크**: [Widget 보기](./widget.md) | [Widget Tree 보기](./widget_tree.md) | [Container & SizedBox 보기](./container_sizedbox.md)
