# 2. Funcionamiento básico del protocolo HTTP aplicado al despliegue

### 2.1. Comunicación cliente-servidor

HTTP (HyperText Transfer Protocol) es el protocolo que permite la comunicación entre navegadores y servidores web.

**Esquema básico:**

```
  CLIENTE (Navegador)              SERVIDOR
        │                              │
        │  ──── HTTP REQUEST ─────▶    │
        │  GET /productos              │
        │                              │
        │                         [Procesa]
        │                              │
        │  ◀─── HTTP RESPONSE ─────    │
        │  200 OK + Datos              │
        │                              │
```

**Flujo explicado:**
1. El cliente (navegador) hace una petición HTTP
2. El servidor recibe la petición, la procesa
3. El servidor envía una respuesta HTTP
4. El cliente recibe y muestra el resultado

### 2.2. Métodos HTTP principales

En el contexto del despliegue, los métodos más importantes son:

| Método | Propósito | Ejemplo |
|--------|-----------|---------|
| **GET** | Obtener datos | Cargar una página, listar productos |
| **POST** | Enviar/crear datos | Enviar un formulario, crear un usuario |
| **PUT** | Actualizar datos | Modificar un perfil |
| **DELETE** | Eliminar datos | Borrar un comentario |

**Ejemplo práctico:**
```
GET http://localhost:3000/api/productos
→ El servidor devuelve la lista de productos

POST http://localhost:3000/api/productos
Body: { "nombre": "Teclado", "precio": 50 }
→ El servidor crea un nuevo producto
```

### 2.3. Códigos de estado HTTP

Los códigos de estado indican si una petición tuvo éxito o falló. Los más importantes:

| Código | Significado | ¿Cuándo aparece? |
|--------|-------------|------------------|
| **200 OK** | Éxito | Todo funcionó correctamente |
| **404 Not Found** | No encontrado | La URL no existe |
| **500 Internal Server Error** | Error del servidor | Algo falló en el backend |

**Otros códigos útiles:**
- **201 Created**: Recurso creado exitosamente (tras un POST)
- **400 Bad Request**: La petición está mal formada
- **401 Unauthorized**: Falta autenticación
- **403 Forbidden**: Sin permisos

**¿Por qué es importante?** Al desplegar, estos códigos te ayudan a diagnosticar problemas:
- 404 → Revisar rutas y configuración del servidor
- 500 → Revisar logs del backend
- 200 → Todo funciona correctamente

### 2.4. Puertos y exposición de servicios

Un **puerto** es un número que identifica un servicio específico en un servidor.

**Puertos comunes:**
```
Puerto 80   → HTTP (web sin cifrar)
Puerto 443  → HTTPS (web cifrada)
Puerto 3000 → Aplicaciones Node.js (desarrollo)
Puerto 5432 → PostgreSQL (base de datos)
Puerto 3306 → MySQL (base de datos)
```

**Concepto clave: EXPONER un puerto**

Cuando despliegas una aplicación, debes **exponer** los puertos necesarios:

```yaml
# docker-compose.yml
services:
  backend:
    ports:
      - "3000:3000"  # Puerto_Host:Puerto_Contenedor
```

Esto significa:
- El backend escucha internamente en el puerto 3000
- Lo exponemos al exterior también en el puerto 3000
- Ahora podemos acceder desde `http://localhost:3000`

**Importante:** 
- Solo expones los puertos que necesitan acceso externo
- La base de datos NO debe exponerse (solo accesible desde el backend)

---
