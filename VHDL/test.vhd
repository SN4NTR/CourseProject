LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

LIBRARY work;
USE work.project_package.ALL;

ENTITY test_mult IS
END test_mult;

ARCHITECTURE test_beh OF test_mult IS
	COMPONENT multiplier IS
		PORT (
			rg1, rg2 : IN std_logic_vector (0 TO N - 1);
			result : OUT std_logic_vector (0 TO (N * 2) - 1));
	END COMPONENT;

	SIGNAL rg1, rg2 : std_logic_vector (0 TO N - 1);
	SIGNAL result : std_logic_vector (0 TO (N * 2) - 1);

	CONSTANT f_name : STRING := "input_data.txt";
	FILE f_source : text;

BEGIN

	mult_func_call : multiplier PORT MAP(rg1 => rg1, rg2 => rg2, result => result);

	PROCESS
		VARIABLE f_line : line;
		VARIABLE rg1_line : std_logic_vector(0 TO N - 1);
		VARIABLE rg2_line : std_logic_vector(0 TO N - 1);
		VARIABLE space_char : CHARACTER;

	BEGIN
		file_open(f_source, f_name, read_mode);

		WHILE (NOT endfile(f_source)) LOOP
			readline(f_source, f_line);
			read(f_line, rg1_line);
			read(f_line, space_char);
			read(f_line, rg2_line);

			rg1 <= rg1_line;
			rg2 <= rg2_line;

			WAIT FOR 50 ns;
		END LOOP;

		file_close(f_source);

	END PROCESS;
END test_beh;