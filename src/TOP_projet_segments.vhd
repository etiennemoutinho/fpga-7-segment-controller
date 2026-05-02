library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TOP_projet_segments is
    Port(
    clk : in std_logic;
    btnC : in std_logic;
    btnU : in std_logic;
    btnL : in std_logic;
    btnR : in std_logic;
    btnD : in std_logic;
    an : out std_logic_vector(3 downto 0);
    seg : out std_logic_vector(6 downto 0)
    );
end TOP_projet_segments;

architecture Behavioral of TOP_projet_segments is
signal stabilised_btnC : std_logic;
signal stabilised_btnU : std_logic;
signal stabilised_btnL : std_logic;
signal stabilised_btnR : std_logic;
signal stabilised_btnD : std_logic;
signal unit_AN0 : std_logic_vector(3 downto 0);
signal unit_AN1 : std_logic_vector(3 downto 0);
signal unit_AN2 : std_logic_vector(3 downto 0);
signal unit_AN3 : std_logic_vector(3 downto 0);


component Filtre_boutons
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
end component;

component Bloc_Logique
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
end component;

component Bloc_Affichage
    Port (
    clk : in std_logic;
    unit_AN0 : in std_logic_vector(3 downto 0);
    unit_AN1 : in std_logic_vector(3 downto 0);
    unit_AN2 : in std_logic_vector(3 downto 0);
    unit_AN3 : in std_logic_vector(3 downto 0);
    an : out std_logic_vector(3 downto 0);
    seg : out std_logic_vector(6 downto 0)
    );
end component;


begin

X1 : Filtre_boutons port map(
    clk => clk,
    btnC => btnC,
    btnU => btnU,
    btnL => btnL,
    btnR => btnR,
    btnD => btnD,
    stabilised_btnC => stabilised_btnC,
    stabilised_btnU => stabilised_btnU,
    stabilised_btnL => stabilised_btnL,
    stabilised_btnR => stabilised_btnR,
    stabilised_btnD => stabilised_btnD
    );

X2 : Bloc_Logique port map(
    clk => clk,
    stabilised_btnC => stabilised_btnC,
    stabilised_btnU => stabilised_btnU,
    stabilised_btnL => stabilised_btnL,
    stabilised_btnR => stabilised_btnR,
    stabilised_btnD => stabilised_btnD,
    unit_AN0 => unit_AN0,
    unit_AN1 => unit_AN1,
    unit_AN2 => unit_AN2,
    unit_AN3 => unit_AN3
    );

X3 : Bloc_Affichage port map(
    clk => clk,
    unit_AN0 => unit_AN0,
    unit_AN1 => unit_AN1,
    unit_AN2 => unit_AN2,
    unit_AN3 => unit_AN3,
    an => an,
    seg => seg
    );

end Behavioral;
