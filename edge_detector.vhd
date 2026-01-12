library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
port 
	( 
		clk			: in std_logic;			-- clk 50 MHz (20 nsec period)
		reset		: in std_logic;			-- asynchronous active low reset						
		strobe 		: in std_logic;			-- input for which rising edge to be detected
		p1			: out std_logic
	);
end edge_detector;


architecture  moore_arch  of  edge_detector  is 

	type state_type is (zero, edge, one);
	signal state_reg, state_next : state_type;
	
begin

	-- state registers
	process(clk, reset)   
	begin
		if (reset = '0') then	  
			state_reg <= zero;		 		 
		elsif rising_edge(clk) then
			state_reg <= state_next;
		end if;
	end process;
	
	-- next-state logic	
	process(state_reg, strobe)
	begin
		case state_reg is
			when zero =>
				if(strobe = '1') then
				   state_next <= edge;
				else
				   state_next <= zero;
				end if;						
			when edge =>
				if(strobe = '1') then
				   state_next <= one;
				else
				   state_next <= zero;
				end if;			
			when one =>
				if(strobe = '1') then
				   state_next <= one;
				else
				   state_next <= zero;
				end if;						
		end case;
	end process;
	  
	-- Moore Output logic
	p1 <= '1' when state_reg = edge else
		  '0';
		  
end moore_arch;