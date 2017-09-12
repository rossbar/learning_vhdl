LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
ENTITY btn_led IS
    PORT(btn: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         led: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END ENTITY btn_led;
-------------------------------------------------------------------------------
ARCHITECTURE lightup OF btn_led IS
BEGIN
    led <= btn;
END ARCHITECTURE lightup;
