package mall.client.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mall.client.model.EbookDao;
import mall.client.vo.Category;
import mall.client.vo.Ebook;

/**
 * Servlet implementation class IndexController
 */
@WebServlet("/IndexController")
public class IndexController extends HttpServlet {
	private EbookDao ebookDao; //컨트롤러는 원래 DAO를 가지고 있음.
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// request 분석
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 15;
		int beginRow = (currentPage -1)*rowPerPage;
		String categoryName = request.getParameter("categoryName");
		String searchWord = request.getParameter("searchWord");
		
		// model 호출
		this.ebookDao = new EbookDao();
		List<Ebook> ebookList = this.ebookDao.selectEbookListByPageSearchWord(beginRow, rowPerPage, searchWord);
		if (searchWord=="" || searchWord==null) {//검색어가 없거나, null이라면 카테고리의 목록을 쓸 것.
			ebookList = this.ebookDao.selectEbookListByPageCategoryName(beginRow, rowPerPage, categoryName);
		}
		List<String> categoryNameList = this.ebookDao.categoryNameList();
		int totalRow = 0;
		if(categoryName=="" || categoryName==null) { //카테고리네임이 없거나 null이라면 검색어의 목록을 쓸 것.
			totalRow = this.ebookDao.totalCntSearchWord(searchWord);
		} else {
			totalRow = this.ebookDao.totalCntCategoryName(categoryName);
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		// view forwarding
		request.setAttribute("ebookList", ebookList);
		request.setAttribute("categoryNameList", categoryNameList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("categoryName", categoryName);
		request.setAttribute("rowPerPage", rowPerPage);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("searchWord", searchWord);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/index.jsp"); //페이지 뷰 요청하기
		rd.forward(request, response); //리퀘스트와 리스폰스 전송? 연결?
		
		
		System.out.printf("currentPage:%s, categoryName:%s, rowPerPage:%d, totalRow:%d, lastPage:%d, searchWord:%s%n", currentPage, categoryName, rowPerPage, totalRow, lastPage, searchWord);
	}
}
