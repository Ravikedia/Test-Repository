.table {
 display:block;
}
.left-table, .left-table table {
	width:100%;
}
.left-table, .right-table {
	vertical-align: top;
}

.left-table table thead tr th, .left-table table tbody tr td {
	text-align:left;
}

/*##### the dragtable stuff #####*/
.dragtable-sortable { 
    list-style-type: none; margin: 0; padding: 0; -moz-user-select: none;
}
.dragtable-sortable li {
    margin: 0; padding: 0; float: left; font-size: 1em; background: white; 
}

.dragtable-sortable th, .dragtable-sortable td{
    border-left: 0px;
}

.dragtable-sortable li:first-child th, .dragtable-sortable li:first-child td {
    border-left: 1px solid #CCC; 
}

.ui-sortable-helper {
    opacity: 0.7;filter: alpha(opacity=70);
}
.ui-sortable-placeholder { 
    -moz-box-shadow: 4px 5px 4px #C6C6C6 inset;
    -webkit-box-shadow: 4px 5px 4px #C6C6C6 inset;
    box-shadow: 4px 5px 4px #C6C6C6 inset;
    border-bottom: 1px solid #CCCCCC;
    border-top: 1px solid #CCCCCC;
    visibility: visible !important;
    background: #EFEFEF !important; 
    visibility: visible !important;
}
.ui-sortable-placeholder * { 
    opacity: 0.0; visibility: hidden; 
}

.btn {
    display: inline-block  !important;
    margin-bottom: 0  !important;
    font-weight: normal  !important;
    text-align: center  !important;
    vertical-align: middle  !important;
    cursor: pointer  !important;
    background-image: none  !important;
    border: 1px solid transparent  !important;
    white-space: nowrap  !important;
    padding: 4px 8px !important;
    font-size: 14px !important;
    line-height: 1.42857143  !important;
    border-radius: 4px  !important;
    -webkit-user-select: none  !important;
    -moz-user-select: none  !important;
    -ms-user-select: none  !important;
    user-select: none  !important;
}

.btn-primary {
    background-image: -webkit-linear-gradient(top, #5e68c4 0, #4853B9 100%) !important;
    background-image: -o-linear-gradient(top, #5e68c4 0, #4853B9 100%)  !important;
    background-image: linear-gradient(to bottom, #5e68c4 0, #4853B9 100%) !important;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff5e68c4', endColorstr='#ff4853B9', GradientType=0) !important;
    filter: progid:DXImageTransform.Microsoft.gradient(enabled = false) !important;
    background-repeat: repeat-x !important;
    border-color: #5e68c4 !important;
    color:white !important;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2) !important;
}

.btn-primary:hover {
    background-color: #5771C4 !important;
    background-repeat: repeat-x !important;
}

.btn-default {
	color:black !important;
	box-shadow: 1px 1px 1px #555 !important;
	background-image: -webkit-linear-gradient(top, #FFFFFF 0, #E7E7E7 100%) !important;
    background-image: -o-linear-gradient(top, #FFFFFF 0, #E7E7E7 100%)  !important;
    background-image: linear-gradient(to bottom, #FFFFFF 0, #E7E7E7 100%) !important;
}

.btn-default:disabled {
	color:grey !important;
	box-shadow: 0px 0px 1px #555 !important;
	
}
.modal-header {
 	background-image: -webkit-linear-gradient(top, #5e68c4 0, #4853B9 100%) !important;
    background-image: -o-linear-gradient(top, #5e68c4 0, #4853B9 100%)  !important;
    background-image: linear-gradient(to bottom, #5e68c4 0, #4853B9 100%) !important;
    color:white;
    padding:12px;
}

.recordInfo {
float:right;
background:#5e68c4;
padding: 5px;
color: white;
border-radius: 3px;
}

.recordName {
	font-size:1.3em;
	color:#4853B9;
}

.report {
	font-weight:bold;
}