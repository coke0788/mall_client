package mall.client.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mall.client.model.*;
import mall.client.vo.*;

@WebServlet("/EbookCalendarController")
public class EbookCalendarController extends HttpServlet {
	private EbookDao ebookDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.ebookDao = new EbookDao();
		//년 월이 매개값으로 전달되지 않으면
		Calendar dday = Calendar.getInstance();
		// 년 월이 매개값으로 전달 되면 날짜 세팅 할거임 받아온 걸로.
		if(request.getParameter("currentYear") != null) {
			dday.set(Calendar.YEAR, Integer.parseInt(request.getParameter("currentYear")));
		}
		//month의 경우 0이 1월이기 때문에, 받아온 값에 -1을 해줘야 원하는 달을 가져올 수 있다. 즉, 출력할 때는 +1(우리가 아는 월), 받아올 때는 -1(얘가 인식하는 월).
		if(request.getParameter("currentMonth") != null) {
			dday.set(Calendar.MONTH, Integer.parseInt(request.getParameter("currentMonth"))-1);
		}
		int currentYear = dday.get(Calendar.YEAR);
		int currentMonth = dday.get(Calendar.MONTH)+1;
		//이번달의 마지막 날짜
		int endDay = dday.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		
		//이번달 1일의 요일
		Calendar firstDay = Calendar.getInstance();
		firstDay.set(Calendar.YEAR,  currentYear);
		firstDay.set(Calendar.MONTH,  currentMonth-1);
		firstDay.set(Calendar.DATE, 1);
		int firstDayofWeek = firstDay.get(Calendar.DAY_OF_WEEK); //1일이 무슨 요일인지
		
		//디버깅
		System.out.printf("올해년도 : %s, 이번달 : %s, 이번달의 마지막 날짜 : %s, 1일의요일 : %s%n", currentYear, currentMonth, endDay, firstDayofWeek);
		
		//왼쪽 변수에 오른쪽 값 다 저장 해주고 jsp 파일과 연결.
		List<Map<String, Object>> ebookListByMonth = this.ebookDao.selectEbookByMonth(currentYear, currentMonth);
		request.setAttribute("currentYear", currentYear);
		request.setAttribute("currentMonth", currentMonth);
		request.setAttribute("ebookListByMonth", ebookListByMonth);
		request.setAttribute("endDay", endDay);
		request.setAttribute("firstDayofWeek", firstDayofWeek);
		request.getRequestDispatcher("WEB-INF/view/ebook/ebookCalendar.jsp").forward(request, response);
	}
}
