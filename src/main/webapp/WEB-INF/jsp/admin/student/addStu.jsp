<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
	<m:Content contentPlaceHolderId="css">

<style>
.layui-form-label {
	width: 114px;
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
	width: 77%;
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

			<div class="layui-field-box" style="border-color: #666; border-radius: 3px; padding: 10px;">
				<form class="layui-form">
					<input type="hidden" name="stuId" id="stuId" value="${Id}">
					<input type="hidden" name="type" id="type" value="${type}">
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
					<div class="planDiv" style="margin-top: 10px;">
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
							<input type="text" readonly="readonly" value="${ruxueTime}" name="ruxueTime" id="ruxueTime" autocomplete="off" class="layui-input" style="width: 340%">
						</div>
					</div>
					<div class="layui-form-item">
					    <label class="layui-form-label"><span class="must">*</span>是否缴费：</label>
					    <div class="layui-input-block">
					      <input type="radio" lay-filter="isPay"  name="isPay" value="0" title="已交" <c:if test="${isPay==0 || isPayType==0}">checked</c:if> >
					      <input type="radio" lay-filter="isPay"  name="isPay" value="1" title="未交" <c:if test="${isPay==1 || isPayType==1}">checked</c:if> >
					    </div>
					</div>
					<div class="layui-form-item" style="margin-top: -5px;" id="payType">
					    <label class="layui-form-label"><span class="must">*</span>缴费类型：</label>
					    <div class="layui-input-block">
					      <input type="radio"  name="payType" value="1" title="季度" <c:if test="${payType==1 || isPayType==0}">checked</c:if> >
					      <input type="radio"  name="payType" value="2" title="半年" <c:if test="${payType==2}">checked</c:if> >
					      <input type="radio"  name="payType" value="3" title="全年" <c:if test="${payType==3}">checked</c:if> >
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
			var index = parent.layer.getFrameIndex(window.name);
			//监听提交
			form.on('submit(addEqBtn)', function(data){
				if(!check()){
					return false;
				}
				var success = function(data){
					if(data.result){
						layer.msg(data.msg, {icon: 1});
						setTimeout(function(){
							parent.layer.close(index);
						},1000);
						
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var postData = $(data.form).serialize();
				ajax('/${applicationScope.adminprefix }/student/addStudent', postData, success, 'post', 'json');
				return false;
			})
			
			laydate.render({
				elem: '#ruxueTime',
				type:'date'
				/* range: true  区间时间选择*/
			});
			
			function check(){
					
				var stuName = $("#stuName").val();
				var age = $("#age").val();
				var fatherName = $("#fatherName").val();
				var fatherPhone = $("#fatherPhone").val();
				var motherName = $("#motherName").val();
				var motherPhone = $("#motherPhone").val();
				var inShop = $("#inShop").next().find(".layui-this").attr("lay-value");
				var inClass = $("#inClass").next().find(".layui-this").attr("lay-value");
				var ruxueTime = $("#ruxueTime").val();
				
				if(stuName==null || stuName==''){
					layer.msg("请输入学生姓名！",{icon:2});
					return false;
				}
				var reg=/^\+?[1-9][0-9]*$/;
				var aa = reg.test(age);
				if(age==null || age=='' || !reg.test(age)){
					layer.msg("请输入正确的学生年龄！",{icon:2});
					return false;
				}
				if((fatherName==null || fatherName=='') && (fatherPhone==null || fatherPhone=='') && (motherName==null || motherName=='') && (motherPhone==null || motherPhone=='')){
					layer.msg("请至少填写一位家长的信息！",{icon:2});
					return false;
				}
				var regPhone = /^((\d{3}-\d{8}|\d{4}-\d{7,8})|(1[3|5|7|8][0-9]{9}))$/
				if(fatherName!=null && fatherName!=''){
					if(fatherPhone==null || fatherPhone=='' || !regPhone.test(fatherPhone)){
						layer.msg("请填写正确的父亲的手机号！",{icon:2});
						return false;
					}
				}
				if(motherName!=null && motherName!=''){
					if(motherPhone==null || motherPhone==''){
						layer.msg("请填写母亲的手机号！",{icon:2});
						return false;
					}
				}
				if(inShop==null || inShop==' '){
					layer.msg("请选择所在店铺！",{icon:2});
					return false;
				}
				if(inClass==null || inClass==' '){
					layer.msg("请选择所在班级！",{icon:2});
					return false;
				}
				if(ruxueTime==null || ruxueTime==''){
					layer.msg("请选择入学时间！",{icon:2});
					return false;
				}
				
				return true;
			}
			
			//给是否缴费添加事件
			form.on('radio(isPay)', function(data){
				  var value = Number(data.value);
				  if(value==1){
					  $("#payType").css("display","none");
					  $("input:radio[name='payType']").attr("disabled",true);
				  }else{
					  $("#payType").css("display","inline");
					  $("input:radio[name='payType']").attr("disabled",false);
				  }
			}); 
			
			$(function(){
				var isPayType = ${isPayType};
				if(isPayType==1){
					$("#payType").css("display","none");
					$("input:radio[name='payType']").attr("disabled",true);
				}
				
			})
			
		})
		
		
	</script>
	</m:Content>
</m:ContentPage>