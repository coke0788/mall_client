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
		//년 월이 매개값으로 전달되지 않으면
		this.ebookDao = new EbookDao();
		Calendar dday = Calendar.getInstance();
		if(request.getParameter("currentYear") != null) {
			dday.set(Calendar.YEAR, Integer.parseInt(request.getParameter("currentYear")));
		}
		if(request.getParameter("currentMonth") != null) {
			dday.set(Calendar.MONTH, Integer.parseInt(request.getParameter("currentMonth"))-1);
		}
		int currentYear = dday.get(Calendar.YEAR);
		int currentMonth = dday.get(Calendar.MONTH)+1;
		int endDay = dday.getActualMaximum(Calendar.DAY_OF_MONTH); //이번달의 마지막 날짜
		
		
		//이번달 1일의 요일
		Calendar firstDay = Calendar.getInstance();
		firstDay.set(Calendar.YEAR,  currentYear);
		firstDay.set(Calendar.MONTH,  currentMonth-1);
		firstDay.set(Calendar.DATE, 1);
		int firstDayofWeek = firstDay.get(Calendar.DAY_OF_WEEK); //1일이 무슨 요일인지
		System.out.printf("올해년도 : %s, 이번달 : %s, 이번달의 마지막 날짜 : %s, 1일의요일 : %s%n", currentYear, currentMonth, endDay, firstDayofWeek);
		List<Map<String, Object>> ebookListByMonth = this.ebookDao.selectEbookByMonth(currentYear, currentMonth);
		request.setAttribute("currentYear", currentYear);
		request.setAttribute("currentMonth", currentMonth);
		request.setAttribute("ebookListByMonth", ebookListByMonth);
		request.setAttribute("endDay", endDay);
		request.setAttribute("firstDayofWeek", firstDayofWeek);
		request.getRequestDispatcher("WEB-INF/view/ebook/ebookCalendar.jsp").forward(request, response);
	}
}
