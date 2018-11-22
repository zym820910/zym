function func_insert()
{
for (i=0; i<select2.options.length; i++)
{
  if(select2.options(i).selected)
  {
    option_text=select2.options(i).text;
    option_value=select2.options(i).value;
    option_style_color=select2.options(i).style.color;
    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;
    my_option.style.color=option_style_color;
    pos=select2.options.length;
    select1.add(my_option,pos);
    select2.remove(i);
    i--;
}
}//for
}
function func_delete()
{
for (i=0;i<select1.options.length;i++)
{
  if(select1.options(i).selected)
  {
    option_text=select1.options(i).text;
    option_value=select1.options(i).value;
    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;
    pos=select2.options.length;
    select2.add(my_option,pos);
    select1.remove(i);
    i--;
}
}//for
}
function func_select_all1()
{
for (i=select1.options.length-1; i>=0; i--)
  select1.options(i).selected=true;
}
function func_select_all2()
{
for (i=select2.options.length-1; i>=0; i--)
  select2.options(i).selected=true;
}
function func_up()
{
sel_count=0;
for (i=select1.options.length-1; i>=0; i--)
{
    if(select1.options(i).selected)
      sel_count++;
}
if(sel_count==0)
{
    alert("调整菜单快捷组的项目顺序时，请选择其中一项！");
    return;
}
else if(sel_count>1)
{
    alert("调整菜单快捷组的项目顺序时，只能选择其中一项！");
    return;
}
i=select1.selectedIndex;
if(i!=0)
{
    var my_option = document.createElement("OPTION");
    my_option.text=select1.options(i).text;
    my_option.value=select1.options(i).value;
    select1.add(my_option,i-1);
    select1.remove(i+1);
    select1.options(i-1).selected=true;
}
}
function func_down()
{
sel_count=0;
for (i=select1.options.length-1; i>=0; i--)
{
    if(select1.options(i).selected)
      sel_count++;
}
if(sel_count==0)
{
    alert("调整菜单快捷组的项目顺序时，请选择其中一项！");
    return;
}
else if(sel_count>1)
{
    alert("调整菜单快捷组的项目顺序时，只能选择其中一项！");
    return;
}
i=select1.selectedIndex;
if(i!=select1.options.length-1)
{
    var my_option = document.createElement("OPTION");
    my_option.text=select1.options(i).text;
    my_option.value=select1.options(i).value;
    select1.add(my_option,i+2);
    select1.remove(i);
    select1.options(i+1).selected=true;
}
}
function mysubmit()
{
  fld_str="";
  for (i=0; i< select1.options.length; i++)
  {
      options_value=select1.options(i).value;
      fld_str+=options_value+",";
    }
  location="submit.php?FLD_STR=" + fld_str;
}