extends Node2D


var time:float = 0.0;
var start_point: Vector2 = Vector2(10,500);

func _ready():
	#drawCollisionShape(100, Vector2(500, 250))
	var circles =  get_tree().get_nodes_in_group("circle")
	print(circles)
	$Line2D.width = 4
	#$Line2D.add_point(start_point)
	#$Line2D.add_point(Vector2(500,250))
	print($Line2D.get_point_position(0))

func _process(delta):
	time += 0.1;
	if($Line2D.get_point_count() > 0):
		var closestCircle = get_closest_circle_position($Line2D.get_point_position(0))
		$Line2D.set_point_position(1, closestCircle.position)
		$Line2D.set_point_position(0, get_global_mouse_position())
		$MeshInstance2D.position = $Line2D.get_point_position(0)
		var closestCircleRadius = closestCircle.get_child(0).shape.radius
		var distance = closestCircle.position.distance_to(get_global_mouse_position()) - closestCircleRadius
		$MeshInstance2D.mesh.radius = distance
		$MeshInstance2D.mesh.height = distance * 2
		
		
func get_closest_circle_position(target: Vector2):
		#var closest: Vector2;
		var circles =  get_tree().get_nodes_in_group("circle")
		var closestCircle = circles[0]
		var closest: Vector2 = circles[0].position
		for x in circles:
			if target.distance_to(x.position) <= target.distance_to(closest):
				closest = x.position;
				closestCircle = x;
		return closestCircle;

func drawCollisionShape(radius: float, position: Vector2):
	var shape = CollisionShape2D.new()
	var circleShape = CircleShape2D.new();
	circleShape.set_radius(radius)
	shape.set_position(position)
	shape.shape = circleShape;
	get_tree().current_scene.add_child(shape)
	
func generate_circle_polygon(radius: float, num_sides: int, position: Vector2):
	var angle_delta: float = (PI * 2) / num_sides
	var vector: Vector2 = Vector2(radius, 0)
	var polygon: PackedVector2Array

	for _i in num_sides:
		polygon.append(vector + position)
		vector = vector.rotated(angle_delta)

	return polygon

#func _draw():
	#var godot_blue : Color = Color("478cbf")
	#draw_polygon(generate_circle_polygon(100, 100, Vector2(500, 250)),[godot_blue] )

