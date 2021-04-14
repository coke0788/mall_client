<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mall.client.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>clientOne</title>
</head>
<body>
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<%
		Client clientOne = (Client)request.getAttribute("clientOne");
	%>
	<h1>회원정보</h1>
		<form>
			<table border="1">
				<tr>
					<td>clientNo</td>
					<td><%=clientOne.getClientNo() %></td>
				</tr>
				<tr>
					<td>clientMail</td>
					<td><%=clientOne.getClientMail() %></td>
				</tr>
				<tr>
					<td>clientPw</td>
					<td><input type="text"></td>
				</tr>
				<tr>
					<td>clientDate</td>
					<td><%=clientOne.getClientDate() %></td>
				</tr>
			</table>
		</form>
		<%
			System.out.printf("상세정보 : %d, %s, %s%n",clientOne.getClientNo(), clientOne.getClientMail(), clientOne.getClientDate());
		%>
		<button type="submit">비밀번호 수정</button>
		<a href=""><button type="button">탈퇴</button></a>
</body>
</html>