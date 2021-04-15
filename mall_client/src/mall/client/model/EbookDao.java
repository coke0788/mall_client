package mall.client.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import mall.client.commons.DBUtil;
import mall.client.vo.Ebook;

public class EbookDao {
	private DBUtil dbutil;
	
	public List<Ebook> selectEbookListByPage(int beginRow, int rowPerPage) {
		List<Ebook> list = new ArrayList<Ebook>();
		this.dbutil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try { //예외처리를 try catch 문으로.
		conn = this.dbutil.getConnection();
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()){
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			e.setEbookNo(rs.getInt("ebookNo"));
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
}
