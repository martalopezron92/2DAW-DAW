# Proyecto Final - Sistema de Blog con Microservicios

### Descripción

**Proyecto:** *Sistema completo de blog con arquitectura de microservicios*

Este proyecto final integra todos los conocimientos adquiridos durante la unidad. Construirás un sistema de blog moderno con arquitectura de microservicios que incluye:

- **Frontend Web** (PHP + Nginx)
- **Base de Datos** (MySQL/MariaDB)
- **Caché** (Redis)
- **Administrador de BD** (phpMyAdmin)
- **Proxy Inverso** (Nginx)

#### Objetivo general

Demostrar dominio de:

- Arquitectura de microservicios con Docker.
- Construcción de imágenes personalizadas.
- Orquestación con Docker Compose.
- Gestión de redes y volúmenes.
- Variables de entorno y configuración.
- Persistencia de datos.
- Proxy inverso y enrutamiento.
- Integración de múltiples tecnologías.

---

### 🏗️ Arquitectura del Sistema

```
                         ┌─────────────────────┐
                         │   INTERNET/USER     │
                         └──────────┬──────────┘
                                    │
                         ┌──────────▼──────────┐
                         │   Nginx Proxy       │
                         │   (Puerto 80)       │
                         └──────────┬──────────┘
                                    │
                ┌───────────────────┼───────────────────┐
                │                   │                   │
     ┌──────────▼──────────┐ ┌─────▼──────┐  ┌────────▼────────┐
     │   Blog Frontend     │ │ phpMyAdmin │  │   API Service   │
     │   (PHP + Nginx)     │ │ (Puerto 81)│  │   (PHP-FPM)     │
     └──────────┬──────────┘ └─────┬──────┘  └────────┬────────┘
                │                   │                   │
                │         ┌─────────┴─────────┬────────┘
                │         │                   │
     ┌──────────▼─────────▼──────┐  ┌────────▼────────┐
     │      MySQL/MariaDB        │  │      Redis      │
     │   (Base de Datos)         │  │     (Caché)     │
     └───────────────────────────┘  └─────────────────┘
```

---

### 📦 Componentes del Sistema

#### 1. **Proxy Inverso (Nginx)**
- Enruta peticiones a los servicios correctos
- Configura dominios virtuales
- Balancea carga (opcional)

#### 2. **Blog Frontend (PHP + Nginx)**
- Aplicación principal del blog
- Interfaz de usuario
- Gestión de posts y comentarios

#### 3. **API Service (PHP-FPM)**
- API REST para operaciones
- Lógica de negocio separada
- Comunicación con BD y caché

#### 4. **Base de Datos (MariaDB)**
- Almacenamiento persistente
- Tablas: users, posts, comments
- Volumen Docker para datos

#### 5. **Caché (Redis)**
- Almacenamiento en memoria
- Caché de consultas frecuentes
- Sesiones de usuario

#### 6. **Administrador (phpMyAdmin)**
- Interfaz web para gestionar BD
- Acceso directo a MySQL/MariaDB
- Herramienta de desarrollo

---

### 📝 Código de la Aplicación

#### Archivo `frontend/public/index.php`:

```php
<?php
session_start();
require_once '../config/database.php';
require_once '../config/redis.php';

// Conectar a la base de datos
$db = getDBConnection();
$redis = getRedisConnection();

// Obtener posts desde caché o BD
$cacheKey = 'blog:posts:all';
$posts = $redis->get($cacheKey);

if (!$posts) {
    $stmt = $db->query("SELECT p.*, u.username, COUNT(c.id) as comment_count 
                        FROM posts p 
                        LEFT JOIN users u ON p.user_id = u.id 
                        LEFT JOIN comments c ON p.id = c.post_id 
                        GROUP BY p.id 
                        ORDER BY p.created_at DESC");
    $posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $redis->setex($cacheKey, 300, json_encode($posts)); // 5 minutos
} else {
    $posts = json_decode($posts, true);
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MicroBlog - Sistema de Blog con Docker</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            margin-bottom: 30px;
            text-align: center;
        }
        h1 {
            color: #667eea;
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .subtitle {
            color: #666;
            font-size: 1.1em;
        }
        .stats {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }
        .stat-item {
            text-align: center;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            color: #666;
            font-size: 0.9em;
        }
        .posts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        .post-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .post-title {
            color: #333;
            font-size: 1.5em;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .post-meta {
            display: flex;
            gap: 15px;
            color: #888;
            font-size: 0.9em;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .post-excerpt {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        .post-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: opacity 0.3s ease;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .comment-count {
            color: #888;
            font-size: 0.9em;
        }
        .new-post-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2em;
            text-decoration: none;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            transition: transform 0.3s ease;
        }
        .new-post-btn:hover {
            transform: scale(1.1);
        }
        .system-info {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            margin-top: 30px;
        }
        .system-info h3 {
            color: #667eea;
            margin-bottom: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        .info-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        .info-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .info-value {
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>🚀 MicroBlog</h1>
            <p class="subtitle">Sistema de Blog con Arquitectura de Microservicios</p>
            
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-number"><?php echo count($posts); ?></div>
                    <div class="stat-label">Posts Publicados</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">
                        <?php 
                        $userCount = $db->query("SELECT COUNT(*) FROM users")->fetchColumn();
                        echo $userCount;
                        ?>
                    </div>
                    <div class="stat-label">Usuarios</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">
                        <?php 
                        $commentCount = $db->query("SELECT COUNT(*) FROM comments")->fetchColumn();
                        echo $commentCount;
                        ?>
                    </div>
                    <div class="stat-label">Comentarios</div>
                </div>
            </div>
        </header>

        <div class="posts-grid">
            <?php foreach ($posts as $post): ?>
            <div class="post-card">
                <h2 class="post-title"><?php echo htmlspecialchars($post['title']); ?></h2>
                <div class="post-meta">
                    <span>👤 <?php echo htmlspecialchars($post['username']); ?></span>
                    <span>📅 <?php echo date('d/m/Y', strtotime($post['created_at'])); ?></span>
                </div>
                <p class="post-excerpt"><?php echo htmlspecialchars(substr($post['content'], 0, 150)) . '...'; ?></p>
                <div class="post-footer">
                    <a href="post.php?id=<?php echo $post['id']; ?>" class="btn">Leer más</a>
                    <span class="comment-count">💬 <?php echo $post['comment_count']; ?> comentarios</span>
                </div>
            </div>
            <?php endforeach; ?>
        </div>

        <div class="system-info">
            <h3>ℹ️ Información del Sistema</h3>
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">Servidor Web</div>
                    <div class="info-value"><?php echo $_SERVER['SERVER_SOFTWARE']; ?></div>
                </div>
                <div class="info-item">
                    <div class="info-label">PHP Version</div>
                    <div class="info-value"><?php echo phpversion(); ?></div>
                </div>
                <div class="info-item">
                    <div class="info-label">Base de Datos</div>
                    <div class="info-value">
                        <?php echo $db->getAttribute(PDO::ATTR_SERVER_VERSION); ?>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Redis</div>
                    <div class="info-value">
                        <?php echo $redis->ping() ? 'Conectado ✓' : 'Desconectado ✗'; ?>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Caché activa</div>
                    <div class="info-value">
                        <?php echo $redis->exists($cacheKey) ? 'Sí (desde caché)' : 'No (desde BD)'; ?>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Host</div>
                    <div class="info-value"><?php echo gethostname(); ?></div>
                </div>
            </div>
        </div>

        <a href="new-post.php" class="new-post-btn" title="Nuevo Post">+</a>
    </div>
</body>
</html>
```

#### Archivo `frontend/config/database.php`:

```php
<?php
function getDBConnection() {
    $host = getenv('DB_HOST') ?: 'db';
    $dbname = getenv('DB_NAME') ?: 'blogdb';
    $user = getenv('DB_USER') ?: 'bloguser';
    $pass = getenv('DB_PASS') ?: 'blogpass';
    
    try {
        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
        $pdo = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]);
        return $pdo;
    } catch (PDOException $e) {
        die("Error de conexión: " . $e->getMessage());
    }
}
```

#### Archivo `frontend/config/redis.php`:

```php
<?php
function getRedisConnection() {
    $host = getenv('REDIS_HOST') ?: 'redis';
    $port = getenv('REDIS_PORT') ?: 6379;
    
    try {
        $redis = new Redis();
        $redis->connect($host, $port);
        return $redis;
    } catch (Exception $e) {
        // Si Redis no está disponible, devolver objeto mock
        return new class {
            public function get($key) { return false; }
            public function setex($key, $ttl, $value) { return false; }
            public function exists($key) { return false; }
            public function ping() { return false; }
        };
    }
}
```

#### Archivo `database/init.sql`:

```sql
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS blogdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE blogdb;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de posts
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    views INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_created (created_at),
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de comentarios
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_post (post_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertar usuarios de ejemplo
INSERT INTO users (username, email, password) VALUES
('admin', 'admin@microblog.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'),
('juan_dev', 'juan@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'),
('maria_tech', 'maria@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'),
('pedro_code', 'pedro@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insertar posts de ejemplo
INSERT INTO posts (user_id, title, content) VALUES
(1, 'Bienvenido a MicroBlog', 'Este es un sistema de blog completo construido con Docker y arquitectura de microservicios. Incluye PHP, MySQL, Redis, Nginx y phpMyAdmin trabajando juntos en perfecta armonía. Esta es una demostración de cómo los contenedores Docker pueden simplificar el despliegue de aplicaciones complejas.'),
(2, 'Introducción a Docker', 'Docker ha revolucionado la forma en que desarrollamos y desplegamos aplicaciones. Con Docker, podemos empaquetar una aplicación y todas sus dependencias en un contenedor que puede ejecutarse en cualquier sistema que tenga Docker instalado. Esto elimina el famoso problema de "en mi máquina funciona".'),
(2, 'Arquitectura de Microservicios', 'La arquitectura de microservicios divide una aplicación en servicios pequeños e independientes que se comunican entre sí. Cada servicio puede desarrollarse, desplegarse y escalarse de forma independiente. Docker es perfecto para implementar microservicios ya que cada servicio puede vivir en su propio contenedor.'),
(3, 'Docker Compose: Orquestación Simplificada', 'Docker Compose nos permite definir y ejecutar aplicaciones multi-contenedor de forma sencilla. Con un simple archivo YAML podemos describir todos los servicios, redes y volúmenes que nuestra aplicación necesita. Un solo comando y toda la infraestructura está funcionando.'),
(3, 'Redis como Sistema de Caché', 'Redis es una base de datos en memoria extremadamente rápida, perfecta para implementar sistemas de caché. En este blog, usamos Redis para cachear las consultas más frecuentes a la base de datos, mejorando significativamente el rendimiento y reduciendo la carga en MySQL.'),
(4, 'Nginx como Proxy Inverso', 'Nginx es uno de los servidores web más eficientes y versátiles. En esta aplicación lo usamos como proxy inverso para enrutar las peticiones a los diferentes servicios. También podría usarse para balanceo de carga, SSL/TLS, compresión y caché de contenido estático.'),
(4, 'Persistencia de Datos en Docker', 'Los contenedores Docker son efímeros por naturaleza, pero nuestros datos deben persistir. Para esto usamos volúmenes Docker que almacenan los datos fuera del contenedor. En este proyecto, tanto la base de datos MySQL como los archivos subidos se almacenan en volúmenes persistentes.'),
(1, 'Mejores Prácticas con Docker', 'Al trabajar con Docker es importante seguir ciertas mejores prácticas: usar imágenes oficiales cuando sea posible, mantener las imágenes pequeñas, no ejecutar procesos como root, usar .dockerignore, etiquetar las imágenes apropiadamente y mantener los contenedores sin estado cuando sea posible.');

-- Insertar comentarios de ejemplo
INSERT INTO comments (post_id, user_id, content) VALUES
(1, 2, '¡Excelente proyecto! Me encanta cómo integra todas estas tecnologías.'),
(1, 3, 'Muy útil para aprender Docker. ¿Tienes el código en GitHub?'),
(2, 1, 'Gran explicación de Docker. Me ayudó mucho a entenderlo mejor.'),
(2, 4, 'Docker ha cambiado completamente mi flujo de trabajo de desarrollo.'),
(3, 1, 'Los microservicios son el futuro del desarrollo de software.'),
(4, 2, 'Docker Compose es increíblemente poderoso y fácil de usar.'),
(5, 3, 'Redis es asombroso. La diferencia de rendimiento es notable.'),
(6, 4, 'Nginx es mi servidor web favorito. Muy eficiente.'),
(7, 1, 'Los volúmenes Docker son esenciales para aplicaciones en producción.'),
(8, 2, '¡Gracias por compartir estas mejores prácticas!');

-- Mensaje de confirmación
SELECT 'Base de datos inicializada correctamente' AS mensaje;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_posts FROM posts;
SELECT COUNT(*) as total_comments FROM comments;
```

#### Archivo `proxy/nginx.conf`:

```nginx
events {
    worker_connections 1024;
}

http {
    # Configuración general
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    # Logs
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
    
    # Optimizaciones
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    
    # Servidor principal - Blog Frontend
    upstream blog_backend {
        server frontend:80;
    }
    
    # Servidor para phpMyAdmin
    upstream phpmyadmin_backend {
        server phpmyadmin:80;
    }
    
    # Configuración del servidor principal
    server {
        listen 80;
        server_name localhost;
        
        # Logs específicos
        access_log /var/log/nginx/blog_access.log;
        error_log /var/log/nginx/blog_error.log;
        
        # Proxy al frontend
        location / {
            proxy_pass http://blog_backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
        
        # Ruta para phpMyAdmin
        location /phpmyadmin/ {
            proxy_pass http://phpmyadmin_backend/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
        
        # Health check
        location /health {
            access_log off;
            return 200 "OK\n";
            add_header Content-Type text/plain;
        }
    }
}
```

---

### 🔹 Parte 1: Comprensión del Proyecto

#### Tarea 1.1: Análisis de la arquitectura

1. Estudia el diagrama de arquitectura proporcionado.

2. Responde en tu documentación:
   
    - ¿Cuántos servicios componen el sistema?
    - ¿Qué función cumple cada servicio?
    - ¿Cómo se comunican los servicios entre sí?
    - ¿Por qué usar un proxy inverso?
    - ¿Qué ventajas tiene esta arquitectura?

3. Dibuja tu propio diagrama de flujo mostrando:
   
    - Cómo una petición HTTP llega al sistema
    - Qué servicios involucra
    - Cómo se accede a los datos
    - Cómo funciona el sistema de caché

#### Tarea 1.2: Análisis del código

1. Lee detenidamente todo el código PHP proporcionado.

2. Identifica y documenta:
   
    **En index.php:**
    - ¿Cómo se conecta a la base de datos?
    - ¿Cómo funciona el sistema de caché con Redis?
    - ¿Qué pasa si Redis no está disponible?
    - ¿Cómo se obtienen las estadísticas?
   
    **En database.php y redis.php:**
    - ¿Cómo se leen las variables de entorno?
    - ¿Qué valores por defecto se usan?
    - ¿Cómo se maneja el error de conexión?
   
    **En init.sql:**
    - ¿Qué relaciones hay entre las tablas?
    - ¿Qué índices se crean y por qué?
    - ¿Cuántos datos de ejemplo se insertan?

---

### 🔹 Parte 2: Construcción de Imágenes Docker

#### Tarea 2.1: Imagen del Frontend

Crea un Dockerfile para el servicio frontend que:

1. Use una imagen base apropiada (php con apache o nginx).
2. Instale las extensiones PHP necesarias:
   
    - `pdo`
    - `pdo_mysql`
    - `redis`

3. Copie el código de la aplicación al directorio correcto.
4. Configure las variables de entorno necesarias.
5. Exponga el puerto apropiado.

**Estructura del proyecto frontend:**
```
frontend/
├── Dockerfile
├── public/
│   └── index.php
└── config/
    ├── database.php
    └── redis.php
```

#### Tarea 2.2: Construcción de la imagen

1. Construye la imagen del frontend:
   
    - Nombre: `tu_usuario/microblog-frontend`
    - Etiqueta: `v1.0`

2. Verifica que la imagen se construyó correctamente.

3. Documenta el tamaño de la imagen.

---

### 🔹 Parte 3: Configuración con Docker Compose

#### Tarea 3.1: Diseño del docker-compose.yml

Crea un archivo `docker-compose.yml` que defina todos los servicios:

**Servicios a definir:**

1. **proxy** (Nginx)
   
    - Imagen oficial de Nginx
    - Puerto 80 del host
    - Montar configuración nginx.conf
    - Depende de frontend y phpmyadmin

2. **frontend**
   
    - Tu imagen construida
    - Variables de entorno para BD y Redis
    - Depende de db y redis

3. **db** (MariaDB)
   
    - Imagen oficial de MariaDB
    - Variables de entorno para configuración
    - Volumen para persistencia de datos
    - Montar script init.sql para inicialización

4. **redis**
   
    - Imagen oficial de Redis
    - (Opcional) Volumen para persistencia

5. **phpmyadmin**
   
    - Imagen oficial de phpMyAdmin
    - Variables de entorno para conectar a db
    - Depende de db

**Redes:**
- Define una red personalizada para todos los servicios

**Volúmenes:**
- Volumen para datos de MySQL
- (Opcional) Volumen para datos de Redis

#### Tarea 3.2: Variables de entorno

Crea un archivo `.env` con todas las configuraciones:

```env
# Base de Datos
MYSQL_ROOT_PASSWORD=rootpassword_seguro
MYSQL_DATABASE=blogdb
MYSQL_USER=bloguser
MYSQL_PASSWORD=blogpass_seguro

# Configuración del Frontend
DB_HOST=db
DB_NAME=blogdb
DB_USER=bloguser
DB_PASS=blogpass_seguro
REDIS_HOST=redis
REDIS_PORT=6379

# phpMyAdmin
PMA_HOST=db
PMA_USER=bloguser
PMA_PASSWORD=blogpass_seguro

# Puertos
PROXY_PORT=80
PHPMYADMIN_PORT=8081
```

---

### 🔹 Parte 4: Despliegue y Pruebas

#### Tarea 4.1: Primer despliegue

1. Asegúrate de tener la estructura completa:

```
microblog-project/
├── docker-compose.yml
├── .env
├── frontend/
│   ├── Dockerfile
│   ├── public/
│   │   └── index.php
│   └── config/
│       ├── database.php
│       └── redis.php
├── database/
│   └── init.sql
└── proxy/
    └── nginx.conf
```

2. Construye todas las imágenes necesarias.

3. Despliega el sistema completo con Docker Compose.

4. Observa los logs de todos los servicios:
   
    - ¿Se inició correctamente cada servicio?
    - ¿Hay errores?
    - ¿La base de datos se inicializó?

#### Tarea 4.2: Verificación funcional

1. **Acceso al blog:**
   
    - Accede a `http://localhost`
    - Verifica que se muestran los posts
    - Verifica que las estadísticas son correctas
    - Verifica la información del sistema

2. **Acceso a phpMyAdmin:**
   
    - Accede a `http://localhost/phpmyadmin`
    - Inicia sesión con las credenciales configuradas
    - Explora las tablas creadas
    - Verifica los datos insertados

3. **Verificación de caché:**
   
    - Primera carga: datos desde BD
    - Segunda carga: datos desde caché
    - Observa la diferencia en "Información del Sistema"

4. **Logs y monitoreo:**
   
    - Revisa los logs de Nginx
    - Revisa los logs del frontend
    - Revisa los logs de MySQL

#### Tarea 4.3: Pruebas de persistencia

1. Desde phpMyAdmin, inserta un nuevo post manualmente.

2. Recarga la página del blog y verifica que aparece.

3. Detén todos los contenedores.

4. Vuelve a iniciarlos.

5. Verifica que:
   
    - Todos los posts siguen ahí
    - Los datos persisten
    - El sistema funciona correctamente

---

### 🔹 Parte 5: Funcionalidades Adicionales (Ampliación)

#### Tarea 5.1: Página de detalle de post

Crea un nuevo archivo `frontend/public/post.php` que:

1. Muestre el contenido completo de un post.
2. Muestre todos sus comentarios.
3. Incremente el contador de vistas.
4. Use caché de Redis para el post.

#### Tarea 5.2: API REST

Crea un servicio API separado:

1. Nuevo servicio en docker-compose.yml.
2. Endpoints REST:
   
    - `GET /api/posts` - Listar posts
    - `GET /api/posts/:id` - Obtener post
    - `POST /api/posts` - Crear post
    - `GET /api/stats` - Estadísticas del sistema

3. Documentación de la API.

#### Tarea 5.3: Monitoreo

Añade un servicio de monitoreo:

1. **Opción 1:** Añadir un contenedor con Grafana + Prometheus
2. **Opción 2:** Crear un dashboard simple en PHP
3. Métricas a mostrar:
   
    - Número de peticiones
    - Tiempo de respuesta
    - Estado de los servicios
    - Uso de caché

---

### 🔹 Parte 6: Optimización y Escalado

#### Tarea 6.1: Optimización de imágenes

1. Optimiza tu Dockerfile del frontend:
   
    - Usa multi-stage build si es posible
    - Reduce el tamaño de la imagen
    - Compara el tamaño antes y después

2. Implementa .dockerignore apropiado.

3. Documenta las mejoras obtenidas.

#### Tarea 6.2: Healthchecks

Añade healthchecks a todos los servicios:

**Frontend:**
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost/health"]
  interval: 30s
  timeout: 10s
  retries: 3
```

**Base de datos:**
```yaml
healthcheck:
  test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
  interval: 10s
  timeout: 5s
  retries: 3
```

Investiga y configura healthchecks para Redis y Nginx.

#### Tarea 6.3: Escalado horizontal

1. Escala el servicio frontend a 3 réplicas:

```bash
docker compose up -d --scale frontend=3
```

2. Observa cómo Nginx balancea la carga.

3. Verifica que todas las réplicas funcionan correctamente.

4. Documenta el comportamiento observado.

---

### 🔹 Parte 7: Seguridad

#### Tarea 7.1: Mejoras de seguridad

Implementa las siguientes mejoras:

1. **Variables de entorno sensibles:**
   
    - No incluir .env en el repositorio
    - Usar Docker secrets (modo swarm) o variables cifradas

2. **Contraseñas seguras:**
   
    - Generar contraseñas fuertes
    - Cambiar contraseñas por defecto

3. **Usuario no root:**
   
    - Modificar Dockerfile para no ejecutar como root
    - Configurar permisos apropiados

4. **Red segmentada:**
   
    - Crear redes separadas (frontend-backend, backend-db)
    - Limitar comunicación entre servicios

#### Tarea 7.2: Auditoría de seguridad

1. Usa herramientas de análisis:

```bash
docker scan tu_usuario/microblog-frontend:v1.0
```

2. Revisa vulnerabilidades encontradas.

3. Corrige las vulnerabilidades críticas.

4. Documenta el proceso.

---

### 🔹 Parte 8: Documentación y Entrega

#### Tarea 8.1: Documentación técnica

Crea una documentación completa que incluya:

1. **README.md principal:**
   
    - Descripción del proyecto
    - Arquitectura del sistema
    - Requisitos previos
    - Instrucciones de instalación
    - Instrucciones de uso
    - Troubleshooting común

2. **Documentación de arquitectura:**
   
    - Diagramas actualizados
    - Descripción de cada servicio
    - Flujo de datos
    - Decisiones de diseño

3. **Guía de despliegue:**
   
    - Paso a paso detallado
    - Comandos necesarios
    - Verificación de cada paso
    - Rollback si algo falla

#### Tarea 8.2: Respuestas a preguntas de reflexión

Responde detalladamente:

1. **Sobre la arquitectura:**
   
    - ¿Por qué elegiste esta arquitectura?
    - ¿Qué beneficios tiene sobre una arquitectura monolítica?
    - ¿Qué desafíos presenta?
    - ¿Cómo la mejorarías para producción?

2. **Sobre Docker:**
   
    - ¿Qué ventajas ofrece Docker para este proyecto?
    - ¿Qué aprendiste sobre construcción de imágenes?
    - ¿Qué dificultades encontraste?
    - ¿Cómo las resolviste?

3. **Sobre persistencia:**
   
    - ¿Cómo garantizas que los datos no se pierdan?
    - ¿Qué estrategia de backup implementarías?
    - ¿Cómo migrarías datos entre entornos?

4. **Sobre escalabilidad:**
   
    - ¿El sistema puede escalar horizontalmente?
    - ¿Qué servicios son stateless y cuáles stateful?
    - ¿Cómo manejarías mayor carga?
    - ¿Qué cuellos de botella identificas?

5. **Sobre monitoreo:**
   
    - ¿Cómo sabrías si un servicio falla?
    - ¿Qué métricas son importantes monitorear?
    - ¿Cómo implementarías alertas?

---

## Entregables

### 1. Código del Proyecto

```
microblog-project/
├── README.md
├── docker-compose.yml
├── .env.example
├── frontend/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── public/
│   │   ├── index.php
│   │   ├── post.php (opcional)
│   │   └── new-post.php (opcional)
│   └── config/
│       ├── database.php
│       └── redis.php
├── api/ (opcional)
│   ├── Dockerfile
│   └── ...
├── database/
│   └── init.sql
├── proxy/
│   └── nginx.conf
└── docs/
    ├── ARCHITECTURE.md
    ├── DEPLOYMENT.md
    └── API.md (si aplica)
```

### 2. Documentación (PDF o Markdown)

- **Portada** con título, autor, fecha
- **Índice**
- **Introducción** al proyecto
- **Análisis de arquitectura** con diagramas
- **Dockerfiles** comentados
- **docker-compose.yml** comentado
- **Proceso de construcción** con capturas
- **Proceso de despliegue** paso a paso
- **Pruebas realizadas** con capturas:
    - Blog funcionando
    - phpMyAdmin
    - Caché funcionando
    - Persistencia verificada
    - Escalado (si lo hiciste)
- **Optimizaciones** implementadas
- **Medidas de seguridad** aplicadas
- **Problemas encontrados** y soluciones
- **Respuestas** a todas las preguntas
- **Conclusiones** y aprendizajes

### 3. Capturas de Pantalla

Mínimo:

- Arquitectura del sistema (diagrama)
- Blog frontend funcionando
- phpMyAdmin con datos
- Información del sistema mostrando caché
- Logs de servicios
- Docker ps mostrando todos los contenedores
- Docker images mostrando las imágenes
- Verificación de persistencia
- (Opcional) Servicio escalado
- (Opcional) Healthchecks funcionando

---

## Evaluación

### Criterios de evaluación (100 puntos):

**Arquitectura y Diseño (20 puntos):**
- Diseño correcto de la arquitectura multi-servicio
- Uso apropiado de redes y comunicación entre servicios
- Documentación de decisiones de diseño

**Construcción de Imágenes (20 puntos):**
- Dockerfile correcto y optimizado
- Imagen funcional con todas las dependencias
- Buenas prácticas aplicadas

**Orquestación con Docker Compose (20 puntos):**
- docker-compose.yml completo y funcional
- Correcta definición de servicios, redes y volúmenes
- Uso apropiado de variables de entorno

**Funcionalidad (20 puntos):**
- Todos los servicios funcionan correctamente
- Comunicación entre servicios operativa
- Sistema de caché funcionando
- Persistencia de datos verificada

**Documentación (15 puntos):**
- Documentación completa y clara
- Diagramas de arquitectura
- Instrucciones reproducibles
- Respuestas a preguntas de reflexión

**Extras y Mejoras (5 puntos):**
- Funcionalidades adicionales implementadas
- Optimizaciones aplicadas
- Medidas de seguridad
- Escalado implementado

---

## Condiciones de Entrega

- **Formato:** Repositorio Git (GitHub/GitLab) + Documentación PDF
- **Plazo:** Según lo publicado en Moodle
- **Requisitos:**
    - El sistema debe funcionar completamente
    - Debe poder desplegarse con un solo comando
    - Todos los servicios deben estar operativos
    - La documentación debe ser clara y completa

---

## Recursos de Apoyo

### Documentación oficial:
- Docker: [https://docs.docker.com/](https://docs.docker.com/)
- Docker Compose: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
- PHP: [https://www.php.net/manual/es/](https://www.php.net/manual/es/)
- Nginx: [https://nginx.org/en/docs/](https://nginx.org/en/docs/)
- MariaDB: [https://mariadb.com/kb/en/](https://mariadb.com/kb/en/)
- Redis: [https://redis.io/documentation](https://redis.io/documentation)

### Imágenes Docker:
- PHP: [https://hub.docker.com/_/php](https://hub.docker.com/_/php)
- Nginx: [https://hub.docker.com/_/nginx](https://hub.docker.com/_/nginx)
- MariaDB: [https://hub.docker.com/_/mariadb](https://hub.docker.com/_/mariadb)
- Redis: [https://hub.docker.com/_/redis](https://hub.docker.com/_/redis)
- phpMyAdmin: [https://hub.docker.com/_/phpmyadmin](https://hub.docker.com/_/phpmyadmin)

### Tutoriales recomendados:
- Docker Multi-Container Apps: [https://docs.docker.com/get-started/07_multi_container/](https://docs.docker.com/get-started/07_multi_container/)
- Networking in Compose: [https://docs.docker.com/compose/networking/](https://docs.docker.com/compose/networking/)
- PHP Extensions: [https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions)

---

## 🎯 Consejos Finales

1. **Empieza simple:** Primero haz que funcione, luego optimiza.
2. **Prueba frecuentemente:** No esperes a tenerlo todo para probar.
3. **Lee los logs:** Los logs te dirán qué está fallando.
4. **Documenta mientras trabajas:** No dejes la documentación para el final.
5. **Pregunta si tienes dudas:** Es mejor preguntar que ir por el camino equivocado.
6. **Haz commits frecuentes:** Usa Git para guardar tu progreso.
7. **Sé creativo:** Siéntete libre de añadir funcionalidades extra.

---

### Presentación del proyecto

[:fontawesome-solid-file-pdf: Ver presentación](https://revilofe.github.io/slides/section4-daw/DAW-U2.-ProyectoFinal.html){ .md-button }

---

## 🚀 ¡Éxito con tu proyecto!

Este proyecto integrará todo lo aprendido en la unidad. Tómate tu tiempo, trabaja con cuidado y disfruta del proceso de crear un sistema completo con Docker.
