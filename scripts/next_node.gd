extends Node2D

class_name NextNode

var Next: Array[String]

# Get a node given its index
func indexToNode(i):
	return get_parent().get_node("AIMovNode" + Next[i])

# Return a random next node
func getRandomNext(exclude: NextNode):
	var excludeName = ""
	if exclude != null:
		excludeName = exclude.name.right(name.length() - 9)
	
	if Next.size() == 1:
		return indexToNode(0)
	
	var indexArray = []
	for i in range(0, Next.size()):
		if Next[i] != excludeName:
			indexArray.push_back(i)
	return indexToNode(indexArray.pick_random())

func _ready():
	var me = name.right(name.length() - 9)
	Next = (get_parent() as NodeManager).get_my_nodes(me)
