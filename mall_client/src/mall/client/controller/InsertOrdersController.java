package mall.client.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mall.client.model.*;
import mall.client.vo.*;

/**
 * Servlet implementation class InsertOrdersController
 */
@WebServlet("/InsertOrdersController")
public class InsertOrdersController extends HttpServlet {
	private OrdersDao ordersDao;
	private CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 유효성 검사
		HttpSession session = request.getSession();
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//의존객체이 객체를 만듦.(생성)
		this.ordersDao = new OrdersDao();
		this.cartDao = new CartDao();
		
		//request
		int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		Client client = (Client)(session.getAttribute("loginClient"));
		Orders orders = new Orders();
		orders.setEbookNo(ebookNo);
		orders.setClientNo(client.getClientNo());
		Cart cart = new Cart();
		cart.setClientMail(client.getClientMail());
		cart.setEbookNo(ebookNo);

		//dao
		//insert후 delete 전에 db에 문제가 생기면 insert도 취소함(롤백) : 트랜잭션처리
		ordersDao.insertOrders(orders);
		cartDao.deleteCart(cart);
		
		response.sendRedirect(request.getContextPath()+"/OrdersListController");
	}

}
