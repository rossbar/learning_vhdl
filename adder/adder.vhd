ENTITY adder IS
    PORT( a: IN BIT;    -- First bit to add
          b: IN BIT;    -- Second bit for add
          cin: IN BIT;  -- Carry-in bit
          co: OUT BIT;  -- Carry-out bit
          sum: OUT BIT); -- Sum
END ENTITY adder;
-------------------------------------------------------------------------------
ARCHITECTURE addition OF adder IS
BEGIN
    sum <= a XOR b XOR cin;
    co <= (a AND b) OR (a AND cin) OR (b AND cin);
END ARCHITECTURE addition;
