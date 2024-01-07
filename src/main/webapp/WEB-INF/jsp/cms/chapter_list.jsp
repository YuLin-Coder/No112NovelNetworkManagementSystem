<%@ page language="java" contentType="text/html; charset=UTF-8"
         autoFlush="false" buffer="1000kb" pageEncoding="UTF-8"
         import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/func.tld" prefix="func"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
    <%@include file="head.jsp"%>
    <title>${novel.name}|所有章节</title>
    <link rel="stylesheet" href="/dist/adminLTE/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <script src="/dist/adminLTE/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="/dist/adminLTE/bower_components/bootstrap-datepicker/dist/locales/bootstrap-datepicker.zh-CN.min.js"></script>
    <script src="/dist/js/cms/chapter_list.min.js"></script>
    <style>
        .back-btn{
            margin-right: 40px;
        }
        .submit-btn{
            margin-left: 15px;
        }
        .clear{
            margin-left: 30px;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<%@include file="header.jsp"%>
<%@include file="aside.jsp"%>
<div class="wrapper">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>${novel.name} · 所有章节</h1>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <%--搜索条件--%>
                            <form action="" method="get" class="form-inline">
                                <%--{% csrf_token %}--%>
                                <%--返回--%>
                                <a href="/cms/novel_list/" class="back-btn btn btn-default"><< 返回</a>
                                <div class="form-group left-group">
                                    <input type="hidden" name="novel_id" value="${novel.id}">
                                    <label>时间：</label>
                                    <input type="text" name="start" id="start-picker" placeholder="起始时间" class="form-control" value="${start}" readonly>
                                    <span> - </span>
                                    <input type="text" name="end" id="end-picker" placeholder="结束时间" class="form-control" value="${end}" readonly>
                                </div>
                                <div class="form-group left-group">
                                    <label for="title-input">标题：</label>
                                    <input type="text" id="title-input" name="title" class="form-control" value="${title}">
                                </div>
                                <div class="form-group left-group">
                                    <button class="submit-btn btn btn-primary">查询</button>
                                </div>
                                <div class="form-group">
                                    <a href="/cms/chapter_list?novel_id=${novel.id}" class="clear">清除查询</a>
                                </div>
                            </form>
                        </div>
                        <div class="box-body">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>章节</th>
                                    <th>标题</th>
                                    <th>发布时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${chapters}" var="chapter">
                                    <tr>
                                        <td>第${chapter.number}章</td>
                                        <td>
                                            <a href="/chapter/${chapter.id}" target="_blank">
                                                ${chapter.title}
                                            </a>
                                        </td>
                                        <td><fmt:formatDate value="${chapter.pub_date}"  pattern="yyyy/MM/dd HH:mm:ss" /></td>
                                        <td>
                                            <a href="/cms/edit_chapter?chapter_id=${chapter.id}"  class="btn btn-warning btn-xs">编辑</a>
                                            <button class="btn btn-danger btn-xs delete-btn" data-chapter-id="${chapter.id}">删除</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="box-footer">
                            <ul class="pagination pagination-sm no-margin pull-right">
                                <c:choose>
                                    <c:when test="${has_previous}">
                                        <li><a href="/account/chapter_list?p=${previous_page_number}${url_query}">«</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="disabled"><a href="javascript:void(0);">«</a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${left_has_more}">
                                    <li><a href="/account/chapter_list${url_query}">1</a></li>
                                    <li><a href="javascript:void(0);" style="cursor:default;">...</a></li>
                                </c:if>
                                <c:forEach items="${left_pages}" var="left_page">
                                    <li><a href="/account/chapter_list?p=${left_page}${url_query}">${left_page}</a></li>
                                </c:forEach>
                                <li class="active"><a href="#">${current_page}</a></li>
                                <c:forEach items="${right_pages}" var="right_page">
                                    <li><a href="/account/chapter_list?p=${right_page}${url_query}">${right_page}</a></li>
                                </c:forEach>
                                <c:if test="${right_has_more}">
                                    <li><a href="javascript:void(0);" style="cursor:default;">...</a></li>
                                    <li><a href="/account/chapter_list?p=${num_pages}${url_query}">${num_pages}</a></li>
                                </c:if>
                                <c:choose>
                                    <c:when test="${has_next}">
                                        <li><a href="/account/chapter_list?p=${next_page_number}${url_query}">»</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="disabled"><a href="javascript:void(0)">»</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <div class="control-sidebar-bg"></div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
