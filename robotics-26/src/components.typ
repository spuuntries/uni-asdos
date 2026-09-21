#import "@preview/touying:0.7.4": *
#import "@preview/showybox:2.0.4": showybox
#import "colors.typ": *
#import "fonts.typ": robotics-fonts-state

/// Pure-Typst 5x5 LED Hub Matrix widget representing the Robot Inventor Hub display
#let hub-matrix(
  pattern: "smile", // "smile", ":3", "heart", "robot", "arrow", "check", or 5-item array of 5-bit strings/arrays
  size: 2.4em,
  shape: "tile", // "tile" | "circle"
  color-on: rgb("#FFD54F"),
  color-off: rgb("#E6EDF0"),
  bg: none,
  radius: 6pt,
) = {
  let presets = (
    "smile": (
      (0, 1, 0, 1, 0),
      (0, 1, 0, 1, 0),
      (0, 0, 0, 0, 0),
      (1, 0, 0, 0, 1),
      (0, 1, 1, 1, 0),
    ),
    "sad": (
      (0, 1, 0, 1, 0),
      (0, 1, 0, 1, 0),
      (0, 0, 0, 0, 0),
      (0, 1, 1, 1, 0),
      (1, 0, 0, 0, 1),
    ),
    "frown": (
      (0, 1, 0, 1, 0),
      (0, 1, 0, 1, 0),
      (0, 0, 0, 0, 0),
      (0, 1, 1, 1, 0),
      (1, 0, 0, 0, 1),
    ),
    ":3": (
      (1, 0, 0, 0, 1),
      (1, 0, 0, 0, 1),
      (0, 1, 0, 1, 0),
      (1, 0, 1, 0, 1),
      (0, 1, 0, 1, 0),
    ),
    "cute": (
      (1, 0, 0, 0, 1),
      (1, 0, 0, 0, 1),
      (0, 1, 0, 1, 0),
      (1, 0, 1, 0, 1),
      (0, 1, 0, 1, 0),
    ),
    "heart": (
      (0, 1, 0, 1, 0),
      (1, 1, 1, 1, 1),
      (1, 1, 1, 1, 1),
      (0, 1, 1, 1, 0),
      (0, 0, 1, 0, 0),
    ),
    "robot": (
      (1, 0, 0, 0, 1),
      (0, 1, 1, 1, 0),
      (1, 0, 1, 0, 1),
      (1, 1, 1, 1, 1),
      (1, 0, 0, 0, 1),
    ),
    "arrow": (
      (0, 0, 1, 0, 0),
      (0, 1, 1, 1, 0),
      (1, 0, 1, 0, 1),
      (0, 0, 1, 0, 0),
      (0, 0, 1, 0, 0),
    ),
    "check": (
      (0, 0, 0, 0, 1),
      (0, 0, 0, 1, 0),
      (1, 0, 1, 0, 0),
      (0, 1, 0, 0, 0),
      (0, 0, 0, 0, 0),
    ),
  )

  let grid-data = if type(pattern) == str {
    presets.at(pattern, default: presets.at("smile"))
  } else if type(pattern) == array {
    pattern
  } else {
    presets.at("smile")
  }

  box(
    fill: bg,
    radius: radius,
    inset: if bg != none { size * 0.1 } else { 0pt },
    baseline: 20%,
    [
      #grid(
        columns: (size * 0.16,) * 5,
        rows: (size * 0.16,) * 5,
        gutter: size * 0.045,
        ..grid-data.map(row => {
          let cols = if type(row) == str { row.clusters().map(c => if c == "1" or c == "#" { 1 } else { 0 }) } else { row }
          cols.map(val => {
            let is-on = (val == 1 or val == true or val == "1")
            if shape == "tile" or shape == "square" {
              rect(
                width: size * 0.16,
                height: size * 0.16,
                radius: size * 0.03,
                fill: if is-on { color-on } else { color-off },
              )
            } else {
              circle(
                radius: size * 0.07,
                fill: if is-on { color-on } else { color-off },
              )
            }
          })
        }).flatten()
      )
    ]
  )
}

/// Reusable callout card with cute rounded corners and clean header
#let cblock(
  title: none,
  type: "info", // "info", "hardware", "exercise", "tip", "warning", "danger", "cute"
  color: none,
  bg: none,
  border: none,
  radius: 6pt,
  body,
) = {
  let theme = inventor-semantic.at(type, default: inventor-semantic.info)
  let bar-color = if color != none { color } else { theme.primary }
  let body-bg = if bg != none { bg } else { theme.bg }
  let border-color = if border != none { border } else { theme.border }

  let title-arg = if title != none [
    #context {
      let f = robotics-fonts-state.get()
      text(font: f.heading, weight: "bold", size: 0.95em)[#title]
    }
  ] else { none }

  showybox(
    title-style: (
      color: white,
      sep-thickness: 0pt,
      align: horizon,
    ),
    frame: (
      radius: radius,
      thickness: 1pt,
      border-color: border-color,
      title-color: bar-color,
      body-color: body-bg,
      inset: (x: 0.8em, y: 0.6em),
    ),
    above: 0.4em,
    below: 0.4em,
    title: title-arg,
    [
      #context {
        let f = robotics-fonts-state.get()
        set text(font: f.body, fill: inventor-text, size: 0.9em)
        body
      }
    ]
  )
}

/// Cute rounded pill badge for hardware ports (Port.A, Port.B, etc.)
#let port-badge(port, type: "motor") = context {
  let f = robotics-fonts-state.get()
  let (bg-col, txt-col) = if type == "motor" {
    (inventor-teal-pale, inventor-teal)
  } else if type == "sensor" {
    (inventor-yellow-light, inventor-yellow-dark)
  } else if type == "hub" {
    (inventor-slate-light, inventor-petrol)
  } else {
    (inventor-coral-light, inventor-coral)
  }

  box(
    fill: bg-col,
    radius: 100pt,
    inset: (x: 0.6em, y: 0.22em),
    stroke: 0.5pt + txt-col.lighten(40%),
    baseline: 0%,
    [
      #text(font: f.code, fill: txt-col, size: 0.78em, weight: "bold")[#port]
    ]
  )
}

/// Hands-on robotics lab exercise card with metadata badges (time, difficulty, ports, points)
#let lab-box(
  title: [Robotics Lab Exercise],
  time: none,
  difficulty: none,
  ports: (),
  points: none,
  body,
) = context {
  let f = robotics-fonts-state.get()
  let badges = ()

  if time != none {
    badges.push(box(
      fill: inventor-teal-pale,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.22em),
      text(font: f.accent, fill: inventor-teal, size: 0.75em, weight: "bold")[⏱ #time]
    ))
  }
  if difficulty != none {
    badges.push(box(
      fill: inventor-yellow-light,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.22em),
      text(font: f.accent, fill: inventor-yellow-dark, size: 0.75em, weight: "bold")[★ #difficulty]
    ))
  }
  if ports.len() > 0 {
    badges.push(box(
      fill: inventor-bg-tint,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.22em),
      text(font: f.code, fill: inventor-petrol, size: 0.72em, weight: "bold")[#ports.join(", ")]
    ))
  }
  if points != none {
    badges.push(box(
      fill: inventor-coral-light,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.22em),
      text(font: f.accent, fill: inventor-coral, size: 0.75em, weight: "bold")[#points pts]
    ))
  }

  showybox(
    frame: (
      radius: 6pt,
      thickness: 1.5pt,
      border-color: inventor-teal,
      title-color: inventor-petrol,
      body-color: inventor-surface,
      inset: (x: 1em, y: 0.85em),
    ),
    above: 0.8em,
    below: 0.8em,
    title: grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(font: f.heading, weight: "bold", size: 0.98em, fill: white)[#title],
      stack(dir: ltr, spacing: 0.4em, ..badges)
    ),
    [
      #set text(font: f.body, fill: inventor-text, size: 0.92em)
      #body
    ]
  )
}

/// Backward compatibility alias for exercise-box
#let exercise-box = lab-box

/// Quote block with a tight left accent pill and subtle background
#let quote-block(body, author: none, color: inventor-teal) = context {
  let f = robotics-fonts-state.get()
  block(
    stroke: (left: 3.5pt + color),
    inset: (left: 0.9em, y: 0.2em),
    [
      #set text(font: f.body, fill: inventor-text, style: "italic", size: 0.95em)
      #body
      #if author != none [
        #v(0.3em)
        #set text(font: f.body, style: "normal", fill: inventor-text-muted, size: 0.85em)
        --- #author
      ]
    ]
  )
}

/// Multi-column layout helper for side-by-side comparisons
#let split(..bodies, columns: auto, gutter: 1.2em, align: top + left) = {
  let list = bodies.pos()
  let cols = if columns == auto { (1fr,) * list.len() } else { columns }
  grid(
    columns: cols,
    gutter: gutter,
    align: align,
    ..list.map(b => block(width: 100%, b))
  )
}

/// Rounded cute pill badge for tags, categories, or status
#let badge(label, fill: inventor-slate-light, color: inventor-petrol, radius: 100pt, icon: none) = context {
  let f = robotics-fonts-state.get()
  box(
    fill: fill,
    radius: radius,
    inset: (x: 0.65em, y: 0.25em),
    baseline: 0%,
    [
      #if icon != none [ #icon #h(0.2em) ]
      #text(font: f.accent, fill: color, size: 0.8em, weight: "bold")[#label]
    ]
  )
}

/// Stat / Metric / Hardware spec card
#let stat-card(value, label, subtext: none, color: inventor-teal, bg: inventor-surface) = context {
  let f = robotics-fonts-state.get()
  block(
    fill: bg,
    stroke: 1pt + inventor-slate-light,
    radius: 6pt,
    inset: (x: 1em, y: 0.8em),
    width: 100%,
    [
      #text(font: f.accent, fill: color, size: 1.8em, weight: "bold")[#value] \
      #v(-0.3em)
      #text(font: f.heading, fill: inventor-petrol, size: 0.9em, weight: "bold")[#label]
      #if subtext != none [
        \ #text(font: f.body, fill: inventor-text-muted, size: 0.75em)[#subtext]
      ]
    ]
  )
}

/// Numbered lab step
#let step(num, title: none, body) = context {
  let f = robotics-fonts-state.get()
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    align: (top + left, top + left),
    box(
      fill: inventor-petrol,
      radius: 100pt,
      inset: (x: 0.6em, y: 0.25em),
      text(font: f.accent, fill: white, size: 0.85em, weight: "bold")[#num]
    ),
    [
      #if title != none [
        #text(font: f.heading, weight: "bold", fill: inventor-petrol)[#title] \
      ]
      #set text(font: f.body, fill: inventor-text, size: 0.92em)
      #body
    ]
  )
  v(0.4em)
}

/// Speaker note for presenter mode (pdfpc)
#let note(text) = [
  #pdfpc.speaker-note(text)
]
