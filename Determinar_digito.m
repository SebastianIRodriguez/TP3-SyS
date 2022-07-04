function [digito] = Determinar_digito(f1, f2)
%
%Toma como argumentos de entrada dos frecuencias, F1 y F2 (F1 < F2), y como
%argumento de salida la variable digito, correspondiente al dígito identificado. 
%Sintaxis: digito = Determinar_digito(F1, F2);
%En caso de que alguna de las frecuencias estuviera fuera del rango 
%(FL +- 1.8% y FH +- 1.8%), la variable de salida sera el digito=' ' (espacio en blanco).
%

    Fl = [697, 770, 852, 941];
    Fh = [1209, 1336, 1477, 1633];

    keyboard = [
        '1', '2', '3', 'A';
        '4', '5', '6', 'B';
        '7', '8', '9', 'C';
        '*', '0', '#', 'D';
    ];

    p_low = 0;
    p_high = 0;

    %Identificar fila en el teclado
    for i = 1:4

        if (f1 > Fl(1, i) * 0.982 && f1 < Fl(1, i) * 1.018)
            p_low = i;
        end

    end

    %Identificar columna en el teclado
    for i = 1:4

        if (f2 > Fh(1, i) * 0.982 && f2 < Fh(1, i) * 1.018)
            p_high = i;
        end

    end

    if(p_low == 0 || p_high == 0) 
        digito = ' ';
    else
        digito = keyboard(p_low, p_high);
    
    end

    

end
