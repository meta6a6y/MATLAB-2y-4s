matrix = [1, 0, 0, 0, 0, 2;
          0, 1, 0, 2, 2, 0;
          0, 1, 0, 0, 0, 2;
          1, 0, 0, 2, 2, 0;
          0, 0, 2, 0, 3, 0;
          0, 1, 0, 0, 3, 0;
          0, 0, 1, 0, 0, 1;
          0, 1, 0, 0, 1, 0;
          0, 0, 0, 0, 2, 0];

submatrix_size = rank_by_minors(matrix);
disp(['���� �������: ', num2str(submatrix_size)]); % ����������� ���� ������� �������� �������

[num_rows, num_cols] = size(matrix); % ������������ ���������� ����� � �������� � �������� �������

for i = 1:(num_rows - submatrix_size + 1) % ������ �������� ����� ��� �������� ���� ��������� ��������� �������� ����� �������
    for j = 1:(num_cols - submatrix_size + 1)
        submatrix = matrix(i:i+submatrix_size-1, j:j+submatrix_size-1);
        determinant = det(submatrix); % ��� ������ ���������� ������� ������������
        if determinant > 0 % ���� ������������ �� ����� ����, ��  ��������� ��� �������� � ���� ����������
            disp(['������������ ����������: ', num2str(determinant)]);
            disp('����������:');
            disp(submatrix);
            disp('----------------');
        end
    end
end
