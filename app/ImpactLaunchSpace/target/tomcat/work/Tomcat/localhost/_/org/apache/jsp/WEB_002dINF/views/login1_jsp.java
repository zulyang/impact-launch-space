/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2017-07-21 17:03:44 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login1_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/views/common/navigationLogin.jspf", Long.valueOf(1500642477283L));
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n");
      out.write("<meta name=\"viewport\"\r\n");
      out.write("\tcontent=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\r\n");
      out.write("<title>ImpactLaunch.Space</title>\r\n");
      out.write("<link rel=\"stylesheet\"\r\n");
      out.write("\thref=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\"\r\n");
      out.write("\tintegrity=\"sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u\"\r\n");
      out.write("\tcrossorigin=\"anonymous\">\r\n");
      out.write("<!--custom css codes -->\r\n");
      out.write("<link rel=\"stylesheet\"\r\n");
      out.write("\thref=\"");
      out.print(request.getContextPath());
      out.write("/resources/css/app.css\" />\r\n");
      out.write("<script src=\"//code.jquery.com/jquery-1.12.0.min.js\"></script>\r\n");
      out.write("<script src=\"//code.jquery.com/jquery-migrate-1.2.1.min.js\"></script>\r\n");
      out.write("<script\r\n");
      out.write("\tsrc=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\"\r\n");
      out.write("\tintegrity=\"sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS\"\r\n");
      out.write("\tcrossorigin=\"anonymous\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("<body class=\"signin\">\r\n");
      out.write("\t<div class=\"container-fluid\">\r\n");
      out.write("\t\t<div class=\"row\">\r\n");
      out.write("\t\t\t<div class=\"col-sm-12 col-md-12 col-lg-12\">\r\n");
      out.write("\r\n");
      out.write("<div id=\"navigationLogin\">\r\n");
      out.write("            <nav class=\"navbar navbar-default navbar-fixed-top landing-nav\">\r\n");
      out.write("                <div class=\"container-fluid\">\r\n");
      out.write("                    <div class=\"navbar-header\">\r\n");
      out.write("                        <a class=\"navbar-brand\" href=\"/\">\r\n");
      out.write("                            <img alt=\"ImpactLaunch.Space\" id=\"logo\" src=\"");
      out.print(request.getContextPath());
      out.write("/resources/img/logo2.png\">\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </div>\r\n");
      out.write("                  \r\n");
      out.write("                    <ul class=\"nav navbar-nav navbar-right nav_elements\">\r\n");
      out.write("                        <li><a href=\"/\">Home</a></li>\r\n");
      out.write("                        <li><a href=\"/login1\">Sign In</a></li>\r\n");
      out.write("                        <li><a href=\"/register\">Sign Up</a></li>\r\n");
      out.write("                    </ul>\r\n");
      out.write("                </div>\r\n");
      out.write("            </nav> \r\n");
      out.write("            </div>");
      out.write("\r\n");
      out.write("\t\t\t\t<div class=\"col-lg-12 form_container\">\r\n");
      out.write("\t\t\t\t\t<h4 id=\"welcome\" class=\"welcome\">Welcome!</h4>\r\n");
      out.write("\t\t\t\t\t<h4 id=\"unlockAccountPinMessage\" class=\"unlockAccountPinMessage\" style=\"display: none;\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${unlockAccountPin}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\r\n");
      out.write("\t\t\t\t\t</h4>\r\n");
      out.write("\t\t\t\t\t<form class=\"form-horizontal\" action=\"authenticate\" method=\"POST\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input name=\"usernameemail\" type=\"text\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"form-control field\" id=\"inputEmail3\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tplaceholder=\"Username or Email\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input name=\"password\" type=\"password\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"form-control field\" id=\"inputPassword3\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tplaceholder=\"Password\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"checkbox remember\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<label> <input name=\"rememberMe\" type=\"checkbox\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\tvalue=\"true\"> Remember me\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<button type=\"submit\" class=\"btn btn-success field\">Login</button>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<p class=\"loginValidation\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${loginValidation}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</p>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<div class=\"forget\">\r\n");
      out.write("\t\t\t\t\t\t\t<a href=\"/forgotpassword\">Forget your password?</a>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" id=\"unlockAccountPin\" name=\"unlockAccountPin\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${unlockAccountPin}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\twindow.onload = function() {\r\n");
      out.write("\t\tvar unlockAccountStatus = document.getElementById(\"unlockAccountPin\").value;\r\n");
      out.write("\r\n");
      out.write("\t\tconsole.log(unlockAccountStatus);\r\n");
      out.write("\r\n");
      out.write("\t\tif (unlockAccountStatus.length > 0) {\r\n");
      out.write("\t\t\t$('#welcome').hide();\r\n");
      out.write("\t\t\t$('#unlockAccountPinMessage').show()\r\n");
      out.write("\t\t\tevent.preventDefault();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
