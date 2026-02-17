#import "requirements.typ": *

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