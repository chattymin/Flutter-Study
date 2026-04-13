# Mixin

Mixin은 **여러 클래스에 기능을 재사용할 수 있게 해주는 구조**이다.  
Dart는 단일 상속만 지원하지만, Mixin을 통해 **다중 기능 조합**이 가능하다.

---

## Mixin 선언

```dart
mixin Flyable on Animal {
  void fly() => print('$runtimeType 날고 있습니다!');
  double altitude = 0;
}

mixin Swimmable {
  void swim() => print('$runtimeType 수영 중!');
}

mixin Runnable {
  void run() => print('$runtimeType 달리는 중!');
}
```

| 문법 | 설명 |
|------|------|
| `mixin 이름` | Mixin 선언 |
| `on 클래스` | 해당 클래스(또는 하위 클래스)에만 적용 가능 |

- `on Animal` → `Animal`을 상속한 클래스에서만 사용 가능
- `on` 없이 선언하면 어떤 클래스에서든 사용 가능

---

## 클래스에 Mixin 적용 — `with` 키워드

```dart
class Animal {
  String name;
  Animal(this.name);
}

class Duck extends Animal with Flyable, Swimmable, Runnable {
  Duck(String name) : super(name);
}
```

- `with` 키워드로 여러 Mixin을 **콤마(,)로 구분**하여 조합
- `extends`로 상속 + `with`로 Mixin 기능 추가

---

## 사용 예시

```dart
void main() {
  var duck = Duck('도널드');
  duck.fly();   // Duck 날고 있습니다!
  duck.swim();  // Duck 수영 중!
  duck.run();   // Duck 달리는 중!
}
```

---

## Mixin vs 상속 vs 인터페이스

| 구분 | 키워드 | 특징 |
|------|--------|------|
| 상속 | `extends` | 단일 상속만 가능 |
| 인터페이스 | `implements` | 모든 메서드를 재구현 해야 함 |
| Mixin | `with` | 다중 조합 가능, 구현체 그대로 사용 |

---

> 💡 **관련 링크**: [클래스 보기](./class.md) | [private 접근 제어자 보기](./private_access.md)
