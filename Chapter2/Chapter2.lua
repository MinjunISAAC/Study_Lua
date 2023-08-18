-- Chapter 2 _ Type & Value (타입과 값)
-- 2023.08.16 ~ 2023.08.17

-- 루아(Lua) 데이터 타입은 기본적으로 8가지가 존재한다.

    -- 1) nil
    -- 2) boolean
    -- 3) number
    -- 4) string
    -- 5) table
    -- 6) function
    -- 7) userdata
    -- 8) thread

    -- 루아(Lua)에서의 변수는 미리 정의된 타입이 존재하지 않는다.
    -- 그러므로 변수는 모든 타입을 할당 받을 수 있다.
    -- type함수는 무조건 string을 출력한다.

    val1 = 10
    val2 = "value"
    val3 = true

    print(val1)              --> 10
    print(val2)              --> value
    print(val3)              --> true

    print(type(val1))        --> number
    print(type(val2))        --> string
    print(type(val3))        --> boolean

    print(type(type(val1)))  --> string
    print(type(type(val2)))  --> string
    print(type(type(val3)))  --> string

-- 1. nil
    -- 다른 언어에서 null 이라는 단일 값과 동일하게 쓰인다.
    -- 정확히는 '값이 없는 상태'이다.
    -- 루아(Lua)의 Garbage Collection (GC)는 nil 값을 가진 변수를 메모리에서 내리게된다.

-- 2. boolean
    -- boolean의 타입은 true와 false가 존재하며, 타 언어에서 사용하는 역할을 동일하게 수행한다.
    -- 루아(Lua)에서 boolean의 타입은 특별하게 작동하는 부분이 존재하는데,
    -- false와 nil은 거짓 타입으로 나머지들은 모두 참으로 작동한다.

    if (false) then print("Example 1") end   --> 출력x
    if (true)  then print("Example 2") end   --> 출력o
    if (0)     then print("Example 3") end   --> 출력o
    if (1)     then print("Example 4") end   --> 출력o
    if (nil)   then print("Example 5") end   --> 출력x
    
    -- false와 nil이 false로 동일한 기능을 제공하고 있지만 
    -- nil은 '값이 없는 상태'이므로 '특별한 불리언 값'을 사용해야할 때는 false를 사용한다.
    
-- 3. number
    -- 루아(Lua)에서 숫자를 나타내는 데이터 타입은 number 하나만 존재한다.
    -- number은 실수를 의미하며, 특이하게 루아(Lua)에서는 정수 타입을 따로 두지 않는다.
    -- 정확히 루아(Lua)의 실수 타입은 '배정도 부동 소수(Double Precision Floating-Point)'를 표현 방식을 채택했다.

    num1 = 1
    num2 = 0.1
    num3 = -1
    num4 = -0.1

    print(type(num1))   --> number
    print(type(num2))   --> number
    print(type(num3))   --> number
    print(type(num4))   --> number
    
-- 4. string
    -- 루아(Lua)에서 string은 타 언어와 유사하게 '문자들의 순열'이다.
    -- 문자열은 한글자를 8비트로 표현하며, 문자열 중간에 0을 포함한 수치 코드를 쓸 수 있다.
    -- ASCII 코드(아스키) 같은 경우 7비트로 표현 가능하며, 유니코드같은 경우 일반적으로 16비트, 32비트로 표현된다.
    -- 하지만 '문자열 중간 0을 포함한 수치 코드'로 표현가능하여 유니코드를 표현할 수 있다.
    
    local unicodeString = "Hello, \226\128\147Lua!"  -- "Hello, –Lua!"
    print(unicodeString)

    -- 1) 수정할 수 없는 값(Immutable Value)
        -- 루아(Lua)의 문자열은 수정할 수 없는 값(Immutable Value)이다.
        -- 여기서 '수정할 수 없는 값'이 혼동할 수 있는 어휘일 수 있으나, 
        -- 설명하자면 루아(Lua)와 반대로 C++에서는 문자열을 수정할 수 있는 값(Mutable Value)으로 표현된다.
        
        --[[
            [C++]
            std::string text = "Hello";
            stdin::cout << text << std::endl;  // Hello
            text[0] = 'W';
            std::cout << text << std::endl;    // Wello
        ]]--
        
        -- 하지만 새 문자열을 만들어 해당 문자열을 대체하여 수정할 수 있도록 쓸 수는 있다.

        val4 = "Hello World!"
        val5 = string.gsub(val4, "World", "Isaac")

        print(val4)             --> Hello World!
        print(val5)             --> Hello Isaac!

    -- 2) 길이 연산자(#)
        -- 루아(Lua)에는 '길이 연산자#'가 존재한다. '길이 연산자'를 통해서 문자열의 길이를 얻을 수 있다.
        -- '길이 연산자'는 접두 연산자 #를 사용한다.

        print(#"Hello")        --> 5
        print(#"Hello World")  --> 11

    -- 3) 이스케이프 문자(Escape Character)
        -- 루아(Lua)에서 큰 따옴표(""), 작은 따옴표('')는 구분없이 사용 가능하지만, 
        -- 사용하는 상황에 따라 다른 표현을 사용해야 할 수도 있다. 
        -- 예를 들어 XML의 내부는 큰 따옴표("")이 포함되어있기에 XML 내용을 감싼다면 작은 따옴표('')을 사용해야한다.

        -- 물론 루아(Lua)는 C기반으로 개발되었기에 C에서 사용하는 이스케이프 문자(Escape Character)도 사용 가능하다.
        -- 루아(Lua)에서는 '구간 문자열' 기능도 제공한다. 
        -- '구간 문자열' 같은 경우 [[ ]]을 통해서 아래와 같이 표현 가능하며, '구간 문자열' 내부에서는 이스케이프 문자(Escape Character)도 작동하지 않는다.

        html_arg = 
        [[
        <html>
            <head>
                <title>My First HTML Page</title>
            </head>
            <body>
                <h1>Hello, World!</h1>
                <p>This is a simple example of an HTML page.</p>
                <ul>
                    <li>Item 1</li>
                    <li>Item 2</li>
                    <li>Item 3</li>
                </ul>
            </body>
        </html>
        ]]

        print(html_arg)

    -- 4) 자동 변환
        -- 루아(Lua)에서는 숫자(number) 타입과 문자(string) 타입간의 '자동 변환'을 지원한다.
        -- (파이썬(Python)에서도 숫자 타입과 문자 타입 간의 일부 자동 변환 제공)

        -- 하지만 어느 언어에서도 그러듯이 '자동 변환' 기능은 위험한 기능이다. 
        -- 의도치 않은 동작을 발생시킬 수도 있기 때문이다. 
        
        -- 해당 마지막 예시에서 Happy New Year 2023 을 의도하고 작성했지만 해당 부분은 '자동 변환'되어 'string + number'이 되어 오류를 발생시키는 것과 같다.

        print("2023" + 08 + 15)              --> 2046
        print("2023" + "08" + "15")          --> 2046
        print("2023" + "-08" + "-15")        --> 2000
        -- print("Happy New Year" + "2023")  --> Error

        -- 그렇기에 명시적으로 해당 타입을 지정해주는 것이 시각적으로 이해하기 편하고, 
        -- 의도치 않은 문제가 발생하는 것을 줄일 수 있다.

        year_num = 2023
        year_str = "2023"

        print(type(year_num))            --> number
        print(type(year_str))            --> string
        print(type(tostring(year_num)))  --> string
        print(type(tonumber(year_str)))  --> number

-- 5. table
    -- 루아(Lua)에서는 테이블(table)라는 강력하고 유일한 자료구조를 가지고 있다.
    
    -- 테이블(table)은 연관 배열(Associative Array) 또는 해시 맵(Hash Map)의 역할을 수행한다.
    
    -- 연관 배열(Associative Array)의 특성 상 테이블(table)은 인덱스로 숫자(number) 타입외 nil 등 모든 값을 쓸 수 있다. 
    -- 그러므로 테이블(table)은 서로 다른 타입의 인덱스를 가질 수 있다.
    -- 이러한 테이블(table)의 특징은 단순한 배열(Array)의 역할이 아닌 해시 맵(Mash Map)과 같은 역할을 수행할 수 있게 된다.

    -- 테이블(table)은 변수 또는 값이 아닌 '동적 할당된 1급 객체'이다.
    -- 프로그램 상에서 객체에 대한 참조 및 포인터에 의해 작동하기 때문에 의도하지 않게 객체의 클론이 생성되거나, 새로운 테이블이 생성되는 일은 일어나지 않는다.
    -- '1급 객체'라는 의미는 '변수에 할당 가능'하기 때문에 '함수의 매개변수', '함수의 반환값'에 할당 할 수 있다는 특징이 있으며 '동적 생성이 가능'하다는 의미이다.

    -- 1) 유일한 자료구조
        -- 앞에서 설명한 것처럼 테이블(table)은 루아(Lua)에서 유일한 자료구조입니다.
        -- "우리가 다른 언어에서 사용하는 '배열(Array)', '링크드 리스트(Linked List)', '그래프(Graph)' 등은 루아(Lua)에서 사용하지 못하는 것인가?"라고 한다면 그렇지 않다.
        -- 특정 자료구조를 테이블(table)을 통하여 구현가능하다.

    -- 2) 선언이 아닌 생성
        -- 루아(Lua)에서 테이블(table)을 사용하기 위해서는 선언을 해주는 것이 아니라 생성을 해주어야한다.
        -- 애초에 루아(Lua)에서 테이블(table)을 선언해줄 수 있는 방법이 존재하지 않는다. 
        -- 테이블(table)의 생성은 중괄호({}) 한쌍을 통해서 가능하다.

        exTable_1 = {}

    -- 3) 표현 방식
        -- 테이블(table)은 '표현 방식'이 다양하고 테이블(table)을 사용하고자 하는 '데이터 구조 설계'에 따라 달라질 수 있다.
        -- 이러한 점은 '테이블(table)이 굉장히 유연하다는 것'을 알 수 있다.

            -- ⦁ Key - Value 표현
                -- 'C#'에서 해시테이블(HashTable), 딕셔너리(Dictionary)와 비슷한 표현을 할 수 있으나, 같다고는 볼 수 없다.

                profile =
                {
                    name   = "Isaac",
                    age    = 20,
                    height = 200,
                    weight = 20
                }

            -- ⦁ Index - Value 표현
                -- 테이블(table)에서 다른 언어에서 Index를 0으로 시작하는 것과 달리 'Index는 1부터 시작'하는 것이 관례이다.
                -- (루아(Lua) 기능들 중 이러한 관례로 구현되어있는 것이 많으므로)

                -- 배열(Array), 리스트(List)와 비슷한 표현이 가능하지만 이또한 비슷하게 표현하는 것이지 같지 않다. 

                heightSet =
                {
                    158,
                    162,
                    180
                }
                
            -- ⦁ Index - Table 표현
                -- 테이블(table)은 '1급 객체'이기 때문에 변수 할당이 가능하다. 
                -- 그러므로 테이블(table) 내부에 중첩 테이블(table)로 표현할 수 있다.

                studentSet = 
                {
                    { name = "Isaac", grade = "A+" },
                    { name = "John",  grade = "A+" },
                    { name = "Ria",   grade = "B"  },
                    { name = "Son",   grade = "C+" }
                }
                
            -- ⦁ Key - Function 표현
                -- 함수(Function)도 '1급 객체'이기에 테이블(table) 내부에서 표현 가능하다.
                mathFuncs =
                {
                    Add      = function (a, b) return a + b end,
                    Subtract = function (a, b) return a - b end,
                    Multiply = function (a, b) return a * b end,
                    Divide   = function (a, b) return a / b end
                }

    -- 4) 접근 방식
        -- 테이블(table)에 다양한 '표현 방식'이 존재했듯이 '접근 방식'도 다양하다. 
        -- '접근 방식'은 테이블(table)의 '데이터 구조'에 따라 적절하게 사용해야 한다. 
        -- (협업에서 타개발자가 해당 테이블을 보았을 때, 의도한 방식을 유추할 수 있다는 점도 중요)
        
            -- ⦁ 점 표기법
                -- '점 표기법'이란, exTable.value 와 같이 [.]을 이용해 테이블(table) 내부에 접근하는 것을 의미한다.
                -- '점 표기법'은 테이블에 미리 정해진 키를 쓰겠다는 룰이 적용된다.
                
                mathFuncs =
                {
                    Add      = function (a, b) return a + b end,
                    Subtract = function (a, b) return a - b end,
                    Multiply = function (a, b) return a * b end,
                    Divide   = function (a, b) return a / b end
                }

                print(mathFuncs.Add(2, 5))        --> 7
                print(mathFuncs.Subtract(2, 5))   --> -3
                print(mathFuncs.Multiply(2, 5))   --> 10
                print(mathFuncs.Divide(2, 5))     --> 0.4

            -- ⦁ 괄호 표기법
                -- '괄호 표기법' 은 배열(Array), 리스트(List)를 표현할 때 정수를 키(C에서 Index를 의미하는)로 나타내고 있을 때 사용되는 경우가 일반적이다. 
                -- (루아(Lua)에서 Index의 시작은 1)

                heightSet =
                {
                    158,              -- Index 1
                    162,              -- Index 2
                    180               -- Index 3
                }

                print(heightSet[0])   --> nil
                print(heightSet[1])   --> 158
                print(heightSet[2])   --> 162
                print(heightSet[3])   --> 180

                -- 두 표기법은 같은 결과물을 출력한다. 
                -- 하지만 앞에서도 말했듯이 테이블(table)의 '설계 의도'에 따라 적절하게 표현해 주어야하며, 
                -- 그렇지 않을 경우 혼동을 초래할 수 있다. 

                exTable = {}
                val   = "y"

                --[[ exTable 상태
                    exTable = 
                    {
                    
                    }
                ]]--

                exTable[val] = 10

                --[[ exTable 상태
                    exTable = 
                    {
                        "y" = 10
                    }
                ]]--

                print(exTable[val]) -- exTable의 필드에서 "y"값  RESULT : 10
                print(exTable.y)    -- exTable의 필드에서 "y"값  RESULT : 10
                print(exTable.val)  -- exTable의 필드에서 "x"값  RESULT : nil

                
    -- 5) 길이 연산자(#)
        -- 문자열(string)에서도 설명했던 '길이 연산자(#)'도 테이블(table)에서 사용 가능하다. 
        
        studentSet =
        {
            "Isaac",
            "Son",
            "John"
        }

        print(#studentSet) --> 3


-- 6. Function
    -- 루아(Lua)에서 함수(function)은 '1급 값'이다.
    -- 다른 포스팅에서도 설명한 적이 있지만 '1급 값'은 'OO을 일반 값처럼 사용 가능'한 특징을 가지고 있다. 
    -- 즉, 루아(Lua)에서 함수(function)은 '1급 값', '1급 함수'이므로 변수가 될 수 있다.
    -- 함수(Function)의 파라미터로 사용하거나 함수의 리턴값으로도 사용 가능하다. 
    -- 물론 테이블(table)에서 확인했듯 테이블(table)의 요소로도 사용 가능하다.

    function Add (num1, num2) 
        local result = 0
        result = num1 + num2
        return result
    end
    
    function Multiply (num1, num2)
        local result = 0
        result = num1 * num2
        return result
    end
    
    -- (num1 + num2) * num3 를 표현
    print(Multiply(Add(2, 4), 10))       --> (2 + 4) * 10

    -- 1. 익명 함수 (Anonymous Function)
        -- 루아(Lua)에서 함수(Function)은 '익명 함수(Anonymous Function)' 기능을 지원한다.
        -- '익명 함수(Anonymous Function)'은 '이름이 없는 함수'이며, 이름이 없다는 점을 제외하면 일반 함수와 큰 차이는 존재하지 않는다.
    
        Add      = function(num1, num2) return num1 + num2 end
        Subtract = function(num1, num2) return num1 - num2 end
        Multiply = function(num1, num2) return num1 * num2 end
        Divide   = function(num1, num2) return num1 / num2 end

        print(Add(4, 5))          --> 9
        print(Subtract(4, 5))     --> -1
        print(Multiply(4, 5))     --> 20
        print(Divide(4, 5))       --> 0.8

    -- 2. 가변 인자 함수(Variadic Function)
        -- 루아(Lua)에서 함수(Function)의 매개변수로 '가변 인자'를 사용할 수 있으며 이를 '가변 인자 함수(Variadic Function)'라고 한다.
        -- '가변 인자 함수'를 정의 하는 방법은 매개변수에 '...'을 사용하면 된다.
        -- '가변 인자 함수'의 매개변수인 '...'는 함수 내부의 특별한 테이블(table)로 처리되어, 테이블(table)의 모든 인자에 접근 가능할 수 있다. 

        function VariadicFunc(...)
            for i, v in ipairs({...}) do
                print(i, v)
            end
        end
        
        VariadicFunc(1, 2, 3, 4, 5)                        
        VariadicFunc("one", "two", "three")                
        VariadicFunc(1, 2, 3, 4, 5, "one", "two", "three") 
        
        --[[
        1	1
        2	2
        3	3
        4	4
        5	5
        1	one
        2	two
        3	three
        1	1
        2	2
        3	3
        4	4
        5	5
        6	one
        7	two
        8	three
        ]]--

    -- 3) 클로저(Closure)
        -- 루아(Lua)에서는 클로저(Closure) 기능을 지원한다. 
        -- 클로저(Closure)란 '함수와 비지역 변수들의 묶음'이다.

        function OuterFunc(num)
            local outerVar = num
            return function(addNum) return (addNum + num) end --> [Pick]
        end

        local closure = OuterFunc(10)                         
        print(closure(5))                                     --> [출력] 15

        -- [Pick]에서 보면 return 값으로 함수를 넘겨주는데, 
        -- 'OuterFunc'에는 'outerVar'이라는 '지역 변수'가 존재하고 리턴하는 
        -- '익명 함수'에서 '외부 변수'인 'outerVar'을 참조하고 있는 것을 알 수 있다.
        -- 이런 식으로 '내부 함수'와 '외부 변수'의 조합을 클로저(Closure)이라고 부른다.
        -- 또한 이러한 클로저(Closure) 기능은 '1급 값'를 특징으로 가진 루아(Lua)에서 가능한 기술이다.

    -- 4) 함수 반환
        -- 다른 언어에서도 '함수 반환' 기능을 지원하고 있는 것과 같이 루아(Lua)에서도 '함수 반환' 기능을 제공하고 있다.
        -- 그렇기에 '재귀 함수' 구현도 가능하다.