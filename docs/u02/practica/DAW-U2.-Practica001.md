# Práctica 2.1: Despliegue de WordPress con MariaDB

### Descripción

**Actividad:** *Despliegue de WordPress con MariaDB*

En esta práctica desplegarás un **CMS (Sistema de Gestión de Contenidos)** completo utilizando WordPress, una de las plataformas más populares para la creación de sitios web. Este despliegue requiere la integración de dos contenedores: un servidor web con WordPress y una base de datos MariaDB.

#### Objetivo general

Aprender a:

- Desplegar aplicaciones web complejas con dependencias de base de datos.
- Integrar múltiples servicios mediante redes Docker.
- Gestionar persistencia de datos tanto de la aplicación como de la base de datos.
- Configurar aplicaciones mediante múltiples variables de entorno.
- Comprender el ciclo de vida de aplicaciones con estado y base de datos.
- Trabajar con volúmenes para datos críticos.

---

### Contexto de trabajo

**WordPress** es un CMS de código abierto que permite crear y gestionar sitios web de forma sencilla. Para su funcionamiento requiere:

**Componentes de la arquitectura:**

1. **Servidor Web + WordPress:**
   
    - Servidor web Apache con PHP y WordPress instalado.
    - Escucha en el puerto 80/tcp.
    - Almacena contenido en `/var/www/html/wp-content`.
    - Imagen Docker: `wordpress`

2. **Base de datos MariaDB:**
   
    - Sistema de gestión de base de datos relacional.
    - Escucha en el puerto 3306/tcp.
    - Almacena datos en `/var/lib/mysql`.
    - Imagen Docker: `mariadb`

**Características importantes:**

- WordPress necesita conectarse a la base de datos para almacenar contenido, usuarios, configuraciones, etc.
- Ambos servicios requieren persistencia de datos mediante volúmenes.
- La comunicación entre servicios se realiza mediante red Docker interna.

---

### 🔹 Parte 1: Despliegue básico de WordPress

#### Tarea 1.1: Preparación del entorno

1. Crea una red Docker personalizada llamada `red_wp` para la comunicación entre los contenedores.

2. Crea los directorios en el host para la persistencia de datos:
   
    - `/opt/mysql_wp` - Para los datos de MariaDB
    - `/opt/wordpress` - Para el contenido de WordPress

3. Investiga en Docker Hub la documentación de las imágenes:
   
    - `mariadb` - Identifica las variables de entorno necesarias
    - `wordpress` - Identifica las variables de entorno de configuración

#### Tarea 1.2: Despliegue del contenedor de base de datos

1. Despliega el contenedor de MariaDB con las siguientes características:
   
    - Nombre del contenedor: `servidor_mysql`
    - Conectado a la red `red_wp`
    - Volumen montado desde `/opt/mysql_wp` del host a `/var/lib/mysql` del contenedor
    - Variables de entorno necesarias:
        - Nombre de la base de datos: `bd_wp`
        - Usuario de la base de datos: `user_wp`
        - Contraseña del usuario: (elige una segura)
        - Contraseña del usuario root: (elige una segura)
    - Ejecutando en modo daemon

2. Verifica que el contenedor está en ejecución.

3. Inspecciona los logs del contenedor para ver el proceso de inicialización de la base de datos.

#### Tarea 1.3: Despliegue del contenedor de WordPress

1. Despliega el contenedor de WordPress con las siguientes características:
   
    - Nombre del contenedor: `servidor_wp`
    - Conectado a la red `red_wp`
    - Volumen montado desde `/opt/wordpress` del host a `/var/www/html/wp-content` del contenedor
    - Puerto 80 del host mapeado al puerto 80 del contenedor
    - Variables de entorno necesarias:
        - Host de la base de datos: (nombre del contenedor de MariaDB)
        - Usuario de la base de datos
        - Contraseña de la base de datos
        - Nombre de la base de datos
    - Ejecutando en modo daemon

2. Verifica que el contenedor está en ejecución.

3. Accede a WordPress desde tu navegador (http://localhost).

#### Tarea 1.4: Instalación y configuración de WordPress

1. Completa la instalación de WordPress desde el navegador:
   
    - Título del sitio
    - Usuario administrador
    - Contraseña del administrador
    - Correo electrónico

2. Accede al panel de administración de WordPress.

3. Crea al menos:
   
    - 2 páginas
    - 3 entradas (posts)
    - 1 categoría personalizada

4. Instala y activa un tema diferente al predeterminado.

5. Instala al menos un plugin.

---

### 🔹 Parte 2: Verificación de la persistencia

#### Tarea 2.1: Persistencia de WordPress

1. Detén y elimina el contenedor `servidor_wp` (NO elimines el volumen).

2. Verifica el contenido del directorio `/opt/wordpress` en el host.

3. Vuelve a crear el contenedor `servidor_wp` con la misma configuración.

4. Accede a WordPress y verifica que:
   
    - Todo el contenido creado sigue presente
    - El tema instalado sigue activo
    - Los plugins siguen instalados

#### Tarea 2.2: Persistencia de la base de datos

1. Detén y elimina ambos contenedores (NO elimines los volúmenes).

2. Verifica el contenido del directorio `/opt/mysql_wp` en el host.

3. Vuelve a crear ambos contenedores con la misma configuración.

4. Accede a WordPress y verifica que toda la información se mantiene.

---

### 🔹 Parte 3: Análisis de la arquitectura

#### Tarea 3.1: Comunicación entre contenedores

1. Desde el contenedor de WordPress, verifica la conectividad con la base de datos:
   
    - Realiza un ping al contenedor de MariaDB
    - Verifica que se puede resolver el nombre del contenedor de base de datos

2. Intenta acceder al puerto 3306 del contenedor de MariaDB desde el contenedor de WordPress.

3. Reflexiona sobre por qué WordPress puede acceder a MariaDB sin que este último tenga puertos expuestos al host.

#### Tarea 3.2: Variables de entorno y configuración automática

1. Inspecciona el archivo `wp-config.php` dentro del contenedor de WordPress.

2. Verifica que las credenciales de la base de datos coinciden con las variables de entorno que definiste.

3. Investiga qué hace el script `docker-entrypoint.sh` en ambos contenedores.

---

### 🔹 Parte 4: Configuración avanzada

#### Tarea 4.1: Cambio del nombre del servidor de base de datos

1. Elimina ambos contenedores (mantén la red y los volúmenes).

2. Crea el contenedor de MariaDB con un nombre diferente, por ejemplo `mariadb_wordpress`.

3. Modifica la configuración del contenedor de WordPress para que se conecte al nuevo nombre del servidor de base de datos.

4. Verifica que WordPress funciona correctamente.

#### Tarea 4.2: Exposición de la base de datos

1. Recrea el contenedor de MariaDB exponiendo su puerto 3306 al host (por ejemplo, en el puerto 3307).

2. Utiliza un cliente de base de datos (MySQL Workbench, DBeaver, o `mysql` desde línea de comandos) para conectarte a la base de datos desde tu host.

3. Explora las tablas creadas por WordPress.

4. Identifica dónde se almacenan:
   
    - Los posts/entradas
    - Las páginas
    - Los usuarios
    - Las opciones de configuración

---

### 🔹 Parte 5: Análisis y documentación

#### Tarea 5.1: Preguntas de análisis

Responde a las siguientes preguntas en tu documentación:

1. **Arquitectura de la aplicación:**
   
    - ¿Por qué WordPress necesita una base de datos?
    - ¿Qué tipo de datos se almacenan en la base de datos vs. en el volumen de WordPress?
    - ¿Cómo se comunican WordPress y MariaDB?

2. **Persistencia de datos:**
   
    - ¿Qué pasaría si no usáramos volúmenes?
    - ¿Por qué es crítico hacer backups de ambos volúmenes?
    - ¿Qué estrategias de backup recomendarías para un WordPress en producción?

3. **Seguridad:**
   
    - ¿Es necesario exponer el puerto de MariaDB al host? ¿Por qué?
    - ¿Qué riesgos de seguridad existen al exponer la base de datos?
    - ¿Cómo mejorarías la seguridad de este despliegue?

4. **Scripts de inicialización:**
   
    - ¿Qué función cumple el `docker-entrypoint.sh` en MariaDB?
    - ¿Qué función cumple el `docker-entrypoint.sh` en WordPress?
    - ¿En qué momento se crea el archivo `wp-config.php`?

5. **Comparación con prácticas anteriores:**
   
    - ¿En qué se diferencia este despliegue de Guestbook?
    - ¿En qué se diferencia de la aplicación Temperaturas?
    - ¿Cuál es más compleja de mantener y por qué?

6. **Escalabilidad y alta disponibilidad:**
   
    - ¿Se podría ejecutar múltiples instancias de WordPress conectadas a la misma base de datos?
    - ¿Cómo se podría implementar alta disponibilidad en la base de datos?
    - ¿Qué limitaciones tiene este despliegue para un entorno de producción?

#### Tarea 5.2: Comandos utilizados

Documenta todos los comandos Docker utilizados para:

- Crear la red y los directorios
- Desplegar y gestionar el contenedor de MariaDB
- Desplegar y gestionar el contenedor de WordPress
- Verificar logs y estado de los contenedores
- Inspeccionar la configuración de red
- Acceder y consultar la base de datos

---

## Entregables

1. **Documentación en formato Markdown** que incluya:
   
    - Todos los comandos utilizados en cada tarea
    - Capturas de pantalla que demuestren:
        - WordPress funcionando en el navegador
        - Panel de administración de WordPress
        - Contenido creado (páginas, posts, tema, plugins)
        - Lista de contenedores en ejecución
        - Inspección de la red Docker
        - Estructura de directorios de los volúmenes
        - Conexión a la base de datos y exploración de tablas
    - Respuestas detalladas a todas las preguntas de análisis
    - Comparación con las prácticas anteriores (Guestbook y Temperaturas)

---

### Evaluación

Se evaluará:

- La correcta implementación de la arquitectura completa.
- El funcionamiento de WordPress con todos sus componentes.
- La demostración de persistencia de datos en ambos servicios.
- La exploración de la base de datos.
- La profundidad del análisis técnico.
- La claridad y completitud de la documentación.
- La comparación crítica entre diferentes arquitecturas de aplicaciones.

---

### Condiciones de entrega

Las publicadas en la plataforma Moodle del curso.

---

### Recursos de apoyo

- Documentación oficial de Docker: [https://docs.docker.com](https://docs.docker.com)
- Imagen MariaDB en Docker Hub: [https://hub.docker.com/_/mariadb](https://hub.docker.com/_/mariadb)
- Imagen WordPress en Docker Hub: [https://hub.docker.com/_/wordpress](https://hub.docker.com/_/wordpress)
- Documentación de WordPress: [https://wordpress.org/support/](https://wordpress.org/support/)
- Volúmenes en Docker: [https://docs.docker.com/storage/volumes/](https://docs.docker.com/storage/volumes/)
- Docker Compose: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
- Variables de entorno en Docker: [https://docs.docker.com/engine/reference/commandline/run/#env](https://docs.docker.com/engine/reference/commandline/run/#env)

