package mall.client.model;

import mall.client.commons.DBUtil;
import mall.client.vo.Client;

import java.sql.*;

public class ClientDao {
	private DBUtil dbUtil;
	//회원가입 메서드
	public int insertClient(Client client) { //매개변수는 Client vo의 전부
		this.dbUtil = new DBUtil();
		int rowCnt =0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try { //예외처리 이지만 오류는 출력 시킬거임.
			String sql = "INSERT INTO client(client_mail, client_pw, client_date) VALUES (?, PASSWORD(?), now())";
			conn = this.dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, client.getClientMail());
			stmt.setString(2, client.getClientPw());
			rowCnt = stmt.executeUpdate();
			//디버깅
			System.out.println("회원가입 stmt:"+stmt);
		}catch(Exception e) { //오류 내용 출력
			e.printStackTrace();
		} finally { //db자원 닫기
			this.dbUtil.close(null, stmt, conn); //rs가 없으므로 rs에 null. 다른 것들도 없으면 null을 직접 넣기.
		}
		return rowCnt;
	}
	//메일 중복검사 메서드
	public String selectClientMail(String clientMail) {
		dbUtil = new DBUtil();
		String returnClientMail = null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		String sql="SELECT client_mail FROM client WHER client_mail=?";
		try {
			conn = this.dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, clientMail);
			rs = stmt.executeQuery();
			System.out.println("중복검사 stmt : "+stmt);
			while(rs.next()) {
				returnClientMail = rs.getString("client_mail");
			}
		} catch(Exception e) { //오류 출력
			e.printStackTrace();
		} finally { //db자원 닫기
			dbUtil.close(rs, stmt, conn);
		}
		return returnClientMail;
	}
	//로그인 메서드
	public Client login(Client client) {
		this.dbUtil=new DBUtil();
		Client returnClient = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = this.dbUtil.getConnection();
			String sql = "SELECT client_mail clientMail FROM client WHERE client_mail=? AND client_pw=PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, client.getClientMail());
			stmt.setString(2, client.getClientPw());
			System.out.println("로그인 stmt :"+stmt);
			rs = stmt.executeQuery();
			if(rs.next()) {
				returnClient = new Client();
				returnClient.setClientMail(rs.getString("clientMail"));
			}
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			this.dbUtil.close(rs, stmt, conn);
		}
	return returnClient;
	}
}
