
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digi_loc_tb is
--  Port ( );
end digi_loc_tb;

architecture Behavioral of digi_loc_tb is
component digi_loc
Port (digit1, digit2, digit3, digit4 : in std_logic_vector(1 downto 0);
        key : in std_logic_vector(3 downto 0);
        clk : in std_logic;
          L : in std_logic;
          led : out std_logic_vector(15 downto 0);
          ledR, ledB, ledG : out std_logic);
end component;
constant PERIOD: time := 100 ns;
signal digit1, digit2, digit3, digit4 :  std_logic_vector(1 downto 0);
signal key : std_logic_vector(3 downto 0);
signal clk :std_logic;
signal L :  std_logic;
signal  led : std_logic_vector(15 downto 0);
signal ledR, ledB, ledG :  std_logic;

begin
DUT: digi_loc port map(
clk => clk,
key=>key,
digit1=> digit1,
digit2=>digit2,
digit3=>digit3,
digit4=>digit4,
L=>L,
led=>led,
ledR=>ledR, 
ledB=>ledB,
 ledG=> ledG);
 STIMULUS1: process
begin


key<="0000";
digit1<="01";
digit2<="00";
digit3<="10";
digit4<="00";
L<='0';

wait for 400 ns;

key<="0000";
digit1<="00";
digit2<="00";
digit3<="00";
digit4<="00";
L<='1';

wait for 400 ns;

end process STIMULUS1;
clock: process
begin
clk <= '0','1' after 50 ns;
wait for 100 ns;
end process clock;
end Behavioral;
