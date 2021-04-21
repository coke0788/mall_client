package mall.client.listner;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DBListner implements ServletContextListener {

    public void contextDestroyed(ServletContextEvent sce)  { //톰캣(서버)이 꺼질 때 
    	System.out.println("contextdestroyed");
    }

    public void contextInitialized(ServletContextEvent sce)  {  //톰캣(서버)이 켜질 떄 할 행동을 지정
		try {
    	Class.forName("org.mariadb.jdbc.Driver");
    	System.out.println("마리아디비 로딩 성공");
		} catch(Exception e) {
			System.out.println("마리아디비 로딩 실패");
			e.printStackTrace();
		}
    }
	
}
