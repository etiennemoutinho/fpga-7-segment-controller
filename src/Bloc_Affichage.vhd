library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Bloc_Affichage is
    Port (
    clk : in std_logic;
    unit_AN0 : in std_logic_vector(3 downto 0);
    unit_AN1 : in std_logic_vector(3 downto 0);
    unit_AN2 : in std_logic_vector(3 downto 0);
    unit_AN3 : in std_logic_vector(3 downto 0);
    an : out std_logic_vector(3 downto 0);
    seg : out std_logic_vector(6 downto 0)
    );
end Bloc_Affichage;

architecture Behavioral of Bloc_Affichage is
    -- Registre pour affichage cyclique des chiffres
    signal reg : unsigned(17 downto 0) := (others => '0');
    
    -- Patterns des segments pour afficher les chiffres
    function to_7seg(d : std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        case d is
            when "0000" => return "1000000"; -- 0
            when "0001" => return "1111001"; -- 1
            when "0010" => return "0100100"; -- 2
            when "0011" => return "0110000"; -- 3
            when "0100" => return "0011001"; -- 4
            when "0101" => return "0010010"; -- 5
            when "0110" => return "0000010"; -- 6
            when "0111" => return "1111000"; -- 7
            when "1000" => return "0000000"; -- 8
            when "1001" => return "0010000"; -- 9
            when others => return "1111111"; -- éteint
        end case;
    end;

begin

process(clk)
    begin
        if rising_edge(clk) then
            reg <= reg + 1;
        end if;
    end process;
    
process(reg, unit_AN0, unit_AN1, unit_AN2, unit_AN3)
    begin
    an <= (others => '1');                                          -- Initialisation des sorties pour ne pas les laissées indéfinies
    seg <= (others => '1');
    
    if reg < (2**17)/4 then                                         -- DIGIT AN3 : Sélection du digit et affichage du chiffre correspondant
    an(0) <= '1';
    an(1) <= '1';
    an(2) <= '1';
    an(3) <= '0';
    seg <= to_7seg(unit_AN3);
    
    elsif reg < 2*((2**17)/4) then                                  -- DIGIT AN2 : Sélection du digit et affichage du chiffre correspondant
    an(0) <= '1';
    an(1) <= '1';
    an(2) <= '0';
    an(3) <= '1';
    seg <= to_7seg(unit_AN2);
    
    
    elsif reg < 3*((2**17)/4) then                                  -- DIGIT AN1 : Sélection du digit et affichage du chiffre correspondant
    an(0) <= '1';
    an(1) <= '0';
    an(2) <= '1';
    an(3) <= '1';
    seg <= to_7seg(unit_AN1);
    
    else                                                            -- DIGIT AN0 : Sélection du digit et affichage du chiffre correspondant
    an(0) <= '0';
    an(1) <= '1';
    an(2) <= '1';
    an(3) <= '1';
    seg <= to_7seg(unit_AN0);
    
    end if;
    end process;


end Behavioral;
