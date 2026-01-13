-- Serial Data In (sdo) module checks for data, sent by sdi_module... 
-- The data will be received similar to uart rx module... 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sdo_module is 
port 
(     
	clk 			: in std_logic;		-- 50 MHz Clk
	rst 			: in std_logic;		-- when s/w is pressed, 'rst' will be pulled to '0'
	sdo_in			: in std_logic;
	data_reg		: out std_logic_vector(7 downto 0);	
	rx_done_tick	: out std_logic     
);
end sdo_module;

architecture sdo_module of sdo_module is

   type state_type is (idle, start, data, stop);
   signal state_reg, state_next: state_type;
   signal d_reg, d_next: unsigned(3 downto 0);			-- it is delay register. some time acts as bit duration (200ns) for 5 Mbps.
   signal n_reg, n_next: unsigned(3 downto 0);			-- to keep track of number of bits
   signal b_reg, b_next: std_logic_vector(7 downto 0); -- whatever data to be received, will be available in this.
   
begin

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
   -- fsmd state & data registers
   process(clk,rst)
   begin
      if(rst = '0') then 
         state_reg <= idle;
         d_reg <= (others=>'0');
         n_reg <= (others=>'0');
         b_reg <= (others=>'0');
      elsif rising_edge(clk) then
         state_reg <= state_next;
         d_reg <= d_next;
         n_reg <= n_next;
         b_reg <= b_next;
      end if;
   end process;
   
   -- next-state logic & data path functional units/routing
   process(state_reg, d_reg, n_reg, b_reg, sdo_in)
   begin
      state_next <= state_reg;
      d_next <= d_reg;
      n_next <= n_reg;
      b_next <= b_reg;
      rx_done_tick <='0';
	  
      case state_reg is

         when idle =>
               if sdo_in = '0' then
                  state_next <= start;
                  d_next <= (others=>'0');
               end if;
			
         when start =>
--               if d_reg = 5 then 
               if d_reg = 2 then
                  state_next <= data;
                  d_next <= (others=>'0');
                  n_next <= (others=>'0');
               else
                  d_next <= d_reg + 1;
               end if;

         when data =>
--               if d_reg = 9 then
               if d_reg = 4 then
                  d_next <= (others=>'0');
                  b_next <= sdo_in & b_reg(7 downto 1) ;
                  if n_reg = 7 then
                     state_next <= stop;
                  else
                     n_next <= n_reg + 1;
                  end if;
               else
                  d_next <= d_reg + 1;
               end if;

         when stop =>
--               if d_reg = 9 then
               if d_reg = 4 then
                  state_next <= idle;				  
				  rx_done_tick <= '1';
               else
                  d_next <= d_reg + 1;
               end if;
			   
      end case;
	  
   end process;

   -- Output logic
   data_reg <= b_reg;
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--   
end sdo_module;



---- Component declaration

--component sdo_module is 
--port 
--(     
--	clk 		: in std_logic;		
--	rst 		: in std_logic;		
--	sdo_in		: in std_logic;	
--  data_reg	: out std_logic_vector(7 downto 0);
--	rx_done_tick: out std_logic     
--);
--end component sdo_module;


---- Component Instantiation

-- A : sdo_module
--	 port map
--	 (
--	  clk 			=> clk,
--	  rst 			=> rst,
--	  sdo_in		=> sdo_in,
--	  data_out		=> data_out, 
--	  rx_done_tick	=> rx_done_tick
--	 );