# 5. Seguridad mínima en aplicaciones desplegadas

### 5.1. Buenas prácticas básicas

**Principio fundamental:** Minimizar la superficie de ataque.

#### **1. Principio de mínimo privilegio**
Solo da los permisos estrictamente necesarios.

```yaml
# ❌ MAL: Usuario root en contenedor
FROM node:18
USER root        # Vulnerable

# ✅ BIEN: Usuario sin privilegios
FROM node:18
USER node        # Más seguro
```

#### **2. Mantener dependencias actualizadas**
```bash
# Revisar vulnerabilidades en Node.js
npm audit

# Actualizar dependencias
npm update
```

#### **3. Validar entrada de usuarios**
```javascript
// ❌ MAL: Sin validación
app.post('/user', (req, res) => {
  db.query(`INSERT INTO users VALUES ('${req.body.name}')`);
});

// ✅ BIEN: Con validación
app.post('/user', (req, res) => {
  const { name } = req.body;
  if (!name || name.length > 100) {
    return res.status(400).json({ error: 'Invalid name' });
  }
  db.query('INSERT INTO users VALUES ($1)', [name]);
});
```

### 5.2. No exponer bases de datos

**Regla de oro:** La base de datos NUNCA debe ser accesible desde Internet.

```yaml
# ✅ CORRECTO
database:
  image: postgres:15
  # SIN 'ports' → No accesible desde fuera
  networks:
    - app-network

# ❌ INCORRECTO - ¡PELIGRO!
database:
  image: postgres:15
  ports:
    - "5432:5432"  # ← Expuesto a Internet
```

**¿Por qué?**
- Cualquiera podría intentar conectarse
- Aumenta el riesgo de ataques de fuerza bruta
- Puede exponer datos sensibles

**Acceso correcto:**
```
Internet ─────X────▶ Database (bloqueado)
                 
Backend  ──────✓───▶ Database (permitido)
```

### 5.3. Uso correcto de variables de entorno

#### **1. Nunca hardcodear credenciales**

```javascript
// ❌ MAL: Contraseña en el código
const db = new Client({
  password: 'mypassword123'
});

// ✅ BIEN: Contraseña en variable de entorno
const db = new Client({
  password: process.env.DB_PASSWORD
});
```

#### **2. Archivo .env en .gitignore**

```gitignore
# .gitignore
.env
.env.local
.env.production
```

#### **3. Proporcionar ejemplo sin datos reales**

```env
# .env.example (SÍ se sube a Git)
DB_USER=usuario
DB_PASSWORD=tu_password_aqui
API_KEY=tu_api_key_aqui
```

```env
# .env (NO se sube a Git)
DB_USER=admin
DB_PASSWORD=supersecreto123
API_KEY=abc123def456
```

### 5.4. Importancia de HTTPS (nivel conceptual)

**HTTP vs HTTPS:**

```
HTTP:   Cliente ──[datos en claro]──▶ Servidor
        ← Cualquiera puede leer los datos

HTTPS:  Cliente ──[datos cifrados]──▶ Servidor
        ← Solo cliente y servidor pueden leerlos
```

**¿Por qué es importante?**
- Protege contraseñas y datos sensibles
- Evita ataques "man in the middle"
- Google penaliza sitios sin HTTPS
- Los navegadores marcan HTTP como "No seguro"

**En producción:** Siempre usar HTTPS con certificado SSL/TLS.

**Herramientas comunes:**
- **Let's Encrypt**: Certificados SSL gratuitos
- **Cloudflare**: Proxy que añade HTTPS automáticamente
- **AWS Certificate Manager**: Para aplicaciones en AWS

**Nota:** En desarrollo local (localhost) no es necesario HTTPS, pero en producción es **obligatorio**.
