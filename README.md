## 진행과정

- 2017.11.16 - InputView, OutputView, MyPoint 객체 추가, 터미널에서 좌표 출력되는 것 확인

- 2017.11.17 - CheckingInput, AdjustPoint 객체 추가. 에러처리와 좌표평면의 점이 출력되는 위치를 조정하는 객체를 따로 만들기로 설계하고 틀을 나눔

- 2017.11.20 - CheckingInput, AdjustPoint 객체의 로직을 구체화함. 터미널 환경 상 좌표평면이 출력되는 위치가 실제 사용자가 입력한 위치와 같아보이도록 조정된 좌표객체인 MyPointOutput을 추가함
    - CheckingInput : 사용자 입력값에 대한 에러체크, 입력값을 기호와 좌표값으로 입력한 숫자로 분리
    - AdjustPoint : 터미널 환경 상 좌표평면에 점이 출력되는 위치가 실제 입력한 값이랑 다른 문제를 보완. MyPoint를 가져와서 좌표 숫자를 조정하고 MyPointOutput 객체를 생성함.

- 2017.11.21 - AdjustPoint와 MyPointOutput객체 제거, GenerateMyPoint객체 추가, 에러케이스 추가, main.swift에서 함수의 리턴값을 let변수로 선언하는 방식으로 작성함
    - AdjustPoint와 MyPointOutput객체는 필요 이상으로 객체를 분리한 것이라서 제거하고, 터미널 출력을 위해 값을 조정하는건 OutPutView에서 바로 조정해서 출력. 그래서 OutputView의 drawPoint ()함수도 MyPoint를 매개변수로 받는 것으로 수정.
    - CheckingInput이 책임이 다른 일을 같이 하고있어서 역할이 모호해서, 에러체크를 완료한 정상적인 (Int,Int) 튜플값을 GenerateMyPoint에 넘기고 GenerateMyPoint는 그 튜플값으로 MyPont를 만드는 역할로 분리.
    - CheckingInput에 사용자가 (0,0)을 입력했을때의 에러케이스 추가함.
    - GenerateMyPoint를 Make - 로 바꿈.
    - ChekingInput의 인스턴스 이름과 함수이름, main.swift에서의 리턴값 변수명을 문맥에맞게/중복이없게 변경함

- 2017.11.23 - step3 직선 입력과 출력 단계 시작 main.swift, CheckingInput수정, MyLine객체 추가
    - main.swift에서 에러 캐치하는 부분을 줄임. `let` `as` 키워드를 사용해서 같은 enum타입의 에러 케이스들이 여러 문장에서 중복되어서 사용되는 것을 줄임.
    - CheckingInput에 checkPointNums()함수를 추가해서 복수의 좌표가 입력되는 상황을 추가. 에러체크하는 부분도 복수의 좌표값을 받아서 체크하고 정상값을 리턴해야하기 때문에 `[String]` 타입을 받아서 에러처리하고 `[(Int,Int)]`타입을 리턴.
    - MyPoint객체를 두 개 가지고있는 MyLine객체를 추가.

- 2017.11.24 ~ 25 - FactoryShape객체 추가, FactoryMyPoint객체의 리턴값 변경, OutputView의 drawPoint() 수정, MyLine객체 수정, CheckingInput에러처리 케이스 추가
    - FactoryShape에 MyShape 프로토콜을 정의해서 어떤 도형이나 직선을 입력받더라도 MyShape객체로 묶음 (MyPoint와 MyLine은 MyShape를 준수함)
    - FactoryMyPoint는 좌표점의 수에 따라 `[MyPoint]`를 리턴
    - drawPoint() 또한 `[MyPoint]`수에 따라 print하는 private함수를 호출
    - 각 도형의 객체는 해당하는 도형의 계산식을 구현하는 함수가 있다. MyLine객체도 두 점 사이의 거리를 계산하는 함수 있음.

- 2017.11.27 - CheckingInput의 checkError()수정, MyLine calculate() 수정, 유닛테스트 추가
    - checkError()에서 Mypoint객체를 만들기 위한 `[(Int,Int)]`를 추가하는 과정에서 마지막 값만 좌표값으로 추가되는 문제 (`for`문 scope밖에서 `.append`를 했던 문제..) 수정.
    - calculate() 함수에서 절대값을 구하는 프로퍼티 `magnitude`사용.
    - 첫번째 에러를 디버깅하는 용도로 여러 유닛테스트 코드 추가... 해결!

- 2017.11.28 - MyTriangle객체 구현, ResultMessage 프로토콜 구현, ,drawPoint수정, MyPoint에 Equatable프로토콜 구현.
  - 삼각형 좌표를 출력하고 삼각형의 넓이 구하는 기능 구현.
  - ResultMessage 프로토콜을 구현하고 각 도형 객체가 준수하게 설계해서, 도형마다 출력되는 결과 문장이 다르게 구현.
  - OutPutView에서 printByPoint, Line, Triangle 함수를 제거하고 하나의 drawPoint()함수 내부에서 도형의 종류마다 출력이 다르게 되도록 통합.
  - 좌표값 MyPoint를 여러개 입력받았을때 좌표값이 같을 에러를 대비해서 Equatable프로토콜을 준수하도록 코드를 추가함. 추후 `FactoryMyPoint`에서 `MyPoint`를 만들때 활용할 예정.

- 2017.11.29 - main.swift에 while문 추가
  - 에러를 `catch`했을때 에러메시지를 출력하고 프로그램이 끝나는 것을 수정하기위해 반복문 추가.

- 2017.11.30 - 에러케이스 추가, ShapeChecker객체 추가, Equatable프로토콜 구현, 게임종료옵션 추가, MyShape프로토콜 수정, drawPoint수정
    - ShapeChecker를 추가하고 직선, 도형이 만들어지는 조건을 체크하는 로직을 추가.
    - ShapeChecker에서 체크되는 새로운 에러 케이스들을 추가.
    - 문자열 "quit"을 입력하면 게임이 종료되는 옵션 추가 (이로써 게임은 좌표를 옳은 값으로 입력해서 그래프까지 출력될때, 사용자가 "quit"을 입력했을때의 두 가지 종료조건을 갖는다)
    - MyPoint와 MyLine에 Equatable프로토콜을 구현해서 직선과 도형 구조체에서 좌표값이나 직선값이 서로 같은지 판단하는데 사용하도록 개선.
    - MyShape프로토콜에 getMyPoints() 함수 추가 구현. 각 도형 객체의 프로퍼티인 Mypoint값을 Array로 리턴
    - MyShape타입의 getMyPoints를 이용해서, outputView에서는 MyShape만 가지고 좌표점을 출력하도록 개선.  

- 2017.12.01 - ResultByShape 프로토콜 구현, drawPoint()수정, 유효한 도형체크 함수 추가, main.swift수정
    - ResultByShape 프로토콜 - 출력되는 결과값의 유무가 각 도형마다 달라서 MyShape가 결과 출력과 관련된 함수를 갖고있는게 적절치 않았음. 결과 출력을 하는 함수만 따로 ResultByShape에 정의하고 결과를 출력할 필요가 있는 도형객체만 준수하게 구현.
    - drawPoint()함수의 파라미터는 프로토콜 컴포지션을 받는 것으로 수정. 좌표점을 찍는 기능과 결과메시지를 출력하는 기능 private 함수로 분리. 
        - 결과메시지를 출력하는 기능은 프로토콜 컴포지션`(MyShape & ResultByShape)`로 파라미터를 받음 
    - MyTriangle객체에 삼각형이 형성되는 조건 체크하는 기능 추가. MyPoint 프로퍼티를 연산형프로퍼티로 구성함 `getter`
    - main.swift에서 `do-try-catch`를 에러가 발생하는 객체에 따라서 두 단락으로 분리

- 2017.12.03 - MyRect 구조체 추가, invalidShape()수정, ShapeChecker삭제
    - ShapeChecker 삭제 - shape팩토리의 책임과 중복되는 면이 있어서 팩토리에서 각 도형 케이스별로 에러를 체크하고 에러가 없으면 해당 도형 인스턴스를 생성하도록 변경. 
    - invalidShape()를 `static`메서드로 변경 - 각 shape객체들이 팩토리에서 넘겨받은 좌표값을 바로 가지고 도형의 성립여부를 체크할 수 있도록 수정

- 2017.12.04 - main파일 수정, InputChecker에서 Mypoint의 유효여부를 체크하는 부분 책임 나누기

    - InputChecker에 있던 거대한 함수를 기능마다 잘게 쪼개서 `private`으로 선언.
    - InputChecker에 있던 MyPoint의 유효여부 검사의 책임을 MyPoint로 넘김
    - isValidShape() 로 함수이름 수정, `guard-else` 적용 - inValidShape같은 이중부정의 뜻으로 함수를 쓰지말기. "isValid, true일때 정상, false일때 에러처리"와 같이 직관적으로 수정


    - main 파일 수정 - 가독성을 위해서 인스턴스나 변수를 맨 위에 다 선언하지 않고 사용하는 부분 부근에 선언. 한  scope에서만 사용하는 인스턴스면 해당 scope 내에서 생성되고 소멸하도록 설계해야함.

