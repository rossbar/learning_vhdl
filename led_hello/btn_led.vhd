LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
ENTITY btn_led IS
    PORT(btn: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         led0_r: OUT STD_LOGIC;
         led0_g: OUT STD_LOGIC;
         led0_b: OUT STD_LOGIC);
END ENTITY btn_led;
-------------------------------------------------------------------------------
ARCHITECTURE lightup OF btn_led IS
BEGIN
    led0_r <= '0' WHEN btn="10" ELSE
              '1';
    led0_g <= '0' WHEN btn="01" ELSE
              '1';
    led0_b <= '0' WHEN btn="11" ELSE
              '1';
END ARCHITECTURE lightup;
