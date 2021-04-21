package mall.client.listner;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import mall.client.model.StatsDao;

@WebListener
public class StatsListner implements HttpSessionListener {
	private StatsDao statsDao;
    public void sessionCreated(HttpSessionEvent se)  { //세션이 열렸을 때(만들어졌을 때)
    	if(se.getSession().isNew()) { //세션이 일어나면 실행. 카운트가 안 될 수도 있음.
	    	System.out.println("새로운 session이 생성");
	    	this.statsDao = new StatsDao();
	    	// 오늘 날짜의 카운트가 없으면 1 인서트
	    	if(this.statsDao.selectStatsByToday()==null) {
	    		this.statsDao.insertStats();
	    	} else {// 오늘 날짜의 카운트가 있으면 오늘카운트 +1 업데이트
	    		this.statsDao.updateStats();
	    	}
    	}
    }

    public void sessionDestroyed(HttpSessionEvent se)  { //세션이 닫혔을 때
    	
    }
	
}
