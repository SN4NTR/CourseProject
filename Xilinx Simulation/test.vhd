LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.project_package.ALL;

ENTITY test_mult IS
END test_mult;

ARCHITECTURE test_beh OF test_mult IS
	COMPONENT mult_function IS
		GENERIC (N : NATURAL := 4);
		PORT (
			rg1, rg2 : IN std_logic_array (0 TO N - 1);
			result : OUT std_logic_array (0 TO (N * 2) - 1));
	END COMPONENT;

	SIGNAL rg1, rg2 : std_logic_array (0 TO N - 1);
	SIGNAL result : std_logic_array (0 TO (N * 2) - 1);

BEGIN

	mult_func_call : mult_function GENERIC MAP(N => N)
	PORT MAP(rg1 => rg1, rg2 => rg2, result => result);

	rg1(0) <= '0', '0' AFTER 50 ns, '0' AFTER 100 ns;
	rg1(1) <= '1', '0' AFTER 50 ns, '1' AFTER 100 ns;
	rg1(2) <= '1', '1' AFTER 50 ns, '0' AFTER 100 ns;
	rg1(3) <= '1', '1' AFTER 50 ns, '0' AFTER 100 ns;

	rg2(0) <= '0', '0' AFTER 50 ns, '0' AFTER 100 ns;
	rg2(1) <= '1', '1' AFTER 50 ns, '1' AFTER 100 ns;
	rg2(2) <= '0', '0' AFTER 50 ns, '1' AFTER 100 ns;
	rg2(3) <= '1', '0' AFTER 50 ns, '1' AFTER 100 ns;

END test_beh;