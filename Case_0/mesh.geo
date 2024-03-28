SetFactory("OpenCASCADE");
v() = ShapeFromFile("./geometry_script/geometry.step");
BooleanFragments{ Volume{v()}; Delete; }{}
//+
lc = $lccc;
rd = $rdd;
l1 = $l11;
a = $aa;
//+
Mesh.MeshSizeMax = lc;
//+
Field[1] = Box;

Field[1].VIn = 0.001;

Field[1].XMin = -rd;

Field[1].XMax = rd;

Field[1].YMin = -rd;

Field[1].YMax = rd;

Field[1].ZMin = l1-a;

Field[1].ZMax = l1+a+a;

Background Field = 1;
//+
