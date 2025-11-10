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

## 🎯 Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| **Código funcional** | 20% |
| **Documentación Javadoc completa** | 30% |
| **Javadoc generado correctamente** | 20% |
| **Documentación MkDocs** | 20% |
| **Integración Javadoc + MkDocs** | 10% |

### Bonus (+10% cada uno)
- ✨ Publicación en GitHub Pages
- ✨ Personalización avanzada del tema MkDocs
- ✨ Documentación especialmente clara y completa

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

### En este Repositorio
- `docs/javadoc-guia.md` - Guía completa de tags Javadoc
- `docs/mkdocs-personalizacion.md` - Personalización de MkDocs
- `src/CalculadoraBuena.java` - Ejemplo de código bien documentado

### Documentación Oficial
- [Javadoc Tool](https://docs.oracle.com/en/java/javase/11/tools/javadoc.html)
- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

---

## 🏆 Ejemplo Simplificado Completo

Si te quedas atascado, aquí tienes la estructura mínima:

**src/Ejemplo.java:**
```java
/**
 * Conversor de temperaturas.
 * @author Mi Nombre
 * @version 1.0
 */
public class Ejemplo {
    /**
     * Convierte Celsius a Fahrenheit.
     * @param celsius temperatura en Celsius
     * @return temperatura en Fahrenheit
     */
    public static double celsiusToFahrenheit(double celsius) {
        return (celsius * 9/5) + 32;
    }
    
    // ... más métodos ...
    
    public static void main(String[] args) {
        System.out.println("32°C = " + celsiusToFahrenheit(32) + "°F");
    }
}
```

**mkdocs.yml:**
```yaml
site_name: Mi Conversor
theme:
  name: material
nav:
  - 'Inicio': 'index.md'
  - 'API': 'api/index.html'
```

**docs/index.md:**
```markdown
# Mi Conversor de Temperaturas

Programa que convierte entre Celsius y Fahrenheit.
```

---

**¡Éxito con la actividad! Si tienes dudas, pregunta al profesor. 🚀**

---

## 📖 Parte 2: Documentar con Javadoc (20-30 min)

### Paso 2.1: Documentar el Código

**Documenta TODOS los elementos siguientes usando comentarios Javadoc:**

#### En cada CLASE:
- Descripción del propósito de la clase
- `@author` con tu nombre
- `@version` 1.0
- `@since` 1.0

#### En cada CONSTRUCTOR:
- Descripción breve de lo que inicializa
- `@param` para cada parámetro
- `@throws` si lanza excepciones

#### En cada MÉTODO PÚBLICO:
- Descripción de qué hace el método
- `@param` para cada parámetro con su significado
- `@return` describiendo qué devuelve (si no es void)
- `@throws` para cada excepción que pueda lanzar

#### En ATRIBUTOS públicos o constantes:
- Descripción del propósito del atributo

**Ejemplo de documentación esperada:**

```java
/**
 * Representa un libro en el sistema de biblioteca.
 * Esta clase almacena la información básica de un libro
 * y permite gestionar su disponibilidad.
 * 
 * @author Tu Nombre
 * @version 1.0
 * @since 1.0
 */
public class Libro {
    
    /**
     * Código ISBN del libro.
     */
    private String isbn;
    
    /**
     * Constructor que inicializa un libro con sus datos básicos.
     * 
     * @param titulo el título del libro (no puede estar vacío)
     * @param autor el nombre del autor (no puede estar vacío)
     * @param isbn el código ISBN único del libro
     * @throws IllegalArgumentException si algún parámetro es inválido
     */
    public Libro(String titulo, String autor, String isbn) {
        // implementación
    }
    
    /**
     * Marca el libro como prestado si está disponible.
     * 
     * @return true si se pudo prestar, false si ya estaba prestado
     * @see #devolver()
     */
    public boolean prestar() {
        // implementación
    }
}
```

**Resultado esperado:** Código completamente documentado con Javadoc en todos los elementos públicos.

### Paso 2.2: Generar Documentación Javadoc

**Tarea:**
1. Crea una carpeta `docs/api/` para la documentación
2. Ejecuta el comando javadoc con los parámetros adecuados
3. Verifica que se generó correctamente

**Comando esperado:**
```bash
javadoc -d docs/api -sourcepath src -subpackages . -encoding UTF-8 -charset UTF-8 -author -version
```

**Resultado esperado:**
- Carpeta `docs/api/` con archivos HTML
- Archivo `index.html` que abre en el navegador
- Documentación completa y legible de todas tus clases

### Paso 2.3: Revisar la Documentación

**Verificación:**
1. Abre `docs/api/index.html` en tu navegador
2. Navega por todas tus clases
3. Verifica que:
   - Aparecen descripciones claras
   - Los parámetros están documentados
   - Los returns están explicados
   - No hay enlaces rotos o warnings

**Resultado esperado:** Documentación técnica profesional y completa.

---

## 📘 Parte 3: Documentación de Usuario con MkDocs

### Paso 3.1: Crear Estructura MkDocs

**Tarea:**
1. Crea el archivo de configuración `mkdocs.yml` en la raíz del proyecto
2. Crea los archivos Markdown necesarios en `docs/`

**Estructura esperada:**
```
mi-sistema-gestion/
├── mkdocs.yml
├── docs/
│   ├── index.md
│   ├── instalacion.md
│   ├── guia-usuario.md
│   ├── ejemplos.md
│   └── api/               (ya existe del paso anterior)
│       └── index.html
```

### Paso 3.2: Configurar mkdocs.yml

**Tarea:** Crea un archivo `mkdocs.yml` con la siguiente estructura (personalízalo):

```yaml
site_name: [Tu título aquí]
site_description: [Tu descripción]
site_author: [Tu nombre]

theme:
  name: material
  language: es
  palette:
    primary: [elige un color]
    accent: [elige un color]
  features:
    - navigation.tabs
    - search.highlight
    - content.code.copy

nav:
  - 'Inicio': 'index.md'
  - 'Instalación': 'instalacion.md'
  - 'Guía de Usuario': 'guia-usuario.md'
  - 'Ejemplos': 'ejemplos.md'
  - '📚 Documentación API': 'api/index.html'

plugins:
  - search

markdown_extensions:
  - admonition
  - pymdownx.highlight
  - pymdownx.superfences
  - tables
  - toc:
      permalink: true
```

**Colores disponibles:** red, pink, purple, indigo, blue, teal, green, amber, orange

**Resultado esperado:** Archivo `mkdocs.yml` válido y personalizado.

### Paso 3.3: Crear index.md

**Contenido que debe incluir:**
- Título del proyecto
- Descripción general (2-3 párrafos)
- Características principales (lista)
- Captura o descripción del sistema
- Tecnologías utilizadas

**Ejemplo de estructura:**

```markdown
# Sistema de [Tu Sistema]

## Descripción

[Explica qué hace tu sistema y para qué sirve]

## Características

- ✅ Característica 1
- ✅ Característica 2
- ✅ Característica 3
- ✅ Característica 4

## Tecnologías

- Java 11+
- Javadoc para documentación API
- MkDocs con Material Theme
```

**Resultado esperado:** Página de inicio atractiva e informativa.

### Paso 3.4: Crear instalacion.md

**Contenido que debe incluir:**
1. **Requisitos previos**
   - Java JDK versión
   - Sistema operativo compatible
   
2. **Pasos de instalación**
   - Descargar el código
   - Compilar el proyecto
   - Ejecutar el programa

3. **Solución de problemas comunes**
   - Al menos 2 problemas típicos y sus soluciones

**Usa bloques de código para los comandos:**
````markdown
```bash
javac -d bin src/*.java
```
````

**Resultado esperado:** Guía clara paso a paso para instalar y ejecutar tu sistema.

### Paso 3.5: Crear guia-usuario.md

**Contenido que debe incluir:**

1. **Inicio del programa**
   - Cómo ejecutarlo
   - Primera pantalla que verá el usuario

2. **Funcionalidades principales**
   - Para cada operación del menú:
     - Qué hace
     - Cómo usarla
     - Qué esperar como resultado

3. **Casos de uso**
   - Al menos 2 escenarios de uso completos

**Usa admonitions para notas:**
```markdown
!!! tip "Consejo"
    Aquí va un consejo útil para el usuario

!!! warning "Advertencia"
    Aquí va una advertencia importante
```

**Resultado esperado:** Manual de usuario completo y fácil de seguir.

### Paso 3.6: Crear ejemplos.md

**Contenido que debe incluir:**

1. **Ejemplo 1: Caso de uso básico**
   - Descripción del escenario
   - Pasos a seguir
   - Resultado esperado

2. **Ejemplo 2: Caso de uso avanzado**
   - Escenario más complejo
   - Múltiples operaciones
   - Capturas o descripciones de salida

3. **Código de ejemplo** (si aplica)
   - Snippets de código relevantes
   - Explicación del código

**Resultado esperado:** Ejemplos prácticos que ayuden a entender el uso del sistema.

### Paso 3.7: Previsualizar MkDocs

**Tarea:**
1. Inicia el servidor de desarrollo de MkDocs
2. Abre la documentación en tu navegador
3. Navega por todas las páginas
4. Verifica enlaces, formato y contenido

**Comando esperado:**
```bash
python -m mkdocs serve
```

**Verificación:**
- ✅ Todas las páginas se cargan correctamente
- ✅ El enlace a la API de Javadoc funciona
- ✅ El tema se ve correctamente
- ✅ La búsqueda funciona
- ✅ No hay errores en la consola

**Resultado esperado:** Documentación completa visible en `http://localhost:8000`

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

## 🎯 Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| **Código funcional** | 20% |
| **Documentación Javadoc completa** | 30% |
| **Javadoc generado correctamente** | 20% |
| **Documentación MkDocs** | 20% |
| **Integración Javadoc + MkDocs** | 10% |

### Bonus (+10% cada uno)
- ✨ Publicación en GitHub Pages
- ✨ Personalización avanzada del tema MkDocs
- ✨ Documentación especialmente clara y completa

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

### En este Repositorio
- `docs/javadoc-guia.md` - Guía completa de tags Javadoc
- `docs/mkdocs-personalizacion.md` - Personalización de MkDocs
- `src/CalculadoraBuena.java` - Ejemplo de código bien documentado

### Documentación Oficial
- [Javadoc Tool](https://docs.oracle.com/en/java/javase/11/tools/javadoc.html)
- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

---

## 🏆 Ejemplo Simplificado Completo

Si te quedas atascado, aquí tienes la estructura mínima:

**src/Ejemplo.java:**
```java
/**
 * Conversor de temperaturas.
 * @author Mi Nombre
 * @version 1.0
 */
public class Ejemplo {
    /**
     * Convierte Celsius a Fahrenheit.
     * @param celsius temperatura en Celsius
     * @return temperatura en Fahrenheit
     */
    public static double celsiusToFahrenheit(double celsius) {
        return (celsius * 9/5) + 32;
    }
    
    // ... más métodos ...
    
    public static void main(String[] args) {
        System.out.println("32°C = " + celsiusToFahrenheit(32) + "°F");
    }
}
```

**mkdocs.yml:**
```yaml
site_name: Mi Conversor
theme:
  name: material
nav:
  - 'Inicio': 'index.md'
  - 'API': 'api/index.html'
```

**docs/index.md:**
```markdown
# Mi Conversor de Temperaturas

Programa que convierte entre Celsius y Fahrenheit.
```

---

**¡Éxito con la actividad! Si tienes dudas, pregunta al profesor. 🚀**
