LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
ENTITY ssd_btn IS
    PORT(btn: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         ssd: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY ssd_btn;
-------------------------------------------------------------------------------
ARCHITECTURE show_all OF ssd_btn IS
BEGIN
    ssd <= "0000000" WHEN btn="10" ELSE
           "ZZZZZZZ";
END ARCHITECTURE show_all;
