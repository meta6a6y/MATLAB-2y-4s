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
disp(['Ранг матрицы: ', num2str(submatrix_size)]); % Определение ранг матрицы способом миноров

[num_rows, num_cols] = size(matrix); % Определяются количество строк и столбцов в исходной матрице

for i = 1:(num_rows - submatrix_size + 1) % Запуск двойного цикла для перебора всех возможных подматриц размером ранга матрицы
    for j = 1:(num_cols - submatrix_size + 1)
        submatrix = matrix(i:i+submatrix_size-1, j:j+submatrix_size-1);
        determinant = det(submatrix); % Для каждой подматрицы подсчет определителя
        if determinant > 0 % Если определитель не равен нулю, то  выводится его значение и сама подматрица
            disp(['Определитель подматрицы: ', num2str(determinant)]);
            disp('Подматрица:');
            disp(submatrix);
            disp('----------------');
        end
    end
end
