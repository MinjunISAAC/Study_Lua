-- Chapter 3 _ Expression (표현식)
-- 2023.08.18

-- 루아(Lua)에서 표현식은 값을 나타낸다.
-- '숫자 상수', '문자열 상수', '변수', '단항 연산', '이항 연산', '함수 호출', '함수 정의', '테이블 생성자' 등이 '표현식'의 범주이다.

-- 1. 산술 연산자

    -- 루아(Lua)의 '산술 연산자'는 대체적으로 숫자(number) 연산을 수행하는데 사용된다.
    -- 타 연산자와 큰 차이는 존재하지 않고 유사한 역할을 수행하며, 모두 '실수'로 동작한다.

    -- 산술 연산자
        -- ⦁ 덧셈(+)
        -- ⦁ 뺄셈(-)
        -- ⦁ 곱셈(*)
        -- ⦁ 나눗셈(/)
        -- ⦁ 나머지(%)

            num1 = 5
            num2 = 2

            print(num1 + num2)  --> 5 + 2 = 7
            print(num1 - num2)  --> 5 - 2 = 3
            print(num1 * num2)  --> 5 * 2 = 10
            print(num1 / num2)  --> 5 / 2 = 2.5
            print(num1 % num2)  --> 5 % 2 = 1

    -- 단항 연산자  
        -- ⦁ 부정(-)

            num1 = -5

            print(num1 > 0)   --> false
            print(num1 < 0)   --> true

            
-- 2. 비교 연산자

    -- 루아(Lua)에서 '비교 연산'의 결과는 모두 불리언(boolean)이다.

    -- '비교 연산'은 같은 타입일 경우에 타입의 정의에 따라 연산하며, 같은 타입이 아닐 경우 false로 판단한다.
    -- 특별하게 'nil'은 오직 'nil'만 같다.
    -- 문자열(string)은 두 피연산자를 왼쪽에서부터 오른쪽으로 사전 순서(알파벳 순)로 체크한다. 
    -- 또한 문자열(string)이 동일한 순서라면 문자열(string)의 길이를 확인하게 된다.

        num1 = -1
        num2 = 1

        print(num1 < num2)     --> true
        print(num1 <= num2)    --> true
        print(num1 > num2)     --> false
        print(num1 >= num2)    --> false
        print(num1 == num2)    --> false
        print(num1 ~= num2)    --> true

        str1 = "abc"
        str2 = "acb"
        str3 = "a"
        str4 = "aa"

        print(str1 < str2)     --> true
        print(str1 <= str2)    --> true
        print(str1 > str2)     --> false
        print(str1 >= str2)    --> false
        print(str1 == str2)    --> false
        print(str1 ~= str2)    --> true
        print(str3 < str4)     --> true

    -- 숫자(number)와 문자열(string)이 아닌 값들의 '비교 연산'은 '=='와 '~=' 연산만 적용 가능하다.
    -- 루아(Lua)에서는 테이블(table) 및 유저데이터(userdata)의 '비교 연산'에서는 둘의 동등성을 참조 값이 같은지로 판단한다. 
    -- 즉, 두 값이 같은 객체를 참조하고 있다는 것을 판별한다는 것이다. 

-- 3. 논리 연산자

    -- 루아(Lua)의 '논리 연산'은 피연산자들을 다룰 때 'false'값과 'nil'을 [거짓]으로 판단하고 나머지 값들을 모두 [참]으로 판단한다.
    -- '논리 연산'은 타 언어와 조금 다른 결과를 보여준다.

    -- and
        -- 'and' 연산자는 첫 번째 인자가 [거짓]일 경우 두 번째 인자를 확인하지 않고 첫 번째 인자를 반환한다.

            boolVal1 = false
            boolVal2 = true

            print(boolVal1 and boolVal2)   --> false

    -- or
        -- 'or' 연산자는 첫 번째 인자가 [거짓]일 경우 두 번째 인자를 반환한다.

            boolVal1 = true
            boolVal2 = false

            print(boolVal1 or boolVal2)    --> true

    -- not
        -- 'not ' 연산자는 'and', 'or'과 다르게 '단일 피연산자'를 가지며, 피연산자가 true일 경우 false를 반환하고 피연산자가
        -- false일 경우 true를 반환한다.

            print(not true)                  --> false
            print(not false)                 --> true
            print(not nil)                   --> true
            print(not 0)                     --> false
            print(not (type(1) == type(2)))  --> false

    -- '논리 연산자'의 활용에서 루아(Lua)의 관용표현들이 존재하는데,
    -- 예를 들어, C#을 통해서 게임을 만들때 '예외처리'하는 방법과 비슷하게 'not' 연산자를 이용한 체크라던지, num1과 num2 중 큰 값을 구하는 식 등이 존재한다.
        
        -- 예외처리
        condition = false
        if not condition then
            print("예외체크")
        end

        -- num1, num2 비교
        num1   = 1
        num2   = 2
        result = (num1 > num2) and num1 or num2 

        print(result)    --> 2

-- 4. 이어 붙이기

    -- 루아(Lua)에서는 문자열을 붙이는 과정이 다른 언어와 조금 다른 형태를 띕니다.
    -- C#에서는 간편하게 두 피연산자가 문자열(string)일 경우 '산술 연산자'를 사용한다.
    -- 타입이 다를 경우 ToString 함수를 써서 둘을 합치는 과정을 가지는데, 
    -- 루아(Lua)는 '..'과 같이 점 두개를 붙인 연산자를 사용하여 문자열을 이어 붙일 수 있다.

        print(1 .. 2)               --> 12
        print(1 .. "2")             --> 12
        print("Result : " .. 2)     --> Result : 2
        print("Hello " .. "World!") --> Hello World!

-- 5. 연산 우선순위

    -- 루아(Lua)에서는 다양한 연산자들이 존재하고 해당 연산자들은 '연산 우선순위'가 존재한다.
        -- 1) ^
        -- 2) not, #, -(단항)
        -- 3) *, /, %
        -- 4) +, -
        -- 5) ..
        -- 6) <, >, <=, >=, ~=, ==
        -- and
        -- or
    
    -- '^' 연산자 (제곱 연산자)와 '..' 연산자 (이음 연산자)는 '오른쪽 결합순'이며 나머지는 '왼쪽 결합순'으로 연산이 진행된다. 
    -- 또한 '괄호'를 통해서 연산자의 순서를 정해줄 수도 있다.

        num1 = 1
        num2 = 2

        print(num1 + 3 < num2 / 2 + 1)        --> false
        print((num1 + 3) < ((num2 / 2) + 1))  --> false

        print(5 + num1 ^ 2 * 8)               --> 13.0
        print(5 + ((num1 ^ 2) * 8))           --> 13.0

        print(num1 < num2 and num2 <= 4)      --> true
        print((num1 < num2) and (num2 <= 4))  --> true

        print(- num1 ^ num2)                  --> -1.0
        print(- (num1 ^ num2))                --> -1.0

        print(num1 ^ num2 ^ 3)                --> 1.0
        print(num1 ^ (num2 ^ 3))              --> 1.0

-- 6. 테이블 생성자

    -- "{}"는 테이블(table)을 생성하고 초기화하는 표현식이다.
    
    -- 레코드(Record) 표현 방식
        -- 레코드(Record)는 일종의 데이터 구조이며, 여러 필드를 가진 데이터를 표현하는데 사용된다.
        -- 루아(Lua)에서는 데이터를 그룹화하고 필드에 접근하는 방식으로 주로 활용된다.

            profile =
            {
                name   = "Isaac",
                age    = 20,
                height = 200,
                weight = 20
            }

    -- 리스트(List) 표현 방식
        -- 리스트(List) 표현 방식은 '연속적인 정수 키(Index)'를 가지고 항목에 접근하는 방식이다.

            weightSet = { 158, 162, 180 }

    -- 복합 표현 방식
        -- 레코드(Record)와 리스트(List)를 복합적으로 사용할 수도 있다.
        -- 이런 경우 관용적인 표현으로 ','(쉼표)가 아닌 ';'(세미콜론)을 이용해서 레코드와 리스트 표현 방식을 구분한다.

            exData = 
            {
                name   = "Isaac",
                age    = 20,
                height = 200,
                weight = 300;
                
                "A+",
                "B+",
                "C+",
                "D+"
            }


-- 7. 연습 문제
    -- 1번
        -- 다항식 a_n * (x^n) + a_(n) * x^(n-1) + ... + a_1 * x + a_0 처럼 계수의 리스트로 표현할 수 있다.
        -- 테이블로 표현된 다항식과 x값을 입력 받아 다항식을 계산한 값을 반환하는 함수를 작성하라.

        function Polynomial_Func(coefficient, x)
            local result = 0

            for i, coef in ipairs(coefficient) do
                result = result + coef * (x ^ (#coefficient - i))  
            end

            return result 
        end

        local coefficients = {2, -1, 3}
        local x            = 2

        -- 다항식 계산 결과 출력
        local result = Polynomial_Func(coefficients, x)
        print("다항식 결과 : " .. result)