# 3. Aplicaciones web dinámicas y APIs

### 3.1. Backend que genera HTML vs Backend que devuelve JSON

Existen dos arquitecturas principales para aplicaciones web:

#### **Arquitectura tradicional (Backend genera HTML)**

```
Navegador  ──GET /productos──▶  Backend
                                   │
                                   ▼
                           [Consulta BD]
                                   │
                                   ▼
                           [Genera HTML]
                                   │
Navegador  ◀──HTML completo────────┘
```

**Características:**
- El servidor genera la página completa
- El navegador solo muestra el HTML recibido
- Tecnologías: PHP, Django templates, JSP, etc.

#### **Arquitectura moderna (Backend devuelve JSON - API REST)**

```
Navegador          Backend (API)       Base de Datos
    │                  │                     │
    │──GET /api/───────▶│                    │
    │   productos       │────Query───────────▶│
    │                   │◀───Datos───────────┘│
    │◀──JSON────────────│                     │
    │                   │                     │
    │                                         │
[JavaScript procesa                          │
 el JSON y genera HTML]                      │
```

**Características:**
- El servidor solo devuelve datos (JSON)
- El frontend (JavaScript) procesa los datos y genera la interfaz
- Tecnologías: React, Vue, Angular + API REST

**Ejemplo de respuesta JSON:**
```json
{
  "productos": [
    { "id": 1, "nombre": "Ratón", "precio": 15 },
    { "id": 2, "nombre": "Teclado", "precio": 45 }
  ]
}
```

### 3.2. Frontend como consumidor de APIs

El frontend moderno **consume** APIs. Esto significa que hace peticiones HTTP para obtener datos.

**Ejemplo con JavaScript (Fetch API):**
```javascript
// El frontend hace una petición GET
fetch('http://localhost:3000/api/productos')
  .then(response => response.json())
  .then(productos => {
    // Ahora tenemos los datos, los mostramos
    productos.forEach(producto => {
      console.log(producto.nombre);
    });
  });
```

**Flujo completo en una app React:**
1. El usuario abre la aplicación
2. React hace una petición a la API: `GET /api/productos`
3. El backend responde con JSON
4. React procesa el JSON y muestra los productos en la página

### 3.3. Separación frontend / backend

**¿Por qué separar frontend y backend?**

| Ventaja | Explicación |
|---------|-------------|
| **Independencia** | Puedes cambiar el frontend sin tocar el backend |
| **Reutilización** | La misma API puede servir a web, móvil, etc. |
| **Especialización** | Un equipo trabaja en frontend, otro en backend |
| **Escalado** | Puedes añadir más servidores backend o frontend según necesidad |

**Ejemplo práctico de despliegue:**
```
Frontend (React)     →  Puerto 80 (Nginx)
Backend (Node.js)    →  Puerto 3000
Base de datos        →  Puerto 5432 (NO expuesto)
```

El usuario accede a `http://tuapp.com` (puerto 80), que muestra el frontend. Este frontend hace peticiones al backend en el puerto 3000.

---

