LIBRARY ieee;
USE ieee.std_logic_1164.all;

--  A testbench has no ports.
entity multiplexer_tb is
end multiplexer_tb;

architecture behav of multiplexer_tb is
   --  Declaration of the component that will be instantiated.
   component mux
     port (a, b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           sel: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
           x: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
   end component;

   --  Specifies which entity is bound with the component.
   for mux_0: mux use entity work.mux;
   signal a, b, x : STD_LOGIC_VECTOR(7 DOWNTO 0);
   signal sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
begin
   --  Component instantiation.
   mux_0: mux port map (a => a, b => b, sel => sel, x => x);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the mux.
         a, b : STD_LOGIC_VECTOR(7 DOWNTO 0);
         sel : STD_LOGIC_VECTOR(1 DOWNTO 0); 
         --  The expected outputs of the adder.
         x : STD_LOGIC_VECTOR(7 DOWNTO 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("00001111", "11110000", "00", "00000000"),
         ("00001111", "11110000", "01", "00001111"),
         ("00001111", "11110000", "10", "11110000"),
         ("00001111", "11110000", "11", "ZZZZZZZZ"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         sel <= patterns(i).sel;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert x = patterns(i).x
            report "bad x value" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end behav;

