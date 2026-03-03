#let Box(body, align: left, inset: 0.8em) = std.align(align)[
  #box(
    stroke: 0.4pt + gray,
    inset: inset,
    radius: 3pt,
  )[
    #set std.align(left)
    #set text(size: 10pt, style: "italic")
    #body
  ]
]

// Fancy block
#let Block(body, ..args) = {
  block(
    body,
    inset: (x: 1em),
    stroke: (left: 3pt + gray),
    outset: (y: 3pt, left: -3pt),
    ..args,
  )
}

#let Comment(body, color: luma(245), ..args) = [
  #block(
    fill: color,
    inset: 10pt,
    radius: 5pt,
    stroke: (cap: "round", dash: "dotted"),
    ..args,
  )[#body]
]
