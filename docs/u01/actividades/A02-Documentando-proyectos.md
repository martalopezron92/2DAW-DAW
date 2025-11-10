# Actividad: Documentación Automática con Javadoc y MkDocs

## 📋 Descripción

En esta actividad crearás un programa Java sencillo (una calculadora avanzada, conversor de unidades, o similar), lo documentarás usando **Javadoc** y crearás una guía de usuario con **MkDocs**. El objetivo es aprender el proceso de generación automática de documentación.

**Duración estimada:** 1-2 horas de clase

---

## 🎯 Objetivos de Aprendizaje

- Documentar código Java con comentarios Javadoc
- Generar documentación HTML automática con Javadoc
- Crear documentación de usuario básica con MkDocs
- Integrar ambas documentaciones en un único sitio
- (Opcional) Publicar en GitHub Pages

---

## 🛠️ Requisitos Previos

### Software Necesario

1. **JDK 11 o superior**
   - Verificar instalación: `java -version` y `javac -version`

2. **Python 3.8 o superior**
   - Verificar instalación: `python --version`

3. **Editor de código** (VS Code, IntelliJ, Eclipse, o cualquiera)

### Paquetes Python a Instalar

```bash
python -m pip install --user mkdocs
python -m pip install --user mkdocs-material
```

Verificar instalación:
```bash
python -m mkdocs --version
```

**Nota:** Si tienes problemas de permisos, usa siempre `python -m pip install --user` y ejecuta comandos como `python -m mkdocs` en lugar de solo `mkdocs`.

---

## 📚 Parte 1: Crear el Programa Java (20-30 min)

### Paso 1.1: Estructura del Proyecto

Crea la siguiente estructura de carpetas:

```
mi-proyecto-doc/
├── src/
└── docs/
```

**Comandos (PowerShell):**
```powershell
mkdir mi-proyecto-doc
cd mi-proyecto-doc
mkdir src, docs
```

### Paso 1.2: Elegir y Crear tu Programa

**Elige UNA de estas opciones (o propón una similar):**

#### Opción A: Calculadora Científica
Clase con métodos: `sumar()`, `restar()`, `multiplicar()`, `dividir()`, `potencia()`, `raizCuadrada()`

#### Opción B: Conversor de Unidades
Clase con métodos: `kmAMillas()`, `millasAKm()`, `celsiusAFahrenheit()`, `fahrenheitACelsius()`, `kgALibras()`, `librasAKg()`

#### Opción C: Generador de Contraseñas
Clase con métodos: `generarSimple()`, `generarSegura()`, `validarFuerza()`, `generarConReglas()`

#### Opción D: Validador de Datos
Clase con métodos: `validarEmail()`, `validarTelefono()`, `validarDNI()`, `validarCodigoPostal()`

### Paso 1.3: Estructura del Código

**Crea UN archivo Java en `src/` con:**

1. **Una clase con nombre descriptivo** (ej: `CalculadoraCientifica.java`)
2. **6-8 métodos públicos** con diferentes funcionalidades
3. **Un método `main`** con menú simple para probar

**Ejemplo de estructura (NO copiar literalmente):**

```java
// src/MiClase.java
public class MiClase {
    
    /**
     * Aquí irá tu documentación Javadoc
     */
    public static double metodo1(double a, double b) {
        // tu código
        return resultado;
    }
    
    /**
     * Aquí irá tu documentación Javadoc
     */
    public static String metodo2(String texto) {
        // tu código
        return resultado;
    }
    
    // Más métodos...
    
    public static void main(String[] args) {
        // Menú simple para probar tus métodos
        System.out.println("=== Mi Programa ===");
        System.out.println("1. Opción 1");
        System.out.println("2. Opción 2");
        // etc...
    }
}
```

**Requisitos mínimos:**
- ✅ Al menos 6 métodos públicos diferentes
- ✅ Métodos con parámetros
- ✅ Métodos que devuelvan valores
- ✅ Al menos un método que lance una excepción
- ✅ Código que compile sin errores

### Paso 1.4: Compilar y Probar

```bash
# Compilar
javac src/*.java

# Ejecutar
java -cp src NombreDeTuClase
```

**Verificación:** El programa debe ejecutarse y mostrar resultados correctos.

---

## 📖 Parte 2: Documentar con Javadoc (20-30 min)

### Paso 2.1: ¿Qué Documentar?

**Documenta estos elementos con comentarios Javadoc (`/** */`):**

#### 1. La Clase Principal
```java
/**
 * Breve descripción de qué hace la clase.
 * Puede incluir más detalles en líneas adicionales.
 * 
 * @author Tu Nombre
 * @version 1.0
 */
public class MiClase {
```

#### 2. Cada Método Público
```java
/**
 * Descripción clara de qué hace el método.
 * 
 * @param nombreParam descripción del parámetro
 * @param otroParam descripción del otro parámetro
 * @return descripción de qué devuelve
 * @throws TipoExcepcion cuándo se lanza la excepción
 */
public static double miMetodo(double nombreParam, double otroParam) throws TipoExcepcion {
```

### Paso 2.2: Ejemplo Completo de Documentación

```java
/**
 * Calculadora científica con operaciones matemáticas básicas y avanzadas.
 * Proporciona métodos estáticos para realizar cálculos sin necesidad de instanciar la clase.
 * 
 * @author Juan Pérez
 * @version 1.0
 */
public class CalculadoraCientifica {
    
    /**
     * Suma dos números.
     * 
     * @param a primer número
     * @param b segundo número
     * @return la suma de a y b
     */
    public static double sumar(double a, double b) {
        return a + b;
    }
    
    /**
     * Divide dos números.
     * 
     * @param dividendo el número a dividir
     * @param divisor el número por el cual dividir
     * @return el resultado de la división
     * @throws ArithmeticException si el divisor es cero
     */
    public static double dividir(double dividendo, double divisor) throws ArithmeticException {
        if (divisor == 0) {
            throw new ArithmeticException("No se puede dividir por cero");
        }
        return dividendo / divisor;
    }
    
    /**
     * Calcula la potencia de un número.
     * 
     * @param base la base de la potencia
     * @param exponente el exponente de la potencia
     * @return el resultado de elevar base a exponente
     * @see Math#pow(double, double)
     */
    public static double potencia(double base, double exponente) {
        return Math.pow(base, exponente);
    }
    
    // ... más métodos documentados
}
```

### Paso 2.3: Tags Importantes

| Tag | Uso | Ejemplo |
|-----|-----|---------|
| `@param` | Cada parámetro del método | `@param edad la edad del usuario` |
| `@return` | Qué devuelve el método | `@return true si es válido` |
| `@throws` | Excepciones que lanza | `@throws IOException si falla lectura` |
| `@author` | Autor de la clase | `@author María López` |
| `@version` | Versión de la clase | `@version 1.0` |
| `@see` | Referencias relacionadas | `@see #otroMetodo()` |

### Paso 2.4: Generar Documentación Javadoc

**Ejecuta este comando desde la carpeta raíz del proyecto:**

```bash
javadoc -d docs/api -sourcepath src -subpackages . -encoding UTF-8 -charset UTF-8 -author -version
```

**Explicación del comando:**
- `-d docs/api` → carpeta de salida
- `-sourcepath src` → dónde está el código
- `-encoding UTF-8` → codificación de caracteres
- `-author -version` → incluir autor y versión

**Resultado esperado:**
- Carpeta `docs/api/` creada con archivos HTML
- Archivo `docs/api/index.html` que puedes abrir en el navegador

### Paso 2.5: Verificar Javadoc

1. Abre `docs/api/index.html` en tu navegador
2. Verifica que aparezcan:
   - ✅ Tu clase principal
   - ✅ Todos tus métodos
   - ✅ Descripciones de parámetros
   - ✅ Valores de retorno
   - ✅ Excepciones

**Si ves warnings:** Revisa que todos los parámetros tengan `@param` y todos los returns tengan `@return`.

---

## 📘 Parte 3: Documentación de Usuario con MkDocs (20-30 min)

### Paso 3.1: Crear mkdocs.yml

Crea un archivo `mkdocs.yml` en la raíz del proyecto:

```yaml
site_name: Mi Programa - Documentación
site_author: Tu Nombre

theme:
  name: material
  language: es
  palette:
    primary: blue
    accent: indigo
  features:
    - navigation.tabs
    - search.highlight

nav:
  - 'Inicio': 'index.md'
  - 'Guía de Uso': 'guia-uso.md'
  - '📚 API Javadoc': 'api/index.html'

plugins:
  - search

markdown_extensions:
  - admonition
  - pymdownx.highlight
  - pymdownx.superfences
  - tables
```

### Paso 3.2: Crear index.md

Crea `docs/index.md`:

```markdown
# Mi Programa

## Descripción

[Explica brevemente qué hace tu programa - 2-3 líneas]

## Características

- ✅ Funcionalidad 1
- ✅ Funcionalidad 2
- ✅ Funcionalidad 3
- ✅ Funcionalidad 4

## Tecnologías

- Java 11+
- Documentación generada con Javadoc
- Sitio creado con MkDocs Material

## Navegación

- **Guía de Uso**: Instrucciones paso a paso
- **API Javadoc**: Documentación técnica completa
```

### Paso 3.3: Crear guia-uso.md

Crea `docs/guia-uso.md`:

```markdown
# Guía de Uso

## Requisitos

- Java JDK 11 o superior instalado
- Terminal o línea de comandos

## Compilación

Para compilar el programa:

\```bash
javac src/*.java
\```

## Ejecución

Para ejecutar el programa:

\```bash
java -cp src NombreDeTuClase
\```

## Funcionalidades

### Funcionalidad 1: [Nombre]

[Explicación de qué hace]

**Ejemplo:**
\```
Input: valor1, valor2
Output: resultado
\```

### Funcionalidad 2: [Nombre]

[Explicación de qué hace]

**Ejemplo:**
\```
Input: valor
Output: resultado
\```

### Funcionalidad 3: [Nombre]

[Explicación de qué hace]

!!! warning "Advertencia"
    [Alguna advertencia importante si aplica]

## Ejemplos de Uso

### Ejemplo 1: Caso básico
\```
[Muestra un ejemplo real de uso]
\```

### Ejemplo 2: Caso con error
\```
[Muestra qué pasa con entradas inválidas]
\```
```

### Paso 3.4: Previsualizar con MkDocs

**Inicia el servidor de desarrollo:**

```bash
python -m mkdocs serve
```

**Abre tu navegador en:** `http://localhost:8000`

**Verificación:**
- ✅ Se ven las 3 páginas en el menú
- ✅ El contenido se muestra correctamente
- ✅ El enlace a Javadoc funciona
- ✅ El tema Material se aplica correctamente

### Paso 3.5: Construir el Sitio

**Genera la versión estática:**

```bash
python -m mkdocs build
```

**Resultado:** Carpeta `site/` con todo el HTML generado.

---

## 🚀 Parte 4 (Opcional): Publicar en GitHub Pages (10-15 min)

Si tienes tiempo y cuenta de GitHub, puedes publicar tu documentación online.

### Paso 4.1: Crear Repositorio

1. Ve a [GitHub](https://github.com) e inicia sesión
2. Crea un nuevo repositorio público
3. NO inicialices con README (ya lo tienes localmente)

### Paso 4.2: Subir tu Código

```bash
git init
git add .
git commit -m "Proyecto con documentación completa"
git remote add origin https://github.com/TU-USUARIO/TU-REPO.git
git branch -M main
git push -u origin main
```

### Paso 4.3: Publicar con MkDocs

```bash
python -m mkdocs gh-deploy
```

Este comando:
- Construye el sitio
- Crea la rama `gh-pages`
- Sube la documentación

### Paso 4.4: Configurar GitHub Pages

1. Ve a tu repositorio en GitHub
2. Settings → Pages
3. Source: Branch `gh-pages`, carpeta `/ (root)`
4. Save

**Espera 2-5 minutos** y tu documentación estará en:
`https://tu-usuario.github.io/tu-repo/`

---

---

## ✅ Verificación Final

### Checklist Obligatorio

- [ ] Código Java compilable y funcional
- [ ] Mínimo 6 métodos documentados con Javadoc
- [ ] Javadoc generado correctamente en `docs/api/`
- [ ] Archivo `mkdocs.yml` configurado
- [ ] Archivo `index.md` creado
- [ ] Archivo `guia-uso.md` creado
- [ ] Enlace a Javadoc funcionando en MkDocs
- [ ] Sitio MkDocs previsualizado correctamente

### Checklist Opcional (GitHub Pages)

- [ ] Repositorio creado en GitHub
- [ ] Código subido con `git push`
- [ ] Documentación publicada con `mkdocs gh-deploy`
- [ ] GitHub Pages configurado y funcionando

---

## 📤 Entrega

**Formato de entrega:**

1. **Carpeta comprimida** con:
   - Código fuente en `src/`
   - Javadoc generado en `docs/api/`
   - Archivos MkDocs en `docs/`
   - Archivo `mkdocs.yml`
   - Sitio generado en `site/`

2. **O enlace a repositorio GitHub** (opcional):
   - URL del repositorio
   - URL de GitHub Pages (si lo publicaste)

**Nombra el archivo:** `Apellido_Nombre_Documentacion.zip`

---

## 💡 Consejos Rápidos

### Para Javadoc
- ✅ Documenta MIENTRAS escribes el código, no después
- ✅ Sé claro y conciso en las descripciones
- ✅ No olvides documentar los parámetros y returns
- ✅ Incluye `@throws` para las excepciones

### Para MkDocs
- ✅ Usa lenguaje simple en la guía de usuario
- ✅ Incluye ejemplos prácticos
- ✅ Verifica que el enlace a Javadoc funcione
- ✅ Usa `python -m mkdocs serve` para previsualizar

### General
- ✅ Guarda y compila frecuentemente
- ✅ Prueba cada método antes de seguir
- ✅ Si algo no funciona, lee el mensaje de error completo

---

## ❓ Solución de Problemas

### Javadoc no genera archivos

**Problema:** El comando javadoc no hace nada o da error.

**Solución:**
- Verifica que estés en la carpeta raíz del proyecto
- Comprueba que tus archivos `.java` están en `src/`
- Asegúrate de que el código compile sin errores

### MkDocs no encuentra el tema Material

**Error:** `ERROR - Config value 'theme': Unrecognised theme name: 'material'`

**Solución:**
```bash
python -m pip install --user mkdocs-material
```

### El enlace a Javadoc no funciona

**Problema:** Click en "API Javadoc" muestra 404.

**Solución:**
- Verifica que `docs/api/index.html` existe
- En `mkdocs.yml`, la ruta debe ser exactamente: `'api/index.html'`
- Regenera Javadoc si es necesario

### No puedo ejecutar `mkdocs`

**Error:** `'mkdocs' no se reconoce como comando...`

**Solución:**
Usa siempre: `python -m mkdocs` en lugar de solo `mkdocs`

---

## 📚 Recursos de Referencia

### Documentación Oficial
- [Javadoc Tool](https://docs.oracle.com/en/java/javase/11/tools/javadoc.html)
- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

---

