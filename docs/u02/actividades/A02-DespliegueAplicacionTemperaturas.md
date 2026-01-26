
# Relación 2.2: Despliegue de la aplicación Guestbook

### Descripción

**Actividad:** *Despliegue de la aplicación Guestbook*

En esta práctica desplegarás una aplicación web completa que requiere de dos servicios para su funcionamiento: un servidor web y una base de datos. Aplicarás los conceptos de redes, volúmenes y variables de entorno en Docker para crear un entorno multi-contenedor funcional.

#### Objetivo general

Aprender a:

- Desplegar aplicaciones multi-contenedor usando Docker.
- Configurar redes Docker para la comunicación entre contenedores.
- Utilizar volúmenes para la persistencia de datos.
- Configurar aplicaciones mediante variables de entorno.
- Comprender la resolución DNS entre contenedores.

---

### Contexto de trabajo

La aplicación **Guestbook** es una aplicación web desarrollada en Python que permite a los usuarios y usuarias dejar mensajes en un libro de visitas. La arquitectura de la aplicación consta de:

- **Servicio web**: Aplicación Guestbook que escucha en el puerto 5000/tcp.
- **Servicio de base de datos**: Redis (base de datos no relacional) que utiliza el puerto 6379/tcp.

**Imágenes Docker a utilizar:**

- `iesgn/guestbook` - Aplicación web Guestbook
- `redis` - Base de datos Redis

---

### 🔹 Parte 1: Despliegue básico de Guestbook

#### Tarea 1.1: Preparación del entorno

1. Crea una red Docker personalizada llamada `red_guestbook` que permita la comunicación entre los contenedores.

2. Investiga en Docker Hub la documentación de la imagen `redis` para comprender:
   
    - Qué puerto utiliza por defecto.
    - Cómo habilitar la persistencia de datos (modo append-only).
    - Qué directorio utiliza para almacenar los datos.

#### Tarea 1.2: Despliegue del servicio de base de datos

1. Crea un contenedor con la base de datos Redis con las siguientes características:
   
    - Nombre del contenedor: `redis`
    - Conectado a la red `red_guestbook`
    - Configurado para persistencia de datos en el directorio `/data` del contenedor
    - Volumen montado desde `/opt/redis_data` del host (crea este directorio previamente)
    - Ejecutando en modo daemon (segundo plano)

2. Verifica que el contenedor está en ejecución correctamente.

#### Tarea 1.3: Despliegue del servicio web

1. Despliega la aplicación Guestbook con las siguientes características:
   
    - Nombre del contenedor: `guestbook`
    - Conectado a la red `red_guestbook`
    - Puerto 80 del host mapeado al puerto 5000 del contenedor
    - Ejecutando en modo daemon

2. Accede a la aplicación desde tu navegador web (http://localhost).

3. Añade varios mensajes en el libro de visitas.

#### Tarea 1.4: Verificación de la persistencia

1. Detén y elimina el contenedor `redis`.

2. Verifica que los datos persisten en el directorio del host `/opt/redis_data`.

3. Vuelve a crear el contenedor `redis` con la misma configuración.

4. Accede nuevamente a la aplicación Guestbook y comprueba que los mensajes anteriores siguen presentes.

---

### 🔹 Parte 2: Configuración personalizada

#### Tarea 2.1: Cambio del nombre del contenedor de base de datos

La aplicación Guestbook utiliza una variable de entorno llamada `REDIS_SERVER` para saber a qué servidor de base de datos debe conectarse. Por defecto, esta variable tiene el valor `redis`.

1. Elimina los contenedores anteriores (mantén la red y el volumen).

2. Crea un nuevo contenedor de base de datos con el nombre `bd_guestbook` (en lugar de `redis`).

3. Despliega el contenedor de la aplicación Guestbook configurando la variable de entorno `REDIS_SERVER` para que apunte al nuevo nombre del contenedor de base de datos.

4. Verifica que la aplicación funciona correctamente con esta nueva configuración.


---

### 🔹 Parte 3: Análisis y documentación

#### Tarea 3.1: Análisis de la arquitectura

Responde a las siguientes preguntas en tu documentación:

1. **Redes Docker:**
   
    - ¿Por qué es necesario crear una red personalizada en lugar de usar la red por defecto de Docker?
    - ¿Cómo se comunican los contenedores dentro de la red `red_guestbook`?
    - ¿Qué ventaja proporciona la resolución DNS automática de Docker?

2. **Volúmenes:**
   
    - ¿Por qué es importante usar volúmenes para la base de datos?
    - ¿Qué pasaría si no usáramos un volumen para Redis?
    - ¿Qué diferencias existen entre un volumen y un bind mount?

3. **Variables de entorno:**
   
    - ¿Qué función cumple la variable de entorno `REDIS_SERVER`?
    - ¿Cómo se pasa una variable de entorno a un contenedor en Docker?

4. **Puertos:**
   
    - ¿Por qué no es necesario exponer el puerto de Redis al host?
    - ¿En qué casos sería necesario exponer el puerto de la base de datos?

#### Tarea 3.2: Comandos utilizados

Documenta todos los comandos Docker que has utilizado para:

- Crear la red
- Crear y gestionar el contenedor Redis
- Crear y gestionar el contenedor Guestbook
- Verificar el estado de contenedores y redes
- Inspeccionar la configuración de red de los contenedores


---

## Entregables

1. **Documentación en formato Markdown** que incluya:
   
    - Comandos utilizados en cada tarea con una breve explicación
    - Capturas de pantalla que demuestren:
        - La aplicación Guestbook funcionando en el navegador
        - El contenido del directorio de persistencia
        - La lista de contenedores en ejecución
        - La inspección de la red Docker
    - Respuestas a las preguntas de análisis de la Parte 3
    - Prueba de la persistencia de datos (Tarea 1.4)

---