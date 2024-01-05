------------------------------------------------------------------------------------------------------------
-- Date:  	1/8/2023
-- Description: This design I wrote it to be tested 
--				at landlabs on cloud d1-soc fpga
---------------------------------------------------------------------------------------------------------- 
library ieee;
use ieee.std_logic_1164.all;

entity traffic_lights is 
   -- those ports are for fpga sevn-seg, intarnal clock mapping 
   port ( HEX0, HEX1, HEX2, HEX3 : out std_logic_vector (6 downto 0);
	  CLOCK_50 : in std_logic;
	  LEDR : out std_logic_vector (9 downto 0));
	 -- SW  : in std_logic_vector (9 downto 0)
      --    );
end entity;


architecture rtl of traffic_lights is 
	-- Defining the enum type which hold the traffic states, also defining the messages to display on the 7seg
	  -- he selects 2d array the rows accessed by the enum light_type and columns accessed by specified number
		-- 
type light_type is (red,red_yellow, yellow, green, green_blinking );
type message  is array (light_type, 3 downto 0)of std_logic_vector (6 downto 0);
constant light_messages : message := (
			("0000000","1010000","1111001","1011110"),--red
			("1010000","1111001","1101110","1111001"),--reye
			("1010000","0011100","1111100","1101110"),--ruby
			("0111101","1010000","1111001","1111001"),--gree
			("0111101","1010000","1111100","0000110") --grbl
);
		-- ---
signal light : light_type := red;
signal clock_2 : std_logic := '0';

begin
HEX3 <= NOT light_messages (light,3);
HEX2 <= NOT light_messages (light,2); 
HEX1 <= NOT light_messages (light,1);
HEX0 <= NOT light_messages (light,0);
LEDR(0) <= clock_2;

clk_div: process (CLOCK_50) is 
	  variable count : integer :=0;
	  begin 
	    if (rising_edge(CLOCK_50)) then
	     if (count > 100_000_000) then
		clock_2 <= not clock_2;
		count := 0;
	     else 
		count := count +1;
	     end if;
	    end if;
	end process;

FSM: process (clock_2) is
	variable elapsed : integer :=0;
	begin
	  if rising_edge (clock_2) then
	     elapsed := elapsed +1;
		case (light) is  
	     when	red  => light <= red_yellow; 
		 when red_yellow =>   light <= yellow;
		 when green =>    light <= green_blinking;
		 when yellow => light <= green;
		 when others => null;
	    end case;
	  end if;  
     end process;


end architecture ;