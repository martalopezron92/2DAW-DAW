# Guía de Javadoc: Tags y Buenas Prácticas

## ¿Qué es Javadoc?

Javadoc es la herramienta estándar para generar documentación HTML a partir de comentarios en el código fuente Java. Utiliza comentarios especiales que comienzan con `/**` y terminan con `*/`.

## Tags Principales de Javadoc

### 1. `@author`

**Función:** Especifica el autor de la clase o interfaz.

**Sintaxis:**
```java
@author Nombre del Autor
```

**Ejemplo:**
```java
/**
 * Clase que implementa operaciones matemáticas básicas.
 * 
 * @author Marta López
 */
public class Calculadora {
    // ...
}
```

---

### 2. `@version`

**Función:** Indica la versión actual de la clase o interfaz.

**Sintaxis:**
```java
@version número de versión
```

**Ejemplo:**
```java
/**
 * Gestor de base de datos para el sistema de inventario.
 * 
 * @author Juan Pérez
 * @version 2.1.0
 */
public class DatabaseManager {
    // ...
}
```

---

### 3. `@param`

**Función:** Documenta un parámetro de un método o constructor. Debe incluirse uno por cada parámetro.

**Sintaxis:**
```java
@param nombreParametro descripción del parámetro
```

**Ejemplo:**
```java
/**
 * Calcula el área de un rectángulo.
 * 
 * @param base la base del rectángulo en metros
 * @param altura la altura del rectángulo en metros
 * @return el área del rectángulo en metros cuadrados
 */
public double calcularArea(double base, double altura) {
    return base * altura;
}
```

---

### 4. `@return`

**Función:** Describe el valor que devuelve un método. No se usa en constructores ni en métodos `void`.

**Sintaxis:**
```java
@return descripción del valor devuelto
```

**Ejemplo:**
```java
/**
 * Obtiene el nombre completo del usuario.
 * 
 * @return una cadena con el nombre y apellidos del usuario
 */
public String getNombreCompleto() {
    return this.nombre + " " + this.apellidos;
}
```

---

### 5. `@throws` o `@exception`

**Función:** Documenta las excepciones que puede lanzar un método. Incluir una por cada tipo de excepción.

**Sintaxis:**
```java
@throws TipoExcepcion descripción de cuándo se lanza
```

**Ejemplo:**
```java
/**
 * Divide dos números enteros.
 * 
 * @param dividendo el número a dividir
 * @param divisor el número por el cual dividir
 * @return el resultado de la división
 * @throws ArithmeticException si el divisor es cero
 */
public int dividir(int dividendo, int divisor) throws ArithmeticException {
    if (divisor == 0) {
        throw new ArithmeticException("No se puede dividir por cero");
    }
    return dividendo / divisor;
}
```

---

### 6. `@see`

**Función:** Crea una referencia cruzada a otra clase, método o URL relacionada.

**Sintaxis:**
```java
@see ClaseRelacionada
@see ClaseRelacionada#metodo
@see <a href="URL">texto del enlace</a>
```

**Ejemplo:**
```java
/**
 * Valida un email según RFC 5322.
 * 
 * @param email la dirección de email a validar
 * @return true si el email es válido, false en caso contrario
 * @see #validarTelefono(String)
 * @see <a href="https://tools.ietf.org/html/rfc5322">RFC 5322</a>
 */
public boolean validarEmail(String email) {
    // ...
}
```

---

### 7. `@deprecated`

**Función:** Marca un elemento como obsoleto, indicando que no debería usarse.

**Sintaxis:**
```java
@deprecated explicación y alternativa recomendada
```

**Ejemplo:**
```java
/**
 * Calcula el precio con descuento.
 * 
 * @param precio el precio original
 * @param descuento el porcentaje de descuento
 * @return el precio final
 * @deprecated Este método está obsoleto. Utilizar {@link #calcularPrecioFinal(double, double)} en su lugar.
 */
@Deprecated
public double calcularPrecio(double precio, double descuento) {
    return precio * (1 - descuento / 100);
}
```

---

### 8. `@since`

**Función:** Indica en qué versión se añadió la clase, método o campo.

**Sintaxis:**
```java
@since versión
```

**Ejemplo:**
```java
/**
 * Exporta los datos a formato JSON.
 * 
 * @param datos los datos a exportar
 * @return una cadena JSON con los datos
 * @since 1.5.0
 */
public String exportarJSON(List<String> datos) {
    // ...
}
```

---

### 9. `{@link}` y `{@linkplain}`

**Función:** Crea un enlace inline a otra clase o método dentro de la documentación.

**Sintaxis:**
```java
{@link Clase#metodo}
{@linkplain Clase#metodo texto alternativo}
```

**Ejemplo:**
```java
/**
 * Procesa un pago utilizando el sistema de validación.
 * Este método internamente llama a {@link #validarTarjeta(String)} 
 * antes de procesar la transacción.
 * 
 * @param monto el monto a procesar
 * @return true si el pago fue exitoso
 */
public boolean procesarPago(double monto) {
    // ...
}
```

---

### 10. `{@code}` y `{@literal}`

**Función:** Muestra texto en formato de código sin procesar HTML.

**Sintaxis:**
```java
{@code código o texto}
{@literal texto literal}
```

**Ejemplo:**
```java
/**
 * Valida que el parámetro no sea nulo.
 * Ejemplo de uso: {@code validarNoNulo(objeto, "El objeto no puede ser nulo")}
 * 
 * @param objeto el objeto a validar
 * @param mensaje mensaje de error si es nulo
 * @throws IllegalArgumentException si el objeto es {@code null}
 */
public void validarNoNulo(Object objeto, String mensaje) {
    // ...
}
```

---

## Aspectos que Hay que Comentar

### 1. **Clases e Interfaces**

Documenta:
- Propósito general de la clase
- Responsabilidades principales
- Autor y versión
- Relaciones con otras clases importantes

```java
/**
 * Representa un producto en el sistema de inventario.
 * Esta clase gestiona la información básica del producto,
 * incluyendo nombre, precio, stock y categoría.
 * 
 * @author Carlos Martínez
 * @version 1.0.0
 * @since 1.0.0
 * @see Categoria
 * @see Inventario
 */
public class Producto {
    // ...
}
```

### 2. **Métodos Públicos y Protegidos**

Documenta:
- Qué hace el método (breve y claro)
- Todos los parámetros con `@param`
- Valor de retorno con `@return`
- Excepciones con `@throws`
- Efectos secundarios importantes

```java
/**
 * Actualiza el stock del producto.
 * Este método ajusta la cantidad disponible y registra 
 * el movimiento en el historial.
 * 
 * @param cantidad la cantidad a añadir (positiva) o restar (negativa)
 * @throws IllegalArgumentException si la cantidad resultante es negativa
 * @throws DatabaseException si hay un error al guardar en la base de datos
 * @see #getStock()
 */
public void actualizarStock(int cantidad) throws IllegalArgumentException, DatabaseException {
    // ...
}
```

### 3. **Constructores**

Documenta:
- Propósito del constructor
- Todos los parámetros
- Excepciones que puede lanzar
- Estado inicial del objeto

```java
/**
 * Crea un nuevo producto con los datos especificados.
 * El stock inicial se establece a cero.
 * 
 * @param nombre el nombre del producto (no puede estar vacío)
 * @param precio el precio unitario (debe ser mayor que cero)
 * @param categoria la categoría del producto (no puede ser null)
 * @throws IllegalArgumentException si algún parámetro no es válido
 */
public Producto(String nombre, double precio, Categoria categoria) {
    // ...
}
```

### 4. **Atributos Públicos y Constantes**

Documenta:
- Propósito del campo
- Valores válidos o restricciones
- Unidades de medida si aplica

```java
/**
 * Tasa de IVA aplicable a los productos.
 * Valor expresado en decimal (0.21 representa 21%).
 */
public static final double IVA = 0.21;

/**
 * Número máximo de intentos de conexión antes de fallar.
 */
public static final int MAX_REINTENTOS = 3;
```

### 5. **Enumeraciones**

Documenta:
- Propósito de la enumeración
- Cada valor del enum

```java
/**
 * Estados posibles de un pedido en el sistema.
 */
public enum EstadoPedido {
    /**
     * El pedido ha sido creado pero no confirmado.
     */
    PENDIENTE,
    
    /**
     * El pedido ha sido confirmado y está en proceso.
     */
    PROCESANDO,
    
    /**
     * El pedido ha sido enviado al cliente.
     */
    ENVIADO,
    
    /**
     * El pedido ha sido entregado satisfactoriamente.
     */
    ENTREGADO,
    
    /**
     * El pedido ha sido cancelado.
     */
    CANCELADO
}
```

---

## Ejemplo Completo

```java
package com.ejemplo.tienda;

import java.util.ArrayList;
import java.util.List;

/**
 * Gestiona el carrito de compras de un usuario.
 * Permite añadir, eliminar y calcular el total de productos.
 * 
 * @author Ana García
 * @version 2.0.0
 * @since 1.0.0
 */
public class CarritoCompras {
    
    /**
     * Lista de productos en el carrito.
     */
    private List<Producto> productos;
    
    /**
     * Descuento aplicable al total (en porcentaje).
     */
    private double descuento;
    
    /**
     * Crea un carrito de compras vacío sin descuento.
     */
    public CarritoCompras() {
        this.productos = new ArrayList<>();
        this.descuento = 0.0;
    }
    
    /**
     * Crea un carrito de compras vacío con un descuento inicial.
     * 
     * @param descuento el porcentaje de descuento (entre 0 y 100)
     * @throws IllegalArgumentException si el descuento no está en el rango válido
     */
    public CarritoCompras(double descuento) {
        this();
        if (descuento < 0 || descuento > 100) {
            throw new IllegalArgumentException("El descuento debe estar entre 0 y 100");
        }
        this.descuento = descuento;
    }
    
    /**
     * Añade un producto al carrito.
     * 
     * @param producto el producto a añadir (no puede ser null)
     * @throws IllegalArgumentException si el producto es null
     * @see #eliminarProducto(Producto)
     */
    public void añadirProducto(Producto producto) {
        if (producto == null) {
            throw new IllegalArgumentException("El producto no puede ser null");
        }
        productos.add(producto);
    }
    
    /**
     * Elimina un producto del carrito.
     * 
     * @param producto el producto a eliminar
     * @return true si el producto fue eliminado, false si no estaba en el carrito
     * @see #añadirProducto(Producto)
     */
    public boolean eliminarProducto(Producto producto) {
        return productos.remove(producto);
    }
    
    /**
     * Calcula el precio total del carrito aplicando el descuento.
     * El cálculo incluye el IVA de cada producto.
     * 
     * @return el precio total con descuento e IVA incluidos
     * @see Producto#getPrecioConIVA()
     */
    public double calcularTotal() {
        double subtotal = productos.stream()
            .mapToDouble(Producto::getPrecioConIVA)
            .sum();
        
        return subtotal * (1 - descuento / 100);
    }
    
    /**
     * Obtiene el número de productos en el carrito.
     * 
     * @return la cantidad de productos
     */
    public int getCantidadProductos() {
        return productos.size();
    }
    
    /**
     * Vacía el carrito eliminando todos los productos.
     * El descuento se mantiene.
     */
    public void vaciar() {
        productos.clear();
    }
    
    /**
     * Establece el descuento aplicable al carrito.
     * 
     * @param descuento el porcentaje de descuento (entre 0 y 100)
     * @throws IllegalArgumentException si el descuento no está en el rango válido
     */
    public void setDescuento(double descuento) {
        if (descuento < 0 || descuento > 100) {
            throw new IllegalArgumentException("El descuento debe estar entre 0 y 100");
        }
        this.descuento = descuento;
    }
}
```

---

## Buenas Prácticas

### ✅ **Hacer**

1. **Ser conciso pero completo**: Explica qué hace, no cómo lo hace
2. **Documentar contratos**: Especifica precondiciones, postcondiciones y efectos secundarios
3. **Usar presente de indicativo**: "Calcula el total" en lugar de "Calculará el total"
4. **Documentar excepciones**: Indica cuándo y por qué se lanzan
5. **Actualizar la documentación**: Mantenerla sincronizada con el código
6. **Usar `{@code}` para ejemplos**: Mejora la legibilidad del código inline

### ❌ **Evitar**

1. **Obviedades**: No documentar `getName()` como "Obtiene el nombre"
2. **Comentarios desactualizados**: Peor que ningún comentario
3. **Repetir el código**: La documentación debe añadir valor, no repetir
4. **Detalles de implementación**: Enfocarse en el "qué", no en el "cómo"
5. **Documentar métodos privados innecesariamente**: Solo si son complejos

---

## Generación de Documentación

Para generar la documentación HTML:

```bash
javadoc -d docs/api -sourcepath src -subpackages com.ejemplo
```

Parámetros:
- `-d docs/api`: directorio de salida
- `-sourcepath src`: ruta del código fuente
- `-subpackages com.ejemplo`: paquetes a incluir

---

## Resumen de Tags Esenciales

| Tag | Nivel | Propósito |
|-----|-------|-----------|
| `@author` | Clase | Autor del código |
| `@version` | Clase | Versión de la clase |
| `@param` | Método | Parámetros del método |
| `@return` | Método | Valor de retorno |
| `@throws` | Método | Excepciones lanzadas |
| `@see` | Todos | Referencias cruzadas |
| `@since` | Todos | Versión de introducción |
| `@deprecated` | Todos | Marcar como obsoleto |
| `{@link}` | Inline | Enlaces a otras clases |
| `{@code}` | Inline | Código inline |

