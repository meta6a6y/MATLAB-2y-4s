function matrix_rank = rank_by_minors(matrix)
    [m, n] = size(matrix);
    min_size = min(m, n);
    
    for r = min_size:-1:1
        % Проверяем все миноры заданного размера
        for i = 1:(m-r+1)
            for j = 1:(n-r+1)
                minor = matrix(i:(i+r-1), j:(j+r-1));
                
                % Проверяем, не является ли минор вырожденным
                if abs(det(minor)) > eps % eps - маленькое значение, чтобы избежать численных ошибок
                    matrix_rank = r;
                    return;
                end
            end
        end
    end
    
    % Если не найдено ненулевых миноров, ранг равен нулю
    matrix_rank = 0;
end