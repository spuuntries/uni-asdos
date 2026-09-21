# Panduan Instalasi Gazebo Harmonic

Panduan ini untuk memasang Gazebo Harmonic, simulator yang kita pakai sepanjang semester.

Selesaikan `../ROS 2/instalasi-ros2.md` terlebih dahulu. Gazebo dipasang lewat ROS, jadi urutannya tidak bisa dibalik.

## Jangan tambahkan repositori OSRF

Kalau kalian mencari cara memasang Gazebo di internet, hampir semua hasilnya menyuruh menambahkan repositori `packages.osrfoundation.org`. Untuk kelas ini, jangan.

Pada kombinasi ROS 2 Jazzy dan Gazebo Harmonic, Gazebo sudah tersedia lewat paket ROS. Paket `ros-jazzy-ros-gz` menarik `ros-gz-sim`, yang kemudian menarik `gz-sim-vendor`. Rantai dependensi itulah Gazebo-nya.

Kalau repositori OSRF ditambahkan di atasnya, kalian akan punya dua instalasi Gazebo dalam satu mesin, satu versi vendor dari ROS dan satu versi mandiri. Masing-masing punya binary `gz` sendiri dan path plugin sendiri. Gejalanya membingungkan: dunia simulasi gagal dimuat, plugin tidak ditemukan, atau `gz` menjalankan versi yang tidak kalian maksud. Membersihkannya jauh lebih repot daripada memasangnya.

## Bagian 1: Ubuntu, WSL2, dan Linux lain dengan apt

Cukup satu perintah:

```bash
sudo apt install ros-jazzy-ros-gz
```

Tambahannya sekitar 63 MB unduhan dan 382 MB terpasang, di atas ROS yang sudah ada.

### 1.1 Perintah gz baru muncul setelah ROS di-source

```bash
source /opt/ros/jazzy/setup.bash
gz sim --version
```

Pesan `gz: command not found` di terminal baru itu wajar. Binary-nya tidak dipasang di `/usr/bin`, melainkan di `/opt/ros/jazzy/opt/gz_tools_vendor/bin/gz`, dan baru masuk ke `PATH` setelah ROS di-source.

Kalau di `../ROS 2/instalasi-ros2.md` langkah 1.4 kalian sudah menambahkan perintah `source` ke `~/.bashrc`, ini terjadi otomatis di setiap terminal baru.

### 1.2 Uji Gazebo sendiri

```bash
source /opt/ros/jazzy/setup.bash
gz sim shapes.sdf
```

Yang muncul seharusnya jendela 3D berisi sebuah kubus, bola, silinder, dan kapsul di atas bidang tanah.

Tekan tombol play di kiri bawah. Bentuk-bentuknya tidak akan bergerak karena memang sudah diam. Yang perlu diperhatikan adalah angka real time factor di bar bawah.

Real time factor, disingkat RTF, adalah angka terpenting di layar ini. Nilai 1.00 artinya simulasi berjalan secepat waktu nyata. Nilai 0.05 artinya simulasi berjalan 20 kali lebih lambat, jadi satu detik simulasi butuh 20 detik nyata.

Kalau RTF kalian jauh di bawah 1.00 pada dunia sesederhana `shapes.sdf`, berarti instalasinya memakai rendering CPU. Lihat bagian [Rendering CPU](#rendering-cpu) di bawah.

### 1.3 Uji Gazebo lewat ROS

Uji sebelumnya membuktikan Gazebo jalan. Uji berikut membuktikan jembatan antara ROS dan Gazebo berfungsi, dan itu yang sebenarnya kalian butuhkan sepanjang semester.

```bash
source /opt/ros/jazzy/setup.bash
ros2 launch ros_gz_sim gz_sim.launch.py gz_args:="shapes.sdf"
```

Jendela yang sama harus muncul, kali ini dijalankan lewat ROS.

## Bagian 2: macOS

Gazebo ikut terpasang lewat channel RoboStack. Jalankan dari dalam folder `ros_ws`:

```bash
cd ros_ws
pixi add ros-jazzy-ros-gz
```

### 2.1 Di macOS pakai dua terminal

Cara ini bukan tanda instalasi kalian rusak. Dokumentasi resmi Gazebo memang menginstruksikan begitu untuk macOS, yaitu server dan GUI dijalankan terpisah.

Terminal 1, untuk server:

```bash
cd ros_ws && pixi shell
gz sim -v 4 shapes.sdf -s
```

Terminal 2, untuk GUI:

```bash
cd ros_ws && pixi shell
gz sim -v 4 -g
```

Bentuk perintah tunggal, `gz sim -v 4 shapes.sdf`, biasanya juga berhasil untuk dunia yang tidak memakai sensor. Kalau crash, pakai dua terminal saja dan lanjutkan. Tidak ada yang salah dengan instalasi kalian.

### 2.2 Batasan sensor di macOS

Ini satu-satunya batasan nyata pada jalur macOS. Kalian perlu mengenali bentuknya supaya tidak menghabiskan waktu mengira instalasinya rusak.

Penyebabnya begini. Di macOS, Gazebo merender lewat Metal, bukan OpenGL. Metal mensyaratkan context dibuat di main thread, sementara rendering sensor di Gazebo tidak melakukannya. Perbaikannya sudah ada di hulu, tapi cuma di-backport ke Gazebo versi berikutnya, tidak ke Harmonic yang kita pakai.

| Yang dikerjakan | Status di macOS |
|---|---|
| Node ROS, topic, service, action | jalan |
| `colcon build`, package sendiri, VS Code | jalan, filesystem langsung |
| tf2, URDF, `robot_state_publisher` | jalan |
| RViz2 | jalan |
| Gazebo server, fisika saja | jalan |
| Gazebo GUI di terminal terpisah | jalan |
| Controller, `ros2_control` | jalan |
| Nav2 dengan lidar tipe ray | jalan |
| Kamera, depth camera, RGBD, lidar GPU | crash |

Praktisnya, membangun dunia, mengemudikan robot, menjalankan controller, dan Nav2 dengan lidar 2D semuanya aman. Begitu kalian menambahkan `<sensor type="camera">` ke URDF, harapkan crash.

Untuk pertemuan yang memakai kamera, kalian akan memakai container dan melihat hasilnya lewat browser. Instruksinya diberikan terpisah menjelang pertemuan tersebut.

## Bagian 3: Linux selain Ubuntu

Ikuti jalur yang sudah kalian pilih di `../ROS 2/instalasi-ros2.md`.

Untuk NixOS, Gazebo tersedia di `nix-ros-overlay` bersama ROS.

Untuk RHEL, Rocky, dan Alma, repositori RPM ROS tidak menyediakan Gazebo. Paket `gz-sim-vendor` dan `ros-gz-sim` tidak ada di sana. ROS tetap terpasang langsung di host, Gazebo berjalan di container, dan keduanya disatukan lewat satu `ROS_DOMAIN_ID`. Konfigurasinya diberikan di kelas.

Untuk Fedora, Debian, Arch, dan openSUSE, Gazebo sudah ikut di dalam image kuliah yang kalian jalankan lewat Distrobox. Tidak ada langkah tambahan.

## Rendering CPU

Ini kegagalan instalasi yang tidak memunculkan error sama sekali. Gazebo terbuka, dunia termuat, semuanya kelihatan benar. Yang terjadi cuma satu, simulasinya lambat sekali.

Tiap semester ada yang melaporkan ini sebagai laptop yang kurang kuat, padahal laptopnya baik-baik saja dan instalasinya yang belum benar.

### Cara mendeteksinya

Ada dua indikator. Yang pertama:

```bash
glxinfo -B | grep -i "OpenGL renderer"
```

Kalau hasilnya menyebut `llvmpipe`, rendering dikerjakan CPU. Kalau menyebut nama kartu grafis, entah Intel, AMD, NVIDIA, atau Apple, kalian aman. Kalau `glxinfo` belum ada, pasang dengan `sudo apt install mesa-utils`.

Indikator kedua adalah angka RTF di bar bawah Gazebo saat menjalankan `shapes.sdf`. Nilainya harus mendekati 1.00. Kalau cuma 0.1 atau lebih rendah pada dunia sesederhana itu, GPU kalian tidak terpakai.

### Penyebab, sesuai jalur instalasi

| Jalur | Penyebab | Solusi |
|---|---|---|
| WSL2 | Driver vGPU dari vendor belum terpasang | Pasang driver Intel, AMD, atau NVIDIA dari situs vendornya, bukan dari Windows Update, lalu jalankan `wsl --shutdown` di PowerShell |
| Linux langsung | Belum tergabung di grup `video` atau `render`, atau `/dev/dri` tidak ada | `sudo usermod -aG video,render $USER`, lalu logout dan login lagi |
| Container atau Distrobox | Perangkat GPU tidak diteruskan ke container | Distrobox mengurusnya otomatis. Kalau memakai `docker run` manual, tambahkan `--device /dev/dri` |
| macOS | Container Docker di Mac tidak punya akses GPU | Wajar. Untuk pekerjaan yang butuh GPU, pakai jalur RoboStack |

## Instalasi dianggap selesai kalau

Untuk Ubuntu, WSL2, dan Linux dengan apt:

```bash
source /opt/ros/jazzy/setup.bash
gz sim shapes.sdf                                                # jendela 3D, RTF mendekati 1.00
ros2 launch ros_gz_sim gz_sim.launch.py gz_args:="shapes.sdf"    # jendela yang sama, lewat ROS
glxinfo -B | grep -i "OpenGL renderer"                           # bukan llvmpipe
```

Untuk macOS:

```bash
cd ros_ws && pixi shell
gz sim -v 4 shapes.sdf -s     # terminal 1
gz sim -v 4 -g                # terminal 2, jendela 3D muncul
```

## Masalah yang sering muncul

| Yang terlihat | Penyebab | Solusi |
|---|---|---|
| `gz: command not found` | ROS belum di-source | `source /opt/ros/jazzy/setup.bash`. Di macOS: `cd ros_ws && pixi shell` |
| Jendela Gazebo hitam, atau GUI segfault saat dibuka | Ubuntu 24.04 memakai Wayland, dan interaksi Ogre dengan Qt bermasalah di sana | Jalankan `QT_QPA_PLATFORM=xcb gz sim shapes.sdf`. Kalau berhasil, permanenkan dengan `echo 'export QT_QPA_PLATFORM=xcb' >> ~/.bashrc` |
| `OGRE EXCEPTION`, atau tidak ada yang ter-render | Ogre2 butuh OpenGL di atas 3.3, idealnya 4.3 ke atas | Turun ke Ogre versi 1: `gz sim -v 3 shapes.sdf --render-engine ogre` |
| `libEGL warning: DRI2: failed to create dri screen` | Tidak berbahaya | Abaikan |
| Pesan "GUI requesting list of world names, please be patient" tidak selesai-selesai | Multicast diblokir. Ini bukan unduhan yang lambat | Aktifkan multicast di interface kalian: `sudo ip link set eth0 multicast on` |
| Gazebo jalan tapi sangat lambat, tanpa pesan error | Rendering CPU | Lihat bagian [Rendering CPU](#rendering-cpu) |
| macOS: crash begitu robot dengan kamera di-spawn | Batasan Metal di Harmonic | Bukan kesalahan kalian. Lihat 2.2 |
| macOS: `gz sim shapes.sdf` crash sebagai perintah tunggal | Perilaku yang sudah diketahui di macOS | Pakai dua terminal, lihat 2.1 |
| Ada dua binary `gz`, plugin tidak ditemukan, versi bentrok | Repositori `packages.osrfoundation.org` pernah ditambahkan | Hapus repositori itu, jalankan `sudo apt remove` untuk paket `gz-*` non-vendor, lalu pasang ulang `ros-jazzy-ros-gz` |

Kalau masalah kalian tidak ada di tabel ini, catat pesan error persis seperti yang muncul, sistem operasi dan jalur instalasi yang dipakai, serta angka RTF yang terlihat. Bawa catatan itu ke sesi lab.

## Sebelum praktikum pertama

Gazebo mengunduh model dunia dari internet saat pertama kali dibutuhkan, lalu menyimpannya di `~/.gz/fuel`. Kalau jaringan lab dibatasi, dunia simulasi bisa menggantung saat dimuat.

Jalankan `gz sim shapes.sdf` setidaknya sekali dari koneksi internet yang lancar sebelum datang ke lab, supaya cache-nya sudah terisi.
