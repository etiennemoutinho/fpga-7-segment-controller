library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Filtre_boutons is
    Port(
    clk : in std_logic;
    btnC : in std_logic;
    btnU : in std_logic;
    btnL : in std_logic;
    btnR : in std_logic;
    btnD : in std_logic;
    stabilised_btnC : out std_logic;
    stabilised_btnU : out std_logic;
    stabilised_btnL : out std_logic;
    stabilised_btnR : out std_logic;
    stabilised_btnD : out std_logic
    );
end Filtre_boutons;

architecture Behavioral of Filtre_boutons is
constant MAX_counter : unsigned(20 downto 0) := (others => '1');            -- MAX du compteur
signal counter_4 : unsigned(20 downto 0) := (others => '0');                -- Compteur filtre anti-rebond btnC
signal counter_3 : unsigned(20 downto 0) := (others => '0');                -- Compteur filtre anti-rebond btnU
signal counter_2 : unsigned(20 downto 0) := (others => '0');                -- Compteur filtre anti-rebond btnL
signal counter_1 : unsigned(20 downto 0) := (others => '0');                -- Compteur filtre anti-rebond btnR
signal counter_0 : unsigned(20 downto 0) := (others => '0');                -- Compteur filtre anti-rebond btnD
signal current_btn : std_logic_vector(4 downto 0) := (others => '0');       -- Etat actuel pour btnC, btnU, btnL, btnR, btnD
signal prev_btn : std_logic_vector(4 downto 0) := (others => '0');          -- Etat précédent pour btnC, btnU, btnL, btnR, btnD


begin

process(clk)
    begin
    
    if rising_edge(clk) then
        current_btn(4) <= btnC;
        current_btn(3) <= btnU;
        current_btn(2) <= btnL;
        current_btn(1) <= btnR;
        current_btn(0) <= btnD;
        
        -- Filtrage des boutons : Si l'état du bouton reste inchangé pendant un certain temps (remplissage compteur), alors l'état est stable
        
        if current_btn(4) /= prev_btn(4) then           -- Gestion bouton C
            counter_4 <= (others => '0');
        else
            if counter_4 < MAX_counter then
                counter_4 <= counter_4 +1;
            else
                counter_4 <= (others => '0');
                stabilised_btnC <= current_btn(4);
            end if;
        end if;
        
        if current_btn(3) /= prev_btn(3) then           -- Gestion bouton U                   
            counter_3 <= (others => '0');
        else
            if counter_3 < MAX_counter then
                counter_3 <= counter_3 +1;
            else
                counter_3 <= (others => '0');
                stabilised_btnU <= current_btn(3);
            end if;
        end if;
        
        if current_btn(2) /= prev_btn(2) then           -- Gestion bouton L
            counter_2 <= (others => '0');
        else
            if counter_2 < MAX_counter then
                counter_2 <= counter_2 +1;
            else
                counter_2 <= (others => '0');
                stabilised_btnL <= current_btn(2);
            end if;
        end if;
        
        if current_btn(1) /= prev_btn(1) then           -- Gestion bouton R
            counter_1 <= (others => '0');
        else
            if counter_1 < MAX_counter then
                counter_1 <= counter_1 +1;
            else
                counter_1 <= (others => '0');
                stabilised_btnR <= current_btn(1);
            end if;
        end if;
        
        if current_btn(0) /= prev_btn(0) then           -- Gestion bouton D
            counter_0 <= (others => '0');
        else
            if counter_0 < MAX_counter then
                counter_0 <= counter_0 +1;
            else
                counter_0 <= (others => '0');
                stabilised_btnD <= current_btn(0);
            end if;
        end if;
        
        prev_btn(4) <= current_btn(4);
        prev_btn(3) <= current_btn(3); 
        prev_btn(2) <= current_btn(2); 
        prev_btn(1) <= current_btn(1); 
        prev_btn(0) <= current_btn(0); 
        
    end if;
                
end process;
end Behavioral;
