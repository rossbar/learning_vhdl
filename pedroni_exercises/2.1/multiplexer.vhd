-------------------------------------------------------------------------------
-- Attempt at laying out the multiplexer described in Pedroni 2nd ed. ex. 2.1
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
ENTITY mux IS
    PORT(a, b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         sel: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         x: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY mux;
-------------------------------------------------------------------------------
ARCHITECTURE example OF mux IS
BEGIN
    PROCESS (a, b, sel)
    BEGIN
        IF (sel="00") THEN
            x <= "00000000";
        ELSIF (sel="01") THEN
            x <= a;
        ELSIF (sel="10") THEN
            x <= b;
        ELSE
            x <= "ZZZZZZZZ";
        END IF;
    END PROCESS;
END ARCHITECTURE example;
