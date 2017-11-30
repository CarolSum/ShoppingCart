<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>

<script>
$(function(){

$("input.addCartButton").removeAttr("disabled");
$("input.addCartButton").click(function(){
	$(this).attr("disabled","disabled");
	var button = $(this);
	var pid = $(this).attr("pid");
	var number = $("input.number[pid="+pid+"]").val();
	var page = "/cart/addOrderItem";
    $.get(
        page,
        {"num":number,"pid":pid},
        function(result){
     	   $("#addCartSuccessMessage").fadeIn(1200);
     	   $("#addCartSuccessMessage").fadeOut(1200,function(){
     		   button.removeAttr("disabled") ;   
     	   });
     	   
     	   
        }
    );
	
});

$("#addCartSuccessMessage").hide();

});
</script>
</head>
<body>
	<c:if test="${!empty user}">
	  <div align="center">
	    当前用户: ${user.name}
	  </div>
	</c:if>
	<div  align="center" style="height:20px;margin:20px;" >
		<span style="color:Chartreuse" id="addCartSuccessMessage">加入购物车成功</span> 
	</div>
	<table align='center' border='1' cellspacing='0'>
	    <tr>
	        <td>id</td>
	        <td>名称</td>
	        <td>价格</td>
	        <td>购买</td>
	    </tr>
	    <c:forEach items="${products}" var="product" varStatus="st">
	        <tr>
	            <td>${product.id}</td>
	            <td>${product.name}</td>
	            <td>${product.price}</td>
	            <td>             
		            <form action="addOrderItem" method="post"> 
			                                         数量<input pid="${product.id}" class="number" type="text" value="1" name="num">
			           	<input type="hidden" name="pid" value="${product.id}">
			            <input class="addCartButton" pid="${product.id}" type="submit" value="加入购物车">
		            </form>
	            </td>
	        </tr>
	    </c:forEach>
	    <tr>
    		<td colspan="4"><a href="/cart/listOrderItem">查看购物车</a></td>
    	</tr>
	</table>
</body>
</html>