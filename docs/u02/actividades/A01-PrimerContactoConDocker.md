<!-- ---
title: "UD 2 - P0: Primer contacto con Docker"
description: "Instalación de Docker y primeros pasos con contenedores e imágenes"
summary: "Actividad práctica inicial para instalar Docker y familiarizarse con comandos básicos de contenedores e imágenes."
authors:
    - Eduardo Fdez
date: 2025-01-12
icon: "material/file-document-edit"
permalink: /daw/unidad2/p2.0
categories:
    - DAW
tags:
    - Docker
    - Instalación
    - Contenedores
    - Imágenes
    - Primeros pasos
--- -->

# Primer contacto con Docker

### Descripción

**Actividad:** *Instalación de Docker y primeros pasos*

Esta es tu primera toma de contacto con Docker. En esta práctica aprenderás a instalar Docker en tu sistema, comprenderás las diferencias entre Docker Engine y Docker Desktop, y realizarás tus primeras operaciones con contenedores e imágenes.

#### Objetivo general

Aprender a:

- Instalar y configurar Docker en tu sistema operativo.
- Comprender las diferencias entre Docker Engine y Docker Desktop.
- Ejecutar tus primeros contenedores.
- Gestionar imágenes desde Docker Hub.
- Utilizar comandos básicos de Docker.
- Entender el ciclo de vida de los contenedores.

---

## 🔧 Parte 1: Instalación de Docker

### 1.1. Docker Engine vs Docker Desktop

Antes de instalar Docker, es importante entender las diferencias entre las dos opciones principales:

#### **Docker Engine**

Docker Engine es el motor de contenedores de código abierto que ejecuta los contenedores.

**Características:**

- ✅ Software base y fundamental de Docker
- ✅ Se instala directamente en el sistema operativo
- ✅ Funciona principalmente mediante línea de comandos (CLI)
- ✅ Ligero y eficiente
- ✅ Ideal para servidores Linux
- ✅ Disponible para Linux únicamente (nativo)

**Componentes principales:**

- **dockerd**: Demonio de Docker (proceso en segundo plano)
- **docker CLI**: Interfaz de línea de comandos
- **containerd**: Runtime de contenedores
- **runc**: Herramienta de bajo nivel para ejecutar contenedores

**Cuándo usar Docker Engine:**

- Servidores Linux en producción
- Entornos CI/CD
- Cuando solo necesitas el motor sin interfaz gráfica
- Recursos limitados (consume menos memoria)

---

#### **Docker Desktop**

Docker Desktop es una aplicación completa que incluye Docker Engine y herramientas adicionales.

**Características:**

- ✅ Incluye Docker Engine + herramientas adicionales
- ✅ Interfaz gráfica (GUI) para gestión visual
- ✅ Disponible para Windows, macOS y Linux
- ✅ Integración con el sistema operativo
- ✅ Fácil instalación y configuración
- ✅ Incluye Docker Compose integrado
- ✅ Kubernetes opcional (cluster local)

**Componentes adicionales:**

- **GUI Dashboard**: Interfaz gráfica para gestionar contenedores
- **Docker Compose**: Herramienta para aplicaciones multi-contenedor
- **Docker Extensions**: Sistema de extensiones
- **Máquina virtual integrada**: En Windows/Mac (usa WSL2 o HyperKit)
- **Sincronización de archivos**: Entre host y contenedores
- **Actualizaciones automáticas**: Gestión simplificada

**Cuándo usar Docker Desktop:**

- Entornos de desarrollo en Windows o macOS
- Si prefieres interfaz gráfica
- Aprendizaje inicial de Docker
- Desarrollo local de aplicaciones
- Testing rápido de aplicaciones

---

#### **Comparación resumida**

| Característica | Docker Engine | Docker Desktop |
|----------------|---------------|----------------|
| **Sistema operativo** | Solo Linux (nativo) | Windows, macOS, Linux |
| **Interfaz gráfica** | ❌ No | ✅ Sí |
| **Línea de comandos** | ✅ Sí | ✅ Sí |
| **Docker Compose** | Requiere instalación separada | ✅ Incluido |
| **Kubernetes** | Requiere instalación separada | ✅ Opcional incluido |
| **Consumo de recursos** | Bajo | Medio-Alto |
| **Facilidad de instalación** | Media | Alta |
| **Ideal para** | Servidores, producción | Desarrollo, aprendizaje |
| **Licencia** | Gratuita (Apache 2.0) | Gratuita para uso personal/educativo |

---

### 1.2. Instalación en Linux (Docker Engine)

Si trabajas en Linux, instalarás Docker Engine directamente en el sistema.

#### **Paso 1: Eliminar versiones antiguas (si existen)**

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```

#### **Paso 2: Actualizar repositorios e instalar dependencias**

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
```

#### **Paso 3: Añadir la clave GPG oficial de Docker**

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

#### **Paso 4: Añadir el repositorio de Docker**

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### **Paso 5: Instalar Docker Engine**

```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### **Paso 6: Añadir tu usuario al grupo docker**

Para ejecutar Docker sin `sudo`:

```bash
sudo usermod -aG docker $USER
```

**Importante:** Cierra sesión y vuelve a iniciarla para que los cambios surtan efecto, o ejecuta:

```bash
su - $USER
```

#### **Paso 7: Verificar la instalación**

```bash
docker --version
docker compose version
```

Deberías ver algo similar a:

```
Docker version 24.0.7, build afdd53b
Docker Compose version v2.20.2
```

#### **Paso 8: Probar que Docker funciona**

```bash
docker run hello-world
```

Si ves un mensaje de bienvenida, ¡Docker está funcionando correctamente! 🎉

---

### 1.3. Instalación en Windows (Docker Desktop)

Si trabajas en Windows, instalarás Docker Desktop.

#### **Requisitos previos**

- Windows 10/11 Pro, Enterprise o Education (64-bit)
- Virtualización habilitada en BIOS
- WSL 2 (Windows Subsystem for Linux 2)

#### **Paso 1: Habilitar WSL 2**

1. Abre PowerShell como Administrador y ejecuta:

```powershell
wsl --install
```

2. Reinicia el equipo cuando se te solicite.

3. Verifica la instalación de WSL 2:

```powershell
wsl --list --verbose
```

#### **Paso 2: Descargar Docker Desktop**

1. Ve a la página oficial: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Descarga Docker Desktop para Windows
3. Ejecuta el instalador descargado (`Docker Desktop Installer.exe`)

#### **Paso 3: Instalar Docker Desktop**

1. Durante la instalación, asegúrate de marcar:
   - ✅ **Use WSL 2 instead of Hyper-V** (recomendado)
   - ✅ **Add shortcut to desktop** (opcional)

2. Completa la instalación y reinicia el equipo si se solicita

#### **Paso 4: Iniciar Docker Desktop**

1. Ejecuta Docker Desktop desde el menú de inicio
2. Espera a que el motor de Docker se inicie (verás un icono en la bandeja del sistema)
3. Cuando el icono muestre "Docker Desktop is running", está listo

#### **Paso 5: Configuración inicial**

1. Docker Desktop te pedirá:
   - Aceptar los términos de servicio
   - Opcionalmente crear/iniciar sesión con una cuenta de Docker Hub
   - Completar una breve encuesta (puedes omitirla)

#### **Paso 6: Verificar la instalación**

Abre PowerShell o Terminal y ejecuta:

```powershell
docker --version
docker compose version
```

#### **Paso 7: Probar Docker Desktop**

```powershell
docker run hello-world
```

Si ves el mensaje de bienvenida, ¡Docker Desktop está funcionando! 🎉

---

### 1.4. Instalación en macOS (Docker Desktop)

#### **Requisitos previos**

- macOS 10.15 o superior
- 4 GB de RAM mínimo (se recomiendan 8 GB)

#### **Paso 1: Descargar Docker Desktop**

1. Ve a [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Descarga Docker Desktop para Mac (elige tu arquitectura: Intel o Apple Silicon)

#### **Paso 2: Instalar**

1. Abre el archivo `.dmg` descargado
2. Arrastra el icono de Docker a la carpeta Aplicaciones
3. Abre Docker desde Aplicaciones
4. Sigue el asistente de configuración inicial

#### **Paso 3: Verificar**

```bash
docker --version
docker run hello-world
```

---

### 1.5. Verificación completa de la instalación

Independientemente de tu sistema operativo, ejecuta estos comandos para verificar que todo funciona:

```bash
# Verificar versión de Docker
docker --version

# Verificar información del sistema Docker
docker info

# Ver comandos disponibles
docker --help

# Ejecutar contenedor de prueba
docker run hello-world
```

**¿Qué deberías ver?**

- Versión de Docker instalada
- Información sobre el sistema Docker
- Lista de comandos disponibles
- Mensaje de bienvenida del contenedor hello-world

---

## 🐳 Parte 2: Primeros pasos con contenedores

### 2.1. Tu primer contenedor: Hello World

Ya ejecutaste este comando durante la instalación, pero analicémoslo en detalle:

```bash
docker run hello-world
```

**¿Qué sucede cuando ejecutas este comando?**

1. Docker busca la imagen `hello-world` localmente
2. Como no la encuentra, la descarga de Docker Hub
3. Crea un contenedor desde esa imagen
4. Ejecuta el contenedor (muestra un mensaje)
5. El contenedor finaliza automáticamente

**Salida esperada:**

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
...
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

---

### 2.2. Ejecutar un contenedor interactivo

Vamos a ejecutar un contenedor con una distribución Linux:

```bash
docker run -it ubuntu bash
```

**¿Qué hace cada parte?**

- `docker run`: Crea y ejecuta un contenedor
- `-it`: Modo interactivo con terminal
  - `-i`: Mantiene la entrada estándar abierta
  - `-t`: Asigna un pseudo-TTY (terminal)
- `ubuntu`: Imagen a utilizar
- `bash`: Comando a ejecutar (shell de bash)

**¿Qué puedes hacer ahora?**

Estás dentro de un contenedor Ubuntu. Prueba algunos comandos:

```bash
# Ver la versión del sistema operativo
cat /etc/os-release

# Ver el hostname del contenedor
hostname

# Listar archivos
ls -la

# Ver procesos en ejecución
ps aux

# Actualizar repositorios
apt-get update

# Instalar un programa
apt-get install -y curl

# Probar el programa instalado
curl --version

# Salir del contenedor
exit
```

**Observación importante:** Una vez que sales del contenedor (`exit`), todos los cambios se pierden. Volveremos sobre esto más adelante.

---

### 2.3. Ejecutar un contenedor en segundo plano

Vamos a ejecutar un servidor web Nginx:

```bash
docker run -d -p 8080:80 --name mi-nginx nginx
```

**¿Qué hace cada parte?**

- `-d`: Ejecuta en modo "detached" (segundo plano)
- `-p 8080:80`: Mapea el puerto 80 del contenedor al puerto 8080 del host
- `--name mi-nginx`: Asigna un nombre al contenedor
- `nginx`: Imagen a utilizar

**Verificar que funciona:**

1. Abre tu navegador web
2. Ve a: `http://localhost:8080`
3. Deberías ver la página de bienvenida de Nginx

---

### 2.4. Comandos básicos para gestionar contenedores

#### **Ver contenedores en ejecución**

```bash
docker ps
```

Deberías ver tu contenedor de Nginx.

**Columnas importantes:**

- `CONTAINER ID`: Identificador único del contenedor
- `IMAGE`: Imagen utilizada
- `COMMAND`: Comando ejecutado
- `CREATED`: Cuándo se creó
- `STATUS`: Estado actual
- `PORTS`: Puertos mapeados
- `NAMES`: Nombre del contenedor

#### **Ver todos los contenedores (incluyendo detenidos)**

```bash
docker ps -a
```

Ahora verás también el contenedor de Ubuntu y hello-world que ejecutaste antes.

#### **Ver logs de un contenedor**

```bash
docker logs mi-nginx
```

Para ver logs en tiempo real:

```bash
docker logs -f mi-nginx
```

(Presiona `Ctrl+C` para salir)

#### **Detener un contenedor**

```bash
docker stop mi-nginx
```

Verifica que se detuvo:

```bash
docker ps
```

Ya no debería aparecer. Pero si ejecutas `docker ps -a`, lo verás con estado "Exited".

#### **Iniciar un contenedor detenido**

```bash
docker start mi-nginx
```

Verifica que volvió a ejecutarse:

```bash
docker ps
```

#### **Reiniciar un contenedor**

```bash
docker restart mi-nginx
```

#### **Ver estadísticas de recursos**

```bash
docker stats mi-nginx
```

Verás uso de CPU, memoria, red y disco. Presiona `Ctrl+C` para salir.

#### **Inspeccionar un contenedor**

```bash
docker inspect mi-nginx
```

Muestra toda la información detallada en formato JSON.

#### **Ejecutar comandos dentro de un contenedor en ejecución**

```bash
docker exec -it mi-nginx bash
```

Ahora estás dentro del contenedor. Prueba:

```bash
# Ver procesos
ps aux

# Ver archivos de configuración de Nginx
cat /etc/nginx/nginx.conf

# Salir
exit
```

#### **Eliminar un contenedor**

Primero detenlo (si está en ejecución):

```bash
docker stop mi-nginx
```

Luego elimínalo:

```bash
docker rm mi-nginx
```

Verifica que se eliminó:

```bash
docker ps -a
```

**Atajo:** Forzar eliminación (detiene y elimina en un solo comando):

```bash
docker rm -f mi-nginx
```

---

## 📦 Parte 3: Trabajando con imágenes de Docker Hub

### 3.1. ¿Qué es Docker Hub?

**Docker Hub** es el registro público de imágenes Docker. Es como el "GitHub" de las imágenes de contenedores.

**URL:** [https://hub.docker.com](https://hub.docker.com)

**Contiene:**

- ✅ Imágenes oficiales (mantenidas por Docker y los proyectos)
- ✅ Imágenes de la comunidad
- ✅ Imágenes privadas (con cuenta de pago)

---

### 3.2. Buscar imágenes

#### **Buscar desde la línea de comandos**

```bash
docker search nginx
```

Muestra las 25 imágenes más populares relacionadas con "nginx".

**Columnas:**

- `NAME`: Nombre de la imagen
- `DESCRIPTION`: Descripción
- `STARS`: Popularidad (estrellas)
- `OFFICIAL`: Si es imagen oficial
- `AUTOMATED`: Si se construye automáticamente

#### **Buscar en el navegador web**

1. Ve a [https://hub.docker.com](https://hub.docker.com)
2. Busca "nginx" en el cuadro de búsqueda
3. Explora la imagen oficial: [nginx](https://hub.docker.com/_/nginx)

**Información útil en Docker Hub:**

- Descripción y documentación
- Etiquetas (tags) disponibles
- Uso y ejemplos
- Dockerfile (cómo se construyó la imagen)
- Número de descargas

---

### 3.3. Descargar imágenes

#### **Descargar una imagen**

```bash
docker pull nginx
```

Esto descarga la última versión (`latest`).

#### **Descargar una versión específica**

```bash
docker pull nginx:1.25
```

#### **Descargar diferentes variantes**

```bash
# Versión Alpine (más ligera)
docker pull nginx:alpine

# Versión específica con Alpine
docker pull nginx:1.25-alpine
```

---

### 3.4. Gestionar imágenes locales

#### **Ver imágenes descargadas**

```bash
docker images
```

**Columnas:**

- `REPOSITORY`: Nombre de la imagen
- `TAG`: Versión o etiqueta
- `IMAGE ID`: Identificador único
- `CREATED`: Cuándo se creó la imagen
- `SIZE`: Tamaño en disco

#### **Ver información detallada de una imagen**

```bash
docker inspect nginx
```

#### **Ver el historial de capas de una imagen**

```bash
docker history nginx
```

Muestra cómo se construyó la imagen capa por capa.

#### **Eliminar una imagen**

```bash
docker rmi nginx
```

**Nota:** No puedes eliminar una imagen si hay contenedores (incluso detenidos) que la utilizan.

#### **Eliminar imágenes no utilizadas**

```bash
# Eliminar imágenes "colgantes" (sin etiqueta)
docker image prune

# Eliminar todas las imágenes no utilizadas
docker image prune -a
```

---

## 🎯 Parte 4: Ejercicios prácticos

### Ejercicio 1: Explorar diferentes distribuciones Linux

**Objetivo:** Ejecutar contenedores de diferentes distribuciones Linux y explorarlas.

**Tareas:**

1. Ejecuta un contenedor de Debian

2. Dentro del contenedor, identifica:
   - La versión del sistema operativo
   - El hostname
   - Los procesos

3. Sal del contenedor

4. Repite el proceso con
   - Ubuntu
   - Alpine Linux
   - CentOS

5. Compara los tamaños de las imágenes:
 

**Pregunta:** ¿Cuál es la distribución más ligera? ¿Por qué crees que es así?

---

### Ejercicio 2: Servidor web Apache

**Objetivo:** Ejecutar un servidor web Apache y personalizarlo.

**Tareas:**

1. Ejecuta un contenedor de Apache:
2. Accede a `http://localhost:8081` en tu navegador. Deberías ver "It works!"
3. Personaliza la página:
   ```bash
   docker exec -it mi-apache bash
   ```
4. Dentro del contenedor:
   ```bash
   echo "<h1>Hola desde Docker!</h1>" > /usr/local/apache2/htdocs/index.html
   exit
   ```
5. Recarga la página en tu navegador. ¿Qué ves ahora?
6. Detén y elimina el contenedor
7. Vuelve a crear el contenedor
8. Accede nuevamente a `http://localhost:8081`

**Pregunta:** ¿Por qué volvió a aparecer "It works!" en lugar de tu mensaje personalizado?

---

### Ejercicio 3: Base de datos MySQL

**Objetivo:** Ejecutar una base de datos MySQL y conectarte a ella.

**Tareas:**

1. Ejecuta un contenedor de MySQL:
   ```bash
   docker run -d -p 3306:3306 --name mi-mysql -e MYSQL_ROOT_PASSWORD=mipassword mysql
   ```
2. Espera unos segundos a que MySQL se inicie. Verifica los logs.
3. Conéctate a MySQL:
   ```bash
   docker exec -it mi-mysql mysql -uroot -pmipassword
   ```
4. Dentro de MySQL, ejecuta:
   ```sql
   SHOW DATABASES;
   CREATE DATABASE prueba;
   USE prueba;
   CREATE TABLE usuarios (id INT, nombre VARCHAR(50));
   INSERT INTO usuarios VALUES (1, 'Juan');
   SELECT * FROM usuarios;
   EXIT;
   ```
5. Detén y elimina el contenedor:
   ```bash
   docker stop mi-mysql
   docker rm mi-mysql
   ```
6. Vuelve a crear el contenedor con el mismo comando del paso 1.
7. Conéctate nuevamente y verifica:
   ```bash
   docker exec -it mi-mysql mysql -uroot -pmipassword
   ```
8. Dentro de MySQL:
   ```sql
   SHOW DATABASES;
   ```
**Pregunta:** ¿Existe la base de datos "prueba"? ¿Por qué?

---

### Ejercicio 4: Explorar Docker Hub

**Objetivo:** Familiarizarse con Docker Hub y encontrar imágenes útiles.

**Tareas:**

1. Ve a [https://hub.docker.com](https://hub.docker.com) en tu navegador.

2. Busca las siguientes imágenes oficiales y explora su documentación:
   - `postgres` (base de datos PostgreSQL)
   - `redis` (base de datos en memoria)
   - `node` (entorno de ejecución Node.js)
   - `python` (intérprete de Python)

3. Para cada imagen, documenta:
   - ¿Cuántas descargas tiene?
   - ¿Qué etiquetas (tags) principales tiene?
   - ¿Qué puerto utiliza por defecto?
   - ¿Qué variables de entorno importantes acepta?

4. Descarga la imagen de Redis
5. Ejecuta un contenedor de Redis
6. Conéctate al cliente de Redis

7. Prueba algunos comandos de Redis:
   ```
   SET nombre "Docker"
   GET nombre
   PING
   EXIT
   ```
8. Limpia todo

---

### Ejercicio 5: Comparar versiones de imágenes

**Objetivo:** Entender las diferencias entre versiones y variantes de imágenes.

**Tareas:**

1. Descarga diferentes versiones de Python:
   ```bash
   docker pull python:3.12
   docker pull python:3.11
   docker pull python:3.12-slim
   docker pull python:3.12-alpine
   ```
2. Compara los tamaños:
3. Ejecuta cada versión y verifica el tamaño real:
   ```bash
   docker run -it --rm python:3.12 python --version
   docker run -it --rm python:3.12-slim python --version
   docker run -it --rm python:3.12-alpine python --version
   ```
4. Entra en un contenedor Alpine y explora:
   ```bash
   docker run -it python:3.12-alpine sh
   ```
5. Dentro del contenedor:
   ```bash
   # Ver el tamaño de los directorios
   du -sh /*
   
   # Ver paquetes instalados
   apk list
   
   # Salir
   exit
   ```

**Pregunta:** ¿Cuál es la diferencia de tamaño entre las versiones? ¿Cuándo usarías cada una?

---

### Ejercicio 6: Limpieza del sistema

**Objetivo:** Aprender a limpiar recursos de Docker.

**Tareas:**

1. Detén todos los contenedores en ejecución:
   ```bash
   docker stop $(docker ps -q)
   ```

2. Elimina todos los contenedores:
   ```bash
   docker rm $(docker ps -aq)
   ```

3. Elimina todas las imágenes:
   ```bash
   docker rmi $(docker images -q)
   ```

4. Limpieza completa del sistema (cuidado, esto elimina todo):
   ```bash
   docker system prune -a
   ```

5. Verifica que todo está limpio:
   ```bash
   docker ps -a
   docker images
   ```

---

## 📝 Parte 5: Documentación de la práctica

### 5.1. Entrega

Documenta en un archivo Markdown o PDF:

#### **Sección 1: Instalación**

- Captura de pantalla mostrando:
  - `docker --version`
  - `docker info`
  - Salida del comando `docker run hello-world`
- ¿Qué sistema operativo usas?
- ¿Instalaste Docker Engine o Docker Desktop? ¿Por qué?

#### **Sección 2: Contenedores**

- Captura de pantalla de `docker ps` mostrando al menos 2 contenedores en ejecución
- Captura de pantalla de `docker logs` de uno de tus contenedores
- Captura de pantalla accediendo a Nginx en el navegador

#### **Sección 3: Imágenes**

- Captura de pantalla de `docker images` mostrando al menos 5 imágenes diferentes
- Tabla comparativa de tamaños de imágenes de Python (Ejercicio 5)

#### **Sección 4: Ejercicios**

Para cada ejercicio (1-5):

- Todos los comandos ejecutados
- Capturas de pantalla de los resultados
- Respuesta a las preguntas planteadas

#### **Sección 5: Reflexión**

Responde a las siguientes preguntas:

1. **Diferencias entre contenedores y máquinas virtuales:**
   - ¿Qué diferencias principales observas?
   - ¿Qué ventajas tiene Docker sobre las VMs tradicionales?

2. **Persistencia de datos:**
   - ¿Qué pasa con los datos cuando eliminas un contenedor?
   - ¿Cómo crees que se podría solucionar este problema?

3. **Imágenes:**
   - ¿Por qué las imágenes Alpine son más pequeñas?
   - ¿Cuándo usarías una imagen completa vs. una imagen slim o alpine?

4. **Uso de Docker:**
   - Menciona 3 casos de uso donde Docker sería útil
   - ¿Qué desventajas o limitaciones has encontrado?

---

## 🎓 Recursos adicionales

### Documentación oficial

- [Documentación de Docker](https://docs.docker.com/)
- [Referencia de comandos](https://docs.docker.com/engine/reference/commandline/cli/)
- [Docker Hub](https://hub.docker.com/)

### Cheat sheets

**Comandos de contenedores:**

```bash
docker run [opciones] imagen [comando]  # Crear y ejecutar
docker ps                               # Listar contenedores activos
docker ps -a                            # Listar todos los contenedores
docker stop nombre                      # Detener contenedor
docker start nombre                     # Iniciar contenedor
docker restart nombre                   # Reiniciar contenedor
docker logs nombre                      # Ver logs
docker exec -it nombre comando          # Ejecutar comando en contenedor
docker rm nombre                        # Eliminar contenedor
```

**Comandos de imágenes:**

```bash
docker images                           # Listar imágenes
docker pull imagen                      # Descargar imagen
docker rmi imagen                       # Eliminar imagen
docker search termino                   # Buscar imágenes
docker history imagen                   # Ver capas de imagen
docker inspect imagen                   # Inspeccionar imagen
```

**Comandos de limpieza:**

```bash
docker system prune                     # Limpiar recursos no usados
docker container prune                  # Eliminar contenedores detenidos
docker image prune                      # Eliminar imágenes sin usar
docker volume prune                     # Eliminar volúmenes sin usar
```
