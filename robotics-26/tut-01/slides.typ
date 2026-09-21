#import "@local/robotics-presentation:0.1.0": *
#import "@preview/fletcher:0.5.6" as fletcher: diagram, edge, node

#show: robotics-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  progress-bar: true,
  font-style: "cute",
  badge-label: [ROBOTIKA (N)],
  config-info(
    title: [Lego MINSTORMS Inventor],
    subtitle: [Basics: Setup, Patterns, and Resources.],
    author: [Robotika RKA],
    institution: [Tutorial \#1],
    date: [21 September 2026],
  ),
)

// --- Cover Slide ---
#title-slide(
  tags: ([51515], [Inventor], [Pybricks]),
  matrix: "smile",
)

= Hardware Setup

== Inventor Hub

Inventor Hub adalah komponen utama yang memuat orkestrasi dari semua sensor dan aktuator pada sebuah robot LEGO Inventor.

Bentukannya kurang-lebih begini:

#grid(
  columns: (auto, 1fr),
  gutter: 1.5em,
  image("media/pybricks-docs/hub-inventor.png", height: 65%),
  [Di sini itu yang lubang samping-sampingnya itu UART port, dari A ke F. Untuk power input  menggunakan microUSB, dan koneksi ke laptop dengan bluetooth.

    Di tengah itu tombol power/execution, terus di pojok kanan-atas itu bluetooth.],
)

== What's Pybricks?

Inventor Hub ini itu seperti komputer kecil. Di dalamnya ada firmware, sama seperti laptop punya sistem operasi (_but lower level, "technically"_). Firmware bawaan LEGO hanya mau bekerja dengan aplikasi ekosistem LEGO, dan ada beberapa kekurangan juga dari firmware bawaan ini: kurang bisa di-_tweaking_ dan ada latensi-latensi yang diakibatkan _bloat_.

#grid(
  columns: (1fr, auto),
  gutter: 1.5em,
  [Oleh karena itu, pada Hub yang kita akan gunakan, kita ganti firmware ini dengan firmware open-source PyBricks yang memiliki API lebih konsisten, lebih performan, dan lebih _maintained_.

    #text(size: .6em)[(serta literally tidak discontinued minggu depan lmao 💀)]],
  image("media/lego-discontinued.png", height: 60%),
)

#let ok-tag = box(fill: rgb("#ECFDF5"), inset: (x: 5pt, y: 2pt), radius: 3pt, text(
  size: 0.75em,
  weight: "bold",
  fill: rgb("#047857"),
)[bisa])
#let no-tag = box(fill: rgb("#FEF2F2"), inset: (x: 5pt, y: 2pt), radius: 3pt, text(
  size: 0.75em,
  weight: "bold",
  fill: rgb("#DC2626"),
)[tidak])
#let none-tag = box(fill: rgb("#F1F5F9"), inset: (x: 5pt, y: 2pt), radius: 3pt, text(
  size: 0.75em,
  weight: "bold",
  fill: rgb("#64748B"),
)[N/A])

== Compatibilities

Intendednya sih kita pake Pybricks Code (#link("https://code.pybricks.com", [https://code.pybricks.com])), yang menggunakan web bluetooth. Jadi ada beberapa yang perlu diperhatikan untuk kompatibilitas di:


#split(columns: (1.25fr, 1fr), gutter: 1.2em)[
  #text(size: 0.78em)[
    #table(
      columns: (1.3fr, 1fr, 1fr, 1fr, 1fr, 1.3fr),
      inset: (x: 5pt, y: 5.5pt),
      align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Browser*], [*Win*], [*macOS*], [*Linux*], [*Chrome \ OS*], [*iOS / iPad*]),
      [*Chrome*], ok-tag, ok-tag, ok-tag, ok-tag, no-tag,
      [*Edge*], ok-tag, ok-tag, ok-tag, ok-tag, no-tag,
      [*Chromium*], ok-tag, ok-tag, ok-tag, ok-tag, no-tag,
      [*Brave*], no-tag, no-tag, no-tag, no-tag, no-tag,
      [*Safari*], none-tag, no-tag, none-tag, none-tag, no-tag,
      [*Firefox*], no-tag, no-tag, no-tag, no-tag, no-tag,
    )
  ]
][
  #cblock(title: [Catatan Penting], type: "warning")[
    #text(size: 0.8em)[
      - *Brave* memblokir Web Bluetooth by default via Shields (tidak bisa).
      - *Firefox* tidak mendukung Bluetooth di platform mana pun.
      - *iPad & iPhone* diblokir Apple untuk semua browser.
      - Gunakan *Chromium-based* (kecuali brave 💀) kalau ingin menggunakan Pybricks Code.
    ]
  ]
]

Sebagai alternatif lain, ada juga pakai #link("https://github.com/afarago/blocklypy-vscode", [BlockLyPy]) kalau mau dari VSCode langsung.

== Setup Hub




#grid(
  columns: (1fr, auto),
  gutter: .5em,
  [Nyalakan hub dengan menekan tombol tengah, nanti lampunya di sekeliling tombol juga akan nyala. Di tombol bluetooth juga bakal kedip-kedip.
  ],
  image("media/pybricks-docs/primehub_light.png", height: 20%),
)

dari sini, pencet tombol ini di PyBricks code, terus nanti pilih device-nya untuk connect.

#v(-.5em)
#grid(
  columns: (auto, auto),
  gutter: 1em,
  image("/assets/image-1.png", height: 40%), image("/assets/image-2.png", height: 40%),
)

#v(-.5em)

Kalau berhasil connect, nanti tombol bluetooth akan menyala terus. Kalo salah koneksi dengan device lain, pencet tombol power lama untuk restart lalu reconnect.

= Hello World

== First program

Buka tab file, klik ikon `+`, pilih Python, beri nama program, lalu klik Create.

#v(-.5em)
#grid(
  columns: (auto, auto),
  gutter: 1em,
  image("/assets/image-3.png", height: 40%), image("/assets/image-4.png", height: 40%),
)

#v(-.8em)
Nanti muncul seperti ini:
#v(-.5em)
#image("/assets/image-6.png")

#pagebreak()

Isi dengan ini:

```python
from pybricks.hubs import InventorHub
from pybricks.tools import wait

hub = InventorHub()

print("hub siap")
hub.speaker.beep()
wait(1000)
print("baterai:", hub.battery.voltage(), "mV")
```

#pagebreak()

Klik tombol play. Hub akan berbunyi, dan teks muncul di panel output di bawah editor.

Kalau kedua hal itu terjadi, instalasi berhasil. 🎉

Selain yang python, Pybricks Code juga ada block-based interface, bisa juga sebagai alternatif, sesuai preferensi saja.

#grid(
  columns: (auto, auto),
  gutter: .5em,
  image("/assets/image-9.png", height: 55%),
  text(size: .9em)[
    Setelah dijalankan dari aplikasi, programnya akan tersimpan di Hub-nya. Untuk menjalankan kembali, bisa dipencet tombol tengah, nanti akan berjalan lagi.

    Hub Inventor punya lima program slot. Tombol yang kiri dan kanan untuk memilih slot, angka slot muncul di layar 5x5. Program yang kalian jalankan dari aplikasi akan tersimpan di slot yang sedang terpilih.
  ],
)
= Pybricks Basics

== Anatomi Hub

#split(columns: (1.25fr, 1fr), gutter: 1.2em)[
  #text(size: 0.7em)[
    #table(
      columns: (1fr, 1fr, 1fr),
      inset: (x: 5pt, y: 6pt),
      align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Bagian*], [*Jumlah*], [*Keterangan*]),
      [*Port Sensor/Motor*], [6, dari A sampai F], [Bebas dipakai untuk motor maupun sensor.],
      [*Layar*], [25 lampu, susunan 5x5], [Untuk menampilkan angka, huruf, dan ikon],
      [*Tombol*], [4], [Kiri, kanan, tengah, dan Bluetooth],
      [*IMU*], [1], [Mengukur kemiringan dan putaran],
      [*Speaker*], [1], [Nada dan bunyi],
    )
  ]
][
  #align(horizon, grid(
    columns: (auto, auto),
    image("media/pybricks-docs/primehub_buttons.png", height: 50%),
    image("media/pybricks-docs/primehub_buttons.png", height: 50%),
  ))
]

== Motors

=== Basics

Motor dihubungkan ke port (misal `Port.A`). Perintah gerak menentukan apakah baris berikutnya menunggu (*blocking*) atau langsung lanjut:

#v(0.2em)

#split(columns: (1.25fr, 1fr), gutter: 1.2em)[
  #text(size: 0.72em)[
    #table(
      columns: (1.4fr, 1fr, 1fr),
      inset: (x: 5pt, y: 5.5pt),
      align: (left + horizon, center + horizon, center + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Perintah*], [*Satuan*], [*Blocking?*]),
      [`motor.run(speed)`], [deg/s], badge("Tidak", fill: rgb("#FEF2F2"), color: rgb("#DC2626")),
      [`motor.run_time(...)`], [deg/s, ms], badge("Ya", fill: rgb("#ECFDF5"), color: rgb("#047857")),
      [`motor.run_angle(...)`], [deg/s, deg], badge("Ya", fill: rgb("#ECFDF5"), color: rgb("#047857")),
      [`motor.run_target(...)`], [deg/s, deg], badge("Ya", fill: rgb("#ECFDF5"), color: rgb("#047857")),
      [`motor.dc(duty)`], [% tegangan], badge("Tidak", fill: rgb("#FEF2F2"), color: rgb("#DC2626")),
    )
  ]
][
  #text(size: 0.78em)[
    ```python
    from pybricks.pupdevices import Motor
    from pybricks.parameters import Port

    motor = Motor(Port.A)
    ```
  ]

  #v(.5em)
  #cblock(title: [Catatan Eksekusi], type: "info")[
    #text(size: 0.75em)[
      Perintah dengan satuan waktu/sudut otomatis menahan eksekusi kode sampai motor selesai bergerak.
    ]
  ]
]

=== Blocking vs Non-Blocking

Pembeda paling krusial adalah bahwa baris berikutnya menunggu putaran selesai atau langsung lanjut saat motor masih jalan.

#v(-0.5em)

#split(columns: (1.15fr, 1fr), gutter: 1.2em)[
  #text(size: 0.75em)[
    ```python
    motor = Motor(Port.A)

    # 1. Menunggu sampai selesai 360°
    motor.run_angle(500, 360)
    print("putaran pertama selesai")

    # 2. Langsung lanjut ke baris bawahnya!
    motor.run(500)
    print("ini muncul saat motor jalan")
    wait(2000)
    motor.stop()
    ```
  ]
][
  #cblock(title: [run_angle vs run_target], type: "warning")[
    #text(size: 0.74em)[
      - *`run_angle(speed, angle)`*: \
        Berputar sejauh sudut dihitung dari *posisi sekarang* (relatif).
      - *`run_target(speed, target)`*: \
        Berputar menuju sudut tertentu dihitung dari *titik nol* (absolut).

      _Keduanya sering tertukar dan efeknya berbeda jauh._
    ]
  ]
]

=== Stopping

Ada 3 cara berhenti:

#split(columns: (1.35fr, 1fr), gutter: 1.2em)[
  #text(size: 0.70em)[
    #table(
      columns: (1.1fr, 1.4fr, 1.2fr),
      inset: (x: 5pt, y: 5.5pt),
      align: (left + horizon, left + horizon, left + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Perintah*], [*Yang Terjadi*], [*When to Use*]),
      [`motor.stop()`], [Listrik dilepas, berputar bebas sampai pelan sendiri], [Gerakan bebas, boleh meluncur],
      [`motor.brake()`], [Motor menahan pasif (hubung singkat coil)], [Berhenti cepat tanpa presisi],
      [`motor.hold()`], [Motor aktif menahan posisi terakhir], [Lengan yang harus tetap terangkat],
    )
  ]
][
  #cblock(title: [Lengan Robot Jatuh Sendiri?], type: "danger")[
    #text(size: 0.74em)[
      Kalau lengan robot lemas setelah program selesai, itu karena berhenti dengan `stop()`, gunakan `hold()`.
    ]
  ]



  #text(size: 0.76em)[
    #v(.2em)
    `run_angle` dkk. punya argumen `then`:
    #v(-.4em)
    ```python
    from pybricks.parameters import Stop

    # Bawaannya adalah Stop.HOLD
    motor.run_angle(500, 90, then=Stop.HOLD)
    ```
  ]
]

== Encoder (Sensor Sudut)

Setiap motor Powered Up punya sensor sudut (*encoder*) di dalamnya. Motor tidak pernah lupa posisinya selama hub menyala.

#v(0.2em)

#split(columns: (1.15fr, 1fr), gutter: 1.2em)[
  #text(size: 0.74em)[
    ```python
    motor = Motor(Port.A)
    motor.reset_angle(0)

    motor.run(300)
    wait(3000)
    motor.stop()

    print("sudut:", motor.angle(), "derajat")
    print("kecepatan:", motor.speed(), "deg/s")
    ```
  ]
][
  #cblock(title: [Coba :0], type: "info")[
    #text(size: 0.75em)[
      Jalankan kode, lalu coba putar poros motor dengan tangan dan jalankan lagi.
    ]
  ]

  #cblock(title: [Dasar Odometri], type: "warning")[
    #text(size: 0.75em)[
      Inilah yang dapat dipakai robot untuk _memperkirakan_ sudah berjalan sejauh apa.
    ]
  ]
]

== Arah Putaran Motor

Setiap jenis motor punya arah positif bawaan (panah biru). Dua motor yang dipasang berhadapan di kiri dan kanan robot akan berputar ke arah berlawanan saat diberi perintah yang sama dan *harus dibalik salah satunya*:

#v(-0.5em)

#split(columns: (1.15fr, 1fr), gutter: 1.2em)[
  #align(center + horizon)[
    #image("media/pybricks-docs/pupmotors.png", width: 95%)
  ]
][
  #text(size: 0.75em)[
    ```python
    from pybricks.parameters import Direction

    # Balik arah motor kiri/kanan
    left = Motor(Port.A, Direction.COUNTERCLOCKWISE)
    right = Motor(Port.B, Direction.CLOCKWISE)
    ```
  ]

  #cblock(title: [Robot Muter di Tempat?], type: "danger")[
    #text(size: 0.74em)[
      Kalau robot disuruh maju lurus tapi malah berputar di tempat, artinya arah putaran salah satu motor belum dibalik.
    ]
  ]
]

== Deteksi Macet

Motor tahu kalau dirinya ditahan/tertahan.

```python
motor.run_until_stalled(300, duty_limit=40)
motor.reset_angle(0)
```

Ini cara umum mencari titik nol sebuah lengan atau capit. Suruh motor bergerak sampai membentur pembatas mekanis, lalu tetapkan posisi itu sebagai sudut nol. Argumen `duty_limit` membatasi tenaga supaya benturannya tidak merusak gigi.

== Susunan Roda Gigi (Gears)

Untuk motor yang tersambung ke roda lewat gigi, sebutkan susunan giginya supaya perhitungan sudut tetap benar:

```python
motor = Motor(Port.A, gears=[12, 36])
```

Angka itu jumlah gigi, dari gigi yang menempel di motor sampai gigi yang menempel di roda.


== DriveBase

Menggerakkan dua motor secara manual untuk jalan lurus sangat merepotkan. `DriveBase` mengontrol kedua motor sekaligus dalam satuan *milimeter* dan *derajat*.

#v(0.2em)

#split(columns: (1.25fr, 1fr), gutter: 1.2em)[
  #text(size: 0.70em)[
    ```python
    from pybricks.pupdevices import Motor
    from pybricks.parameters import Port, Direction
    from pybricks.robotics import DriveBase

    left = Motor(Port.A, Direction.COUNTERCLOCKWISE)
    right = Motor(Port.B, Direction.CLOCKWISE)
    robot = DriveBase(left, right, wheel_diameter=56, axle_track=114)

    robot.straight(300)   # maju 300 mm
    robot.turn(90)        # putar 90° kanan (CW)
    robot.straight(-300)  # mundur 300 mm
    robot.turn(-90)       # putar 90° kiri (CCW)
    ```
  ]
][
  #cblock(title: [Konvensi Arah & Sudut], type: "info")[
    #text(size: 0.74em)[
      - *Positif ($+$)*: Maju, atau berputar searah jarum jam (*CW / kanan*).
      - *Negatif ($-$)*: Mundur, atau berputar berlawanan jarum jam (*CCW / kiri*).
    ]
  ]

  #cblock(title: [Parameter], type: "accent")[
    #text(size: 0.76em)[
      - `wheel_diameter`: Diameter roda fisik (mm).
      - `axle_track`: Jarak titik tengah kedua roda (mm).
    ]
  ]
]

== Perintah Lengkap DriveBase

#v(-0.3em)
Metode bawaan `DriveBase` untuk navigasi robot:

#v(-0.3em)

#align(center)[
  #text(size: 0.72em)[
    #table(
      columns: (1.7fr, 1.1fr, 2.2fr),
      inset: (x: 6pt, y: 5pt),
      align: (left + horizon, center + horizon, left + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Perintah*], [*Satuan*], [*Keterangan*]),
      [`robot.straight(distance)`], [mm], [Maju ($+$) / mundur ($-$), program menunggu],
      [`robot.turn(angle)`], [deg], [Berputar di tempat ($+$ kanan, $-$ kiri), menunggu],
      [`robot.arc(radius, angle)`], [mm & deg], [Menikung dengan radius tertentu, menunggu],
      [`robot.drive(speed, turn_rate)`], [mm/s & deg/s], [Jalan terus tanpa henti, langsung lanjut],
      [`robot.stop()`], [--], [Menghentikan pergerakan motor],
      [`robot.distance()`], [mm], [Total jarak tempuh menurut encoder roda],
      [`robot.angle()`], [deg], [Sudut hadap robot menurut odometri],
      [`robot.reset()`], [--], [Kembalikan hitungan jarak & sudut ke nol],
    )
  ]
]

// #v(-.2em)

#cblock(title: [How to Calculate], type: "warning")[#text(
  size: .75em,
)[Untuk roda LEGO, diameter sering tercetak di sisi ban. Tulisan `62.4 x 20` berarti diameternya 62.4 mm dan lebarnya 20 mm. Untuk mengukur `axle_track`, jarak antar lubang di balok Technic adalah 8 mm, jadi kalian bisa menghitungnya dari jumlah lubang.]]

== Prosedur Kalibrasi DriveBase

Pengukurannya hampir tidak pernah pas karena ban tertekan bobot robot (diameter efektif mengecil), sehingga axel sedikit melengkung di bawah beban. Kalibrasinya harus dilakukan secara berurutan:

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #block(stroke: 1.2pt + inventor-teal, radius: 7pt, fill: white, inset: (x: 8pt, y: 7pt), width: 100%)[
      #box(fill: inventor-teal.lighten(80%), inset: (x: 6pt, y: 2pt), radius: 3pt)[
        #text(weight: "bold", size: 0.82em, fill: inventor-petrol)[1. Setel wheel_diameter]
      ]

      #text(size: 0.74em)[
        Jalankan `robot.straight(1000)`, ukur dengan meteran:
        - *Kurang dari 1000 mm* $arrow.r$ *Kecilkan* `wheel_diameter`
        - *Lebih dari 1000 mm* $arrow.r$ *Besarkan* `wheel_diameter`
      ]
    ]
  ],
  [
    #block(stroke: 1.2pt + inventor-teal, radius: 7pt, fill: white, inset: (x: 8pt, y: 7pt), width: 100%)[
      #box(fill: inventor-teal.lighten(80%), inset: (x: 6pt, y: 2pt), radius: 3pt)[
        #text(weight: "bold", size: 0.82em, fill: inventor-petrol)[2. Setel axle_track]
      ]

      #text(size: 0.74em)[
        Setelah diameter pas, jalankan `robot.turn(360)`:
        - *Kurang berputar* $arrow.r$ *Besarkan* `axle_track`
        - *Kelewat berputar* $arrow.r$ *Kecilkan* `axle_track`
      ]
    ]
  ],
)

#split(columns: (1fr, 1.2fr), gutter: 10pt)[
  #cblock(title: [Berurutan], type: "warning")[
    #text(size: 0.74em)[
      *Wajib diameter roda lebih dulu*, karena kalkulasi sudut belok robot ikut mengandalkan nilai diameter roda.
    ]
  ]
][
  #cblock(title: [Sifat Permukaan Lantai], type: "danger")[
    #text(size: 0.74em)[
      Kalibrasi di *keramik* akan meleset di *karpet*. Nilai kalibrasi tergantung robot + permukaannya.
    ]
  ]
]


== Sensors

Set 51515 berisi satu Ultrasonic Sensor dan satu Color Sensor.

#grid(
  columns: (auto, auto, auto),
  gutter: 1em,
  image("media/pybricks-docs/sensor_ultrasonic_lights.png"),
  line(angle: 90deg, length: 50%),
  image("media/pybricks-docs/sensor_color_lights.png"),
)

Kedua sensor ini bisa digunakan untuk mengukur jarak dan menentukan warna yang diobservasi oleh robot.

== Ultrasonic Sensor

Fungsi dari ultrasonic sensor adalah mengukur jarak ke benda di depannya dengan gelombang suara.

#v(-.5em)

#align(center, image("media/pybricks-docs/sensor_ultrasonic_lights.png", height: 40%))

Di sini, nomor pada gambar kanan adalah urutan lampu. Satu angka menyalakan keempatnya sekaligus, `sensor.lights.on(100)`, dengan   empat angka untuk mengatur masing-masing, `sensor.lights.on([100, 100, 0, 0])` (dengan asumsi variabel sensor di-set jadi `sensor`).

```python
from pybricks.pupdevices import UltrasonicSensor
from pybricks.parameters import Port
from pybricks.tools import wait

eyes = UltrasonicSensor(Port.C)

while True:
    print(eyes.distance(), "mm")
    wait(200)
```

=== Ultrasonic Methods:

#align(center)[
  #text(size: 0.78em)[
    #table(
      columns: (1.5fr, 2fr),
      inset: (x: 8pt, y: 6pt),
      align: (left + horizon, left + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Perintah*], [*Hasil*]),
      [`eyes.distance()`], [Jarak dalam mm],
      [`eyes.presence()`], [`True` kalau ada sensor ultrasonic lain di dekatnya],
      [`eyes.lights.on(brightness)`], [Menyalakan empat lampu di sensor],
    )
  ]
]

=== Ultrasonic Notes:

Ketika kalian uji, sensor ini punya beberapa perilaku yang perlu kalian ketahui sebelum mengira kodenya salah: Permukaan yang miring memantulkan suara menjauh, jadi dinding yang menyudut sering terbaca lebih jauh dari kenyataannya atau tidak terbaca sama sekali. Kain dan busa menyerap suara. Benda yang terlalu dekat, di bawah beberapa sentimeter, juga tidak terbaca dengan benar.

== Color Sensor

Berfungsi untuk membaca warna dan tingkat pantulan permukaan di bawahnya.

#align(center, image("media/pybricks-docs/sensor_color_lights.png", height: 40%))

Sama seperti sebelumnya, sensor ini juga punya lampu-lampu sebagaimana teranotasi di gambar kanan, dengan `sensor.lights.on([100, 0, 0])` bisa kalian mati-nyalakan satu-satu.

#pagebreak()

```python
from pybricks.pupdevices import ColorSensor
from pybricks.parameters import Port, Color
from pybricks.tools import wait

sensor = ColorSensor(Port.D)

while True:
    print(sensor.color(), sensor.reflection())
    wait(200)
```

#v(-.5em)

=== Color Methods
#v(-.5em)

#align(center)[
  #text(size: 0.78em)[
    #table(
      columns: (1.3fr, 2fr),
      inset: (x: 8pt, y: 6pt),
      align: (left + horizon, left + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Perintah*], [*Hasil*]),
      [`sensor.color()`], [Salah satu nilai `Color`, misal `Color.RED`],
      [`sensor.reflection()`], [Persentase pantulan, 0 sampai 100],
      [`sensor.ambient()`], [Persentase cahaya sekitar, 0 sampai 100],
      [`sensor.hsv()`], [Nilai hue, saturation, dan value mentah],
    )
  ]
]

#v(-.5em)

=== Color Notes

Untuk mengikuti garis, `reflection()` lebih berguna daripada `color()` karena hasilnya berupa angka yang bisa diukur, bukan kategori.

#v(-.5em)

Jarak sensor ke lantai sangat berpengaruh. Beda dua milimeter sudah mengubah angka pantulan. Pasang sensor sedekat mungkin ke lantai dan jangan diubah-ubah setelah kalian mengukur nilai acuan.

== Hub Buttons

Rancangan StarterBot resmi memakai tombol kiri dan kanan hub sebagai bumper mekanis. Batang LEGO menempel ke tombol, dan saat robot menabrak sesuatu, batang itu menekan tombol.

#align(center, image("/assets/image-8.png", height: 60%))

Ini berguna karena Ultrasonic Sensor punya sudut pandang relatif sempit. Benda tipis seperti kaki meja sering lolos dari deteksi, dan bumper bisa digunakan untuk menangkapnya.

#v(-.5em)

#text(size: .74em)[
  ```python
  from pybricks.hubs import InventorHub
  from pybricks.parameters import Button
  from pybricks.tools import wait

  hub = InventorHub()

  while True:
      pressed = hub.buttons.pressed()
      if Button.LEFT in pressed:
          print("tabrakan di kiri")
      if Button.RIGHT in pressed:
          print("tabrakan di kanan")
  ```]

== Timings


```python
from pybricks.tools import wait, StopWatch

wait(1000)                    # berhenti 1000 ms

timer = StopWatch()
robot.straight(500)
print("butuh", timer.time(), "ms")
```

`StopWatch` mulai menghitung begitu dibuat. Metodenya `time()`, `pause()`, `resume()`, dan `reset()`.

== Loops

Sampai sini kalian menyuruh robot melakukan gerakan yang sudah ditentukan. Sekarang robot yang menentukan gerakannya sendiri berdasarkan pembacaan sensor.

Bentuknya selalu sama, apa pun sensornya:

#align(center)[
  #diagram(
    node-stroke: 1.2pt + inventor-teal,
    node-fill: inventor-bg-tint,
    node-corner-radius: 5pt,
    node-inset: 8pt,
    spacing: (8mm, 10mm),
    edge-stroke: 1.2pt + inventor-petrol,
    node((0, 0), text(size: 0.72em, weight: "bold")[Baca sensor]),
    edge((0, 0), (1, 0), "-|>"),
    node((1, 0), text(size: 0.72em, weight: "bold")[Bandingkan dengan\ nilai acuan]),
    edge((1, 0), (2, 0), "-|>"),
    node((2, 0), text(size: 0.72em, weight: "bold")[Hitung koreksi]),
    edge((2, 0), (3, 0), "-|>"),
    node((3, 0), text(size: 0.72em, weight: "bold")[Kirim perintah\ ke motor]),
    edge((3, 0), (4, 0), "-|>"),
    node((4, 0), text(size: 0.72em, weight: "bold")[Tunggu sebentar]),
    edge((4, 0), (4, 0.9), (0, 0.9), (0, 0), "-|>", corner-radius: 5pt),
  )
]

Robot tidak pernah tahu posisinya yang sebenarnya. Yang dia tahu cuma selisih antara pembacaan sensor sekarang dan nilai yang dia inginkan, dan dia bergerak untuk mengecilkan selisih itu.

#pagebreak()

=== Stop Before Crash

Berikut contoh kode yang berhenti sebelum menabrak permukaan:

#text(size: .74em)[
  ```python
  from pybricks.pupdevices import Motor, UltrasonicSensor
  from pybricks.parameters import Port, Direction
  from pybricks.robotics import DriveBase
  from pybricks.tools import wait

  left = Motor(Port.A, Direction.COUNTERCLOCKWISE)
  right = Motor(Port.B, Direction.CLOCKWISE)
  eyes = UltrasonicSensor(Port.C)

  robot = DriveBase(left, right, wheel_diameter=56, axle_track=114)

  robot.drive(150, 0)

  while eyes.distance() > 200:
      wait(10)

  robot.stop()
  print("berhenti pada jarak", eyes.distance(), "mm")
  ```
]

Ini harus kalian jalankan beberapa kali dan catat angka terakhirnya, karena angkanya tidak akan sama persis, dan tidak akan tepat 200 mm. Robot butuh waktu untuk membaca sensor, dan setelah `stop()` dipanggil robot masih meluncur sedikit.

#pagebreak()

=== Mengikuti garis

Contoh #link("https://en.wikipedia.org/wiki/PID_controller", [_proportional control_]), cara paling sederhana membuat robot mengoreksi diri sendiri.

#text(size: .74em)[
  ```python
  from pybricks.pupdevices import Motor, ColorSensor
  from pybricks.parameters import Port, Direction
  from pybricks.robotics import DriveBase
  from pybricks.tools import wait

  left = Motor(Port.A, Direction.COUNTERCLOCKWISE)
  right = Motor(Port.B, Direction.CLOCKWISE)
  sensor = ColorSensor(Port.D)

  robot = DriveBase(left, right, wheel_diameter=56, axle_track=114)

  BLACK = 9
  WHITE = 85
  threshold = (BLACK + WHITE) / 2

  DRIVE_SPEED = 100
  GAIN = 1.2

  while True:
      deviation = sensor.reflection() - threshold
      turn_rate = GAIN * deviation
      robot.drive(DRIVE_SPEED, turn_rate)
      wait(10)
  ```
]

Robot tidak mengikuti tengah garis. Robot mengikuti tepi garis, tempat pantulan bernilai di antara hitam dan putih.

#align(center)[
  #text(size: 0.76em)[
    #table(
      columns: (1.3fr, 1fr, 1.1fr, 1.8fr),
      inset: (x: 8pt, y: 6pt),
      align: (left + horizon, center + horizon, center + horizon, left + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Posisi Sensor*], [*Pantulan*], [*`deviation`*], [*Yang Dilakukan Robot*]),
      [Terlalu ke putih], [mendekati 85], [positif], [Membelok ke arah garis],
      [Pas di tepi garis], [sekitar 47], [mendekati nol], [Jalan lurus],
      [Terlalu ke hitam], [mendekati 9], [negatif], [Membelok menjauh dari garis],
    )
  ]
]

Nilai `BLACK` dan `WHITE` harus kalian ukur sendiri dengan program di 9.2, di lintasan yang akan dipakai, dengan pencahayaan ruangan saat itu. Angka 9 dan 85 di atas cuma titik awal.

`GAIN` menentukan seberapa keras robot mengoreksi. Terlalu kecil, robot memotong tikungan dan lepas dari garis. Terlalu besar, robot berkelok-kelok tajam dan bisa terlempar keluar. Naikkan sedikit demi sedikit sampai robot mengikuti garis dengan goyangan yang masih wajar, lalu berhenti di situ.

Ini bagian yang tidak bisa dihitung di atas kertas. Nilai yang benar bergantung pada berat robot, jenis ban, kecepatan, dan permukaan lintasan.

#focus-slide(title: [#v(-1.5em)Penugasan], matrix: "sad")[
  #v(-2em)
  #image("/assets/image-10.png", height: 40%)
  #text(
    size: .75em,
  )[Buat sebuah robot maze solver. Tiap tim akan mendemokan hasil masing-masing #text(weight: "bold")[minggu depan].
    #v(-.45em)
    Tidak terdapat restriksi pada metode maupun desain dari robot, tetapi dipastikan bahwa masing-masing anggota kelompok memahami dan dapat menjelaskan mekanisme yang diterapkan pada robot.]
]

== Additional Materials

Dokumentasi API lengkap ada di #link("https://docs.pybricks.com", [`https://docs.pybricks.com`]). Halaman yang paling sering kalian buka:

#align(center)[
  #text(size: 0.74em)[
    #table(
      columns: (1.8fr, 1.5fr),
      inset: (x: 8pt, y: 5pt),
      align: (left + horizon, left + horizon),
      stroke: (x, y) => if y == 0 { (bottom: 1.5pt + inventor-teal) } else { 0.5pt + inventor-slate-light },
      fill: (col, row) => if row == 0 { inventor-bg-tint } else if calc.even(row) { inventor-bg.lighten(60%) } else {
        white
      },
      table.header([*Topik*], [*Halaman Resmi*]),
      [Motor], [#link("https://docs.pybricks.com/en/stable/pupdevices/motor.html")[Motor]],
      [DriveBase], [#link("https://docs.pybricks.com/en/stable/robotics.html")[robotics]],
      [Sensor], [#link("https://docs.pybricks.com/en/stable/pupdevices/index.html")[pupdevices]],
      [Layar, tombol, IMU, speaker, baterai],
      [#link("https://docs.pybricks.com/en/stable/hubs/primehub.html")[Prime Hub / Inventor Hub]],

      [`Port`, `Direction`, `Stop`, `Color`, `Button`, `Icon`],
      [#link("https://docs.pybricks.com/en/stable/parameters/index.html")[parameters]],

      [`wait` dan `StopWatch`], [#link("https://docs.pybricks.com/en/stable/tools/index.html")[tools]],
      [Satuan yang dipakai setiap perintah],
      [#link("https://docs.pybricks.com/en/stable/signaltypes.html")[Signals and Units]],
    )
  ]
]

#v(-.5em)
dan materi ini dapat diakses di: #linebreak()
https://its.id/m/materi-robotika-rka-n
#v(-.5em)
(Ada referensi materi yang lebih lengkap juga di repo).
