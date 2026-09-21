#import "@preview/touying:0.7.4": *
#import "@preview/codly:1.3.0": *
#import "colors.typ": *
#import "fonts.typ": *
#import "components.typ": *
#import "slides.typ": slide, title-slide, outline-slide, section-slide, focus-slide, blank-slide

#let _robotics-header(self) = {
  let fonts = self.store.at("fonts", default: default-font-presets.cute)
  let title = self.store.at("current-slide-title", default: auto)
  let badge-label = self.store.at("badge-label", default: [ROBOTICS LAB])
  let hdr = if title != auto {
    title
  } else {
    utils.display-current-heading(level: 2)
  }

  // Header layout:
  // Top breadcrumb + category pill
  // Main slide title with cute teal accent bar
  block(
    width: 100%,
    inset: (x: 1.5cm, top: 0pt),
    stack(
      spacing: 0.8em,
      // Breadcrumbs / Section category
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #set text(font: fonts.accent, size: 0.68em, fill: inventor-slate-dark, weight: "bold")
          #let sec = utils.display-current-heading(level: 1)
          #if sec != none [ #sec ] else [ #text(fill: inventor-slate-dark.lighten(20%))[AGENDA] ]
        ],
        [
          #if badge-label != none [
            #box(
              fill: inventor-slate-light,
              radius: 100pt,
              inset: (x: 0.6em, y: 0.18em),
              text(font: fonts.accent, fill: inventor-petrol, size: 0.62em, weight: "bold")[#badge-label]
            )
          ]
        ]
      ),
      // Main slide title (clean layout without any external logo)
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #if hdr != none and hdr != [] and hdr != "" [
            #box(
              stroke: (left: 4.5pt + inventor-teal),
              inset: (left: 0.6em, y: 0.05em),
              text(font: fonts.heading, size: 1.25em, weight: "bold", fill: inventor-petrol, hdr)
            )
          ]
        ],
        [
          // Optional subtle mini status or custom header widget
          #let hw = self.store.at("header-right", default: none)
          #if hw != none [ #hw ]
        ]
      )
    )
  )
}

#let _robotics-footer(self) = context {
  let fonts = self.store.at("fonts", default: default-font-presets.cute)
  set text(font: fonts.accent, size: 0.72em, fill: inventor-text-muted)

  block(
    width: 100%,
    inset: (x: 1.5cm, bottom: 0.5cm),
    [
      // Segmented accent line inspired by Robot Inventor colorway
      #block(
        width: 100%,
        height: 4pt,
        stack(
          dir: ltr,
          line(stroke: 2.5pt + inventor-petrol, length: 2.2em),
          line(stroke: 2.5pt + inventor-teal, length: 2.2em),
          line(stroke: 2.5pt + inventor-yellow, length: 2.2em),
          line(stroke: 1pt + inventor-slate-light, length: 100% - 6.6em),
        )
      )

      #v(0.5em)

      #grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #let author = self.info.at("author", default: "")
          #let inst = self.info.at("institution", default: "")
          #if author != "" [ #strong(author) ]
          #if inst != "" [ #h(0.4em) · #h(0.4em) #inst ]
        ],
        [
          // Cute rounded pill slide counter
          #box(
            fill: inventor-petrol,
            radius: 100pt,
            inset: (x: 0.7em, y: 0.25em),
            [
              #set text(font: fonts.accent, fill: white, weight: "bold", size: 0.9em)
              #utils.slide-counter.display()
              #text(fill: inventor-yellow, weight: "bold")[ \/ #utils.last-slide-number]
            ]
          )
        ]
      )

      // Optional progress bar along the very bottom
      #if self.store.progress-bar {
        place(
          bottom + left,
          float: true,
          move(dy: 0.55cm)[
            #components.progress-bar(
              height: 2.5pt,
              inventor-teal,
              inventor-slate-light,
            )
          ]
        )
      }
    ]
  )
}

/// Main Robotics Theme function for Touying presentations
#let robotics-theme(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  progress-bar: true,
  font-style: "cute", // "cute" | "modern" | "tech"
  font-heading: auto,
  font-body: auto,
  font-code: auto,
  font-accent: auto,
  badge-label: [ROBOTICS LAB],
  header-right: none,
  ..args,
  body,
) = {
  // Extract font configuration if passed via config-fonts()
  let font-config = args.pos().find(item => type(item) == dictionary and "fonts" in item)
  let fonts = if font-config != none {
    font-config.fonts
  } else {
    config-fonts(
      style: font-style,
      heading: font-heading,
      body: font-body,
      code: font-code,
      accent: font-accent,
    ).fonts
  }

  // Update global typography state
  robotics-fonts-state.update(fonts)

  // Document-wide typographic foundations
  set text(font: fonts.body, size: 20pt, fill: inventor-text, lang: "en", number-type: "lining")
  set par(justify: false, leading: 0.7em)
  show heading: set text(font: fonts.heading, fill: inventor-petrol)
  show raw: set text(font: fonts.code)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      fill: inventor-bg,
      margin: (top: 3.2cm, bottom: 2.2cm, x: 1.5cm),
      header: _robotics-header,
      footer: _robotics-footer,
      header-ascent: 0.6cm,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: section-slide,
    ),
    config-colors(
      primary: inventor-teal,
      secondary: inventor-petrol,
      tertiary: inventor-yellow,
      neutral-darkest: inventor-text,
      neutral-dark: inventor-text-muted,
      neutral-lightest: inventor-bg,
    ),
    config-store(
      navigation: navigation,
      progress-bar: progress-bar,
      current-slide-title: auto,
      current-slide-subtitle: none,
      badge-label: badge-label,
      header-right: header-right,
      fonts: fonts,
    ),
    config-methods(
      init: (self: none, body) => {
        let f = if self != none and "fonts" in self.store { self.store.fonts } else { fonts }
        set text(font: f.body, size: 20pt, fill: inventor-text, lang: "en", number-type: "lining")
        set par(justify: false, leading: 0.7em)
        show heading: set text(font: f.heading, fill: inventor-petrol)
        show raw: set text(font: f.code)

        // Cute bullet styling
        set list(
          marker: (
            text(fill: inventor-teal, size: 0.75em)[◆],
            text(fill: inventor-petrol, size: 0.6em)[▪],
            text(fill: inventor-yellow, size: 0.6em)[●],
          ),
          spacing: 0.5em,
          body-indent: 0.6em,
        )

        // Cute numbered list styling
        set enum(
          numbering: n => box(
            fill: inventor-teal,
            radius: 100pt,
            inset: (x: 0.45em, y: 0.15em),
            text(font: f.accent, fill: white, size: 0.75em, weight: "bold")[#n]
          ),
          spacing: 0.5em,
          body-indent: 0.6em,
        )

        // Codly code block initialization
        show: codly-init.with()
        codly(
          stroke: 1pt + inventor-slate-light,
          radius: 5pt,
          fill: inventor-surface,
          zebra-fill: inventor-bg-tint,
          display-name: false,
          display-icon: false,
          number-format: n => text(font: f.code, fill: inventor-slate-dark, size: 0.75em)[#n],
        )

        // Links and emphasis
        show link: set text(fill: inventor-teal)
        show strong: it => text(fill: inventor-petrol, weight: "bold", it.body)

        body
      },
    ),
    ..args,
  )

  body
}
