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
		Client client = (Client)request.getAttribute("client");
	%>
	<h1>회원정보</h1>
			<table border="1">
				<tr>
					<td>clientNo</td>
					<td><%=client.getClientNo() %></td>
				</tr>
				<tr>
					<td>clientMail</td>
					<td><%=client.getClientMail() %></td>
				</tr>
				<tr>
					<td>clientPw</td>
					<td>		
					<!-- UpdateClientPwController(doGet) - updateClientPw.jsp -->
					<!-- UpdateClientPwController(doPost) - ClientDao().updateClientPw - session invalidate(controller에 있어야함.) - redirect:/IndexController -->
					<a href="<%=request.getContextPath()%>/UpdateClientPwController"><button type="button">비밀번호수정</button></a>
					</td>
				</tr>
				<tr>
					<td>clientDate</td>
					<td><%=client.getClientDate() %></td>
				</tr>
			</table>
		<%
			System.out.printf("상세정보 : %d, %s, %s%n",client.getClientNo(), client.getClientMail(), client.getClientDate());
		%>
		<!-- DeleteClientController - ClientDao().deleteClient, CartDao().deleteCartAll(mail) - session invalidate(controller에 있어야함.) - redirect:/IndexController -->
		<a href="<%=request.getContextPath()%>/DeleteClientController"><button type="button">회원탈퇴</button></a>
</body>
</html>