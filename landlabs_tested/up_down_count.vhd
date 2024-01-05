--------------------------------------------------------------------------------------------------------------------------------------
-- Date: 		2/08/2023
-- Description :        Design a counter display its value in 7seg and has reset, load, increment and decrement 
--			get the inputs using universal shift register, use ROM and RAM to store binary to decimal values
--			here I am using natural and mod which could be unsynth
-----------------------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity up_down_count is 
	port (
		SW 			: in std_logic_vector (9 downto 0);  --- SW(0)-> load active, SW(others) load new value into reg
		KEY 			: in std_logic_vector (3 downto 0); -- KEY(0) reset, KEY(1) increment, KEY(2) decrement   
		CLOCK_50 		: in std_logic ;
		--------
		HEX0,HEX1,HEX2,HEX3   	: out std_logic_vector (6 downto 0);
		LEDR		      	: out std_logic_vector (9 downto 0)
		

);

end entity ;

architecture rtl of up_down_count is 
  signal clk2 		: std_logic; --- this is the clk which the counter operate on 
  signal counter 	: std_logic_vector (3 downto 0) :="0000";
  signal seg_out 	: std_logic_vector (6 downto 0);
  begin 
  LEDR(0) <= clk2;         --- toggling led for indicating the counter clock
  HEX0    <= not seg_out;
  HEX1    <= not seg_out;
  HEX2    <= not seg_out;
  HEX3    <= not seg_out;
count   : process (clk2,KEY(0),KEY(1),KEY(2),SW(0)) is 
	     VARIABLE count_reg: std_logic_vector (3 downto 0) :="0000";
	    begin 
	     if (rising_edge (clk2)) then
                counter <= count_reg ;
		if (KEY(0) = '1')then 
		   count_reg := "0000";
		elsif (KEY(1)= '1') then 
		   count_reg := (count_reg +"0001") ;
		elsif (KEY(2)= '1') then 
		   count_reg := (count_reg -"0001") ;
		end if;
		if count_reg = "1010" then 
		      count_reg := "0000";
		else count_reg := (count_reg +"0001") ;
		end if;
	     end if ;
	  end process;   

sev_seg : process(counter)
	begin	
		case counter is
			when x"0" => seg_out <= "0111111";	-- 0
			when x"1" => seg_out <= "0000011";	-- 1
			when x"2" => seg_out <= "1011011";	-- 2
			when x"3" => seg_out <= "1001111";	-- 3
			when x"4" => seg_out <= "1100110";	-- 4
			when x"5" => seg_out <= "1101101";	-- 5
			when x"6" => seg_out <= "1111101";	-- 6
			when x"7" => seg_out <= "0000111";	-- 7
			when x"8" => seg_out <= "1111111";	-- 8
			when x"9" => seg_out <= "1101111";	-- 9
			when x"A" => seg_out <= "0111111";	-- 0
			when others =>
				seg_out <= (others => 'X');
		end case;
    end process;

clk_div : process (CLOCK_50) is 
	   variable count : integer :=0;
	   begin 
	      if (rising_edge(CLOCK_50)) then 
		if (count = 100_000_000) then
		   clk2 <= not clk2;
                   count := 0;
		else count := count +1; 
		end if ;
	      end if;
	  end process;     

end architecture ; 