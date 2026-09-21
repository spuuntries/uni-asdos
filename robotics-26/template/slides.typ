#import "@local/robotics-presentation:0.1.0": *

#show: robotics-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  progress-bar: true,
  font-style: "cute",
  badge-label: [ROBOTICS 2026],
  config-info(
    title: [Autonomous Robotics & Sensor Integration],
    subtitle: [Lab 01: Line Following, Sensors & Pybricks State Machines],
    author: [TA Robotics Team],
    institution: [Robotics & Autonomous Systems Lab],
    date: [Fall 2026],
  ),
)

// --- Cover Slide ---
#title-slide(
  tags: ([Robotics], [Inventor Hub], [Pybricks], [Lab 01]),
  matrix: "smile",
)

// --- Lab Roadmap ---
#outline-slide()

// ==========================================
= Hardware Setup & Hub Architecture
// ==========================================

== Inventor Hub & Port Configuration

The Robot Inventor Hub orchestrates all sensors and actuators via high-speed UART ports:

- *DriveBase Actuators*: Dual medium angular motors configured with counter-rotation.
- *Active Perception*: Color sensor oriented down for line detection; ultrasonic sensor forward.
- *Real-time MicroPython*: Running baremetal Pybricks firmware for deterministic timing.

#v(0.4em)

#split[
  #stat-card("56 mm", "Wheel Diameter", subtext: [Standard Inventor rubber wheels], color: inventor-teal)
][
  #stat-card("112 mm", "Axle Track", subtext: [Distance between drive wheels], color: inventor-petrol)
][
  #stat-card("200 mm/s", "Max Velocity", subtext: [Recommended cruising speed], color: inventor-yellow-dark)
]

#note("Remind students to measure their wheel diameter carefully if they modified the chassis!")

== Port Mapping & Safety Callout

Connect all peripheral cables to the designated hub ports before powering on:

#split[
  #cblock(title: [Hardware Port Assignment], type: "hardware")[
    - #port-badge("Port.F", type: "motor") : Left Drive Motor
    - #port-badge("Port.B", type: "motor") : Right Drive Motor
    - #port-badge("Port.E", type: "sensor") : Ground Color Sensor
    - #port-badge("Port.A", type: "sensor") : Ultrasonic Rangefinder
    - #port-badge("Port.C", type: "motor") : Pitch Scanner Motor
    - #port-badge("Port.D", type: "motor") : Yaw Scanner Motor
  ]
][
  #cblock(title: [Safety & Motor Limits], type: "warning")[
    - Never force motors past physical stops while powered on.
    - Set soft software limits:
      - Yaw limits: `-115°` to `-55°`
      - Pitch limits: `-25°` to `25°`
    - Keep battery level above $20%$ to prevent sudden hub reboot.
  ]
]

// ==========================================
= State Machine & Line Tracking
// ==========================================

== Line Tracking Architecture

A reactive line tracker transitions across distinct operational states:

#split[
  #cblock(title: [Follow State], type: "tip")[
    - Increments ($50 upright(m m)$).
    - Checks sensor at $80 upright(m s)$.
    - Line lost $arrow.r$ *Backtrack*.
  ]
][
  #cblock(title: [Backtrack State], type: "info")[
    - Reverses move history.
    - Inverts straight / turn.
    - Recovers last known line.
  ]
][
  #cblock(title: [Scan State], type: "cute")[
    - Sweeps yaw motor.
    - Records angles seen.
    - Steers toward peak.
  ]
]

#v(0.1em)

#quote-block(
  [In robotics, open-loop assumptions fail. Always verify sensory feedback before advancing.],
  author: [Autonomous Systems Handbook],
)

== Pybricks Implementation

#text(size: 0.74em)[
  ```python
  from pybricks.hubs import InventorHub
  from pybricks.pupdevices import Motor, ColorSensor
  from pybricks.parameters import Port, Color, Direction
  from pybricks.robotics import DriveBase

  hub = InventorHub()
  left_m = Motor(Port.F, Direction.COUNTERCLOCKWISE)
  right_m = Motor(Port.B)
  sensor = ColorSensor(Port.E)
  robot = DriveBase(left_m, right_m, wheel_diameter=56, axle_track=112)

  while True:
      robot.drive(150, 0) if sensor.color() == Color.GREEN else robot.stop()
  ```
]

// ==========================================
= Hands-on Practicum Task
// ==========================================

== Lab Assignment 01

#lab-box(
  title: [Task 1: Line Following & Lost Recovery],
  time: "30 min",
  difficulty: "Hands-on",
  ports: ("Port.F", "Port.B", "Port.E"),
  points: "100",
)[
  Implement and test the autonomous navigation routine in your robot:

  #step("1", title: [Initialize DriveBase & Invert Left Motor])[
    Ensure the left motor uses `Direction.COUNTERCLOCKWISE` so straight motion drives forward.
  ]

  #step("2", title: [Calibrate Color Sensor Thresholds])[
    Print raw RGB and ambient reflection values on both the white floor and the green track line.
  ]

  #step("3", title: [Implement Backtracking Deque])[
    Maintain a history of the last 20 actions using `ucollections.deque(maxlen=20)`.
  ]
]

// --- Dark Standout Focus Slide ---
#focus-slide(title: [Checkpoint & Demonstration Area], matrix: "robot")[
  Once your robot completes 2 consecutive laps without manual intervention, signal a TA for scoring.

  #v(0.5em)
  #text(size: 0.75em, fill: inventor-teal-bright)[
    Submit your code to the lab repository before 17:00 WIB!
  ]
]

== Evaluation Rubric & Wrap-up

#split[
  #cblock(title: [Scoring Criteria], type: "info")[
    - Smooth line tracking: *40 pts*
    - Lost state recovery: *30 pts*
    - Clean code & comments: *20 pts*
    - Lab cleanup: *10 pts*
  ]
][
  #cblock(title: [Common Troubleshooting], type: "tip")[
    - *Robot spins in circles*: Check motor port orientation and direction flag.
    - *Sensor misses line*: Adjust sensor height to $8-12 upright(m m)$ above ground.
    - *Bluetooth disconnects*: Re-pair using the central connect button.
  ]
]
