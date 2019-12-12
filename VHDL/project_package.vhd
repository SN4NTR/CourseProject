LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE project_package IS
    CONSTANT N : NATURAL := 4;
    TYPE int_array IS ARRAY(NATURAL RANGE 0 TO N - 1) OF INTEGER RANGE 0 TO 3;
END project_package;