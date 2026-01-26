---
title: "UD 2 - P4+P8: Despliegue de Tomcat con Nginx - Manual y con Docker Compose"
description: "Despliegue completo de aplicación Java con servidor de aplicaciones y proxy inverso, utilizando gestión manual y Docker Compose"
summary: "Práctica integral para desplegar aplicaciones Java en Tomcat con Nginx como proxy inverso, primero mediante gestión manual de contenedores y posteriormente automatizando el proceso con Docker Compose."
authors:
    - Eduardo Fdez
date: 2025-01-12
icon: "material/file-document-edit"
permalink: /daw/unidad2/p2.4-8
categories:
    - DAW
tags:
    - Docker
    - Docker Compose
    - Tomcat
    - Nginx
    - Proxy inverso
    - Java
    - Bind mount
---

## Relación 2.4+2.8 (Práctica Integrada)

### Descripción

**Actividad:** *Despliegue de Tomcat con Nginx - De la gestión manual a Docker Compose*

Esta práctica integrada combina dos enfoques complementarios para desplegar una aplicación Java en un **servidor de aplicaciones Tomcat** con **Nginx como proxy inverso**. En la **Primera Parte** aprenderás a gestionar contenedores manualmente, entendiendo cada comando y configuración. En la **Segunda Parte** automatizarás todo el proceso usando **Docker Compose**, comprendiendo las ventajas de la orquestación declarativa.

Esta arquitectura de dos capas (servidor web + servidor de aplicaciones) es muy común en entornos de producción, ya que permite separar responsabilidades: Nginx maneja las peticiones HTTP, contenido estático y actúa como punto de entrada, mientras que Tomcat ejecuta la lógica de negocio de las aplicaciones Java.

#### Objetivos generales

Aprender a:

- Desplegar aplicaciones Java en servidores de aplicaciones (Tomcat).
- Configurar Nginx como proxy inverso para enrutar peticiones.
- Utilizar bind mounts para montar archivos de configuración y aplicaciones.
- Comprender la arquitectura de múltiples capas en aplicaciones web.
- Trabajar con archivos WAR (Web Application Archive).
- Entender el flujo completo de peticiones en una arquitectura con proxy inverso.
- Gestionar contenedores Docker manualmente mediante comandos CLI.
- Automatizar y orquestar servicios con Docker Compose.
- Comparar ventajas y desventajas entre gestión manual y orquestación.
- Implementar configuraciones avanzadas: healthchecks, límites de recursos, redes personalizadas.

---

### Contexto de trabajo

En esta práctica trabajaremos con una arquitectura de dos capas que utiliza los siguientes componentes:

**1. Servidor de aplicaciones Tomcat:**

- Servidor de aplicaciones Java que ejecuta aplicaciones web empaquetadas en formato WAR.
- Escucha en el puerto 8080/tcp por defecto.
- Directorio de despliegue: `/usr/local/tomcat/webapps/`
- Imagen Docker: `tomcat:9.0`

**2. Servidor web Nginx (Proxy inverso):**

- Actúa como punto de entrada para las peticiones HTTP.
- Recibe peticiones en el puerto 80 y las redirige a Tomcat.
- Se configura mediante archivos de configuración en `/etc/nginx/conf.d/`
- Imagen Docker: `nginx`

**Flujo de peticiones:**

```
Cliente → Nginx (puerto 80) → Tomcat (puerto 8080) → Aplicación Java
```

**Estructura de la práctica:**

- **PRIMERA PARTE (P2.4):** Gestión manual con comandos Docker
- **SEGUNDA PARTE (P2.8):** Automatización con Docker Compose

---

# PRIMERA PARTE: Gestión Manual con Docker

Esta primera parte se centra en comprender cada componente y comando Docker necesario para desplegar la arquitectura. Aprenderás a gestionar redes, contenedores, volúmenes y configuraciones de forma manual.

---

### 🔹 Parte 1: Preparación del entorno

#### Tarea 1.1: Obtención de recursos

1. Crea un directorio de trabajo para esta práctica, por ejemplo `~/tomcat_practica`.

2. Descarga o crea un archivo WAR de ejemplo. Puedes:
   
    - Descargar `sample.war` desde el repositorio del curso
    - Utilizar cualquier aplicación WAR simple que tengas disponible
    - Crear una aplicación Java básica y empaquetarla como WAR

3. Investiga la estructura básica de un archivo de configuración de Nginx para proxy inverso.

4. Crea un archivo de configuración de Nginx llamado `default.conf` que debe incluir:
   
    - Servidor que escucha en el puerto 80
    - Configuración de `location /` con proxy_pass
    - El proxy_pass debe apuntar al contenedor de Tomcat (puerto 8080)
    - Debe incluir el nombre de la aplicación en la ruta
    - Gestión de páginas de error (500, 502, 503, 504)
    
    **Nota:** Usa placeholders (como NOMBRE_CONTENEDOR_TOMCAT y NOMBRE_APLICACION) que luego sustituirás por los valores reales.

5. Verifica que tienes ambos archivos:
   
    - `sample.war` (o el nombre de tu aplicación WAR)
    - `default.conf`

#### Tarea 1.2: Creación de la red

1. Crea una red Docker personalizada llamada `red_tomcat` para la comunicación entre los contenedores.

2. Verifica que la red se ha creado correctamente.

---

### 🔹 Parte 2: Despliegue del servidor Tomcat

#### Tarea 2.1: Despliegue básico de Tomcat

1. Despliega un contenedor de Tomcat con las siguientes características:
   
    - Nombre del contenedor: `aplicacionjava`
    - Conectado a la red `red_tomcat`
    - Bind mount del archivo WAR desde el host al directorio de despliegue de Tomcat
    - Montaje en modo solo lectura (`:ro`)
    - **NO mapees puertos** (el acceso será solo interno a través de Nginx)
    - Ejecutando en modo daemon

2. Verifica que el contenedor está en ejecución.

3. Inspecciona los logs del contenedor para verificar que la aplicación se ha desplegado correctamente.

4. Accede al contenedor y verifica que el archivo WAR está en el directorio de despliegue.

5. Comprueba que la aplicación se ha desplegado automáticamente (Tomcat descomprime el WAR).

---

### 🔹 Parte 3: Configuración y despliegue de Nginx

#### Tarea 3.1: Configuración del proxy inverso

1. Revisa y completa el archivo `default.conf` con la configuración correcta:
   
    - Sustituye `NOMBRE_CONTENEDOR_TOMCAT` por el nombre real de tu contenedor de Tomcat
    - Sustituye `NOMBRE_APLICACION` por el nombre de tu aplicación (sin la extensión .war)
    - Asegúrate de que la directiva `proxy_pass` apunta correctamente

2. Comprende qué hace cada directiva de la configuración:
   
    - `listen`: Puerto en el que escucha Nginx
    - `server_name`: Nombre del servidor
    - `location /`: Configuración del proxy inverso
    - `proxy_pass`: Dirección a la que se redirigen las peticiones

#### Tarea 3.2: Despliegue de Nginx

1. Despliega un contenedor de Nginx con las siguientes características:
   
    - Nombre del contenedor: `proxy`
    - Puerto 80 del host mapeado al puerto 80 del contenedor
    - Conectado a la red `red_tomcat`
    - Bind mount del archivo `default.conf` al directorio de configuración de Nginx
    - Montaje en modo solo lectura (`:ro`)
    - Ejecutando en modo daemon

2. Verifica que el contenedor está en ejecución.

3. Inspecciona los logs de Nginx para verificar que no hay errores de configuración.

#### Tarea 3.3: Verificación del despliegue

1. Accede a la aplicación desde tu navegador web (http://localhost).

2. Verifica que la aplicación Java se muestra correctamente.

3. Comprueba que estás accediendo a través de Nginx (puerto 80) y no directamente a Tomcat.

---

### 🔹 Parte 4: Análisis de la arquitectura

#### Tarea 4.1: Flujo de peticiones

1. Analiza el flujo completo de una petición HTTP:
   
    - ¿Qué componente recibe primero la petición del navegador?
    - ¿Cómo sabe Nginx dónde redirigir la petición?
    - ¿Por qué funciona la resolución del nombre del contenedor de Tomcat?
    - ¿Qué respuesta envía Tomcat de vuelta?

2. Realiza pruebas de conectividad:
   
    - Desde el contenedor Nginx, intenta hacer ping al contenedor de Tomcat
    - Desde el contenedor Nginx, verifica que puedes acceder al puerto 8080 de Tomcat

#### Tarea 4.2: Bind mount vs volúmenes

1. Compara el uso de bind mount en esta práctica con los volúmenes usados en prácticas anteriores:
   
    - ¿Cuándo es más apropiado usar bind mount?
    - ¿Cuándo es mejor usar volúmenes nombrados?
    - ¿Qué ventajas y desventajas tiene cada enfoque?

2. Verifica en el host la ubicación de los archivos montados con bind mount.

---

### 🔹 Parte 5: Configuración avanzada

#### Tarea 5.1: Modificación de la configuración de Nginx

1. Investiga qué cabeceras HTTP adicionales puede configurar un proxy inverso para mejorar la funcionalidad.

2. Modifica el archivo `default.conf` para añadir dentro de `location /`:
   
    - Cabecera `Host` con el valor del host original
    - Cabecera `X-Real-IP` con la IP real del cliente
    - Cabecera `X-Forwarded-For` con las IPs de proxies intermedios
    - Cabecera `X-Forwarded-Proto` con el protocolo usado
    
    **Pista:** Investiga las directivas `proxy_set_header` de Nginx y las variables disponibles.

3. Investiga qué comando permite recargar la configuración de Nginx sin detener el contenedor.

4. Aplica los cambios y verifica que funcionan correctamente.

#### Tarea 5.2: Acceso directo a Tomcat

1. Recrea el contenedor de Tomcat exponiendo el puerto 8080 al host.

2. Accede directamente a Tomcat desde tu navegador (http://localhost:8080/sample).

3. Compara el acceso directo con el acceso a través del proxy:
   
    - ¿Qué diferencias observas en las URLs?
    - ¿Qué cabeceras HTTP son diferentes?

4. Reflexiona sobre por qué en producción no se suele exponer directamente Tomcat.

#### Tarea 5.3: Múltiples aplicaciones

1. Si tienes múltiples archivos WAR, despliega más de una aplicación en Tomcat.

2. Configura Nginx para que cada aplicación sea accesible en rutas diferentes:
   
    - `/app1/` → aplicacion1.war
    - `/app2/` → aplicacion2.war

---

# SEGUNDA PARTE: Automatización con Docker Compose

En esta segunda parte retomarás el mismo despliegue de **Tomcat con Nginx como proxy inverso**, pero utilizando **Docker Compose** para simplificar y automatizar la gestión. Comprenderás las ventajas de la orquestación declarativa frente a la gestión manual de contenedores.

---

### 🔹 Parte 7: Preparación del entorno con Docker Compose

#### Tarea 7.1: Estructura de archivos

1. Crea un nuevo directorio para esta parte: `~/tomcat_compose`.

2. Dentro del directorio, crea la siguiente estructura:

```
tomcat_compose/
├── docker-compose.yml
├── default.conf
└── sample.war
```

3. Copia o descarga los archivos necesarios:
   
    - `sample.war` - La misma aplicación Java de la Primera Parte (o puedes usar otra)
    - Puedes copiar el archivo WAR que ya tenías o descargar uno nuevo

4. Crea el archivo `default.conf` con la configuración de Nginx:

```nginx
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
   
    location / {
        root   /usr/share/nginx/html;
        proxy_pass http://aplicacionjava:8080/sample/;
    }
    
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

#### Tarea 7.2: Creación del docker-compose.yml

1. Investiga la documentación de Docker Compose sobre:
   
    - Definición de servicios
    - Bind mounts en Docker Compose
    - Dependencias entre servicios
    - Políticas de reinicio

2. Crea un archivo `docker-compose.yml` que defina:
   
    **Servicio de Tomcat (`aplicacionjava`):**
    - Imagen: `tomcat:9.0`
    - Bind mount del archivo WAR al directorio de despliegue de Tomcat (`/usr/local/tomcat/webapps/`)
    - Montaje en modo solo lectura (`:ro`)
    - NO mapear puertos al host (acceso solo interno)
    - Política de reinicio: `always`
    
    **Servicio de Nginx (`proxy`):**
    - Imagen: `nginx`
    - Puerto 80 del host mapeado al puerto 80 del contenedor
    - Bind mount del archivo de configuración a `/etc/nginx/conf.d/default.conf`
    - Montaje en modo solo lectura (`:ro`)
    - Dependencia del servicio de Tomcat (`depends_on`)
    - Política de reinicio: `always`

3. Analiza y responde:
   
    - ¿Por qué se usan bind mounts en lugar de volúmenes Docker en este caso?
    - ¿Qué significa `:ro` y por qué es importante usarlo?
    - ¿Por qué Nginx depende de Tomcat (`depends_on`)?
    - ¿Por qué Tomcat no expone puertos al host?
    - ¿Cómo se comunican los contenedores entre sí?

---

### 🔹 Parte 8: Despliegue y verificación con Compose

#### Tarea 8.1: Despliegue del escenario

1. Desde el directorio del proyecto (`~/tomcat_compose`), despliega todos los servicios con Docker Compose.

2. Observa la salida del comando y verifica:
   
    - Qué red se crea automáticamente
    - En qué orden se inician los servicios
    - Si hay algún error durante el despliegue

3. Comprueba que ambos servicios están en ejecución y su estado.

4. Accede a la aplicación desde tu navegador (http://localhost).

5. Verifica que estás accediendo a través del proxy (puerto 80, no 8080).

6. Compara con la Primera Parte:
   
    - ¿Cuántos comandos necesitaste en la Primera Parte?
    - ¿Cuántos comandos has usado ahora?
    - ¿Qué es más fácil de documentar y versionar?

#### Tarea 8.2: Verificación de bind mounts

1. Verifica que los archivos se han montado correctamente:
   
    - Accede al contenedor de Tomcat y verifica que `sample.war` está en `/usr/local/tomcat/webapps/`
    - Accede al contenedor de Nginx y verifica que `default.conf` está en `/etc/nginx/conf.d/`

2. Modifica el archivo `default.conf` en el host (añade un comentario o cambia algo menor).

3. Investiga cómo recargar la configuración de Nginx sin reiniciar el contenedor usando Docker Compose.

4. Recarga la configuración y verifica que el cambio se ha aplicado.

5. Compara con la Primera Parte:
   
    - ¿Es más fácil hacer cambios en configuración con Compose?
    - ¿Qué ventajas tiene tener todos los archivos juntos en un directorio?

#### Tarea 8.3: Análisis de logs

1. Visualiza los logs de ambos servicios con Docker Compose.

2. Visualiza los logs solo del servicio de Nginx.

3. Visualiza los logs solo del servicio de Tomcat.

4. Identifica en los logs:
   
    - En Nginx: las peticiones que redirige a Tomcat
    - En Tomcat: el despliegue de la aplicación WAR

5. Realiza varias peticiones HTTP desde el navegador y observa cómo se registran en ambos servicios.

6. Compara con la Primera Parte:
   
    - ¿Es más fácil ver los logs con Compose?
    - ¿Qué ventajas tiene poder ver logs de múltiples servicios a la vez?

---

### 🔹 Parte 9: Configuración avanzada con Compose

#### Tarea 9.1: Mejora de la configuración de Nginx

1. Modifica el archivo `default.conf` para añadir cabeceras de proxy que mejoren la funcionalidad:

```nginx
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location / {
        proxy_pass http://aplicacionjava:8080/sample/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
    
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

2. Explica qué hace cada directiva añadida:
   
    - `proxy_set_header Host`
    - `proxy_set_header X-Real-IP`
    - `proxy_set_header X-Forwarded-For`
    - `proxy_set_header X-Forwarded-Proto`
    - Las directivas de timeout

3. Recarga Nginx sin detener el contenedor.

4. Verifica que las cabeceras se están enviando correctamente.

#### Tarea 9.2: Variables de entorno y customización

1. Crea un archivo `.env` en el mismo directorio con variables para:
   
    - Puerto de Nginx (por ejemplo: `NGINX_PORT=80`)
    - Versión de Tomcat a usar (por ejemplo: `TOMCAT_VERSION=9.0`)
    - Nombre del archivo WAR (por ejemplo: `WAR_FILE=sample.war`)

2. Modifica tu `docker-compose.yml` para usar estas variables con la sintaxis `${VARIABLE}`.

3. Cambia el puerto de Nginx a 8080 en el archivo `.env`.

4. Reinicia los servicios y verifica que la aplicación ahora es accesible en http://localhost:8080.

5. Vuelve a cambiar el puerto a 80.

6. Prueba cambiando la versión de Tomcat (por ejemplo, a `10.1`) y verifica que se usa la nueva versión.

7. Reflexiona:
   
    - ¿Qué ventajas tiene usar variables de entorno?
    - ¿Es más fácil adaptar la configuración a diferentes entornos (dev, test, prod)?

---

### 🔹 Parte 10: Análisis comparativo

#### Tarea 10.1: Comparación entre gestión manual y Docker Compose

Completa la siguiente tabla comparativa analizando ambas partes de la práctica:

| Aspecto                          | Gestión manual (Parte 1) | Docker Compose (Parte 2) |
|----------------------------------|--------------------------|--------------------------|
| Nº de comandos para desplegar    |                          |                          |
| Creación de red                  |                          |                          |
| Montaje de archivos              |                          |                          |
| Despliegue de app WAR            |                          |                          |
| Configuración de Nginx           |                          |                          |
| Actualización de app             |                          |                          |
| Modificación de configuración    |                          |                          |
| Reproducibilidad en otro equipo  |                          |                          |
| Facilidad de versionado (git)    |                          |                          |
| Documentación de la arquitectura |                          |                          |
| Gestión de dependencias          |                          |                          |
| Escalabilidad (múltiples réplicas)|                         |                          |

#### Tarea 10.2: Preguntas de análisis final

Responde a las siguientes preguntas en tu documentación:

**1. Comparación entre enfoques:**

- ¿Cuántos comandos necesitabas en la Primera Parte vs la Segunda Parte?
- ¿Qué enfoque es más fácil de compartir con tu equipo?
- ¿Cuál es más fácil de versionar con Git?
- Si tuvieras que desplegar esta arquitectura en 10 servidores diferentes, ¿qué enfoque usarías?

**2. Montajes de solo lectura (`:ro`):**

- ¿Por qué es buena práctica montar archivos como solo lectura?
- ¿Qué riesgos evitas al usar `:ro`?
- ¿En qué casos NO usarías `:ro`? (pista: piensa en archivos de logs o datos)

**3. Arquitectura de proxy inverso:**

- ¿Qué ventajas aporta Docker Compose a esta arquitectura específica?
- ¿Es más fácil modificar la configuración del proxy con Compose?
- ¿Cómo facilita Docker Compose el despliegue de nuevas aplicaciones?
- ¿Cómo añadirías un segundo servidor Tomcat para balanceo de carga?

**4. Dependencias entre servicios:**

- ¿Por qué Nginx depende de Tomcat (`depends_on`)?
- ¿Qué pasa si Tomcat no está listo cuando Nginx arranca?
- ¿Es suficiente `depends_on` para garantizar que Tomcat está listo? ¿Por qué?

**5. Entornos de desarrollo vs producción:**

- ¿Cómo usarías el archivo `.env` para diferentes entornos?
- ¿Qué configuraciones cambiarían entre desarrollo y producción?
- ¿Cómo gestionarías secretos (contraseñas, API keys) con Docker Compose?

---

## Entregables

### Entregables de la Primera Parte (Gestión Manual)

1. **Documentación en formato Markdown o PDF** que incluya:
   
    - Todos los comandos utilizados en cada tarea de las Partes 1-5
    - Archivo de configuración `default.conf` completo y explicado
    - Capturas de pantalla que demuestren:
        - La aplicación funcionando a través del proxy
        - Lista de contenedores en ejecución
        - Inspección de la red Docker
        - Logs de Tomcat mostrando el despliegue de la aplicación
        - Logs de Nginx
        - Acceso directo a Tomcat (si realizas la tarea 5.2)
        - Estructura de directorios con bind mounts
    - Diagrama del flujo de peticiones (cliente → Nginx → Tomcat)

2. **Archivos de configuración:**
   
    - `default.conf` - Configuración básica de Nginx
    - `default.conf` (versión avanzada) - Con cabeceras adicionales

### Entregables de la Segunda Parte (Docker Compose)

1. **Documentación en formato Markdown o PDF** que incluya:
   
    - Archivo `docker-compose.yml` completo y comentado
    - Archivo `default.conf` para Docker Compose (con cabeceras de proxy)
    - Archivo `.env` con variables de entorno
    - Todos los comandos Docker Compose utilizados en las Partes 7-9
    - Capturas de pantalla que demuestren:
        - Aplicación funcionando a través del proxy con Compose
        - Estructura de archivos del proyecto (`docker-compose.yml`, `default.conf`, `sample.war`)
        - Servicios en ejecución (`docker compose ps`)
        - Logs de ambos servicios
        - Prueba de variables de entorno funcionando
    - Respuestas a todas las preguntas de análisis

2. **Archivos del proyecto Docker Compose:**
   
    - `docker-compose.yml`
    - `default.conf`
    - `.env` (archivo de variables de entorno)

### Entregables de Análisis Comparativo (Parte 10)

1. **Análisis comparativo:**
   
    - Tabla comparativa completada (Tarea 10.1)
    - Respuestas detalladas a todas las preguntas de análisis final (Tarea 10.2)
    - Reflexión personal sobre qué enfoque prefieres y por qué
    - Casos de uso donde usarías cada enfoque

---

### Evaluación

Se evaluará:

**De la Primera Parte:**
- La correcta configuración del proxy inverso con comandos Docker.
- El funcionamiento completo de la aplicación a través de Nginx.
- La comprensión del flujo de peticiones.
- El uso apropiado de bind mounts y redes Docker.
- La correcta gestión de contenedores mediante CLI.

**De la Segunda Parte:**
- La correcta configuración del proxy inverso con Docker Compose.
- El uso apropiado de bind mounts en el archivo `docker-compose.yml`.
- El uso de variables de entorno.
- La comprensión de las dependencias entre servicios.

**Del Análisis Comparativo:**
- La profundidad del análisis comparativo entre ambos enfoques.
- La comprensión de ventajas y desventajas de cada método.
- La calidad de las respuestas a las preguntas de análisis.
- La claridad y completitud de la documentación.

**Criterios transversales:**
- Claridad y organización de la documentación.
- Calidad y relevancia de las capturas de pantalla.
- Profundidad del análisis técnico.
- Capacidad de reflexión crítica.
- Aplicación de conceptos aprendidos en prácticas anteriores.

---

### Condiciones de entrega

Las publicadas en la plataforma Moodle del curso.

---

### Estimación de tiempo

**Tiempo estimado total: 5-6 horas**

Desglose aproximado:

- **Primera Parte (Gestión Manual):** 3-3.5 horas
    - Parte 1 (Preparación): 30 min
    - Parte 2 (Tomcat): 30 min
    - Parte 3 (Nginx): 45 min
    - Parte 4 (Análisis arquitectura): 30 min
    - Parte 5 (Configuración avanzada): 1-1.5 horas

- **Segunda Parte (Docker Compose):** 1.5-2 horas
    - Parte 7 (Preparación Compose): 20 min
    - Parte 8 (Despliegue y verificación): 30 min
    - Parte 9 (Configuración avanzada): 40-50 min

- **Análisis Comparativo (Parte 10):** 30-40 min
    - Tabla comparativa: 10-15 min
    - Preguntas de análisis: 20-25 min

**Notas sobre la estimación:**

- Los tiempos están ajustados considerando que los alumnos:
    - Ya han completado la Práctica P2.001 (experiencia previa con Docker)
    - Han recibido explicación en clase sobre Docker Compose
    - Han realizado una práctica guiada de Docker Compose con WordPress
- La documentación y capturas de pantalla deben realizarse en paralelo mientras se completan las tareas.
- Se recomienda distribuir la práctica en 2 sesiones de trabajo de 2.5-3 horas cada una.
- Los alumnos más familiarizados con Docker podrían completarla en aproximadamente 4-5 horas.

---

### Recursos de apoyo

**Recursos generales:**

- Documentación oficial de Docker: [https://docs.docker.com](https://docs.docker.com)
- Documentación oficial de Docker Compose: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
- Repositorio con ejemplos: [https://github.com/josedom24/curso_docker_ies](https://github.com/josedom24/curso_docker_ies)

**Tomcat:**

- Imagen Tomcat en Docker Hub: [https://hub.docker.com/_/tomcat](https://hub.docker.com/_/tomcat)
- Documentación de Tomcat: [https://tomcat.apache.org/tomcat-9.0-doc/](https://tomcat.apache.org/tomcat-9.0-doc/)
- Despliegue de aplicaciones WAR: [https://tomcat.apache.org/tomcat-9.0-doc/deployer-howto.html](https://tomcat.apache.org/tomcat-9.0-doc/deployer-howto.html)

**Nginx:**

- Imagen Nginx en Docker Hub: [https://hub.docker.com/_/nginx](https://hub.docker.com/_/nginx)
- Documentación de Nginx: [https://nginx.org/en/docs/](https://nginx.org/en/docs/)
- Nginx como proxy inverso: [https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- Configuración de cabeceras proxy: [http://nginx.org/en/docs/http/ngx_http_proxy_module.html](http://nginx.org/en/docs/http/ngx_http_proxy_module.html)

**Docker Compose:**

- Compose file reference: [https://docs.docker.com/compose/compose-file/](https://docs.docker.com/compose/compose-file/)
- Bind mounts en Compose: [https://docs.docker.com/compose/compose-file/07-volumes/](https://docs.docker.com/compose/compose-file/07-volumes/)
- Networks en Compose: [https://docs.docker.com/compose/networking/](https://docs.docker.com/compose/networking/)

**Conceptos adicionales:**

- Bind mounts en Docker: [https://docs.docker.com/storage/bind-mounts/](https://docs.docker.com/storage/bind-mounts/)
- Docker networking: [https://docs.docker.com/network/](https://docs.docker.com/network/)
- Archivos WAR (Web Application Archive): [https://en.wikipedia.org/wiki/WAR_(file_format)](https://en.wikipedia.org/wiki/WAR_(file_format))

---

### Presentación de la práctica

[:fontawesome-solid-file-pdf: Descargar presentación P2.4](https://revilofe.github.io/slides/section4-daw/DAW-U2.4.-Tomcat.html){ .md-button }
