<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tugas WebGIS - Alvin Andrianto Ciputra</title>

    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- FontAwesome untuk Ikon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-color: #2980b9;
            --secondary-color: #8e44ad;
            --bg-color: #f4f7f6;
            --text-main: #2c3e50;
            --text-muted: #7f8c8d;
            --card-bg: #ffffff;
        }

        * {
            box-sizing: border-box;
        }

        html, body {
            min-height: 100vh;
            width: 100%;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            background-image: radial-gradient(#d5d8dc 1px, transparent 1px);
            background-size: 20px 20px;
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 1100px;
            padding: 40px 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 50px;
            animation: fadeInDown 0.8s ease-out;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 10px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header h4 {
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--text-muted);
            margin-top: 0;
            margin-bottom: 30px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .profile-card {
            display: inline-block;
            background-color: var(--card-bg);
            padding: 20px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            border-top: 4px solid var(--primary-color);
            text-align: left;
        }

        .cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            animation: fadeInUp 0.8s ease-out;
            width: 100%;
        }

        .card {
            flex: 1 1 300px;
            max-width: 340px;
            background-color: var(--card-bg);
            border-radius: 16px;
            padding: 30px 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid #eee;
        }

        .card.tugas-besar {
            max-width: 600px;
            border: 2px solid var(--secondary-color);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .card:hover::before {
            opacity: 1;
        }

        .card-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .task-number {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--secondary-color);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .task-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 25px;
            line-height: 1.4;
        }

        .btn-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 24px;
            background-color: var(--bg-color);
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-link:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-link i {
            transition: transform 0.3s ease;
        }

        .btn-link:hover i {
            transform: translateX(5px);
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        footer {
            margin-top: auto;
            padding: 30px;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

    </style>
</head>

<body>
    <div class="container">        
        <div class="header">
            <h1>Manajemen Data Spasial Kota Pontianak</h1>
            <h4>Kumpulan Tugas SIG</h4>
            
            <div class="profile-card">
                <table>
                    <tr>
                        <td><strong>Nama</strong></td>
                        <td>:</td>
                        <td><strong>Alvin Andrianto Ciputra</strong></td>
                    </tr>

                    <tr>
                        <td><strong>NIM</strong></td>
                        <td>:</td>
                        <td><strong>D1041231074</strong></td>
                    </tr>

                    <tr>
                        <td><strong>Kelas</strong></td>
                        <td>:</td>
                        <td><strong>SIG C</strong></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="cards">            
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="task-number">Tugas 01</div>
                <div class="task-title">Manajemen Data SPBU (Titik / Point)</div>
                <a href="tugas_01/index.php" class="btn-link">
                    Buka Proyek <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-route"></i>
                </div>
                <div class="task-number">Tugas 02</div>
                <div class="task-title">Manajemen Data Jalan (Polyline) & Parsil (Polygon)</div>
                <a href="tugas_02/index.php" class="btn-link">
                    Buka Proyek <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-layer-group"></i>
                </div>
                <div class="task-number">Tugas 03</div>
                <div class="task-title">Penerapan Layer Groups & Layers Controls</div>
                <a href="tugas_03/index.php" class="btn-link">
                    Buka Proyek <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="card tugas-besar">
                <div class="card-icon" style="color: #8e44ad;">
                    <i class="fas fa-globe-asia"></i>
                </div>
                <div class="task-number" style="color: #8e44ad;">Tugas Besar </div>
                <div class="task-title">WebGIS Poverty Mapping</div>
                <a href="proverty_mapping/index.php" class="btn-link" style="background-color: #8e44ad; color: white;">
                    Buka Proyek <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2026 Alvin Andrianto Ciputra - Teknik Informatika UNTAN
    </footer>
</body>

</html>