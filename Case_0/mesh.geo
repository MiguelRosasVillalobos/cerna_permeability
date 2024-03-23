SetFactory("OpenCASCADE");
v() = ShapeFromFile("./geometry_script/geometry.step");
BooleanFragments{ Volume{v()}; Delete; }{}
//+
lc = 0.01;
rd = 0.05;
l1 = 0.2;
a = 0.005;
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
