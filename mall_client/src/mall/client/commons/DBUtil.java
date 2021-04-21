package mall.client.commons;

import java.sql.*;

public class DBUtil {
	//DB 연결
	public Connection getConnection() {
		Connection conn=null;
		try {
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	//DB 자원(conn, stmt, rs) 해제
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
		if(rs != null) { //null이 들어올 수도 있으므로 null이 아닐 때만 클로즈할 수 있도록.
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
