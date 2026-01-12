library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity goPulse_gen is
	port 
		( 
			clk					: in std_logic;			-- clk 50 MHz (20 nsec period)
			reset					: in std_logic;			-- asynchronous active low reset						
			strobe	 			: in std_logic;			-- trigger input to start sending goPulses 
			delayWidth			: in std_logic_vector(15 downto 0);
			pulseOnWidth		: in std_logic_vector(15 downto 0);
			pulseOffWidth		: in std_logic_vector(15 downto 0);
			noOfpulses			: in std_logic_vector(15 downto 0);
			goPulseOut			: out std_logic;
			work_done			: out std_logic
		);
end goPulse_gen;


architecture arc_goPulse_gen of goPulse_gen is

component edge_detector is
port 
	( 
		clk			: in std_logic;			-- clk 50 MHz (20 nsec period)
		reset		: in std_logic;			-- asynchronous active low reset						
		strobe 		: in std_logic;			-- input for which rising edge to be detected
		p1			: out std_logic
	);
end component;

	type state_type is (idle, sdelayWidth, spulseOnWidth, spulseOffWidth);
	signal state_reg, state_next : state_type;
	
	signal delayWidth_reg, delayWidth_next			: std_logic_vector(15 downto 0);
	signal pulseOnWidth_reg, pulseOnWidth_next	: std_logic_vector(15 downto 0);
	signal pulseOffWidth_reg, pulseOffWidth_next	: std_logic_vector(15 downto 0);
	signal noOfpulses_reg, noOfpulses_next			: std_logic_vector(15 downto 0);
	signal goPulseOut_reg, goPulseOut_next 		: std_logic;
	signal strobe_edge									: std_logic;
	signal work_done_reg, work_done_next			: std_logic;

begin

	-- port map
	 A: edge_detector
	 port map
	 (
	  clk 		=> clk,
	  reset 	=> reset,
	  strobe	=> strobe,
	  p1		=> strobe_edge
	 );
		
	-- state & data registers
	process(clk, reset)   
	begin
		if (reset = '0') then	  
			state_reg <= idle;
			delayWidth_reg <= (others =>'0');
			pulseOnWidth_reg <= (others =>'0');
			pulseOffWidth_reg <= (others =>'0');
			noOfpulses_reg <= (others =>'0');
			goPulseOut_reg <= '0';
			work_done_reg <= '0';
		elsif rising_edge(clk) then
			state_reg <= state_next;
			delayWidth_reg <= delayWidth_next;
			pulseOnWidth_reg <= pulseOnWidth_next;
			pulseOffWidth_reg <= pulseOffWidth_next;
			noOfpulses_reg <= noOfpulses_next;
			goPulseOut_reg <= goPulseOut_next;	
			work_done_reg <= work_done_next;					
		end if;
	end process;

	-- next state logic & data path functional units/routing
	process(state_reg, delayWidth, pulseOnWidth, pulseOffWidth, noOfpulses, strobe_edge,
			delayWidth_reg, pulseOnWidth_reg, pulseOffWidth_reg, noOfpulses_reg, goPulseOut_reg,work_done_reg)
	begin
		-- default values...	
		state_next <= state_reg;		 
		delayWidth_next <= delayWidth_reg;
		pulseOnWidth_next <= pulseOnWidth_reg;
		pulseOffWidth_next <= pulseOffWidth_reg;
		noOfpulses_next <= noOfpulses_reg;
		goPulseOut_next <= goPulseOut_reg;
		work_done_next <= work_done_reg;
		 
			case state_reg is
				when idle =>
					if(strobe_edge = '1') then
						if(noOfpulses = x"0000") then
							state_next <= idle;
						else
						   state_next <= sdelayWidth;
						end if;					   
					end if;
					delayWidth_next <= (others =>'0');
					pulseOnWidth_next <= (others =>'0');
					pulseOffWidth_next <= (others =>'0');
					noOfpulses_next <= (others =>'0');
					goPulseOut_next <= '0';
					work_done_next <= '0';
				
				when sdelayWidth =>
					if(delayWidth_reg = (delayWidth)) then
						goPulseOut_next <= '1';
						delayWidth_next <= (others =>'0');
						state_next <= spulseOnWidth;
					else
						delayWidth_next <= delayWidth_reg + 1;
					end if;
					
				when spulseOnWidth =>
					if(pulseOnWidth_reg = (pulseOnWidth)) then
					   goPulseOut_next <= '0';
					   pulseOnWidth_next <= (others =>'0');
					   noOfpulses_next <= noOfpulses_reg + 1;
					   state_next <= spulseOffWidth;
					else
					   pulseOnWidth_next <= pulseOnWidth_reg + 1;
					end if;	

				when spulseOffWidth =>
					if(pulseOffWidth_reg = (pulseOffWidth)) then
					    pulseOffWidth_next <= (others =>'0');
					    if(noOfpulses_reg = noOfpulses) then
						  state_next <= idle;
						  work_done_next <= '1';
					    else
						  state_next <= spulseOnWidth;
						  goPulseOut_next <= '1';						  
						end if;
					else
					   pulseOffWidth_next <= pulseOffWidth_reg + 1;
					end if;
					
				when others => 		
					state_next <= idle;
				
			end case;
	end process;
	  
	-- Output logic
	goPulseOut <= goPulseOut_reg;
	work_done <= work_done_reg;

end arc_goPulse_gen;

