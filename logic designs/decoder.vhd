---------------------------------------------------------------------------------------
-- Entity and architecture declarations for an address decoder using a CASE statement.
---------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decoder IS
  PORT( address: IN std_logic_vector(2 DOWNTO 0);
        decode: OUT std_logic_vector(7 DOWNTO 0)); 
END ENTITY decoder;

ARCHITECTURE behav OF decoder IS 
BEGIN 
  Pdec: PROCESS(address) IS 
  BEGIN 
    CASE address IS
      WHEN "001"          => decode <= X"11"; 
      WHEN "111"          => decode <= X"42"; 
      WHEN "010"          => decode <= X"44"; 
      WHEN "101" | "110"  => decode <= X"88"; 
      WHEN OTHERS         => decode <= X"00"; 
    END CASE;
  END PROCESS Pdec;
END ARCHITECTURE behav;