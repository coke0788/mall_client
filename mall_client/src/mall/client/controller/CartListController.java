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
import javax.servlet.http.HttpSession;

import mall.client.model.CartDao;
import mall.client.model.ClientDao;
import mall.client.vo.*;

@WebServlet("/CartListController")
public class CartListController extends HttpServlet {
	private CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 유효성 검사
		HttpSession session = request.getSession();
		//로그인 세션이 널이면 인덱스로
		if(session.getAttribute("loginClient")==null) {
			response.sendRedirect(request.getContextPath()+"/IndexController");
			return;
		}
		//문자 인코딩
		request.setCharacterEncoding("utf-8");
		
		//dao 호출
		/* clientMail 값 얻어오는 거 헷갈려서 이해한대로 적어놓기. 
		* clientMail 변수 선언. 세션에 세팅 된 loginClient 값을 리턴. 
		* > 값은 Object 타입으로 리턴 되므로 타입 변환 해줘야함. loginClient가 Client 타입이라는걸 알고 있으므로 Client 타입으로 강제 변환.
		* > 그 중에 clientMail 값을 리턴해서 String 타입의 clientMail변수에 저장.
		*/   
		String clientMail = ((Client)(session.getAttribute("loginClient"))).getClientMail();
		//cartDao new연산자 생성. 참조값을 객체에(cartDao) 저장
		this.cartDao = new CartDao();
		//list 선언. cartDao의 selectCartList 값을 저장.
		List<Map<String, Object>> cartList = this.cartDao.selectCartList(clientMail);
		
		//forwarding
		request.setAttribute("cartList", cartList);
		//페이지 뷰 요청
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/cart/cartList.jsp");
		//리퀘스트와 리스폰스 값을 연결시킴.(forwarding)
		rd.forward(request, response);
	}
}
