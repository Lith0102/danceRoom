<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/jsp-masterpage.tld" prefix="m"%>
<%@ taglib uri="cn.core.AuthorizeTag" prefix="px" %>
<m:ContentPage materPageId="master">
<m:Content contentPlaceHolderId="css">
	<link rel="stylesheet" href="/manage/public/css/layui_public/layui_dyx.css"/>
	<style type="text/css">
		body{
			height: 200%;
		}
		.layui-table-cell{
			height:200% !important;
			max-width: 200% !important;
		}
		.layui-table tr{
			height: 70px;
		}
		.delIcon{
			font-size: 20px;
		    font-weight: bolder;
		    color: #FF5722;
		    cursor: pointer;
		}
	</style>
</m:Content>
<m:Content contentPlaceHolderId="content">
	<!-- 内容主体区域 -->
	<div style="padding: 15px;" class="layui-anim layui-anim-upbit">
		<blockquote class="layui-elem-quote layui-bg-blue">
			课程表
		</blockquote>
		<!-- <div class="yw_cx">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">用户状态：</label>
					<div class="layui-input-inline">
						<select class="layui-input" name="isFreeze">
							<option value="">全部</option>
							<option value="0">禁用</option>
							<option value="1">启用</option>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">用户类型：</label>
					<div class="layui-input-inline">
						<select class="layui-input" name="userType">
							<option value="">全部</option>
							<option value="1">普通用户</option>
							<option value="2">专家</option>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">名称：</label>
					<div class="layui-input-inline">
						<input type="text" name="name" placeholder="用户名/真实姓名/手机号" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">注册日期：</label>
					<div class="layui-input-inline" style="width: 234px;">
						<input type="text" name="registrationDate" id="registrationDate" readonly="readonly" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<button class="layui-btn layui-btn-normal search"><i class="layui-icon">&#xe615;</i> 搜索</button>
				</div>
			</div>
		</div> -->
		<div class="layui-form-item" style="padding-top: 10px; margin-bottom: 0;">
			<div class="layui-inline">
				<button class="layui-btn download" id="download"><i class="layui-icon">&#xe601;</i>打印生成课表</button>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-normal" id="addClass"><i class="layui-icon">&#xe654;</i>添加课程</button>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-danger" id="delClass"><i class="layui-icon">&#xe640;</i><span>删除时间</span></button>
			</div>
			<!-- <div class="layui-inline">
				<button id="deleteId" class="layui-btn layui-btn-danger" ><i class="layui-icon">&#xe640;</i>批量删除</button>
			</div>	 -->
			<div style="clear: both"></div>
		</div>
		<div class="layui-form">
			<table class="layui-table" lay-skin="line" id="danceClass" lay-filter="tableContent"></table>
		</div>
		<input type="hidden" name="classIds" id="classIds">
		
		<%-- <div class="layui-tab layui-tab-brief" id="detailPanel" style="display: none;">
		  <ul class="layui-tab-title" id="tab_btn">
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/selUserMsg" class="layui-this">会员信息</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/selUserOrder">订单</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/selUserAccountJF">积分</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/selBalance">用户余额</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/interlocution">问答</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/attend">旁听</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/comment">评论</li>
		    <li data-taburl="/${applicationScope.adminprefix }/consumer/selReward">打赏</li>
		    <li style="float: right;font-weight:bold;font-size: 15px;" onclick="CloseIframe();">X</li>
		  </ul>
		  <iframe id="ifr_b" name="ifr_b" src="" frameborder="no" scrolling="no"
							width="100%" height="100%" allowtransparency="true"></iframe>
		</div>  --%>
		
	</div>
	<!-- 视频播放容器 -->
	<!-- <div id="a1"></div> -->
	
	<!-- 操作按钮 -->
	<!-- <script type="text/html" id="caozuo">
		<input type="hidden" name="userId" id="userId" value="{{ d.userId }}" />
		<input type="hidden" name="userType" id="userType" value="{{ d.userType }}" />
		<a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edits">查看</a>
		<a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="deletes">删除</a>
	</script> -->
	<script type="text/html" id="checkClass">
		<i class="layui-icon delIcon" name="tabDel" lay_value="{{d.Id}}" onclick="delInfo({{d.Id}});">&#x1006;</i>
	</script>
</m:Content>
<m:Content contentPlaceHolderId="js">
	<script type="text/javascript" src="/manage/public/js/ToolTip.js"></script>
	<!-- <script type="text/javascript" src="/manage/public/js/ckplayer/ckplayer.js"></script>
	<script type="text/javascript">
	    var flashvars={
	        f:'/upload/123.mp4',
	        c:0,
	        loaded:'loadedHandler'
	    };
	    var video=['/upload/123.mp4->video/mp4'];
	    CKobject.embed('/manage/public/js/ckplayer/ckplayer.swf','a1','ckplayer_a1','600','400',false,flashvars,video);
	</script> -->
	<script type="text/javascript">
		var userId = 0;
		var yhType = 0;
		var tableIns;
		//JavaScript代码区域
		layui.use(['laypage', 'layer', 'table', 'form', 'laydate'], function(){
			var table = layui.table;
			var laypage = layui.laypage;
			var layer = layui.layer;
			var form = layui.form;
			var laydate = layui.laydate;
			laydate.render({
				elem: '#registrationDate',
				range: true
			});
			//绑定表格
			tableIns = table.render({
				id: 'danceClass',
				elem: '#danceClass',
				url: '/${applicationScope.adminprefix }/danceClass/classData', //数据接口
				where: {},
				page: false, //开启分页
				limits: [10, 20, 30, 40, 50],
				cols: [
					[ //表头
						{
							title: '<i class="layui-icon delIcon" name="titleDel" onclick="delInfo(0);">&#x1006;</i>',
							width: "5%",
							templet:"#checkClass"
						},
					  	{
							field: 'danceTime',
							type: '',
							width: "12.4%",
							edit:'text'
						}, 
						{
							field: 'monday',
							title: '星期一',
							width: "12.4%",
							height:"50px",
							edit:'text'
						}, 
						{
							field: 'tuesday',
							title: '星期二',
							width: "12.4%",
							height:"50px",
							edit:'text'
						}, 
						{
							field: 'wednesday',
							title: '星期三',
							width: "12.4%",
							height:"50px",
							edit:'text'
						}, 
						{
							field: 'thursday',
							title: '星期四',
							width: "12.4%",
							height:"50px",
							edit:'text'
						}, 
						{
							field: 'friday',
							title: '星期五',
							width: "12.4%",
							height:"50px",
							edit:'text'
						},
						{
							field: 'saturday',
							title: '星期六',
							width: "12.4%",
							height:"50px",
							edit:'text'
						}, 
						{
							field: 'sunday',
							title: '星期日',
							width: "12.4%",
							height:"50px",
							edit:'text'
						},
					]
				],
				done: function(){
					 $(".layui-table-main .layui-table tr td").each(function(){
						 var tdName = $(this).attr("data-field");
						 if(tdName!="danceTime"){
							 var tdText = $(this).find("div").html();
							 if(tdText!=null && tdText!='' && tdText!=' ' && tdText.indexOf("<i")<0){
								 $(this).attr("style","background-color:#FF8080;color:#fff;");
							 }
						 }
					 })
					 
					 $("table").find("[data-field=0]").attr("style","display:none;");
					//行点击事件
					/* $('tbody').on('click',"td",function() {
						if($(this).index() > 9 || $(this).index() < 1){
							return ;
						}
						//获取当前行的id值
						var id = $(this).parents('tr').find('td:eq(10)').find('input[name="userId"]').val();
						//点击的用户类型
						var type = $(this).parents('tr').find('td:eq(10)').find('input[name="userType"]').val();
						if(id != null){
							$("#detailPanel").css("display", "block");
							userId=id;
							yhType=type;
							changepage();
						}
					}) */
				}
			});
			//导出excel
			$(".download").click(function(){
				layer.msg("小侯同学别着急啊,敬请期待！");
				/* var name=$('input[name="name"]').val(),
				isFreeze=$('select[name="isFreeze"]').val(),
				registrationDate=$("#registrationDate").val(),
				userType=$("select[name='userType']").val();
				//选中的id checkbox
				var checkStatus = table.checkStatus('consumer');
				var ids = '';
				$.each(checkStatus.data, function(i){
					ids = ids + checkStatus.data[i].userId + ',';
				}) */
			})
			
			//添加课程时间
			$("#addClass").click(function(){
				$.ajax({
					type:"POST",
					url:"/${applicationScope.adminprefix }/danceClass/addClassData",
					async:false,
					datatype:"json",
					success:function(data){
						if(data.result){
							layer.msg(data.msg,{icon:1});
							reload();
						}else{
							layer.msg(data.msg,{icon:2});
						}
					},
					error:function(data){
						layer.msg(data.msg,{icon:2});
					}
				})
			});
			
			//监听单元格编辑
			table.on('edit(tableContent)', function(obj){
			   var value = obj.value; //得到修改后的值
			   var data = obj.data; //得到所在行所有键值
			   var field = obj.field; //得到字段
			   var classId = data.Id;//该时间段课表id
			   $.ajax({
					type : "POST",
					url : "/${applicationScope.adminprefix }/danceClass/updClassData",
					async : false,
					data : {
						"classId" : classId,
						"updkey":field,
						"updvalue":value
					},
					success : function(data) {
						if(data.result){
							reload();
							layer.msg(data.msg,{icon: 1});
						}else{
							layer.msg(data.msg,{icon: 2});
						}
						
					},
					error : function(data) {
						layer.msg(data.msg,{icon: 2});
					}
				});
			   
			});
			
			//点击删除按钮，显示叉号
			$("#delClass").click(function(){
				var text = $(this).find("span").html();
				if(text=="删除时间"){
					$("table").find("[data-field=0]").attr("style","");
					$(this).find("span").html("取消删除");
				}else{
					$(this).find("span").html("删除时间");
					$("table").find("[data-field=0]").attr("style","display:none;");
				}
			})
			
			$("i[name='tabDel']").click(function(){
				layer.msg(123);
			})
			
			
			//监听复选框
			form.on('checkbox()', function(data){
				var checkName = data.elem.name;
				var titleCheck = $("input[name=titleCheck]");//标题行的复选框
				var allCheckSize = $("input[name=checkClass]").length;//不包括标题行的复选框总数
				var checkSize = $("input[name=checkClass]:checked").length;//选中的复选框数量
				
				if(checkName=='titleCheck'){//点击的是标题行的复选框时
					//点击标题行复选框时，修改表格复选框的样式
					if($("input[name=titleCheck]:checked")>0){
						$("input[name=checkClass]").each(function(){
							$(this).attr("checked","checked");
						})
					}
				}else{
					//全部选中时，修改标题行复选框的样式
					if(allCheckSize==checkSize){
						titleCheck.next("div").addClass("layui-form-checked");
					}else{
						titleCheck.next("div").removeClass("layui-form-checked");
					}
				}
				
				
				/* if((chekcLength>0 && chekcLength!=6) || firstCheck>0){
					$("#delClass").find("span").html("确认删除");
				}else if((chekcLength==6 &&　firstCheck==0) || chekcLength==0){
					$("#delClass").find("span").html("取消删除");
				} */
			});

			
			//搜索，重置表格
			$('.search').click(function() { 
				tableIns.reload({
					where: { //设定异步数据接口的额外参数，任意设
						name: $('input[name="name"]').val(),
						isFreeze: $('select[name="isFreeze"]').val(),
						registrationDate: $("#registrationDate").val(),
						userType:$("select[name='userType']").val(),
						num:Math.random()
					},
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			});
			//监听操作
			table.on('tool(tableContent)', function(obj){
				var data = obj.data; //获得当前行数据
				var userId = data.userId;
				var userType = data.userType;
				var layEvent = obj.event; //获得 lay-event 对应的值（区分点击的按钮）
				if(layEvent === 'edits'){ 
					//编辑
			  		updateUser(userId,userType);
			  	}else if(layEvent === 'deletes'){
			  		//删除
			  		deletes(userId);
			  	}
			});
			//批量删除
			$('#deleteId').click(function(){
				var checkStatus = table.checkStatus('danceClass');
				if(checkStatus.data.length == 0){
					layer.msg('请至少选择一项', {icon: 7});
					return false;
				}
				var ids = '';
				$.each(checkStatus.data, function(i){
					ids = ids + checkStatus.data[i].userId + ',';
				})
				layer.confirm('确定将所选全部删除吗？', function(index){
					deleteid(ids,layer, tableIns);
				})
			});
			//批量删除
			function deleteid(ids,layer, tableIns){
				$.ajax({
					type : "POST",
					url : "/${applicationScope.adminprefix }/consumer/deleteids",
					async : false,
					data : {
						"ids" : ids
					},
					success : function(data) {
						tableIns.reload({
							where: {
								num:Math.random()
							},
							page: {
								curr: 1 //重新从第 1 页开始
							}
						});
						layer.alert(data.msg,{icon: 1});
					},
					error : function(data) {
						layer.alert(data.msg,{icon: 2});
					}
				});
			}
			//删除
			function deletes(userId){
				layer.confirm('确定删除吗？', {icon: 7}, function(){
					$.ajax({
						type : "POST",
						url : "/${applicationScope.adminprefix }/consumer/deletes",
						data : {"userId" : userId},
						success : function(data) {
							tableIns.reload({
								where: { //设定异步数据接口的额外参数，任意设
									num:Math.random()
								},
								page: {
									curr: 1 //重新从第 1 页开始
								}
							});
							if(data.success){
								layer.alert(data.msg,{icon: 1});
							}else{
								layer.alert(data.msg,{icon: 2});
							}
						},
						error : function(data) {
							layer.alert(data.msg,{icon: 2});
						}
					});
				})
			}
			//刷新页面
			function reload(){
				tableIns.reload({
					where: {
						num:Math.random()
					}
					
				});
			}
			//页签切换
			/* $("#tab_btn > li[data-taburl]").on("click",function(){
				$("#tab_btn > li.layui-this").removeClass("layui-this");
				$(this).addClass("layui-this");
				changepage();
			}); */
			
			/* function changepage(){
				if(userId > 0){
					var url = $("#tab_btn > li.layui-this").data("taburl");
					$("#ifr_b").css("display","none");
					//loading(true);
					$("#ifr_b").attr("src",url+"?userId="+userId+"&userType="+yhType);
				}
			} */
			/* $("#ifr_b").load(function(){
				loading(false);
				$("#ifr_b").css("display","block");
				setFrameHeight();
			}); */
			/* function setFrameHeight(){
				var iframe = document.getElementById("ifr_b");
				var height = $("#tab_btn > li.select_tab").data("height");
				if(height){
					iframe.height=$(window).height();
					$("#ifr_b").contents().find("#maincontent").css("padding-bottom",iframe.height+"px");
					$("#ifr_b").contents().find(".target_menu,.sidebar").height(iframe.height);
					return;
				}
				
				try{
					iframe.height=0;
					var bHeight = iframe.contentWindow.document.body.scrollHeight;
					var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
					var height = Math.max(bHeight, dHeight);
					iframe.height = height+150;
					
				}catch (ex){}
			} */
		})
		function delInfo(classId){
			var text = "";
			if(classId=='' || classId==null){
				text="确定删除全部课程?";
			}else{
				var timeText = $("i[lay_value="+classId+"]").parent().parent().next().find("div").html();
				text="确定删除"+timeText+"的课程?";
			}
			layer.confirm(text, {icon: 7}, function(){
				$.ajax({
					type : "POST",
					url : "/${applicationScope.adminprefix }/danceClass/delClass",
					data : {"classId" : classId},
					success : function(data) {
						tableIns.reload({
							where: {
								num:Math.random()
							}
							
						});
						if(data.result){
							layer.msg(data.msg,{icon: 1});
						}else{
							layer.msg(data.msg,{icon: 2});
						}
					},
					error : function(data) {
						layer.msg(data.msg,{icon: 2});
					}
				});
			})
		}
	</script>
</m:Content>
</m:ContentPage>
