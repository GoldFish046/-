package interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import org.apache.struts2.StrutsStatics;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.dispatcher.HttpParameters;
import org.apache.struts2.dispatcher.Parameter;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


public class DownloadInterceptor implements Interceptor {
    @Override
    public void destroy() {

    }

    @Override
    public void init() {

    }

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        ActionContext actionContext = actionInvocation.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST);
        String url = request.getRequestURI();
        String flag = StringUtils.substringAfterLast(url, "_");
        HttpParameters httpParameters = actionContext.getParameters();
        Map<String, Parameter> newParams = new HashMap<String, Parameter>();
        for (String key : httpParameters.keySet()) {
            Parameter p = httpParameters.get(key);
            if (p instanceof Parameter.Request) {
                newParams.put(key, new Parameter.Request(key, new String[]{p.getValue()}));
            }
        }
        newParams.put("flag", new Parameter.Request("flag", new String[]{flag}));
        request.setAttribute("flag", flag);
        httpParameters.appendAll(newParams);
        actionContext.setParameters(httpParameters);
        return actionInvocation.invoke();
    }

}
