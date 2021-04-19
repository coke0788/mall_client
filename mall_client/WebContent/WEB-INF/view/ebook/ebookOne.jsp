<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mall.client.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookOne</title>
</head>
<body>
	<%
		Ebook ebook = (Ebook)request.getAttribute("ebook");
	%>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1> 책 정보 </h1>
		<table border="1">
		<tr>
			<td>ebookNo</td>
			<td><%=ebook.getEbookNo() %></td>
		</tr>
		<tr>
			<td>ebookState</td>
			<td><%=ebook.getEbookState() %></td>
		</tr>
		<tr>
			<td>CategoryName</td>
			<td><%=ebook.getCategoryName() %></td>
		</tr>
		<tr>
			<td>ebookISBN</td>
			<td><%=ebook.getEbookISBN() %></td>
		</tr>
		<tr>
			<td>ebookTitle</td>
			<td><%=ebook.getEbookTitle() %></td>
		</tr>
		<tr>
			<td>ebookAuthor</td>
			<td><%=ebook.getEbookAuthor() %></td>
		</tr>
		<tr>
			<td>ebookCompany</td>
			<td><%=ebook.getEbookCompany() %></td>
		</tr>
		<tr>
			<td>ebookImg</td>
			<td><img src="<%=request.getContextPath()%>/img/default.jpg"></td>
		</tr>
		<tr>
			<td>ebookPrice</td>
			<td><%=ebook.getEbookPrice() %></td>
		</tr>
		<tr>
			<td>ebookPageCount</td>
			<td><%=ebook.getEbookPageCount() %></td>
		</tr>
		<tr>
			<td>ebookSummary</td>
			<td><%=ebook.getEbookSummary() %></td>
		</tr>
		<tr>
			<td>ebookDate</td>
			<td><%=ebook.getEbookDate() %></td>
		</tr>
	</table>
	<!-- InsertCartController?ebookNo, CartDao.insertCart(), redirect:CartListController -->
	<a href="<%=request.getContextPath()%>/InsertCartController?ebookNo=<%=ebook.getEbookNo()%>">
	<%
		if(session.getAttribute("loginClient")==null || ebook.getEbookState().equals("품절") || ebook.getEbookState().equals("절판") || ebook.getEbookState().equals("구편절판")) {
	%>
			<button type="button" disabled="disabled">장바구니 추가</button>
	<%
		} else {
	%>
			<button type="button">장바구니 추가</button>
	<%
		System.out.println(ebook.getEbookNo());
		}
	%>
	</a>
</body>
</html>