-- Chapter 1 _ Intro (시작하기)
-- 2023.08.14

-- 1. 청크(Chunk)
-- 파일이나 대화모드에서 입력하는 한 줄의 코드처럼, 루아(Lua)가 실행하는 코드 조각
-- 청크의 정의의 핵심은 '실행하는 코드 조각'

    -- [대화모드]에서는 보통 입력한 한 줄을 완성된 하나의 청크(Chunk)로 해석
    -- 하지만 한 줄을 완성된 청크(Chunk)의 형태가 아닌 것으로 감지하는 경우에는 완료될 때까지 입력을 기다림.
    -- 이런 경우는 [대화모드]를 직접 실행하는게 아니라, Lua 파일(.lua)을 저장하고 파일 자체를 실행하는 것이 올바르다.
        -- CMD에서 -i 옵션을 이용하여 실행 가능하다. ( %lua -i prog)
        -- prog 파일에 있는 청크를 실행 -> 대화모드 프롬프트 실행 

    -- dofile을 사용해서 파일의 내용을 불러올 수 있으며, 하나의 라이브러리 형태로 활용가능하다.

    -- Example 1) 청크의 구분

        -- a = 1
        -- b = a * 2

        -- a = 1;
        -- b = a * 2;

        -- a = 1; b = a * 2

        -- a = 1 b = a * 2

    -- Example 2) dofile을 이용한 파일 불러오기

        -- # Add.lua
        -- function Add(a, b)
        --    return a + b
        -- end

        -- # Test.lua
        dofile("Add.lua")
        num2_1 = 1
        num2_2 = 2 
        c2 = Add(num2_1, num2_2)
        print(c)

-- 2. 어휘 규정
    -- 언더스코어(_)는 루아(Lua)에서 특별하게 사용되므로 사용을 피해야한다. (아직 정확한 이유를 잘 모르겠다.)
    -- 루아(Lua)는 대소문자를 구별한다. 
    
    -- [예약어]
        -- and     break    do       else   elseif 
        -- end     false    goto     for    function
        -- if      in       local    nil    not 
        -- or      repeat   return   then   true
        -- until   while
    -- 예약어와 "대소문자를 구별한다"의 조건 등을 통해 and는 예약어지만 AND는 예약어가 아니다.

    -- [주석]
        -- 한 줄 주석 --
        -- 문 단 주석 --[[ ]]--

-- 3. 전역 변수
    -- 루아(Lua)에서는 전역 변수를 선언할 필요가 없다.
    -- 초기화 되지 않는 변수를 사용해도 C#에서 null을 의미하는 nil 값을 얻을 뿐.
    -- nil을 변수에 할당할 경우 변수가 쓰였던 적이 없었던 것으로 처리, 그러므로 사용했던 메모리를 재활용 가능

    -- Example 1) 전역 변수
        print(a3)   --> nil
        b3 = 1
        print(b3)   --> 1
    
    -- Example 2) nil
        c3 = 1
        print(c3)   --> 1   (같은 메모리 접근)
        c3 = nil
        print(c3)   --> nil (같은 메모리 접근)

-- 4. 연습 문제
    -- 1번
    -- 해당 함수에 파라미터로 음수가 들어갈 경우 어떤일이 생기는지?
    -- 문제가 생길 경우 함수를 수정하라.
    
        function factorial (exN1)
            if exN1 == 0 then
                return 1
            else
                return exN1 * factorial(exN1 - 1)
            end
        end

    -- factorial에 음수가 파라미터가 들어갈 경우 Overflow 발생
    -- 계속해서 작아지기 때문에 Overflow 발생할 것
    -- 팩토리얼의 정의는 0과 양의 정수에 제한되기 때문에 함수내부에 음수일 경우 정수로 수정하는 함수가 필요함.

    function modify_factorial (exN2)
        if exN2 == 0 then
            return 1
        else
            if exN2 < 0 then
                exN2 = exN2 * -1
            end
            return exN2 * modify_factorial(exN2 - 1)
        end
    end
    
    -- 2번
    -- 유효한 식별자로 사용될 수 있는 문자열은 무엇인가?

--[[
        ___     _end     End     end     until?    nil     NULL 
]] --

   -- end, nil