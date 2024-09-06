M = [3 0 1 2 4; 1 5 3 1 8; 0 -1 0 7 2; 2 -3 8 1 9];

function Mprime = multFilaK(M, i, k)
    Mprime = M;
    Mprime(i, :) = k * M(i, :);
end

function Mprime = sume(M, i, j, k)
    Mprime = M;
    Mprime(i, :) = M(i, :) + k * M(j, :);
end
function valores = resuelva(M)
    [filas, columnas] = size(M);
    if columnas ~= filas + 1
        error('La matriz no tiene el tamaño correcto.');
    end

    for i = 1:filas
        % Hacer el elemento M(i, i) igual a 1
        M = multFilaK(M, i, 1 / M(i, i));
        for j = 1:filas
            if i ~= j
                % Hacer el elemento M(j, i) igual a 0
                M = sume(M, j, i, -M(j, i));
            end
        end
    end

    valores = M(:, end);
end

valores = resuelva(M);
disp('Los valores de las variables del sistema de ecuaciones son:');
disp(valores);
