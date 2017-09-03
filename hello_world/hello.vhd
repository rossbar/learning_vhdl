-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.all;
-------------------------------------------------------------------------------
ENTITY hello_world IS
END ENTITY hello_world;
-------------------------------------------------------------------------------
ARCHITECTURE say_hello OF hello_world IS
BEGIN
    PROCESS
        VARIABLE l : line;
    BEGIN
        write(l, String'("Hello World!"));
        writeline(output, l);
        WAIT;
    END PROCESS;
END ARCHITECTURE say_hello;
