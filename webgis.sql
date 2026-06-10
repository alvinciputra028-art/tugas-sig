-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 10 Jun 2026 pada 14.18
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webgis`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin_ibadah`
--

CREATE TABLE `admin_ibadah` (
  `id` int(11) NOT NULL,
  `id_ibadah` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admin_ibadah`
--

INSERT INTO `admin_ibadah` (`id`, `id_ibadah`, `nama_lengkap`, `username`, `password`, `created_at`) VALUES
(4, 1, 'Andi Novianto', 'andinovi838', '$2y$10$kStMlX8nekrCFAhkcTymv.DTIs23AWlCoSfUJ3U2xZJT0rnTXjQmm', '2026-04-30 07:08:22'),
(5, 2, 'Budi Santoso', 'budisans', '$2y$10$D6xh9zVvllWwS4e3KcWjL.LGw//N0hxJzxUbF7MRCzVB7QMsgUzza', '2026-04-30 07:08:22'),
(6, 5, 'Toni Hardyanto', 'tonihard', '$2y$10$WHgmO/dVttoFvQRu/I5W4OqipCLkp3LVuPqjdvBRpq5TWNYVLAFG.', '2026-04-30 07:08:22'),
(7, 3, 'Christian Marvin', 'christmarvin', '$2y$10$813CUf.Fm/q5zYkkC1X/I.UObSvoXZCmMd3aasDb5lV4JHT.gUB3O', '2026-04-30 09:44:02');

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota_keluarga`
--

CREATE TABLE `anggota_keluarga` (
  `id` int(11) NOT NULL,
  `id_penduduk` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `pendidikan_terakhir` enum('Tidak Sekolah','SD Sederajat','SMP Sederajat','SMA Sederajat','Diploma','Sarjana') NOT NULL,
  `pekerjaan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggota_keluarga`
--

INSERT INTO `anggota_keluarga` (`id`, `id_penduduk`, `nik`, `nama_lengkap`, `tanggal_lahir`, `pendidikan_terakhir`, `pekerjaan`) VALUES
(1, 5, '6101055708840004', 'Siti Nurdiah', '1984-08-17', 'SMP Sederajat', 'Ibu Rumah Tangga'),
(2, 5, '6101052305040008', 'Muhammad Rifki', '2004-05-23', 'SMA Sederajat', 'Belum Bekerja'),
(3, 5, '6101050302780003', 'Budi', '1978-02-03', 'SD Sederajat', 'Petani'),
(4, 8, '6101052307650006', 'Somat', '1965-07-23', 'SD Sederajat', 'Nelayan'),
(5, 8, '6101056008730008', 'Fatimah', '1973-08-20', 'SD Sederajat', 'Ibu Rumah Tangga'),
(6, 8, '6101051410980003', 'Muhammad Fatharrahman', '1998-10-14', 'SMP Sederajat', 'Pekerja Pabrik'),
(7, 8, '6101050611040009', 'Muhammad Abdurrahman', '2004-11-06', 'SMA Sederajat', 'Belum Bekerja'),
(10, 9, '6101050807710003', 'Toni', '1971-07-08', 'SD Sederajat', 'Petani'),
(11, 9, '6101055602800004', 'Wati', '1980-02-16', 'SMP Sederajat', 'Ibu Rumah Tangga'),
(12, 9, '6101051012030008', 'Joko Supratno', '2003-12-10', 'SMA Sederajat', 'Belum Bekerja'),
(13, 10, '6101051710700001', 'Roni', '1970-09-17', 'SD Sederajat', 'Nelayan'),
(14, 10, '6101052105980004', 'Nurul Aslam', '1998-05-21', 'Sarjana', 'Guru'),
(15, 3, '6101052306670003', 'Ali', '1967-06-23', 'SMP Sederajat', 'Pedagang'),
(16, 3, '6101054901780002', 'Sinta', '1978-01-09', 'SMP Sederajat', 'Ibu Rumah Tangga'),
(17, 3, '6101052405050004', 'Davey Nelson', '2005-05-24', 'SMA Sederajat', 'Belum Bekerja');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jalan`
--

CREATE TABLE `jalan` (
  `id` int(11) NOT NULL,
  `nama_jalan` varchar(100) DEFAULT NULL,
  `status_jalan` enum('Nasional','Provinsi','Kabupaten') DEFAULT NULL,
  `panjang_jalan` float DEFAULT NULL,
  `koordinat` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jalan`
--

INSERT INTO `jalan` (`id`, `nama_jalan`, `status_jalan`, `panjang_jalan`, `koordinat`, `created_at`) VALUES
(9, 'Jalan Veteran', 'Nasional', 682.3, '[{\"lat\":-0.04648804154543884,\"lng\":109.34230506420137},{\"lat\":-0.04391848610908843,\"lng\":109.34354960918428},{\"lat\":-0.042083855659666713,\"lng\":109.3445259332657},{\"lat\":-0.04130601525131569,\"lng\":109.3454432487488}]', '2026-06-01 06:06:39'),
(10, 'Budi Karya', 'Provinsi', 762.81, '[{\"lat\":-0.041322108501222,\"lng\":109.34560418128969},{\"lat\":-0.04434227500773272,\"lng\":109.34942901134492},{\"lat\":-0.04426180876134359,\"lng\":109.34961676597597},{\"lat\":-0.042926069058584725,\"lng\":109.3507969379425}]', '2026-06-09 14:36:25'),
(11, 'Aris Margono', 'Kabupaten', 331.64, '[{\"lat\":-0.043693180617690015,\"lng\":109.33982133865358},{\"lat\":-0.0431567389687856,\"lng\":109.34043288230897},{\"lat\":-0.042850967227206826,\"lng\":109.34094786643983},{\"lat\":-0.04256665315062193,\"lng\":109.34174716472627},{\"lat\":-0.04252373781820425,\"lng\":109.34199392795564},{\"lat\":-0.04255592431752069,\"lng\":109.3422567844391},{\"lat\":-0.042641754982266994,\"lng\":109.34244453907014}]', '2026-06-09 14:37:54');

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporan_musibah`
--

CREATE TABLE `laporan_musibah` (
  `id` int(11) NOT NULL,
  `id_penduduk` int(11) NOT NULL,
  `id_ibadah` int(11) NOT NULL,
  `tanggal_lapor` timestamp NOT NULL DEFAULT current_timestamp(),
  `jenis_musibah` enum('Kebakaran','Sakit Keras','Kematian','Kecelakaan','Bencana Alam','Lainnya') NOT NULL,
  `deskripsi` text NOT NULL,
  `status_penanganan` enum('Menunggu Bantuan','Sedang Ditangani','Selesai Ditangani') DEFAULT 'Menunggu Bantuan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `laporan_musibah`
--

INSERT INTO `laporan_musibah` (`id`, `id_penduduk`, `id_ibadah`, `tanggal_lapor`, `jenis_musibah`, `deskripsi`, `status_penanganan`) VALUES
(1, 5, 1, '2026-05-08 08:49:27', 'Kebakaran', 'Seluruh bagian rumah terbakar habis', 'Selesai Ditangani'),
(2, 5, 1, '2026-05-08 10:36:29', 'Kecelakaan', 'Kepala keluarga mengalami kecelakaan motor yang menyebabkan  korban mengalami patah kaki', 'Selesai Ditangani'),
(3, 8, 2, '2026-06-02 05:31:40', 'Bencana Alam', 'Banjir, rumah tergenang air setinggi lutut', 'Selesai Ditangani'),
(4, 9, 5, '2026-06-02 09:46:35', 'Kebakaran', 'Rumah habis kebakar tanpa sisa', 'Selesai Ditangani');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_bantuan`
--

CREATE TABLE `log_bantuan` (
  `id` int(11) NOT NULL,
  `id_penduduk` int(11) NOT NULL,
  `id_ibadah` int(11) NOT NULL,
  `id_musibah` int(11) DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `tanggal_penyaluran` date NOT NULL,
  `beras_kg` float DEFAULT 0,
  `minyak_l` float DEFAULT 0,
  `gula_kg` float DEFAULT 0,
  `telur_kg` float DEFAULT 0,
  `susu_kaleng` int(11) DEFAULT 0,
  `uang_tunai` int(11) DEFAULT 0,
  `catatan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_bantuan`
--

INSERT INTO `log_bantuan` (`id`, `id_penduduk`, `id_ibadah`, `id_musibah`, `id_admin`, `tanggal_penyaluran`, `beras_kg`, `minyak_l`, `gula_kg`, `telur_kg`, `susu_kaleng`, `uang_tunai`, `catatan`, `created_at`) VALUES
(1, 5, 1, NULL, 4, '2026-04-30', 10, 2, 2, 2, 3, 300000, 'Bantuan Bulan April', '2026-04-30 10:19:16'),
(12, 5, 1, 2, 4, '2026-05-08', 10, 2, 2, 2, 3, 500000, 'Bantuan Pasca Musibah Kecelakaan', '2026-05-08 10:50:56'),
(13, 5, 1, NULL, 4, '2026-05-08', 10, 2, 2, 2, 3, 300000, 'Bantuan Bulan Mei', '2026-05-08 10:51:42'),
(14, 8, 2, 3, 5, '2026-06-02', 5, 2, 1, 1, 2, 150000, 'Bantuan pasca musibah banjir', '2026-06-02 05:32:01'),
(15, 9, 5, 4, 6, '2026-06-02', 5, 2, 1, 1, 2, 150000, 'Bantuan pasca musibah kebakaran', '2026-06-02 10:02:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_pelatihan`
--

CREATE TABLE `log_pelatihan` (
  `id` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `id_pelatihan` int(11) NOT NULL,
  `tanggal_daftar` timestamp NOT NULL DEFAULT current_timestamp(),
  `status_kelulusan` enum('Sedang Berjalan','Lulus','Tidak Lulus/Drop Out') DEFAULT 'Sedang Berjalan',
  `catatan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_pelatihan`
--

INSERT INTO `log_pelatihan` (`id`, `id_anggota`, `id_pelatihan`, `tanggal_daftar`, `status_kelulusan`, `catatan`) VALUES
(1, 2, 1, '2026-05-08 08:23:32', 'Sedang Berjalan', NULL),
(2, 7, 3, '2026-06-02 05:35:07', 'Sedang Berjalan', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_pelatihan`
--

CREATE TABLE `master_pelatihan` (
  `id` int(11) NOT NULL,
  `nama_pelatihan` varchar(150) NOT NULL,
  `penyelenggara` varchar(100) NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `master_pelatihan`
--

INSERT INTO `master_pelatihan` (`id`, `nama_pelatihan`, `penyelenggara`, `tanggal_mulai`, `tanggal_selesai`, `deskripsi`) VALUES
(1, 'Pelatihan Desain Grafis', 'Dinas Sosial Kota Pontianak', '2026-05-15', '2026-06-15', 'Pelatihan Desain Grafis ini akan memberikan bekal ilmu desain grafis yang dapat digunakan oleh peserta dalam dunia kerja!'),
(2, 'Pelatihan Pemrograman Web', 'Prodi Informatika, Fakultas Teknik, Universitas Tanjungpura Kota Pontianak', '2026-06-01', '2026-06-30', 'Pelatihan ini akan membekali peserta dengan kemampuan dasar pemrograman web yang dapat berguna dalam dunia kerja.'),
(3, 'Pelatihan Bahasa Mandarin Dasar', 'Prodi Pendidikan Bahasa Mandarin, Fakultas Keguruan dan Ilmu Pendidikan, Universitas Tanjungpura', '2026-06-01', '2026-06-30', 'Pelatihan ini ditujukan kepada anak-anak kurang mampu yang ingin mempelajari bahasa Mandarin yang diharpkan dapat menjadi bekal untuk terjun ke dunia kerja.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `parsil`
--

CREATE TABLE `parsil` (
  `id` int(11) NOT NULL,
  `nama_pemilik` varchar(100) DEFAULT NULL,
  `status_kepemilikan` enum('SHM','HGB','HGU','HP') DEFAULT NULL,
  `luas_tanah` float DEFAULT NULL,
  `koordinat` text DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `parsil`
--

INSERT INTO `parsil` (`id`, `nama_pemilik`, `status_kepemilikan`, `luas_tanah`, `koordinat`, `alamat`, `created_at`) VALUES
(1, 'Garuda Hotel', 'SHM', 1757.53, '[{\"lat\":-0.039460655907509815,\"lng\":109.34722959995271},{\"lat\":-0.03960549515983438,\"lng\":109.34731543064119},{\"lat\":-0.03956257982583914,\"lng\":109.34737980365755},{\"lat\":-0.03965913932731252,\"lng\":109.34745490550995},{\"lat\":-0.039557215409097686,\"lng\":109.34766948223115},{\"lat\":-0.03941237615668407,\"lng\":109.34783041477203},{\"lat\":-0.039203163902749624,\"lng\":109.34768557548524}]', 'Jalan Pahlawan, Benua Melayu Darat, Pontianak Selatan', '2026-04-08 02:41:15'),
(2, 'Budi', 'HGU', 45671.5, '[{\"lat\":-0.04345714629263058,\"lng\":109.34811472892763},{\"lat\":-0.044605131412008475,\"lng\":109.3472456932068},{\"lat\":-0.046214456315453456,\"lng\":109.34928953647615},{\"lat\":-0.045146937466815015,\"lng\":109.35004055500032},{\"lat\":-0.04478215715312821,\"lng\":109.34950411319734},{\"lat\":-0.04455148724793989,\"lng\":109.34964358806612}]', NULL, '2026-06-10 11:50:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penduduk_miskin`
--

CREATE TABLE `penduduk_miskin` (
  `id` int(11) NOT NULL,
  `nama_kk` varchar(100) DEFAULT NULL,
  `agama` enum('Islam','Kristen','Katolik','Hindu','Buddha','Konghucu') DEFAULT NULL,
  `tanggungan` int(11) DEFAULT NULL,
  `pengeluaran` int(11) DEFAULT NULL,
  `lantai` int(11) DEFAULT 0,
  `dinding` int(11) DEFAULT 0,
  `sanitasi` int(11) DEFAULT 0,
  `listrik` int(11) DEFAULT 0,
  `air` int(11) DEFAULT 0,
  `skor_aset` int(11) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status_kemiskinan` enum('Sangat Miskin','Miskin','Rentan Miskin','Data Belum Lengkap') DEFAULT 'Data Belum Lengkap'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penduduk_miskin`
--

INSERT INTO `penduduk_miskin` (`id`, `nama_kk`, `agama`, `tanggungan`, `pengeluaran`, `lantai`, `dinding`, `sanitasi`, `listrik`, `air`, `skor_aset`, `alamat`, `latitude`, `longitude`, `created_at`, `status_kemiskinan`) VALUES
(1, 'Anton', 'Islam', 3, 600000, 0, 0, 0, 1, 1, 2, 'Akcaya, Pontianak Selatan', -0.05051135, 109.32582557, '2026-04-15 07:21:00', 'Miskin'),
(3, 'Ali', 'Islam', 3, 800000, 0, 0, 0, 0, 1, 1, 'Tanjung Hulu, Pontianak Timur', -0.02762139, 109.36540961, '2026-04-15 07:26:33', 'Rentan Miskin'),
(5, 'Budi', 'Islam', 3, 500000, 0, 1, 0, 1, 1, 3, 'Akcaya, Pontianak Selatan', -0.04989981, 109.32654440, '2026-04-30 08:18:38', 'Sangat Miskin'),
(8, 'Somat', 'Islam', 4, 500000, 1, 0, 0, 0, 1, 2, 'Akcaya, Pontianak Selatan', -0.05437373, 109.32617426, '2026-06-02 05:19:08', 'Miskin'),
(9, 'Toni', 'Islam', 3, 500000, 0, 0, 0, 1, 1, 2, 'Akcaya, Pontianak Selatan', -0.04326939, 109.32870090, '2026-06-02 05:40:00', 'Miskin'),
(10, 'Roni', 'Islam', 2, 600000, 1, 0, 0, 0, 1, 2, 'Gang surya Ungu, Akcaya, Pontianak Selatan', -0.04996418, 109.33091104, '2026-06-02 05:45:52', 'Miskin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengaturan`
--

CREATE TABLE `pengaturan` (
  `id` int(11) NOT NULL,
  `garis_kemiskinan` int(11) NOT NULL,
  `terakhir_diubah` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengaturan`
--

INSERT INTO `pengaturan` (`id`, `garis_kemiskinan`, `terakhir_diubah`) VALUES
(1, 700000, '2026-05-03 10:55:23');

-- --------------------------------------------------------

--
-- Struktur dari tabel `spbu`
--

CREATE TABLE `spbu` (
  `id` int(11) NOT NULL,
  `nama_spbu` varchar(100) NOT NULL,
  `no_wa` varchar(20) NOT NULL,
  `buka_24` enum('Ya','Tidak') DEFAULT 'Tidak',
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `alamat` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `spbu`
--

INSERT INTO `spbu` (`id`, `nama_spbu`, `no_wa`, `buka_24`, `latitude`, `longitude`, `alamat`, `created_at`) VALUES
(1, 'SPBU Kodam', '081234567864', 'Ya', -0.07373927, 109.37164307, 'Gang Siaga 4 Berseri, Sungai Raya', '2026-04-01 04:17:20'),
(3, 'SPBU Parit Husin 2', '0812247892342', 'Tidak', -0.06434618, 109.35622573, 'Jalan Parit Haji Husein 2, Bangka Belitung Darat, Pontianak Tenggara', '2026-04-01 04:35:31'),
(4, 'SPBU Parit Husin 1', '081236247214', 'Ya', -0.05546807, 109.36264157, 'Jalan Parit Haji Husein 1, Bangka Belitung Laut, Pontianak Tenggara', '2026-04-01 04:47:47'),
(5, 'SPBU Kota Baru', '081274127365', 'Ya', -0.04786133, 109.31865335, 'Jalan Dokter Sutomo, Sungai Bangkong, Pontianak Kota', '2026-04-01 14:52:09'),
(6, 'SPBU OSO MT. Haryono', '0812213289472', 'Tidak', -0.04490554, 109.33673143, 'Jalan M.T. Haryono, Akcaya, Pontianak Selatan', '2026-04-01 14:56:39'),
(7, 'SPBU Wahidin', '0812332137192', 'Tidak', -0.03841459, 109.31034386, 'Gang Sepakat 2A, Sungai Jawi, Pontianak Kota', '2026-04-01 15:02:01'),
(8, 'SPBU Kota Baru Ujung', '081298347891', 'Tidak', -0.06250619, 109.30449665, 'Sungai Bangkong, Pontianak Kota', '2026-04-01 15:05:39'),
(9, 'SPBU Husein Hamzah', '0812927334234', 'Tidak', -0.03319718, 109.29170002, 'Jalan Husein Hamzah, Pal Lima, Pontianak Barat', '2026-04-01 15:06:57'),
(10, 'SPBU Hasanuddin', '0812874474637', 'Tidak', -0.01785815, 109.33168352, 'Jalan Hassanudin, Sungai Jawi Dalam, Pontianak Barat', '2026-04-01 15:08:44'),
(11, 'SPBU Hos Cokroaminoto', '0812934729842', 'Tidak', -0.02796454, 109.33415910, 'Tengah, Pontianak Kota', '2026-04-01 15:14:25'),
(12, 'SPBU K.H.Ahmad Dahlan', '0812892378923', 'Tidak', -0.03441810, 109.33190346, 'Jalan Teuku Umar, Sungai Bangkong, Pontianak Kota', '2026-04-01 15:15:53'),
(13, 'SPBU Tanjung Pura', '0812234762394', 'Tidak', -0.03152132, 109.34516430, 'Jalan Tanjung Pura, Benua Melayu Darat, Pontianak Selatan', '2026-04-01 15:16:50'),
(14, 'SPBU Imam Bonjol', '081292347386', 'Ya', -0.04699766, 109.35453057, 'Gang Haji Ali, Bansir Laut, Pontianak Tenggara', '2026-04-01 15:18:06'),
(15, 'SPBU Arteri Supadio', '081221739832', 'Tidak', -0.07354615, 109.36516821, 'Perumahan 288, Sungai Raya', '2026-04-01 15:19:18'),
(16, 'SPBU Sungai Raya Dalam', '081202389237', 'Tidak', -0.09251471, 109.34664488, 'Bangka Belitung Darat, Pontianak Tenggara', '2026-04-01 15:20:36'),
(17, 'SPBU Tanjung Raya 2', '081223428943', 'Tidak', -0.04881620, 109.36897159, 'Jalan Tanjung Raya 2, Banjar Serasan, Pontianak Timur', '2026-04-01 15:23:03'),
(18, 'SPBU Tanjung Hilir', '081202373243', 'Ya', -0.02581894, 109.36204612, 'Tanjung Hilir, Pontianak Timur', '2026-04-01 15:24:04'),
(19, 'SPBU 28 Oktober', '0812824728424', 'Ya', -0.00503182, 109.36372519, 'Siantan Hulu, Pontianak Utara', '2026-04-01 15:24:59'),
(20, 'SPBU Siantan', '081292347897', 'Ya', -0.01620054, 109.35854316, 'Gusti Situt Mahmud, Siantan Hulu, Pontianak Utara', '2026-04-01 15:26:43'),
(21, 'SPBU Batulayang', '081282934774', 'Ya', 0.00920534, 109.29668069, 'Khatulistiwa, Batu Layang, Pontianak Utara', '2026-04-01 15:27:57'),
(23, 'SPBU Panglima Aim', '081237498484', 'Tidak', -0.02923608, 109.36807036, 'Jalan Panglima Aim, Tanjung Hulu, Pontianak Timur', '2026-04-11 04:46:59'),
(24, 'SPBU Ampera', '081292384723', 'Tidak', -0.04652559, 109.29498553, 'Sungai Jawi, Pontianak Kota', '2026-04-11 04:52:34'),
(25, 'Sudarso', '081234384839', 'Ya', -0.06077884, 109.36611772, 'Jalan Adi Sucipto, Sungai Raya', '2026-04-21 14:39:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `super_admin`
--

CREATE TABLE `super_admin` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `super_admin`
--

INSERT INTO `super_admin` (`id`, `nama_lengkap`, `username`, `password`) VALUES
(1, 'Kepala Dinas Sosial', 'superadmin', '$2y$10$YxxYVcDt44pud3LJWlDo4.XyHMzJRH0K6W4H3RL0FrDsENSxw18r2');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tempat_ibadah`
--

CREATE TABLE `tempat_ibadah` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `jenis` enum('Masjid','Gereja Katolik','Gereja Protestan','Vihara','Pura','Klenteng') DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `radius` float DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tempat_ibadah`
--

INSERT INTO `tempat_ibadah` (`id`, `nama`, `jenis`, `alamat`, `radius`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'Masjid Al-Ikhlash', 'Masjid', 'Gamg III, Akcaya, Pontianak Selatan', 500, -0.04957795, 109.32585776, '2026-04-15 07:17:56'),
(2, 'Majid Al-Qadir', 'Masjid', 'Gang Keluarga, Akcaya, Pontianak Selatan', 500, -0.05155205, 109.32599723, '2026-04-15 07:20:13'),
(3, 'Gereja Baptis Indonesia Kalvari Pontianak', 'Gereja Protestan', 'Gang Mandala, Tanjung Hulu, Pontianak Timur', 500, -0.02779305, 109.36456203, '2026-04-15 07:23:15'),
(4, 'Sunah Nurul Haq', 'Masjid', 'Gang Orde Baru, Tanjung Hulu, Pontianak Timur', 500, -0.02695084, 109.36616600, '2026-04-15 07:25:34'),
(5, 'Masjid SMAN 1 Pontianak', 'Masjid', 'Jalan Kalimantan, Akcaya, Pontianak Selatan', 500, -0.04244864, 109.32930708, '2026-04-29 03:01:31');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin_ibadah`
--
ALTER TABLE `admin_ibadah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id_ibadah` (`id_ibadah`);

--
-- Indeks untuk tabel `anggota_keluarga`
--
ALTER TABLE `anggota_keluarga`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penduduk` (`id_penduduk`);

--
-- Indeks untuk tabel `jalan`
--
ALTER TABLE `jalan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `laporan_musibah`
--
ALTER TABLE `laporan_musibah`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penduduk` (`id_penduduk`);

--
-- Indeks untuk tabel `log_bantuan`
--
ALTER TABLE `log_bantuan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penduduk` (`id_penduduk`),
  ADD KEY `id_ibadah` (`id_ibadah`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_musibah` (`id_musibah`);

--
-- Indeks untuk tabel `log_pelatihan`
--
ALTER TABLE `log_pelatihan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_pelatihan` (`id_pelatihan`);

--
-- Indeks untuk tabel `master_pelatihan`
--
ALTER TABLE `master_pelatihan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `parsil`
--
ALTER TABLE `parsil`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `penduduk_miskin`
--
ALTER TABLE `penduduk_miskin`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pengaturan`
--
ALTER TABLE `pengaturan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `spbu`
--
ALTER TABLE `spbu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `super_admin`
--
ALTER TABLE `super_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `tempat_ibadah`
--
ALTER TABLE `tempat_ibadah`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin_ibadah`
--
ALTER TABLE `admin_ibadah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `anggota_keluarga`
--
ALTER TABLE `anggota_keluarga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `jalan`
--
ALTER TABLE `jalan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `laporan_musibah`
--
ALTER TABLE `laporan_musibah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `log_bantuan`
--
ALTER TABLE `log_bantuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `log_pelatihan`
--
ALTER TABLE `log_pelatihan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `master_pelatihan`
--
ALTER TABLE `master_pelatihan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `parsil`
--
ALTER TABLE `parsil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `penduduk_miskin`
--
ALTER TABLE `penduduk_miskin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `spbu`
--
ALTER TABLE `spbu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `super_admin`
--
ALTER TABLE `super_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tempat_ibadah`
--
ALTER TABLE `tempat_ibadah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `admin_ibadah`
--
ALTER TABLE `admin_ibadah`
  ADD CONSTRAINT `admin_ibadah_ibfk_1` FOREIGN KEY (`id_ibadah`) REFERENCES `tempat_ibadah` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `anggota_keluarga`
--
ALTER TABLE `anggota_keluarga`
  ADD CONSTRAINT `anggota_keluarga_ibfk_1` FOREIGN KEY (`id_penduduk`) REFERENCES `penduduk_miskin` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `laporan_musibah`
--
ALTER TABLE `laporan_musibah`
  ADD CONSTRAINT `laporan_musibah_ibfk_1` FOREIGN KEY (`id_penduduk`) REFERENCES `penduduk_miskin` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `log_bantuan`
--
ALTER TABLE `log_bantuan`
  ADD CONSTRAINT `log_bantuan_ibfk_1` FOREIGN KEY (`id_penduduk`) REFERENCES `penduduk_miskin` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `log_bantuan_ibfk_2` FOREIGN KEY (`id_ibadah`) REFERENCES `tempat_ibadah` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `log_bantuan_ibfk_3` FOREIGN KEY (`id_admin`) REFERENCES `admin_ibadah` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `log_bantuan_ibfk_4` FOREIGN KEY (`id_musibah`) REFERENCES `laporan_musibah` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `log_pelatihan`
--
ALTER TABLE `log_pelatihan`
  ADD CONSTRAINT `log_pelatihan_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota_keluarga` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `log_pelatihan_ibfk_2` FOREIGN KEY (`id_pelatihan`) REFERENCES `master_pelatihan` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
