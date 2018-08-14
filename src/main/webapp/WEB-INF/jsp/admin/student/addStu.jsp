<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
	<m:Content contentPlaceHolderId="css">

		<link
			href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
			rel="stylesheet">
		<link rel="stylesheet"
			href="/manage/public/css/selected/bootstrap-select.css">

		<style>
.layui-form-label {
	width: 145px;
}

.must {
	color: red;
	margin-right: 2%;
	size: 10px;
	font-size: 15px;
}

.nowPage {
	margin-top: 10px;
}

.layui-input {
	width: 325%;
}
.only-input{
	width: 87%;
}
.layui-form-select .layui-edge {
	right: -215%;
}

.layui-form-select dl {
	width: 325%;
}

.bootstrap-select>.btn {
	width: 281%;
}

.dropdown-menu {
	width: 280%;
}

.dropdown-menu>li>a {
	width: 595%;
}



</style>
	</m:Content>
	<m:Content contentPlaceHolderId="content">
		<div style="padding: 0 30px" class="layui-anim layui-anim-upbit">

			<div class="layui-field-box"
				style="border-color: #666; border-radius: 3px; padding: 10px;">
				<form class="layui-form">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>学生姓名：</label>
						<div class="layui-input-block">
							<input type="text" name="stuName" id="stuName" value="${stuName}" lay-verify="stuName"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: -8px;">
					    <label class="layui-form-label"><span class="must">*</span>性别：</label>
					    <div class="layui-input-block">
					      <input type="radio"  name="sex" value="2" title="女" <c:if test="${sex==2 || sex==null}">checked</c:if> >
					      <input type="radio"  name="sex" value="1" title="男" <c:if test="${sex==1}">checked</c:if> >
					    </div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>学生年龄：</label>
						<div class="layui-input-block">
							<input type="text" name="age" id="age" value="${age}" lay-verify="age"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="planDiv">
						<div class="layui-inline">
							<label class="layui-form-label"><span class="must">*</span>父亲信息：</label>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 60px; padding-left: 0px;">姓名：</label>
						</div>
						<div class="layui-input-inline">
							<input type="text" placeholder="父亲姓名" lay-verify="fatherName" value="${fatherName}" name="fatherName" id="fatherName" autocomplete="off" class="layui-input" style="width: 120%;">
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="margin-left: -10%;">电话：</label>
						</div>
						<div class="layui-inline">
							<input type="text" placeholder="父亲手机号" lay-verify="fatherPhone" value="${fatherPhone}" name="fatherPhone" id="fatherPhone" autocomplete="off" class="layui-input" style="width: 122%; margin-left: -10%;">
						</div>
					</div>
					<div class="planDiv">
						<div class="layui-inline">
							<label class="layui-form-label"><span class="must">*</span>母亲信息：</label>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="width: 60px; padding-left: 0px;">姓名：</label>
						</div>
						<div class="layui-input-inline">
							<input type="text" placeholder="母亲姓名" lay-verify="motherName" value="${motherName}" name="motherName" id="motherName" autocomplete="off" class="layui-input" style="width: 120%;">
						</div>
						<div class="layui-inline">
							<label class="layui-form-label" style="margin-left: -10%;">电话：</label>
						</div>
						<div class="layui-inline">
							<input type="text" placeholder="母亲手机号" lay-verify="motherPhone" value="${motherPhone}" name="motherPhone" id="motherPhone" autocomplete="off" class="layui-input" style="width: 122%; margin-left: -10%;">
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: 10px;">
						<label class="layui-form-label"><span class="must">*</span>所属店铺：</label>
						<div class="layui-input-inline">
							<select class="layui-inputs" name="inShop" id="inShop" lay-filter="inShop">
								<option value=" ">请选择</option>
								<c:forEach items="${shopList}" var="shopList">
									<option value="${shopList.Id}"
										<c:if test="${shopList.Id==inShop}">selected</c:if>>${shopList.shopName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>所属班级：</label>
						<div class="layui-input-inline">
							<select class="layui-inputs" name="inClass" id="inClass" lay-filter="inClass">
								<option value=" ">请选择</option>
								<c:forEach items="${classList}" var="classList">
									<option value="${classList.Id}"
										<c:if test="${classList.Id==inClass}">selected</c:if>>${classList.className}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">入学时间：</label>
						<div class="layui-input-inline">
							<input type="text" name="ruxueTime" id="ruxueTime" lay-verify="date" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
					    <label class="layui-form-label"><span class="must">*</span>是否缴费：</label>
					    <div class="layui-input-block">
					      <input type="radio"  name="isPay" value="0" title="已交" <c:if test="${isPay==0 || isPay==null}">checked</c:if> >
					      <input type="radio"  name="isPay" value="1" title="未交" <c:if test="${isPay==1}">checked</c:if> >
					    </div>
					</div>
					<div class="layui-form-item" style="text-align: center;">
						<button class="layui-btn" style="width: 50%; margin-top: 12px;" id="saveInfo" lay-submit="" lay-filter="addEqBtn">保存</button>
					</div>
				</form>
			</div>
		</div>
	</m:Content>
	<m:Content contentPlaceHolderId="js">

		<script type="text/javascript">
	
		layui.use(['form','laydate','layedit'], function(){
			var form = layui.form;
			var laydate = layui.laydate;
			
			//监听提交
			form.on('submit(addEqBtn)', function(data){
				if(!check()){
					return false;
				}
				var success = function(data){
					if(data.result){
						layer.msg(data.msg, {icon: 1});
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var postData = $(data.form).serialize();
				ajax('/${applicationScope.adminprefix }/danceClass/addClassPlan', postData, success, 'post', 'json');
				return false;
			})
			
			laydate.render({
				elem: '#ruxueTime'
				/* range: true  区间时间选择*/
			});
			
			function check(){
				var result = true;
				var planSize = $("#allPlans .planDiv").length;
				if(planSize==0){
					layer.msg("请至少添加一项活动计划！",{icon:2});
					result = false;
					return result;
				}else{
					$("#allPlans .planDiv").each(function(){
						var num = $(this).attr("num");
						var title = $(this).find("input[id='plan"+num+"_planName']").val();
						var planTime = $(this).find("input[id='plan"+num+"_activityTime']").val();
						var address = $(this).find("input[id='plan"+num+"_address']").val();
						var students = $(this).find("input[id='plan"+num+"_students']").val();
						if(title==null || title==''){
							tipinfo("请输入活动标题！","#plan"+num+"_planName");
							result = false;
							return result;
						}
						if(planTime==null || planTime==''){
							tipinfo("请输入活动时间！","#plan"+num+"_activityTime");
							result = false;
							return result;
						}
						if(address==null || address==''){
							tipinfo("请输入活动地点！","#plan"+num+"_address");
							result = false;
							return result;
						}
						if(students==null || students==''){
							tipinfo("请选择参加的学生！","#id_select"+num);
							result = false;
							return result;
						}
					})
				}
				return result;
			}
			
			
		})
		
		//删除活动计划
		function delplan(planNum){
			var text = "确定删除'活动计划"+planNum+"'?";
			layer.confirm(text, {icon: 7}, function(){
				
				$("#plan"+planNum).remove();
				layer.closeAll('dialog');
				$("#allNum").val($("#allNum").val().replace(planNum+",",""));
			})
		}
    	
		
	</script>
	</m:Content>
</m:ContentPage>