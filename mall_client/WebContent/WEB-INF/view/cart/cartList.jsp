<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "mall.client.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartList</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<!-- 카트 리스트 -->
	<%
		//컨트롤러에서 포워딩한 리스트 얻어오기.(오브젝트 타입으로 들어와서 타입변환 해줘야함.)
		List<Map<String,Object>> cartList = (List<Map<String,Object>>)(request.getAttribute("cartList"));
	%>
	<h1>cartList</h1>
	<table border="1">
			<tr>
				<td>cartNo</td>
				<td>ebookNo</td>
				<td>ebookTitle</td>
				<td>cartDate</td>
			</tr>
		<%
		for(Map<String,Object> map : cartList){
			%>
			<tr>
				<td><%=map.get("cartNo")%></td>
				<td><%=map.get("ebookNo") %></td>
				<td><%=map.get("ebookTitle")%></td>
				<td><%=map.get("cartDate")%></td>
			</tr>
			<% 	
		}
		%>
	</table>
</body>
</html>