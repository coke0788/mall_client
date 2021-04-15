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
	//카트 추가 메서드
	public int insertCart(Cart cart) {
		int rowCnt=0;
		dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		//try catch문으로 예외처리. finally로 닫기.
		try{
			conn=this.dbUtil.getConnection();
			String sql = "INSERT INTO cart(client_mail, ebook_no, cart_date) VALUES(?, ?, now())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cart.getClientMail());
			stmt.setInt(2, cart.getEbookNo());
			System.out.println("insertCart stmt:"+stmt);
			rowCnt=stmt.executeUpdate();
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			//DB자원 닫기.
			this.dbUtil.close(null, stmt, conn);
		}
		return rowCnt;
	}
	//카트 중복확인 메서드
	public boolean selectClientMail(Cart cart) {
		boolean flag = true; //flag가 true이면 중복 없음, flag가 false이면 중복이 있다.
		dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		String sql="SELECT * FROM cart WHERE client_mail=? AND ebook_no=?";
		try {
			conn = this.dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cart.getClientMail());
			stmt.setInt(2, cart.getEbookNo());
			rs = stmt.executeQuery();
			System.out.println("카트 중복검사 stmt : "+stmt);
			if(rs.next()) {
				flag = false;
			}
		} catch(Exception e) { //오류 출력
			e.printStackTrace();
		} finally { //db자원 닫기
			dbUtil.close(rs, stmt, conn);
		}
		return flag;
	}
	//특정 회원의 카트 전체 삭제 메서드
	public int deleteCartAll(String clientMail) {
		this.dbUtil=new DBUtil();
		int rowCnt=0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = this.dbUtil.getConnection();
			String sql = "DELETE from cart WHERE client_mail=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, clientMail);
			System.out.println("카트 삭제 stmt :"+stmt);
			rowCnt=stmt.executeUpdate();
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			this.dbUtil.close(null, stmt, conn);
		}
		return rowCnt;
	}
	//삭제 선택한 카트 삭제 메서드
	public int deleteCart(Cart cart) {
		this.dbUtil=new DBUtil();
		int rowCnt=0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = this.dbUtil.getConnection();
			String sql = "DELETE from cart WHERE client_mail=? AND cart_no=?";
			stmt = conn.prepareStatement(sql);
			//Cart vo 전체를 매개변수로 받았기 때문에 cart vo의 무슨 값을 받아올건지 작성해줘야함.
			stmt.setString(1, cart.getClientMail());
			stmt.setInt(2, cart.getCartNo());
			System.out.println(cart.getCartNo()+"번의 카트 삭제 stmt :"+stmt);
			rowCnt=stmt.executeUpdate();
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			this.dbUtil.close(null, stmt, conn);
		}
		return rowCnt;
	}
}
