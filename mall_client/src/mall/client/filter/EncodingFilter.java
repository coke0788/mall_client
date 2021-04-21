package mall.client.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/*") //뭐라고 요청하든지 실행할 것이다.
public class EncodingFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		chain.doFilter(request, response); //위에 적으면 Endpoint(요청으로 가기) 전에 필터 적용, 아래 적으면 Endpoint 이후에 필터 적용.
	}


}
