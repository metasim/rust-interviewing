#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "@preview/cetz:0.4.2"

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Lorem Ipsum Praesentation],
    subtitle: [Dolor Sit Amet],
    author: [Auctor Nomen],
    date: datetime.today(),
    institution: [Institutio Lorem],
  ),
)

// Slide 1: Title
#title-slide()

// Slide 2: Outline
== Agenda <touying:hidden>

#outline(title: none, indent: 1em, depth: 2)

// Slide 3: Abstraction diagram
== Levels of Abstraction

#grid(
  columns: (1fr, auto),
  column-gutter: 1.2em,
  align: (left + horizon, center + horizon),

  stack(
    spacing: 6pt,
    rect(width: 100%, height: 3em, fill: rgb("#dce8f5"), stroke: rgb("#4a90d9"), radius: 3pt, inset: 0.7em)[
      #align(center + horizon)[Lorem Ipsum — Layer Four]
    ],
    rect(width: 100%, height: 3em, fill: rgb("#b8d4ed"), stroke: rgb("#4a90d9"), radius: 3pt, inset: 0.7em)[
      #align(center + horizon)[Dolor Sit Amet — Layer Three]
    ],
    rect(width: 100%, height: 3em, fill: rgb("#85b8e0"), stroke: rgb("#4a90d9"), radius: 3pt, inset: 0.7em)[
      #align(center + horizon)[Consectetur Adipiscing — Layer Two]
    ],
    rect(width: 100%, height: 3em, fill: rgb("#4a90d9"), stroke: rgb("#2a6090"), radius: 3pt, inset: 0.7em)[
      #align(center + horizon)[#text(fill: white)[Sed Do Eiusmod — Layer One]]
    ],
  ),

  rotate(-90deg, reflow: true)[
    #text(size: 0.85em)[Specificity #sym.arrow.r]
  ],
)

// Slide 4: CeTZ version of the abstraction diagram
== Levels of Abstraction (CeTZ)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let bw = 11.0  // box width
    let bh = 1.4   // box height
    let gap = 0.45 // vertical gap between boxes

    // Layer definitions: (label, fill, text-fill)
    let layers = (
      ("Sed Do Eiusmod — Layer One",       rgb("#4a90d9"), white),
      ("Consectetur Adipiscing — Layer Two", rgb("#85b8e0"), black),
      ("Dolor Sit Amet — Layer Three",      rgb("#b8d4ed"), black),
      ("Lorem Ipsum — Layer Four",          rgb("#dce8f5"), black),
    )

    for (i, layer) in layers.enumerate() {
      let (label, fill, tfill) = layer
      let y0 = i * (bh + gap)
      let y1 = y0 + bh
      rect(
        (0, y0), (bw, y1),
        fill: fill, stroke: rgb("#4a90d9"), radius: 0.15,
      )
      content(
        (bw / 2, y0 + bh / 2),
        text(fill: tfill)[#label],
      )
    }

    // Upward arrow to the right of the boxes
    let total-h = 4 * bh + 3 * gap
    let ax = bw + 0.9
    line(
      (ax, 0), (ax, total-h),
      mark: (end: ">", fill: black, scale: 1.2),
      stroke: (paint: black, thickness: 1.5pt),
    )

    // Rotated "Specificity" label alongside the arrow
    content(
      (ax + 0.55, total-h / 2),
      angle: 90deg,
      text(size: 0.85em)[Specificity],
    )
  })
]

// Slide 5 (was Slide 4)
== Sed Do Eiusmod Tempor

Ut labore et dolore magna aliqua enim ad minim veniam. Quis nostrud exercitation
ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor.

- Incididunt labore dolore
- Magna aliqua veniam exercitation
- Ullamco laboris consequat

// Slide 5
== Ut Labore et Dolore

Reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
deserunt mollit anim id est laborum lorem ipsum dolor sit amet.

// Slide 6
== Quis Nostrud Exercitation

Consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore
magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris
nisi ut aliquip.

- Ex ea commodo consequat
- Duis aute irure dolor
- Reprehenderit voluptate velit

// Slide 7
== Ullamco Laboris Nisi

Lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua enim ad minim veniam. Nostrud
exercitation ullamco laboris aliquip ex commodo.

- Aliquip ex commodo consequat
- Duis aute irure dolor reprehenderit
- In voluptate velit esse cillum

// Slide 8
== Ex Ea Commodo Consequat

Fugiat nulla pariatur excepteur sint occaecat cupidatat non proident. Sunt in
culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde
omnis iste natus error sit voluptatem accusantium.

// Slide 9
== Duis Aute Irure Dolor

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed
quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque
porro quisquam est qui dolorem.

- Dolorem ipsum quia dolor sit
- Amet consectetur adipiscing
- Sed eiusmod tempor incididunt

// Slide 10
== Reprehenderit Voluptate

Ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima
veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut
aliquid ex ea commodi consequatur.

- Quid ex ea commodi consequatur
- Vel illum qui dolorem eum fugiat
- Quo voluptas nulla pariatur

// Slide 11
== Velit Esse Cillum Dolore

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis
praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
excepturi sint occaecati cupiditate non provident.

// Slide 12
== Fugiat Nulla Pariatur

Similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et
dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam
libero tempore cum soluta nobis eligendi optio cumque.

- Nihil impedit quo minus id quod maxime
- Placeat facere possimus omnis voluptas
- Assumenda est omnis dolor repellendus

// Slide 13
== Excepteur Sint Occaecat

Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus
saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.
Itaque earum rerum hic tenetur a sapiente delectus.

// Slide 14
== Cupidatat Non Proident

Ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis
doloribus asperiores repellat. Lorem ipsum dolor sit amet consectetur adipiscing
elit sed do eiusmod tempor.

- Maiores alias consequatur perferendis
- Doloribus asperiores repellat lorem
- Ipsum dolor amet consectetur

// Slide 15: Conclusion
== Conclusio et Summa

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua.

*Gratias vobis ago.*
