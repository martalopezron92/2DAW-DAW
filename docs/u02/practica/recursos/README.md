# Recursos para la Práctica 2.4/2.8 - Tomcat con Docker

Este directorio contiene los recursos necesarios para completar la práctica de despliegue de Tomcat con Nginx.

## 📦 Contenido

### 1. Aplicación Sample WAR

La carpeta `sample/` contiene el código fuente de una aplicación Java simple que se puede empaquetar en formato WAR.

**Estructura:**
```
sample/
├── WEB-INF/
│   └── web.xml          # Descriptor de la aplicación web
├── index.jsp            # Página principal
└── info.jsp             # Página con información detallada del sistema
```

## 🔨 Cómo crear el archivo sample.war

### Opción 1: Usar el script proporcionado (Linux/Mac)

```bash
cd recursos
./crear-war.sh
```

### Opción 2: Crear manualmente con jar

```bash
cd recursos/sample
jar -cvf ../sample.war *
```

### Opción 3: Usar zip y renombrar

```bash
cd recursos/sample
zip -r ../sample.war *
```

## 📥 Descargar el WAR ya compilado

Si no quieres compilar la aplicación, puedes descargar el archivo `sample.war` directamente desde:

[**Descargar sample.war**](sample.war) *(después de ejecutar el script de creación)*

## ✅ Verificar el archivo WAR

Para verificar que el archivo WAR se creó correctamente:

```bash
# Ver el contenido del archivo WAR
jar -tvf sample.war

# O con unzip
unzip -l sample.war
```

Deberías ver:
```
WEB-INF/web.xml
index.jsp
info.jsp
META-INF/MANIFEST.MF
```

## 🚀 Cómo usar el archivo WAR en la práctica

1. Copia el archivo `sample.war` a tu directorio de trabajo de la práctica
2. Monta el archivo en el contenedor de Tomcat en `/usr/local/tomcat/webapps/sample.war`
3. Accede a la aplicación a través de: `http://localhost/sample/`

## 📝 Características de la aplicación

- **Página principal (index.jsp):** Muestra información básica del servidor y la arquitectura
- **Página de información (info.jsp):** Muestra propiedades del sistema y variables de entorno
- **Diseño responsive:** Funciona en dispositivos móviles y escritorio
- **Información del sistema:** Muestra versión de Java, Tomcat, sistema operativo, etc.

## 🔧 Personalización

Puedes modificar los archivos JSP para:
- Cambiar el diseño visual
- Añadir nuevas páginas
- Mostrar información adicional
- Practicar con JSP y servlets

Después de modificar, simplemente vuelve a crear el archivo WAR.

## 📚 Archivos de configuración de Nginx

Para esta práctica también necesitarás crear un archivo `default.conf` para Nginx. Aquí tienes un ejemplo:

```nginx
server {
    listen 80;
    server_name localhost;

    location /sample/ {
        proxy_pass http://NOMBRE_CONTENEDOR_TOMCAT:8080/sample/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
```

Recuerda sustituir `NOMBRE_CONTENEDOR_TOMCAT` por el nombre real de tu contenedor de Tomcat.

## ❓ Solución de problemas

### El archivo WAR no se despliega
- Verifica que el archivo se copió correctamente a `/usr/local/tomcat/webapps/`
- Revisa los logs de Tomcat: `docker logs NOMBRE_CONTENEDOR`
- Asegúrate de que el archivo tiene extensión `.war`

### Error 404 al acceder
- Verifica que la URL incluye el nombre de la aplicación: `/sample/`
- Comprueba que Tomcat ha desplegado la aplicación (debe crear una carpeta `sample/`)

### No se ve a través de Nginx
- Verifica la configuración del proxy_pass en Nginx
- Comprueba que ambos contenedores están en la misma red Docker
- Revisa los logs de Nginx: `docker logs NOMBRE_CONTENEDOR_NGINX`

## 🎓 Objetivos de aprendizaje

Al trabajar con esta aplicación aprenderás:
- Cómo empaquetar aplicaciones Java en formato WAR
- Estructura de una aplicación web Java
- Despliegue de aplicaciones en Tomcat
- Configuración de proxy inverso con Nginx
- Gestión de contenedores Docker
- Orquestación con Docker Compose
