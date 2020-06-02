library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digi_Loc is
  Port (digit1, digit2, digit3, digit4 : in std_logic_vector(1 downto 0);
        key : in std_logic_vector(3 downto 0);
        clk : in std_logic;
          L : in std_logic;
          led : out std_logic_vector(15 downto 0);
          ledR, ledB, ledG : out std_logic);
end digi_Loc;

architecture Behavioral of digi_Loc is

-- states for the lock
type states1 is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
signal ps, ns: states1;

-- states for button press
type states2 is (up, down);
signal ps2, ns2: states2;

--temporary and stored value signal for key button press
signal temp : std_logic_vector(3 downto 0):= "0000";
signal store : std_logic_vector(3 downto 0):= "0000";

begin

process(clk)
begin
 if rising_edge(clk) then
    ps <= ns;
    ps2 <= ns2;
 end if;
end process;

process(ps, digit1, digit2, digit3, digit4, temp)
begin

 case(ps) is
    when s0 => if ((digit1 = "00" and temp = "0001") or (digit1 = "01" and temp = "0010") or (digit1 = "10" and temp = "0100") or (digit1 = "11" and temp = "1000")) then
                 ns <= s1;
               elsif (temp = "0000") then
                 ns <= s0;
               else 
                 ns <= s5;
               end if;
               
               led <= "1000000000000000"; --idle state
               ledR <= '0';
               ledB <= '1';
               ledG <= '0';

    when s1 => if ((digit2 = "00" and temp = "0001") or (digit2 = "01" and temp = "0010") or (digit2 = "10" and temp = "0100") or (digit2 = "11" and temp = "1000")) then
                 ns <= s2;
               elsif (temp = "0000") then
                 ns <= S1;
               else
                 ns <= s6;
               end if;
               
               led <= "0100000000000000"; --1st correct sequence 
               ledR <= '0';
               ledB <= '0';
               ledG <= '0';
               
    when s2 => if ((digit3 = "00" and temp = "0001") or (digit3 = "01" and temp = "0010") or (digit3 = "10" and temp = "0100") or (digit3 = "11" and temp = "1000")) then
                 ns <= s3;
               elsif (temp = "0000") then
                 ns <= S2;
               else
                 ns <= s7;
               end if;
                          
               led <= "0010000000000000"; --2nd correct sequence
               ledR <= '0';
               ledB <= '0';
               ledG <= '0';
                          
    when s3 => if ((digit4 = "00" and temp = "0001") or (digit4 = "01" and temp = "0010") or (digit4 = "10" and temp = "0100") or (digit4 = "11" and temp = "1000")) then
                 ns <= s4;
               elsif (temp = "0000") then
                 ns <= S3;
               else
                 ns <= s8;
               end if;
                                     
               led <= "0001000000000000";  --3rd correct sequence
               ledR <= '0';
               ledB <= '0';
               ledG <= '0';
               
    when s4 => ns <= s4;
               led <= "0000100000000000"; --4th correct sequence
               ledR <= '0'; -- green shows correct sequence is pressed
               ledB <= '0';
               ledG <= '1';
               
    when s5 => if (temp = "0000") then
                 ns <= s5;
               else
                 ns <= s6;
               end if;
               
               led <= "0000010000000000";   --bad key 1st sequence
               ledR <= '0';
               ledB <= '0';
               ledG <= '0';
               
    when s6 => if (temp = "0000") then
                 ns <= s6;
               else
                 ns <= s7;
               end if;
               
               led <= "0000001000000000";   --bad key at 2nd sequence
               ledR <= '0';
               ledB <= '0';
               ledG <= '0';
               
    when s7 => if (temp = "0000") then
                 ns <= s7;
               else
                 ns <= s8;
               end if;
               
               led <= "0000000100000000";   --bad key at 3rd sequence
               ledR <= '0';
               ledB <= '0';
               ledG <= '0';
               
    when s8 => ns <= s8;
               led <= "0000000010000000";  --bad key at 4th sequence
               ledR <= '1';  --Red color indicates sequence was wrong
               ledB <= '0';
               ledG <= '0';
  end case;
  
  if (L = '1') then
    ns <= s0;
  end if;
end process;


-- Button Press

process(ps2, key)
begin

  case(ps2) is
    when up => if (key = "0000") then   -- Button has not been pressed
                 ns2 <= up;
                 temp <= "0000";
               else
                 ns2 <= down;
                 store <= key;
                 temp <= "0000”-- Store the button Pressed value 
               end if;
    when down => if (key = "0000") then       -- Button held down
                   ns2 <= up;                    
                   temp <= store;
                 else
                   ns2 <= down;
                   temp <= "0000
                 end if;
  end case;
end process;

end Behavioral;
