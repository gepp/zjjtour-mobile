package com.jdk2010.util;


import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.jdk2010.framework.util.Page;

public class PageTag extends TagSupport
{
  private String data = "pageList";
  private String href;
  private StringBuffer output;

  public String getData()
  {
    return this.data;
  }

  public void setData(String data) {
    this.data = data;
  }

  public String getHref() {
    return this.href;
  }

  public void setHref(String href) {
    this.href = href;
  }

  public StringBuffer getOutput() {
    return this.output;
  }

  public void setOutput(StringBuffer output) {
    this.output = output;
  }

  public int doEndTag() throws JspException
  {
    return super.doEndTag();
  }

  public int doStartTag() throws JspException
  {
    try {
      this.output = new StringBuffer();
      hander();
      this.pageContext.getOut().write(this.output.toString());
    } catch (IOException e) {
      e.printStackTrace();
    }
    return 0;
  }

  private void hander() {
    if (this.href.indexOf("?") < 0) {
      this.href += "?";
    }
    if ((this.href.endsWith("?")) || (this.href.endsWith("&amp;")))
      this.href += "pageIndex=";
    else {
      this.href += "&amp;pageIndex=";
    }
    Page pageList = (Page)this.pageContext.getRequest().getAttribute(this.data);
    if (pageList != null) {
      StringBuffer page = new StringBuffer();
      int pageNumber = Integer.valueOf(pageList.getPageIndex()).intValue();
      int totalPage = Integer.valueOf(pageList.getTotalPage()).intValue();
      int totalRow = Integer.valueOf(pageList.getTotalCount()).intValue();
      int startPage = pageNumber - 4;
      int endPage = pageNumber + 4;

      if (totalRow == 0) {
        pageNumber = 0;
      }

      if (startPage < 1) {
        startPage = 1;
      }

      if (endPage > totalPage) {
        endPage = totalPage;
      }

      if (pageNumber <= 8) {
        startPage = 1;
      }
      if (totalPage - pageNumber < 8) {
        endPage = totalPage;
      }

      page.append("<div class=\"page\">	<ul class=\"clr\">");

      if (pageNumber == totalPage)
          page.append("<li ><i class=\"iconfont\">&#xe611;</i></li>");
        else {
          page.append("<li onclick=\"window.location.href='" + this.href + (pageNumber + 1) + "'\"><i class=\"iconfont\">&#xe611;</i></li>");
        }
      if (totalPage - pageNumber >= 8) {
          page .append("<li onclick=\"window.location.href='" +  this.href + totalPage  + "'\">" + totalPage + "</li>")
          .append("<li onclick=\"window.location.href='" + this.href + (totalPage - 1)   + "'\">" + (totalPage - 1) + "</li>")
          .append("<li class=\"none\"> ...</li>");
        }
      for (int i = endPage; i >= startPage; i--) {
          if (pageNumber == i)
            page.append("<li class=\"active\">" + i + "</li>");
          else {
            page.append("<li onclick=\"window.location.href='" + this.href + i + "'\">" + i + "</li>");
          }
        }
      if (pageNumber > 8) {
          page.append("<li class=\"none\">...</li>")
           .append("<li onclick=\"window.location.href='" + this.href + "2'\" >2</li>")
           .append("<li onclick=\"window.location.href='" + this.href + "1'\" >1</li>");        
            
        }
      
      if (pageNumber > 1) {
          page.append("<li  onclick=\"window.location.href='" + this.href + (pageNumber - 1)+ "'\"><i class=\"iconfont\">&#xe611;</i></li>");
        }
      if (pageNumber <= 1) {
          page.append("<li><i class=\"iconfont\">&#xe611;</i></li>");
        }
      System.out.println("============================");
      
     

      page.append("</ul></div>");
      this.output.append(page);
    }
  }
}
