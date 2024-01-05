-------------------------------------------------------------------------------------
-- Date:               30/07/2023
-- Engineer:	       Mohamed Ruby
-- Description:        ITI.Lab1 designing full adder and subtractor with three favors 
--                       behavior, structural and data flow with configuration and TB 
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

entity add_sub is 
  port ( a,b   : in std_logic_vector (3 downto 0);
         m     : in std_logic;
	 ----------
         s     : out std_logic_vector (3 downto 0);
         cout  : out std_logic  );

end entity;

-------------------------------------------------------------------------
architecture behavior of add_sub is 
signal temp :  std_logic_vector (4 downto 0);
  begin 
  p1: process (all) 
       begin
       if (m='0') then   -- adder 
       temp <=  ('0' & a)+('0' & b);
       cout <= temp(4);
	s   <= temp (3 downto 0); 
	
       else           -- subtractor
       temp <= ('0' & a)-('0' & b);
       cout <= temp(4);
	s   <= temp (3 downto 0); 
	 end if ;
  end process;
end architecture; --- behavior 

-------------------------------------------------------------------------------
architecture struct of add_sub is 
signal temp1 : std_logic_vector (3 downto 0);
begin 
p2: process (all) 
	begin
	 if (m = '1')then
	   s      <= (a xor b) ;
	   temp1  <= ((not a)and b ) or not((a xor b));
	   cout   <= temp1(0);
	 else 
	   s      <= (a xor b) ;
	   temp1  <= ( a and b ) or (a xor b);
	   cout   <= temp1(0);
	 end if ;
    end process;
end architecture; -- struct

--------------------------------------------------------------------------------
architecture dataflow of add_sub is 
signal temp2 : std_logic_vector(3 downto 0);
begin 
s      <= (a xor b) ;
temp2  <= ((not a)and b ) or not((a xor b)) when m = '1' else ( a and b ) or (a xor b);
cout   <= temp2(0);
end architecture ; -- data flow