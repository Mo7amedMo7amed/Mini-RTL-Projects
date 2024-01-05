-------------------------------------------------------------------------------------
--Date:  		03/08/2023
-- Description:		This TB is for ITI VHDL lab2 
-----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;
entity decoder_tb is  
end entity;


architecture test of decoder_tb is 
	signal       address      :  std_logic_vector (2 downto 0);
	signal       decode       :  std_logic_vector (7 downto 0);
  begin 
     decoder: entity work.decoder(behav)
	port map (
		  address => address  , decode => decode);	
test: process is 
		
		begin
		wait for 20ns;

		    address <= "001";
			wait for 10 ns;
		assert  decode = x"11"  report "Error! decoding 11 at address 001 "  severity note;		
		wait for 20ns;

		   address <= "111";
			wait for 10ns;
		assert  decode = x"42"  report "Error! decoding 42 at address 111 " severity note;		
		wait for 20ns;

		   address <= "010";
			wait for 10 ns;
		assert  decode = x"44"  report "Error! decoding  44 at address 010" severity note;		
		wait for 20ns;

		    address <= "101";
			wait for 10ns;
		assert decode = x"88" report "Error! decoding 88 at address 101 | 110 " severity note;		
		wait for 20ns;

		    address <= "000";
			wait for 10 ns;
		assert decode = x"00"  report "Error! decoding 00 at address dont care "  severity note;		
		wait ;


	     end process;





end architecture ; 