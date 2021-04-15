package mall.client.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mall.client.model.CartDao;
import mall.client.vo.Cart;
import mall.client.vo.Client;

/**
 * Servlet implementation class InsertCartController
 */
@WebServlet("/InsertCartController")
public class InsertCartController extends HttpServlet {
	private CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		
		System.out.println("insert ebookNo : " +ebookNo);
		this.cartDao = new CartDao();
		Cart cart = new Cart();
		cart.setEbookNo(ebookNo);
		cart.setClientMail(((Client)session.getAttribute("loginClient")).getClientMail());
		
		if(this.cartDao.selectClientMail(cart)==true) {
			this.cartDao.insertCart(cart);
		} else {
			System.out.println("중복된 책입니다.");
		}
		
		response.sendRedirect(request.getContextPath()+"/CartListController");
	}
}
