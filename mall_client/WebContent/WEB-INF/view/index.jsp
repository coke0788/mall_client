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
		List<Ebook> ebookList=(List<Ebook>)(request.getAttribute("ebookList"));
		List<String> categoryNameList=(List<String>)(request.getAttribute("categoryNameList"));
		String categoryName="";
		if(categoryName!=null){
			categoryName=(String)request.getAttribute("categoryName");
		}
		String searchWord="";
		if(searchWord!=null){
			searchWord=(String)request.getAttribute("searchWord");
		}
		int currentPage=(Integer)request.getAttribute("currentPage");
		int rowPerPage=(Integer)request.getAttribute("rowPerPage");
		int totalRow=(Integer)request.getAttribute("totalRow");
		int lastPage=(Integer)request.getAttribute("lastPage");
		%>
	<div>
		<a href="<%=request.getContextPath()%>/IndexController?categoryName=">전체보기</a>
		<%
			for(String cn : categoryNameList) {
		%>
				<a href="<%=request.getContextPath()%>/IndexController?categoryName=<%=cn%>"><%=cn%></a>
		<%
			}
		%>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/IndexController" method="get">
			<input type="text" placeholder="검색어를 입력하세요." name="searchWord"><button type="submit">검색</button>

		</form>
	</div>
	<table border="1">
		<tr>
			<%
				int i = 0; //이북 표시 개수 설정 하기 위한 변수 선언.
				for(Ebook ebook : ebookList) {
					i+=1;
			%>	
					<td>
						<div><img src="<%=request.getContextPath()%>/img/default.jpg"></div>
						<!-- EbookOneController, EbookDao.selectEbookOne, ebookOne.jsp -->
						<div><a href="<%=request.getContextPath()%>/EbookOneController?ebookNo=<%=ebook.getEbookNo()%>"><%=ebook.getEbookTitle()%></a></div>
						<div><%=ebook.getCategoryName()%></div>
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
	<!-- 페이지 작업 -->
<%
	if(lastPage<=1) {
%>
		<button>현재페이지</button>
<%
	return;
	}
%>
<%
	if(searchWord==null) { //searchword가 null이면 페이징 작업에 searchword쪽 다 지워버리기.
		if(1<currentPage && currentPage<lastPage){
	%>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=1&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>처음으로</button></a>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>이전</button></a>
		<button>현재페이지</button>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>다음</button></a>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=lastPage %>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>끝으로</button></a>
	<%
		} else if(currentPage==1) {
	%>
		<button>현재페이지</button>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>다음</button></a>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=lastPage %>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>끝으로</button></a>
	<%
		} else if(currentPage==lastPage) {
	%>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=1&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>처음으로</button></a>
		<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><button>이전</button></a>
		<button>현재페이지</button>
	<%
		}
	} else { //아니라면 categoryName을 지우기
		if(1<currentPage && currentPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>처음으로</button></a>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>이전</button></a>
			<button>현재페이지</button>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>다음</button></a>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=lastPage %>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>끝으로</button></a>
		<%
			} else if(currentPage==1) {
		%>
			<button>현재페이지</button>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>다음</button></a>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=lastPage %>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>끝으로</button></a>
		<%
			} else if(currentPage==lastPage) {
		%>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>처음으로</button></a>
			<a href="<%=request.getContextPath()%>/IndexController?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>"><button>이전</button></a>
			<button>현재페이지</button>
		<%
		}
	}
%>
</body>
</html>