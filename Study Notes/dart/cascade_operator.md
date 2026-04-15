# Cascade 연산자 (..)

Cascade 연산자(`..`)를 사용하면 동일한 객체에 대해 **여러 속성이나 메서드를 연속으로 호출**할 수 있다.

---

## 기존 방식 (일반 스타일)

```dart
// 다른 언어 스타일
final button = Button();
button.text = '확인';
button.color = Colors.blue;
button.onPressed = handleTap;
```

매번 `button.`을 반복해야 한다.

---

## Dart의 Cascade

```dart
final button = Button()
  ..text = '확인'
  ..color = Colors.blue
  ..onPressed = handleTap;
```

- `..`을 사용하면 **같은 객체에 연속적으로 접근** 가능
- 반환값이 아닌 **원래 객체 자체를 반환**하기 때문에 체이닝이 가능
- 코드가 간결해지고 가독성이 높아짐

---

## 주의사항

- `..`은 메서드 체이닝(`.`)과 다르다
- `.`은 메서드의 반환값을 반환하지만, `..`은 원래 객체를 반환

---

> 💡 **관련 링크**: [Spread 연산자 보기](./spread_operator.md) | [Collection if/for 보기](./collection_if_for.md)
