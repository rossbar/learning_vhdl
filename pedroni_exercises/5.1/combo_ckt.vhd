LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
ENTITY ckt IS
    PORT (x: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          y: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END ENTITY ckt;

ARCHITECTURE selector OF ckt IS
BEGIN
    y <= "01" WHEN x(2)='0' ELSE
         "00" WHEN x(1)='0' ELSE
         "10" WHEN x(0)='1';
END ARCHITECTURE selector;

