#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "@preview/cetz:0.4.2"
#import "@preview/cades:0.3.1": qr-code
#import "@preview/fontawesome:0.6.0": *
#fa-version("6")

#let handout = sys.inputs.at("handout", default: "false") == "true"
#let speaker = true

#let notes-placement = {
  if handout      { bottom }
  else if speaker { right  }
  else            { none   }
}

#let qr-src(..args) = {
  qr-code("https://github.com/metasim/rust-interviewing/releases", height: 5cm, ..args)
}

#let rotunda(height: 1.1em) = {
  image("images/UVA-rotunda.svg", height: height)
}

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  header-right: [
    #move(dy: -0.3em)[
      #box[#rotunda()]
      #box[#fa-rust()]
      #box[#qr-src(height: 1.1em)] 
    ]
  ],
  config-info(
    title: [Sharpening your Rust Skills for Job Interviews],
    subtitle: [How to Become a Stand-out Candidate],
    author: [Simeon H.K. Fitch],
    institution: [Brown Science & Engineering Library\ University of Virginia],
    date: [April 14th, 2026],
  ),
  config-common(
    show-notes-on-second-screen: notes-placement,
    show-strong-with-alert: false,
    handout: handout,
  ),
  config-colors(
    primary: rgb("#eb811b"),
    neutral-dark: rgb("#23233b"),
    secondary: rgb("#23233b"),
  ),
)

#show link: underline
#set text(font: "Helvetica Neue", weight: "light", size: 20pt)
#set strong(delta: 200)
#let indent(body) = {
  pad(left: 1em, top: -0.5em)[#body]
}

// Overlays `modal-body` centered on top of the slide after a pause.
// The slide content is shown first; the next subslide reveals the modal.
// Advancing again moves to the next slide.
#let modal(modal-body, width: 60%, inset: 2em) = {
  pause
  place(center + horizon,
    block(
      width: width,
      inset: inset,
      radius: 0.5em,
      fill: white,
      stroke: 1.5pt + rgb("#23233b"),
    )[#modal-body]
  )
}

#let grouped-enum-panel(
  title,
  start: 1,
  fill: white,
  stroke: black,
  text-fill: luma(5%),
  ..items,
) = {
  block(
    width: 100%,
    inset: 0.4em,
    radius: 0.35em,
    fill: fill,
    stroke: (paint: stroke, thickness: 0.6pt),
  )[
    #place(top + right,
      box(
        radius: 0.2em,
      )[
        #text(size: 0.72em, weight: "semibold", fill: text-fill)[#title]
      ]
    )
    #set text(size: 0.9em, fill: text-fill)
    #pad(top: 0.1em, right: 8em)[
      #enum(
        start: start,
        tight: true,
        ..items,
      )
    ]
  ]
}

// Title
#title-slide()

= Context <touying:hidden>

== The Interview

#focus-slide(align: left, config: config-common(freeze-slide-counter: false))[
  #speaker-note[- How many of you have "Rust" on your resume?]
  #pause
  You've landed the interview...
  #speaker-note[- How many of you have had a Rust interview already?]
  #pause
  #indent[it's going well...
    #speaker-note[- Let's assume you're being your best?]
    #pause
    #indent[and the engineering manager asks...]
  ]

  #align(center)[
    #quote(block: true)[
      #text(size: 1.4em)[
        "Why would we choose Rust?"
      ]
    ]
  ]

  #speaker-note[
    - How would you answer? Most candidates haven't thought about that question, especially if they're recent graduates.
    - *I’m going to show you a way of thinking about Rust that most engineers only develop after years of experience, helping you stand out as a candidate.*
  ]
]

== `impl Info for Me`

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[
    Simeon H.K. Fitch \
    UVA SEAS (CS) 1994 \
    #fa-github() #link("https://github.com/metasim")[\@metasim] #h(1em)
    #fa-linkedin() #link("https://www.linkedin.com/in/simeon-fitch")[simeon-fitch] \
    #line(length: 100%, stroke: 0.5pt + gray)
    #set text(size: 0.8em)
    === Why I might have something relevant to say on this topic:
    - Over 30 years of software engineering in a variety of quantitative domains: #indent[Satellite communications, reliability engineering, machine learning, image processing, signal processing, distributed systems]
    - Former business owner, startup founder and CTO
    - Currently: Principal Engineer, DataShapes AI, Inc. (a local RF security startup)
  ],
  align(right + top)[
    #stack(dir: ttb, spacing: 0.3em, layout(size => context {
      let img = image("images/fitch-headshot-mono.png", height: 0.6 * size.height)
      let w = measure(img).width
      let cropped-w = 0.8 * w
      stack(dir: ttb, spacing: 0.3em, box(clip: true, width: cropped-w, stroke: 0.5pt)[#img], box(width: cropped-w)[
        #align(right)[#text(size: 0.5em, fill: gray)[Photo: Billy Hunt]]
      ])
    }))
  ],
)

#underline[Career thread]: Deploying reliable, maintainable, and performant software solutions.

#speaker-note[
  - My goal is to bring a practical  perspective to Rust in the context of professional software engineering, both as a developer and as a manager.
  - It takes years to master a language, something we can't achieve here nor before a near-term interview. 
  - However, we can develop a roadmap for becoming a stand-out candidate.
]

== Restatement

#focus-slide(config: config-common(freeze-slide-counter: false))[
  #align(center)[
    #text(size: 1.4em)[
      "Why would _we_ choose Rust?"
    ]
  ]

  #speaker-note()[
    #set text(size: 0.9em)
    - The crux of this presentation:
      - Think about the "Why" for the organization
      - Then understand the "How"
  ]
  #pause
  #v(0.5em)
  Why would _you_ be asked that question?

  #speaker-note[
    #set text(size: 0.9em)
    - In a Rust interview, the goal isn't just to show that you know the language, but to also show that you understand what Rust brings to the table in terms of the problems it solves for the organization.
    - The candidates who get offers over equally qualified peers are the ones who demonstrate _understanding_ of problems the organization is trying to solve.
  ]
]

= Cost Drivers in Commercial Software Engineering

== Employer Motivator: Total Cost of Solution
#let fh = 0.45
#layout(size => grid(
  rows: (1fr, auto),
  gutter: 1em,
  [
    === You've seen these charts before...
    - The cost of defects rises dramatically the later they are discovered in the development lifecycle
    - Rust's type system, ownership model, and compile-time guarantees help catch many classes of defects early, reducing the cost of defects and the risk to the organization
  ],
  align(center, stack(
    dir: ltr,
    spacing: 1em,
    stack(
      dir: ttb,
      spacing: 0.3em,
      box(stroke: 0.5pt)[#image("images/Relative Cost of Fixing a Flaw.png", height: size.height * fh)],
      text(size: 0.35em)[https://dzone.com/articles/quality-is-the-answer],
    ),
    stack(
      dir: ttb,
      spacing: 0.3em,
      box(stroke: 0.5pt)[#image(
        "images/Life Cycle Cost Commitment as a Function of the System Life Cycle.png",
        height: size.height * fh,
      )],
      text(
        size: 0.35em,
      )[Sanders & Klein, _Procedia Computer Science_ 8 (2012), Fig. 1 (orig. INCOSE SE Handbook, 2006)],
    ),
  )),
))

#speaker-note[
  - Organizations care about 
    - Cost to develop
    - Cost to extend / scale / modify
    - Cost to maintain
  - In addition to bugs, those costs are effected by:
    - Inherent vs accidental complexity
    - Technical debt
    - Talent acquisition and onboarding
]



= Preparatory Roadmap

#speaker-note[
  - This is not a prescription with guaranteed results; ultimately that rests on your consistent and dedicated preparation
  - What I'm offering here is a way of decomposing the process into something that's manageable over the span of weeks-to-months.
]

== How to Stand Out

=== View Software Engineering from the Employer's Perspective
  - Understand the engineering needs of the employer (hint: return on investment)
  - Map the capabilities and guarantees of Rust (and its ecosystem) to those needs
  - Understanding Rust deeply is to understand why organizations choose it.

=== Good News!
  - Rust is a language that rewards the kind of thinking that organizations actually need from engineers
  - The skills and mindset that make someone effective at Rust are the generally the same that make someone an effective software engineer
  - The effort you put into learning Rust and thinking in the way Rust encourages is directly applicable to being a strong engineer in general.

#speaker-note[
  - The alignment between the skills that make someone effective at Rust and the skills that make someone effective as a professional software engineer is the good news here: 
  - The questions you ask and the way you frame your answers should demonstrate that you understand Rust in the context of the organization's needs and priorities.
]


#slide(
  title: [How Rust Delivers],
  repeat: 3,
  self => {
    let (uncover,) = utils.methods(self)
    [
      #layout(size =>
        utils.fit-to-height(size.height)[
          #stack(
            dir: ttb,
            spacing: 0.35em,
            grouped-enum-panel(
              [Baseline],
              start: 1,
              fill: rgb("#e7eef8"),
              stroke: rgb("#7d9cc4"),
            )[
              Undefined behavior is *eliminated* by design, not by convention
            ][
              Zero runtime cost memory-safety without a garbage collector
            ][
              Data race freedom is enforced, not tested
            ],
            uncover("2-")[
              #grouped-enum-panel(
                [Engineering],
                start: 4,
                fill: rgb("#fbe9d2"),
                stroke: rgb("#d79a3a"),
              )[
                The type system encodes and enforces domain invariants
              ][
                The module, crate, and workspace system provides a natural unit of decomposition that scales
              ][
                Large-scale refactoring is bounded by the compiler, not by test coverage
              ]
            ],
            uncover("3-")[
              #grouped-enum-panel(
                [Organization],
                start: 6,
                fill: rgb("#e5f1e8"),
                stroke: rgb("#6f9e78"),
              )[
                Lower maintenance costs through machine-checked invariants slow the accumulation of technical debt
              ][
                Upgrading shared dependencies surfaces breaking changes at compile time, reducing cross-team coordination cost
              ][
                Onboarding new contributors to an existing codebase is less risky
              ]
            ],
          )
        ]
      )

      #speaker-note(subslide: [1,2,3])[
        - Baseline: Your understanding of these these items will be a _given_. Make sure you understand deeply how Rust achieves these.
      ]

      #speaker-note(subslide: [2,3])[
        - Engineering: With a strong type system, you can model complex invariants (requirements) that are *guaranteed* at compile time (e.g. non-zero, non-empty, validated, etc.)
      ]

      #speaker-note(subslide: 3)[
        - Organization: Strong types and strong guarantees mean less experienced people can be added more quickly to a team with lower risks/costs.
      ]
    ]
  },
)

== Roadmap for Comprehensive Coverage

#let next-steps(highlight: none) = {
  let steps = (
    [Figure out what domain(s) you're interested working within, or where you're seeing opportunity],
    [Dive deeply into the crates exist to serve that ecosystem. Keyword search on #link("https://lib.rs")["lib.rs"]],
    [From your research, select the largest, most complicated project and read all the `Cargo.toml`, `build.rs`, and `config.toml` files. Also: #link("https://github.com/microsoft/RustTraining")["Microsoft's Rust Training Books"]],
    [Pick parts of the standard library and read the source. Also: #link("https://tinyurl.com/container-cheat-sheet")[Container Cheat Sheet]],
    [Read some part of #link("http://cheats.rs")[`cheats.rs`] and/or #link("https://doc.rust-lang.org/book/")[The Rust Book] every day],
  )
  enum(
    ..steps
      .enumerate()
      .map(((i, step)) => {
        let dimmed = highlight != none and i != highlight
        text(fill: if dimmed { luma(90%) } else { black })[#step]
      }),
  )
}

#let draw-abstraction-layers(bw: 11.0, bh: 1.4, gap: 0.3, highlight: none) = {
  import cetz.draw: *
  let layers = (
    ("Language", rgb("#dce8f5"), black),
    ("Standard Library", rgb("#b8d4ed"), black),
    ("Build System", rgb("#85b8e0"), black),
    ("Ecosystem", rgb("#4a90d9"), white),
    ("Domain", rgb("#1e5fa8"), white),
  )
  for (i, layer) in layers.enumerate() {
    let (label, fill, tfill) = layer
    let dimmed = highlight != none and i != (layers.len() - 1 - highlight)
    let effective-fill = if dimmed { fill.transparentize(70%) } else { fill }
    let effective-tfill = if dimmed { tfill.transparentize(70%) } else { tfill }
    let effective-stroke = if dimmed { rgb("#4a90d9").transparentize(70%) } else { rgb("#4a90d9") }
    let y0 = i * (bh + gap)
    let y1 = y0 + bh
    rect(
      (0, y0),
      (bw, y1),
      fill: effective-fill,
      stroke: effective-stroke,
      radius: 0.15,
    )
    content(
      (bw / 2, y0 + bh / 2),
      text(fill: effective-tfill)[#label],
    )
  }
}

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let bw = 11.0
    let bh = 1.4
    let gap = 0.3

    draw-abstraction-layers(bw: bw, bh: bh, gap: gap)

    let total-h = 5 * bh + 4 * gap

    // Downward arrow to the left of the boxes
    let lx = -0.9
    line(
      (lx, total-h),
      (lx, 0),
      mark: (end: ">", fill: black, scale: 1.2),
      stroke: (paint: black, thickness: 1.5pt),
    )
    content(
      (lx - 0.55, total-h / 2),
      angle: 90deg,
      text(size: 0.85em)[Problem Searching for Tool],
    )
    content(
      (lx, total-h + 0.65),
      text(size: 0.85em)[🔩],
    )

    // Upward arrow to the right of the boxes
    let ax = bw + 0.9
    line(
      (ax, 0),
      (ax, total-h),
      mark: (end: ">", fill: black, scale: 1.2),
      stroke: (paint: black, thickness: 1.5pt),
    )
    content(
      (ax + 0.55, total-h / 2),
      angle: 90deg,
      text(size: 0.85em)[Tool Applied to Problem],
    )
    content(
      (ax, -0.6),
      text(size: 0.85em)[🛠️],
    )
  })
]

#speaker-note[
  - You will want to come at this from both directions
    - Sometimes focus on top-down
    - Other times focus bottom-up
  - We're going to (somewhat) arbitrarily go through this top-down 
]

== Next Steps: Domain

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[#next-steps(highlight: 0)],
  align(center + horizon)[
    #cetz.canvas({
      draw-abstraction-layers(bw: 7, highlight: 0)
    })
  ],
)

#speaker-note[
  - Who here has a particular domain of interest they'd like to work within?
  - If you're not sure, pick something general, like "backend web services" or "MLOps".
]

== Roadmap: Ecosystem

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[#next-steps(highlight: 1)],
  align(center + horizon)[
    #cetz.canvas({
      draw-abstraction-layers(bw: 7, highlight: 1)
    })
  ],
)

#speaker-note[
  - Search keywords on lib.rs
  - Read articles. Read the source. Experiment with them. Form an opinion.
]

// #modal[
//   === https://lib.rs 
//   Helpful Tags and Cross References
//   #image("images/lib-rs.png")
// ]

== Roadmap: Build System

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[#next-steps(highlight: 2)],
  align(center + horizon)[
    #cetz.canvas({
      draw-abstraction-layers(bw: 7, highlight: 2)
    })
  ],
)

#speaker-note[
  - If you don't understand something, ask AI to explain.
  - Try refactoring or improving the organization.
]

== NRoadmap: Standard Library

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[#next-steps(highlight: 3)],
  align(center + horizon)[
    #cetz.canvas({
      draw-abstraction-layers(bw: 7, highlight: 3)
    })
  ],
)

#speaker-note[
  - If you don't understand a design decision, ask AI to explain.
  - Check out the container cheat sheet, and map the diagrams to the actual declarations. 
    https://tinyurl.com/container-cheat-sheet
]

== Roadmap: Language

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[#next-steps(highlight: 4)],
  align(center + horizon)[
    #cetz.canvas({
      draw-abstraction-layers(bw: 7, highlight: 4)
    })
  ],
)

#speaker-note[
  - Again, Research what you don't understand.
  - Go down rabbit holes.
  - Take notes on what you learn.
]

== Full Roadmap

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  align(top)[#next-steps()],
  align(center + horizon)[
    #cetz.canvas({
      draw-abstraction-layers(bw: 7)
    })
  ],
)

#speaker-note[
  - Again, to be effective, alternate directions, biasing the one where your understanding and knowledge are weaker.
]

== Educational Resources

- *Remember*: Nothing beats writing code and working through challenging problems (with patience and consistency)

- Generally, any search will provide a plethora of great educational resources. Pick the ones that fit your learning style.

- Personal "Hall of Fame":
  - https://doc.rust-lang.org
  - https://cheats.rs
  - https://lib.rs
  - https://github.com/microsoft/RustTraining
  - https://tinyurl.com/container-cheat-sheet
  - https://github.com/rust-unofficial/awesome-rust

#speaker-note()[
  - Different people have different learning styles
  - Some are book-first, others are do-first
  - Try multiple ways, but lean into what's intuitive for you
]

== Final Thoughts

#utils.fit-to-height(100%)[

  === Remember the Good News!
  - The qualities that make a great engineer and the qualities that make someone good at Rust are unusually well-aligned
  - Rust rewards the kind of thinking that organizations actually need to deliver profitable solutions
  - Even if you don't land that dream Rust job, everything you do to work towards it will serve you extremely well in any software engineering job

  === What #underline[I] Look For:
  - Genuine engagement in both the problem and solution spaces (genuine engagement is something you can develop!)
  - Also, the candidates who stand out aren't the ones with all the answers. They're the ones who ask the question that shows they understand there's a larger context
]

#speaker-note[
]

== Follow-on Information

#align(center + top)[
  This presentation is available on GitHub:

  #v(3em)

  #qr-src()

  #fa-github() #link("https://github.com/metasim")[github.com/metasim]

  #align(bottom)[
    PS: These slides were #link("https://github.com/typst/typst")[rendered by Rust!]
  ]
]

#speaker-note[
  - Feel free to message me on LinkedIn, or via the contact info on my business card.
  - If there's interest, I'd be happy to meet informally to discuss Rust with a group of at least 3, if someone else coordinates it.
]

