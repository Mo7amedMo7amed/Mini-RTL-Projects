---
---
-----
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.math_real.all;

entity tb_comparator is 
end entity;


architecture test_comp of tb_comparator is 
	signal a, b                         : std_logic_vector (7 downto 0);
	signal equal_out, not_equal_out,clk : std_logic;
	begin 
comparator: entity work.comparator(behavioral)
	     port map (a => a, b => b, equal_out => equal_out, not_equal_out => not_equal_out );

--virtual_clock: process is 
--		begin 
--	       clk <= '0' , '1' after 10 ns;
--		wait for 20 ns;
--	       end process;
--
--random : process (clk)  is 
--	variable r : real;
--	variable seed1, seed2 : integer := 99;
--          begin
--              for i in a'range loop
--               uniform(seed1, seed2, r);
--               a(i) <= '1' when r > 0.3 else '0';
--      end loop;
--
--      for i in b'range loop
--          uniform(seed1, seed2, r);
--          b(i) <= '1' when r > 0.5 else '0';
--      end loop;
--end process;
--

main: process  is 

	begin 
	  report "Starting test...." severity note;
	   a <= "00000001";
	   b <= "00000001";

	    wait for 10 ns ;
	  if (a = b)then
	  assert equal_out = '1'  report "Equality fail!" severity note ;
	  else 
	  assert not_equal_out ='1' report "NON-Equality fail!" severity note; 
	end if ;

	   a <= "00000101";
	   b <= "00000001";
	    wait for 10 ns ;
	  if (a = b)then
	  assert equal_out = '1'  report "Equality fail!" severity note ;
	  else 
	  assert not_equal_out ='1' report "NON-Equality fail!" severity note; 
	end if ;

           a <= "00000101";
	   b <= "00000101";
	    wait for 10 ns ;
	  if (a = b)then
	  assert equal_out = '1'  report "Equality fail!" severity note ;
	  else 
	  assert not_equal_out ='1' report "NON-Equality fail!" severity note; 
	end if ;

	wait;
	end process;

end architecture ;