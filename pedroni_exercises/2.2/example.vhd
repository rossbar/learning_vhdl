library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------
ENTITY ckt IS
    PORT(a, b, c: IN STD_LOGIC;
         z: OUT STD_LOGIC);
END ENTITY ckt;
-----------------------------------------------------------
ARCHITECTURE unoptimized OF ckt IS
    SIGNAL x, y: STD_LOGIC;
BEGIN
    x <= a NAND b;
    y <= c OR x;
    z <= a XOR y;
END ARCHITECTURE unoptimized;
