library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity tb_Top_Mensaje is
end entity;

architecture sim of tb_Top_Mensaje is
    -- Señales para conectar al componente
    signal s_selector : std_logic_vector(3 downto 0) := "0000";
    signal s_display  : std_logic_vector(6 downto 0);

begin
    -- Instancia del código principal
    UUT: entity work.Top_Mensaje
        port map (
            S      => s_selector,
            Y_7seg => s_display
        );

    -- Proceso de estímulo: Cambia el selector cada 10 nanosegundos
    process
    begin
        report "Iniciando secuencia del mensaje...";
        
        for i in 0 to 15 loop
            s_selector <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        
        report "Simulación terminada.";
        wait;
    end process;
end architecture;
