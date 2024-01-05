---
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fsm_mealy is 
end entity;


architecture test_fsm_mealy of tb_fsm_mealy is 
   signal clk, reset, x,y   : std_logic;
   
 begin 
 fsm_mealy:  entity work.fsm(mealy_2p)
  port map (x=>x, y=>y, clk=>clk, reset=>reset);

clk_gen: process is 
         begin
	  clk <= '0' , '1' after 10 ns;
	  wait for 20 ns;
         end process;

main: process is 
	begin
	x    <= '0';
	reset <= '1';
        wait until (falling_edge (clk));
	reset <= '0';
	wait until (rising_edge (clk));
	x <= '1';
	wait for 10 ns;
	wait until (falling_edge(clk));
	x <= '0';		       
	
	wait until (falling_edge(clk));
	x <= '1';	
	
      wait until (falling_edge(clk));
	x <= '1';	

      end process;
end architecture;