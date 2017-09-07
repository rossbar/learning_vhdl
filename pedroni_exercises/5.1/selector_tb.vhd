LIBRARY ieee;
USE ieee.std_logic_1164.all;

--  A testbench has no ports.
entity selector_tb is
end selector_tb;

architecture behav of selector_tb is
   --  Declaration of the component that will be instantiated.
   component ckt
     port (x: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
           y: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
   end component;

   --  Specifies which entity is bound with the component.
   for ckt_0: ckt use entity work.ckt;
   signal x : STD_LOGIC_VECTOR(2 DOWNTO 0);
   signal y : STD_LOGIC_VECTOR(1 DOWNTO 0);
begin
   --  Component instantiation.
   ckt_0: ckt port map (x => x, y => y);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs of the ckt.
         x : STD_LOGIC_VECTOR(2 DOWNTO 0);
         --  The expected outputs of the ckt
         y : STD_LOGIC_VECTOR(1 DOWNTO 0);
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (("000", "01"),
         ("001", "01"),
         ("010", "--"),
         ("011", "--"),
         ("100", "00"),
         ("101", "00"),
         ("110", "--"),
         ("111", "10"));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         x <= patterns(i).x;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert y = patterns(i).y
            report "bad y value" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end behav;

