/// Font configuration for Robotics Presentation Template
///
/// Provides coordinated typography presets across 4 roles:
/// - `heading`: Slide headers, section titles, card labels
/// - `body`: Explanations, bullet points, checklists
/// - `code`: Monospace syntax highlighting, inline python/pybricks
/// - `accent`: HUD badges, port pills, step counters, matrix indicators

#let default-font-presets = (
  cute: (
    heading: ("Century Gothic", "Segoe UI", "Arial"),
    body: ("Corbel", "Segoe UI", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Century Gothic", "Segoe UI", "Arial"),
  ),
  modern: (
    heading: ("Bahnschrift", "Segoe UI", "Arial"),
    body: ("Segoe UI", "Arial", "Helvetica"),
    code: ("Cascadia Code", "Cascadia Mono", "Consolas"),
    accent: ("Bahnschrift", "Segoe UI", "Arial"),
  ),
  tech: (
    heading: ("Bahnschrift", "Segoe UI", "Arial"),
    body: ("Segoe UI", "Helvetica", "Arial"),
    code: ("Cascadia Code", "Consolas"),
    accent: ("Bahnschrift", "Segoe UI"),
  ),
)

/// Configure presentation fonts with presets or custom families
#let config-fonts(
  style: "cute",
  body: auto,
  heading: auto,
  code: auto,
  accent: auto,
) = {
  let base = default-font-presets.at(style, default: default-font-presets.cute)
  (
    fonts: (
      heading: if heading != auto { heading } else { base.heading },
      body: if body != auto { body } else { base.body },
      code: if code != auto { code } else { base.code },
      accent: if accent != auto { accent } else { base.accent },
    )
  )
}

/// Global state storing active typography configuration
#let robotics-fonts-state = state("robotics-fonts", default-font-presets.cute)
