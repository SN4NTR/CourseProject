LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.project_package.ALL;

ENTITY mult_function IS
	GENERIC (N : NATURAL := 4);
	PORT (
		rg1, rg2 : IN std_logic_array (0 TO N - 1);
		result : OUT std_logic_array (0 TO (N * 2) - 1));
END mult_function;

ARCHITECTURE mult_function_beh OF mult_function IS

	FUNCTION multiply(rg1, rg2 : std_logic_array(0 TO N - 1)) RETURN std_logic_array IS
		VARIABLE rg1Copy : int_array (0 TO N - 1);
		VARIABLE rg2Copy : int_array (0 TO N - 1);
		VARIABLE rg3 : int_array (0 TO N - 1);
		VARIABLE result : std_logic_array (0 TO (N * 2) - 1);
		VARIABLE counter : INTEGER := N;
		VARIABLE buff : INTEGER := 0;
		VARIABLE rg3LastElement : INTEGER := 0;

	BEGIN

		FOR i IN 0 TO N - 1 LOOP
			IF (rg1(i) = '1') THEN
				rg1Copy(i) := 1;
			ELSE
				rg1Copy(i) := 0;
			END IF;

			IF (rg2(i) = '1') THEN
				rg2Copy(i) := 1;
			ELSE
				rg2Copy(i) := 0;
			END IF;

			rg3(i) := 0;
		END LOOP;

		WHILE counter > 0 LOOP
			IF (rg2Copy(N - 1) = 1) THEN
				FOR i IN rg3'length - 1 DOWNTO 0 LOOP
					rg3(i) := rg3(i) + rg1Copy(i);

					IF (buff /= 0) THEN
						rg3(i) := rg3(i) + buff;
						buff := buff - 1;
					END IF;
					IF (rg3(i) > 1) THEN
						buff := buff + 1;
						rg3(i) := rg3(i) - (buff + 1);
					END IF;
				END LOOP;
			END IF;

			rg3LastElement := rg3(N - 1);

			FOR i IN rg3'length - 1 DOWNTO 1 LOOP
				rg3(i) := rg3(i - 1);
			END LOOP;
			rg3(0) := 0;

			FOR i IN rg2Copy'length - 1 DOWNTO 1 LOOP
				rg2Copy(i) := rg2Copy(i - 1);
			END LOOP;
			rg2Copy(0) := rg3LastElement;

			counter := counter - 1;
		END LOOP;

		FOR i IN 0 TO rg3'length - 1 LOOP
			IF (rg3(i) = 1) THEN
				result(i) := '1';
			ELSE
				result(i) := '0';
			END IF;
		END LOOP;
		FOR i IN 0 TO rg2'length - 1 LOOP
			IF (rg2Copy(i) = 1) THEN
				result(i + N) := '1';
			ELSE
				result(i + N) := '0';
			END IF;
		END LOOP;

		RETURN result;
	END multiply;

BEGIN
	result <= multiply(rg1, rg2);
END mult_function_beh;