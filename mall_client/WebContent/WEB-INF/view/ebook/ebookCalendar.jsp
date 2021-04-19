<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookCalendar</title>
</head>
<body>
	<!-- 상단 메뉴바. -->
	<jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include>
	<h1>Ebook Calendar</h1>
	<%
		List<Map<String,Object>> ebookListByMonth = (List<Map<String,Object>>)(request.getAttribute("ebookListByMonth"));
		int currentYear = (Integer)(request.getAttribute("currentYear"));
		int currentMonth = (Integer)(request.getAttribute("currentMonth"));
		int endDay = (Integer)(request.getAttribute("endDay"));
		int firstDayofWeek = (Integer)(request.getAttribute("firstDayofWeek"));
				
		int preMonth = currentMonth-1;
		int preYear = currentYear;
		if(preMonth == 0) { //이전달이 0이 되면 전년도의 12월로.
			preMonth = 12;
			preYear = preYear-1;
		}
		int nextMonth = currentMonth+1;
		int nextYear = currentYear;
		if(nextMonth == 13) {//다음달이 13이 되면 다음년도의 1월로.
			nextMonth = 1;
			nextYear = nextYear+1;
		}
	%>
	<!-- n행 7월 달력 -->
	<div>
		<span><a href="<%=request.getContextPath()%>/EbookCalendarController?currentYear=<%=preYear%>&currentMonth=<%=preMonth%>">이전달</a></span>
		<span><%=currentYear%>년 <%=currentMonth%>월</span> 
		<span><a href="<%=request.getContextPath()%>/EbookCalendarController?currentYear=<%=nextYear%>&currentMonth=<%=nextMonth%>">다음달</a></span>
	</div>
	<table border="1">
		<tr>
			<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
		</tr>
		<tr>
<%
			for(int i=1; i<firstDayofWeek; i++){ //i가 1부터 주의 첫번째 요일(ex. 5) 전까지 1씩 증가해서 빈칸 채우기. 
%>
            	<td>&nbsp;</td>
<%
         	}
			for(int i=1; i<=endDay; i++){ //위에서 빈칸이 채워졌으니까 그 이후로 i가 1부터 마지막날까지 1씩 증가해서 값 넣기.
%>            
            	<td>
	            <%=i %>
		            <%
					for(Map m : ebookListByMonth){ //해당하는 날짜에 발간된(ebook_date) 이북의 타이틀 표시.
		            	if(i==(Integer)m.get("d")) { //형변환
		            %>
		            	<div><a href="<%=request.getContextPath()%>/EbookOneController?ebookNo=<%=m.get("ebookNo")%>">
		            	<%
		            		String ebookTitle = (String)(m.get("ebookTitle"));
		            		if(ebookTitle.length()>10){
		            	%>
		            			<%=ebookTitle.substring(0,10)%>...
		         		<%	
		            		} else {
		            	%>
		            			<%=ebookTitle%>
		            	<%
		            		}
		            	%>
		            	</a></div>
		            	<%
		            	}
		            }
		            %>
	            </td>
<%
            if(firstDayofWeek%7==0){ //주의 첫째날의 요일이 7로 나누었을 때 나누어 떨어지면(=토요일) 줄바꿈.
%>               
            </tr><tr>
<%               
            }
            firstDayofWeek += 1; //for문 루프 한 번 돌 때마다 주의 첫째날 요일에 1씩 추가 (요일 증가 시켜야 되니까)
         }
			firstDayofWeek -= 1; //최종에서 1이 추가 되었는데 이건 쓰레기값이라 -1해줌. (다음달로 넘어갔으니까.)
         if((firstDayofWeek%7) != 0){ //7로 나누었을 때 나누어 떨어지는 값이 0이 아니면
            for(int i=1; i<=7-(firstDayofWeek%7); i++){ //7-나머지 개수만큼 공백 삽입.
%>               

            <td>&nbsp;</td>
<%               
            }
         }
%>
      </tr>
   </table>
</body>
</html>