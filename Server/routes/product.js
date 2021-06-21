async function productApi(fastify, options) {
    // 생성
    fastify.post("/product/createProduct", require("../controllers/product").createProduct);

    // 읽기
    fastify.post("/product/readProduct", require("../controllers/product").readProduct);

    // 변경
    fastify.put("/product/updateProduct", require("../controllers/product").updateProduct);

    // 삭제
}

module.exports = productApi;