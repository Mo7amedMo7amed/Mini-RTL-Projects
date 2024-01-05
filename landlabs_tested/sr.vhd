----------------------------------------------------------------------------------------------------------------------
--
--
----------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sr is 
port(	SW           : in  std_logic_vector (9 downto 0); -- SW(0) reset, sw(1) load 
    	KEY	         : in  std_logic_vector (3 downto 0);  -- key(0) shift left, key(1) shift right
    	LEDR	     : out std_logic_vector (9 downto 0);
    	CLOCK_50     : in  std_logic;
    	HEX0, HEX1   : out std_logic_vector (6 downto 0));
attribute mark_debug : string ; --- for activating ILA
attribute mark_debug of SW : signal is "true";  -- debuging temp by ILA: attribute mark_debug of <signal>: signal "true";
end entity;


architecture rtl of sr is 
     signal temp : std_logic_vector (7 downto 0);
     signal seg_out0, seg_out1 : std_logic_vector (6 downto 0);	
     signal toseg0, toseg1: std_logic_vector (3 downto 0);
     signal clk2 : std_logic;
  begin
    HEX0   <= seg_out1;
    HEX1   <= seg_out0;
    LEDR(9 downto 1)   <=SW(8 downto 0);
    LEDR(0) <= CLK2;
    toseg0 <= temp(7 downto 4);
    toseg1 <= temp(3 downto 0);
--  sr:  for i in 8 downto 1 generate     -- build the shift register
--          temp (i) <= temp (i-1);
--       end generate sr;
   process (clk2,SW(0)) is        -- SW(0) reset signal , SW(1) load enable signal
	  
     begin 
      if (rising_edge (clk2)) then
	if (SW(0) = '1') then	     -- reset active high
	   temp <= (others =>'0');
	    if (SW(1) = '1')then    -- load signal enabled
	      temp <= SW(9 downto 2);
	    else 
		if (KEY(0) = '1') then -- shift left
		    temp  <= SW(2) & temp (7 downto 1);
		elsif (KEY(1) = '1') then -- shift right 
		    temp  <= temp (6 downto 0) & SW(2);
		end if;
	    end if ;
	end if ;
      end if ;
end process;
      ----------------------------------------------------------------------------------------------------------------------
      ----------------------------------------------------------------------------------------------------------------------
      ----------------------------------------------------------------------------------
	--   the following processes is for decoding the 4-bit outputs to 7-bit using LUT for 7-segment display
process (toseg0) is
begin
		case toseg0 is
			when x"0" => seg_out0 <= "0111111";	-- 0
			when x"1" => seg_out0 <= "0000110";	-- 1
			when x"2" => seg_out0 <= "1011011";	-- 2
			when x"3" => seg_out0 <= "1001111";	-- 3
			when x"4" => seg_out0 <= "1100110";	-- 4
			when x"5" => seg_out0 <= "1101101";	-- 5
			when x"6" => seg_out0 <= "1111101";	-- 6
			when x"7" => seg_out0 <= "0000111";	-- 7
			when x"8" => seg_out0 <= "1111111";	-- 8
			when x"9" => seg_out0 <= "1101111";	-- 9
			when x"A" => seg_out0 <= "0111111";	-- 0
			when others =>
				seg_out0 <= (others => 'X');
		end case;
  end process;  
process (toseg1)is 
begin
		case toseg1 is
			when x"0" => seg_out1 <= "0111111";	-- 0
			when x"1" => seg_out1 <= "0000110";	-- 1
			when x"2" => seg_out1 <= "1011011";	-- 2
			when x"3" => seg_out1 <= "1001111";	-- 3
			when x"4" => seg_out1 <= "1100110";	-- 4
			when x"5" => seg_out1 <= "1101101";	-- 5
			when x"6" => seg_out1 <= "1111101";	-- 6
			when x"7" => seg_out1 <= "0000111";	-- 7
			when x"8" => seg_out1 <= "1111111";	-- 8
			when x"9" => seg_out1 <= "1101111";	-- 9
			when x"A" => seg_out1 <= "0111111";	-- 0
			when others =>
				seg_out1 <= (others => 'X');
		end case;

end process;
 process (CLOCK_50) is
 variable count : integer := 0;
 begin
 if (rising_edge(CLOCK_50)) then
    if (count = 25_000_000) then 
         count := 0;
         clk2 <= not clk2;
     else 
         count := count +1;
 end if;
 end if ;
 
 
 end process;

end architecture ;