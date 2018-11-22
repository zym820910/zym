<%@ include file="/common/taglibs.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Menu</title>
<link rel="stylesheet" type="text/css" media="all" href="../css/jquery.treeview.css" />
<link rel="stylesheet" type="text/css" href="../css/main.css">
<script type="text/javascript"	src="../js/jquery.cookie.js"></script>	
<script type="text/javascript"	src="../js/jquery.treeview.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#tree").treeview(
					{
				expanded : true,
				collapsed: false,
				animated: 250,
				control:"#sidetreecontrol",
				prerendered: true,
				persist: "location",
				collapse: true,
				fileico: true,
				folderico: true
			});
			$('#tcon').height($(document).height()-65);
			$('#tcon').css('overflow-y','auto');
		});
	</script>
</head>
<body bgcolor="d9effd">
  <div class="lefttop"></div>
<div id="sidetree">
  <div id="sidetreecontrol">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; <a href="?#"><s:text name="tree.collapseAll"/></a> | <a href="?#"><s:text name="tree.expandAll"/></a> </div>
  <br/>
  <div id='tcon'>
  <ul class="treeview" id="tree">
	${outputTreeStr}
<!--	<li class="last"><strong><a href="<c:url value='/main/blank.action'/>" target="mainFrame"><s:text name="navigate.homePage"/></a></strong></li>-->
  </ul>
  </div>
</div>
</body>
