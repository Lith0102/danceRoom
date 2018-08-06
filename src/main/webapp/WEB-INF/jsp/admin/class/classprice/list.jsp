<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/authorizetag.tld" prefix="px"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">
	<style>
		.layui-input, .layui-textarea{
			width: 92%;
		} 
		.layui-form-label{
			width: 125px;
		}
		.must{
			color: red;
			margin-right: 2%;
			size: 10px;
			font-size: 15px;
		}
		.clear{
			clear:both;
		}
		.ss_biao{
			float: right;
			margin-top: -4%;
			margin-right:3%;
			cursor:pointer;
		}
		.nowPage{
			margin-top: 10px;
		}
	</style>
</m:Content>
<m:Content contentPlaceHolderId="content">
	<div style="padding:0 30px" class="layui-anim layui-anim-upbit">
	<blockquote class="layui-elem-quote nowPage">
			课程费用
	</blockquote>
		<div class="layui-field-box" style=" border-color:#666; border-radius:3px; padding:10px;">
			<form class="layui-form">
			<input type="hidden" name="priceId" id="priceId" value="${Id}">
            	<div class="layui-form-item">
					<label class="layui-form-label"><span class="must">*</span>舞蹈班地址：</label>
					<div class="layui-input-block">
						<input type="text" name="address" id="address" value="${address}" lay-verify="address"  autocomplete="off" class="layui-input" />
					</div>
				</div>
				<!-- 季度详情 -->
				<div>
					<div class="layui-inline">
						<label class="layui-form-label"><span class="must">*</span>季度：</label>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 50px;padding-left: 0px;">原价：</label>
					</div>
					<div class="layui-input-inline">
							<input type="text"  placeholder="￥" lay-verify="jidu" value="${jidu}" name="jidu" id="jidu"  autocomplete="off" class="layui-input" style="width: 120%;">
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="margin-left: -10%;">活动价：</label>
					</div>
					<div class="layui-inline">
						<input type="text"  placeholder="￥" lay-verify="jiduActivity" value="${jiduActivity}" name="jiduActivity" id="jiduActivity"  autocomplete="off" class="layui-input" style="width: 120%;margin-left: -10%;">
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="margin-left: -10%;">课时：</label>
					</div>
					<div class="layui-inline">
						<input type="text" lay-verify="jiduHour" value="${jiduHour}" name="jiduHour" id="jiduHour"  autocomplete="off" class="layui-input" style="width: 122%;margin-left: -10%;">
					</div>
					<div class="layui-form-item" id="jiduChexkbox" style="margin-top: 20px;">
						<input type="hidden" name="jiduGift" id="jiduGift" value="${jiduGift}">
						<label class="layui-form-label">季度赠品:</label>
						<div class="layui-input-block">
						      <input type="checkbox" lay-filter="jiduall"  name="jiduall" id="jiduall" value="0" title="全部赠送" <c:if test="${fn:contains(jiduGift,'0')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="jidudong" name="jidudong" id="jidudong" value="1" title="冬季练功服" <c:if test="${fn:contains(jiduGift,'1')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="jiduxia" name="jiduxia" id="qikanCheck" value="2" title="夏季练功服" <c:if test="${fn:contains(jiduGift,'2')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="jiduxie" name="jiduxie" id="jiduxie" value="3" title="舞蹈鞋" <c:if test="${fn:contains(jiduGift,'3')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="jiduku" name="jiduku" id="jiduku" value="4" title="打底裤" <c:if test="${fn:contains(jiduGift,'4')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="jidubei" name="jidubei" id="jidubei" value="5" title="水杯" <c:if test="${fn:contains(jiduGift,'5')==true}">checked</c:if>>
					    </div>
					</div>
				</div>
				<!-- 半年详情 -->
				<div>
					<div class="layui-inline">
						<label class="layui-form-label"><span class="must">*</span>半年：</label>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 50px;padding-left: 0px;">原价：</label>
					</div>
					<div class="layui-input-inline">
							<input type="text"  placeholder="￥" lay-verify="bannian" value="${bannian}" name="bannian" id="bannian"  autocomplete="off" class="layui-input" style="width: 120%;">
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="margin-left: -10%;">活动价：</label>
					</div>
					<div class="layui-inline">
						<input type="text"  placeholder="￥" lay-verify="bannianActivity" value="${bannianActivity}" name="bannianActivity" id="bannianActivity"  autocomplete="off" class="layui-input" style="width: 120%;margin-left: -10%;">
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="margin-left: -10%;">课时：</label>
					</div>
					<div class="layui-inline">
						<input type="text" lay-verify="bannianHour" value="${bannianHour}" name="bannianHour" id="bannianHour"  autocomplete="off" class="layui-input" style="width: 122%;margin-left: -10%;">
					</div>
					<div class="layui-form-item" id="bannianChexkbox" style="margin-top: 20px;">
						<input type="hidden" name="bannianGift" id="bannianGift" value="${bannianGift}">
						<label class="layui-form-label">半年赠品:</label>
						<div class="layui-input-block">
						      <input type="checkbox" lay-filter="bannianall"  name="bannianall" id="bannianall" value="0" title="全部赠送" <c:if test="${fn:contains(bannianGift,'0')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="banniandong" name="banniandong" id="banniandong" value="1" title="冬季练功服" <c:if test="${fn:contains(bannianGift,'1')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="bannianxia" name="bannianxia" id="bannianxia" value="2" title="夏季练功服" <c:if test="${fn:contains(bannianGift,'2')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="bannianxie" name="bannianxie" id="bannianxie" value="3" title="舞蹈鞋" <c:if test="${fn:contains(bannianGift,'3')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="bannianku" name="bannianku" id="bannianku" value="4" title="打底裤" <c:if test="${fn:contains(bannianGift,'4')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="bannianbei" name="bannianbei" id="bannianbei" value="5" title="水杯" <c:if test="${fn:contains(bannianGift,'5')==true}">checked</c:if>>
					    </div>
					</div>
				</div>
				<!-- 全年详情 -->
				<div>
					<div class="layui-inline">
						<label class="layui-form-label"><span class="must">*</span>全年：</label>
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="width: 50px;padding-left: 0px;">原价：</label>
					</div>
					<div class="layui-input-inline">
							<input type="text"  placeholder="￥" lay-verify="years" value="${years}" name="years" id="years"  autocomplete="off" class="layui-input" style="width: 120%;">
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="margin-left: -10%;">活动价：</label>
					</div>
					<div class="layui-inline">
						<input type="text"  placeholder="￥" lay-verify="yearActivity" value="${yearActivity}" name="yearActivity" id="yearActivity"  autocomplete="off" class="layui-input" style="width: 120%;margin-left: -10%;">
					</div>
					<div class="layui-inline">
						<label class="layui-form-label" style="margin-left: -10%;">课时：</label>
					</div>
					<div class="layui-inline">
						<input type="text" lay-verify="yearHour" value="${yearHour}" name="yearHour" id="yearHour"  autocomplete="off" class="layui-input" style="width: 122%;margin-left: -10%;">
					</div>
					<div class="layui-form-item" id="yearChexkbox" style="margin-top: 20px;">
						<input type="hidden" name="yearGift" id="yearGift" value="${yearGift}">
						<label class="layui-form-label">全年赠品:</label>
						<div class="layui-input-block">
						      <input type="checkbox" lay-filter="yearall"  name="yearall" id="yearall" value="0" title="全部赠送" <c:if test="${fn:contains(yearGift,'0')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="yeardong" name="yeardong" id="yeardong" value="1" title="冬季练功服" <c:if test="${fn:contains(yearGift,'1')==true}">checked</c:if> >
						      <input type="checkbox" lay-filter="yearxia" name="yearxia" id="yearxia" value="2" title="夏季练功服" <c:if test="${fn:contains(yearGift,'2')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="yearxie" name="yearxie" id="yearxie" value="3" title="舞蹈鞋" <c:if test="${fn:contains(yearGift,'3')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="yearku" name="yearku" id="yearku" value="4" title="打底裤" <c:if test="${fn:contains(yearGift,'4')==true}">checked</c:if>>
						      <input type="checkbox" lay-filter="yearbei" name="yearbei" id="yearbei" value="5" title="水杯" <c:if test="${fn:contains(yearGift,'5')==true}">checked</c:if>>
					    </div>
					</div>
				</div>
				
				<div class="layui-form-item">
				    <label class="layui-form-label"><span class="must">*</span>是否启用活动价：</label>
				    <div class="layui-input-block">
				      <input type="radio"  name="isActivity" value="0" title="否" <c:if test="${isActivity==0 || isActivity==null}">checked</c:if> >
				      <input type="radio"  name="isActivity" value="1" title="是" <c:if test="${isActivity==1}">checked</c:if> >
				    </div>
				</div>
				
				<div class="layui-form-item" style="text-align: center;">
					<button class="layui-btn" style="width: 50%;margin-top: 60px;" id="saveInfo" lay-submit="" lay-filter="addEqBtn">保存</button>
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
		/* 	laydate.render({
			    elem: '#startTime' //指定元素
			});
			laydate.render({
			    elem: '#endTime' //指定元素
			}); */
			//监听提交
			form.on('submit(addEqBtn)', function(data){
				/* if(!check()){
					return false;
				} */
				var success = function(data){
					if(data.result){
						layer.msg(data.msg, {icon: 1});
					}else{
						layer.msg(data.msg, {icon: 2});
					}
				}
				var postData = $(data.form).serialize();
				ajax('/${applicationScope.adminprefix }/danceClass/addClassPrice', postData, success, 'post', 'json');
				return false;
			})
			//自定义验证规则
			form.verify({
				
				address: function(value) {
					if(value.length < 3) {
						return '请填写舞蹈班名称及位置';
					}
				},
				jidu:function(value){
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(value==null || value=='' || !regPos.test(value)){
						return '请填写正确的季度价格';
					}
				},
				jiduActivity:function(value){
					var isActivity = $("input[name='isActivity']:checked").val();
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(isActivity==1){
						if(value==null || value=='' || !regPos.test(value)){
							return '请填写正确的季度活动价格';
						}
					}
				},
				jiduHour:function(value){
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(value==null || value=='' || !regPos.test(value)){
						return '请填写正确的季度课时';
					}
				},
				bannian:function(value){
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(value==null || value=='' || !regPos.test(value)){
						return '请填写正确的半年价格';
					}
				},
				bannianActivity:function(value){
					var isActivity = $("input[name='isActivity']:checked").val();
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(isActivity==1){
						if(value==null || value=='' || !regPos.test(value)){
							return '请填写正确的半年活动价';
						}
					}
					
				},
				bannianHour:function(value){
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(value==null || value=='' || !regPos.test(value)){
						return '请填写正确的半年课时';
					}
				},
				years:function(value){
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(value==null || value=='' || !regPos.test(value)){
						return '请填写正确的全年价格';
					}
				},
				yearActivity:function(value){
					var isActivity = $("input[name='isActivity']:checked").val();
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(isActivity==1){
						if(value==null || value=='' || !regPos.test(value)){
							return '请填写正确的全年活动价';
						}
					}
					
				},
				yearHour:function(value){
					var regPos = /^\d+(\.\d+)?$/;//非负浮点数
					if(value==null || value=='' || !regPos.test(value)){
						return '请填写正确的全年课时';
					}
				}
				
				
			});
		
			
			//季度赠品全选操作
			form.on('checkbox(jiduall)', function(data){
				var allisCheck = $(this).is(':checked');//判断全选按钮是否选中 （boolean）
				$("#jiduChexkbox input[type='checkbox']").each(function(){
					var this_value = $(this).val();
					var this_ischeck = $(this).is(':checked');
					if(this_value!=0 && allisCheck!=this_ischeck){
						$(this).next().click();
					}
				})
			});
			//半年赠品全选操作
			form.on('checkbox(bannianall)', function(data){
				var allisCheck = $(this).is(':checked');//判断全选按钮是否选中 （boolean）
				$("#bannianChexkbox input[type='checkbox']").each(function(){
					var this_value = $(this).val();
					var this_ischeck = $(this).is(':checked');
					if(this_value!=0 && allisCheck!=this_ischeck){
						$(this).next().click();
					}
				})
			});
			//全年赠品全选操作
			form.on('checkbox(yearall)', function(data){
				var allisCheck = $(this).is(':checked');//判断全选按钮是否选中 （boolean）
				$("#yearChexkbox input[type='checkbox']").each(function(){
					var this_value = $(this).val();
					var this_ischeck = $(this).is(':checked');
					if(this_value!=0 && allisCheck!=this_ischeck){
						$(this).next().click();
					}
				})
			});
			//获取所有赠品的值-拼串
			form.on('checkbox()', function(data){
				var jidugift = [];
				var banniangift = [];
				var yeargift = [];
				var checkName = $(this).attr("name");
				if(checkName.indexOf("jidu")>=0){
					var allisCjeck = $("#jiduall").is(":checked");
					var checkSize = $("#jiduChexkbox input[type='checkbox']:checked").not("input[name='jiduall']").length;
					if(checkSize==5 && !allisCjeck){
						$("#jiduall").click();
						$("#jiduall").attr("checked","checked");
						$("#jiduall").next().addClass("layui-form-checked");
					}else if(checkSize<5){
						$("#jiduall").removeAttr("checked");
						$("#jiduall").next().removeClass("layui-form-checked");
					}
					
					$("#jiduChexkbox input[type='checkbox']:checked").each(function(){
						jidugift.push($(this).val());
					})
					$("#jiduGift").val(jidugift.join(","));
				}else if(checkName.indexOf("bannian")>=0){
					var allisCjeck = $("#bannianall").is(":checked");
					var checkSize = $("#bannianChexkbox input[type='checkbox']:checked").not("input[name='bannianall']").length;
					if(checkSize==5 && !allisCjeck){
						$("#bannianall").click();
						$("#bannianall").attr("checked","checked");
						$("#bannianall").next().addClass("layui-form-checked");
					}else if(checkSize<5){
						$("#bannianall").removeAttr("checked");
						$("#bannianall").next().removeClass("layui-form-checked");
					}
					
					$("#bannianChexkbox input[type='checkbox']:checked").each(function(){
						banniangift.push($(this).val());
					})
					$("#bannianGift").val(banniangift.join(","));
				}else if(checkName.indexOf("year")>=0){
					var allisCjeck = $("#yearall").is(":checked");
					var checkSize = $("#yearChexkbox input[type='checkbox']:checked").not("input[name='yearall']").length;
					if(checkSize==5 && !allisCjeck){
						$("#yearall").click();
						$("#yearall").attr("checked","checked");
						$("#yearall").next().addClass("layui-form-checked");
					}else if(checkSize<5){
						$("#yearall").removeAttr("checked");
						$("#yearall").next().removeClass("layui-form-checked");
					}
					
					$("#yearChexkbox input[type='checkbox']:checked").each(function(){
						yeargift.push($(this).val());
					})
					$("#yearGift").val(yeargift.join(","));
				}
				
			});
			
		})
		
	</script>
</m:Content>
</m:ContentPage>