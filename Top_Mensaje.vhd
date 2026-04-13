library IEEE;
use IEEE.std_logic_1164.all;

entity Top_Mensaje is
    port(
        S : in  std_logic_vector(3 downto 0); -- Selector (Switches)
        Y_7seg : out std_logic_vector(6 downto 0) -- Salida al Display (a-g)
    );
end entity Top_Mensaje;

architecture rtl of Top_Mensaje is

    -- Señales para los datos del mensaje (Tu número de cuenta)
    signal D0, D1, D2, D3, D4, D5, D6, D7,  
           D8, D9, D10, D11, D12, D13, D14, D15 : std_logic_vector(3 downto 0);  

    -- Señales de selección del MUX
    signal Sel : std_logic_vector(15 downto 0);
    
    -- "Cable" interno que lleva el dato del MUX al DECO
    signal dato_seleccionado : std_logic_vector(3 downto 0);

begin

    -- 1. DEFINICIÓN DEL MENSAJE (Tu lógica original)
    -- Mensaje: 319106473_2026-2  
    D0  <= "0011"; D1  <= "0001"; D2  <= "1001"; D3  <= "0001"; 
    D4  <= "0000"; D5  <= "0110"; D6  <= "0100"; D7  <= "0111"; 
    D8  <= "0011"; D9  <= "1010"; D10 <= "0010"; D11 <= "0000"; 
    D12 <= "0010"; D13 <= "0110"; D14 <= "1011"; D15 <= "0010"; 

    -- 2. LÓGICA DEL MULTIPLEXOR (Decodificación de selección)
    Sel(0)  <= not S(3) and not S(2) and not S(1) and not S(0);  
    Sel(1)  <= not S(3) and not S(2) and not S(1) and     S(0);  
    Sel(2)  <= not S(3) and not S(2) and     S(1) and not S(0);  
    Sel(3)  <= not S(3) and not S(2) and     S(1) and     S(0);  
    Sel(4)  <= not S(3) and     S(2) and not S(1) and not S(0);  
    Sel(5)  <= not S(3) and     S(2) and not S(1) and     S(0);  
    Sel(6)  <= not S(3) and     S(2) and     S(1) and not S(0);  
    Sel(7)  <= not S(3) and     S(2) and     S(1) and     S(0);  
    Sel(8)  <=     S(3) and not S(2) and not S(1) and not S(0);  
    Sel(9)  <=     S(3) and not S(2) and not S(1) and     S(0);  
    Sel(10) <=     S(3) and not S(2) and     S(1) and not S(0);  
    Sel(11) <=     S(3) and not S(2) and     S(1) and     S(0);  
    Sel(12) <=     S(3) and     S(2) and not S(1) and not S(0);  
    Sel(13) <=     S(3) and     S(2) and not S(1) and     S(0);  
    Sel(14) <=     S(3) and     S(2) and     S(1) and not S(0);  
    Sel(15) <=     S(3) and     S(2) and     S(1) and     S(0);  

    -- Salida del MUX combinacional (hacia el cable interno)
    gen_mux: for i in 0 to 3 generate
        dato_seleccionado(i) <= (D0(i) and Sel(0)) or (D1(i) and Sel(1)) or (D2(i) and Sel(2)) or 
                                (D3(i) and Sel(3)) or (D4(i) and Sel(4)) or (D5(i) and Sel(5)) or 
                                (D6(i) and Sel(6)) or (D7(i) and Sel(7)) or (D8(i) and Sel(8)) or 
                                (D9(i) and Sel(9)) or (D10(i) and Sel(10)) or (D11(i) and Sel(11)) or 
                                (D12(i) and Sel(12)) or (D13(i) and Sel(13)) or (D14(i) and Sel(14)) or 
                                (D15(i) and Sel(15));
    end generate;

    -- 3. LÓGICA DEL DECODIFICADOR (Ecuaciones combinacionales)
    -- Segmentos: abcdefg (Y_7seg)
    -- Basado en Cátodo Común (1 = encendido). Si es Ánodo Común, usa "not" al principio.
    
    Y_7seg(6) <= (not dato_seleccionado(3) and dato_seleccionado(1)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(2) and dato_seleccionado(0)) or 
                 (dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(1)) or 
                 (not dato_seleccionado(2) and not dato_seleccionado(1) and dato_seleccionado(0)); -- seg a

    Y_7seg(5) <= (not dato_seleccionado(3) and not dato_seleccionado(2)) or 
                 (not dato_seleccionado(3) and not dato_seleccionado(1) and not dato_seleccionado(0)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(1) and dato_seleccionado(0)) or 
                 (dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(1)); -- seg b

    Y_7seg(4) <= (not dato_seleccionado(3) and not dato_seleccionado(1)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(0)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(2)) or 
                 (dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(1)); -- seg c

    Y_7seg(3) <= (not dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(0)) or 
                 (not dato_seleccionado(3) and not dato_seleccionado(2) and dato_seleccionado(1)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(1) and not dato_seleccionado(0)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(2) and not dato_seleccionado(1) and dato_seleccionado(0)) or 
                 (dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(1)); -- seg d

    Y_7seg(2) <= (not dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(0)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(1) and not dato_seleccionado(0)); -- seg e

    Y_7seg(1) <= (not dato_seleccionado(3) and not dato_seleccionado(1) and not dato_seleccionado(0)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(2) and not dato_seleccionado(1)) or 
                 (not dato_seleccionado(3) and dato_seleccionado(2) and not dato_seleccionado(0)) or 
                 (dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(1)); -- seg f

    Y_7seg(0) <= (not dato_seleccionado(3) and dato_seleccionado(2) and not dato_seleccionado(1)) or 
                 (not dato_seleccionado(3) and not dato_seleccionado(2) and dato_seleccionado(1)) or 
                 (dato_seleccionado(3) and not dato_seleccionado(2) and not dato_seleccionado(1)) or 
                 (dato_seleccionado = "1011"); -- seg g (guion medio)

end architecture rtl;
