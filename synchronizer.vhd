-- This module Synchronizes the incoming Asynchronous signal also...
-- removes any glitches in the signal which is picked up during the path of travel. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synchronizer is 
port 
(     
	clk 		: in std_logic;		-- 50 MHz Clk
	rst 		: in std_logic;		-- when s/w is pressed, 'rst' will be pulled to '0'
	in_async	: in std_logic;	
	out_sync	: out std_logic     
);
end synchronizer;

architecture synchronizer of synchronizer is
   
   signal r_reg, r_next: unsigned(2 downto 0); 	-- Shift register
   signal sync_reg, sync_next: std_logic;		-- Output Buffer
   
begin

   -- shift register and output Buffer
   process(clk,rst)
   begin
      if(rst = '0') then 
         r_reg <= (others=>'0');
         sync_reg <= '0';
      elsif rising_edge(clk) then
         r_reg <= r_next;
         sync_reg <= sync_next;
      end if;
   end process;
   
   -- next-state logic
   r_next <= r_reg(1 downto 0) & in_async;
   
   sync_next <= '1' when r_reg = "111" else
				'0' when r_reg = "000" else
				sync_reg;

   -- Output logic
   out_sync <= sync_reg;
   
end synchronizer;



---- Component declaration

--component synchronizer is 
--port 
--(     
--	clk 		: in std_logic;		
--	rst 		: in std_logic;		
--	in_async	: in std_logic;	
--	out_sync	: out std_logic    
--);
--end component synchronizer;


---- Component Instantiation

-- A : synchronizer
--	 port map
--	 (
--	  clk 		=> clk,
--	  rst 		=> rst,
--	  in_async	=> in_async,
--	  out_sync	=> out_sync
--	 );