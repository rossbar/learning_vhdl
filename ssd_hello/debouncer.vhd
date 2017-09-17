LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
-------------------------------------------------------------------------------
ENTITY debouncer IS
    -- Assume 10 ms settling time. log2(0.01 / (1/12 MHz)) ~> 17
    GENERIC(ctr_bitlen: INTEGER := 17);
    PORT(clk: IN STD_LOGIC;
         btn: IN STD_LOGIC;
         dbcd_res: OUT STD_LOGIC);
END ENTITY debouncer;
-------------------------------------------------------------------------------
ARCHITECTURE debounce OF debouncer IS
    SIGNAL flipflops: STD_LOGIC_VECTOR(1 DOWNTO 0); -- For storing btn at clk[i-1] & clk[i]
    SIGNAL ctr_reset: STD_LOGIC := '0';             -- For resetting ctr
    SIGNAL ctr: STD_LOGIC_VECTOR(ctr_bitlen DOWNTO 0) := (OTHERS => '0'); -- Initialize ctr to 0
BEGIN
    -- Reset counter if btn[clk-1] != btn[clk]
    ctr_reset = flipflops(1) XOR flipflops(0);

    compare_signal: PROCESS(clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            flipflops(0) <= btn;
            flipflops(1) <= flipflops(0);
            IF ctr_reset='1' THEN               -- Stored signals different, reset
                ctr <= (OTHERS => '0');
            ELSIF(ctr(ctr_bitlen)='0') THEN     -- Not at termination cond. yet
                ctr = ctr + 1;
            ELSE
                dbcd_res <= flipflops(1);
            END IF;
        END IF;
    END PROCESS compare_signals;
END ARCHITECTURE debounce;
