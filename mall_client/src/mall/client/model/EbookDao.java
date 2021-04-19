package mall.client.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mall.client.commons.DBUtil;
import mall.client.vo.*;

public class EbookDao {
	private DBUtil dbutil;
	
	public List<Ebook> selectEbookListByPageCategoryName(int beginRow, int rowPerPage, String categoryName) {
		List<Ebook> list = new ArrayList<Ebook>();
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try { //예외처리를 try catch 문으로.
		conn = this.dbutil.getConnection();
		if(categoryName==""||categoryName==null) {
			String sql = "SELECT category_name categoryName, ebook_no ebookNo, ebook_title ebookTitle, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			String sql = "SELECT category_name categoryName, ebook_no ebookNo, ebook_title ebookTitle, ebook_price ebookPrice FROM ebook WHERE category_name=? ORDER BY ebook_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		System.out.println("ebook목록 stmt:"+stmt);
		rs = stmt.executeQuery();
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryName(rs.getString("categoryName"));
			//e.setEbookImg(rs.getString("ebookImg"));
			list.add(e);
		}
		} catch(Exception e) {
			e.printStackTrace(); //오류메세지 출력
		//코드가 try절에서 끝나든 catch절에서 끝나든 finally 안의 문법을 실행 시킴. 즉, try절에서 예외 발생 시, catch절로 이동, 후에 finally 실행. try절에서 예외 미발생 시, try절 실행, 후에 finally 실행
		} finally { 
			this.dbutil.close(rs, stmt, conn); //해제
		}
		
		return list;
	}
	public List<Ebook> selectEbookListByPageSearchWord(int beginRow, int rowPerPage, String searchWord) {
		List<Ebook> list = new ArrayList<Ebook>();
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try { //예외처리를 try catch 문으로.
		conn = this.dbutil.getConnection();
		if(searchWord==""||searchWord==null) {
			String sql = "SELECT category_name categoryName, ebook_no ebookNo, ebook_title ebookTitle, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {
			String sql = "SELECT category_name categoryName, ebook_no ebookNo, ebook_title ebookTitle, ebook_price ebookPrice FROM ebook WHERE ebook_title LIKE ? ORDER BY ebook_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		System.out.println("ebook목록 stmt:"+stmt);
		rs = stmt.executeQuery();
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setCategoryName(rs.getString("categoryName"));
			//e.setEbookImg(rs.getString("ebookImg"));
			list.add(e);
		}
		} catch(Exception e) {
			e.printStackTrace(); //오류메세지 출력
		//코드가 try절에서 끝나든 catch절에서 끝나든 finally 안의 문법을 실행 시킴. 즉, try절에서 예외 발생 시, catch절로 이동, 후에 finally 실행. try절에서 예외 미발생 시, try절 실행, 후에 finally 실행
		} finally { 
			this.dbutil.close(rs, stmt, conn); //해제
		}
		
		return list;
	}
	//ebook 상세페이지 메소드
	public Ebook selectEbookOne(int ebookNo) {
		Ebook ebook = null;
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = this.dbutil.getConnection();
			String sql = "SELECT ebook_no, ebook_title, ebook_ISBN, ebook_price, ebook_summary, ebook_page_count, ebook_date, ebook_author, ebook_company, ebook_state, category_name, ebook_img FROM ebook WHERE ebook_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebookNo);
			rs = stmt.executeQuery();
			System.out.println("ebookOne stmt:"+stmt);
			if(rs.next()) {
				ebook = new Ebook();
				ebook.setEbookNo(rs.getInt("ebook_no"));
				ebook.setEbookISBN(rs.getString("ebook_isbn"));
				ebook.setCategoryName(rs.getString("category_name"));
				ebook.setEbookTitle(rs.getString("ebook_title"));
				ebook.setEbookAuthor(rs.getString("ebook_author"));
				ebook.setEbookCompany(rs.getString("ebook_company"));
				ebook.setEbookPageCount(rs.getInt("ebook_page_count"));
				ebook.setEbookPrice(rs.getInt("ebook_price"));
				ebook.setEbookSummary(rs.getString("ebook_summary"));
				ebook.setEbookImg(rs.getString("ebook_img"));
				ebook.setEbookDate(rs.getString("ebook_date"));
				ebook.setEbookState(rs.getString("ebook_state"));
			}
		} catch(Exception e) {
			e.printStackTrace(); //오류메세지 출력
		} finally {
			this.dbutil.close(rs, stmt, conn); //해제
		}
		return ebook;
	}
	//카테고리별 전체개수 메소드
	public int totalCntCategoryName(String categoryName) {
		int totalRow = 0;
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbutil.getConnection();
			if (categoryName=="" || categoryName==null) { 
				String sql = "SELECT COUNT(*) cnt FROM ebook";
				stmt = conn.prepareStatement(sql);
			} else {
				String sql = "SELECT COUNT(*) cnt FROM ebook WHERE category_name=?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, categoryName);
			}
			rs = stmt.executeQuery();
			System.out.println("전체 ebook페이지 stmt : "+stmt);
			if(rs.next()) {
				totalRow=rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			this.dbutil.close(rs, stmt, conn); //해제
		}
		return totalRow;
	}
	//검색어 전체개수 메소드
	public int totalCntSearchWord(String searchWord) {
		int totalRow = 0;
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbutil.getConnection();
			if (searchWord==""||searchWord==null) { 
				String sql = "SELECT COUNT(*) cnt FROM ebook";
				stmt = conn.prepareStatement(sql);
			} else {
				String sql = "SELECT COUNT(*) cnt FROM ebook WHERE ebook_title LIKE ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%"+searchWord+"%");
			}
			rs = stmt.executeQuery();
			System.out.println("전체 ebook페이지 stmt : "+stmt);
			if(rs.next()) {
				totalRow=rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			this.dbutil.close(rs, stmt, conn); //해제
		}
		return totalRow;
	}
	//카테고리이름 목록 메소드
	public List<String> categoryNameList() {
		List<String> list = new ArrayList<>();
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbutil.getConnection();
			String sql = "SELECT category_name categoryName FROM category ORDER BY category_weight DESC";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				String cn = rs.getString("categoryName");
				list.add(cn);
			}
			System.out.println("카테고리네임 리스트:"+stmt);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbutil.close(rs, stmt, conn);
		}
		return list;
	}
	//신간 리스트 메소드
	public List<Map<String,Object>> selectEbookByMonth(int year, int month){
		List<Map<String,Object>> list = new ArrayList<>();
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbutil.getConnection();
			String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, DAY(ebook_date) d FROM ebook WHERE YEAR(ebook_date)=? AND MONTH(ebook_date)=? ORDER BY DAY(ebook_date) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ebookNo", rs.getString("ebookNo"));
				map.put("ebookTitle", rs.getString("ebookTitle"));
				map.put("d", rs.getInt("d"));
				list.add(map);
			}
			System.out.println("신간 목록:"+stmt);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbutil.close(rs, stmt, conn);
		}
		return list;
	}
}
