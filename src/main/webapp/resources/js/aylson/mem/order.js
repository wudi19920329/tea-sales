	/**
	 * 订单管理.js
	 */
	var datagrid;
	var editor;
	$(function() { 
		datagrid = $('#datagrid').datagrid({
			method:'post',
			url : '/admin/order?method=orders',
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'id',
			singleSelect:true,
			rownumbers: true,
			toolbar:[{
				text:"刷新",
				iconCls : 'icon-reload',
				handler : reload
			}],
			onBeforeLoad : function(param){
				 param["currentPage"] = param.page;
                 param["pageCount"] = param.rows;
                 delete param.rows;
                 delete param.page;
            },
 			frozenColumns : [[{
				field : 'id',
				title:'序号',
				align:'center',
				hidden:true,
				width : 50
			},{
				title : '订单编号',
				field : 'orderNumber',
				align:'center',
				sortable:true,
				width : 300
			}, {
				title : '客户昵称',
				field : 'customer',
				align:'center',
				formatter:function(value,row,index){
					return value.nickName;
				},
				width : 150
			}, {
				title : '支付金额',
				field : 'payableAmount',
				align:'center',
				sortable:true,
				formatter:function(value,row,index){
					return '￥'+value;
				},
				width : 100
			},{
				title : '订单状态',
				field : 'orderStatus',
				align:'center',
				formatter:function(value,row,index){
					return value.description;
				},
				width : 150
			},{
				title : '快递类型',
				field : 'expressDeliveryMode',
				align:'center',
				sortable:true,
				formatter:function(value,row,index){
					return value.description+"(价格：￥"+value.cost+")";
				},
				width : 250
			},{
				title : '订单描述',
				field : 'description',
				align:'center',
				sortable:true,
				width : 350
			},{
				title : '创建时间',
				field : 'createTime',
				align:'center',
				sortable:true,
				width : 250
			}, {field : 'opt',
				title:'操作选项',
				align:'center',
				width : 150,
				formatter:function(value,row,index){
					var handleHtml = "";
					if(row.orderStatus.name == 'WAIT_FOR_DELIVERY'){
						handleHtml += "<a href='javascript:void(0);' onclick='changeStatus("+row.id+")'>发货</a>&nbsp;";
					}
					handleHtml += "<a href='javascript:void(0);' onclick='view("+row.id+")'>查看</a>&nbsp;";
					return handleHtml;
				}
			}
			
			] ]
		});
		
	});			
	
	 
	//发货
	function changeStatus(orderId){
		var tip = "信息无误，确定发货吗？";
		$.messager.confirm("提示",tip,function(r){
			if(r){
				$.ajax({
					type:"POST",
					url: '/admin/order?method=deliver&orderId=' + orderId,
					dataType:"json",
					success:function(data){
	    				$.messager.show({"title":"系统提示","msg":"操作成功！","timeout":1000});
	    				$("#datagrid").datagrid("reload");
					}
				});
			}
		});
	}
	
	//查看
	function view(orderId){
		win = $("<div></div>").dialog({
			title:'查看',
			width:700,
			height:400,
			maximizable:true,
			modal:true,
			href:'/admin/order?method=queryProductsBy&adminIgnoreAjaxHeader=false&orderId='+orderId,
			onClose:function(){
		    	$(this).dialog("destroy");
		    },
			buttons:[{
						 text:'关闭',
					     iconCls:'icon-cancel',  
					 	 handler:function(){
					 		 win.dialog('destroy');
					 	 }   
					}]
		});
	}
	
	 
	
	//刷新
	function reload(){
		$("#datagrid").datagrid("reload");
	}
	
	
	//搜索
	function doSearch(method){
		$("#datagrid").datagrid("load",serializeObject($("#orderConfigSearchForm")));
	}
	
	
	//重置
	function reset(){
		$("#orderConfigSearchForm").form("reset");
	}
	
	