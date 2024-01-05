----------------------------------------------------------------------------------------------------------------------------------
-- This TB uses   
-- 
----------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;


entity tb2 is 
end entity;

architecture tb2 of tb2 is 
   signal a,b,s  : std_logic_vector ( 3 downto 0); 
   signal m,cout : std_logic ;


begin 
     e2: entity work.add_sub(behavior)
     port map (
          a    => a,
	  b    => b,
          m    => m,
	  s    => s,
	  cout => cout);
pf: process is 
      file vector_r: text open read_mode is "test_vector.txt";
      file result_wr: text open write_mode is "output_result.txt";
      variable input_l, result_l : line;
      variable a_file, b_file, s_file : std_logic_vector (3 downto 0);
      variable m_file, cout_file : std_logic;
      variable pause : time;
     begin 
     report "Starting test02 !" severity note;
	while not endfile (vector_r) loop
	readline (vector_r, input_l);
	read (input_l, pause);
	read (input_l, a_file);
	read (input_l, b_file);
	read (input_l, m_file);
	
	a <= a_file; b <= b_file; m <= m_file; wait for pause;
	
	write (result_l, string'("Time is now "));
	write (result_l, now); -- current simulation time
	write (result_l, string'(" a = "));
	write (result_l,a);
	write (result_l, string'(" b = "));
	write (result_l, b);
	write (result_l, string'(" s = "));
	write (result_l, s);
	write (result_l, string'(" cout = "));
	write (result_l, cout);

	if (m = '0')then 
	write (result_l, string'("  addition.. "));
	else
	write (result_l, string'("  subtraction.."));
	end if;

	writeline (result_wr, result_l);
	end loop;

   report "End of test02" severity note;
   wait;

    end process ;

end architecture; 