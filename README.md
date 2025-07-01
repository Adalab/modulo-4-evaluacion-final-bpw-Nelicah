# API REST sobre frases de los Simpsons

## Instrucciones

- Se puede ver las tablas y relacion de tablas abriendo los archivos de la carpeta **data** con MySQL Workbech o algún programa similar que lea tipo de archivos **.mwb** y **.sql**

- El funcionamiento de la API se podría ver con el programa **Postman** y desde el Visual Studio Code: clonando este repositorio o haciendo fork, creando un archivo **.env** localmente para añadir los datos correspondientes que arranquen el servidor, instalando los módulos de node y el resto de bibliotecas con **npm i express cors mysql2 dotenv** y arrancando el servidor.

---

## 📊 Estructura de la base de datos

A continuación se describen las tres tablas principales del sistema:

### 1. 🗨️ Tabla: `frases`

| Campo          | Tipo | Descripción                                                   |
| -------------- | ---- | ------------------------------------------------------------- |
| `id`           | INT  | Clave primaria.                                               |
| `texto`        | TEXT | Frase completa. **Obligatorio.**                              |
| `marca_tiempo` | TIME | Minuto y segundo en que aparece la frase (puede estar vacío). |
| `descripcion`  | TEXT | Información adicional o curiosidades (opcional).              |

---

### 2. 👤 Tabla: `personajes`

| Campo         | Tipo   | Descripción                         |
| ------------- | ------ | ----------------------------------- |
| `id`          | INT    | Clave primaria.                     |
| `nombre`      | STRING | Nombre del personaje.               |
| `apellido`    | STRING | Apellido (ej: Simpson, Bouvier...). |
| `ocupacion`   | STRING | Ocupación del personaje.            |
| `descripcion` | TEXT   | Descripción del personaje.          |

---

### 3. 🎬 Tabla: `capitulos`

| Campo             | Tipo   | Descripción                               |
| ----------------- | ------ | ----------------------------------------- |
| `id`              | INT    | Clave primaria.                           |
| `titulo`          | STRING | Título del episodio.                      |
| `numero_episodio` | INT    | Número del episodio en la serie.          |
| `temporada`       | INT    | Temporada a la que pertenece el episodio. |
| `fecha_emision`   | DATE   | Fecha de emisión original.                |
| `sinopsis`        | TEXT   | Breve resumen del episodio.               |

---

## 🔗 Endpoints de la API

### 🔤 Frases

#### 📥 Crear una nueva frase

**POST** `/api/frases`

#### 📃 Listar todas las frases

**GET** `/api/frases`
Devuelve una lista de frases con información del personaje y capítulo.

#### 🔍 Obtener una frase por ID

**GET** `/api/frases/:id`

#### ✏️ Actualizar una frase

**PUT** `/api/frases/:id`

#### 🗑️ Eliminar una frase

**DELETE** `/api/frases/:id`

### 👤 Personajes

#### 📃 Listar todos los personajes

**GET** `/api/personajes`

### 🎬 Capítulos

####📃 Listar todos los capítulos
**GET** `/api/capitulos`

## ⚠️ Errores comunes

| Código | Significado                     |
| ------ | ------------------------------- |
| 400    | Bad Request (petición inválida) |
| 404    | Not Found (no encontrado)       |
| 500    | Internal Server Error           |

## 🧪 Tecnologías utilizadas

- Node.js + Express.js

- MySQL

- JSON como formato de respuesta

**-> Nelicah <-**
