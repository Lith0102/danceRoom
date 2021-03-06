<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
	<m:Content contentPlaceHolderId="css">

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

.layui-input {
	width: 330%;
}
.only-input{
	width: 87%;
}
.layui-textarea{
	width: 87%;
}
.photoDiv{
	border: 1px solid #E6E6E6;
	width: 200px;
	height: 250px;
	margin-left: 175px;
	color: #C1C1C1;
	text-align: center;
	line-height: 250px;
	font-size: 15px;
	cursor: pointer;
}
/* .layui-form-select .layui-edge {
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
} */



</style>
	</m:Content>
	<m:Content contentPlaceHolderId="content">
		<div style="padding: 0 30px" class="layui-anim layui-anim-upbit">
			<blockquote class="layui-elem-quote layui-bg-blue" style="margin-top: 10px;">
				财务统计计算
			</blockquote>
			<input type="hidden" name="isCalculation" id="isCalculation" value="0">
			<div class="layui-field-box" style="border-color: #666; border-radius: 3px; padding: 10px;">
				<form class="layui-form">
					<div class="layui-form-item" style="margin-top: -8px;">
					    <label class="layui-form-label"><span class="must">*</span>统计分类：</label>
					    <div class="layui-input-block">
					      <input type="radio" lay-filter="calculationType"  name="calculationType" value="1" title="季度统计">
					      <input type="radio" lay-filter="calculationType"  name="calculationType" value="2" title="上半年统计" >
					      <input type="radio" lay-filter="calculationType"  name="calculationType" value="3" title="下半年统计" >
					      <input type="radio" lay-filter="calculationType"  name="calculationType" value="4" title="本年统计" >
					    </div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>学生缴费收入：</label>
						<div class="layui-input-block">
							<input type="text" name="studentPay" id="studentPay" value="" lay-verify="studentPay"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>活动收入：</label>
						<div class="layui-input-block">
							<input type="text" name="activityIncome" id="activityIncome" value="" lay-verify="activityIncome"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: 10px;">
						<label class="layui-form-label">其他收入：</label>
						<div class="layui-input-block">
							<input type="text" name="otherIncome" id="otherIncome" value="" lay-verify="otherIncome"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="must">*</span>购买支出：</label>
						<div class="layui-input-block">
							<input type="text" name="expenditure" id="expenditure" value="" lay-verify="expenditure"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: 10px;">
						<label class="layui-form-label">其他支出：</label>
						<div class="layui-input-block">
							<input type="text" name="otherBuy" id="otherBuy" value="" lay-verify="otherBuy"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-form-item" style="margin-top: 10px;">
						<label class="layui-form-label"><span class="must">总共盈利：</span></label>
						<div class="layui-input-block">
							<input type="text" readonly="readonly" name="profit" id="profit" value="" lay-verify="profit"  autocomplete="off" class="layui-input only-input" />
						</div>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label">统计时间：</label>
						<div class="layui-input-inline">
							<input type="text" readonly="readonly" value="" name="statisticsTime" id="statisticsTime" autocomplete="off" class="layui-input" style="width: 502%">
						</div>
					</div>
					<div class="layui-form-item" style="text-align: center;">
						<a class="layui-btn layui-btn-normal" style="width: 15%; margin-top: 12px;" id="calculation" lay-filter="calculation">计算</a>
						<a class="layui-btn layui-btn-warm" style="width: 15%; margin-top: 12px;" id="details" lay-submit="" lay-filter="details">查看详情</a>
						<button class="layui-btn" style="width: 15%; margin-top: 12px;" id="saveInfo" lay-submit="" lay-filter="addEqBtn">保存</button>
					</div>
				</form>
			</div>
		</div>
	</m:Content>
	<m:Content contentPlaceHolderId="js">
	
		<script type="text/javascript" src="/manage/public/js/jquery.form.min.js"></script>
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
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var postData = $(data.form).serialize();
				ajax('/${applicationScope.adminprefix }/finance/addStatisticsInfo', postData, success, 'post', 'json');
				return false;
			})
			
			laydate.render({
				elem: '#statisticsTime',
				type:'date'
				/* range: true  区间时间选择*/
			});
			form.on('radio(calculationType)', function(data){
				$("#studentPay").val("");
				$("#activityIncome").val("");
				$("#otherIncome").val("");
				$("#expenditure").val("");
				$("#statisticsTime").val("");
				$("#otherBuy").val("");
				$("#profit").val("");
				$("#isCalculation").val(0);
			});  
			
			function check(){
				var jsType = $("input[name='calculationType']:checked").val();	
				var studentPay = $("#studentPay").val();
				var activityIncome = $("#activityIncome").val();
				var expenditure = $("#expenditure").val();
				var profit = $("#profit").val();
				
				if(jsType==null || jsType=='' || jsType=='undefined'){
					layer.msg("请选择统计类型并计算！",{icon:2});
					return false;
				}
				
				if(studentPay==null || studentPay==''){
					layer.msg("学生缴费收入未统计出，请重新计算！",{icon:2});
					return false;
				}
			
				if(activityIncome==null || activityIncome==''){
					layer.msg("活动收入未统计出，请重新计算！",{icon:2});
					return false;
				}
				if(expenditure==null || expenditure==''){
					layer.msg("购买支出未统计出，请重新计算！",{icon:2});
					return false;
				}
				if(profit==null || profit==''){
					layer.msg("总盈利未统计出，请重新计算！",{icon:2});
					return false;
				}
				return true;
			}
			
			//计算盈利
			$("#calculation").click(function(){
				var jsType = $("input[name='calculationType']:checked").val();
				if(jsType==null || jsType=='' || jsType=='undefined'){
					layer.msg("请先选择统计分类",{'icon':2})
				}else{
					$.ajax({
						type:"get",
						url:"/${applicationScope.adminprefix }/finance/calculation",
						data:{"jsType":jsType},
						dataType:"json",
						async:false,
						success:function(data){
							
							var isCalculation = $("#isCalculation").val();
							if(isCalculation==0){
								$("#studentPay").val(data.totalStuMoney);
								$("#activityIncome").val(data.totalActivityMoney);
								$("#expenditure").val(data.buyMoney);
								$("#statisticsTime").val(data.nowYmd);
								$("#profit").val(data.profit);
								$("#isCalculation").val(1);
							}else{
								var studentPay = Number($("#studentPay").val());//学生收费
								var activityIncome = Number($("#activityIncome").val());//活动盈利
								var otherIncome = Number($("#otherIncome").val());//其他收入
								var expenditure = Number($("#expenditure").val());//购买支出
								var otherBuy = Number($("#otherBuy").val());//其他支出
								var profit = studentPay+activityIncome+otherIncome-expenditure-otherBuy;
								$("#profit").val(profit);//总盈利
							}
							
						},
					});
				}
				
			})
			
		})
		
		
	</script>
	</m:Content>
</m:ContentPage>