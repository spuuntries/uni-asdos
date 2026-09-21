# Robotics TA Presentation Template (Inventor Theme)

A clean & cute presentation template crafted for university **Robotics TAing & Practicum sessions**, themed after **LEGO Mindstorms Robot Inventor & Pybricks Hub** aesthetics, powered by [Touying](https://github.com/touying-typ/touying).

## ✨ Features

- **Robot Inventor Palette**: Deep petrol (`#0E2E3B`), bright mint/teal (`#00A896` / `#02C39A`), sunny yellow (`#FFB800`), coral pink (`#FF6584`), and soft mist background (`#F4F8F9`).
- **No External Logo Dependencies**: Replaced external HCS logos and dragon watermarks with self-contained vector components and a cute pure-Typst 5x5 LED Hub matrix display (`#hub-matrix`).
- **Hardware & Practicum Components**:
  - `#port-badge`: Pill badges for hardware ports (`#port-badge("Port.F", type: "motor")`, `#port-badge("Port.E", type: "sensor")`).
  - `#lab-box` / `#exercise-box`: Hands-on lab assignment callouts with duration, difficulty, port lists, and point rewards.
  - `#stat-card`: Hardware specification metrics (wheel diameter, gear ratio, baud rate, sensor thresholds).
  - `#hub-matrix`: Pure-Typst 5x5 LED matrix widget with presets (`smile`, `:3`, `heart`, `robot`, `arrow`, `check`).
  - `#cblock`: Colored card boxes (`hardware`, `info`, `tip`, `warning`, `danger`, `cute`).
  - `#step`: Numbered lab walkthrough steps.
  - `#split`: Multi-column layout helper.
  - `#note`: Speaker notes integrated with `pdfpc`.
- **Slide Layouts**:
  - `#title-slide`: Clean cover slide with tags, lab metadata, and cute Robot Inventor Hub illustration.
  - `#outline-slide`: Automated practicum syllabus / roadmap.
  - `#section-slide`: Module dividers with module number pills and clean technical dot grid.
  - `#focus-slide`: High-contrast deep petrol standout slide.
  - `#blank-slide`: Canvas for full-bleed circuit schematics or live terminal output.

## 🚀 Quickstart & Making New Presentations

Since this template is linked to your local Typst packages (`@local/robotics-presentation:0.1.0`), you can scaffold a new lab presentation anytime with one command:

```bash
typst init @local/robotics-presentation:0.1.0 prak-02
cd prak-02
typst watch slides.typ
```

Or manually in any `.typ` file:

```typ
#import "@local/robotics-presentation:0.1.0": *

#show: robotics-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  badge-label: [ROBOTICS 2026],
  config-info(
    title: [Autonomous Robotics & Sensor Integration],
    subtitle: [Lab 02: Advanced PID Control & Gyro Navigation],
    author: [TA Robotics Team],
    institution: [Robotics & Autonomous Systems Lab],
    date: [Fall 2026],
  ),
)

#title-slide(tags: ([Robotics], [Inventor Hub], [Pybricks], [Lab 02]))
#outline-slide()

= Hardware Setup & Hub Architecture

== Port Mapping & Safety Callout

Connect all peripheral cables to the designated hub ports:

#cblock(title: [Hardware Port Assignment], type: "hardware")[
  - #port-badge("Port.F", type: "motor") : Left Drive Motor
  - #port-badge("Port.E", type: "sensor") : Ground Color Sensor
]
```

## 🔨 Compile

```bash
typst compile slides.typ output.pdf
```
