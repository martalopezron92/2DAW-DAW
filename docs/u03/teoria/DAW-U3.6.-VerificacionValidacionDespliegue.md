
# 6. Verificación y validación del despliegue

### 6.1. Comprobaciones básicas

Después de desplegar, debes verificar que todo funciona correctamente.

#### **1. Verificar que los contenedores están corriendo**

```bash
docker-compose ps
```

Deberías ver algo como:
```
NAME                SERVICE    STATUS     PORTS
myapp-frontend-1    frontend   Up         0.0.0.0:60->60/tcp
myapp-backend-1     backend    Up         0.0.0.0:3000->3000/tcp
myapp-database-1    database   Up         5432/tcp
```

**¿Qué revisar?**
- STATUS debe ser "Up"
- PORTS debe mostrar los puertos correctos

#### **2. Verificar logs de cada servicio**

```bash
# Ver logs del backend
docker-compose logs backend

# Ver logs en tiempo real
docker-compose logs -f backend
```

**Busca:**
- ✅ Mensajes de inicio exitoso
- ❌ Errores de conexión
- ❌ Excepciones o stack traces

### 6.2. Acceso desde navegador

#### **1. Probar el frontend**
Abre el navegador y ve a:
```
http://localhost
```

**Debe mostrar:** La interfaz de tu aplicación.

#### **2. Probar la API directamente**
```
http://localhost:3000/api/productos
```

**Debe devolver:** JSON con datos (si hay datos en la BD).

#### **3. Revisar la consola del navegador**
Abre las herramientas de desarrollo (F12) y revisa:
- **Console**: No debe haber errores
- **Network**: Las peticiones deben devolver 200 OK

### 6.3. Revisión de logs

#### **Logs del backend**
```bash
docker-compose logs backend | tail -50
```

**Busca:**
- ✅ "Server listening on port 3000"
- ✅ "Database connected"
- ❌ "Error: Connection refused"
- ❌ "TypeError: Cannot read property..."

#### **Logs de la base de datos**
```bash
docker-compose logs database | tail -50
```

**Busca:**
- ✅ "database system is ready to accept connections"
- ❌ "FATAL: password authentication failed"

#### **Logs del frontend (Nginx)**
```bash
docker-compose logs frontend | tail -50
```

**Busca:**
- ✅ Peticiones GET con código 200
- ❌ Códigos 404 o 500

### 6.4. Checklist de aplicación correctamente desplegada

Usa este checklist para validar tu despliegue:

#### **✅ Infraestructura**
- [ ] Todos los contenedores están en estado "Up"
- [ ] Los puertos están correctamente expuestos
- [ ] Las redes Docker están configuradas
- [ ] Los volúmenes están montados correctamente

#### **✅ Conectividad**
- [ ] El frontend es accesible desde el navegador
- [ ] El backend responde a peticiones API
- [ ] El backend se conecta correctamente a la base de datos
- [ ] No hay errores de CORS

#### **✅ Seguridad**
- [ ] La base de datos NO está expuesta públicamente
- [ ] Las variables de entorno están configuradas
- [ ] El archivo .env NO está en Git
- [ ] No hay contraseñas hardcodeadas en el código

#### **✅ Funcionalidad**
- [ ] La aplicación carga correctamente
- [ ] Se pueden crear/leer/actualizar/eliminar datos
- [ ] No hay errores en la consola del navegador
- [ ] Los logs no muestran errores críticos

#### **✅ Rendimiento básico**
- [ ] La aplicación carga en menos de 3 segundos
- [ ] Las peticiones API responden rápidamente
- [ ] No hay fugas de memoria evidentes

### 6.5. Qué hacer si algo falla

#### **Problema: Contenedor no arranca**
```bash
# Ver por qué falló
docker-compose logs [servicio]

# Reiniciar el servicio
docker-compose restart [servicio]

# Reconstruir desde cero
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

#### **Problema: Base de datos sin conexión**
```bash
# Verificar que el contenedor está activo
docker-compose ps database

# Ver logs de la BD
docker-compose logs database

# Verificar variables de entorno
docker-compose config
```

#### **Problema: Frontend no carga**
```bash
# Verificar que los archivos están en el lugar correcto
docker-compose exec frontend ls -la /usr/share/nginx/html

# Ver configuración de Nginx
docker-compose exec frontend cat /etc/nginx/conf.d/default.conf
```

#### **Problema: Cambios no se reflejan**
```bash
# Reconstruir y reiniciar
docker-compose down
docker-compose build
docker-compose up -d

# Limpiar caché de Docker
docker system prune -a
```

---
