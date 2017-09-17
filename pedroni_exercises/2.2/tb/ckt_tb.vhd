LIBRARY ieee;
USE ieee.std_logic_1164.all;

--  A testbench has no ports.
ENTITY ckt_tb IS
END ENTITY ckt_tb;

architecture behav of ckt_tb is
   --  Declaration of the component that will be instantiated.
   component unopt_ckt
     port (a, b, c: IN STD_LOGIC;
           z: OUT STD_LOGIC);
   end component;

   --  Specifies which entity is bound with the component.
   for ckt_0: unopt_ckt use entity work.ckt;
   SIGNAL a, b, c, z: STD_LOGIC;
begin
   --  Component instantiation.
   ckt_0: unopt_ckt PORT MAP (a, b, c, z);

   --  This process does the real job.
   process
      type pattern_type is record
         --  The inputs to the ckt.
         a, b, c: STD_LOGIC; 
         --  The expected outputs of ckt;
         z : STD_LOGIC;
      end record;
      --  The patterns to apply.
      type pattern_array is array (natural range <>) of pattern_type;
      constant patterns : pattern_array :=
        (('1', '1', '1', '0'),
         ('1', '1', '0', '1'),
         ('1', '0', '1', '0'),
         ('1', '0', '0', '0'),
         ('0', '1', '1', '1'),
         ('0', '1', '0', '1'),
         ('0', '0', '1', '1'),
         ('0', '0', '0', '1'));
   begin
      --  Check each pattern.
      for i in patterns'range loop
         --  Set the inputs.
         a <= patterns(i).a;
         b <= patterns(i).b;
         c <= patterns(i).c;
         z <= patterns(i).z;
         --  Wait for the results.
         wait for 1 ns;
         --  Check the outputs.
         assert ckt_0(a, b, c) = z;
            report "bad x value" severity error;
      end loop;
      assert false report "end of test" severity note;
      --  Wait forever; this will finish the simulation.
      wait;
   end process;
end behav;