# ft_linear_regression
В этом проекте реализован мой первый алгоритм машинного обучения.

В репозитории представлены две версии программы консольная и версия с графическим интерфейсом.

В данном проекте представлена реализация линейной регрессии. Суть которой заключается в определении коэффициентов k и b для построения прямой, минимально удаленной от всех точек графика данных.

Нахождение коэффициентов k и b выполняется на основе среднеквадратичной функции потерь (MSE среднеквадратичная ошибка).

<a href="https://www.codecogs.com/eqnedit.php?latex=MSE&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(Y_{i}&space;-&space;y_{i})^2}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?MSE&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(Y_{i}&space;-&space;y_{i})^2}{n}" title="MSE = \sum_{i = 0}^{n}\frac{(Y_{i} - y_{i})^2}{n}" /></a>

Где Yi это значение прямой, а yi это значение данных из файла.

<a href="https://www.codecogs.com/eqnedit.php?latex=Y&space;=&space;k&space;\cdot&space;x&space;&plus;&space;b" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Y&space;=&space;k&space;\cdot&space;x&space;&plus;&space;b" title="Y = k \cdot x + b" /></a>

Подставим в формулу и получим функцию от двух переменных.

<a href="https://www.codecogs.com/eqnedit.php?latex=f(k,&space;b)&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})^2}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?f(k,&space;b)&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})^2}{n}" title="f(k, b) = \sum_{i = 0}^{n}\frac{(k \cdot x_{i} + b - y_{i})^2}{n}" /></a>

Далее нужно найти минимальное значение получившейся функции, для этого нам нужно взять частные производные по k и по b.

<a href="https://www.codecogs.com/eqnedit.php?latex=f'(k,&space;b)_k&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})\cdot&space;x_i}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?f'(k,&space;b)_k&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})\cdot&space;x_i}{n}" title="f'(k, b)_k = \sum_{i = 0}^{n}\frac{2\cdot (k \cdot x_{i} + b - y_{i})\cdot x_i}{n}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=f'(k,&space;b)_b&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?f'(k,&space;b)_b&space;=&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})}{n}" title="f'(k, b)_b = \sum_{i = 0}^{n}\frac{2\cdot (k \cdot x_{i} + b - y_{i})}{n}" /></a>

Решив получившуюся систему уравнений мы получим коэффициенты k и b.

<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{150}&space;\left\{\begin{matrix}&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})&space;}{n}&space;=&space;0&space;\\&space;\\\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})\cdot&space;x_i}{n}&space;=&space;0&space;\end{matrix}\right." target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{150}&space;\left\{\begin{matrix}&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})&space;}{n}&space;=&space;0&space;\\&space;\\\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})\cdot&space;x_i}{n}&space;=&space;0&space;\end{matrix}\right." title="\left\{\begin{matrix} \sum_{i = 0}^{n}\frac{2\cdot (k \cdot x_{i} + b - y_{i}) }{n} = 0 \\ \\\sum_{i = 0}^{n}\frac{2\cdot (k \cdot x_{i} + b - y_{i})\cdot x_i}{n} = 0 \end{matrix}\right." /></a>

В проекте для нахождения коэффициентов k и b используются метод градиентного спуска. Подбирается шаг lr и "спускаемся" по функциям частных производных высчитывая на каждом шагу коэффициенты k и b. Делаем это до тех пор пока среднеквадратичная ошибка (MSE) на текущем шаге не будет больше чем на предыдущем.

<a href="https://www.codecogs.com/eqnedit.php?latex=k_{new}&space;=&space;k&space;-&space;lr\cdot&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})\cdot&space;x_i}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?k_{new}&space;=&space;k&space;-&space;lr\cdot&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})\cdot&space;x_i}{n}" title="k_{new} = k - lr\cdot \sum_{i = 0}^{n}\frac{2\cdot (k \cdot x_{i} + b - y_{i})\cdot x_i}{n}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=b_{new}&space;=&space;b&space;-&space;lr\cdot&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})}{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?b_{new}&space;=&space;b&space;-&space;lr\cdot&space;\sum_{i&space;=&space;0}^{n}\frac{2\cdot&space;(k&space;\cdot&space;x_{i}&space;&plus;&space;b&space;-&space;y_{i})}{n}" title="b_{new} = b - lr\cdot \sum_{i = 0}^{n}\frac{2\cdot (k \cdot x_{i} + b - y_{i})}{n}" /></a>

## Консольная версия
Консольная версия представлена в виде двух программ. Программы по обучении (ft_linear_regression) и программы по выводу значения (forecast). Программа ft_linear_regression считывает данные из файла, имя которого передается вторым аргументом при запуске. На основе данных вычисляет коэффициенты k и b прямой линии, минимально отдаленной от всех точек. Коэффициенты k и b сохраняются в файл "rezult.csv". Программа forecast считывает коэффициенты k и b из файла "rezult.csv" и выводит значение линейной функции на основе числа переданного в качестве второго аргумента.

### Использование

    git clone https://github.com/MixFon/ft_linear_regression.git
    cd ft_linear_regression/LinearRegression/LinearRegression
    make
    ./ft_linear_regression data.csv
    > -0.019402453931589177 8008.438885070447
    cat rezult.csv
    > k,b
    > -0.019402453931589177,8008.438885070447
    ./forecast 74000
    > k = -0.019402453931589177
    > b = 8008.438885070447
    > 6572.657294132849


## Визуальный режим

Визуальный режим находится ветке UILinearRegression.

В визуальном режиме совмещены две программы в одну. В окно ввода текста вводнится информация для обучения. После нажатия на кнопку Read информация считывается и обрабатывается.

### Использование

Для запуска визуального режима необходим XCode.

    git clone https://github.com/MixFon/ft_linear_regression.git
    cd ft_linear_regression
    git checkout UILinearRegression
    cd UILinearRegression
    open UILinearRegression.xcodeproj

![gif](https://github.com/MixFon/ft_linear_regression/blob/master/images/Screen_Recording.gif)
