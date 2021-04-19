package mall.client.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import mall.client.commons.DBUtil;
import mall.client.vo.Orders;

public class OrdersDao {
	private DBUtil dbUtil;
	//주문 입력 메소드
	public int insertOrders(Orders orders) {
		int rowCnt = 0;
		this.dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO orders(ebook_no, client_no, orders_date, orders_state) VALUES(?, ?, now(), '주문완료')";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orders.getEbookNo());
			stmt.setInt(2, orders.getClientNo());
			rowCnt = stmt.executeUpdate();
			System.out.println("주문 stmt :"+stmt);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			this.dbUtil.close(null, stmt, conn);
		}
		return rowCnt;
	}
	//주문 목록 메소드
	public List<Map<String, Object>> selectOrdersListByClient(int clientNo) {
		List<Map<String, Object>> list = new ArrayList<>();
		this.dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, o.orders_date ordersDate, o.orders_state ordersState, e.ebook_title ebookTitle, e.ebook_price ebookPrice FROM orders o INNER JOIN ebook e ON o.ebook_no = e.ebook_no WHERE o.client_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, clientNo);
			rs = stmt.executeQuery();
			System.out.println("주문목록 stmt :"+stmt);
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("ordersNo", rs.getInt("ordersNo"));
				map.put("ebookNo", rs.getInt("ebookNo"));
				map.put("ordersDate", rs.getString("ordersDate"));
				map.put("ordersState", rs.getString("ordersState"));
				map.put("ebookTitle", rs.getString("ebookTitle"));
				map.put("ebookPrice", rs.getInt("ebookPrice"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			this.dbUtil.close(rs, stmt, conn);
		}
		return list;
	}
	//베스트셀러 목록 메소드
	public List<Map<String,Object>> selectBestOrdersList() {
		/*﻿
			#모집단을 선택(WHERE) -> 그룹선정 -> 그룹 함수 사용(COUNT) -> 결과 값에 대한 조건(HAVING) -> 정렬(ORDER BY)
			# t = subQuery
		 * 쿼리 : SELECT t.ebook_no, t.cnt, e.ebook_title, e.ebook_price, e.ebook_summary FROM (SELECT ebook_no, COUNT(ebook_no) cnt FROM orders WHERE orders_state='주문완료' GROUP BY ebook_no HAVING COUNT(ebook_no) > 1 ORDER BY COUNT(ebook_no) DESC LIMIT 5) t INNER JOIN ebook e ON t.ebook_no = e.ebook_no
		 */
		List<Map<String, Object>> list = new ArrayList<>();
		this.dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT t.ebook_no ebookNo, t.cnt tCnt, e.ebook_title ebookTitle, e.ebook_price ebookPrice, e.ebook_summary ebookSummary FROM (SELECT ebook_no, COUNT(ebook_no) cnt FROM orders WHERE orders_state='주문완료' GROUP BY ebook_no HAVING COUNT(ebook_no) > 1) t INNER JOIN ebook e ON t.ebook_no = e.ebook_no ORDER BY t.Cnt DESC LIMIT 5";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			System.out.println("베스트셀러 stmt :"+stmt);
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("ebookNo", rs.getInt("ebookNo"));
				map.put("cnt", rs.getInt("tCnt"));
				map.put("ebookTitle", rs.getString("ebookTitle"));
				map.put("ebookPrice", rs.getInt("ebookPrice"));
				map.put("ebookSummary", rs.getString("ebookSummary"));
				list.add(map);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			this.dbUtil.close(rs, stmt, conn);
		}
		return list;
	}
}
