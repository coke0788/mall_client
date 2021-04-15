package mall.client.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mall.client.model.ClientDao;
import mall.client.vo.Client;

@WebServlet("/ClientOneController")
public class ClientOneController extends HttpServlet {
	private ClientDao clientDao;//컨트롤러는 원래 DAO를 가지고 있음.
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 유효성 검사 session값으로 로그인 한 경우에만 넘어오도록.
		HttpSession session = request.getSession();
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//문자 인코딩
		request.setCharacterEncoding("utf-8");
		//clientOne dao 호출
		/* clientMail 값 얻어오는 거 헷갈려서 이해한대로 적어놓기. 
		* clientMail 변수 선언. 세션에 세팅 된 loginClient 값을 리턴. 
		* > 값은 Object 타입으로 리턴 되므로 타입 변환 해줘야함. loginClient가 Client 타입이라는걸 알고 있으므로 Client 타입으로 강제 변환.
		* > 그 중에 clientMail 값을 리턴해서 String 타입의 clientMail변수에 저장.
		*/   
		String clientMail = ((Client)(session.getAttribute("loginClient"))).getClientMail(); 
		this.clientDao = new ClientDao();
		Client client = clientDao.selectClientOne(clientMail);
		//forwarding
		request.setAttribute("client", client);
		//리퀘스트와 리스폰스값을 뷰에 요청하여 연결.
		request.getRequestDispatcher("/WEB-INF/view/client/clientOne.jsp").forward(request, response);
		System.out.println("client Mail :"+clientMail);
	}


}
