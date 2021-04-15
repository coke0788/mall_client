package mall.client.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mall.client.model.ClientDao;
import mall.client.vo.Client;

@WebServlet("/UpdateClientPwController")
public class UpdateClientPwController extends HttpServlet {
	private ClientDao clientDao;
	//비밀번호 수정 페이지로 이동 C>V
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		//로그인 유효성 검사. 로그인 안 되어 있으면 인덱스로
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//view forwarding
		request.getRequestDispatcher("/WEB-INF/view/client/updateClientPw.jsp").forward(request, response);
	}
	
	//비밀번호 수정 action C>M>V
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//로그인 유효성 검사. 로그인 안 되어 있으면 인덱스로
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		request.setCharacterEncoding("utf-8");
		this.clientDao = new ClientDao();
		//DAO 호출
		String clientPw = request.getParameter("clientPw");
		Client client = new Client();
		client.setClientPw(clientPw);
		client.setClientMail(((Client)(session.getAttribute("loginClient"))).getClientMail());
		clientDao.updateClientPw(client);
		session.invalidate();
		//index로 이동
		response.sendRedirect(request.getContextPath()+"/IndexController");
	}

}
