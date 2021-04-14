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

/**
 * Servlet implementation class InsertClientController
 */
@WebServlet("/InsertClientController")
public class InsertClientController extends HttpServlet {
	private ClientDao clientDao;

	//폼 : C > V
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		if(session.getAttribute("loginClient")!=null) {
			/*redirect는 클라이언트에서 처리, forward는 서버에서 처리(자기 자신이). 
			*차이점: redirect는 클라이언트에서 처리하므로 정확한 위치를 알려 줘야함. (getContextPath 필요)
			*		forward(dispatcher)는 같은 반(예시)을 선언할 필요 없음 알고 있어서. (getContextPath 필요x)
			*/
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		request.getRequestDispatcher("/WEB-INF/view/client/insertClient.jsp").forward(request, response);
	}
	//액션 : C > M > redirect
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		this.clientDao = new ClientDao();//객체 생성
		
		//입력된 메일이랑 패스워드 받아오기 +변수선언
		String clientMail = request.getParameter("clientMail");
		String clientPw = request.getParameter("clientPw");
		//중복 검사용 메서드 호출
		String selectClientMail = clientDao.selectClientMail(clientMail);
		System.out.printf("회원가입 메일 :%s, 비밀번호:%s%n", clientMail, clientPw);
		
		//매개변수를 Client vo 전부를 받아와서 얻은 값을 vo의 변수에 저장해야 함.
		Client client = new Client();
		client.setClientMail(clientMail);
		client.setClientPw(clientPw);
		if(selectClientMail!=null) { //중복된 아이디가 있다면
			System.out.println("사용중인 메일");
			response.sendRedirect(request.getContextPath()+"/InsertClientController");
			return;
		}
		//중복된 아이디가 없으면, 가입 메서드 호출
		clientDao.insertClient(client);
		response.sendRedirect(request.getContextPath()+"/IndexController");
	}

}
