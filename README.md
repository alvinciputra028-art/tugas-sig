# 🗺️ TUGAS SIG WebGIS - Teknik Informatika UNTAN

Repositori ini berisi kumpulan tugas praktikum mata kuliah **Sistem Informasi Geografis (SIG)**. Seluruh proyek dikembangkan berbasis web (WebGIS) menggunakan pustaka pemetaan interaktif **Leaflet.js**, dikombinasikan dengan ekosistem **PHP** dan **MySQL**.

👤 **Nama:** Alvin Andrianto Ciputra  
🎓 **NIM:** D1041231074  
📚 **Kelas:** SIG C  
🏫 **Institusi:** Program Studi Teknik Informatika, Universitas Tanjungpura (UNTAN)  
---

## 📂 Struktur Repositori
Repositori ini menyatukan beberapa tugas yang dieksekusi secara terpisah dalam satu lingkungan web terpadu (*Landing Page*).

```text
📁 webgis/
│
├── 📁 tugas_01/           # Tugas 1: Pemetaan Data Titik
├── 📁 tugas_02/           # Tugas 2: Pemetaan Data Garis & Poligon
├── 📁 tugas_03/           # Tugas 3: Manajemen Lapisan Peta (Layers)
│
├── index.php              # Halaman Utama (Landing Page)
└── README.md              # Dokumentasi
```

## 🚀 Daftar Tugas & Deskripsi Proyek
Berikut adalah penjelasan singkat untuk masing-masing modul tugas yang terdapat di dalam repositori ini:

### 📍 Tugas 01: Manajemen Data SPBU (Point)
Tugas ini berfokus pada pengenalan dasar Leaflet.js dengan memetakan titik-titik lokasi berwujud penanda (Marker).

Fokus Pembelajaran: Menginisialisasi Peta Dasar (Basemap), mengatur koordinat awal (Latitude & Longitude) Kota Pontianak, serta menambahkan marker dengan keterangan informasi pada fitur Pop-up.

Studi Kasus: Visualisasi sebaran titik lokasi Stasiun Pengisian Bahan Bakar Umum (SPBU).

### 🛣️ Tugas 02: Manajemen Data Jalan & Parsil (Polyline & Polygon)
Meningkatkan kompleksitas spasial dengan menggambar elemen vektor dasar berupa garis komposit (Polyline) dan area tertutup (Polygon).

Fokus Pembelajaran: Menangani array koordinat berlapis (multi-dimensional arrays) untuk membentuk rute dan batasan luasan (boundary), serta mengkustomisasi styling vektor (warna garis, ketebalan, dan warna isian/ fill color).

Studi Kasus: Visualisasi jaringan infrastruktur jalan dan luasan parsil lahan/bangunan.

### 📑 Tugas 03: Penerapan Layer Groups & Layers Controls
Menyempurnakan fungsi peta agar lebih interaktif dan mudah dibaca ketika menampung banyak data spasial sekaligus.

Fokus Pembelajaran: Mengelompokkan marker, polyline, dan polygon menggunakan L.layerGroup(). Menerapkan antarmuka pengendali lapisan menggunakan L.control.layers() agar pengguna dapat memfilter visual peta secara dinamis.

Studi Kasus: Penggabungan seluruh data SPBU, Jalan, dan Parsil dalam satu layar interaktif.

## 🛠️ Teknologi Utama
Frontend: HTML5, CSS3 (Modern Flexbox/Grid CSS), Vanilla JavaScript.

Web Mapping Library: Leaflet.js (v1.9.4).

Backend: PHP Native (Versi 7.x - 8.x).

Database: MySQL / MariaDB.

Basemap Provider: OpenStreetMap (OSM).

## 💻 Panduan Menjalankan Proyek Secara Lokal
Agar seluruh modul tugas (terutama Tugas Akhir yang memerlukan database) dapat berjalan dengan sempurna, ikuti langkah berikut:
1. Pastikan Anda telah memasang Web Server lokal (seperti XAMPP, Laragon, atau MAMP) dan mengaktifkan servis Apache & MySQL.

2. Salin atau Clone repositori ini ke dalam direktori publik web server Anda (contoh: di dalam folder htdocs untuk XAMPP).

```
git clone https://github.com/alvinciputra028/webgis.git
```

3. Konfigurasi Database:
- Buka phpMyAdmin.
- Buat basis data baru dan import file SQL yang disediakan
- Sesuaikan kredensial akses di dalam file webgis-bansos/config/koneksi.php.

4. Buka peramban (web browser) dan akses URL Landing Page:

```
   http://localhost/webgis/index.php
```

5. Anda dapat mengklik tombol "Buka Proyek" pada masing-masing kartu penugasan untuk melihat hasilnya secara interaktif.
