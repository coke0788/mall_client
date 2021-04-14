<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertClient</title>
</head>
<body>
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1>회원가입</h1>
	<form action="<%=request.getContextPath()%>/InsertClientController" method="post">
		<table border="1">
			<tr>
				<td>clientMail</td>
				<td><input type="text" name="clientMail"></td>
			</tr>
			<tr>
				<td>clientPw</td>
				<td><input type="password" name="clientPw"></td>
			</tr>
		</table>
		<button type="submit">가입</button>
	</form>
</body>
</html>