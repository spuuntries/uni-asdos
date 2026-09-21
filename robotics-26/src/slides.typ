#import "@preview/touying:0.7.4": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": badge, hub-matrix

/// Cute stylized Robot Inventor Hub illustration with accurate side-mounted ports
#let _hub-illustration(pattern: "smile", dark: false) = {
  let hub-w = 5.2cm
  let hub-h = 7.6cm
  let body-fill = if dark { inventor-petrol } else { inventor-surface }
  let border-col = if dark { inventor-petrol-light } else { rgb("#D5DFE3") }
  let label-col = if dark { rgb("#7C96A4") } else { rgb("#95ACB7") }
  let hole-fill = if dark { rgb("#081A22") } else { rgb("#E3ECEF") }
  let hole-border = if dark { rgb("#183C4D") } else { rgb("#BACCD4") }
  let socket-fill = if dark { rgb("#06131A") } else { rgb("#1C2C35") }
  let btn-tray = if dark { rgb("#0A212C") } else { rgb("#EDF3F5") }
  let btn-col = if dark { rgb("#153443") } else { white }
  let led-on = if dark { inventor-yellow } else { rgb("#FFD54F") }
  let led-off = if dark { rgb("#0D2531") } else { rgb("#EDF2F4") }

  box(
    width: hub-w,
    height: hub-h,
    [
      // Left teal Technic side casing (as seen on physical hub)
      #place(
        left + top,
        dx: -0.28cm,
        dy: 0.18cm,
        rect(
          width: 0.45cm,
          height: hub-h - 0.36cm,
          radius: (left: 8pt),
          fill: inventor-teal,
          stroke: none,
          [
            #align(center + horizon)[
              #stack(
                spacing: 0.65cm,
                ..(circle(radius: 2.8pt, fill: inventor-teal.darken(28%)),) * 5
              )
            ]
          ]
        )
      )

      // Main white Hub faceplate
      #rect(
        width: hub-w,
        height: hub-h,
        radius: 12pt,
        fill: body-fill,
        stroke: 1.5pt + border-col,
        inset: 0pt,
        [
          // 4 Corner Technic mounting holes
          #let hole(x, y) = place(
            x + y,
            dx: if x == left { 0.35cm } else { -0.35cm },
            dy: if y == top { 0.35cm } else { -0.35cm },
            circle(radius: 5pt, fill: hole-fill, stroke: 1.2pt + hole-border)
          )
          #hole(left, top)
          #hole(right, top)
          #hole(left, bottom)
          #hole(right, bottom)

          // Top features: Lego square logo on left, Bluetooth button on right
          #place(
            top + left,
            dx: 1.1cm,
            dy: 0.4cm,
            rect(
              width: 0.52cm,
              height: 0.52cm,
              radius: 2pt,
              stroke: 1pt + if dark { rgb("#183C4D") } else { rgb("#DDE5EA") },
              fill: none,
            )
          )
          #place(
            top + right,
            dx: -1.05cm,
            dy: 0.38cm,
            circle(
              radius: 9pt,
              fill: if dark { rgb("#123240") } else { white },
              stroke: 1.4pt + if dark { inventor-yellow } else { rgb("#CEB36E") },
              [
                #align(center + horizon)[
                  #image(if dark { "assets/bluetooth-gold.svg" } else { "assets/bluetooth.svg" }, width: 11pt, height: 11pt)
                ]
              ]
            )
          )

          // Center 5x5 LED Matrix (warm golden glow)
          #place(
            center + horizon,
            dy: -0.25cm,
            hub-matrix(
              pattern: pattern,
              size: 3.4em,
              shape: "tile",
              color-on: led-on,
              color-off: led-off,
              bg: none,
            )
          )

          // Left Side Ports: A, C, E (stacked vertically on the edge)
          #place(
            left + horizon,
            dx: 0.04cm,
            dy: -0.22cm,
            stack(
              spacing: 0.72cm,
              ..("A", "C", "E").map(p => grid(
                columns: (auto, auto),
                gutter: 0.28em,
                align: (horizon, horizon),
                rect(width: 3.5pt, height: 11pt, radius: 1pt, fill: socket-fill),
                text(font: "Cascadia Code", size: 0.72em, weight: "bold", fill: label-col)[#p]
              ))
            )
          )

          // Right Side Ports: B, D, F (stacked vertically on the edge)
          #place(
            right + horizon,
            dx: -0.04cm,
            dy: -0.22cm,
            stack(
              spacing: 0.72cm,
              ..("B", "D", "F").map(p => grid(
                columns: (auto, auto),
                gutter: 0.28em,
                align: (horizon, horizon),
                text(font: "Cascadia Code", size: 0.72em, weight: "bold", fill: label-col)[#p],
                rect(width: 3.5pt, height: 11pt, radius: 1pt, fill: socket-fill),
              ))
            )
          )

          // Bottom Controller: Pill tray with [< ( O ) >]
          #place(
            bottom + center,
            dy: -0.48cm,
            box(
              fill: btn-tray,
              radius: 100pt,
              inset: (x: 0.32cm, y: 0.1cm),
              stroke: 1pt + border-col,
              [
                #grid(
                  columns: (auto, auto, auto),
                  column-gutter: 0.2cm,
                  align: (horizon, horizon, horizon),
                  // Left button <
                  box(
                    width: 0.72cm,
                    height: 0.52cm,
                    radius: 100pt,
                    fill: btn-col,
                    stroke: 0.8pt + border-col,
                    align(center + horizon)[#text(size: 0.65em, fill: label-col, weight: "bold")[<]]
                  ),
                  // Center Power button with golden ring
                  circle(
                    radius: 9.5pt,
                    fill: btn-col,
                    stroke: 2pt + if dark { inventor-yellow } else { rgb("#E5C564") },
                    align(center + horizon)[
                      #circle(radius: 3.2pt, fill: if dark { inventor-yellow } else { rgb("#E5C564") })
                    ]
                  ),
                  // Right button >
                  box(
                    width: 0.72cm,
                    height: 0.52cm,
                    radius: 100pt,
                    fill: btn-col,
                    stroke: 0.8pt + border-col,
                    align(center + horizon)[#text(size: 0.65em, fill: label-col, weight: "bold")[>]]
                  )
                )
              ]
            )
          )
        ]
      )
    ]
  )
}

/// Title slide for robotics lab / practicum presentation
#let title-slide(
  title: auto,
  subtitle: none,
  author: auto,
  institution: auto,
  date: auto,
  extra: none,
  tags: (),
  dark: false,
  matrix: "smile",
  graphic: auto,
  ..args,
) = touying-slide-wrapper(self => {
  let fonts = self.store.at("fonts", default: default-font-presets.cute)

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: if dark { inventor-petrol-dark } else { inventor-bg },
      header: none,
      footer: none,
      margin: (x: 2.2cm, top: 1.8cm, bottom: 1.8cm),
    ),
  )

  let info-title = if title != auto { title } else { self.info.at("title", default: "") }
  let info-subtitle = if subtitle != none { subtitle } else { self.info.at("subtitle", default: none) }
  let info-author = if author != auto { author } else { self.info.at("author", default: none) }
  let info-inst = if institution != auto { institution } else { self.info.at("institution", default: none) }
  let info-date = if date != auto { date } else { utils.display-info-date(self) }

  let body = {
    set align(left + horizon)

    grid(
      columns: (1fr, auto),
      gutter: 1.5cm,
      align: (left + horizon, right + horizon),
      [
        // Tags / pills row
        #if tags.len() > 0 [
          #stack(
            dir: ltr,
            spacing: 0.5em,
            ..tags.map(t => if dark {
              box(
                fill: rgb("#133645"),
                radius: 100pt,
                inset: (x: 0.7em, y: 0.3em),
                text(font: fonts.accent, fill: inventor-teal-bright, size: 0.78em, weight: "bold")[#t]
              )
            } else {
              badge(t, fill: inventor-slate-light, color: inventor-petrol)
            })
          )
          #v(0.8em)
        ]

        // Title with cute Inventor accent bar
        #block(
          stroke: (left: 5pt + if dark { inventor-teal-bright } else { inventor-teal }),
          inset: (left: 0.8em),
          [
            #block[
              #set text(
                font: fonts.heading,
                size: 2.1em,
                weight: "bold",
                fill: if dark { white } else { inventor-petrol },
              )
              #set par(leading: 0.28em)
              #info-title
            ]
            #if info-subtitle != none [
              #v(0.4em)
              #text(
                font: fonts.body,
                size: 1.15em,
                weight: "medium",
                fill: if dark { inventor-slate } else { inventor-text-muted },
                info-subtitle,
              )
            ]
          ]
        )

        #v(1em)

        // Metadata block (Author, Institution, Date)
        #block[
          #set text(font: fonts.body, size: 0.88em)
          #if info-author != none [
            #text(
              font: fonts.heading,
              weight: "bold",
              fill: if dark { white } else { inventor-text },
              info-author,
            )
            #h(0.8em)
          ]
          #if info-inst != none [
            #text(
              font: fonts.body,
              fill: if dark { inventor-slate } else { inventor-text-muted },
              [| #h(0.8em) #info-inst],
            )
          ]
          #if info-date != none [
            #v(0.3em)
            #text(
              font: fonts.body,
              fill: if dark { rgb("#94A8B3") } else { inventor-text-muted },
              size: 0.88em,
              info-date,
            )
          ]
          #if extra != none [
            #v(0.5em)
            #extra
          ]
        ]
      ],
      [
        // Cute Hub Graphic on the right (replaces any external logo)
        #if graphic == auto [
          #_hub-illustration(pattern: matrix, dark: dark)
        ] else if graphic != none [
          #graphic
        ]
      ]
    )
  }

  touying-slide(self: self, repeat: 1, body)
})

/// Outline / Agenda slide for lab syllabus
#let outline-slide(
  title: [Lab Roadmap],
  ..args,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
  ))
  touying-slide(
    self: self,
    [
      #v(0.5em)
      #set outline(title: none, indent: 1.2em, depth: self.slide-level)
      #show outline.entry: it => {
        text(fill: inventor-text, weight: "medium", it)
      }
      #outline(..args)
    ]
  )
})

/// Section divider slide for robotics modules
#let section-slide(
  title: auto,
  subtitle: none,
  number: auto,
  level: 1,
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: inventor-bg,
      header: none,
      footer: none,
      margin: (x: 2.5cm, y: 2cm),
    ),
  )

  let display-title = if title != auto and title != none {
    title
  } else {
    utils.display-current-heading(level: level)
  }

  let sec-num = if number != auto {
    number
  } else {
    context {
      let sec = query(heading.where(level: 1)).filter(h => h.location().page() <= here().page())
      if sec.len() > 0 {
        let n = sec.len()
        if n < 10 { "0" + str(n) } else { str(n) }
      } else { "01" }
    }
  }

  let fonts = self.store.at("fonts", default: default-font-presets.cute)

  let content = {
    set align(left + horizon)

    // Subtle technical grid accent in the background
    place(
      right + horizon,
      dx: 1cm,
      box(
        width: 7cm,
        grid(
          columns: (12pt,) * 8,
          rows: (12pt,) * 8,
          gutter: 6pt,
          ..(circle(radius: 1.8pt, fill: inventor-slate-light),) * 64
        )
      )
    )

    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2cm,
      align: (left + horizon, left + horizon),
      [
        // Big Module Number pill
        #box(
          fill: inventor-petrol,
          radius: 8pt,
          inset: (x: 0.7em, y: 0.5em),
          text(font: fonts.accent, fill: inventor-yellow, size: 2.8em, weight: "black")[#sec-num]
        )
      ],
      [
        #block[
          #set text(font: fonts.heading, size: 2.2em, weight: "bold", fill: inventor-petrol)
          #set par(leading: 0.28em)
          #display-title
        ]
        #if subtitle != none [
          #v(0.3em)
          #text(font: fonts.body, size: 1.2em, fill: inventor-text-muted)[#subtitle]
        ]
        #let extra = args.pos().filter(it => it != none and it != [])
        #if extra.len() > 0 [
          #v(0.8em)
          #extra.first()
        ]
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Standout / Focus slide with deep petrol background
#let focus-slide(
  title: none,
  matrix: "robot",
  ..args,
  body,
) = touying-slide-wrapper(self => {
  let fonts = self.store.at("fonts", default: default-font-presets.cute)

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: inventor-petrol-dark,
      header: none,
      footer: none,
      margin: 2.5cm,
    ),
  )

  let content = {
    set align(center + horizon)
    set text(font: fonts.body, fill: white, size: 1.6em)

    // Subtle background 5x5 matrix
    if matrix != none [
      #place(
        center + horizon,
        hub-matrix(
          pattern: matrix,
          size: 10em,
          color-on: rgb("#114253"),
          color-off: rgb("#0A2531"),
          bg: rgb("#06171E"),
          radius: 16pt,
        )
      )
    ]

    block(
      width: 85%,
      [
        #if title != none [
          #text(font: fonts.heading, size: 1.3em, weight: "bold", fill: inventor-yellow)[#title]
          #v(0.8em)
        ]
        #body
      ]
    )
  }

  touying-slide(self: self, repeat: 1, content)
})

/// Blank slide without header/footer for full schematics or demos
#let blank-slide(..args, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      header: none,
      footer: none,
      margin: 1cm,
    ),
  )
  touying-slide(self: self, align(center + horizon, body), ..args)
})

/// Standard robotics lecture / lab slide
#let slide(
  title: auto,
  subtitle: none,
  quote: none,
  alignment: top + left,
  ..args,
) = touying-slide-wrapper(self => {
  let named = args.named()
  let self = utils.merge-dicts(self, config-store(
    current-slide-title: title,
    current-slide-subtitle: subtitle,
  ))

  set align(alignment)

  if quote != none {
    let rest-composer = named.remove("composer", default: auto)
    let quote-composer = (..composer-args) => {
      let composer-bodies = composer-args.pos()
      quote-block(quote)
      if type(rest-composer) == function {
        rest-composer(..composer-bodies)
      } else {
        components.side-by-side(columns: rest-composer, ..composer-bodies)
      }
    }
    touying-slide(self: self, composer: quote-composer, ..args.pos(), ..named)
  } else {
    touying-slide(self: self, ..args)
  }
})
