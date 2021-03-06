<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">

<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/manage/public/css/selected/bootstrap-select.css">

	<style>
		.layui-form-label{
			width: 145px;
		}
		.must{
			color: red;
			margin-right: 2%;
			size: 10px;
			font-size: 15px;
		}
		.nowPage{
			margin-top: 10px;
		}
		.layui-input {
		    width: 325%;
		}
		.layui-form-select .layui-edge{
			right: -215%;
		}
		.layui-form-select dl{
			width: 325%;
		}
		.bootstrap-select > .btn {
		    width: 281%;
		}
		.dropdown-menu{
			width: 280%;
		}
		.dropdown-menu>li>a{
			width: 595%;
		}
		li{
			width: 10%;
		}
		.delonePlan{
			margin-right: 10px;
		}
		.deloneicon{
			font-size: 18px;
			color: #EB3B42;
			cursor: pointer;
		}
	</style>
</m:Content>
<m:Content contentPlaceHolderId="content">
	<div style="padding:0 30px" class="layui-anim layui-anim-upbit">
	<blockquote class="layui-elem-quote nowPage">
			教学计划
	</blockquote>
		<div class="layui-form-item" style="padding-top: 10px; margin-bottom: 0;">
			<div class="layui-inline">
				<button class="layui-btn layui-btn-normal" id="addPlan"><i class="layui-icon">&#xe654;</i>添加活动</button>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-danger" id="delPlan"><i class="layui-icon">&#xe640;</i><span id="delText">删除活动</span></button>
			</div>
		
			<div style="clear: both"></div>
		</div>
		<div class="layui-field-box" style=" border-color:#666; border-radius:3px; padding:10px;">
			<form class="layui-form">
				<input type="hidden" name="allNum" id="allNum" value="${allNum}">
				<div class="layui-form-item">
					<label class="layui-form-label">计划年份：</label>
					<div class="layui-input-inline">
						<select class="layui-inputs" name="planyear" id="planyear" lay-filter="planyear">
							<c:forEach items="${yearList}" var="yearList">
								<option value="${yearList.Id}" <c:if test="${yearList.years==nowYear}">selected</c:if> >${yearList.years}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<!-- 活动详情 -->
				<div id="allPlans">
					<c:if test="${not empty planInfo}">
						<c:forEach items="${planInfo}" var="list">
							<div id="plan${list.planNum}" num="${list.planNum}" class="planDiv">
								<input type="hidden" name="planNum_${list.planNum}" id="planNum_${list.planNum}" value="${list.planNum}">
								<div class="layui-inline">
									<label class="layui-form-label"><span onclick="delplan('${list.planNum}');" class="delonePlan" style="display: none"><i class="layui-icon layui-icon-close-fill deloneicon" >&#x1007;</i></span><span class="must">*</span>活动计划${list.planNum}：</label>
								</div>
								<div class="layui-inline">
									<label class="layui-form-label" style="width: 60px;padding-left: 0px;">标题：</label>
								</div>
								<div class="layui-input-inline">
									<input type="text"  placeholder="活动名称" lay-verify="plan${list.planNum}_planName" value="${list.planName}" name="plan${list.planNum}_planName" id="plan${list.planNum}_planName"  autocomplete="off" class="layui-input" style="width: 120%;">
								</div>
								<div class="layui-inline">
									<label class="layui-form-label" style="margin-left: -10%;">时间：</label>
								</div>
								<div class="layui-input-inline">
							        <input type="text" class="layui-input" lay-verify="plan${list.planNum}_activityTime" id="plan${list.planNum}_activityTime" name="plan${list.planNum}_activityTime" value="${list.activityTime}" placeholder="请选择活动时间" style="width: 120%;margin-left: -10%;">
							    </div>
								<div class="layui-inline">
									<label class="layui-form-label" style="margin-left: -10%;">地点：</label>
								</div>
								<div class="layui-inline">
									<input type="text" placeholder="活动地点" lay-verify="plan${list.planNum}_address" value="${list.address}" name="plan${list.planNum}_address" id="plan${list.planNum}_address"  autocomplete="off" class="layui-input" style="width: 122%;margin-left: -10%;">
								</div>
								<div class="joinStudent" style="margin-top: 20px;">
									<input type="hidden" name="plan${list.planNum}_students" id="plan${list.planNum}_students" value="${list.students}">
									<label id="id_select${list.planNum}" class="layui-form-label"><span class="must">*</span>参加学生：</label>
									<select id="id_select" num="${list.planNum}" class="selectpicker bla bla bli" multiple data-live-search="true">
									  	<c:forEach items="${stuList}" var="stuList">
									  		<option value="${stuList.Id}" <c:if test="${fn:contains(list.students,stuList.Id)==true}">selected</c:if> >${stuList.stuName}</option>
									  	</c:forEach>
									</select>
									
									<div class="layui-inline" style="margin-top: -5px;margin-left: 349.5px;">
										<label class="layui-form-label">盈利：</label>
									</div>
									<div class="layui-inline" style="margin-top: -12px;">
										<input type="text" placeholder="盈利金额￥" lay-verify="plan${list.planNum}_profit" value="${list.profit}" name="plan${list.planNum}_profit" id="plan${list.planNum}_profit"  autocomplete="off" class="layui-input" style="width: 122%;">
									</div>
								</div>
							</div>  
						</c:forEach>
					</c:if>
				</div>	
				<div class="layui-form-item" style="text-align: center;">
					<button class="layui-btn" style="width: 50%;margin-top: 60px;" id="saveInfo" lay-submit="" lay-filter="addEqBtn">保存</button>
				</div>
			
			</form>
		</div>
	</div>
</m:Content>
<m:Content contentPlaceHolderId="js">
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/manage/public/js/bootstrap-select.js"></script>

	<script type="text/javascript">
	var sutdentList = ${stujsonList};
	var options = "";
	$(function(){
		for(var i = 0;i<sutdentList.length;i++){
			options += "<option value='"+sutdentList[i].Id+"'>"+sutdentList[i].stuName+"</option>";
		}
	})
	
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
			
			function check(){
				var result = true;
				var planSize = $("#allPlans .planDiv").length;
				if(planSize==0){
					layer.msg("请至少添加一项活动计划！",{icon:2});
					result = false;
					return result;
				}else{
					$("#allPlans .planDiv").each(function(){
						debugger;
						var num = $(this).attr("num");
						var title = $(this).find("input[id='plan"+num+"_planName']").val();
						var planTime = $(this).find("input[id='plan"+num+"_activityTime']").val();
						var address = $(this).find("input[id='plan"+num+"_address']").val();
						var students = $(this).find("input[id='plan"+num+"_students']").val();
						var profit = $(this).find("input[id='plan"+num+"_profit']").val();
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
						var patrn  = /^(-)?\d+(\.\d+)?$/;//校验数字
						if(profit==null || profit=='' || !patrn.exec(profit)){
							tipinfo("请输入此次活动的盈利！","#plan"+num+"_profit");
							result = false;
							return result;
						}
					})
				}
				return result;
			}
			
			//添加计划-拼串
			$("#addPlan").click(function(){
				var maxNum = 0;//获得最大的num值
				$("#allPlans .planDiv").each(function(){
					var nowNum = Number($(this).attr("num"));
					if(nowNum>maxNum){
						maxNum = nowNum;
					}
				})
				
				var delText = $("#delText").html();
				var display = "";
				if(delText=='删除活动'){
					display = "none";
				}else{
					display = "inline";
				}
				var newNum = maxNum+1;//最新添加的计划的num值
				$("#allNum").val($("#allNum").val()+newNum+",");
				var html = '<div id="plan'+newNum+'" num="'+newNum+'" class="planDiv">'+
						   //'<input type="hidden" name="planNum_'+newNum+'" id="planNum_'+newNum+'" value="'+newNum+'">'+	
						   '	<div class="layui-inline"> '+
						   '		<label class="layui-form-label"><span onclick="delplan('+newNum+');" class="delonePlan" style="display:'+display+';"><i class="layui-icon layui-icon-close-fill deloneicon">&#x1007;</i></span><span class="must">*</span>活动计划'+newNum+'：</label>'+
						   '	</div> '+
						   '	<div class="layui-inline"> '+
						   '		<label class="layui-form-label" style="width: 60px;padding-left: 0px;">标题：</label> '+
						   '	</div> '+
						   '	<div class="layui-input-inline"> '+
						   '		<input type="text"  placeholder="活动名称" lay-verify="plan'+newNum+'_planName" value="" name="plan'+newNum+'_planName" id="plan'+newNum+'_planName"  autocomplete="off" class="layui-input" style="width: 120%;"> '+
						   '	</div> '+
						   '	<div class="layui-inline"> '+
						   '		<label class="layui-form-label" style="margin-left: -10%;">时间：</label> '+
						   '	</div> '+
						   '	<div class="layui-input-inline"> '+
						   '        <input type="text" class="layui-input" lay-verify="plan'+newNum+'_activityTime" id="plan'+newNum+'_activityTime" name="plan'+newNum+'_activityTime" value="" placeholder="请选择活动时间" style="width: 120%;margin-left: -10%;"> '+
						   '    </div> '+
						   '	<div class="layui-inline"> '+
						   '		<label class="layui-form-label" style="margin-left: -10%;">地点：</label> '+
						   '	</div> '+
						   '	<div class="layui-inline"> '+
						   '		<input type="text" placeholder="活动地点" lay-verify="plan'+newNum+'_address" value="" name="plan'+newNum+'_address" id="plan'+newNum+'_address"  autocomplete="off" class="layui-input" style="width: 122%;margin-left: -10%;"> '+
						   '	</div> '+
						   '	<div class="joinStudent" style="margin-top: 20px;"> '+
						   '		<input type="hidden" name="plan'+newNum+'_students" id="plan'+newNum+'_students" value=""> '+
						   '		<label id="id_select'+newNum+'" class="layui-form-label"><span class="must">*</span>参加学生：</label> '+
						   '		<select id="id_select" num='+newNum+' class="selectpicker bla bla bli" multiple data-live-search="true"> '+options+
						   '		</select> '+
						   		
						   '		<div class="layui-inline" style="margin-top: -5px;margin-left: 347px;">'+
						   '			<label class="layui-form-label">盈利：</label>'+
						   '		</div>'+
						   '		<div class="layui-inline" style="margin-top: -11px;">'+
						   '			<input type="text" placeholder="盈利金额￥" lay-verify="plan'+newNum+'_profit" value="" name="plan'+newNum+'_profit" id="plan'+newNum+'_profit"  autocomplete="off" class="layui-input" style="width: 122%;">'+
						   '		</div>'+
						   '	</div> '+
						   '</div>';
				
				$("#allPlans").append(html);	
				
				//初始化下拉多选插件
				$(".joinStudent .layui-unselect").remove();
				$('.selectpicker').selectpicker({
					'selectedText' : 'cat'
				});
				//初始化时间选择框
				laydate.render({
				    elem: '#plan'+newNum+'_activityTime', //指定元素
				    type: 'datetime'
				});
				
			})
			
			//点击删除按钮，显示活动计划前的叉号
			$("#delPlan").click(function(){
				
				var delText = $(this).find("#delText").html();
				if(delText=='删除活动'){
					$(this).find("#delText").html('取消删除');
					$(".delonePlan").css("display","inline");
				}else{
					$(this).find("#delText").html('删除活动');
					$(".delonePlan").css("display","none");
				}
			})
			
			//根据年份查询活动
			form.on('select(planyear)', function(data){
				var years = data.value;
			   window.location.href = "/${applicationScope.adminprefix }/danceClass/classPlanFace?planyears="+years;
			})
			
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
    	
		//初始化下拉多选模块
		$(window).on('load', function() {
			$(".joinStudent .layui-unselect").remove();
			$('.selectpicker').selectpicker({
				'selectedText' : 'cat'
			});

		});
	</script>
</m:Content>
</m:ContentPage>