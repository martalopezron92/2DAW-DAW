# 4. Servidores web y su papel en el despliegue

### 4.1. ¿Qué es un servidor web?

Un **servidor web** es un software que:
- Escucha peticiones HTTP
- Devuelve contenido (HTML, CSS, imágenes, etc.)
- Gestiona la comunicación cliente-servidor

**Servidores web populares:**
- **Nginx**: Muy eficiente, usado para producción
- **Apache**: Tradicional, muy configurable
- **Node.js + Express**: Usado en desarrollo y producción

### 4.2. Servir contenido estático vs dinámico

#### **Contenido estático**
Archivos que no cambian: HTML, CSS, JavaScript, imágenes.

```
Cliente  ──GET /index.html──▶  Nginx
Cliente  ◀──index.html──────── Nginx
```

Nginx simplemente devuelve el archivo tal cual.

#### **Contenido dinámico**
Contenido generado en tiempo real según la petición.

```
Cliente  ──GET /api/productos──▶  Nginx
                                    │
                                    ▼
                              [Envía a Backend]
                                    │
                                    ▼
                              Backend (Node.js)
                                    │
                                    ▼
                              [Consulta BD]
                                    │
Cliente  ◀──JSON────────────────────┘
```

### 4.3. Relación servidor web – backend

En una aplicación moderna, el servidor web (Nginx) hace dos cosas:

1. **Servir el frontend** (archivos estáticos)
2. **Redirigir peticiones al backend** (reverse proxy)

**Ejemplo de configuración Nginx:**
```nginx
server {
    listen 80;
    
    # Servir archivos estáticos del frontend
    location / {
        root /usr/share/nginx/html;
        try_files $uri /index.html;
    }
    
    # Redirigir peticiones a la API al backend
    location /api {
        proxy_pass http://backend:3000;
    }
}
```

**¿Qué hace esto?**
- `GET /` → Devuelve el index.html del frontend
- `GET /api/productos` → Redirige al backend en el puerto 3000

### 4.4. Concepto básico de reverse proxy

Un **reverse proxy** es un intermediario entre el cliente y el backend.

```
                     ┌──────────┐
    Internet ───────▶│  Nginx   │
                     │ (Puerto  │
                     │   80)    │
                     └────┬─────┘
                          │
             ┌────────────┴────────────┐
             ▼                         ▼
      ┌──────────┐              ┌──────────┐
      │ Frontend │              │ Backend  │
      │ (Estático│              │ (Puerto  │
      │  files)  │              │  3000)   │
      └──────────┘              └──────────┘
```

**Ventajas del reverse proxy:**
- El usuario solo ve un puerto (80)
- Puedes tener múltiples backends
- Añade una capa de seguridad
- Puede hacer balanceo de carga

**Caso de uso real:** Todos tus servicios se comunican internamente, pero solo expones Nginx al exterior.

---
