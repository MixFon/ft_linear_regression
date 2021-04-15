# ft_linear_regression
В этом проекте реализован мой первый алгоритм машинного обучения.

В репозитории передставлены две версии программы - консольная и оконная. 

## Консольная версия
Консольная версия представлена в виде двух программ. Программы по обучении (ft_linear_regression) и программы по выводу значения (forecast). Программа ft_linear_regression считывае данные из файла, имя которого передается вторым агрументом при запуске. На основе данных вычисляет коэффициенты k и b прямой линии, минимально отдаленной от всех точек. Коэффициенты k и b сохраняются в файл "rezult.csv". Программа forecast считывает коэффициенты k и b из файла "rezult.csv" и выводит значение линейной функции на основе числа переданного в качестве второго аргумента.

Нахождение коэффициентов k и b выпоняется на основе среднеквадратичной функции потерь (MSE среднеквадратичная ошибка).

<a href="https://www.codecogs.com/eqnedit.php?latex=MSE&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(Y_{i}&space;-&space;y_{i})^2}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?MSE&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(Y_{i}&space;-&space;y_{i})^2}{n}" title="MSE = \sum_{i = 0}^{n}\frac{(Y_{i} - y_{i})^2}{n}" /></a>

Где Yi это значение прямой, а yi это знаяение данных из файла.

<a href="https://www.codecogs.com/eqnedit.php?latex=Y&space;=&space;k&space;\cdot&space;x&space;&plus;&space;b" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Y&space;=&space;k&space;\cdot&space;x&space;&plus;&space;b" title="Y = k \cdot x + b" /></a>

Подставим в формулу и получим функцию от двух переменных.

<a href="https://www.codecogs.com/eqnedit.php?latex=f(k,&space;b)&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})^2}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?f(k,&space;b)&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})^2}{n}" title="f(k, b) = \sum_{i = 0}^{n}\frac{(k \cdot x_{i} + b - y_{i})^2}{n}" /></a>

Далнее нужно найти минимальное значение для этого нам нужно взять частные производные по k и по b.



### Использование

    git clone https://github.com/MixFon/ft_linear_regression.git
    cd ft_linear_regression/LinearRegression/LinearRegression
    make