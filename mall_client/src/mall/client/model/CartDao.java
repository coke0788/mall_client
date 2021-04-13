package mall.client.model;

import java.sql.*;
import java.util.*;

import mall.client.commons.DBUtil;
import mall.client.vo.*;

public class CartDao {
	private DBUtil dbUtil;
	public List<Map<String, Object>> selectCartList(String clientMail) {
		//sql = SELECT c.cart_no, e.ebook_no, e.ebook_title FROM cart c INNER JOIN ebook e ON c.ebook_no=e.ebook_no
		List<Map<String, Object>> list = new ArrayList<>();
		//DBUtil new연산자 생성.(참조값 객체에 저장) mariadb 변수 선언 -> null값으로.
		dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//try catch문으로 예외처리. finally로 닫기.
		try{
			conn=this.dbUtil.getConnection();
			String sql = "SELECT c.cart_no cartNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, c.cart_date cartDate FROM cart c INNER JOIN ebook e ON c.ebook_no=e.ebook_no WHERE c.client_mail=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, clientMail);
			System.out.println("cartList stmt:"+stmt);
			rs = stmt.executeQuery();
			while(rs.next()) {
				//new연산자 생성.(참조값 객체에 저장) Map: 키(String)와 값(Object:멀로 들어올지 모르니까.)이 한 쌍으로 저장.
				//Map 하나가 vo라고 생각하고, get대신 put 사용한다고 생각하기.
				Map<String, Object> map = new HashMap<>();
				map.put("cartNo",rs.getInt("cartNo")); //no -> cartNo값
				map.put("ebookNo", rs.getInt("ebookNo"));
				map.put("ebookTitle", rs.getString("ebookTitle"));
				map.put("cartDate", rs.getString("cartDate"));
				list.add(map);	
		  }
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			//DB자원 닫기.
			this.dbUtil.close(rs, stmt, conn);
		}
		return list;
	}
}
