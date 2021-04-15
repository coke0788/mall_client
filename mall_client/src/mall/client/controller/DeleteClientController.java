package mall.client.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mall.client.model.CartDao;
import mall.client.model.ClientDao;
import mall.client.vo.Client;

@WebServlet("/DeleteClientController")
public class DeleteClientController extends HttpServlet {
	private ClientDao clientDao;
	private CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 유효성 검사
		HttpSession session = request.getSession();
		//로그인 세션이 널이면 인덱스로
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//dao 호출
		clientDao=new ClientDao();
		cartDao = new CartDao();
		String clientMail = ((Client)(session.getAttribute("loginClient"))).getClientMail();
		clientDao.deleteClient(clientMail);
		cartDao.deleteCartAll(clientMail);
		//로그아웃 후 인덱스 이동
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/IndexController");
	}

}
