# 함수 (Functions)

Dart에서 함수는 **일급 객체(First-class Object)** 이다.  
즉, 함수를 변수에 담거나, 다른 함수의 파라미터로 전달할 수 있다.

---

## 기본 함수

```dart
void main() {
  print(greet('홍길동')); // Hello, 홍길동!
  
  runTwice(() => print('클리어!'));
  // 클리어!
  // 클리어!
}
```

---

## 함수를 변수처럼 전달

```dart
Function greet = (String name) => 'Hello, $name!';
```

- 함수를 `Function` 타입 변수에 담아 사용 가능
- 화살표 함수(`=>`)로 한 줄 표현 가능

---

## 함수를 파라미터로 받는 함수

```dart
void runTwice(Function action) {
  action();
  action();
}
```

- 함수를 인자로 받아 내부에서 호출
- 콜백(callback) 패턴의 기초

---

## 화살표 함수 (Arrow Function)

```dart
// 일반 함수
String greet(String name) {
  return 'Hello, $name!';
}

// 화살표 함수 (동일한 기능)
String greet(String name) => 'Hello, $name!';
```

- 함수 본문이 단일 표현식일 때 `=>` 로 축약 가능

---

> 💡 **관련 링크**: [클래스 보기](./class.md) | [변수와 타입 보기](./variables.md)
