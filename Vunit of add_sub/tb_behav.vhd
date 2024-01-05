----------------------------------------------------------------------------------------------------------------------------------
-- This TB uses uniform random function from ieee library to generate random stimulus and uses assert satements to check results...   
-- 
----------------------------------------------------------------------------------------------------------------------------------
library IEEE;
library vunit_lib;
context vunit_lib.vunit_context;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.std_logic_signed.all;


entity tb_vunit is 
	generic (runner_cfg: string); -- used to assign this entity to vunit tb
end entity;

architecture tb_vunit of tb_vunit is 
   signal a,b,s  : std_logic_vector ( 3 downto 0); 
   signal m,cout : std_logic ;
  
--  procedure random (signal a,b : inout std_logic_vector)is      --- defined procedure to convert the output of uniform function								
--        variable r : real;					   -- from real to std_logic_vector 
--        variable seed1, seed2 : integer := 99;
--
--	begin
--	 for i in a'range loop
--          uniform(seed1, seed2, r);
--          a(i) <= '1' when r > 0.3 else '0';
--         end loop;
--
--	 for i in b'range loop
--          uniform(seed1, seed2, r);
--          b(i) <= '1' when r > 0.5 else '0';
--	 end loop;
--         --wait for 30 ns;
--   end procedure;

begin 
     e1: entity work.add_sub(behavior)
     port map (
          a    => a,
	  b    => b,
          m    => m,
	  s    => s,
	  cout => cout 
                );
  --random (a,b);         --- give signals initial random values
process is 
    begin
       report "Starting test01 !" severity note;

	
     for i in 0 to 80 loop   --- run simulation for only 80 cycles

      if (m ='0')then        -- Use m signal as a trigger to test addition and subtraction operations 
	--random (a,b);      -- randomize only when addition occurs
        assert cout = '0' or s = a +b report "Fault addition!" severity note;
	m <= '1';
     
	else
        assert cout = '1' or s = a - b report "Fault subtraction!" severity note;
	m <= '0';
      end if;

   wait for 50 ns;
   end loop ;

report "Test01 finished!" severity note;   -- End of simulation
wait;
end process ;

--*******************************************************************************************
--- I use this process instead of the above procedure to do randomization
--- because procedure block evaluted only once at the start of the simulation 
--- and I don't know how to activate it at every simulation cycle to get new random values
--********************************************************************************************
mai : process (m)  is 
variable r : real;
variable seed1, seed2 : integer := 99;
   begin
     for i in a'range loop
          uniform(seed1, seed2, r);
          a(i) <= '1' when r > 0.3 else '0';
      end loop;

      for i in b'range loop
          uniform(seed1, seed2, r);
          b(i) <= '1' when r > 0.5 else '0';
      end loop;
end process;

--------------------------------------------------------------------
-- VUnit testbench
--
main : process 


begin 
	test_runner_setup (runner,runner_cfg);
	 while test_suite loop 
	    if  run ("zero test")then 
		  a <= "0000";
		  b <= "0000";
		  wait for 20 ns;
		  check_equal (s,cout,"Sum error");
		  --check_equal (cout,'0',"Sum error");
		end if;
	 end loop;
	test_runner_cleanup(runner) ;

end process;

end architecture ;
