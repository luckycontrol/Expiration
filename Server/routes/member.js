async function memberApi(fastify, options) {
  // 멤버 전체 가져오기
  fastify.get("/member", require("../controllers/member").getAllMembers);

  // 멤버 생성
  fastify.post(
    "/member/createMember",
    require("../controllers/member").createMember
  );

  // 멤버 비밀번호 변경
  fastify.put(
    "/member/updateMember",
    require("../controllers/member").updateMember
  );

  // 멤버 삭제
  fastify.delete(
    "/member/removeMember",
    require("../controllers/member").removeMember
  );
}

module.exports = memberApi;
