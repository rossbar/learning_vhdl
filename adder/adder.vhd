ENTITY adder IS
    PORT( i0: IN BIT;    -- First bit to add
          i1: IN BIT;    -- Second bit for add
          ci: IN BIT;  -- Carry-in bit
          co: OUT BIT;  -- Carry-out bit
          s: OUT BIT); -- Sum
END ENTITY adder;
-------------------------------------------------------------------------------
ARCHITECTURE addition OF adder IS
BEGIN
    s <= i0 XOR i1 XOR ci;
    co <= (i0 AND i1) OR (i0 AND ci) OR (i1 AND ci);
END ARCHITECTURE addition;
