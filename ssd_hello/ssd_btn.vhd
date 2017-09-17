LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
USE work.my_ssd_driver.all;
-- DEBOUNCER COMPONENT
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

-- MAIN
-------------------------------------------------------------------------------
ENTITY ssd_btn IS
    PORT(sysclk: IN STD_LOGIC;
         btn: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         ssd: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY ssd_btn;
-------------------------------------------------------------------------------
ARCHITECTURE show_all OF ssd_btn IS
    SHARED VARIABLE value: INTEGER RANGE 0 TO 9 := 0;
    SIGNAL debounced_buttons: STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL last_button_state : STD_LOGIC := '0';
    COMPONENT debouncer IS
        PORT(clk, btn: IN STD_LOGIC; dbcd_res: OUT STD_LOGIC);
    END COMPONENT debouncer;
BEGIN
    -- Debounced button signals
    dbcd_btn_0: debouncer PORT MAP (sysclk, btn(0), debounced_buttons(0));
    dbcd_btn_1: debouncer PORT MAP (sysclk, btn(1), debounced_buttons(1));
    button_process: PROCESS (sysclk)
    BEGIN
        IF (rising_edge(sysclk)) THEN
            IF (debounced_buttons(1)='1' AND last_button_state='0') THEN
                IF (value=9) THEN
                    value := 0;
                ELSE
                    value := value + 1;
                END IF;
            ELSIF (debounced_buttons(0)='1' AND last_button_state='0') THEN
                IF (value=0) THEN
                    value := 9;
                ELSE
                    value := value - 1;
                END IF;
            END IF;
            last_button_state <= (debounced_buttons(0) OR debounced_buttons(1));
        END IF;
    END PROCESS button_process;
    -- Convert to TTL signal for SSD
    ssd <= val_to_ssd_signal(value);
END ARCHITECTURE show_all;
