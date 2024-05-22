function matrix_rank = rank_by_minors(matrix)
    [m, n] = size(matrix);
    min_size = min(m, n);
    
    for r = min_size:-1:1
        % ��������� ��� ������ ��������� �������
        for i = 1:(m-r+1)
            for j = 1:(n-r+1)
                minor = matrix(i:(i+r-1), j:(j+r-1));
                
                % ���������, �� �������� �� ����� �����������
                if abs(det(minor)) > eps % eps - ��������� ��������, ����� �������� ��������� ������
                    matrix_rank = r;
                    return;
                end
            end
        end
    end
    
    % ���� �� ������� ��������� �������, ���� ����� ����
    matrix_rank = 0;
end