#import "requirements.typ": *
#import "common.typ": *

#set text(lang: "rus")
#set page(
    paper: "a4",
    margin: (top: 3cm, rest: 0.5cm, bottom: 1cm),
    numbering: "1"
    )

#show heading.where(level: 1): it => [
  #set text(14pt, weight: "bold")
  #it
]

#show heading.where(level: 2): it => [
  #set text(12pt, weight: "bold")
  #it
]

#let Green(x) = text(green.darken(20%), x)
#let Red(x) = text(red.darken(20%), x)
#let Blue(x) = text(blue.darken(20%), x)
#let Orange(x) = text(orange.darken(20%), x)

#let pinit-highlight-equation-from(height: 2em, pos: bottom, fill: rgb(0, 180, 255), highlight-pins, point-pin, body) = {
  pinit-highlight(..highlight-pins, dy: -0.9em, fill: rgb(..fill.components().slice(0, -1), 40))
  pinit-point-from(
    fill: fill, pin-dx: 0em, pin-dy: if pos == bottom { 0.5em } else { -0.9em }, body-dx: 0pt, body-dy: if pos == bottom { -1.7em } else { -1.6em }, offset-dx: 0em, offset-dy: if pos == bottom { 0.8em + height } else { -0.6em - height },
    point-pin,
    rect(
      inset: 0.5em,
      stroke: (bottom: 0.12em + fill),
      {
        set text(fill: fill)
        body
      }
    )
  )
}

#let (theorem, definition, remark, proof, example) = frames(
  theorem:   ("Теорема",   navy),     
  definition:("Определение", blue),
  remark:    ("Замечание", teal),
  proof:     ("Доказательство", purple),
  example: ("Пример", blue),
)
#show: frame-style(styles.hint)


#align(center)[
    #text(size: 17pt, weight: "bold")[ITMO University] \
    #text(weight: "bold", size: 15pt)[Software Engineering] \
    #v(2em)

    #text(size: 16pt, weight: "bold")[Математический анализ] \
    #v(1em)
    #text(size: 13pt)[Лектор: Ржонсницкая Ю. Б.]
    #v(1em)
    #text(size: 11pt)[1st Year, Spring Semester] \
    #v(3em)

    #text(size: 14pt)[Написан: Коткин Михаил, M3100]\
    
    #v(40em)
    #text(size: 9pt, fill: rgb("#b7b4b4"))[скомпилировано в #datetime.today().display() c https://github.com/mk0t1k/notes]\
]

#pagebreak()
// Оглавление
#set heading(numbering: "1.")
#outline(title: "Содержание")

= Интегрирование функций одной переменной
== Неопределённый интеграл. Свойства

$Blue(underline("Определение:"))$ Функция $F(x)$ перевообразная для $f(x)$ на $(a, b)$ если $forall x in (a, b): F'(x) = f(x)$

$underline("Пример:") f(x) = cos(x)$ первообразные к ней:\ $F_1(x) = sin(x)$ и $F_2(x) = sin(x) + 2$ то есть первообразная определяется неоднозначно

$underline("Замечание:")$ Важно, что первообразная именно на интервале\

#theorem(
  style: styles.thmbox,
)[][Если $F(x)$ первообразная для $f(x)$ на $(a, b)$ тогда любая другая первообразная $Phi(x) = F(x) + C$]
#text(navy.darken(10%))[*Доказательство:*]\
  Рассмотрим функцию $Psi(x) = (F(x) - Phi(x))$ и возьмём её производную на $(a, b):$ \ $ Psi'(x) = (F'(x) - Phi'(x)) = f(x) - f(x) + C' = 0$\ Тогда по теореме Лагранжа $F(x) - Phi(x) = "const"$ а значит $Phi(x)$ представима в виде $F(x) + "const" qed$

$Blue(underline("Определение:"))$ Неопределённый интеграл - это совокупность всех первообразных функции $f(x)$ на $(a, b)$\
$ integral f(x) d x = F(x) + C $

#align(center)[
$underline("Таблица интегралов:")$

#table(
  columns: 2,
  table.vline(x: 1),
  table.hline(y: 1),
  stroke: none,
  table.header[$ f(x) $][$ integral f(x) d x $],
  [$ x^n $], [$ x^(n+1)/(n+1) + C $],
  [$ 1/x $], [$ ln|x| + C $],
  [$ a^x $], [$ a^x/ln(a) + C $],
  [$ e^x $], [$ e^x + C $],
  [$ sin(x) $], [$ -cos(x) + C $],
  [$ cos(x) $], [$ sin(x) + C $],
  [$ 1/(cos^2(x)) $], [$ tg(x) + C $],
  [$ 1/(sin^2(x)) $], [$ ctg(x) + C $],
  [$ "sh"(x) $], [$ "ch"(x) + C $],
  [$ "ch"(x) $], [$ "sh"(x) + C $],
  [$ 1/(a^2 + x^2) $], [$ 1/a "arctg"(x/a) + C $],
  [$ 1/sqrt(a^2 - x^2) $], [$ 1/a arcsin(x/a) + C $],
  [$ 1/(x^2 - a^2) $], [#pin(1)$ 1/a ln lr(|(x - a)/(x + a)|) + C $#pin(2) ],
  [$ 1/sqrt(x^2 plus.minus k^2) $], [#pin(3)$ ln|x + sqrt(x^2 plus.minus k^2)| + C $#pin(4) ]
)
]

#pinit-highlight-equation-from((1, 2), (1, 2), height: 1.4em, pos: top, fill: rgb(150, 90, 170))[Высокий логарифм]

#pinit-highlight-equation-from((3, 4), (3, 4), height: 1.4em, pos: top, fill: orange)[Длинный логарифм]


#underline("Свойства неопределённого интеграла:")\
#table(
stroke: none,
columns: 2,
column-gutter: 10em,
[$ 1) d/(d x) (integral f(x) d x) = f(x) $], [$ 2) d (integral f(x) d x) = f(x) d x $],
[$ 3)integral d F(x) = F(x) + C $], [$ 4)"линейность" integral (alpha f(x) + beta g(x))d x = alpha integral f(x) d x + beta integral g(x) d x $]
)
#text(navy.darken(10%))[*Доказательство:*]\
- Свойства 1-3 доказываются просто по определению
- Докажем свойство 4, для этого продеференцируем обе части равенства:
  $ d/(d x) (integral (alpha f(x) + beta g(x))d x) = d/(d x) (alpha integral f(x) d x) + d/(d x) (beta integral g(x) d x) "по формуле производной суммы" $
  $ alpha f(x) + beta g(x) = alpha d/(d x) ( integral f(x) d x) + beta d/(d x) (integral g(x) d x) = alpha f(x) + beta g(x) "по первому свойству" $

#underline("Замечание:") Из 4 свойства следует, что интеграл - линейный оператор

== Вычисление неопределённого интеграла заменой переменной. Интегрирование по частям

#theorem(
  style: styles.thmbox,
)[][Пусть $x = phi(t)$ определённая и дифференцируемая на $(a, b)$. $X$ - множество значений $phi(t)$ на котором определеная $f(x)$ с первообразной $F(x)$.\ $ integral f(phi(t))phi'(t)d t = lr(integral f(x) d x |)_(x = phi(t)) = F(phi(t)) + C $]
#text(navy.darken(10%))[*Доказательство:*]\

$ integral f(phi(t)) underbrace( phi'(t)d t, d phi) = integral f(phi) d phi = F(phi) + C $


#underline("Пример:")$""_1$\
$ integral cos(5x + 4) d x =  mat(delim: "[", t = 5x + 4 ; d t = 5 d x ) = 1/5 integral cos(5x + 4) 5 d x = 1/5 integral cos(t) d t = 1/5 sin(t) + C = 1/5 sin(5x + 4) + C $
#underline("Пример:")$""_2$(занесение под знак дифференциала)\
$ integral x/(x^2 + 1) d x = 1 / 2 integral (2x)/(x^2 + 1) d x = 1/2 integral d(x^2 + 1)/(x^2 + 1) = ln|x^2 + 1| + C $

#theorem(
  style: styles.thmbox,
)[][Пусть $u(x)$ и $v(x)$ дифференцируемые на $(a,b)$ Тогда $ integral u d v = u v - integral v d u $]
#text(navy.darken(10%))[*Доказательство:*]\

Вспомним формулы для производной и дифференциала произведения:\
$ (u v)' = u' v + v'u $
$ d(u v) =  u d v + v d u $ 
Возьмём неопределённый интеграл от обеих частей равенства:
$ integral d(u v) = integral(u d v + v d u) = integral u d v + integral v d u "по свойсву линейности" $ 
$ "По свойству неопределённого интеграла:" integral d(u v) = u v $
$ u v = integral u d v + integral v d u <=>  integral u d v = u v - integral v d u #h(5em) qed $

#underline("Пример:")$""_1$\
$ integral x e^x d x = mat(delim: "[", u = x ; d v = e^x d x ) = e^x x - integral e^x d x = e^x x - e^x + C $
#underline("Пример:")$""_2$\
$ integral ln(x) d x = mat(delim: "[", u = ln(x) ; d v = d x ) = ln(x) x - integral x 1/x d x = ln(x) x - x + C $
#underline("Пример:")$""_3$(циклические интегралы)\
$ I = integral e^x cos(x) d x = mat(delim: "[", u = e^x ; d v = cos d x ) = e^x sin(x) - integral sin(x) e^x d x = mat(delim: "[", u = e^x ; d v = sin d x ) = $ $ e^x sin(x) - (-e^x cos(x) + integral e^x cos(x) d x ) = e^x sin(x) - (-e^x cos(x) + I) $
получили равенство из которого можно найти $I$:
$ I = e^x sin(x) - (-e^x cos(x) + I) <=> I = (e^x sin(x) + e^x cos(x))/2 + C $

== Формула Эйлера и правило Лейбница для вычисления неопределённого интеграла

Вспомним формулу Эйлера: $ e^(i phi) = cos(phi) + i sin(phi) $
$"Тогда функция" f(x) = e^x cos(x) = "Re"(e^(i x) e^x) = "Re"(e^(x(i + 1))) $

$ integral e^x cos(x) d x = "Re"(integral e^(x(i + 1))) = "Re"(1/(1 + i)e^(x(1 + i))) + C = "Re"((1 - i)/2 e^x (cos(x) + i sin(x))) = 1/2 e^x cos(x) + 1/2 e^x sin(x) + C $

#theorem(
  style: styles.thmbox,
)[][(*Правило Лейбница*) Пусть $f(x, alpha)$ функция, зависящая от переменной $x$ и параметра $alpha. f(x, alpha)$ и $f'_alpha (x, alpha)$ - непрерывны на $ [a, d] times [c, d].$ $ "Тогда" Phi(alpha) = integral_a^b f(x, alpha) d x "диффериенцируема по" alpha "и" Phi'(alpha) = d/(d alpha) (integral_a^b f(x, alpha) d x) = integral_a^b f'_alpha (x, alpha) d x $ ]
Докажем мы эту теорему позже, а пока применем ее для нахождения неопределённого интеграла

#underline("Пример:")\
#table(
  columns: 1,
  stroke: none,
[+ $ integral e^(alpha x) d x = 1/ alpha e^(alpha x) + C $],
[2. $ d / (d alpha) (integral e^(alpha x) d x ) = integral (e^(alpha x))'_alpha d x = integral x e^(alpha x) d x $],
[3. $ d / (d alpha) (integral 1/ alpha e^(alpha x) d x ) = - 1/alpha^2 e^(alpha x) + x/alpha e^(alpha x) ==> integral x e^(alpha x) d x = - 1/alpha^2 e^(alpha x) + x/alpha e^(alpha x) + C $],
)


== Интегрирование рациональных дробей

$Blue(underline("Определение:"))$ рациональная функция это $R(x) = (P_m (x))/(Q_n (x))$, где $P_m (x), Q_n (x)$ - многочлены\
1) $m < n: R(x)$ - правильная дробь\
2) $m >= n: R(x)$ - неправильная дробь\ 

#theorem(
  style: styles.thmbox,
)[][Любая рациональная дробь может быть представлена в виде суммы элементарных дробей вида:
  #table(
  columns: 2,
  stroke: none,
  [$I: A/(x - a) $], [$I I: A/(x - a)^k $],
  [$I I I: (A x + B)/(x^2 +p x + q), D < 0 $], [$I V: (A x + B)/(x^2 +p x + q)^k, D < 0, k > 1 $]
  )
]
=== Интегрирование дробей I типа
$ integral A/(x - a) d x = A ln(|x - a|) + C $
#underline("Пример:") (Метод неопределённых коэффицентов)\
$ integral (x + 1)/(x^2 + 4x - 5) d x $
Рассмотрим подынтегральное выражение: $ (x + 1)/(x^2 + 4x - 5) = (x + 1)/((x - 1)(x + 5)) = (A/(x - 1) + B/(x + 5)) = (A(x + 5) + B(x - 1))/((x - 1)(x + 5)) $\
$x + 1 = A(x + 5) + B(x - 1) $ Для любых значений $x$, подставим удобные, чтобы найти $A$ и $B$:\
$x = -5: -4 = -6 B <=>  B = 2/3$ \
$x = 1: 2 = 6A <=>  A = 1/3$ \
$ integral (x + 1)/(x^2 + 4x - 5) d x = integral (A/(x - 1) + B/(x + 5)) d x = integral (1/3/(x - 1) + 2/3/(x + 5)) d x = 1/3 ln|x - 1| + 2/3 ln|x + 5| + C $
==== Метод Ховесайда
Если знаменатель раскладывается на линейные множители в 1 степени, то $ R(x) = (P(x))/((x - a_1)...(x - a_n)) = (A_1)/(x - a_1) + ... + (A_n)/(x - a_n) $
$ "Где" A_i = lim_(x -> a_i) (P(x))/(Q(x)) (x - a_i) = P(a_i)/(П_(i != j) (a_j - a_i)) = P(a_i)/(Q'(a_i)) $
*#underline("Доказательство:")*\
$ R(x) = (P(x))/((x - a_1)...(x - a_n)) = (A_1)/(x - a_1) + ... + (A_n)/(x - a_n) | * (x - a_i) $
$ (P(x))/((x - a_1)...(x - a_(i - 1))(x - a_(i + 1))...(x - a_n)) = (A_1 (x - a_i))/(x - a_1) + ... + A_i + ... + (A_n (x - a_i))/(x - a_n) $
Перенесём все влево и подставим $x = a_i$ так как это равенство должно быть верно для любых $x$, все слагаемые $(A_k (x - a_i))/(x - a_k)$ станут нулями и мы получим нашу формулу.\
#underline("Пример:")\
$ integral (x^2 + 2x + 6)/((x - 1)(x - 2)(x - 4)) d x = integral (A/(x - 1) + B/(x - 2) + C/(x - 4)) d x = 3ln|x - 1| - 7ln|x - 2| + 5ln|x - 4| + C $
$A = (1 + 2 * 1 + 6)/((1 - 2)(1 - 4)) = 3$ #h(3em)
$B = (4 + 2 * 2 + 6)/((2 - 1)(2 - 4)) = -7$ #h(3em)
$C = (16 + 2 * 4 + 6)/((4 - 1)(4 - 2)) = 5$
=== Интегрирование дробей II типа
$ integral (d x)/(x - a)^k = integral (d (x - a))/(x - a)^k = (x - a)^(-k + 1)/(-k + 1) + C $
=== Интегрирование дробей III типа
$ integral (A x + B)/(x^2 + p x + q) d x eq.o $
#underline("Алгоритм двух шагов"):\
1 Шаг: выделение производной знаменателя в числителе\
  $A x + B = A/2 (2x + p) + underbrace(B - p A/2, r)$\
2 Шаг: интегрирование полученных частей\
  $ eq.o integral (A/2(2x + p) + r)/(x^2 + p x + q) d x = A/2 integral (d(x^2 + p x + q))/(x^2 + p x + q) + integral r/(x^2 + p x + q) d x = A/2 ln|x^2 + p x + q| + r integral 1/((x + p/2)^2 + underbrace(q - (p^2)/4, a^2)) $\
  $ = A/2 ln|x^2 + p x + q| + r/a "arctg"((x + p/2)/a) + C $
#underline("Пример:")
$ integral (x + 1)/(x^2 + 2x + 5) d x = 1/2 integral (2x + 2)/(x^2 + 2x + 5) d x = 1/2 ln(x^2 + 2x + 5) + C $
=== Интегрирование дробей IV типа
$ J_k = integral (A x + B)/(x^2 + p x + q) d x eq.o #h(3em) k > 1, D < 0 $
1 Шаг: выделение производной знаменателя в числителе\
  $A x + B = A/2 (2x + p) + underbrace(B - p A/2, r)$\
  $ J_n = A/2 integral (d(x^2 + p x + q))/(x^2 + p x + q)^k + underbrace(integral (d x)/(x^2 + p x + q)^k, I_n) = A/(2(-k + 1)) 1/(x^2 + p x + q)^(k+ 1) + I_n $\
2 Шаг:\
  $ I_n = integral (d x)/(x^2 + p x + q)^k = integral (d x)/(underbrace((x + p/2)^2, t^2) + underbrace(q - p^2/4, a^2))^k $
3 Шаг: рекурентная формула\
  $ I_n = integral (d t)(t^2 + a^2)^k = 1/a^2 integral ((a^2 + t^2) - t^2)/(t^2 + a^2)^k d t = 1/a^2 integral (d t)/(t^2 + a^2)^(k - 1) - 1/a^2 underbrace(integral t^2/(t^2 + a^2)^k d t, "можно интегрировать по частям") $
  $ integral t^2/(t^2 + a^2)^k d t = mat(delim: "[", u = t; d v = t/(t^2 + a^2)^k d t ) = ... $\
  $ I_n = 1/a^2 (2n - 3)/(2n - 2) * I_(n - 1) + t/(2(n - 1)(t^2 + a^2)^(n - 1)) $
#underline("Замечание:") Неплохое упаражение, но эту формулы мы использовать не будем :)\
#underline("Пример:")
  $ integral (d x)/(x^2 + 1)^2 = 1/2 I_1 + x/(2(x^2 + 1)) = 1/2 "arctg"(x) + x/(2(x^2 + 1)) + C $\
  $ n = 2 #h(3em) a = 1 $\
==== Метод Остроградского
Применяется при наличии кратных корней в знаменателе $Q(x)$
$ integral P(x)/Q(x) d x = (P_1 (x))/(Q_1 (x)) + integral (P_2 (x))/(Q_2 (x)) d x $
$ P(x)/Q(x) = ((P_1 (x))/(Q_1 (x)))' + (P_2 (x))/(Q_2 (x)) $
Часто удобно использовать в такой форме, получили ее просто взяв производную от обеих частей\
Где $Q_1 (x)$ = НОД$(Q(x), Q'(x))$ многочлен содержащий все кратные множители знаменателя, но в степени на 1 меньше\
$Q_2 (x) = Q(x)/(Q_1 (x))$ многочлен содержит все множители знаменателя в степени 1(без кратности)\
$P_1 (x)$ и $P_2 (x)$ многочлены степени на 1 меньше чем $Q_1 (x)$ и $Q_2 (x)$ соответственно ищутся методом неопределённых коэфицентов. \
#underline("Пример:")\
$ integral (d x)/(x^2 + 1)^2 = (A x + B)/(x^2 + 1) + integral (C x + D)/(x^2 + 1) d x $
$ 1/(x^2 + 1)^2 = ((A x + B)/(x^2 + 1))' + (C x + D)/(x^2 + 1) $
$ 1 = A(x^2 + 1) - 2x(A x + B) + (C x + D)(x^2 + 1) $ 
Многочлены тождественно равны(то есть равны при всех $x$) если у них с овпадают все коэфиценты.
#align(center)[
#table(
  columns: 3,
  stroke: none,
  table.hline(y: 1),
  table.hline(y: 2),
  table.hline(y: 3),
  table.vline(x: 1),
  table.vline(x: 2),
  [$x^3$], [$C$], [$0$],
  [$x^2$], [$-A + D$], [$0$],
  [$x$], [$-2B + C$], [$0$],
  [$x^0$], [$A + D$], [$1$],
)
  Из таблички получаем, что $A = 1/2 #h(3em) B = 0 #h(3em) C = 0 #h(3em) D = 1/2$
]
Вернёмся к изначальному интегралу: $ integral (d x)/(x^2 + 1)^2 = (A x + B)/(x^2 + 1) + integral (C x + D)/(x^2 + 1) d x = (1/2 x) / (x^2 + 1) + integral (1/2 x) / (x^2 + 1) d x = 1 / 2 1/(x^2 + 1) + 1/2 "arctg"(x) + C $

== Интегрирование тригонометрических функций
$ integral R(cos x, sin x) d x #h(0.5em) (*) #h(3em) R - "универсальная функция" $\
#underline("Универсальная тригонометрическая подстановка")\
Сводит любой интеграл вида $(*)$ к интегралу от рациональной функции\
#align(left)[
#table(
  stroke: none,
  columns: 1,
  [$ t = tg(x/2), x in (-pi/2; pi/2) $],
  [$ sin x = (2t)/(1 + t^2) $],
  [$ cos x = (1 - t^2)/(1 + t^2) $],
  [$ t = tg(x/2) => x = 2 "arctg"(t) "тогда" d x = 2/(1 + t^2) d t $]
)
]
#underline("Быстрые подстановки"):
+ Нечётность по $sin x : R(cos x, -sin x) = -R(cos x, sin x)$\
  Делаем замену $t = cos x #h(3em) d t = -sin x d x$\
  #underline("Пример:")\
  $ integral (d x)/(sin x) = mat(delim: "[", t = cos x; d t = -sin x d x ) = - integral (d t)/(1 - t^2) = integral (d t)/(t^2 - 1) = 1 / 2 ln lr(|(t - 1)/(t + 1)|) + C = 1 / 2 ln lr(|(cos x - 1)/(cos x + 1)|) + C $
+ Нечётность по $cos x : R(-cos x, sin x) = -R(cos x, sin x)$\
  Делаем замену $t = sin x #h(3em) d t = cos x d x$
+ Чётность по совокупности $R(-sin x, -cos x) = R(sin x, cos x)$
  #align(left)[
  #table(
  stroke: none,
  columns: 1,
  [$ t = tg(x) $],
  [$ sin x = (t^2)/(1 + t^2) $],
  [$ cos x = 1/(1 + t^2) $],
  [$ t = tg(x) => x =  "arctg"(t) "тогда" d x = 1/(1 + t^2) d t $]
  )
  ]
+ 
  #place(left)[
  $ integral sin^m x * cos^n x d x $\ ]
  \
  \
  А) Хотя бы одна из степеней нечётная\
  Отрываем от нечётной степени один множитель, две степени - чётные, а то, что оторвали заносим под знак интеграла\
  #underline("Пример:")\
  $ integral sin^3 x d x = integral sin^2 x * underbrace(sin x x d x, - d(cos x)) = - integral sin^2 x d(cos x) = - integral (1 - cos^2) d(cos x) = (cos^3 x)/3 - cos x + C $
  Б) Обе степени чётные\
  Используем следующие формулы:
  #align(left)[
  #table(
  stroke: none,
  columns: 1,
  [$ cos^2 x = (1 + cos 2 x)/2 $],
  [$ sin^2 x = (1 - cos 2 x)/2 $],
  [$ sin x = 2 sin x/2 cos x/2 $],
  )
  ]
  #underline("Пример:")\
  _1 способ:_\
  $ integral (d x)/(sin^3 x cos x) = integral 1/(tg^3 x cos^4 x) = mat(delim: "[", t = tg x; d t = (d x)/(1 + t^2) ) = integral ((d t)/(1 + t^2))/(t^3 1/(1 + t^2)^2) = integral ((1 + t^2) d t)/t^3 = 1/(2t^2) + ln|t| + C = - 1/2 1/(tg^2 x) + ln|tg x| + C $
  _2 способ:_\
  $ integral (d x)/(sin^3 x cos x) = integral (sin^2 x + cos^2 x)/(sin^3 x cos x) d x = integral ((cos x)/(sin^3 x) + 1/(cos x sin x)) d x = integral (d(sin x))/(sin^3 x) + 1/2 ln lr(|(cos 2x - 1)/(cos 2x + 1)|) + C = $ $ = -1/2 1/(sin^2 x) + 1/2 ln lr(|(cos 2x - 1)/(cos 2x + 1)|) $
  _(тут мы воспользовались результатом из примера к блоку нечётность по $sin x$)_\
+ Реккурентные формулы (понижения степени)
  $ "Нужны для решения чего-то такого" I_n = integral sin^n x #h(0.2em) d x "или" I_n = integral 1/(sin^n x) d x $ 
  $ I_n = integral sin x sin^(n - 1) x #h(0.2em) d x = 
  mat(delim: "[",
  u = sin^(n - 1) x; 
  d v = sin x #h(0.2em) d x;
  d u = (n - 1) sin^(n - 2) x cos x d x;
  v = -cos x )
  = -sin^(n - 1) x cos x + integral cos^2 x * (n - 1) sin^(n - 2) #h(0.2em) d x $
  $ = -sin^(n - 1) x cos x + (n - 1) integral (1 - sin^2 x) sin^(n - 2) #h(0.2em) d x = -sin^(n - 1) x cos x + (n- 1)(underbrace(integral sin^(n - 2) x #h(0.2em) d x, I_(n-2)) - underbrace(integral sin^n x #h(0.2em) d x, I_n)) $
  то есть
  $ I_n = -sin^(n - 1) x cos x + (n- 1)(I_(n-2) - I_n) => I_n = 1/n (-sin^(n - 1) x cos x + (n - 1) * I_(n - 2)) $
  и так сводим к 1 и 2 степени, которые мы умеем решать...\
== Интегрирование гиперболических функций
#Block[
  Вспомним: $ "ch"(x) = (e^x + e^(-x))/2 #h(5em) "sh"(x) = (e^x - e^(-x))/2 #h(5em) "ch"^2 x - "sh"^2 x = 1 $
  $ "ch" 2x = "ch"^2 x + "sh"^2 x #h(5em) 2 "ch"^2 x = "ch" 2 x + 1 $
]
_Методы интегрирования:_\
+ универсальная подстановка\
  #align(left)[
  #table(
  stroke: none,
  columns: 1,
  [$ t = "th" x/2 $],
  [$ "sh" x = (2t)/(1 + t^2) $],
  [$ "ch" x = (1 - t^2)/(1 + t^2) $],
  [$ t = "th" x/2 => x = 2 "arcth" t "тогда" d x = "arcth"' t #h(0.2em) d t $]
  )
  ]
+ чётность/нечётность
  Используем замену $t = "sh" x "/" "ch" x$\
+ Использование определения (сводим к экспонентам)
#underline("Пример:")\
$ integral sqrt(1 + "sh"^2 x) d x = integral "ch" x #h(0.2em) d x = "sh" x + C $
#Comment(color: rgb("#e8d0e6"))[
  *Fun Fact*
  $ integral sqrt(1 + (f'(x))^2) d x "- формула для вычисления дуги кривой f(x)" $
  А в данном случае мы считали формулу для длины дуги цепной линии (то есть форма упругой и нерастяжимой тяжёлой нити(цепи) с закреплёнными концами в однородном гравитационном поле)
]
_Гиперболическая подстановка_\
Мы в выражении, где не было гиперболических функций делаем замену с использованием гиперболических функций\
#underline("Пример:")\
$ integral sqrt(x^2 + a^2) d x = mat(delim: "[", x = a "sh" t; t = ("arcsh" x/a)/2; d x = a "ch" t d t ) = integral sqrt((a "sh" t)^2 + a^2) d x = a integral sqrt("sh"^2 x + 1) d x = a "ch" t + C = a "ch" ("arcsh" x/a)/2 + C $
== Интегрирование ирроциональных функций
При $ integral R(x, root(n, (a x + b)/(c x + d))) d x $ выгодно сделать замену $ t = root(n, (a x + b)/(c x + d)) $ а дальше выразить $x$ через $t$.\
#underline("Пример:")\
$ integral 1/(1 + x)^2 sqrt((1 - x)/(1 + x)) = mat(delim: "[", t = sqrt((1 - x)/(1 + x)); x = (1 - t^2)/(1 + t^2); d x = (-4t)/(1 + t^2)^2 d t) = - integral (1 + t^2)^2/4 t (4t)/(1 + t^2)^2 d t = - integral t^2 d t = -1/3 t^3 + C = -1/3 sqrt(((1 - x)/(1 + x))^3) + C $
== Квадратичные ирроциональности. Подстановки Эйлера
$ integral R(x, sqrt(a x^2 + b x + c)) d x $
_Подстановки Эйлера:_
+ При $a > 0:$
  $ sqrt(a x^2 + b x + c) = plus.minus sqrt(a) x + t $
+ При $c > 0$
  $ sqrt(a x^2 + b x + c) = t x plus.minus sqrt(t) $
+ При $D > 0$
  $ sqrt(a x^2 + b x + c) = sqrt(a (x - x_1)(x - x_2)) = t (x - x_1) $
#underline("Замечание:") Иногда может подходить несколько подстановок, тогда используем любую.\
#underline("Пример:")$""_1$\
$ integral (d x)/(x + sqrt(x^2 + x + 1)) = 
mat(delim: "[", sqrt(x^2 + x + 1) = - x + t;
x = (t^2 - 1)/(2t + 1);
d x = 2(t^2 + t + 1)/(2t + 1)^2 d t)
= integral (d x)/(x - x + t) = 2 integral (t^2 + t + 1)/(t(2t + 1)^2) d t = 2 integral (A/t + B/(2t + 1) + (C x + D)/(2t + 1)^2) d x eq.o $
Найдём коэффиценты:\
$ t^2 + t + 1 = A(2t + 1)^2 + B t(2t+1) + (C t + D)t $
$t = 0: A = 1$\
$t = -1/2: -1/4 C - 1/2 D = 3/4$\
$t = -1: B + C - D = 0 $\
$t = 1: 3B + C + D = 0$\
тогда $A = 1 #h(3em) B = -3/2 #h(3em) C = 0 #h(3em) D = -3/2$
$ eq.o 2ln|t| - 3/2ln|2t + 1| + 3/2 1/(2t + 1) + C = 2ln lr(|sqrt(x^2 + x + 1) + x|) - 3/2 ln lr(|2sqrt(x^2 + x + 1) + 2x + 1|) + 3/2 1/(2sqrt(x^2 + x + 1) + 2x + 1) + C $
#underline("Пример:")$""_2$\
_1 способ:_
$ integral (d x)/sqrt(x^2 - 1) = mat(delim: "[", sqrt((x - 1)(x + 1)) = t(x - 1); x = (t^2 + 1)/(t^2 - 1); d x = (4t)/(t^2 - 1) d t) = integral (d x)/(t((t^2 + 1)/(t^2 - 1) - 1)) = - integral (2 d t)/(t^2 - 1) = -ln lr(|(t - 1)/(t + 1)|) + C = -ln lr(|(sqrt((x - 1)/(x + 1)) - 1)/(sqrt((x - 1)/(x + 1)) + 1)|) + C $
_2 способ:(гиперболическая замена)_
$ integral (d x)/sqrt(x^2 - 1) = mat(delim: "[", x = "ch" t; d x = "sh" t #h(0.2em) d t) = integral ("sh" t #h(0.2em) d t)/("sh" t) = t + C = "arcsh" x + C $
== Теорема Чебышёва
$Blue(underline("Определение:"))$ $x^m (a + b x^n)^p$ - интегральный бином, $m, n, p in QQ$
#theorem(
  style: styles.thmbox,
)[][ 
  Интеграл от дифференцируемого бинома выражается через комбинацию элементарных функцию в трёх случаях:
  #table(
    stroke: none,
    columns: 1,
    [1. $p in ZZ:$ делаем замену $x = t^k$, где $k$ общий знаментель $m$ и $n$(НОК)],
    [2. $ (m + 1)/ n in ZZ: "делаем замену" a + b x^n = t^k, "где" k - "знаменатель дроби" p $], 
    [3. $ (m + 1)/ n + p in ZZ: "делаем замену" t^k = a x^(-n) + b, "где" k - "знаменатель дроби" p $]
  )
]
#underline("Пример:")$""_1$:\
$ integral sqrt(1 + x^2) d x #h(7em) p = 1/2 #h(4em) a = b = 1 #h(4em) n = 3 #h(4em) m = 0 $
#align(left)[
  #table(
    stroke: none,
    columns: 1,
    [$ p = 1/2 in.not ZZ $],
    [$ (0 + 1)/3 in.not ZZ $],
    [$ (0 + 1)/3 + 1/2 in.not ZZ $]
  )
]
Тогда по теореме Чебышёва интеграл не берётся.\
#underline("Пример:")$""_2$:\
$ integral root(3, 1 + root(4, x))/sqrt(x) d x = integral x^(-1/2) (1 + x^(1/4))^(1/3) d x = mat(delim: "[", 1 + x^(1/4) = t^3; (t^3 - 1)^2 = x^1/2) = integral t^3(t^3 - 1)^2 4(t^3 - 1)^3 3t^2 d t = 12 integral (t^6 - t^3) d t = 12/7 t^7 - 3t^4 + C = 12/7 (1 + x^(1/4))^(7/3) - 3(1 + x^(1/4))^(4/3) + C $
= Определённый интеграл
Рассмотрим функцию $f(x) >=$ на $[a;b]$\
Разобьём $[a;b]$ точками $x_i: a = x_0 < x_1 < ... < x_n = b$, ${x_n}$ - разбиение отрезка, назовём его $Tau$\
Возьмём $xi_i in [x_i; x_(i + 1)]$ - произвольная точка на отрезке.\
$Delta x_i = x_(i + 1) - x_i$\
$Blue(underline("Определение:"))$ Интегральная сумма Римана для $f(x)$ на $[a;b]$ называется сумма $ sigma = sum_(i = 0)^(n-1) f(x_i) * Delta x_i $

#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": *

#canvas(length: 5cm, {
  import draw: *
  
  let f(x) = calc.pow(x, 0.89) + 0.4
  let a = 0.2
  let b = 1.8
  let n = 5
  let dx = (b - a) / n

  plot.plot(
    size: (1.5, 0.8),
    x-min: 0, x-max: 2.2,
    y-min: 0, y-max: 4,
    x-label: [x], y-label: [y],
    axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    {
      plot.add(f, domain: (0.1, 2.1), style: (stroke: blue + 1pt))

      for i in range(0, n) {
        let x_i = a + i * dx
        let x_next = a + (i + 1) * dx
        let xi_i = x_i + dx / 2
        let y_i = f(x_i)

        plot.add(
          ((x_i, 0), (x_i, y_i), (x_next, y_i), (x_next, 0)),
          style: (fill: blue.lighten(95%), stroke: (dash: "dashed", thickness: 0.5pt, paint: gray)),
        )

        plot.add(
          ((xi_i, 0), (xi_i, f(xi_i))), 
          mark: "circle",
          mark-size: 8pt,
          style: (stroke: (paint: red, dash: "dotted", thickness: 1.0pt))
        )
      }

      plot.annotate({
        content((a, 0), [$a=x_0$], anchor: "south", padding: .1)
        content((b, 0), [$b=x_n$], anchor: "south-west", padding: .1)
        content((a + dx, 0), [$x_1$], anchor: "south", padding: .1)
        content((a + dx/2, 0), [$Red(xi_1)$], anchor: "north", padding: .2, r: -90deg)
        content((a + 3/2 * dx, 0), [$Red(xi_2)$], anchor: "north", padding: .2, r: -90deg)
        content((a + 9/2 * dx, 0), [$Red(xi_n)$], anchor: "north", padding: .2, r: -90deg)

        content((2.1, f(2.1)), [$y = f(x)$], anchor: "west", padding: .15)
      })
    }
  )
})
$Blue(underline("Определение:"))$ Мелколсть разбиения $Tau$ - это $lambda(Tau) = max Delta x_i$\
$Blue(underline("Определение:"))$ Число $I$ называется определённым интегралом функции $f(x)$ на $[a;b]$, если $forall epsilon > 0$ существует такое $delta > 0$, что для всякого разбиения $Tau$ отрезка $[a;b]$ с мелколстью меньше $delta$ и всякого выбора точек $xi_i in [x_i; x_(i + 1)]$ выполняется неравенство $|sigma - I| < epsilon$\
$ I = integral_a^b f(x) d x $

Если $exists integral_a^b f(x) d x$ то $f(x) in R_([a;b])$ - множество интегрируемых по Риману функций на $[a;b]$\

#theorem("(Необходимое условие интегрируемости)")[
  $f in R_([a;b]) => f$ ограничена на $[a;b]$
]

#underline("Доказательство:")  \( от противного) \
Пусть $f$ не ограничена на $[a;b]$ и существует $I = integral_a^b f(x) d x$.\
#align(left)[
#table(
  stroke: none,
  columns: 2,
  [1)],[$ f in R_([a;b]) => lr(|sum_(i = 1)^n f(xi_i) Delta x_i - I|) < 1  #h(4em) (lambda < delta) #h(4em) (epsilon - "любой, мы взяли его равным 1") $],
  [2)], [$f - "не ограничена" => exists x_k - "отрезок на котором" f "неограничена" $],
  [3)], [$ sigma = f(xi_k) Delta x_k + sum_(i != k, i = 1)^n f(xi_i) Delta x_i "Фиксируем точки оснащения" xi_i "обохначим" S_("fix") = sum_(i != k, i = 1)^n f(xi_i) Delta x_i $],
  [4)], [$"Выберем" xi_k: |f(xi_k)| > (|I| + 1 + S_("fix"))/(Delta x_k) $],
  [5)], [$ |sigma| = |f(xi_k) Delta x_k + S_("fix")| >= |f(xi_k) Delta x_k| - |S_("fix")| > (|I| + 1 + S_("fix")) - |S_("fix")| = |I| + 1 "Противоречие с 1)" $],
  [], [#underline("Замечание") Тут мы использовали то, что мы можем выбирать любые точки оснаения, в частности мы выбрали такую точку, на которой функция принимает очень большое значение, так как она не ограничена]
)
]

#underline("Пример")$""_1$:
#align(center)[
#table(
  columns: 2,
  stroke: none,
  [$ integral_a^b C d x $\ $  sigma = sum_(i = 1)^n C Delta x_i = C underbrace(sum_(i = 1)^n Delta x_i, "длина" [a;b]) = C (b - a) $],
  [
  #import "@preview/cetz:0.4.2": *
  #import "@preview/cetz-plot:0.1.3": *

  #canvas(length: 1.5cm, {
  import draw: *
  
  let c_val = 1.5
  let a = 0.5
  let b = 2.5

  plot.plot(
    size: (1.5, 1.0),
    x-min: 0, x-max: 3.2,
    y-min: 0, y-max: 2.2,
    axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    {
      plot.add(x => c_val, domain: (0, 3), style: (stroke: blue + 1.5pt))

      plot.add(
        ((a, 0), (a, c_val), (b, c_val), (b, 0)),
        style: (
          fill: blue.lighten(90%), 
          stroke: (paint: blue, thickness: 1pt),
        ),
      )
      
      let step = 0.15
      let num_lines = int((b - a) / step)
      for i in range(1, num_lines) {
        let x = a + i * step
        plot.add(((x, 0), (x, c_val)), style: (stroke: (paint: blue.lighten(50%), thickness: 0.5pt)))
      }

      plot.annotate({
        content((a, 0), [$a$], anchor: "south", padding: .1)
        content((b, 0), [$b$], anchor: "south", padding: .1)
        content((0, c_val), [$C$], anchor: "east", padding: .2)
      })
    }
  )
})
  ]
)
]
#underline("Пример")$""_2$:\
$ integral_0^1 D(x) d x $
Напоминание: $D(x) = 1$ при $x in QQ$ и $D(x) = 0$ при $x in RR without QQ$\
Если $xi_i in QQ #h(2em) sigma(D(x), Tau, xi) = sum_(i = 1)^n 1 * Delta x_i = 1$\
Если $xi_i in.not QQ #h(2em) sigma(D(x), Tau, xi) = 0$\
Предел при $lambda(Tau) -> 0$ зависит от выбора точек оснащения, то интеграл не существует.\
== Верхняя и нижняя суммы Дарбу
Пусть $f$ ограничена на $[a;b]$ и $Tau$ - разбиение отрезка $[a;b]$\
$ m_i = inf f(x), x in [x_i; x_(i + 1)] #h(4em) M_i = sup f(x), x in [x_i; x_(i + 1)] $\

$Blue(underline("Определение:"))$ Верхняя сумма Дарбу для $f$ на $Tau$ - это $ S^*(f, Tau) = overline(S)(Tau) = sum_(i = 0)^(n-1) M_i Delta x_i $\
$Blue(underline("Определение:"))$ Нижняя сумма Дарбу для $f$ на $Tau$ - это $ S_*(f, Tau) = underline(S)(Tau) = sum_(i = 0)^(n-1) m_i Delta x_i $\

#underline("Замечание:") $overline(S) "и" underline(S) "не зависят от выбора точек оснащения"$

#table(
  columns: 2,
  stroke: none,
  [
    #import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": *
#canvas(length: 5cm, {
  import draw: *
  
  let f(x) = calc.pow(x, 0.89) + 0.4
  let a = 0.2
  let b = 1.8
  let n = 5
  let dx = (b - a) / n

  plot.plot(
    size: (1.5, 0.8),
    x-min: 0, x-max: 2.2,
    y-min: 0, y-max: 3,
    axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    {
      plot.add(f, domain: (0.1, 2.1), style: (stroke: black + 1pt))

      for i in range(0, n) {
        let x_i = a + i * dx
        let x_next = a + (i + 1) * dx
        
        let y_min = f(x_i)    // Нижняя сумма
        let y_max = f(x_next) // Верхняя сумма

        // Нижняя сумма Дарбу (Зеленая)
        plot.add(
          ((x_i, 0), (x_i, y_min), (x_next, y_min), (x_next, 0)),
          style: (fill: green.lighten(80%), stroke: green + 0.5pt),
        )

        // Верхняя сумма Дарбу (Красная штриховка)
        plot.add(
          ((x_i, 0), (x_i, y_max), (x_next, y_max), (x_next, 0)),
          style: (
            fill: red.lighten(90%), 
            stroke: red + 0.5pt,
          ),
        )
      }

      plot.annotate({
        content((a, 0), [$a$], anchor: "south")
        content((b, 0), [$b$], anchor: "south")
        content((2.1, f(2.1)), [$f(x)$], anchor: "west", padding: .15)
      })
    }
  )
  })
  ],
  [#Green("зелёные прямоугольники") -- нижняя сумма Дарбу,\ #Red("красные прямоугольники") -- верхняя сумма Дарбу]
)

#underline("Свойства сумм Дарбу")
+ $overline(S) = sup(sigma(Tau, xi))$ и $underline(S) = inf(sigma(Tau, xi))$
+ При добавлении новой точки в разбиение верхняя сумма Дарбу не возрастает, а нижняя не убывает
  #underline("Доказательство")
  Пусть $Tau$ - разбиение отрезка $[a;b]$ и $Tau'$ - разбиение, полученное добавлением новой точки $x'$ в $Tau$\
  Пусть $x' in [x_(k - 1); x_k]$\
  $M'_k <= M_k$ и $m'_k >= m_K$\
  Пусть на отрезке $[x'; x_k]: M''_k$ и $m''_k$\
  Тогда $M''_k <= M_k$ и $m''_k >= m_k$\
  $ overline(S)(Tau') - overline(S)(Tau) = M'_k (x_k - x') + M''_k (x' - x_(k - 1)) - M_k (x_k - x_(k - 1)) = (M'_k - M_k)underbrace((x_k - x'), >= 0) + (M''_k - M_k)underbrace((x' - x_(k - 1)), >= 0) <= 0 $
  $ underline(S)(Tau') - underline(S)(Tau) = m'_k (x_k - x') + m''_k (x' - x_(k - 1)) - m_k (x_k - x_(k - 1)) = (m'_k - m_k)(x_k - x') + (m''_k - m_k)(x' - x_(k - 1)) >= 0 $
+ $forall Tau_1, Tau_2: overline(S)(Tau_1) >= underline(S)(Tau_2)$\
  #underline("Доказательство")\
  Возьмём $Tau = Tau_1 union Tau_2$\
  $ overline(S)(Tau_1) >= overline(S)(Tau) >= underline(S)(Tau) >= underline(S)(Tau_2) $
$Blue(underline("Определение:"))$ Пусть $f$ - ограниченная функция на $[a;b]$.\ $underline(I) = sup_Tau (overline(S)(Tau))$называется нижним интегралом Дарбу\
$overline(I) = inf_Tau (underline(S)(Tau))$называется верхним интегралом Дарбу\
#underline("Пример")\
$D(x)$ на $[0;1]: overline(I)(D) = 1, underline(I)(D) = 0$
#theorem("критерий интегрируемости в терминах сумм Дарбу")[
  $ f in R_([a;b]) <=> lim_(lambda(Tau) -> 0) (overline(S)(Tau) - underline(S)(Tau)) = 0 $
]
#underline("Доказательство")\
+ $=>$ 
  $f in R_([a;b])$ Возьмём $epsilon/3 > 0 => exists delta > 0: lambda(Tau) < delta =>$
  $ |sigma(f, Tau, xi) - I| < epsilon/3 #h(1em) => #h(1em) I - epsilon/3 < sigma(f, Tau, xi) < I + epsilon/3 #h(1em) => I - epsilon/3  <= underline(S)\(Tau) <= sigma(f, Tau, xi) <= overline(S)(Tau) <= I + epsilon/3 $
  $ => overline(S)(Tau) - underline(S)(Tau) <= 2epsilon/ 3 < epsilon #h(1em) => #h(1em) overline(S)(Tau) - underline(S)(Tau) -->_(lambda(Tau) -> 0) 0 $
+ $\<=$\
  $overline(S)(Tau) - underline(S)(Tau) -->_(lambda(Tau) -> 0) 0$
  $ forall T: underline(S)(Tau) <= underline(I) <= overline(I) <= overline(S)(Tau) #h(1em) => #h(1em) overline(I) - underline(I) <= overline(S) - underline(S) -->_(lambda(Tau) -> 0) 0 => overline(I) = underline(I) $
  Проверим, что $ I = underline(I) = overline(I) = integral_a^b f(x) d x$
  $underline(S)(Tau) <= I <= overline(S)(Tau)$\
  $underline(S)(Tau) <= sigma(f, Tau, xi) <= overline(S)(Tau)$
  $=> |sigma(f, Tau, xi) - I| <= overline(S) - underline(S) -->_(lambda(Tau) -> 0) 0 #h(5em) qed $
$Blue(underline("Определение:"))$ Колебанием функции $f$ на отрезке $[a;b]$ называется $omega(f, x) = sup_x f(x) - inf_x f(x)$\
На $[x_(i - 1); x_i]: omega_i = M_i - m_i$\
#underline("Лемма") $ overline(S)(Tau) - underline(S)(Tau) = sum_(i=1)^n (M_i - m_i) (x_i - x_(i-1)) = sum_(i=1)^n omega_i (x_i - x_(i-1)) $
#theorem("(критерий интегрируемости в терминах колебания функции)")[
  $ f in R_([a;b]) <=> lim_(lambda(Tau) -> 0) sum_(i=1)^n omega_i (x_i - x_(i-1)) = 0 $
]
#underline("Пример")$""_1$
$f(x) = x$ на $[0;1]$:\
Рассмотри равномерное разбиение $Tau_n: x_i = i/n$\
$ [x_(i - 1); x_i] = [(i - 1)/n; i/n]: m_i = (i-1)/n #h(1em) M_i = i/n  #h(1em)omega_i = f(x_i) - f(x_(i - 1)) = 1/n$\
$ sum_(i=1)^n omega_i (x_i - x_(i-1)) = sum_(i=1)^n 1/n * 1/n = 1/n -->_(n -> infinity) 0 $
#underline("Пример")$""_2$
$D(x)$ на $[0;1]$:\
При плюбом разбиении $[x_(i-1); x_i]: m_i = 0 #h(1em) M_i = 1 #h(1em)omega_i = 1$\
$ sum_(i=1)^n omega_i (x_i - x_(i-1)) = sum_(i=1)^n 1 * 1/n = 1 -->_(n -> infinity) 1 arrow.not 0 $

#underline("Пример")$""_3$(Функция Риммана, Томаэ)\ 
$ r(x) = cases( 1/q "," x = p/q in QQ, 1 "," x in.not QQ) $
TODO: доказать интегрируемость функции Римана
== Классы интегрируемых функций
=== Непрерывные функции
Для интегрируемости непрерывной функции нам понадобится понятие равномерной непрерывности, поэтому давайте поговорим о нём\
$Blue(underline("Определение:"))$ Функция $f$ называется _равномерно непрерывной_ на множестве $X$, если\ $forall epsilon > 0: exists delta > 0: |x - y| < delta #h(1em) (x - y in X) => |f(x) - f(y)| < epsilon$\
#underline("Пример")$""_1$  $f(x) = sin(x)$\
$x in RR #h(1em) |sin(x) - sin(y)| = underbrace(|f'(xi)|, <= 1) |x - y| <= |x - y| "(теорема Лагранжа)"$\
Если $|sin(x) - sin(y)| < delta = epsilon #h(1em) => |sin(x) - sin(y)| < epsilon$ (для любого $epsilon > 0$ мы можем взять $delta = epsilon$)\
значит $sin(x)$ равномерно непрерывна\
#underline("Пример")$""_2$
$f(x) = 1/x$ (на $(0,1)$)\
Будем брать в качестве $x = 1/n, "где" n in NN$ $|1/(2n) - 1/n| = 1/(2n) -> 0$\
Но $f(1/(2n)) - f(1/n) = n -> infinity$\
Значит $f$ неравномерно непрерывна на $(0,1)$\
#theorem("Теорема Кантора")[
  $f$ непрерывная функция на компакте $K => f$ равномерно непрерывная на $K$
]
Замечание: _компакт_ - это замкнутое и ограниченное множество\
#underline("Доказательство") \( от противного) \
Пусть $f$ непрерывная функция на компакте $K$, но неравномерно непрерывная на $K$\
+ Отрицание определения равномерной непрерывности:\ $exists epsilon_0 > 0: forall delta > 0: exists x, y in K |x - y| < delta #h(2em) |f(x) - f(y)| >= epsilon_0$\
  Пусть $delta_n = 1/n: |x_n - y_n|< 1/n => |f(x_n) - f(y_n)| >= epsilon_0$\
+ Выделим из ${x_n}$ сходящуюся подпоследовательность ${x_(n_k)} -->_(k -> infinity) x_0$\ (это можно сделать по теореме _Больцано-Коши_ т. к. ${x_n}$ ограничена)\
+ Рассмотрим ${y_(n_k)}$: $|x_(n_k) - y_(n_k)| < 1/n_k -->_(k -> infinity) 0 => y_(n_k) -->_(k -> infinity) x_0$\
+ Противоречие:\
  $lim_(k -> infinity) f(x_(n_k)) = f(x_0)$\
  $lim_(k -> infinity) f(y_(n_k)) = f(x_0)$\
  (определение непрерывности по Гейне)\
  С другой строны: $|f(x_(n_k)) - f(y_(n_k))| -->_(n_k -> infinity) 0$\
  $|f(x_(n_k)) - f(y_(n_k))| >= epsilon_0$\
#theorem("(об интегрировании непрерывной функции)")[
  $f$ непрерывная функция на $[a;b] => f in R_([a;b])$
]
#underline("Доказательство:")\
$f$ равномерно непрерывна на $[a;b]$(по _теореме Кантора_)\
+ $ I = epsilon/(b - a) #h(1em) exists delta: |x' - x''| < delta => |f(x') - f(x'')| < epsilon/(b - a) $\
+ Выбернем разбиение $Tau$ с мелколстью $lambda(Tau) < delta$ $ => forall [x_(i-1); x_i]: |f(x') - f(x'')| < epsilon/(b - a) $\
+ так как $f in C([x_(i-1);x_i]) =>$ она достигает своего минимума и максимума на $[x_(i-1); x_i]$\
  $ M_i = f(xi'_i) "и" m_i = f(xi''_i), "где" xi'_i, xi''_i in [x_(i-1); x_i]$\
  $omega_i = f(xi'_i) - f(xi''_i), |xi'_i - xi''_i| < delta$\
+ $ overline(S)(Tau) - underline(S)(Tau) = sum_(i=1)^n omega_i Delta x_i < sum_(i=1)^n epsilon/(b - a) Delta x_i = epsilon/(b - a) sum_(i = 1)^n Delta x_i $
  тогда $f$ интегрируема на $[a;b]$\
#underline("Пример")
$ integral_0^1 x d x = lim_(n -> infinity) sum_(i=1)^n (i)/n * 1/n = lim_(n -> infinity) sum_(i=1)^n i = lim_(n -> infinity) 1/n^2 * n(n+1)/2 = 1/2 $\
Разбиение $Tau_n: x_i = i/n, f(x_i) = x_i$\
=== Монотонные функции
#theorem("(об интегрировании монотонной функции)")[
  $f$ монотонная функция на $[a;b] => f in R_([a;b])$
]
#underline("Доказательство:")\
Не умаляя общности, пусть $f$ - неубывающая функция на $[a;b]$\
+ Ограниченность: $f(a) <= f(x) <= f(b)$\
+ Тривиальный случай: $f(a) = f(b) => f(x) = f(a) = "const", f in R_([a;b])$\
+ $Tau$ - разбиение отрезка $[a;b]$\
  $M_i = f(x_i) #h(1em) m_i = f(x_(i-1)) #h(1em) omega_i = f(x_i) - f(x_(i-1))$
+
  $ sum_(i=1)^n omega_i Delta x_i = sum_(i=1)^n underbrace((f(x_i) - f(x_(i-1))), >= 0) Delta x_i <= lambda(Tau) $
  $ sum_(i=1)^n (f(x_i) - f(x_(i-1)) = lambda(Tau) (f(x_n) - f(x_0)) = lambda(Tau) (f(b) - f(a)) -->_(lambda(Tau) -> 0) 0 $
  тогда $f$ интегрируема на $[a;b]$\
#underline("Пример")
$f(x) = sum_(n: r_n < x) 1/(2^n), "где" {r_n}_(n = 1)^infinity - "последовательность рациональных чисел"$\
На $[0;1]$ функция $f$ - неубывающая, так как при увеличении $x$ мы добавляем слагаемые в сумму. И ограничена сверху\
Тогда $f$ интегрируема на $[0;1]$\
=== Функции с конечным числом точек разрыва
#theorem("")[
  $f$ ограниченная на $[a;b]$ и имеет конечное число точек разрыва $=> f in R_([a;b])$ 
]
#underline("Доказательство:")\
+ Пусть у $f$ -- $k$ точек разрыва, окружим каждую интервалом $delta_0$. Причём выберем $delta_0$ так, чтобы суммарная длина $k * delta_0 < epsilon/2 omega$, где $omega$ - колебание функции на $[a;b]$\
+ Вне этих окрестностей функция непрерывна(на $k + 1$ отрезке)
  $f$ равномерно непрерывна на компактном множжестве $=> f$ равномерно непрерывна на нём(по _теореме Кантора_)
+ Возьмём разбиение $Tau$, пусть точки разрыва принадледат $Delta_i^("плохие")$, а остальные точки разбиения - $Delta_i^("хорошие")$\
  $ overline(S)(Tau) - underline(S)(Tau) = sum_(i=1)^n omega_i Delta x_i = sum_(i: Delta_i^("плохие")) omega_i Delta x_i + sum_(i: Delta_i^("хорошие")) omega_i Delta x_i$
+ $ sum_("плохие") omega_i Delta x_i < sum_("плохие") omega Delta x_i = omega sum_("плохие") Delta x_i < omega epsilon/(2 omega) = epsilon/2 $
+ Посколько на объелинении хороших отрезков $f$ равномерно непрерывна, то при достаточной мелкости $lambda(Tau):$
  $ omega_i < epsilon/(2(b - a)) $
  $ sum_("хорошие") omega_i Delta x_i < sum_("хорошие") epsilon/(2(b - a)) Delta x_i = epsilon/(2(b - a)) sum_("хорошие") Delta x_i < epsilon/(2(b - a)) (b - a) = epsilon/2 $
+ $ overline(S)(Tau) - underline(S)(Tau) < epsilon/2 + epsilon/2 = epsilon $
#underline("Замечание") В общем случае ничего нельзя сказать про функцию с бесконечным числом точек разрыва.\
$ D(x) in.not R_([a;b]) $\
$ f = cases("sign"(sin(1/x)) "," x in (0;1], 0 "," x = 0) , f - "интегрируема" $\
== Алгебраические свойства определённого интеграла
#Block[
  определённый интеграл - функционал (ставит в соответвие линейному простравству функций - число)
]
+ $ integral_a^a f(x) d x = 0 $
+ $ integral_b^a f(x) d x = - integral_a^b f(x) d x $
+ Линейность: $ integral_a^b (alpha f(x) + beta g(x)) d x = alpha integral_a^b f(x) d x + beta integral_a^b g(x) d x $
#underline("Доказательство:")
Обозначим $h(x) = alpha f(x) + beta g(x)$\
$ sigma(h, Tau, xi) = sum_(i=1)^n h(xi_i) Delta x_i = alpha sum_(i=1)^n f(xi_i) Delta x_i + beta sum_(i=1)^n g(xi_i) Delta x_i = alpha sigma(f, Tau, xi) + beta sigma(g, Tau, xi) $
перейдём к пределу при $lambda(Tau) -> 0$ получаем требуемое\
=== Аддитивность определённого интеграла
#theorem("")[
  $f in R_([a;b]) <=> f in R_([a;c]) "и" f in R_([c;b]) , "где" c in [a; b]$
  $ integral_a^b f(x) d x + integral_b^c f(x) d x = integral_a^c f(x) d x $
]
#underline("Доказательство:")\
+ $\<=$ $f in R_([a;c]) "и" f in R_([c;b])$\
  Пусть $epsilon > 0: exists Tau_1 - "разбиение" [a;c]: overline(S)(Tau_1) - underline(S)(Tau_1) < epsilon/2$\
  #h(6em) $exists Tau_2 - "разбиение" [c;b]: overline(S)(Tau_2) - underline(S)(Tau_2) < epsilon/2$\
  Возьмём $Tau = Tau_1 union Tau_2$\
  $ overline(S)(Tau) - underline(S)(Tau) = (overline(S)(Tau_1) - underline(S)(Tau_1)) + (overline(S)(Tau_2) - underline(S)(Tau_2)) < epsilon/2 + epsilon/2 = epsilon $\
+ $=>$\
  $ forall epsilon > 0: exists Tau: overline(S)(Tau) - underline(S)(Tau) < epsilon $
  Пусть $Tau' = Tau union {c}$\
  $ overline(S)(Tau') - underline(S)(Tau') <= (overline(S)(Tau) - underline(S)(Tau)) < epsilon $
  Представим $Tau$ в виде $Tau_1 union Tau_2$, где $Tau_1$ - разбиение отрезка $[a;c]$, а $Tau_2$ - разбиение отрезка $[c;b]$\
  $ overline(S)(Tau) - underline(S)(Tau) = (overline(S)(Tau_1) - underline(S)(Tau_1)) + (overline(S)(Tau_2) - underline(S)(Tau_2)) < epsilon $\
  $ overline(S)(Tau_1) - underline(S)(Tau_1) < epsilon #h(1em) => f in R_([a;c]) $\
  $ overline(S)(Tau_2) - underline(S)(Tau_2) < epsilon #h(1em) => f in R_([c;b]) $\
=== Интегрирование неравенств
#theorem("")[
  $f, g in R_([a;b]), forall x in [a;b]: f(x) <= g(x) => integral_a^b f(x) d x <= integral_a^b g(x) d x $
]
#underline("Доказательство:")\
Рассмотрим $ integral_a^b f(x) d x - integral_a^b g(x) d x = integral_a^b underbrace((f(x) - g(x)), >= 0) d x $\
_Лемма:_ Если $f$ - неотрицательная функция на $[a;b]$, то $ integral_a^b f(x) d x >= 0 $
#underline("Следствие:")
$ lr(|integral_a^b f(x) d x|) <= integral_a^b |f(x)| d x $
Для доказательства достаточно проинтегрировать неравенство $-|f(x)| <= f(x) <= |f(x)|$\
#underline("Замечание:") $f(x) in R_([a;b]) => |f(x)| in R_([a;b])$ а $|f(x)| in R_([a;b]) arrow.double.not f in R_([a;b])$\
=== Теоремы о среднем значении

#theorem("(I теорема о среднем значении для определённого интеграла)")[
  $ f in С_([a;b]) => exists xi in [a;b]: integral_a^b f(x) d x = f(xi) (b - a) $
]
#Block[
  напоминание: $f in C_([a;b])$ значмает, что $f$ непрерывная функция на $[a;b]$
]
#underline("Доказательство:")\
+ $f$ непрерывная $=> exists m = min_(x in [a;b]) f(x)$ и $M = max_(x in [a;b]) f(x)$ и верно неравенство $m <= f(x) <= M$\
+ Проинтегрируем это неравенство: 
  $ integral_a^b m d x <= integral_a^b f(x) d x <= integral_a^b M d x #h(1em) => m <= (integral_a^b f(x) d x)/(b - a) <= M $\
+ поделим на $b - a$ и воспользуемся непрерывностью функции $f$\
  $ m <= underbrace(1/(b - a) integral_a^b f(x) d x, mu) <= M $
  $ exists xi in [a;b]: f(xi) = mu => integral_a^b f(x) d x = f(xi) (b - a) $
#underline("Замечание:") Если $f$ -- только интегрируемая, то $mu in [inf_(x in [a;b]) f(x); sup_(x in [a;b]) f(x)]$\
$Blue(underline("Определение:"))$ $ integral_a^b f(x) d x /(b - a) $ - называется _средним значением функции на $[a;b]$_
#Block[
  по аналогии с средним арифметическим
]
#theorem("Обобщенная теорема о среднем значении")[
  $f, g in R_([a;b]), g - "не меняет знак на " [a;b], f in C_([a;b]) $\
  $ g >= 0 => exists xi in [a;b]: integral_a^b f(x) g(x) d x = f(xi) integral_a^b g(x) d x $
]
#underline("Доказательство:")\
+ $f$ -- непрерывная на $[a;b]$ тогда $exists m = min_(x in [a;b]) f(x)$ и $M = max_(x in [a;b]) f(x)$ и верно неравенство $m <= f(x) <= M$\
+ Так как $g >= 0:$ домножим на неё неравенство $m g(x) <= f(x) g(x) <= M g(x)$\
+ Проинтегрируем это неравенство: 
  $ integral_a^b m g(x) d x <= integral_a^b f(x) g(x) d x <= integral_a^b M g(x) d x$\
+ Случай $ integral_a^b g(x) d x = 0 => integral_a^b g(x) f(x) d x = f(xi) integral_a^b g(x) d x $
+ Во втором случае поделим на $ integral_a^b g(x) d x$ и воспользуемся непрерывностью функции $f$\
  $ m <= underbrace((integral_a^b f(x) g(x) d x)/(integral_a^b g(x) d x), mu) <= M $
+ Так как $f$ непрерывная 
  $ exists xi in [a;b]: f(xi) = mu => integral_a^b f(x) g(x) d x = f(xi) integral_a^b g(x) d x $
#theorem("(II теорема о среднем значении для определённого интеграла(Бонне))")[
  $ f, g in R_([a;b]), g - "монотонна на " [a;b], f in C_([a;b]) $\
  $ exists xi in [a;b]: integral_a^b f(x) g(x) d x = g(a) integral_a^xi f(x) d x + g(b) integral_xi^b f(x) d x $
]
#underline("Пример")\(интегральный синус)\
$ lr(|integral_a^b sin(x)/x d x|) = lr(|1/a integral_a^xi sin(x) d x + 1/b integral_xi^b sin(x) d x|) = lr(|1/a(cos(a) - cos(xi)) + 1/b(cos(xi) - cos(b))|) $
$ <= 1/a|cos(a) - cos(xi)| + 1/b|cos(xi) - cos(b)| <= 2 (1/a + 1/b) <= 4/a $
== Интеграл с переменным верхним пределом
$Blue(underline("Определение:"))$ $ Phi(x) = integral_a^x f(t) d t $ называется _интегралом с переменным верхним пределом_\
#theorem("")[
  Интеграл с переменным верхним пределом -- непрерывная функция
]
#underline("Доказательство:")\
Рассмотрим произвольную точку $x$:
  $ Delta Phi(x) = Phi(x + Delta x) - Phi(x) = integral_a^(x + Delta x) f(t) d t - integral_a^x f(t) d t = integral_x^(x + Delta x) f(t) d t <= Delta x M -->_(Delta x -> 0) 0 $

#theorem("Барроу")[
  $f in R_([a;b])$ и $f$ непрерывна в окрестности $delta$ точки $x_0$
  Тогда $Phi(x)$ дифференцируема в точке $x_0$ и $Phi'(x_0) = f(x_0)$
]
#underline("Доказательство:")\
$ (Phi(x_0 + Delta x) - Phi(x_0))/(Delta x) = (integral_x_0^(x_0 + Delta x) f(t) d t)/(Delta x) = (f(xi) Delta x) = Delta x = f(xi) $
По теореме о среднем($xi in [x_0, x_0 + Delta x]$)\
$xi -->_(Delta x -> 0) x_0$ тогда $f(xi) --> f(x_0)$\
#underline("Пример")\
+ $ lim_(x -> 0) (integral_0^x sin(t^2) d t)/x^3 = lim_(x -> 0) sin(x^2)/3x^2 = 1/3 $
+ $ lim_(x -> + infinity) (integral_0^x e^(t^2) d t )^2/(integral_0^x e^(t^2) d t ) = lim_(x -> + infinity) 2integral_0^x e^(t^2) d t e^(x^2)/(e^(2x^2)) = lim_(x -> + infinity) 2 integral_0^x e^(t^2) d t/(e^(x^2)) = lim_(x -> + infinity) (2e^x^2)/(2x e^x^2) = 0 $
Замечание: интеграл квадрата растёт быстрее, чем квадрат интеграла\
== Формула Ньютона-Лейбница
#theorem("Формула Ньютона-Лейбница")[
  $f in R_([a;b])$ и $f$ имеет первообразную $F$ на $[a;b]$
  Тогда $ integral_a^b f(x) d x = F(b) - F(a) $
]
#underline("Доказательство:")\
+ Рассмотрим $Phi(x) = integral_a^x f(t) d t$, $Phi'(x) = f(x)$ (так как $Phi(x)$ -- первообразная)
+ $exists c: Phi(c) = F(x) + C$\
+ $ integral_a^b f(x) d x = Phi(b) - Phi(a)$
  Найдём $C$:\
  $x = a: 0 = Phi(a) = F(a) + C => C = -F(a)$\
  $x = b: 0 = Phi(b) =integral_a^b f(t) d t = F(b) + C = F(b)$\
+ то есть $ integral_a^b f(x) d x = F(b) - F(a) $
#underline("Замена переменной в опредённом интеграле")\
$f$ - непрерывная функция на $[a;b] #h(1.5em) f(x) = g(t) "на" [alpha; beta]: g(alpha) = a, g(beta) = b$\ 
$ integral_a^b f(x) d x = integral_alpha^beta g(t) d t $
#underline("Интегрирование по частям в опредлённом интеграле")\
$u, v$ - непрерывные функции на $[a;b]$ и дифференцируемые на $(a;b)$\
$ integral_a^b u d v = lr(u v|_a^b) - integral_a^b v d u $
== Геометрические приложения определённого интеграла