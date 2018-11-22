package action.main;

import itaf.framework.common.AppContext;
import itaf.framework.common.UserInfo;
import itaf.framework.constant.ResourceConstant;
import itaf.framework.system.model.TsResource;
import itaf.framework.system.service.ResourceService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;





import util.ResourceSort;

import com.svw.framework.web.action.BaseAction;
import com.svw.framework.web.util.RequestUtil;

public class MenuAction  extends BaseAction{

	
	private static final long serialVersionUID = 6646464585482627531L;

	private String outputTreeStr = "";
	private String contextStr;
	private boolean showChinese = true;

	@Autowired
	private ResourceService resourceService;

	
	/**
     * 灞曠ず涓婚〉
     * @return
     */
    @Action(value="desktop",results={@Result(name="success", location="desktop.jsp")})
    public String desktop() {
		return SUCCESS;
	}
	/**
     * 灞曠ず涓婚〉
     * @return
     */
    @Action(value="index",results={@Result(name="success", location="index.jsp")})
    public String index() {
		return SUCCESS;
	}
    
    /**
     * 灞曠ず宸﹁竟鑿滃崟
     * @return
     */
    @Action(value="left",results={@Result(name="success", location="left.jsp")})
    public String left() {
		return SUCCESS;
	}
    
    /**
     * 灞曠ず椤堕儴
     * @return
     */
    @Action(value="top",results={@Result(name="success", location="top.jsp")})
    public String top() {
		return SUCCESS;
	}
    
    /**
     * 灞曠ず搴曢儴鐗堟潈淇℃伅椤甸潰
     * @return
     */
    @Action(value="end",results={@Result(name="success", location="end.jsp")})
    public String end() {
		return SUCCESS;
	}
    /**
     * 灞曠ずMainFrame
     * @return
     */
    @Action(value="blank",results={@Result(name="success", location="blank.jsp")})
    public String blank() {
    	return SUCCESS;
    }
    
    @Action(value="main",results={@Result(name="success", location="main.jsp")})
    public String main() {
    	return SUCCESS;
    }

    
	public String list() {
		outputTreeStr = "";
		// 1. 获取当前用户身份，获取当前Locale信息
		UserInfo userInfo = AppContext.getUserInfo();
		if (userInfo == null || userInfo.getId() == null)
			return CANCEL;

		// 选择显示中文或英文菜单
		showChinese = true;

		Collection<TsResource> web_cat_list = null;
		Collection<TsResource> web_url_list = null;

		// 需要整理菜单类型
		web_cat_list = resourceService.doFindByType(ResourceConstant.JXTMENU_CATEGORY);
		web_url_list = resourceService.doFindByUserIdAndType(userInfo.getId(), ResourceConstant.JXTMENU_CATEGORY_ITEM);

		HashMap<Long, TsResource> wholeTree = new HashMap<Long, TsResource>();
		HashMap<Long, TsResource> subTree = new HashMap<Long, TsResource>();

		ArrayList<TsResource> web_top_list = new ArrayList<TsResource>();

		// 先组织目录菜单
		for (TsResource sysResource : web_cat_list) {
			wholeTree.put(sysResource.getId(), sysResource);
		}

		// 再组织叶节点菜单
		for (TsResource sysResource : web_url_list) {
			// 没有地址指向的节点菜单就不显示
			if (sysResource.getPath() != null) {
				subTree.put(sysResource.getId(), sysResource);
			}
		}

		Set<Entry<Long, TsResource>> set_entry = subTree.entrySet();
		Iterator<Entry<Long, TsResource>> iterate_entry = set_entry.iterator();
		while (iterate_entry.hasNext()) {
			Entry<Long, TsResource> entry = iterate_entry.next();
			TsResource resource = entry.getValue();
			updateWithParents(resource, web_top_list, wholeTree);
		}

		contextStr = RequestUtil.getRequest().getContextPath();
		Collections.sort(web_top_list, new ResourceSort(ResourceSort.UP));

		// 生成输出文件字符串，以后要改成jstl-el的控制方式
		for (TsResource resource : web_top_list) {
			outputTreeStr = outputTreeStr + "<li class=\"expandable\"><div class=\"hitarea expandable-hitarea\"></div><strong>";

			if (null == resource.getPath() || resource.getPath().equals("")) {
				if (showChinese)
					outputTreeStr = outputTreeStr + resource.getNameZh() + "</strong><ul style=\"display: none;\">";
				else
					outputTreeStr = outputTreeStr + resource.getNameEn() + "</strong><ul style=\"display: none;\">";
			} else {
				outputTreeStr = outputTreeStr + "<a href=\"" + contextStr + resource.getPath() + "\" target=\"mainFrame\">";
				if (showChinese)
					outputTreeStr = outputTreeStr + resource.getNameZh() + "</a></strong><ul style=\"display: none;\">";
				else
					outputTreeStr = outputTreeStr + resource.getNameEn() + "</a></strong><ul style=\"display: none;\">";
			}
			processChildResource(resource);
			outputTreeStr = outputTreeStr + "</ul></li>";
		}
		return SUCCESS;
	}

	private void updateWithParents(TsResource resource,
			ArrayList<TsResource> list, HashMap<Long, TsResource> wholeTree) {
		TsResource parent = wholeTree.get(resource.getParentResourceId());
		// 可能存在多个根目录
		if (parent == null) {
			if (!list.contains(resource)) {
				list.add(resource);
			}
		} else {
			List<TsResource> parentChilds = parent.getSortedChildResources();
			if (parentChilds == null) {
				parentChilds = new ArrayList<TsResource>();
				parent.setSortedChildResources(parentChilds);
			}
			if (!parentChilds.contains(resource)) {
				parentChilds.add(resource);
			}
			updateWithParents(parent, list, wholeTree);
		}
	}

	private void processChildResource(TsResource resource) {
		List<TsResource> child_list = resource.getSortedChildResources();
		if (null != child_list) {
			Collections.sort(child_list, new ResourceSort(ResourceSort.UP));
			for (int i = 0; i < child_list.size(); i++) {
				TsResource child_resource = child_list.get(i);
				// 判断是否有子节点
				if (child_resource.getSortedChildResources() != null
						&& child_resource.getSortedChildResources().size() > 0) {
					outputTreeStr = outputTreeStr 	+ "<li class=\"expandable\"><div class=\"hitarea expandable-hitarea\"></div><strong>";

					if (null == child_resource.getPath()
							|| child_resource.getPath().equals("")) {
						if (showChinese)
							outputTreeStr = outputTreeStr + child_resource.getNameZh() + "</strong><ul style=\"display: none;\">";
						else
							outputTreeStr = outputTreeStr + child_resource.getNameEn() + "</strong><ul style=\"display: none;\">";
					} else {
						outputTreeStr = outputTreeStr + "<a href=\"" + contextStr + child_resource.getPath() + "\" target=\"mainFrame\">";
						if (showChinese)
							outputTreeStr = outputTreeStr + child_resource.getNameZh() + "</a></strong><ul style=\"display: none;\">";
						else
							outputTreeStr = outputTreeStr + child_resource.getNameEn() + "</a></strong><ul style=\"display: none;\">";
					}
					processChildResource(child_resource);
					outputTreeStr = outputTreeStr + "</ul></li>";

				} else {
					String li_tag = "<li>";
					if (i == (child_list.size() - 1))
						li_tag = "<li class=\"last\">";
					if (null == child_resource.getPath() || child_resource.getPath().equals("")) {
						if (showChinese)
							outputTreeStr = outputTreeStr + li_tag + child_resource.getNameZh() + "</li>";
						else
							outputTreeStr = outputTreeStr + li_tag + child_resource.getNameEn() + "</li>";
					} else {
						outputTreeStr = outputTreeStr + li_tag + "<a href=\"" + contextStr + child_resource.getPath() + "\" target=\"mainFrame\">";
						if (showChinese)
							outputTreeStr = outputTreeStr + child_resource.getNameZh() + "</a></li>";
						else
							outputTreeStr = outputTreeStr + child_resource.getNameEn() + "</a></li>";
					}
				}
			}
		}
	}

	public String getOutputTreeStr() {
		return outputTreeStr;
	}

	public void setOutputTreeStr(String outputTreeStr) {
		this.outputTreeStr = outputTreeStr;
	}

	public String getContextStr() {
		return contextStr;
	}

	public void setContextStr(String contextStr) {
		this.contextStr = contextStr;
	}

	public boolean isShowChinese() {
		return showChinese;
	}

	public void setShowChinese(boolean showChinese) {
		this.showChinese = showChinese;
	}
}
