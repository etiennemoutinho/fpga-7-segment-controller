library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Bloc_Logique is
    Port(
    clk : in std_logic;
    stabilised_btnC : in std_logic;
    stabilised_btnU : in std_logic;
    stabilised_btnL : in std_logic;
    stabilised_btnR : in std_logic;
    stabilised_btnD : in std_logic;
    unit_AN0 : out std_logic_vector(3 downto 0);
    unit_AN1 : out std_logic_vector(3 downto 0);
    unit_AN2 : out std_logic_vector(3 downto 0);
    unit_AN3 : out std_logic_vector(3 downto 0)
    );
end Bloc_Logique;

architecture Behavioral of Bloc_Logique is
signal unit_0 : unsigned(3 downto 0) := (others => '0');                    -- Chiffres associés à chacun des 4 digits
signal unit_1 : unsigned(3 downto 0) := (others => '0');
signal unit_2 : unsigned(3 downto 0) := (others => '0');
signal unit_3 : unsigned(3 downto 0) := (others => '0');
signal current_digit : unsigned(1 downto 0) := (others => '0');             -- Sélection du digit à éditer
signal current_btn : std_logic_vector(4 downto 0) := (others => '0');       -- Etat actuel pour btnC, btnU, btnL, btnR, btnD
signal prev_btn : std_logic_vector(4 downto 0) := (others => '0');          -- Etat précédent pour btnC, btnU, btnL, btnR, btnD

begin

process(clk)
    
    begin
    if rising_edge(clk) then                                            -- Changement des variables sur front d'horloge
        current_btn(4) <= stabilised_btnC;
        current_btn(3) <= stabilised_btnU;
        current_btn(2) <= stabilised_btnL;
        current_btn(1) <= stabilised_btnR;
        current_btn(0) <= stabilised_btnD;

    -- Priorité la plus haute : Reset
        
        if current_btn(4) = '1' and prev_btn(4) = '0' then              -- Appui sur BtnC => Reset des chiffres (passent à la valeur 0)
            unit_0 <= (others => '0');
            unit_1 <= (others => '0');
            unit_2 <= (others => '0');
            unit_3 <= (others => '0');
            
    -- Priorité intermédiaire : Sélection du digit
            
        elsif current_btn(2) = '1' and prev_btn(2) = '0' then           -- Appui sur BtnL => Incrémentation sélection digit           
            if current_digit < "11" then           
                current_digit <= current_digit +1;
            end if;
        elsif current_btn(1) = '1' and prev_btn(1) = '0' then           -- Appui sur BtnR => Décrémentation sélection digit
            if current_digit > "00" then           
                current_digit <= current_digit -1;
            end if;
            
    -- Priorité la plus basse : Changement de valeur du chiffre associé au digit sélectionné
            
        elsif current_btn(3) = '1' and prev_btn(3) = '0' then           -- Appui sur BtnU => Incrémentation chiffre associé au digit sélectionné
            if current_digit = "00" then
                if unit_0 < 9 then
                    unit_0 <= unit_0 +1;
                end if;
            elsif current_digit = "01" then
                if unit_1 < 9 then
                    unit_1 <= unit_1 +1;
                end if;
            elsif current_digit = "10" then
                if unit_2 < 9 then
                    unit_2 <= unit_2 +1;
                end if;
            elsif current_digit = "11" then
                if unit_3 < 9 then
                    unit_3 <= unit_3 +1;
                end if;
            end if;
            
        elsif current_btn(0) = '1' and prev_btn(0) = '0' then           -- Appui sur BtnD => Décrémentation chiffre associé au digit sélectionné
            if current_digit = "00" then
                if unit_0 > 0 then
                    unit_0 <= unit_0 -1;
                end if;
            elsif current_digit = "01" then
                if unit_1 > 0 then
                    unit_1 <= unit_1 -1;
                end if;
            elsif current_digit = "10" then
                if unit_2 > 0 then
                    unit_2 <= unit_2 -1;
                end if;
            elsif current_digit = "11" then
                if unit_3 > 0 then
                    unit_3 <= unit_3 -1;
                end if;
            end if;
         end if;
         
        prev_btn(4) <= current_btn(4);
        prev_btn(3) <= current_btn(3); 
        prev_btn(2) <= current_btn(2); 
        prev_btn(1) <= current_btn(1); 
        prev_btn(0) <= current_btn(0);
         
     end if;
     
    unit_AN0 <= std_logic_vector(unit_0);
    unit_AN1 <= std_logic_vector(unit_1);
    unit_AN2 <= std_logic_vector(unit_2);
    unit_AN3 <= std_logic_vector(unit_3);
     
     
end process;
end Behavioral;
