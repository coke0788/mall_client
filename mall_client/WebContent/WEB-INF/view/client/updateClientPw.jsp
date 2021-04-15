<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UpdateClientPw</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1>비밀번호 수정</h1>
	<form action="<%=request.getContextPath()%>/UpdateClientPwController" method="post">
		<input type="Password" name="clientPw">
		<button type="submit">수정</button>
		<a href="<%=request.getContextPath() %>/ClientOneController"><button type="button">취소</button></a>
	</form>
</body>
</html>