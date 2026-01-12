library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity timer is
port
( 
	clk 	: in std_logic;
	rst 	: in std_logic;
	max_cnt	: in std_logic_vector(27 downto 0);
    tmr_out : out std_logic
);
end timer;

architecture gen_timer of timer is

signal t_reg, t_nxt : std_logic_vector(27 downto 0);

begin

A	: process(clk, rst)
		begin
			if(rst = '0') then
				t_reg <= (others => '0');
			elsif rising_edge(clk) then
				t_reg <= t_nxt;
		end if;
	  end process;

	t_nxt <= (others => '0') when t_reg = max_cnt else t_reg + 1; -- Once t_reg reaches max_cnt, timer restarts.

	tmr_out <= '1' when t_reg < conv_std_logic_vector(1,28) else '0'; -- pulse width is 10 nsec

end gen_timer;      