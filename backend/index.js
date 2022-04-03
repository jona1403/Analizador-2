const parser = require('../grammar/grammar')
const express = require('express')
const cors = require('cors')
//cargarCodigo

const app = express()
app.use(cors())
app.use(express.json());

app.get('/', (req, res) => {
    res.send("Escuchando")
})

app.post('/cargarCodigo', (req, res) => {
    //console.log(req.body)
    //console.log(req.body.cod)
    console.log(parser.parse(req.body.cod))
})


app.listen(3000, () => {
    console.log("Servidor en el puerto 3000")
})