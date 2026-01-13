-- 'sdi_module' transmitts data of 16 bits at the rate of 5 Mbps speed.
-- The data will be transmitted similar to uart module... i.e., 
-- start and stop bit will always be there for any data transmission.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sdi_module is 
port 
(     
	clk 			: in std_logic;		-- 50 MHz Clk
	rst 			: in std_logic;		-- when s/w is pressed, 'rst' will be pulled to '0'
	data_in			: in std_logic_vector(7 downto 0);
	fifo_rd_rqst	: out std_logic;
	tx_start		: in std_logic;
	sdi_out			: out std_logic;
	tx_done_tick 	: out std_logic
);
end sdi_module;

architecture sdi_module of sdi_module is

   type state_type is (idle, gen_fifo_rd_rqst, wt_for_fifo_data, rd_fifo, start, data, stop);
   signal state_reg, state_next: state_type;
   signal d_reg, d_next: unsigned(9 downto 0);			-- it is delay register. some time acts as bit duration (200ns) for 5 Mbps.
   signal n_reg, n_next: unsigned(3 downto 0);			-- to keep track of number of bits
   signal w_reg, w_next: std_logic_vector(7 downto 0); -- whatever data to be transmitted, will be loaded in this... word register
   signal tx_done_reg, tx_done_next: std_logic;   
   signal sdi_reg, sdi_next: std_logic;
	signal fifo_rd_rqst_reg, fifo_rd_rqst_next: std_logic;
	
	
   
begin

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
   -- fsmd state & data registers
   process(clk,rst)
   begin
      if(rst = '0') then 
         state_reg <= idle;
         d_reg <= (others=>'0');
         n_reg <= (others=>'0');
         w_reg <= (others=>'0');
		 tx_done_reg <= '0';
         sdi_reg <= '1';
			fifo_rd_rqst_reg <= '0';
      elsif rising_edge(clk) then
         state_reg <= state_next;
         d_reg <= d_next;
         n_reg <= n_next;
         w_reg <= w_next;
		 tx_done_reg <= tx_done_next;
         sdi_reg <= sdi_next;
			fifo_rd_rqst_reg <= fifo_rd_rqst_next;
      end if;
   end process;
   
   -- next-state logic & data path functional units/routing
   process(state_reg, d_reg, n_reg, w_reg, tx_done_reg, sdi_reg, tx_start, data_in)
   begin
      state_next <= state_reg;
      d_next <= d_reg;
      n_next <= n_reg;
      w_next <= w_reg;
		tx_done_next <= '0';
      sdi_next <= sdi_reg ;
		fifo_rd_rqst_next <= '0'; 
	  
      case state_reg is
	  
         when idle =>
            sdi_next <= '1';
			   if tx_start = '1' then		-- means fifo is not empty
				  state_next <= gen_fifo_rd_rqst;
				  d_next <= (others=>'0');
			   end if;
			
			when gen_fifo_rd_rqst =>
				fifo_rd_rqst_next <= '1';
				state_next <= wt_for_fifo_data;
				
			when wt_for_fifo_data =>
				state_next <= rd_fifo;
				
			when rd_fifo =>
				w_next <= data_in;
				state_next <= start;				
	
         when start =>
            sdi_next <= '0';
--               if d_reg = 9 then
               if d_reg = 4 then
                  state_next <= data;
                  d_next <= (others=>'0');
                  n_next <= (others=>'0');
               else
                  d_next <= d_reg + 1;
               end if;
		
         when data =>
            sdi_next <= w_reg(0);
--               if d_reg = 9 then
               if d_reg = 4 then
                  d_next <= (others=>'0');
                  w_next <= '0' & w_reg(7 downto 1);
                  if n_reg = 7 then
                     state_next <= stop ;
                  else
                     n_next <= n_reg + 1;
                  end if;
               else
                  d_next <= d_reg + 1;
               end if;
			
         when stop =>
            sdi_next <= '1';
--               if d_reg = 9 then
               if d_reg = 4 then
				  tx_done_next <= '1';
                  state_next <= idle;
               else
                  d_next <= d_reg + 1;
               end if;

         when others =>
            state_next <= idle;
			
      end case;
	  
   end process;
   
   sdi_out <= sdi_reg;
   tx_done_tick <= tx_done_reg;
	fifo_rd_rqst <= fifo_rd_rqst_reg;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--   
end sdi_module;


---- Component declaration

-- component sdi_module is 
-- port 
-- (     
	-- clk 			: in std_logic;
	-- rst 			: in std_logic;
	-- data_in		: in std_logic_vector(7 downto 0);
	-- tx_start		: in std_logic;
	-- sdo_out		: out std_logic;
	-- tx_done_tick : out std_logic;
-- );
-- end component sdo_module;

---- Component Instantiation

-- A : sob_module
--	 port map
--	 (
--	  clk 			=> clk,
--	  rst 			=> rst,
--	  data_in		=> data_in,
--	  tx_start  	=> tx_start,
--	  sdo_out		=> sdo_out,
--	  tx_done_tick 	=> tx_done_tick
--	 );



