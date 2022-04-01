const parser = require('../grammar/grammar')
const express = require('express')
//cargarCodigo

const app = express()

app.get('/', (req, res) => {
    res.send("Escuchando")
})

app.post('/cargarCodigo', (req, res) => {
    res.send('a')
})


app.listen(3000, () => {
    console.log("Servidor en el puerto 3000")
})