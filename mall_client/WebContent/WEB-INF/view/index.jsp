<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "mall.client.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1> index </h1>
	<%
		//컨트롤러에서 forwarding한 ebooklist를 얻어옴(오브젝트 타입으로 들어왔으므로 배열로 타입 변경). 배열Ebook 타입 ebookList에 저장.
		List<Ebook> ebookList = (List<Ebook>)(request.getAttribute("ebookList"));
	%>
	<table border="1">
		<tr>
			<%
				int i = 0; //이북 표시 개수 설정 하기 위한 변수 선언.
				for(Ebook ebook : ebookList) {
					i+=1;
			%>	
					<td>
						<div><img src="<%=request.getContextPath()%>/img/default.jpg"></div>
						<div><a href=""><%=ebook.getEbookTitle()%></a></div>
						<div><%=ebook.getEbookPrice()%></div>
					</td>
			<%
					if(i%5==0) {
						%>
							</tr><tr>
						<%
					}
				}
			%>
		</tr>
	</table>
</body>
</html>