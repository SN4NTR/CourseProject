LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE project_package IS
    CONSTANT N : NATURAL := 4;
    TYPE int_array IS ARRAY(NATURAL RANGE <>) OF INTEGER;
    TYPE std_logic_array IS ARRAY(NATURAL RANGE <>) OF std_logic;
END project_package;