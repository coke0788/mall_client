package mall.client.model;

import java.sql.*;

import mall.client.commons.DBUtil;
import mall.client.vo.*;

public class StatsDao {
	private DBUtil dbUtil;
	public Stats selectStatsByToday() {
		this.dbUtil = new DBUtil();
		Stats stats = null;
		//SELECT stats_day statsDay stats_count statsCount FROM stats WHERE stats_day=DATE(NOW())
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql="SELECT stats_day statsDay, stats_count statsCount FROM stats WHERE stats_day=DATE(NOW())";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			System.out.println("오늘방문자수 stmt : " + stmt);
			if(rs.next()) {
				stats = new Stats();
				stats.setStatsDay(rs.getString("statsDay"));
				stats.setStatsCount(rs.getInt("statsCount"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		return stats;
	}
	public void insertStats() {
		//INSERT INTO stats(stats_day, stats_count) VALUES (NOW(), 1)
		this.dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql="INSERT INTO stats(stats_day, stats_count) VALUES (DATE(NOW()), 1)";
			stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
	}
	public void updateStats() {
		//UPDATE SET stats_count=stats_count+1 WHERE stats_day=DATE(NOW())
		this.dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql="UPDATE SET stats_count=stats_count+1 WHERE stats_day=DATE(NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
	}
	public long selectStatsTotal() {
		//SELECT SUM(stats_count) total FROM stats
		this.dbUtil = new DBUtil();
		long total=0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql="SELECT SUM(stats_count) total FROM stats";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			System.out.println("오늘방문자수 stmt : " + stmt);
			if(rs.next()) {
				total = rs.getLong("total");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		return total;
	}
}
