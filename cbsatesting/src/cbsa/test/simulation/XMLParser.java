package cbsa.test.simulation;

import java.io.File;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


public class XMLParser {
	enum CellType
	{
		Page,
		Button,
		edge
	};
	public class mxEdge
	{
		public String id;
		public String Source;
		public String Target;		
	}

	public class mxCell
	{
		String Name;
		String id;
		CellType type;
		List<mxCell> ChildCells;
		mxCell Parent;
		
		public mxCell(String aName, String aId, CellType aType )
		{
			this.Name = aName;
			this.id = aId;
			this.type = aType;			
			this.ChildCells = new ArrayList<mxCell>();
			Parent = null;
		}
		
		public void addChild(mxCell child)
		{
			this.ChildCells.add(child);			
		}
		public void SetParent(mxCell aParent)
		{
			this.Parent = aParent;
		}
		public void print()
		{
			System.out.println("Node name = " + this.Name);
			System.out.println(this.Name + "has " + this.ChildCells.size() + " child node(s)" );
			System.out.println();
			
			if(this.ChildCells.size()>0)
			{
				for(int i =0; i<ChildCells.size(); i ++) 
				{	
					System.out.println(this.Name+ "'s child #" + i);
					ChildCells.get(i).print();	
				}
			}
		}
	}
	
	public static mxCell FindCellByID(List<mxCell> listCells, String id)
	{
		if(listCells != null) 
		{
			for(int i=0; i<listCells.size(); i++)
			{
				if(listCells.get(i).id.equals(id))
					return listCells.get(i);
			}
		}
		return null;
	}
	
	
	public List<mxCell> ParseXML(String XMLFile)
	{
		List<mxCell> retAllParents = null;
		try
		{
			  //not sure why we need this.
			//XMLParser domTestingObject = new XMLParser();
			  //but this is to hide some weird syntax of java... 
			  //may be if i move all mxedge, mxcell out of this file, then i might not need it.
			  //se the usage of this object below.
	
			File fXmlFile = new File(XMLFile);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
	
			//System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
			NodeList nList = doc.getElementsByTagName("mxCell");
			//System.out.println("-----------------------");
	
			List<mxCell> vertexList = new ArrayList<mxCell>();
			List<mxEdge> edgeList = new ArrayList<mxEdge>();
			for (int temp = 0; temp < nList.getLength(); temp++) 
			{
				//This is the node (mxCell) from xml
				Node nNode = nList.item(temp);
	
				//These are all attributes of this cell.
				NamedNodeMap attrs =  nNode.getAttributes();
	
				//based on presence of certain attributes, we can decide which kind of node is this.
				//button, page, edge
				//button and page both are called vertex only. their style determines their real type.
	
				//ID is must, if xml node doesn't have id, we can't do much
				Node nodeId = attrs.getNamedItem("id");
				String id = nodeId.getNodeValue();
				if(id == null || id.isEmpty())
				{
					//since this doens't have ID lets skip it.
					continue;
				}
	
				//now with ID, there are bunch of other attrs, lets try to get them.
				Node nodeVertex = attrs.getNamedItem("vertex");
				Node nodeEdge = attrs.getNamedItem("edge");
				
	
				if(nodeVertex != null  )
				{
					String vertex = nodeVertex.getNodeValue();
					if(vertex !=null && vertex.equals("1"))
					{
						Node nodeName = attrs.getNamedItem("value");
						String name = nodeName.getNodeValue();
	
						//Since this is a vertex, it has to have a name
						if(name == null || name.isEmpty())
						{
							//since this doens't have name lets skip it.
							continue;
						}
						//this is a good vertex
						Node nodeStyle = attrs.getNamedItem("style");
						
						if(nodeStyle != null)
						{
							String style = nodeStyle.getNodeValue();
							
							if(style != null && style.equals("rounded=1"))
							{
								//this is page
								mxCell newPage = new mxCell(name, id, CellType.Page);
								vertexList.add(newPage);
								//System.out.println("(style:rounded=1) creating a page = "+ newPage.id + " with name " + newPage.Name );
								continue;
							}
						}
						
						//Execution comes at this point due to many reasons.
						//1. nodestyle is null, i.e. there is no style attribute 
						//2. style is null
						//3. sytle is empty
						//4. style is somehting else then "rounded=1"
	
						//as of now we do not know what style is defined for button
						//so we would consider all the non-empty style as button.
						//FIX ME
						mxCell newButton = new mxCell(name, id, CellType.Button);
						vertexList.add(newButton);
						//System.out.println("(there is no style) creating a button = "+ newButton.id + " with name " + newButton.Name );
						continue;
					}
				}
				else if(nodeEdge != null )
				{
					String edge = nodeEdge.getNodeValue();
					if(edge!= null && edge.equals("1"))
					{
						Node edgeSource = attrs.getNamedItem("source");
						String source = edgeSource.getNodeValue();
	
						Node edgeTarget = attrs.getNamedItem("target");
						String target = edgeTarget.getNodeValue();
						
						if(source==null || source.isEmpty() || target ==null || target.isEmpty())
						{
							//this is a bad edge
							//ignore it.
							continue;
						}				
	
						mxEdge mEdge = new mxEdge();
						mEdge.id = id;
						mEdge.Source= source;
						mEdge.Target= target;
	
						edgeList.add(mEdge);
						
						//System.out.println("creating an edge with id = "+ mEdge.id + " from source =" + mEdge.Source + " to target = " + mEdge.Target );
					}
				}
				else
				{
					//something else.
					continue;
				}
	
				//for(int j =0; j<attrs.getLength(); j++)
				//{
				//	System.out.println("attr : name " + attrs.item(j).getNodeName() + " value = " + attrs.item(j).getNodeValue() );
				//}
			}
			
			//with above for loop, now we have following two list full.
			//lets join edges with vertex.
			//List<mxCell> vertexList
			//List<mxEdge> edgeList		
			for(int e=0; e<edgeList.size(); e++)
			{
				mxEdge edge = edgeList.get(e);
				mxCell source = FindCellByID(vertexList, edge.Source);
				mxCell target = FindCellByID(vertexList, edge.Target); 
				if(source == null || target==null)
				{
					//this is a problem, we can;t have a edge with bad source and target
					//
					continue;
				}
				source.addChild(target);
				target.SetParent(source);
			}
			
			//now all the edge is set.. so lets find out vertex with null parent
			//that means that vertex is the root of all.
			//we could have more then one root, so lets keep all of them in a list.
			retAllParents = new ArrayList<mxCell>();
			for(int v=0; v<vertexList.size(); v++)
			{
				if(vertexList.get(v).Parent == null)
				{
					retAllParents.add(vertexList.get(v));
					
					//lets print it as well.
					//System.out.println("print all roots");
					//vertexList.get(v).print();
				}		
			}
			
			//at this point, retAllParents contains the list of all root "tests".
			
		}
		catch(Exception e)
		{
			if(retAllParents!=null) retAllParents.clear();
			e.printStackTrace();
		}
		
		return retAllParents;
		
	}
	
	private static String getTagValue(String sTag, Element eElement) 
	{

		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
	 
	        Node nValue = (Node) nlList.item(0);
	 
		return nValue.getNodeValue();
    }


}
