LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.project_package.ALL;

ENTITY multiplier IS
	PORT (
		rg1, rg2 : IN std_logic_vector (0 TO N - 1);
		result : OUT std_logic_vector (0 TO (N * 2) - 1));
END multiplier;

ARCHITECTURE mult_function_beh OF multiplier IS

	FUNCTION fill_array_with_zeros(arr : int_array) RETURN int_array IS
		VARIABLE arr_with_zeros : int_array;
	BEGIN
		FOR i IN 0 TO arr'length - 1 LOOP
			arr_with_zeros(i) := 0;
		END LOOP;

		RETURN arr_with_zeros;
	END FUNCTION;

	FUNCTION std_logic_to_integer(arr : std_logic_vector(0 TO N - 1)) RETURN int_array IS
		VARIABLE arr_to_integer : int_array;
	BEGIN
		FOR i IN 0 TO arr'length - 1 LOOP
			IF (arr(i) = '1') THEN
				arr_to_integer(i) := 1;
			ELSE
				arr_to_integer(i) := 0;
			END IF;
		END LOOP;

		RETURN arr_to_integer;
	END FUNCTION;

	FUNCTION integer_to_std_logic(arr1, arr2 : int_array) RETURN std_logic_vector IS
		VARIABLE arr_to_std_logic : std_logic_vector(0 TO (N * 2) - 1);
	BEGIN
		FOR i IN 0 TO arr1'length - 1 LOOP
			IF (arr1(i) = 1) THEN
				arr_to_std_logic(i) := '1';
			ELSE
				arr_to_std_logic(i) := '0';
			END IF;
		END LOOP;

		FOR i IN 0 TO arr2'length - 1 LOOP
			IF (arr2(i) = 1) THEN
				arr_to_std_logic(i + N) := '1';
			ELSE
				arr_to_std_logic(i + N) := '0';
			END IF;
		END LOOP;

		RETURN arr_to_std_logic;
	END FUNCTION;

	FUNCTION multiply(rg1, rg2 : std_logic_vector(0 TO N - 1)) RETURN std_logic_vector IS
		VARIABLE rg1_copy : int_array;
		VARIABLE rg2_copy : int_array;
		VARIABLE rg3 : int_array;
		VARIABLE result : std_logic_vector (0 TO (N * 2) - 1);
		VARIABLE counter : INTEGER := N;
		VARIABLE buff : INTEGER := 0;
		VARIABLE rg3_last_element : INTEGER := 0;

	BEGIN
		rg1_copy := std_logic_to_integer(rg1);
		rg2_copy := std_logic_to_integer(rg2);
		rg3 := fill_array_with_zeros(rg3);

		WHILE counter > 0 LOOP
			IF (rg2_copy(N - 1) = 1) THEN
				FOR i IN rg3'length - 1 DOWNTO 0 LOOP
					rg3(i) := rg3(i) + rg1_copy(i);

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

			rg3_last_element := rg3(N - 1);

			FOR i IN rg3'length - 1 DOWNTO 1 LOOP
				rg3(i) := rg3(i - 1);
			END LOOP;
			rg3(0) := 0;

			FOR i IN rg2_copy'length - 1 DOWNTO 1 LOOP
				rg2_copy(i) := rg2_copy(i - 1);
			END LOOP;
			rg2_copy(0) := rg3_last_element;

			counter := counter - 1;
		END LOOP;

		result := integer_to_std_logic(rg3, rg2_copy);

		RETURN result;
	END multiply;

BEGIN
	result <= multiply(rg1, rg2);
END mult_function_beh;