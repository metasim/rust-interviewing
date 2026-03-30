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

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  header-right: fa-rust(),
  config-info(
    title: [Sharpening your Rust Skills for Job Interviews],
    subtitle: [How to Become a Stand-out Candidate],
    author: [Simeon H.K. Fitch],
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

// Title
#title-slide()

== Motivation

#focus-slide(align: left, config: config-common(freeze-slide-counter: false))[

  You're landed the interview...
  #pause
  #indent[it's going well...
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
    - How do you answer?
    - What I’m about to tell you matters most once you’re in the room
    - Most candidates haven't thought about that question
    - I’m going to show you a way of thinking about Rust that most engineers only develop after years of experience — and you can start developing it right now.
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
  - My hope is to bring a practical  perspective to Rust in the context of professional software engineering
  - I do not subscribe to the "move fast and break things" ethos. Rather, I have found the most efficient way to deliver solutions is to do it once, do it well, and move on.
]

== Restatement

#focus-slide(config: config-common(freeze-slide-counter: false))[
  #align(center)[
    #text(size: 1.4em)[
      "Why would we choose Rust?"
    ]
  ]

  #pause
  #v(0.5em)
  Why would _you_ be asked that question?

  #speaker-note[
    - Think about the "Why" for the organization you're interviewing with.
    - When you're talking about Rust in an interview, the goal isn't just to show that you know the language.
    - Show that you understand what Rust brings to the table in terms of the problems it solves for the organization, the guarantees it provides, and the trade-offs it makes.
    - The candidates who get offers over equally qualified peers are almost always the ones who demonstrate they understand what problem the organization is trying to solve.
  ]
]

== How to Stand Out

=== View Software Engineering from the Employer's Perspective

+ Understand the engineering needs of the employer
+ Map the capabilities and garantees of Rust (and its ecosystem) to those needs

#speaker-note()[
  - The alignment between the skills that make someone effective at Rust and the skills that make someone effective as a professional software engineer is the good news here: the effort you put into learning Rust and thinking in the way Rust encourages is directly applicable to being a strong engineer in general.

  - The questions you ask and the way you frame your answers should demonstrate that you understand Rust in the context of the organization's needs and priorities.
  - Then think about the "How" via Rust.
  - In the time we have ahead I’m going to show you a way of thinking about Rust that most engineers only develop after years of experience — and you can start developing it right now.

]

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
      text(size: 0.35em, fill: gray)[https://dzone.com/articles/quality-is-the-answer],
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
        fill: gray,
      )[Sanders & Klein, _Procedia Computer Science_ 8 (2012), Fig. 1 (orig. INCOSE SE Handbook, 2006)],
    ),
  )),
))

#speaker-note()[
  Rust is one of the few languages where the path from "I know how to use this tool" to "I understand why this tool exists and what it costs and saves organizations" is unusually short and well-documented.
]

== How Rust Delivers

- The skills and mindset that make someone effective at Rust are the same skills and mindset that make someone effective as a professional software engineer
  - Careful attention to ownership, lifetimes, type correctness
  - Considering safety and correctness up-front
- Rust is a language that rewards the kind of thinking that organizations actually need from engineers

#speaker-note()[
  - Rust was designed to solve industrial problems.
  - Understanding Rust deeply is inseparable from understanding why organizations choose it.

]

== How to go from Candidate to Employee

Now, let's discuss how to prepare yourself...

=== Roadmap to Comprehesive Coverage

#let next-steps(highlight: none) = {
  let steps = (
    [Figure out what domain(s) you're intereseted working within. If you're not sure, work on figuring that out (general is okay)],
    [Research what crates exist to serve that ecosystem. Read articles. Read the source. Play with them],
    [From your research, select the largest, most complicated project and read all the `Cargo.toml` and `build.rs` files. If you don't understand something, ask AI to explain],
    [Pick parts of the standard library and read the source. If you don't understand a design decision, ask AI to explain],
    [Read some part of #link("http://cheats.rs")[`cheats.rs`] every day. Research what you don't understand],
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

== Next Steps: Ecosystem

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

== Next Steps: Build System

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

== Next Steps: Standard Library

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

== Next Steps: Langugage

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

== Next Steps: Roadmap

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

== Educational Resources

- *Remember*: Nothing beats writing code and working through challenging problems (with patience)

- Generally, any search will provide a plethora of great educational resources. Pick the ones that fit your learning style

- Some of my favorites:
  - https://doc.rust-lang.org
  - https://cheats.rs
  - https://github.com/microsoft/RustTraining
  - https://tinyurl.com/container-cheat-sheet

Also:
- https://lib.rs

== Final Thoughts

#utils.fit-to-height(100%)[

  === Remember there's Good News!
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

  #qr-code("https://github.com/metasim/rust-interviewing/releases", width: 5cm)
  #fa-github() #link("https://github.com/metasim")[github.com/metasim]

  #align(bottom)[
    PS: These slides were #link("https://github.com/typst/typst")[rendered by Rust!]
  ]
]

