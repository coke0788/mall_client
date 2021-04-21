package mall.client.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mall.client.model.EbookDao;
import mall.client.model.OrdersDao;
import mall.client.model.StatsDao;
import mall.client.vo.Category;
import mall.client.vo.Ebook;

/**
 * Servlet implementation class IndexController
 */
@WebServlet("/IndexController")
public class IndexController extends HttpServlet {
	private OrdersDao ordersDao;
	private StatsDao statsDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// model 호출
		this.ordersDao = new OrdersDao();
		List<Map<String,Object>> bestOrdersList = this.ordersDao.selectBestOrdersList();
		
		//접속자수 데이터
		this.statsDao = new StatsDao();
		long total = this.statsDao.selectStatsTotal();
		long statsCount = this.statsDao.selectStatsByToday().getStatsCount();
		
		// view forwarding
		request.setAttribute("bestOrdersList", bestOrdersList);
		request.setAttribute("total", total);
		request.setAttribute("statsCount", statsCount);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/designIndex.jsp"); //페이지 뷰 요청하기
		rd.forward(request, response); //리퀘스트와 리스폰스 전송? 연결?
	}
}
