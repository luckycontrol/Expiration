const fastify = require("fastify")({ logger: true });
const PORT = process.env.PORT || 5000;

// API
fastify.register(require("./routes/member"));
fastify.register(require("./routes/product"));

// Database
const mongoose = require("mongoose");
const url = require("./dbConnector"); 

const start = async () => {
    try {
        mongoose.connect(url, { useNewUrlParser: true, useUnifiedTopology: true })
            .then(() => { fastify.listen(PORT, "0.0.0.0"); })
            .catch((error) => { console.log(error.message); })
    } catch (error) {
        console.log(error.message); 
    }  
}

start();