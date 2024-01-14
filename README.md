# MiniSuperApp

## 📱 프로젝트 소개

- 해당 프로젝트는 카드 등록 및 금액 충전을 주제로 만든 데모앱입니다.
- 의존성과 모듈화에 대한 명확한 이해를 하기 위해 템플릿을 제공하는 `ModernRIBs` 아키텍처 패턴을 사용하였습니다.
- Combine을 활용해 네트워크 환경에서의 비동기처리를 진행하였습니다.
- Transport 팀, Finance 팀, Profile 팀, Utility 팀으로 분업을 한다는 가정으로 모듈화를 진행하였습니다.
- `XCTest`를 이용해 `Unit Test`, `UI Test`를 진행하였습니다.

### 슈퍼 택시화면에서 충전
![2024-01-1412 29 55-ezgif com-video-to-gif-converter](https://github.com/jincode93/MiniSuperApp/assets/111134273/b3115284-3234-434e-888b-6e3ad884b453)

### 슈퍼 페이화면에서 충전
![2024-01-1412 30 30-ezgif com-video-to-gif-converter](https://github.com/jincode93/MiniSuperApp/assets/111134273/73937cbd-0f3a-4928-8e2a-9c96deb98b1b)

### 슈퍼 페이화면에서 카드 추가
![2024-01-1412 30 57-ezgif com-video-to-gif-converter](https://github.com/jincode93/MiniSuperApp/assets/111134273/14fa17e5-52a5-4ad1-8dfa-f6367d75758e)

---

## ModernRIBs를 사용한 이유

- 아키텍처 패턴, DI(+DIP), UnitTest에 대한 공부를 하기 위해 여러가지 자료를 찾던 중 RIBs에 대해 알게 되었고 RIBs의 경우 Template를 제공하고 있어 매우 확실한 구조를 가지고 있기 때문에 한동안 계속 공부하고 있던 `의존성, 모듈화에 대해 명확하게 이해할 수 있을 것 같아 RIBs를 선정` 하였습니다.
- ModernRIBs의 경우 Rx를 걷어내고 Combine으로 대체한 RIBs 패턴인데 템플릿도 잘 되어있고 Rx는 현재 Split it이라는 앱을 통해 학습 및 사용해보고 있어 `Combine을 함께 학습하기 위해 ModernRIBs로 선정` 하였습니다.

### ModernRIBs의 구조와 역할

- RIBs는 Router, Interactor, Builder로 구성되며 ViewController는 필요에 따라 추가되거나 없는 경우도 발생합니다.
- 하나의 Router, Interactor, Builder의 묶음을 Riblet이라고 부르며 `RIBs의 가장 중요한 개념은 Riblet을 Flow에 따라 attach, detach하며 Riblet을 재활용`한다는 것입니다.
- Router : Builder를 통해 인스턴스되며 Interator에게 Listener를 통해 하위 Riblet들의 attach와 detach를 관리합니다. RIBs에서 꼭 지켜야하는 원칙 중 하나는 `상위 Riblet에서 attach 시킨 하위 Riblet은 책임지고 상위 Riblet이 detach 시켜야 한다는 것으로 해당 원칙을 지킴으로써 메모리 누수를 방지`할 수 있습니다.
- ViewController : 다른 아키텍처와 마찬가지로 View의 역할을 담당합니다. Interactor를 통해 데이터를 전달받으며 인터렉션이 일어나면 PresentableListener를 통해 Interactor에게 신호를 전달해 줍니다.
- Interactor : ViewController에게 신호를 받아 비즈니스 로직을 동작합니다. 해당 로직으로 인해 하위 View가 attach된다면 Router에게 신호를 전달해 attach를 진행하게되고, Interator가 속한 Riblet이 detach되어야하는 상황이라면 RibletListener를 통해 상위 Riblet에 신호를 보내 detach동작이 일어나도록 합니다.
- Builder : Riblet을 생성시키는 역할을 담당합니다. 상위 Riblet이 하위 Riblet을 생성할 때 Builder를 만들어서 생성을 하게되며, 이로 인해 하위 Riblet에 필요한 리소스들을 Dependency로 만들어 전달하고 있습니다.

### Router
<img width="963" alt="스크린샷 2024-01-14 오후 1 08 21" src="https://github.com/jincode93/MiniSuperApp/assets/111134273/1e1eab80-15fc-4015-bc40-730707a7761e">

### Interactor
<img width="1160" alt="스크린샷 2024-01-14 오후 1 08 45" src="https://github.com/jincode93/MiniSuperApp/assets/111134273/ca156bbd-1507-48b7-8756-d0c1eb90526b">

### Builder
<img width="876" alt="스크린샷 2024-01-14 오후 1 09 00" src="https://github.com/jincode93/MiniSuperApp/assets/111134273/aa6f73cd-120d-41a9-9d3e-2d21b4cef89d">

---

## 모듈화를 진행한 이유

- 개인 또는 스터디를 통해 앱을 만들 경우 여러 팀을 나눠서 작업하는 경우가 거의 없었는데 실제 현업에서는 여러 팀을 나눠서 개발을 진행하거나 각각 맡은 역할이 확실하기 때문에 각 팀마다 소스코드 의존성을 끊어서 사용할 것이라고 생각하였습니다.
- 그래서 `하나의 앱을 만들면서 Transport 팀, Finance 팀, Profile 팀, Util 팀으로 나눠져서 작업을 진행한다고 가정`하고 만들게 되었고 각 팀은 다른 팀의 코드에 영향을 주어선 안된다는 전제하에 개발을 진행하기 위해 모듈로 분리하고 의존성을 관리해 주었습니다.
- 뿐만 아니라 모듈로 나눔으로써 `각 팀마다 불필요한 코드들은 숨길 수 있고 팀별로 빌드를 할 수 있기 때문에 테스트 코드를 작성하기 쉽고 테스트에 걸리는 시간도 현저히 줄어든다는 장점`이 있다고 판단하여 모듈화를 진행하였습니다.

---

## 더미 서버와 로컬 서버를 사용한 이유

- 더미 서버를 사용한 이유는 `아직 서버가 없다고 가정`하고 Request와 Response를 직접 만들어서 주고 받을 수 있도록 구현하고 `추후 서버가 만들어진다면 바로 교체할 수 있도록 개발`하는 환경으로 만들었습니다.
- 실제 현업에서 서버의 구현이 끝나지 않은 상태에서 앱을 만들고 테스트 해야되는 경우도 있을 것이라고 생각해서 이러한 가정을 추가하게 되었습니다.
- 로컬 서버를 사용한 이유는 `테스트는 외부 환경에 영향을 받으면 안되기 때문에 로컬 서버를 이용해서 테스트 하기 위해 사용` 하였습니다.
- 현재는 더미 서버를 사용했기 때문에 굳이 로컬 서버로 테스트를 하지 않아도 크게 문제는 없으나 추후 더미 서버를 걷어내고 실제 서버를 적용하게 될 경우 테스트 코드를 수정해야되는 경우가 발생 할 수 있기 때문에 미리 로컬 서버를 이용해서 테스트 코드를 작성하였습니다.

---

## 특정 Riblet만 Interface를 작성한 이유

- 여러 팀에서 각각의 기능을 만든다는 전제하에 코드를 작성하였습니다.
- Finance 팀의 Topup, AddPaymentMethod Riblet의 경우는 Transport 팀에서도 사용을 해야하기 때문에 `Interface를 활용해 의존성을 역전시킴으로써 결합을 느슨하게 만들어 재활용성을 높이고 빌드 시간을 줄여주기 위해` 사용하였습니다.
    - Topup Riblet : View가 없는 Riblet으로 카드 선택, 금액 충전 Flow를 담고 있는 로직 Riblet입니다.
    - AddPaymentMethod Riblet : 새로운 카드를 추가하는 Riblet입니다.

---

## Combine Scheduler를 사용한 이유

- Network 관련해서 `기존에는 DispathQueue를 통해 UI 관련 작업을 메인 쓰레드에서 실행하고 있어서 비동기적으로 진행이 되고 있었는데 이것은 Testable한 코드가 아니라고 생각` 합니다.
- 왜냐하면 `비동기적으로 실행하면 불확실성이 생겨서 동일한 테스트여도 실패할 수 있는 확률이 생기기 때문`인데 그래서 `Combine Schedulers를 통해 테스트 환경에서는 동기적으로 실행될 수 있도록 바꿔주었습니다.`
- Test 환경에서만 Combine이 제공하는 ImmediateScheduler를 사용할수도 있지만 여러 테스트 케이스들을 처리하기 편하도록 하기 위해 Combine Schedulers 라이브러리를 도입하게 되었습니다.

---

## Unit Test, UI Test 작성

- Mini Super App을 만들면서 가장 고려했던 부분이 Test 하기 쉬운 코드 였습니다.
- 앱스쿨, 애플 아카데미를 통해 다양한 협업 경험을 하면서 Test 코드를 작성하는 것이 얼마나 중요하고 더 빠른 속도로 프로젝트를 완성할 수 있는지에 대해 많이 느꼈습니다.
- Quick / Nimble을 많이 사용하지만 기본 프레임워크인 XCTest를 통해 Test를 작성해보는 경험을 많이 가지는 것이 더 좋을 것 같다고 판단하여 XCTest를 활용하여 Unit Test, UI Test를 작성하였습니다.

---

## 💡 학습하면서 느낀 점

- RIBs, VIPER, TCA와 같은 아키텍처 패턴은 처음 사용할 경우 익숙해지는데 시간이 꽤 걸리는 편이지만 MVC, MVVM 패턴에 비해 각 역할마다 구조가 확실하고 명확하기 때문에 규모가 커서 개발자가 많고 역할이 명확하게 나누어진 서비스일 경우에는 유지보수성이 뛰어날 것 같다고 느꼈습니다.
- UnitTest, UITest를 작성해봄으로써 Testable한 코드란 무엇인가에 대해 조금 더 명확하게 알 수 있었습니다.
- 아키텍처 패턴, 모듈화에 대해 공부하기 전에는 협업을 하는 과정에서 코드 충돌이 꽤 많이 발생하였고, 충돌이 발생하지 않더라도 코드가 명확히 구분되어 있지 않은 경우가 있어 사이드 이펙트로 고생을 했던 경험이 있는데 Mini Super App을 만들어봄으로써 조금 더 코드를 소프트웨어 답게 사용할 수 있는 방법을 알게 되었습니다.
