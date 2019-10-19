<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>显示学生信息</title>
	<style type="text/css">
	*{margin: 0px; padding: 0px;}
	</style>
  <link rel="stylesheet" href="css/bootstrap-table.css" type="text/css"></link>
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css"></link>
  <script type="text/javascript" src="js/jquery-1.12.4.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" href="css/bootstrap-select.css" type="text/css"></link>
  <script type="text/javascript" src="js/bootstrap-select.js"></script>
  </head>
  
  <body>
     <div class="panel-body" style="padding-bottom:0px;">
        <div class="panel panel-default">
            <div class="panel-heading">查询条件</div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal">
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="txt_search_departmentname">姓名:</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="txtName">
                        </div>
                        <label class="control-label col-sm-1" for="txt_search_statu">成绩:</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="txtScore">
                        </div>
                        <div class="col-sm-4" style="text-align:left;">
                            <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>       

        <div id="toolbar" class="btn-group">
            <%--<button id="btn_add" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            --%>
            <button id="btn_delete" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
        </div>
        <table id="tb_departments"></table>
        
        <form id="form1" class="form-horizontal" style="border:1px solid #ccc;">
        <div class="container">
            <div class="row" style="padding: 20px 0">
                <h3>学生信息</h3>
            </div>
            <div class="row form-group ">
                <label class="control-label col-md-1" for="name">姓名</label>
                <div class="col-md-6">
                	<input class="form-control" id="id" name="id" type="hidden"/>
                    <input class="form-control" id="name" name="name"/>
                </div>
            </div>
            <div class="row form-group">
                <label class="control-label col-md-1" for="male">性别</label>
                <div class="col-md-6">
                    <input type="radio" name="sex" value="true" id="male" checked="checked"/>男
                    <input type="radio" name="sex" value="true" id="female" style="margin-left: 50px;"/>女
                </div>
            </div>
            <div class="row form-group">
                <label class="control-label col-md-1" for="birthday">生日</label>
                <div class="col-md-6">
                    <input class="form-control" type="date" name="birthday" id="birthday"/>
                </div>
            </div>
            <div class="row form-group">
                <label class="control-label col-md-1" for="grade">年级</label>
                <div class="col-md-6">
                <%--这里的name也可以写为grade.id，只是改了之后，StudentMapper.xml里面新增和修改的方法也要跟着改--%>
                <select name="gradeId" class="bs-select form-control" id="grade">
                    </select>
                </div>
            </div>
            <div class="row form-group">
                <label class="control-label col-md-1" for="score">成绩</label>
                <div class="col-md-6">
                    <input class="form-control" name="score" id="score"/>
                </div>
            </div>
            <div class="row form-group">
                <label class="control-label col-md-1"></label>
                <!--form-control会设置宽度为100%,两个按钮会换行。这里将父容器的类样式设置为form-inline，即可使之在一行显示 -->
                <div class="col-md-2 form-inline">
                    <input class="form-control btn-success" type="button" id="btnSave" value="新增"/>
                    <input class="form-control btn-info" type="reset" value="清空"/>
                </div>
            </div>
        </div>
    	</form>
	</div>
    
    <script type="text/javascript">
    $(function () {
        //1.初始化Table
        var oTable = new TableInit();
        oTable.Init();
        //2.初始化Button的点击事件
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();
    });

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $('#tb_departments').bootstrapTable({
                url: 'stu/selectStus.do',         //请求后台的URL（*）
                /*
            	请求方式为get的时候，查询时文本框的汉字会是乱码
            	将请求方式改为post后，必须要设置contentType，否则参数的值不能传递到Controller
            	*/
                method: 'post',                      //请求方式（*）
                contentType:"application/x-www-form-urlencoded",
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: false,                    //是否启用排序
                sortOrder: "asc",                   //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber:1,                       //初始化加载第一页，默认第一页
                pageSize: 6,                        //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                strictSearch: true,					//设为true，开启精确搜索
                showColumns: true,                  //是否显示所有的列
                showRefresh: true,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                  //是否显示父子表
                rowStyle:function(row,index){		//奇偶行变色,有5个取值颜色['active', 'success', 'info', 'warning', 'danger']
                	return {classes:index%2==0?"success":"danger"};
                },
                columns: [{
                    checkbox: true
                }, {
                    field: 'id',
                    title: '编号'
                }, {
                    field: 'name',
                    title: '姓名'
                }, {
                    field: 'sex',
                    title: '性别',
                    formatter:sexFormatter
                }, {
                    field: 'birthday',
                    title: '生日'
                },{
                    field: 'grade.name',
                    title: '年级'
                },{
                    field: 'score',
                    title: '成绩'
                },{
                	field:'id',
                	title:'操作',
                	width:120,
                	align:'center',
                	valign:'middle',
                	formatter:actionFormatter
                }],
                queryParams:function (params) {
                    var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                            limit: params.limit,   //页面大小
                            offset: params.offset,  //页码
                            name: $("#txtName").val(),
                            score: $("#txtScore").val()
                    };
                    return temp;
                },
                onDblClickRow: function (row, $element) {
                	//行的双击事件。row是选中行，row.id可以获取选中行的id
                    alert(row.id);
                },
            });
        };

        return oTableInit;
    };
    
    //"性别"的处理
    function sexFormatter(value){
    	return value?"男":"女 ";
    }
    //"操作"列的显示
    function actionFormatter(value, row, index) {
        var id = value;
        var result = "";
        result += "<a href='javascript:;' class='btn btn-xs green'  title='查看'><span class='glyphicon glyphicon-search'></span></a>";
        //js的onclick事件中，参数无法传递一个对象，必须要将对象转为json来传递
        result += "<a href='javascript:;' class='btn btn-xs blue' onclick=\"edit(" +JSON.stringify(row).replace(/"/g,"&quot;") + ")\" title='编辑'><span class='glyphicon glyphicon-pencil'></span></a>";
        result += "<a href='javascript:;' class='btn btn-xs red' onclick=\"deleteByIds('" + id + "')\" title='删除'><span class='glyphicon glyphicon-remove'></span></a>";

        return result;
    }

    //查询：姓名是模糊查询，成绩是>=
    $("#btn_query").click(function(){
    	$('#tb_departments').bootstrapTable('refresh');
    })

    var ButtonInit = function () {
        var oInit = new Object();
        var postdata = {};

        oInit.Init = function () {
          //初始化页面上面的按钮事件
          $('#btn_add').click(function(){
            alert("新增~");
          });
        
          //批量删除任务按钮点击事件
          $('#btn_delete').click(function(){
              var arr = $('#tb_departments').bootstrapTable('getSelections');
              if(arr.length>0){
                for(var a in arr){
                	alert(arr[a].id);
                }
              }else{
                alert("请选择一条数据");
              }
          });
        };

        return oInit;
    };
    
    //删除
    function deleteByIds(id){
    	if(confirm('是否删除?')){
	    	$.ajax({
	    		url:"stu/del.do",
	    		data:{"id":id},
	    		dataType:"json",
	    		success:function(data){
	    			if(data){
	    				$('#tb_departments').bootstrapTable('refresh');
	    				alert('删除成功！');
	    			}else{
	    				alert('删除失败！');
	    			}
	    		}
	    	})
    	}
    }
    
    //修改
	function edit(row){
		$("#id").val(row.id);
    	$("#name").val(row.name);
    	if(row.sex){
    		$("#male").attr("checked","checked");
    	}else{
    		$("#female").attr("checked","checked");
    	}
    	$("#birthday").val(row.birthday);
    	$("#grade option[value="+row.grade.id+"]").attr("selected","selected");
    	$("#score").val(row.score);
    	$("#btnSave").val("修改");
    }
    
    /*
    BootStrap本身的Selectpicker没有提供json数据的绑定，
           所以这里处理的时候grade没有写成这样：
    <select id="grade" class="selectpicker" data-live-search="true" multiple></select>
    */
    (function ($) {
       //自定义的jquery扩展方法：bootstrapSelect
       $.fn.bootstrapSelect = function (options, param) {
        	var target = $(this);
        	$.ajax({
        		url:options.url,
	    		dataType:"json",
	    		success:function(data){
	    			$.each(data,function(i,d){
	    				var option = $('<option></option>');
	                    option.attr('value', d[options.valueField]);
	                    option.text(d[options.textField]);
	                    target.append(option);
	    			})
	    		}
        	})
        }
    })(jQuery);
    
    //年级下拉列表
    $("#grade").bootstrapSelect({
        url:"grade/list.do",
        valueField: 'id',
        textField: 'name'
    });
    
    //新增和修改
    $("#btnSave").click(function(){
    	$.ajax({
    		url:"stu/save.do",
    		//以前的方式是{"id":$("#id").val(),"name":$("#name").val()}一个个传值
    		//这里使用的是form序列化
    		data:$("#form1").serialize(),
    		type:"post",
    		success:function(data){
    			if(data){
    				$('#tb_departments').bootstrapTable('refresh');
    				$('#form1')[0].reset();
    				alert($("#btnSave").val()+'成功！');
    			}else{
    				alert($("#btnSave").val()+'失败！');
    			}
    		}
    	})
    })
    </script>
  </body>
</html>

















