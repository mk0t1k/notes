#import "requirements.typ": *
#set page(
    paper: "a4",
    margin: (top: 3cm, rest: 0.5cm),
    numbering: "1"
    )

#show heading.where(level: 1): it => [
  #pagebreak(weak: true)
  #set text(14pt, weight: "bold")
  #it
]

#show heading.where(level: 2): it => [
  #set text(12pt, weight: "bold")
  #it
]

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

// Оглавление
#outline()



