const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");
require("dotenv").config();

// Creamos una vari con el servidor
const server = express();

// SECCIÓN DE CONFIGURACIÓN DE SERVER

// Configuramos server para que funcione bien como API
server.use(cors());
server.use(express.json({ limit: "25Mb" }));

// Arrancamos el servidor en el puerto 4000
const port = 4000;
server.listen(port, () => {
  console.log(`Servidor iniciado <http://localhost:${port}>`);
});

async function getConnection() {
  const connData = {
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  };

  const conn = await mysql.createConnection(connData);
  await conn.connect();

  return conn;
}

// ENDPOINTS

// Insertar nueva frase
server.post("/api/frases", async (req, res) => {
  if (!req.body.texto || !req.body.fk_personajes) {
    res.status(400).json({
      success: false,
      message: "Faltan datos por rellenar",
    });
    return;
  }

  try {
    const conn = await getConnection();

    const [result] = await conn.execute(
      `INSERT INTO frases (texto, marca_tiempo, descripcion, fk_personajes)
        VALUES (?, ?, ?, ?);`,
      [
        req.body.texto,
        req.body.marca_tiempo,
        req.body.descripcion,
        req.body.fk_personajes,
      ]
    );

    await conn.end();

    res.json({
      success: true,
      frase: {
        id: result.insertId,
        ...req.body,
      },
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: String(err),
    });
  }
});

// Listar todas las frases
server.get("/api/frases", async (req, res) => {
  try {
    const conn = await getConnection();

    const [results] = await conn.query(
      `SELECT
      f.texto, f.marca_tiempo, 
      f.descripcion AS frase_descripcion, 
      p.nombre AS personaje_nombre, 
      p.apellido AS personaje_apellido,
      p.ocupacion AS personaje_ocupacion,
      c.titulo AS capitulo_titulo
      FROM frases f
      JOIN personajes p ON f.fk_personajes = p.id
      JOIN capitulos_has_personajes chp ON p.id = chp.fk_personajes
      JOIN capitulos c ON chp.fk_capitulos = c.id
      ORDER BY f.id;`
    );

    await conn.end();

    res.json(results);
  } catch (err) {
    res.status(500).json({
      success: false,
      error: String(err),
    });
  }
});

// Obtener una frase específica
server.get("/api/frases/:id", async (req, res) => {
  if (!req.params.id || isNaN(parseInt(req.params.id))) {
    res.status(400).json({
      success: false,
      error: "El id no es un número",
    });
    return;
  }

  try {
    const conn = await getConnection();

    const [result] = await conn.query(
      `SELECT
      f.texto, f.marca_tiempo, f.descripcion,
      p.nombre AS personaje_nombre,
      p.apellido AS personaje_apellido
      FROM frases f
      JOIN personajes p ON f.fk_personajes = p.id
      WHERE f.id = ?;`,
      [req.params.id]
    );

    await conn.end();

    res.json(result);
  } catch (err) {
    res.status(500).json({
      success: false,
      error: String(err),
    });
  }
});

// Actualizar una frase existente
server.put("/api/frases/:id", async (req, res) => {
  if (!req.params.id || isNaN(parseInt(req.params.id))) {
    res.status(400).json({
      success: false,
      error: "El id no es un número",
    });
    return;
  }

  if (!req.body.texto || !req.body.descripcion || !req.body.fk_personajes) {
    res.status(400).json({
      success: false,
      message: "Ha ocurrido un error",
    });
  }

  try {
    const conn = await getConnection();

    const [result] = await conn.execute(
      `UPDATE frases
      SET texto = ?, marca_tiempo = ?, descripcion = ? , fk_personajes = ?
      WHERE id = ?;`,
      [
        req.body.texto,
        req.body.marca_tiempo,
        req.body.descripcion,
        req.body.fk_personajes,
        req.params.id,
      ]
    );

    await conn.end();

    res.json({
      success: true,
      frase: {
        id: req.params.id,
        ...req.body,
      },
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: String(err),
    });
  }
});

// Eliminar una frase
server.delete("/api/frases/:id", async (req, res) => {
  if (!req.params.id || isNaN(parseInt(req.params.id))) {
    res.status(400).json({
      success: false,
      error: "El id no es un número",
    });
    return;
  }

  try {
    const conn = await getConnection();

    const [result] = await conn.execute(`DELETE FROM frases WHERE id = ?`, [
      req.params.id,
    ]);

    await conn.end();

    if (result.affectedRows === 1) {
      res.json({
        success: true,
      });
    } else {
      res.status(404).json({
        success: false,
        error: "El id no existe",
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      error: String(err),
    });
  }
});
