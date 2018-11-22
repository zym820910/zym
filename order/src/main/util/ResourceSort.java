
package util;

import itaf.framework.system.model.TsResource;

import java.util.Comparator;

/********************************************************************** 
 * <pre>
 * FILE	          : ResourceSort.java			
 * CLASS          : solution.jxt.action.admin.ResourceSort.CLASS
 *			
 * AUTHOR         : peter					
 *									
 * FUNCTION       :	menu Sort
 * 									
 *                							
 *======================================================================
 * CHANGE HISTORY LOG                                             	
 *----------------------------------------------------------------------
 * MOD. NO.|  DATE    | NAME           | REASON		   | CHANGE REQ.
 *----------------------------------------------------------------------
 *         |2010-6-24   | peter	       | Created       |                
 * DESCRIPTION: menu sort                                            	
 * </pre>
 ***********************************************************************/
/**
 Copyright 2010 XceSys Co.,Ltd.

 You may not use this file except in compliance with the legal License
 of XceSys Co., Ltd.
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
public class ResourceSort implements Comparator<TsResource> {

	public final static int UP = 1; 

	public final static int DOWM = -1; 

	private int state; 

	public ResourceSort(int state) { 
	this.state = state; 
	} 

	public ResourceSort() { 

	} 

	public int compare(TsResource o1, TsResource o2) { 
		if (state == ResourceSort.DOWM) { 
			return sortDown(o1, o2); 
		} 
		return sortUp(o1, o2); 
	} 

	private int sortUp(TsResource o1, TsResource o2) { 
		if (o1.getSeqNum().compareTo(o2.getSeqNum()) < 0) { 
			return -1; 
		} else if (o1.getSeqNum().compareTo(o2.getSeqNum()) > 0) { 
			return 1; 
		} else { 
			return 0; 
		} 
	} 

	private int sortDown(TsResource o1, TsResource o2) { 
		if (o1.getSeqNum().compareTo(o2.getSeqNum()) > 0) { 
			return -1; 
		} else if (o1.getSeqNum().compareTo(o2.getSeqNum()) < 0) { 
			return 1; 
		} else { 
			return 0; 
		} 
	}
}
