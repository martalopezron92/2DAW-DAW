# 1. Introducción al despliegue de aplicaciones web

### 1.1. ¿Qué significa desplegar?

**Desplegar** una aplicación web significa ponerla disponible para que usuarios reales puedan acceder a ella a través de Internet. Es el paso final que convierte tu código en un servicio funcionando 24/7.

En términos prácticos, desplegar implica:
- Subir tu código a un servidor
- Configurar los servicios necesarios (base de datos, servidor web, etc.)
- Asegurar que todo funcione correctamente en un entorno real
- Hacer que sea accesible mediante una URL

**¿Por qué es importante?** Porque una aplicación que solo funciona en tu ordenador no tiene ningún valor para los usuarios. El despliegue es lo que transforma tu proyecto en un producto real.

### 1.2. Diferencia entre desarrollo y producción

Existen dos entornos principales en el ciclo de vida de una aplicación:

| Aspecto | Desarrollo | Producción |
|---------|-----------|------------|
| **Objetivo** | Programar y probar | Servir a usuarios reales |
| **Ubicación** | Tu ordenador | Servidor remoto |
| **Configuración** | Flexible, con herramientas de debug | Optimizada, segura |
| **Datos** | Datos de prueba | Datos reales |
| **Errores** | Se muestran en detalle | Se ocultan al usuario |
| **Rendimiento** | No es prioritario | Crítico |

**Ejemplo práctico:**
- En **desarrollo**: usas `localhost:3000` y ves todos los errores en consola
- En **producción**: usas `www.tuapp.com` y los errores se registran en logs internos

### 1.3. Componentes mínimos de una aplicación web desplegada

Una aplicación web moderna típica necesita al menos estos componentes:

```
┌─────────────────────────────────────────────┐
│           APLICACIÓN WEB                    │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────┐      ┌──────────────┐   │
│  │   FRONTEND   │─────▶│   BACKEND    │   │
│  │  (HTML/CSS/  │      │  (API REST)  │   │
│  │   JS/React)  │◀─────│              │   │
│  └──────────────┘      └──────┬───────┘   │
│                                │            │
│                                ▼            │
│                        ┌──────────────┐    │
│                        │ BASE DE DATOS│    │
│                        │  (PostgreSQL)│    │
│                        └──────────────┘    │
│                                             │
└─────────────────────────────────────────────┘
```

**Componentes explicados:**

1. **Frontend**: La interfaz que ve el usuario (HTML, CSS, JavaScript)
   - Se ejecuta en el navegador del usuario
   - Hace peticiones al backend

2. **Backend**: La lógica de negocio y gestión de datos
   - Se ejecuta en el servidor
   - Procesa peticiones y responde con datos

3. **Base de datos**: Almacenamiento persistente de información
   - Guarda usuarios, productos, etc.
   - Solo accesible desde el backend

**¿Por qué esta separación?** 
- Permite que cada parte evolucione independientemente
- Facilita el escalado (puedes añadir más servidores backend sin tocar el frontend)
- Mejora la seguridad (la base de datos nunca está expuesta directamente)

---
