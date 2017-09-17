LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
PACKAGE my_ssd_driver IS
    FUNCTION val_to_ssd_signal (input: INTEGER RANGE 0 TO 9)
    RETURN STD_LOGIC_VECTOR(6 DOWNTO 0);
END PACKAGE my_ssd_driver;
-------------------------------------------------------------------------------
PACKAGE BODY my_ssd_driver IS
    FUNCTION val_to_ssd_signal (input: INTEGER RANGE 0 TO 9)
    RETURN STD_LOGIC_VECTOR(6 DOWNTO 0) IS
        VARIABLE ssd: STD_LOGIC_VECTOR(6 DOWNTO 0);
    BEGIN
        CASE input IS
            WHEN 0 => ssd := "0000Z00";
            WHEN 1 => ssd := "ZZ00ZZZ";
            WHEN 2 => ssd := "00Z00Z0";
            WHEN 3 => ssd := "Z0000Z0";
            WHEN 4 => ssd := "ZZ0000Z";
            WHEN 5 => ssd := "Z00Z000";
            WHEN 6 => ssd := "000Z000";
            WHEN 7 => ssd := "ZZ00ZZ0";
            WHEN 8 => ssd := "0000000";
            WHEN 9 => ssd := "ZZ00000";
            WHEN OTHERS => ssd :="00ZZ000"; -- 'E' for error
        END CASE;
        RETURN ssd;
    END FUNCTION val_to_ssd_signal;
END PACKAGE BODY;
