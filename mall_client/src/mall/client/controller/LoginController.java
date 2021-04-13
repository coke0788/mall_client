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

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	//clientDao를 사용하기 위해 선언.
	private ClientDao clientDao;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 유효성 검사
		HttpSession session = request.getSession();
		//로그인 세션이 널이 아니면(로그인 상태면) 인덱스컨트롤러로 이동을 요청.
		if(session.getAttribute("loginClient")!=null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//문자 인코딩
		request.setCharacterEncoding("utf-8");
		String clientMail = request.getParameter("clientMail");
		String clientPw = request.getParameter("clientPw");
		//client new연산자 생성.(참조값 객체에 저장)
		Client client = new Client();
		//클라이언트의 ClientMail/Pw값에 clientMail/Pw 값 저장.
		client.setClientMail(clientMail);
		client.setClientPw(clientPw);
		
		this.clientDao = new ClientDao();
		Client returnClient = this.clientDao.login(client);
		if(returnClient != null) {
			session.setAttribute("loginClient", returnClient);
		}
		response.sendRedirect(request.getContextPath()+"/IndexController");
	}

}
