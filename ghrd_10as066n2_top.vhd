LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
LIBRARY lpm;
USE lpm.lpm_components.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
use IEEE.numeric_std.all;

entity ghrd_10as066n2_top is
    generic (
        QTRM_COUNT_const : integer := 95
    );
 port (
 
 
	fpga_bresetn        : in std_logic;
	clk_25         : in std_logic                     := 'X';             -- clk
			 
	ddr3_pll_inclk0     : in std_logic;
--	fpga_dipsw_pio : in   std_logic_vector(3 downto 0);                   
--	fpga_led_pio  : out   std_logic_vector(3 downto 0);                   
--	fpga_button_pio : in  std_logic_vector(3 downto 0);
	 
--	BRESETN_FPGA_QSPI	: in std_logic;
--	FPGA_FABCLK_25		: in std_logic := 'X';
--	DIP_SW 				: in std_logic_vector(3 downto 0);                    
		
--			--MONITORING
--	FPGA_AQC_MON_SP1 : OUT std_logic; --C23
--	FPGA_AQC_MON_SOB : OUT std_logic; --B23
--	FPGA_AQC_MON_CP : OUT std_logic; --A26
	
		
			--SENSORS
	FPGA_TEMP_SDA : INOUT std_logic; --AA3
	FPGA_TEMP_SCL : OUT std_logic;	--Y2
--	FPGA_HUM_SDA : INOUT std_logic;	--Y1
--	FPGA_HUM_SCL : OUT std_logic;	--AA1
--	FPGA_TEMP_ALERT : IN std_logic;	--D10,
--	FPGA_TEMP_OVERT : IN std_logic;	--D-11,
		
	
--	CLOCK_I2C_SCL_1 : INOUT std_logic;	--F5
--	CLOCK_I2C_SDA_1 : INOUT std_logic;	--F6
--	CLOCK_I2C_SCL_2 : INOUT std_logic;	--W2
--	CLOCK_I2C_SDA_2 : INOUT std_logic;	--W1
	
	FPGA_AQC_QTRM_SDI : OUT std_logic_vector(0 to QTRM_COUNT_const);
	
	FPGA_QTRM_AQC_SDO : IN std_logic_vector(0 to QTRM_COUNT_const);
	

	FPGA_CP				: OUT std_logic;
	FPGA_SOB				: OUT std_logic;
	FPGA_RTGU_2_AQC_CP  : IN std_logic := 'X';
	FPGA_RTGU_2_AQC_SOB : IN std_logic := 'X';


--FPGA_RTGU_2_QCC_SOB	: IN std_logic; --AB2 
--FPGA_RTGU_2_QCC_CP	: IN std_logic; --AB3 
--FPGA_RTGU_2_QCC_1PPS	: IN std_logic; --AA6 
                                       
--FPGA_USER_LED1			: OUT std_logic; --B26 
--FPGA_USER_LED2			: OUT std_logic; --A26 
--FPGA_USER_LED3			: OUT std_logic; --B23 
--FPGA_USER_LED4			: OUT std_logic; --C23 
		 
	  -- HPS memory controller ports
	  -- DDR3 single rank -2133 device

		hps_memory_mem_a : out std_logic_vector (15 downto 0);                            
		hps_memory_mem_ba : out std_logic_vector(2 downto 0);
		hps_memory_mem_ck : out std_logic ;                       
		hps_memory_mem_ck_n : out std_logic ;                        
		hps_memory_mem_cke : out std_logic ;
		hps_memory_mem_cs_n : out std_logic ;                                           
		hps_memory_mem_reset_n : out std_logic ;
		hps_memory_mem_dq : inout std_logic_vector( 31 downto 0) := (others => 'X');                         
		hps_memory_mem_dqs: inout std_logic_vector( 3 downto 0) := (others => 'X');                          
		hps_memory_mem_dqs_n: inout std_logic_vector( 3 downto 0) := (others => 'X'); 
		hps_memory_oct_rzqin : in std_logic := 'X';     
		emif_ref_clk : in std_logic := 'X';
		hps_memory_mem_odt             : out std_logic;
		hps_memory_mem_we_n            : out std_logic;
		hps_memory_mem_ras_n           : out std_logic;
		hps_memory_mem_cas_n           : out std_logic;
		hps_memory_mem_dm      : out   std_logic_vector(3 downto 0);
		
  -- HPS peripherals
		hps_emac0_TX_CLK : out std_logic ;  
		hps_emac0_TXD0 : out std_logic ;     
		hps_emac0_TXD1 : out std_logic ;     
		hps_emac0_TXD2 : out std_logic ;     
		hps_emac0_TXD3 : out std_logic ;     
		hps_emac0_RXD0 : in std_logic := 'X';    
      hps_emac0_MDIO : inout std_logic := 'X';     
		hps_emac0_MDC : out std_logic ;    
		hps_emac0_RX_CTL : in std_logic := 'X';   
		hps_emac0_TX_CTL : out std_logic ;  
		hps_emac0_RX_CLK : in std_logic := 'X';   
		hps_emac0_RXD1 : in std_logic := 'X';  
		hps_emac0_RXD2: in std_logic := 'X';     
		hps_emac0_RXD3 : in std_logic := 'X';

		
		hps_uart1_RX : in std_logic := 'X';     
		hps_uart1_TX : out std_logic ; 
      
	
      hps_sdio_CMD: inout std_logic := 'X';
		hps_sdio_CLK : out std_logic ;
	   hps_sdio_D0 : inout std_logic := 'X';
	   hps_sdio_D1 : inout std_logic := 'X';
	   hps_sdio_D2 : inout std_logic := 'X';
	   hps_sdio_D3 : inout std_logic := 'X'
						
);
end entity ghrd_10as066n2_top;


ARCHITECTURE SYN OF ghrd_10as066n2_top is

    component ghrd_10as066n2 is
        port (
            clk_100_clk                                : in    std_logic                     := 'X';             -- clk
            emif_a10_hps_0_mem_conduit_end_mem_ck      : out   std_logic_vector(0 downto 0);                     -- mem_ck
            emif_a10_hps_0_mem_conduit_end_mem_ck_n    : out   std_logic_vector(0 downto 0);                     -- mem_ck_n
            emif_a10_hps_0_mem_conduit_end_mem_a       : out   std_logic_vector(15 downto 0);                    -- mem_a
            emif_a10_hps_0_mem_conduit_end_mem_ba      : out   std_logic_vector(2 downto 0);                     -- mem_ba
            emif_a10_hps_0_mem_conduit_end_mem_cke     : out   std_logic_vector(0 downto 0);                     -- mem_cke
            emif_a10_hps_0_mem_conduit_end_mem_cs_n    : out   std_logic_vector(0 downto 0);                     -- mem_cs_n
            emif_a10_hps_0_mem_conduit_end_mem_odt     : out   std_logic_vector(0 downto 0);                     -- mem_odt
            emif_a10_hps_0_mem_conduit_end_mem_reset_n : out   std_logic_vector(0 downto 0);                     -- mem_reset_n
            emif_a10_hps_0_mem_conduit_end_mem_we_n    : out   std_logic_vector(0 downto 0);                     -- mem_we_n
            emif_a10_hps_0_mem_conduit_end_mem_ras_n   : out   std_logic_vector(0 downto 0);                     -- mem_ras_n
            emif_a10_hps_0_mem_conduit_end_mem_cas_n   : out   std_logic_vector(0 downto 0);                     -- mem_cas_n
            emif_a10_hps_0_mem_conduit_end_mem_dqs     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
            emif_a10_hps_0_mem_conduit_end_mem_dqs_n   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
            emif_a10_hps_0_mem_conduit_end_mem_dq      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
            emif_a10_hps_0_mem_conduit_end_mem_dm      : out   std_logic_vector(3 downto 0);                     -- mem_dm
            emif_a10_hps_0_oct_conduit_end_oct_rzqin   : in    std_logic                     := 'X';             -- oct_rzqin
            emif_a10_hps_0_pll_ref_clk_clock_sink_clk  : in    std_logic                     := 'X';             -- clk
            hps_io_hps_io_phery_emac0_TX_CLK           : out   std_logic;                                        -- hps_io_phery_emac0_TX_CLK
            hps_io_hps_io_phery_emac0_TXD0             : out   std_logic;                                        -- hps_io_phery_emac0_TXD0
            hps_io_hps_io_phery_emac0_TXD1             : out   std_logic;                                        -- hps_io_phery_emac0_TXD1
            hps_io_hps_io_phery_emac0_TXD2             : out   std_logic;                                        -- hps_io_phery_emac0_TXD2
            hps_io_hps_io_phery_emac0_TXD3             : out   std_logic;                                        -- hps_io_phery_emac0_TXD3
            hps_io_hps_io_phery_emac0_RX_CTL           : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RX_CTL
            hps_io_hps_io_phery_emac0_TX_CTL           : out   std_logic;                                        -- hps_io_phery_emac0_TX_CTL
            hps_io_hps_io_phery_emac0_RX_CLK           : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RX_CLK
            hps_io_hps_io_phery_emac0_RXD0             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD0
            hps_io_hps_io_phery_emac0_RXD1             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD1
            hps_io_hps_io_phery_emac0_RXD2             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD2
            hps_io_hps_io_phery_emac0_RXD3             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD3
            hps_io_hps_io_phery_emac0_MDIO             : inout std_logic                     := 'X';             -- hps_io_phery_emac0_MDIO
            hps_io_hps_io_phery_emac0_MDC              : out   std_logic;                                        -- hps_io_phery_emac0_MDC
            hps_io_hps_io_phery_sdmmc_CMD              : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_CMD
            hps_io_hps_io_phery_sdmmc_D0               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D0
            hps_io_hps_io_phery_sdmmc_D1               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D1
            hps_io_hps_io_phery_sdmmc_D2               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D2
            hps_io_hps_io_phery_sdmmc_D3               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D3
            hps_io_hps_io_phery_sdmmc_CCLK             : out   std_logic;                                        -- hps_io_phery_sdmmc_CCLK
            hps_io_hps_io_phery_uart1_RX               : in    std_logic                     := 'X';             -- hps_io_phery_uart1_RX
            hps_io_hps_io_phery_uart1_TX               : out   std_logic;                                        -- hps_io_phery_uart1_TX
            reset_reset_n                              : in    std_logic                     := 'X';


				sdi_wr_export                              : out   std_logic;                                        -- export
				sdi_full_export                            : in    std_logic                     := 'X';             -- export
				
								
				sdo_data_qtrm0_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_empty_qtrm0_export                     : in    std_logic                     := 'X';             -- export
				sdi_data_qtrm0_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_rr_qtrm0_export                        : out   std_logic;                                        -- export
				
				sdi_data_qtrm1_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm1_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm1_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm1_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm2_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm2_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm2_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm2_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm3_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm3_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm3_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm3_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm4_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm4_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm4_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm4_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm5_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm5_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm5_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm5_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm6_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm6_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm6_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm6_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm7_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm7_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm7_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm7_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm8_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm8_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm8_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm8_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm9_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm9_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm9_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm9_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm10_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm10_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm10_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm10_export                     : in    std_logic                     := 'X';              -- export

				
				sdi_data_qtrm11_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm11_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm11_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm11_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm12_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm12_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm12_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm12_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm13_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm13_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm13_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm13_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm14_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm14_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm14_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm14_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm15_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm15_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm15_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm15_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm16_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm16_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm16_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm16_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm17_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm17_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm17_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm17_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm18_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm18_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm18_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm18_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm19_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm19_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm19_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm19_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm20_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm20_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm20_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm20_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm21_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm21_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm21_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm21_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm22_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm22_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm22_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm22_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm23_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm23_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm23_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm23_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm24_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm24_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm24_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm24_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm25_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm25_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm25_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm25_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm26_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm26_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm26_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm26_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm27_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm27_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm27_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm27_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm28_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm28_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm28_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm28_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm29_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm29_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm29_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm29_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm30_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm30_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm30_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm30_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm31_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm31_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm31_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm31_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm32_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm32_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm32_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm32_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm33_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm33_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm33_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm33_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm34_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm34_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm34_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm34_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm35_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm35_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm35_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm35_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm36_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm36_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm36_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm36_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm37_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm37_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm37_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm37_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm38_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm38_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm38_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm38_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm39_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm39_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm39_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm39_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm40_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm40_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm40_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm40_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm41_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm41_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm41_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm41_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm42_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm42_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm42_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm42_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm43_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm43_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm43_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm43_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm44_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm44_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm44_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm44_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm45_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm45_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm45_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm45_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm46_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm46_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm46_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm46_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm47_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm47_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm47_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm47_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm48_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm48_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm48_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm48_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm49_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm49_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm49_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm49_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm50_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm50_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm50_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm50_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm51_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm51_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm51_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm51_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm52_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm52_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm52_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm52_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm53_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm53_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm53_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm53_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm54_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm54_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm54_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm54_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm55_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm55_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm55_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm55_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm56_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm56_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm56_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm56_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm57_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm57_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm57_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm57_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm58_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm58_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm58_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm58_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm59_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm59_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm59_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm59_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm60_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm60_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm60_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm60_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm61_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm61_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm61_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm61_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm62_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm62_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm62_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm62_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm63_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm63_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm63_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm63_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm64_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm64_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm64_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm64_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm65_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm65_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm65_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm65_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm66_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm66_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm66_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm66_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm67_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm67_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm67_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm67_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm68_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm68_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm68_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm68_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm69_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm69_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm69_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm69_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm70_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm70_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm70_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm70_export                     : in    std_logic                     := 'X';              -- export		

				sdi_data_qtrm71_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm71_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm71_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm71_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm72_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm72_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm72_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm72_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm73_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm73_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm73_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm73_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm74_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm74_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm74_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm74_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm75_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm75_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm75_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm75_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm76_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm76_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm76_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm76_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm77_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm77_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm77_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm77_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm78_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm78_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm78_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm78_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm79_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm79_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm79_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm79_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm80_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm80_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm80_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm80_export                     : in    std_logic                     := 'X';              -- export		

				sdi_data_qtrm81_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm81_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm81_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm81_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm82_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm82_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm82_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm82_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm83_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm83_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm83_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm83_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm84_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm84_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm84_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm84_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm85_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm85_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm85_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm85_export                     : in    std_logic                     := 'X';             -- export

				sdi_data_qtrm86_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm86_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm86_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm86_export                     : in    std_logic                     := 'X';              -- export

				sdi_data_qtrm87_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm87_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm87_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm87_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm88_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm88_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm88_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm88_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm89_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm89_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm89_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm89_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm90_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm90_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm90_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm90_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm91_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm91_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm91_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm91_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm92_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm92_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm92_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm92_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm93_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm93_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm93_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm93_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm94_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm94_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm94_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm94_export                     : in    std_logic                     := 'X';              -- export
				
				sdi_data_qtrm95_export                      : out   std_logic_vector(7 downto 0);                    -- export
				sdo_data_qtrm95_export                      : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
				sdo_rr_qtrm95_export                        : out   std_logic;                                        -- export
				sdo_empty_qtrm95_export                     : in    std_logic                     := 'X';              -- export
				
						
				
				sdo_fifo_reset_export                       : out   std_logic;                                         -- export
				
				cal_cntrl_export                            : out   std_logic_vector(31 downto 0);                    -- export
				sbu_cntrl_export                            : out   std_logic_vector(31 downto 0);                    -- export
				sbu_status_export                           : in    std_logic_vector(15 downto 0) := (others => 'X'); -- export				
	

				cp_sob_cntrl_export                        : out   std_logic_vector(7 downto 0);                      -- export	
				
				cp_cntrl_export                            : out   std_logic;                                        -- export
				sob_cntrl_export                           : out   std_logic;                                        -- export
				cp_sob_strobe_export                       : out   std_logic;                                        -- export
				ttl_strobe_export                          : out   std_logic;                                        -- export
				cp_delay_count_export                      : out   std_logic_vector(15 downto 0);                    -- export
				cp_on_count_export                         : out   std_logic_vector(15 downto 0);                    -- export
				cp_off_count_export                        : out   std_logic_vector(15 downto 0);                    -- export
				cp_pulse_count_export                      : out   std_logic_vector(15 downto 0);                    -- export
				sob_delay_count_export                     : out   std_logic_vector(15 downto 0);                    -- export
				sob_on_count_export                        : out   std_logic_vector(15 downto 0);                    -- export
				sob_off_count_export                       : out   std_logic_vector(15 downto 0);                    -- export
				sob_pulse_count_export                     : out   std_logic_vector(15 downto 0);                    -- export
				ttl_delay_count_export                     : out   std_logic_vector(15 downto 0);                    -- export
				ttl_on_count_export                        : out   std_logic_vector(15 downto 0);                    -- export
				ttl_off_count_export                       : out   std_logic_vector(15 downto 0);                    -- export
				ttl_pulse_count_export                     : out   std_logic_vector(15 downto 0);                    -- export
				cp_work_done_export                        : in    std_logic                     := 'X';             -- export
				sob_work_done_export                       : in    std_logic                     := 'X';             -- export
				ttl_work_done_export                       : in    std_logic                     := 'X';              -- export
				pio_temp_export                            : in    std_logic_vector(9 downto 0)  := (others => 'X') -- export

				
				
				
        );
    end component ghrd_10as066n2;

	component sdi_module is 
	port 
	(     
		clk 				: in std_logic;
		rst 				: in std_logic;
		data_in				: in std_logic_vector(7 downto 0);
		fifo_rd_rqst			: out std_logic;
		tx_start			: in std_logic;
		sdi_out				: out std_logic;
		tx_done_tick			: out std_logic
	);
	end component sdi_module;

	component sdo_module is 
	port 
	(     
		clk 				: in std_logic;		
		rst 				: in std_logic;		
		sdo_in				: in std_logic;	
		data_reg			: out std_logic_vector(7 downto 0);
		rx_done_tick			: out std_logic     
	);
	end component sdo_module;
	
	
	component timer is
	port
	( 
		clk 		: in std_logic;
		rst 		: in std_logic;
		max_cnt	: in std_logic_vector(27 downto 0);
		tmr_out 	: out std_logic
	);
	end component timer;
	
	
	component sdi_fifo is
	port 
	(
		data  : in  std_logic_vector(7 downto 0); 	-- datain
		wrreq : in  std_logic;             				-- wrreq
		rdreq : in  std_logic;             				-- rdreq
		clock : in  std_logic;             				-- clk
		aclr  : in  std_logic;             				-- aclr
		q     : out std_logic_vector(7 downto 0);   -- dataout
		full  : out std_logic;                       -- full
		empty : out std_logic                        -- empty
	);
	end component sdi_fifo;			
	
	
	component sdo_fifo is
	port 
	(
		data  : in  std_logic_vector(7 downto 0); 	-- datain
		wrreq : in  std_logic;             				-- wrreq
		rdreq : in  std_logic;             				-- rdreq
		clock : in  std_logic;             				-- clk
		aclr  : in  std_logic;             				-- aclr
		q     : out std_logic_vector(7 downto 0);   -- dataout
		full  : out std_logic;                       -- full
		empty : out std_logic                        -- empty
	);
	end component sdo_fifo;

	component en_gen is
	port 
	 ( 
		clk				: in std_logic;		-- 50 MHz Clk
		reset			 	: in std_logic;		-- when s/w is pressed, 'reset' will be pulled to '0'
		en_in				: in std_logic;
		en_out			: out std_logic
	 );
	end component en_gen;
	
	component synchronizer is 
	port 
	(     
		clk 		: in std_logic;		
		rst 		: in std_logic;		
		in_async	: in std_logic;	
		out_sync	: out std_logic    
	);
	end component synchronizer;
	
	component goPulse_gen is
	port 
		( 
			clk					: in std_logic;	
			reset				: in std_logic;									
			strobe	 			: in std_logic;	
			delayWidth			: in std_logic_vector(15 downto 0);
			pulseOnWidth		: in std_logic_vector(15 downto 0);
			pulseOffWidth		: in std_logic_vector(15 downto 0);
			noOfpulses			: in std_logic_vector(15 downto 0);
			goPulseOut			: out std_logic;
			work_done			: out std_logic
		);
	end component goPulse_gen;
	
	component TEMP_SENSE is
	port 
	(
		corectl : in  std_logic;             				
		eoc  : out std_logic;                       
		reset : in std_logic;
		tempout : out std_logic_vector(9 downto 0) 
	);
	end component TEMP_SENSE;	
	 
 ----------------------------common signals START-------------------------------------
		signal clk_sig, rst_sig: std_logic;	
		signal data_in: std_logic_vector(7 downto 0);
		signal tx_start, tx_done_tick: std_logic;	
		signal max_cnt	: std_logic_vector(27 downto 0);

		
		signal sig_FPGA_AQC_QTRM34_SDI, sig_FPGA_AQC_QTRM36_SDI : std_logic;
		signal sig_FPGA_AQC_QTRM53_SDI, sig_FPGA_AQC_QTRM55_SDI : std_logic;
		
		signal t_reg, t_nxt : std_logic_vector(27 downto 0);
	   signal test_clk_ref : std_logic;
	   
	   signal sig_sdo_fifo_reset, sig_sdo_fifo_reset_gen : std_logic;
	   signal sig_cal_cntrl : std_logic_vector(31 downto 0); 
	   signal sig_sbu_cntrl : std_logic_vector(31 downto 0):= (others =>'0');  
	   signal sig_sbu_status: std_logic_vector(15 downto 0);  
	   signal sig_cp_sob_cntrl: std_logic_vector(7 downto 0);
  
	   signal FPGA_CP_sig	: std_logic := '0';
	   signal FPGA_SOB_sig 	: std_logic := '1';
		
		signal cp_cntrl_sig 			: std_logic := '0';        
		signal sob_cntrl_sig 		: std_logic := '0';        
		signal cp_sob_strobe_sig, cp_sob_strobe_sig_gen   : std_logic := '0';
		signal ttl_cntrl_sig       : std_logic := '0'; 
		signal cp_delay_count_sig 	: std_logic_vector(15 downto 0) := (others =>'0');    
		signal cp_on_count_sig      : std_logic_vector(15 downto 0) := (others =>'0');
		signal cp_off_count_sig     : std_logic_vector(15 downto 0) := (others =>'0');
		signal cp_pulse_count_sig   : std_logic_vector(15 downto 0) := (others =>'0');
		signal sob_delay_count_sig  : std_logic_vector(15 downto 0) := (others =>'0');
		signal sob_on_count_sig     : std_logic_vector(15 downto 0) := (others =>'0');
		signal sob_off_count_sig    : std_logic_vector(15 downto 0) := (others =>'0');
		signal sob_pulse_count_sig  : std_logic_vector(15 downto 0) := (others =>'0');
		signal ttl_delay_count_sig  : std_logic_vector(15 downto 0) := (others =>'0');
		signal ttl_on_count_sig     : std_logic_vector(15 downto 0) := (others =>'0');
		signal ttl_off_count_sig    : std_logic_vector(15 downto 0) := (others =>'0');
		signal ttl_pulse_count_sig  : std_logic_vector(15 downto 0) := (others =>'0');
		signal cp_work_done_sig     : std_logic := '0';
		signal sob_work_done_sig    : std_logic := '0';
		signal ttl_work_done_sig    : std_logic := '0';
		
		
		signal pio_temp, tempout, temp_out : std_logic_vector(9 downto 0) := (others =>'0'); 
		signal corectl, eoc,temp_rdy : std_logic := '0';   
----------------------------common signals END-------------------------------------	
-------------------Signals----------------------------
TYPE t_qtrm_data_type IS ARRAY (0 TO QTRM_COUNT_const) OF STD_LOGIC_VECTOR(7 DOWNTO 0);

------------------------------------------------------
		signal qtrm_sdi_fifo_data_out, qtrm_sdi_fifo_data_in	: t_qtrm_data_type;		
		signal qtrm_sdi_fifo_empty, qtrm_sdi_fifo_rd_rqst: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		signal qtrm_sdi_fifo_sdi_wr_rqst_gen: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);

		signal qtrm_sdo_fifo_data_out, qtrm_sdo_fifo_data_in	: t_qtrm_data_type;		
		signal qtrm_sdo_fifo_empty, qtrm_sdo_fifo_rd_rqst: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		signal qtrm_sdo_fifo_sdi_wr_rqst_gen: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		
		
		signal qtrm_data_out: t_qtrm_data_type;
		signal qtrm_trigger: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		signal qtrm_rx_done_tick: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		
		signal qtrm_sdi_data_hps2fifo: t_qtrm_data_type;
--		signal qtrm0_sdi_wr_rqst, qtrm0_sdi_wr_rqst_gen : std_logic;		
		signal qtrm_sdi_wr_rqst, qtrm_sdi_wr_rqst_gen : std_logic;
		signal qtrm_sdi_fifo_full: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		
		signal qtrm_sdo_data_fifo2hps: t_qtrm_data_type;
		signal qtrm_sdo_rd_rqst, qtrm_sdo_rd_rqst_gen : STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		signal FPGA_QTRM_AQC_SDO_regen: STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
		
		signal qtrm_sdi_data_export : t_qtrm_data_type;
		signal qtrm_sdi_wr_export : STD_LOGIC_VECTOR(0 TO QTRM_COUNT_const);
----------------------------QTRM0 signals START-------------------------------------	
--
--		
--		signal qtrm0_sdi_fifo_data_out, qtrm0_sdi_fifo_data_in	: std_logic_vector(15 downto 0);		
--		signal qtrm0_sdi_fifo_empty, qtrm0_sdi_fifo_rd_rqst: std_logic;
--		signal qtrm0_sdi_fifo_sdi_wr_rqst_gen: std_logic;
--
--		signal qtrm0_sdo_fifo_data_out, qtrm0_sdo_fifo_data_in	: std_logic_vector(15 downto 0);		
--		signal qtrm0_sdo_fifo_empty, qtrm0_sdo_fifo_rd_rqst: std_logic;
--		signal qtrm0_sdo_fifo_sdi_wr_rqst_gen: std_logic;
--		
--		
--		signal qtrm0_data_out: std_logic_vector(15 downto 0);
--		signal qtrm0_trigger: std_logic;
--		signal qtrm0_rx_done_tick: std_logic;
--		
--		signal qtrm0_sdi_data_hps2fifo: std_logic_vector(15 downto 0);
----		signal qtrm0_sdi_wr_rqst, qtrm0_sdi_wr_rqst_gen : std_logic;		
--		signal qtrm_sdi_wr_rqst, qtrm_sdi_wr_rqst_gen : std_logic;
--		signal qtrm0_sdi_fifo_full: std_logic;
--		
--		signal qtrm0_sdo_data_fifo2hps: std_logic_vector(15 downto 0);
--		signal qtrm0_sdo_rd_rqst, qtrm0_sdo_rd_rqst_gen : std_logic;
--		signal FPGA_QTRM0_AQC_SDO_regen: std_logic;
--		
--		signal qtrm0_sdi_data_export : std_logic_vector (15 downto 0);
--		signal qtrm0_sdi_wr_export : std_logic;
		

----------------------------QTRM0 signals END-------------------------------------

BEGIN		
	

niosdisp_comp : ghrd_10as066n2
port map 
(
		
  
  hps_io_hps_io_phery_emac0_TX_CLK            => hps_emac0_TX_CLK, 
  hps_io_hps_io_phery_emac0_TXD0              => hps_emac0_TXD0,   
  hps_io_hps_io_phery_emac0_TXD1              => hps_emac0_TXD1,   
  hps_io_hps_io_phery_emac0_TXD2              => hps_emac0_TXD2,   
  hps_io_hps_io_phery_emac0_TXD3              => hps_emac0_TXD3,   
  hps_io_hps_io_phery_emac0_MDIO              => hps_emac0_MDIO,   
  hps_io_hps_io_phery_emac0_MDC               => hps_emac0_MDC,    
  hps_io_hps_io_phery_emac0_RX_CTL            => hps_emac0_RX_CTL, 
  hps_io_hps_io_phery_emac0_TX_CTL            => hps_emac0_TX_CTL, 
  hps_io_hps_io_phery_emac0_RX_CLK            => hps_emac0_RX_CLK, 
  hps_io_hps_io_phery_emac0_RXD0              => hps_emac0_RXD0,   
  hps_io_hps_io_phery_emac0_RXD1              => hps_emac0_RXD1,   
  hps_io_hps_io_phery_emac0_RXD2              => hps_emac0_RXD2,   
  hps_io_hps_io_phery_emac0_RXD3              => hps_emac0_RXD3,

  hps_io_hps_io_phery_uart1_RX                => hps_uart1_RX,     
  hps_io_hps_io_phery_uart1_TX                => hps_uart1_TX, 
  
  hps_io_hps_io_phery_sdmmc_CMD               => hps_sdio_CMD,     
  hps_io_hps_io_phery_sdmmc_D0                => hps_sdio_D0,      
  hps_io_hps_io_phery_sdmmc_D1                => hps_sdio_D1,      
  hps_io_hps_io_phery_sdmmc_D2                => hps_sdio_D2,      
  hps_io_hps_io_phery_sdmmc_D3                => hps_sdio_D3,    
  hps_io_hps_io_phery_sdmmc_CCLK              => hps_sdio_CLK,
    
  emif_a10_hps_0_mem_conduit_end_mem_ck(0)       => hps_memory_mem_ck,     
  emif_a10_hps_0_mem_conduit_end_mem_ck_n(0)     => hps_memory_mem_ck_n,   
  emif_a10_hps_0_mem_conduit_end_mem_a        	 => hps_memory_mem_a,      
  emif_a10_hps_0_mem_conduit_end_mem_ba          => hps_memory_mem_ba, 
  emif_a10_hps_0_mem_conduit_end_mem_cke(0)      => hps_memory_mem_cke,    
  emif_a10_hps_0_mem_conduit_end_mem_cs_n(0)     => hps_memory_mem_cs_n,   
  emif_a10_hps_0_mem_conduit_end_mem_odt(0)      => hps_memory_mem_odt,    
  emif_a10_hps_0_mem_conduit_end_mem_reset_n(0)  => hps_memory_mem_reset_n, 
  emif_a10_hps_0_mem_conduit_end_mem_dqs         => hps_memory_mem_dqs,    
  emif_a10_hps_0_mem_conduit_end_mem_dqs_n       => hps_memory_mem_dqs_n,  
  emif_a10_hps_0_mem_conduit_end_mem_dq          => hps_memory_mem_dq, 
  emif_a10_hps_0_mem_conduit_end_mem_dm          => hps_memory_mem_dm, 
  emif_a10_hps_0_oct_conduit_end_oct_rzqin       => hps_memory_oct_rzqin, 
  emif_a10_hps_0_pll_ref_clk_clock_sink_clk      => ddr3_pll_inclk0,
  emif_a10_hps_0_mem_conduit_end_mem_we_n(0) 	 => hps_memory_mem_we_n,
  emif_a10_hps_0_mem_conduit_end_mem_ras_n(0) 	 => hps_memory_mem_ras_n,   
  emif_a10_hps_0_mem_conduit_end_mem_cas_n(0) 	 =>  hps_memory_mem_cas_n,
  
  clk_100_clk                              		 => clk_25,
  reset_reset_n                            		 => fpga_bresetn,
 
	sdi_wr_export                              => qtrm_sdi_wr_rqst,                              --                                sdi_wr.export
	sdi_full_export                            => qtrm_sdi_fifo_full(0),                            --                              sdi_full.export
	
	                   
		sdi_data_qtrm0_export  => qtrm_sdi_data_hps2fifo(0),
		sdo_data_qtrm0_export  => qtrm_sdo_data_fifo2hps(0),
		sdo_rr_qtrm0_export    => qtrm_sdo_rd_rqst(0),
		sdo_empty_qtrm0_export => qtrm_sdo_fifo_empty(0),
		
		sdi_data_qtrm1_export  => qtrm_sdi_data_hps2fifo(1),
		sdo_data_qtrm1_export  => qtrm_sdo_data_fifo2hps(1),
		sdo_rr_qtrm1_export    => qtrm_sdo_rd_rqst(1),
		sdo_empty_qtrm1_export => qtrm_sdo_fifo_empty(1),
		
		sdi_data_qtrm2_export  => qtrm_sdi_data_hps2fifo(2),
		sdo_data_qtrm2_export  => qtrm_sdo_data_fifo2hps(2),
		sdo_rr_qtrm2_export    => qtrm_sdo_rd_rqst(2),
		sdo_empty_qtrm2_export => qtrm_sdo_fifo_empty(2),
		
		sdi_data_qtrm3_export  => qtrm_sdi_data_hps2fifo(3),
		sdo_data_qtrm3_export  => qtrm_sdo_data_fifo2hps(3),
		sdo_rr_qtrm3_export    => qtrm_sdo_rd_rqst(3),
		sdo_empty_qtrm3_export => qtrm_sdo_fifo_empty(3),
		
		sdi_data_qtrm4_export  => qtrm_sdi_data_hps2fifo(4),
		sdo_data_qtrm4_export  => qtrm_sdo_data_fifo2hps(4),
		sdo_rr_qtrm4_export    => qtrm_sdo_rd_rqst(4),
		sdo_empty_qtrm4_export => qtrm_sdo_fifo_empty(4),
		
		sdi_data_qtrm5_export  => qtrm_sdi_data_hps2fifo(5),
		sdo_data_qtrm5_export  => qtrm_sdo_data_fifo2hps(5),
		sdo_rr_qtrm5_export    => qtrm_sdo_rd_rqst(5),
		sdo_empty_qtrm5_export => qtrm_sdo_fifo_empty(5),
		
		sdi_data_qtrm6_export  => qtrm_sdi_data_hps2fifo(6),
		sdo_data_qtrm6_export  => qtrm_sdo_data_fifo2hps(6),
		sdo_rr_qtrm6_export    => qtrm_sdo_rd_rqst(6),
		sdo_empty_qtrm6_export => qtrm_sdo_fifo_empty(6),
		
		sdi_data_qtrm7_export  => qtrm_sdi_data_hps2fifo(7),
		sdo_data_qtrm7_export  => qtrm_sdo_data_fifo2hps(7),
		sdo_rr_qtrm7_export    => qtrm_sdo_rd_rqst(7),
		sdo_empty_qtrm7_export => qtrm_sdo_fifo_empty(7),
		
		sdi_data_qtrm8_export  => qtrm_sdi_data_hps2fifo(8),
		sdo_data_qtrm8_export  => qtrm_sdo_data_fifo2hps(8),
		sdo_rr_qtrm8_export    => qtrm_sdo_rd_rqst(8),
		sdo_empty_qtrm8_export => qtrm_sdo_fifo_empty(8),
		
		sdi_data_qtrm9_export  => qtrm_sdi_data_hps2fifo(9),
		sdo_data_qtrm9_export  => qtrm_sdo_data_fifo2hps(9),
		sdo_rr_qtrm9_export    => qtrm_sdo_rd_rqst(9),
		sdo_empty_qtrm9_export => qtrm_sdo_fifo_empty(9),
		
		sdi_data_qtrm10_export  => qtrm_sdi_data_hps2fifo(10),
		sdo_data_qtrm10_export  => qtrm_sdo_data_fifo2hps(10),
		sdo_rr_qtrm10_export    => qtrm_sdo_rd_rqst(10),
		sdo_empty_qtrm10_export => qtrm_sdo_fifo_empty(10),
		
		sdi_data_qtrm11_export  => qtrm_sdi_data_hps2fifo(11),
		sdo_data_qtrm11_export  => qtrm_sdo_data_fifo2hps(11),
		sdo_rr_qtrm11_export    => qtrm_sdo_rd_rqst(11),
		sdo_empty_qtrm11_export => qtrm_sdo_fifo_empty(11),
		
		sdi_data_qtrm12_export  => qtrm_sdi_data_hps2fifo(12),
		sdo_data_qtrm12_export  => qtrm_sdo_data_fifo2hps(12),
		sdo_rr_qtrm12_export    => qtrm_sdo_rd_rqst(12),
		sdo_empty_qtrm12_export => qtrm_sdo_fifo_empty(12),
		
		sdi_data_qtrm13_export  => qtrm_sdi_data_hps2fifo(13),
		sdo_data_qtrm13_export  => qtrm_sdo_data_fifo2hps(13),
		sdo_rr_qtrm13_export    => qtrm_sdo_rd_rqst(13),
		sdo_empty_qtrm13_export => qtrm_sdo_fifo_empty(13),
		
		sdi_data_qtrm14_export  => qtrm_sdi_data_hps2fifo(14),
		sdo_data_qtrm14_export  => qtrm_sdo_data_fifo2hps(14),
		sdo_rr_qtrm14_export    => qtrm_sdo_rd_rqst(14),
		sdo_empty_qtrm14_export => qtrm_sdo_fifo_empty(14),
		
		sdi_data_qtrm15_export  => qtrm_sdi_data_hps2fifo(15),
		sdo_data_qtrm15_export  => qtrm_sdo_data_fifo2hps(15),
		sdo_rr_qtrm15_export    => qtrm_sdo_rd_rqst(15),
		sdo_empty_qtrm15_export => qtrm_sdo_fifo_empty(15),
		
		sdi_data_qtrm16_export  => qtrm_sdi_data_hps2fifo(16),
		sdo_data_qtrm16_export  => qtrm_sdo_data_fifo2hps(16),
		sdo_rr_qtrm16_export    => qtrm_sdo_rd_rqst(16),
		sdo_empty_qtrm16_export => qtrm_sdo_fifo_empty(16),
		
		sdi_data_qtrm17_export  => qtrm_sdi_data_hps2fifo(17),
		sdo_data_qtrm17_export  => qtrm_sdo_data_fifo2hps(17),
		sdo_rr_qtrm17_export    => qtrm_sdo_rd_rqst(17),
		sdo_empty_qtrm17_export => qtrm_sdo_fifo_empty(17),
		
		sdi_data_qtrm18_export  => qtrm_sdi_data_hps2fifo(18),
		sdo_data_qtrm18_export  => qtrm_sdo_data_fifo2hps(18),
		sdo_rr_qtrm18_export    => qtrm_sdo_rd_rqst(18),
		sdo_empty_qtrm18_export => qtrm_sdo_fifo_empty(18),
		
		sdi_data_qtrm19_export  => qtrm_sdi_data_hps2fifo(19),
		sdo_data_qtrm19_export  => qtrm_sdo_data_fifo2hps(19),
		sdo_rr_qtrm19_export    => qtrm_sdo_rd_rqst(19),
		sdo_empty_qtrm19_export => qtrm_sdo_fifo_empty(19),
		
		sdi_data_qtrm20_export  => qtrm_sdi_data_hps2fifo(20),
		sdo_data_qtrm20_export  => qtrm_sdo_data_fifo2hps(20),
		sdo_rr_qtrm20_export    => qtrm_sdo_rd_rqst(20),
		sdo_empty_qtrm20_export => qtrm_sdo_fifo_empty(20),
		
		sdi_data_qtrm21_export  => qtrm_sdi_data_hps2fifo(21),
		sdo_data_qtrm21_export  => qtrm_sdo_data_fifo2hps(21),
		sdo_rr_qtrm21_export    => qtrm_sdo_rd_rqst(21),
		sdo_empty_qtrm21_export => qtrm_sdo_fifo_empty(21),
		
		sdi_data_qtrm22_export  => qtrm_sdi_data_hps2fifo(22),
		sdo_data_qtrm22_export  => qtrm_sdo_data_fifo2hps(22),
		sdo_rr_qtrm22_export    => qtrm_sdo_rd_rqst(22),
		sdo_empty_qtrm22_export => qtrm_sdo_fifo_empty(22),
		
		sdi_data_qtrm23_export  => qtrm_sdi_data_hps2fifo(23),
		sdo_data_qtrm23_export  => qtrm_sdo_data_fifo2hps(23),
		sdo_rr_qtrm23_export    => qtrm_sdo_rd_rqst(23),
		sdo_empty_qtrm23_export => qtrm_sdo_fifo_empty(23),
		
		sdi_data_qtrm24_export  => qtrm_sdi_data_hps2fifo(24),
		sdo_data_qtrm24_export  => qtrm_sdo_data_fifo2hps(24),
		sdo_rr_qtrm24_export    => qtrm_sdo_rd_rqst(24),
		sdo_empty_qtrm24_export => qtrm_sdo_fifo_empty(24),
		
		sdi_data_qtrm25_export  => qtrm_sdi_data_hps2fifo(25),
		sdo_data_qtrm25_export  => qtrm_sdo_data_fifo2hps(25),
		sdo_rr_qtrm25_export    => qtrm_sdo_rd_rqst(25),
		sdo_empty_qtrm25_export => qtrm_sdo_fifo_empty(25),
		
		sdi_data_qtrm26_export  => qtrm_sdi_data_hps2fifo(26),
		sdo_data_qtrm26_export  => qtrm_sdo_data_fifo2hps(26),
		sdo_rr_qtrm26_export    => qtrm_sdo_rd_rqst(26),
		sdo_empty_qtrm26_export => qtrm_sdo_fifo_empty(26),
		
		sdi_data_qtrm27_export  => qtrm_sdi_data_hps2fifo(27),
		sdo_data_qtrm27_export  => qtrm_sdo_data_fifo2hps(27),
		sdo_rr_qtrm27_export    => qtrm_sdo_rd_rqst(27),
		sdo_empty_qtrm27_export => qtrm_sdo_fifo_empty(27),
		
		sdi_data_qtrm28_export  => qtrm_sdi_data_hps2fifo(28),
		sdo_data_qtrm28_export  => qtrm_sdo_data_fifo2hps(28),
		sdo_rr_qtrm28_export    => qtrm_sdo_rd_rqst(28),
		sdo_empty_qtrm28_export => qtrm_sdo_fifo_empty(28),
		
		sdi_data_qtrm29_export  => qtrm_sdi_data_hps2fifo(29),
		sdo_data_qtrm29_export  => qtrm_sdo_data_fifo2hps(29),
		sdo_rr_qtrm29_export    => qtrm_sdo_rd_rqst(29),
		sdi_data_qtrm30_export  => qtrm_sdi_data_hps2fifo(30),
		sdo_data_qtrm30_export  => qtrm_sdo_data_fifo2hps(30),
		sdo_rr_qtrm30_export    => qtrm_sdo_rd_rqst(30),
		sdo_empty_qtrm30_export => qtrm_sdo_fifo_empty(30),
		
		sdi_data_qtrm31_export  => qtrm_sdi_data_hps2fifo(31),
		sdo_data_qtrm31_export  => qtrm_sdo_data_fifo2hps(31),
		sdo_rr_qtrm31_export    => qtrm_sdo_rd_rqst(31),
		sdo_empty_qtrm31_export => qtrm_sdo_fifo_empty(31),
		
		sdi_data_qtrm32_export  => qtrm_sdi_data_hps2fifo(32),
		sdo_data_qtrm32_export  => qtrm_sdo_data_fifo2hps(32),
		sdo_rr_qtrm32_export    => qtrm_sdo_rd_rqst(32),
		sdo_empty_qtrm32_export => qtrm_sdo_fifo_empty(32),
		
		sdi_data_qtrm33_export  => qtrm_sdi_data_hps2fifo(33),
		sdo_data_qtrm33_export  => qtrm_sdo_data_fifo2hps(33),
		sdo_rr_qtrm33_export    => qtrm_sdo_rd_rqst(33),
		sdo_empty_qtrm33_export => qtrm_sdo_fifo_empty(33),
		
		sdi_data_qtrm34_export  => qtrm_sdi_data_hps2fifo(34),
		sdo_data_qtrm34_export  => qtrm_sdo_data_fifo2hps(34),
		sdo_rr_qtrm34_export    => qtrm_sdo_rd_rqst(34),
		sdo_empty_qtrm34_export => qtrm_sdo_fifo_empty(34),
		
		sdi_data_qtrm35_export  => qtrm_sdi_data_hps2fifo(35),
		sdo_data_qtrm35_export  => qtrm_sdo_data_fifo2hps(35),
		sdo_rr_qtrm35_export    => qtrm_sdo_rd_rqst(35),
		sdo_empty_qtrm35_export => qtrm_sdo_fifo_empty(35),
		
		sdi_data_qtrm36_export  => qtrm_sdi_data_hps2fifo(36),
		sdo_data_qtrm36_export  => qtrm_sdo_data_fifo2hps(36),
		sdo_rr_qtrm36_export    => qtrm_sdo_rd_rqst(36),
		sdo_empty_qtrm36_export => qtrm_sdo_fifo_empty(36),
		
		sdi_data_qtrm37_export  => qtrm_sdi_data_hps2fifo(37),
		sdo_data_qtrm37_export  => qtrm_sdo_data_fifo2hps(37),
		sdo_rr_qtrm37_export    => qtrm_sdo_rd_rqst(37),
		sdo_empty_qtrm37_export => qtrm_sdo_fifo_empty(37),
		
		sdi_data_qtrm38_export  => qtrm_sdi_data_hps2fifo(38),
		sdo_data_qtrm38_export  => qtrm_sdo_data_fifo2hps(38),
		sdo_rr_qtrm38_export    => qtrm_sdo_rd_rqst(38),
		sdo_empty_qtrm38_export => qtrm_sdo_fifo_empty(38),
		
		sdi_data_qtrm39_export  => qtrm_sdi_data_hps2fifo(39),
		sdo_data_qtrm39_export  => qtrm_sdo_data_fifo2hps(39),
		sdo_rr_qtrm39_export    => qtrm_sdo_rd_rqst(39),
		sdo_empty_qtrm39_export => qtrm_sdo_fifo_empty(39),
		sdi_data_qtrm40_export  => qtrm_sdi_data_hps2fifo(40),
		sdo_data_qtrm40_export  => qtrm_sdo_data_fifo2hps(40),
		sdo_rr_qtrm40_export    => qtrm_sdo_rd_rqst(40),
		sdo_empty_qtrm40_export => qtrm_sdo_fifo_empty(40),
		
		sdi_data_qtrm41_export  => qtrm_sdi_data_hps2fifo(41),
		sdo_data_qtrm41_export  => qtrm_sdo_data_fifo2hps(41),
		sdo_rr_qtrm41_export    => qtrm_sdo_rd_rqst(41),
		sdo_empty_qtrm41_export => qtrm_sdo_fifo_empty(41),
		
		sdi_data_qtrm42_export  => qtrm_sdi_data_hps2fifo(42),
		sdo_data_qtrm42_export  => qtrm_sdo_data_fifo2hps(42),
		sdo_rr_qtrm42_export    => qtrm_sdo_rd_rqst(42),
		sdo_empty_qtrm42_export => qtrm_sdo_fifo_empty(42),
		
		sdi_data_qtrm43_export  => qtrm_sdi_data_hps2fifo(43),
		sdo_data_qtrm43_export  => qtrm_sdo_data_fifo2hps(43),
		sdo_rr_qtrm43_export    => qtrm_sdo_rd_rqst(43),
		sdo_empty_qtrm43_export => qtrm_sdo_fifo_empty(43),
		
		sdi_data_qtrm44_export  => qtrm_sdi_data_hps2fifo(44),
		sdo_data_qtrm44_export  => qtrm_sdo_data_fifo2hps(44),
		sdo_rr_qtrm44_export    => qtrm_sdo_rd_rqst(44),
		sdo_empty_qtrm44_export => qtrm_sdo_fifo_empty(44),
		
		sdi_data_qtrm45_export  => qtrm_sdi_data_hps2fifo(45),
		sdo_data_qtrm45_export  => qtrm_sdo_data_fifo2hps(45),
		sdo_rr_qtrm45_export    => qtrm_sdo_rd_rqst(45),
		sdo_empty_qtrm45_export => qtrm_sdo_fifo_empty(45),
		
		sdi_data_qtrm46_export  => qtrm_sdi_data_hps2fifo(46),
		sdo_data_qtrm46_export  => qtrm_sdo_data_fifo2hps(46),
		sdo_rr_qtrm46_export    => qtrm_sdo_rd_rqst(46),
		sdo_empty_qtrm46_export => qtrm_sdo_fifo_empty(46),
		
		sdi_data_qtrm47_export  => qtrm_sdi_data_hps2fifo(47),
		sdo_data_qtrm47_export  => qtrm_sdo_data_fifo2hps(47),
		sdo_rr_qtrm47_export    => qtrm_sdo_rd_rqst(47),
		sdo_empty_qtrm47_export => qtrm_sdo_fifo_empty(47),
		
		sdi_data_qtrm48_export  => qtrm_sdi_data_hps2fifo(48),
		sdo_data_qtrm48_export  => qtrm_sdo_data_fifo2hps(48),
		sdo_rr_qtrm48_export    => qtrm_sdo_rd_rqst(48),
		sdo_empty_qtrm48_export => qtrm_sdo_fifo_empty(48),
		
		sdi_data_qtrm49_export  => qtrm_sdi_data_hps2fifo(49),
		sdo_data_qtrm49_export  => qtrm_sdo_data_fifo2hps(49),
		sdo_rr_qtrm49_export    => qtrm_sdo_rd_rqst(49),
		sdo_empty_qtrm49_export => qtrm_sdo_fifo_empty(49),
		
		sdi_data_qtrm50_export  => qtrm_sdi_data_hps2fifo(50),
		sdo_data_qtrm50_export  => qtrm_sdo_data_fifo2hps(50),
		sdo_rr_qtrm50_export    => qtrm_sdo_rd_rqst(50),
		sdo_empty_qtrm50_export => qtrm_sdo_fifo_empty(50),
		
		sdi_data_qtrm51_export  => qtrm_sdi_data_hps2fifo(51),
		sdo_data_qtrm51_export  => qtrm_sdo_data_fifo2hps(51),
		sdo_rr_qtrm51_export    => qtrm_sdo_rd_rqst(51),
		sdo_empty_qtrm51_export => qtrm_sdo_fifo_empty(51),
		
		sdi_data_qtrm52_export  => qtrm_sdi_data_hps2fifo(52),
		sdo_data_qtrm52_export  => qtrm_sdo_data_fifo2hps(52),
		sdo_rr_qtrm52_export    => qtrm_sdo_rd_rqst(52),
		sdo_empty_qtrm52_export => qtrm_sdo_fifo_empty(52),
		
		sdi_data_qtrm53_export  => qtrm_sdi_data_hps2fifo(53),
		sdo_data_qtrm53_export  => qtrm_sdo_data_fifo2hps(53),
		sdo_rr_qtrm53_export    => qtrm_sdo_rd_rqst(53),
		sdo_empty_qtrm53_export => qtrm_sdo_fifo_empty(53),
		
		sdi_data_qtrm54_export  => qtrm_sdi_data_hps2fifo(54),
		sdo_data_qtrm54_export  => qtrm_sdo_data_fifo2hps(54),
		sdo_rr_qtrm54_export    => qtrm_sdo_rd_rqst(54),
		sdo_empty_qtrm54_export => qtrm_sdo_fifo_empty(54),
		
		sdi_data_qtrm55_export  => qtrm_sdi_data_hps2fifo(55),
		sdo_data_qtrm55_export  => qtrm_sdo_data_fifo2hps(55),
		sdo_rr_qtrm55_export    => qtrm_sdo_rd_rqst(55),
		sdo_empty_qtrm55_export => qtrm_sdo_fifo_empty(55),
		
		sdi_data_qtrm56_export  => qtrm_sdi_data_hps2fifo(56),
		sdo_data_qtrm56_export  => qtrm_sdo_data_fifo2hps(56),
		sdo_rr_qtrm56_export    => qtrm_sdo_rd_rqst(56),
		sdo_empty_qtrm56_export => qtrm_sdo_fifo_empty(56),
		
		sdi_data_qtrm57_export  => qtrm_sdi_data_hps2fifo(57),
		sdo_data_qtrm57_export  => qtrm_sdo_data_fifo2hps(57),
		sdo_rr_qtrm57_export    => qtrm_sdo_rd_rqst(57),
		sdo_empty_qtrm57_export => qtrm_sdo_fifo_empty(57),
		
		sdi_data_qtrm58_export  => qtrm_sdi_data_hps2fifo(58),
		sdo_data_qtrm58_export  => qtrm_sdo_data_fifo2hps(58),
		sdo_rr_qtrm58_export    => qtrm_sdo_rd_rqst(58),
		sdo_empty_qtrm58_export => qtrm_sdo_fifo_empty(58),
		
		sdi_data_qtrm59_export  => qtrm_sdi_data_hps2fifo(59),
		sdo_data_qtrm59_export  => qtrm_sdo_data_fifo2hps(59),
		sdo_rr_qtrm59_export    => qtrm_sdo_rd_rqst(59),
		sdo_empty_qtrm59_export => qtrm_sdo_fifo_empty(59),
		sdi_data_qtrm60_export  => qtrm_sdi_data_hps2fifo(60),
		sdo_data_qtrm60_export  => qtrm_sdo_data_fifo2hps(60),
		sdo_rr_qtrm60_export    => qtrm_sdo_rd_rqst(60),
		sdo_empty_qtrm60_export => qtrm_sdo_fifo_empty(60),
		
		sdi_data_qtrm61_export  => qtrm_sdi_data_hps2fifo(61),
		sdo_data_qtrm61_export  => qtrm_sdo_data_fifo2hps(61),
		sdo_rr_qtrm61_export    => qtrm_sdo_rd_rqst(61),
		sdo_empty_qtrm61_export => qtrm_sdo_fifo_empty(61),
		
		sdi_data_qtrm62_export  => qtrm_sdi_data_hps2fifo(62),
		sdo_data_qtrm62_export  => qtrm_sdo_data_fifo2hps(62),
		sdo_rr_qtrm62_export    => qtrm_sdo_rd_rqst(62),
		sdo_empty_qtrm62_export => qtrm_sdo_fifo_empty(62),
		
		sdi_data_qtrm63_export  => qtrm_sdi_data_hps2fifo(63),
		sdo_data_qtrm63_export  => qtrm_sdo_data_fifo2hps(63),
		sdo_rr_qtrm63_export    => qtrm_sdo_rd_rqst(63),
		sdo_empty_qtrm63_export => qtrm_sdo_fifo_empty(63),
		
		sdi_data_qtrm64_export  => qtrm_sdi_data_hps2fifo(64),
		sdo_data_qtrm64_export  => qtrm_sdo_data_fifo2hps(64),
		sdo_rr_qtrm64_export    => qtrm_sdo_rd_rqst(64),
		sdo_empty_qtrm64_export => qtrm_sdo_fifo_empty(64),
		
		sdi_data_qtrm65_export  => qtrm_sdi_data_hps2fifo(65),
		sdo_data_qtrm65_export  => qtrm_sdo_data_fifo2hps(65),
		sdo_rr_qtrm65_export    => qtrm_sdo_rd_rqst(65),
		sdo_empty_qtrm65_export => qtrm_sdo_fifo_empty(65),
		
		sdi_data_qtrm66_export  => qtrm_sdi_data_hps2fifo(66),
		sdo_data_qtrm66_export  => qtrm_sdo_data_fifo2hps(66),
		sdo_rr_qtrm66_export    => qtrm_sdo_rd_rqst(66),
		sdo_empty_qtrm66_export => qtrm_sdo_fifo_empty(66),
		
		sdi_data_qtrm67_export  => qtrm_sdi_data_hps2fifo(67),
		sdo_data_qtrm67_export  => qtrm_sdo_data_fifo2hps(67),
		sdo_rr_qtrm67_export    => qtrm_sdo_rd_rqst(67),
		sdo_empty_qtrm67_export => qtrm_sdo_fifo_empty(67),
		
		sdi_data_qtrm68_export  => qtrm_sdi_data_hps2fifo(68),
		sdo_data_qtrm68_export  => qtrm_sdo_data_fifo2hps(68),
		sdo_rr_qtrm68_export    => qtrm_sdo_rd_rqst(68),
		sdo_empty_qtrm68_export => qtrm_sdo_fifo_empty(68),
		
		sdi_data_qtrm69_export  => qtrm_sdi_data_hps2fifo(69),
		sdo_data_qtrm69_export  => qtrm_sdo_data_fifo2hps(69),
		sdo_rr_qtrm69_export    => qtrm_sdo_rd_rqst(69),
		sdo_empty_qtrm69_export => qtrm_sdo_fifo_empty(69),
		
		sdi_data_qtrm70_export  => qtrm_sdi_data_hps2fifo(70),
		sdo_data_qtrm70_export  => qtrm_sdo_data_fifo2hps(70),
		sdo_rr_qtrm70_export    => qtrm_sdo_rd_rqst(70),
		sdo_empty_qtrm70_export => qtrm_sdo_fifo_empty(70),
		
		sdi_data_qtrm71_export  => qtrm_sdi_data_hps2fifo(71),
		sdo_data_qtrm71_export  => qtrm_sdo_data_fifo2hps(71),
		sdo_rr_qtrm71_export    => qtrm_sdo_rd_rqst(71),
		sdo_empty_qtrm71_export => qtrm_sdo_fifo_empty(71),
		
		sdi_data_qtrm72_export  => qtrm_sdi_data_hps2fifo(72),
		sdo_data_qtrm72_export  => qtrm_sdo_data_fifo2hps(72),
		sdo_rr_qtrm72_export    => qtrm_sdo_rd_rqst(72),
		sdo_empty_qtrm72_export => qtrm_sdo_fifo_empty(72),
		
		sdi_data_qtrm73_export  => qtrm_sdi_data_hps2fifo(73),
		sdo_data_qtrm73_export  => qtrm_sdo_data_fifo2hps(73),
		sdo_rr_qtrm73_export    => qtrm_sdo_rd_rqst(73),
		sdo_empty_qtrm73_export => qtrm_sdo_fifo_empty(73),
		
		sdi_data_qtrm74_export  => qtrm_sdi_data_hps2fifo(74),
		sdo_data_qtrm74_export  => qtrm_sdo_data_fifo2hps(74),
		sdo_rr_qtrm74_export    => qtrm_sdo_rd_rqst(74),
		sdo_empty_qtrm74_export => qtrm_sdo_fifo_empty(74),
		
		sdi_data_qtrm75_export  => qtrm_sdi_data_hps2fifo(75),
		sdo_data_qtrm75_export  => qtrm_sdo_data_fifo2hps(75),
		sdo_rr_qtrm75_export    => qtrm_sdo_rd_rqst(75),
		sdo_empty_qtrm75_export => qtrm_sdo_fifo_empty(75),
		
		sdi_data_qtrm76_export  => qtrm_sdi_data_hps2fifo(76),
		sdo_data_qtrm76_export  => qtrm_sdo_data_fifo2hps(76),
		sdo_rr_qtrm76_export    => qtrm_sdo_rd_rqst(76),
		sdo_empty_qtrm76_export => qtrm_sdo_fifo_empty(76),
		
		sdi_data_qtrm77_export  => qtrm_sdi_data_hps2fifo(77),
		sdo_data_qtrm77_export  => qtrm_sdo_data_fifo2hps(77),
		sdo_rr_qtrm77_export    => qtrm_sdo_rd_rqst(77),
		sdo_empty_qtrm77_export => qtrm_sdo_fifo_empty(77),
		
		sdi_data_qtrm78_export  => qtrm_sdi_data_hps2fifo(78),
		sdo_data_qtrm78_export  => qtrm_sdo_data_fifo2hps(78),
		sdo_rr_qtrm78_export    => qtrm_sdo_rd_rqst(78),
		sdo_empty_qtrm78_export => qtrm_sdo_fifo_empty(78),
		
		sdi_data_qtrm79_export  => qtrm_sdi_data_hps2fifo(79),
		sdo_data_qtrm79_export  => qtrm_sdo_data_fifo2hps(79),
		sdo_rr_qtrm79_export    => qtrm_sdo_rd_rqst(79),
		sdo_empty_qtrm79_export => qtrm_sdo_fifo_empty(79),
		sdi_data_qtrm80_export  => qtrm_sdi_data_hps2fifo(80),
		sdo_data_qtrm80_export  => qtrm_sdo_data_fifo2hps(80),
		sdo_rr_qtrm80_export    => qtrm_sdo_rd_rqst(80),
		sdo_empty_qtrm80_export => qtrm_sdo_fifo_empty(80),
		
		sdi_data_qtrm81_export  => qtrm_sdi_data_hps2fifo(81),
		sdo_data_qtrm81_export  => qtrm_sdo_data_fifo2hps(81),
		sdo_rr_qtrm81_export    => qtrm_sdo_rd_rqst(81),
		sdo_empty_qtrm81_export => qtrm_sdo_fifo_empty(81),
		
		sdi_data_qtrm82_export  => qtrm_sdi_data_hps2fifo(82),
		sdo_data_qtrm82_export  => qtrm_sdo_data_fifo2hps(82),
		sdo_rr_qtrm82_export    => qtrm_sdo_rd_rqst(82),
		sdo_empty_qtrm82_export => qtrm_sdo_fifo_empty(82),
		
		sdi_data_qtrm83_export  => qtrm_sdi_data_hps2fifo(83),
		sdo_data_qtrm83_export  => qtrm_sdo_data_fifo2hps(83),
		sdo_rr_qtrm83_export    => qtrm_sdo_rd_rqst(83),
		sdo_empty_qtrm83_export => qtrm_sdo_fifo_empty(83),
		
		sdi_data_qtrm84_export  => qtrm_sdi_data_hps2fifo(84),
		sdo_data_qtrm84_export  => qtrm_sdo_data_fifo2hps(84),
		sdo_rr_qtrm84_export    => qtrm_sdo_rd_rqst(84),
		sdo_empty_qtrm84_export => qtrm_sdo_fifo_empty(84),
		
		sdi_data_qtrm85_export  => qtrm_sdi_data_hps2fifo(85),
		sdo_data_qtrm85_export  => qtrm_sdo_data_fifo2hps(85),
		sdo_rr_qtrm85_export    => qtrm_sdo_rd_rqst(85),
		sdo_empty_qtrm85_export => qtrm_sdo_fifo_empty(85),
		
		sdi_data_qtrm86_export  => qtrm_sdi_data_hps2fifo(86),
		sdo_data_qtrm86_export  => qtrm_sdo_data_fifo2hps(86),
		sdo_rr_qtrm86_export    => qtrm_sdo_rd_rqst(86),
		sdo_empty_qtrm86_export => qtrm_sdo_fifo_empty(86),
		
		sdi_data_qtrm87_export  => qtrm_sdi_data_hps2fifo(87),
		sdo_data_qtrm87_export  => qtrm_sdo_data_fifo2hps(87),
		sdo_rr_qtrm87_export    => qtrm_sdo_rd_rqst(87),
		sdo_empty_qtrm87_export => qtrm_sdo_fifo_empty(87),
		
		
		sdi_data_qtrm88_export  => qtrm_sdi_data_hps2fifo(88),
		sdo_data_qtrm88_export  => qtrm_sdo_data_fifo2hps(88),
		sdo_rr_qtrm88_export    => qtrm_sdo_rd_rqst(88),
		sdo_empty_qtrm88_export => qtrm_sdo_fifo_empty(88),
		
		sdi_data_qtrm89_export  => qtrm_sdi_data_hps2fifo(89),
		sdo_data_qtrm89_export  => qtrm_sdo_data_fifo2hps(89),
		sdo_rr_qtrm89_export    => qtrm_sdo_rd_rqst(89),
		sdo_empty_qtrm89_export => qtrm_sdo_fifo_empty(89),
		
		sdi_data_qtrm90_export  => qtrm_sdi_data_hps2fifo(90),
		sdo_data_qtrm90_export  => qtrm_sdo_data_fifo2hps(90),
		sdo_rr_qtrm90_export    => qtrm_sdo_rd_rqst(90),
		sdo_empty_qtrm90_export => qtrm_sdo_fifo_empty(90),
		
		sdi_data_qtrm91_export  => qtrm_sdi_data_hps2fifo(91),
		sdo_data_qtrm91_export  => qtrm_sdo_data_fifo2hps(91),
		sdo_rr_qtrm91_export    => qtrm_sdo_rd_rqst(91),
		sdo_empty_qtrm91_export => qtrm_sdo_fifo_empty(91),
		
		sdi_data_qtrm92_export  => qtrm_sdi_data_hps2fifo(92),
		sdo_data_qtrm92_export  => qtrm_sdo_data_fifo2hps(92),
		sdo_rr_qtrm92_export    => qtrm_sdo_rd_rqst(92),
		sdo_empty_qtrm92_export => qtrm_sdo_fifo_empty(92),
		
		sdi_data_qtrm93_export  => qtrm_sdi_data_hps2fifo(93),
		sdo_data_qtrm93_export  => qtrm_sdo_data_fifo2hps(93),
		sdo_rr_qtrm93_export    => qtrm_sdo_rd_rqst(93),
		sdo_empty_qtrm93_export => qtrm_sdo_fifo_empty(93),
		
		sdi_data_qtrm94_export  => qtrm_sdi_data_hps2fifo(94),
		sdo_data_qtrm94_export  => qtrm_sdo_data_fifo2hps(94),
		sdo_rr_qtrm94_export    => qtrm_sdo_rd_rqst(94),
		sdo_empty_qtrm94_export => qtrm_sdo_fifo_empty(94),
		
		sdi_data_qtrm95_export  => qtrm_sdi_data_hps2fifo(95),
		sdo_data_qtrm95_export  => qtrm_sdo_data_fifo2hps(95),
		sdo_rr_qtrm95_export    => qtrm_sdo_rd_rqst(95),
		sdo_empty_qtrm95_export => qtrm_sdo_fifo_empty(95),

	
	sbu_cntrl_export                           => sig_sbu_cntrl,                           --                             sbu_cntrl.export
	sbu_status_export                          => sig_sbu_status,                          --                            sbu_status.export
			
	cal_cntrl_export                           => sig_cal_cntrl,                           --                             cal_cntrl.export
			
	sdo_fifo_reset_export                      => sig_sdo_fifo_reset,                       --                        sdo_fifo_reset.export
	
	cp_cntrl_export                            => cp_cntrl_sig,                            --                              cp_cntrl.export
	sob_cntrl_export                           => sob_cntrl_sig,                           --                             sob_cntrl.export
	cp_sob_strobe_export                       => cp_sob_strobe_sig,                       --                         cp_sob_strobe.export
	ttl_strobe_export                          => ttl_cntrl_sig,                          --                            ttl_strobe.export
	cp_delay_count_export                      => cp_delay_count_sig,                      --                        cp_delay_count.export
	cp_on_count_export                         => cp_on_count_sig,                         --                           cp_on_count.export
	cp_off_count_export                        => cp_off_count_sig,                        --                          cp_off_count.export
	cp_pulse_count_export                      => cp_pulse_count_sig,                      --                        cp_pulse_count.export
	sob_delay_count_export                     => sob_delay_count_sig,                     --                       sob_delay_count.export
	sob_on_count_export                        => sob_on_count_sig,                        --                          sob_on_count.export
	sob_off_count_export                       => sob_off_count_sig,                       --                         sob_off_count.export
	sob_pulse_count_export                     => sob_pulse_count_sig,                     --                       sob_pulse_count.export
	ttl_delay_count_export                     => ttl_delay_count_sig,                     --                       ttl_delay_count.export
	ttl_on_count_export                        => ttl_on_count_sig,                        --                          ttl_on_count.export
	ttl_off_count_export                       => ttl_off_count_sig,                       --                         ttl_off_count.export
	ttl_pulse_count_export                     => ttl_pulse_count_sig,                     --                       ttl_pulse_count.export
	cp_work_done_export                        => cp_work_done_sig,                        --                          cp_work_done.export
	sob_work_done_export                       => sob_work_done_sig,                       --                         sob_work_done.export
	ttl_work_done_export                       => ttl_work_done_sig,                        --                         ttl_work_done.export
	pio_temp_export                            => pio_temp
		
);


		clk_sig <= clk_25;		-- 100 MHz clock
		rst_sig <= fpga_bresetn;		-- external asyncrnous reset
	
			
	
		WR_generation : en_gen
		port map
		 ( 
			clk	 => clk_sig,
			reset	 => '1',
			en_in	 => qtrm_sdi_wr_rqst,
			en_out 	 => qtrm_sdi_wr_rqst_gen
		 );
		 
		SDO_FIFO_RESET_generation : en_gen
		port map
		 ( 
			clk	 => clk_sig,
			reset	 => '1',
			en_in	 => sig_sdo_fifo_reset,
			en_out 	 => sig_sdo_fifo_reset_gen
			

		 );
		 
		 
		sdi_module_GEN : FOR i IN 0 TO QTRM_COUNT_const GENERATE
			n_sdi_module : sdi_module
			 port map
			 (
			  clk 			=> clk_sig,
			  rst 			=> '1',
			  data_in		=> qtrm_sdi_fifo_data_out(i),--X"53ac",
			  fifo_rd_rqst 		=> qtrm_sdi_fifo_rd_rqst(i),
			  tx_start  		=> not qtrm_sdi_fifo_empty(i),--'1',
			  sdi_out		=> FPGA_AQC_QTRM_SDI(i),
			  tx_done_tick 		=> open
			 );
		END GENERATE sdi_module_GEN;
	
		sdo_module_GEN : FOR i IN 0 TO QTRM_COUNT_const GENERATE
			n_sd0_module : sdo_module
			 port map
			 (
			  clk 			=> clk_sig,
			  rst 			=> '1',
			  sdo_in		=> FPGA_QTRM_AQC_SDO_regen(i),
			  data_reg		=> qtrm_data_out(i),
			  rx_done_tick		=> qtrm_rx_done_tick(i)
			 );
		END GENERATE sdo_module_GEN;
		
			
		sdi_fifo_GEN : FOR i IN 0 TO QTRM_COUNT_const GENERATE
			n_sdi_fifo : sdi_fifo
			port map 
			(
				clock => not clk_sig,
				aclr  => '0',
				
				full  => qtrm_sdi_fifo_full(i),
				data  => qtrm_sdi_data_hps2fifo(i), 
				wrreq => qtrm_sdi_wr_rqst_gen,

				empty => qtrm_sdi_fifo_empty(i), 					
				rdreq => qtrm_sdi_fifo_rd_rqst(i), 				
				q     => qtrm_sdi_fifo_data_out(i)   
				

			);
		END GENERATE sdi_fifo_GEN;
		
				
			
		n_sdo_GEN : FOR i IN 0 TO QTRM_COUNT_const GENERATE
			n_sdo_fifo : sdo_fifo
			port map 
			(
				clock => not clk_sig,
				aclr  => sig_sdo_fifo_reset_gen,
				
				full  => open,
				data  => qtrm_data_out(i), 
				wrreq => qtrm_rx_done_tick(i),

				empty => qtrm_sdo_fifo_empty(i), 					
				rdreq => qtrm_sdo_rd_rqst_gen(i), 				
				q     => qtrm_sdo_data_fifo2hps(i)   
				
			);
		END GENERATE n_sdo_GEN;
		
		en_gen_GEN : FOR i IN 0 TO QTRM_COUNT_const GENERATE
			n_en_gen : en_gen
				port map
				( 
					clk	 => clk_sig,
					reset	 => '1',
					en_in	 => qtrm_sdo_rd_rqst(i),
					en_out   => qtrm_sdo_rd_rqst_gen(i)
				);
		END GENERATE en_gen_GEN;
 		
		synchronizer_GEN : FOR i IN 0 TO QTRM_COUNT_const GENERATE
			 n_synchronizer : synchronizer
			 port map
			 (
			  clk 		=> clk_sig,
			  rst 		=> '1',
			  in_async	=> FPGA_QTRM_AQC_SDO(i),
			  out_sync	=> FPGA_QTRM_AQC_SDO_regen(i)
			 );
		END GENERATE synchronizer_GEN;
 

		----------------------------QTRM0 PORTMAPS START-------------------------------------	
--		A_qtrm0 : sdi_module
--			 port map
--			 (
--			  clk 			=> clk_sig,
--			  rst 			=> '1',
--			  data_in		=> qtrm0_sdi_fifo_data_out,--X"53ac",
--			  fifo_rd_rqst 		=> qtrm0_sdi_fifo_rd_rqst,
--			  tx_start  		=> not qtrm0_sdi_fifo_empty,--'1',
--			  sdi_out		=> FPGA_AQC_QTRM0_SDI,
--			  tx_done_tick 		=> open
--			 );

--		B_qtrm0 : sdo_module
--			 port map
--			 (
--			  clk 			=> clk_sig,
--			  rst 			=> '1',
--			  sdo_in		=> FPGA_QTRM0_AQC_SDO_regen,
--			  data_reg		=> qtrm0_data_out,
--			  rx_done_tick		=> qtrm0_rx_done_tick
--			 );
--			 
--	 			 
--		D_qtrm0 : sdi_fifo
--			port map 
--			(
--				clock => not clk_sig,
--				aclr  => '0',
--				
--				full  => qtrm0_sdi_fifo_full,
--				data  => qtrm0_sdi_data_hps2fifo, 
--				wrreq => qtrm_sdi_wr_rqst_gen,
--
--				empty => qtrm0_sdi_fifo_empty, 					
--				rdreq => qtrm0_sdi_fifo_rd_rqst, 				
--				q     => qtrm0_sdi_fifo_data_out,   
--				
--				usedw => Open 
--
--			);


--		E_qtrm0 : sdo_fifo
--			port map 
--			(
--				clock => not clk_sig,
--				aclr  => sig_sdo_fifo_reset_gen,
--				
--				full  => open,
--				data  => qtrm0_data_out, 
--				wrreq => qtrm0_rx_done_tick,
--
--				empty => qtrm0_sdo_fifo_empty, 					
--				rdreq => qtrm0_sdo_rd_rqst_gen, 				
--				q     => qtrm0_sdo_data_fifo2hps,   
--				
--				usedw => Open 
--			);
--				

--		F_qtrm0 : en_gen
--			port map
--			 ( 
--				clk	 => clk_sig,
--				reset	 => '1',
--				en_in	 => qtrm0_sdo_rd_rqst,
--				en_out   => qtrm0_sdo_rd_rqst_gen
--			 );	
--			 
			 
--		G_qtrm0 : synchronizer
--			 port map
--			 (
--			  clk 		=> clk_sig,
--			  rst 		=> '1',
--			  in_async	=> FPGA_QTRM0_AQC_SDO,
--			  out_sync	=> FPGA_QTRM0_AQC_SDO_regen
--			 );

----------------------------QTRM0 PORTMAPS END-------------------------------------	

		 
A	: process(clk_25)
		begin
			if rising_edge(clk_25) then
				t_reg <= t_nxt;
		end if;
	  end process;

	t_nxt <= (others => '0') when t_reg = conv_std_logic_vector(5000,28) else t_reg + 1; -- Once t_reg reaches 5000, timer_aqc restarts.

	test_clk_ref <= '1' when t_reg < conv_std_logic_vector(500,28) else '0'; --10% dutycycle
	
------------------ CP, SOB LOGIC START---------------------------

		process(cp_cntrl_sig)
		begin
			if(cp_cntrl_sig = '1') then
				FPGA_CP_sig <= '0';
			else										
				FPGA_CP_sig <= FPGA_RTGU_2_AQC_CP;
		end if;
	  end process;
	  
	  	process(sob_cntrl_sig)
		begin
			if(sob_cntrl_sig = '1') then
				FPGA_SOB_sig <= '0'; 
			else										
				FPGA_SOB_sig <= FPGA_RTGU_2_AQC_SOB; 
		end if;
	  end process;
	  	
	  FPGA_CP	<= FPGA_CP_sig; 		 
	  FPGA_SOB	<= not FPGA_SOB_sig; --inverted
	  
--	  FPGA_TTL_OUT_2 <= FPGA_CP_sig; --CP monitoring
--	  FPGA_TTL_OUT_3 <= FPGA_SOB_sig; --SOB monitoring

------------------ CP, SOB LOGIC END--------------------------
		
		process(temp_rdy)
		begin
		if (temp_rdy = '1') then
		pio_temp <= temp_out;
		end if;
		end process;
		
end SYN;