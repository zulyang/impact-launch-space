/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2017-07-06 14:07:51 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class verifyaccount_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

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
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n");
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
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("</head>\r\n");
      out.write("<body class=\"signup\">\r\n");
      out.write("\t<div class=\"container-fluid\">\r\n");
      out.write("\t\t<div class=\"row\">\r\n");
      out.write("\t\t\t<div class=\"col-sm-12 col-md-12 col-lg-12\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<nav class=\"navbar navbar-default navbar-fixed-top landing-nav\">\r\n");
      out.write("\t\t\t\t\t<div class=\"container-fluid\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"navbar-header\">\r\n");
      out.write("\t\t\t\t\t\t\t<a class=\"navbar-brand\" href=\"/\"> <img\r\n");
      out.write("\t\t\t\t\t\t\t\talt=\"ImpactLaunch.Space\" id=\"logo\"\r\n");
      out.write("\t\t\t\t\t\t\t\tsrc=\"");
      out.print(request.getContextPath());
      out.write("/resources/img/logo2.png\"></a>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<ul class=\"nav navbar-nav navbar-right nav_elements\">\r\n");
      out.write("\t\t\t\t\t\t\t<li><a href=\"/\">Home</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t<li><a href=\"/login1\">Sign In</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t<li><a href=\"/register\">Sign Up</a></li>\r\n");
      out.write("\t\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</nav>\r\n");
      out.write("\t\t\t\t<div class=\"col-lg-12 verify_container\" id=\"verify_container\">\r\n");
      out.write("\t\t\t\t\t<h4 class=\"verifyAccountMessage\">Verify your account</h4>\r\n");
      out.write("\t\t\t\t\t<form method=\"post\" class=\"form-horizontal\" action=\"verifyaccount\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"text\" name=\"usernameemail\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"form-control field\" placeholder=\"Username/Email\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"password\" name=\"password\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"form-control field\" placeholder=\"Password\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"text\" name=\"verificationcode\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"form-control field\" placeholder=\"Verification code\">\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"col-lg-12\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<button type=\"submit\" value=\"Register\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"btn btn-success field\" id=\"verify_button\">Submit</button>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<p class=\"verifyNewAccount\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${verifyNewAccount}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("</p>\r\n");
      out.write("\t\t\t\t\t</form>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<div class=\"col-lg-12 verify_success\" id=\"verify_success\"\r\n");
      out.write("\t\t\t\t\tstyle=\"display: none;\">\r\n");
      out.write("\t\t\t\t\t<h4 class=\"verify_success_message\">Verification Successful</h4>\r\n");
      out.write("\t\t\t\t\t<p>Hi ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${usernameemail}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(", your account has been verified!</p>\r\n");
      out.write("\t\t\t\t\t<a href=\"/login1\" class=\"btn btn-success signInNowBox\">SIGN IN NOW</a>\r\n");
      out.write("\t\t\t\t\t<a href=\"/\" class=\"btn btn-default returnHome\" role=\"button\">Return\r\n");
      out.write("\t\t\t\t\t\tto Home</a>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" id=\"registerCheck\" name=\"registerCheck\"\r\n");
      out.write("\t\t\t\t\tvalue=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${registerCheck}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"> <input type=\"hidden\"\r\n");
      out.write("\t\t\t\t\tid=\"verifyNewAccount\" name=\"verifyNewAccount\"\r\n");
      out.write("\t\t\t\t\tvalue=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${verifyNewAccount}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"> <input type=\"hidden\"\r\n");
      out.write("\t\t\t\t\tid=\"verifyNewAccountSuccess\" name=\"verifyNewAccountSuccess\"\r\n");
      out.write("\t\t\t\t\tvalue=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${verifyNewAccountSuccess}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t</body>\r\n");
      out.write(" \r\n");
      out.write(" <script type=\"text/javascript\">\r\n");
      out.write("\twindow.onload = function() {\r\n");
      out.write("\t\tvar verifyNewAccountStatus = document\r\n");
      out.write("\t\t\t\t.getElementById(\"verifyNewAccount\").value;\r\n");
      out.write("\t\tvar verifyNewAccountSuccessStatus = document\r\n");
      out.write("\t\t\t\t.getElementById(\"verifyNewAccountSuccess\").value;\r\n");
      out.write("\r\n");
      out.write("\t\tif (verifyNewAccountStatus.length > 0) {\r\n");
      out.write("\t\t\tconsole.log(\"in here la\");\r\n");
      out.write("\t\t\t$('#register_container').hide();\r\n");
      out.write("\t\t\t$('#register_success').hide();\r\n");
      out.write("\t\t\t$('#verify_container').show();\r\n");
      out.write("\t\t\tevent.preventDefault();\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\tif (verifyNewAccountSuccessStatus.length > 0) {\r\n");
      out.write("\t\t\tconsole.log(\"in here 2\");\r\n");
      out.write("\t\t\t$('#register_container').hide();\r\n");
      out.write("\t\t\t$('#register_success').hide();\r\n");
      out.write("\t\t\t$('#verify_container').hide();\r\n");
      out.write("\t\t\t$('#verify_success').show();\r\n");
      out.write("\t\t\tevent.preventDefault();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("</html>");
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
