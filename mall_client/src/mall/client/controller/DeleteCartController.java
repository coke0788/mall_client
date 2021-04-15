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
 * Servlet implementation class DeleteCartController
 */
@WebServlet("/DeleteCartController")
public class DeleteCartController extends HttpServlet {
	private CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 유효성 검사
		HttpSession session = request.getSession();
		//로그인 세션이 널이면 인덱스로
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//Dao 호출
		cartDao = new CartDao();
		Cart cart=new Cart();
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		cart.setCartNo(cartNo);
		cart.setClientMail(((Client)session.getAttribute("loginClient")).getClientMail());
		System.out.printf("삭제 카트 넘버:%s, 삭제 카트 클라이언트메일:%s%n",cart.getCartNo(), cart.getClientMail());
		cartDao.deleteCart(cart);
		//카트 리스트 이동요청
		response.sendRedirect(request.getContextPath()+"/CartListController");
	}

}
