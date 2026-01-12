
library ieee;
use ieee.std_logic_1164.all;

entity en_gen is

 port 
 ( 
		clk				: in std_logic;		-- 50 MHz Clk
		reset			 	: in std_logic;		-- when s/w is pressed, 'reset' will be pulled to '0'
		en_in				: in std_logic;
		en_out			: out std_logic
 );

end en_gen;

architecture en_gen of en_gen is

   type state_type is (idle, start);
   signal state_reg, state_next: state_type;
   signal en_reg, en_next: std_logic;
   
begin	
		
-- FSMD state and data registers
	
	process( clk, reset )
	begin
		if(reset = '0') then		
			state_reg <= idle;
			en_reg <= '0';
		elsif rising_edge(clk) then
			state_reg <= state_next;
			en_reg <= en_next;
		end if;		
	end process;
	
-- next state logic & data path functional units/routing
	
	process( state_reg, en_in )
	
	begin

		state_next <= state_reg;
		en_next <= en_reg;
		
		case state_reg is
		
			when idle => 
			
				if(en_in = '1') then				
					state_next <= start;
					en_next <= '1';					
				end if;
				
			when start =>
			
				en_next <= '0';
				
				if(en_in = '0') then
					state_next <= idle;
				else
					state_next <= start;
				end if;
				
			when others =>
			
				state_next <= idle;	 
		
		end case;

	end process;
				
-- Output logic

	en_out <= en_reg;
	
end en_gen;
	