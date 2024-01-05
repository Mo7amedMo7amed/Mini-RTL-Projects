---------------------------------------
--
---
------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;
USE WORK.pack_a.ALL;

entity alu_tb is 
end entity;


architecture test_alu of alu_tb is 
	signal a, b, c : signed (3 downto 0);
	signal op      : op_type := add;
  begin 
alu: entity work.alu(alu)
	port map (a => a, b => b, c => c, op => op);
	process is 

	   begin 
		wait for 10ns;
		op <= add;
		a  <= "0001";
		b  <= "0001";
		wait for 5ns;
		assert c = "0010" report "ERROR! : ADD op fail.." severity note;

		wait for 10ns;
		op <= sub;
		a  <= "0001";
		b  <= "0001";
		wait for 5ns;
		assert c = "0000" report "ERROR! : SUB op fail.." severity note;

		wait for 10ns;
		op <= mul;
		a  <= "0001";
		b  <= "0001";
		wait for 5ns;
		assert c = "0001" report "ERROR! : MUL op fail.." severity note;

		wait for 10ns;
		op <= div;
		a  <= "0001";
		b  <= "0001";
		wait for 5ns;
		assert c = "0001" report "ERROR! : DIV op fail" severity note;

		wait for 10ns;
		op <= add;   --- Test adding 7+7 which equal -2 not 14
		a  <= "0111";
		b  <= "0111";
		wait for 5ns;
		assert c = "1110" report "ERROR! : ADD op fail.." severity note;

		wait for 10ns;
		op <= sub;
		a  <= "0001";
		b  <= "0001";
		wait for 5ns;
		assert c = "0000" report "ERROR! : SUB op fail.." severity note;

		wait for 10ns;
		op <= mul;
		a  <= "0111";
		b  <= "0111";
		wait for 5ns;
		assert c = "0000" report "ERROR! : MUL op fail.." severity note;

		wait for 10ns;
		op <= div;
		a  <= "1000";
		b  <= "0011";
		wait for 5ns;
		assert c = "0010" report "ERROR! : DIV op fail" severity note;
 
		

		
	end process;

end ArCHITECTURE ;