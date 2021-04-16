package mall.client.model;

import mall.client.commons.DBUtil;
import mall.client.vo.Client;

import java.sql.*;
import java.util.List;

public class ClientDao {
	private DBUtil dbUtil;
	//상세페이지 메서드
	public Client selectClientOne(String clientMail) {
		//dbUtil 객체 생성
		this.dbUtil = new DBUtil();
		//리턴값, db 자원 초기화
		Client client = new Client();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM client WHERE client_mail=? ";
			conn=this.dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, clientMail);
			rs=stmt.executeQuery();
			System.out.println("상세정보 stmt : " + stmt);
			if(rs.next()) {
				client.setClientDate(rs.getString("client_date"));
				client.setClientMail(rs.getString("client_mail"));
				client.setClientNo(rs.getInt("client_no"));
				client.setClientPw(rs.getString("client_pw"));
			}
		} catch(Exception e) { //예외처리하지만 오류는 출력 시킬 것임.
			e.printStackTrace();
		} finally { //db자원 close
			dbUtil.close(rs, stmt, conn);
		}
		return client;
	}
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
		String sql="SELECT client_mail FROM client WHERE client_mail=?";
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
			String sql = "SELECT client_no clientNo, client_mail clientMail FROM client WHERE client_mail=? AND client_pw=PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, client.getClientMail());
			stmt.setString(2, client.getClientPw());
			System.out.println("로그인 stmt :"+stmt);
			rs = stmt.executeQuery();
			if(rs.next()) {
				returnClient = new Client();
				returnClient.setClientMail(rs.getString("clientMail"));
				returnClient.setClientNo(rs.getInt("clientNo"));
			}
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			this.dbUtil.close(rs, stmt, conn);
		}
	return returnClient;
	}
	//비밀번호 수정 메서드
	public int updateClientPw(Client client) {
		this.dbUtil=new DBUtil();
		int rowCnt=0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = this.dbUtil.getConnection();
			String sql = "UPDATE client SET client_pw=PASSWORD(?) WHERE client_mail=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, client.getClientPw());
			stmt.setString(2, client.getClientMail());
			System.out.println("비밀번호 수정 stmt :"+stmt);
			rowCnt=stmt.executeUpdate();
		} catch(Exception e) {
			//오류 내용 출력
			e.printStackTrace();
		} finally {
			this.dbUtil.close(null, stmt, conn);
		}
		return rowCnt;
	}
	//회원 삭제 메서드
	public int deleteClient(String clientMail) {
		this.dbUtil=new DBUtil();
		int rowCnt=0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = this.dbUtil.getConnection();
			String sql = "DELETE from client WHERE client_mail=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, clientMail);
			System.out.println("회원 삭제 stmt :"+stmt);
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
