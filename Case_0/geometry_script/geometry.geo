//+
SetFactory("OpenCASCADE");
//+
lc = $lccc; //tamano de malla
rd = $rdd; // radio del ducto
l1 = $l11; // largo del ducto lado 1
a = $aa; // espesor de la placa
rp = $rpp; // radio del poro
//+
Point(1) = {0, 0, 0, lc};
//+
Point(2) = {rd, 0, 0, lc};
//+
Point(3) = {0, rd, 0, lc};
//+
Point(4) = {-rd, 0, 0, lc};
//+
Point(5) = {0, -rd, 0, lc};
//+
Circle(1) = {5, 1, 2};
//+
Circle(2) = {2, 1, 3};
//+
Circle(3) = {3, 1, 4};
//+
Circle(4) = {4, 1, 5};
//+
Curve Loop(1) = {4, 1, 2, 3};
//+
Plane Surface(1) = {1};
//+
Extrude {0, 0, l1} {
  Surface{1}; 
}
Point(10) = {0, 0, l1+a, lc};
//+
Point(11) = {rd, 0, l1+a, lc};
//+
Point(12) = {0, rd, l1+a, lc};
//+
Point(13) = {-rd, 0, l1+a, lc};
//+
Point(14) = {0, -rd, l1+a, lc};
//+
Circle(13) = {14, 10, 11};
//+
Circle(14) = {11, 10, 12};
//+
Circle(15) = {12, 10, 13};
//+
Circle(16) = {13, 10, 14};
//+
Curve Loop(16) = {16, 13, 14, 15};
//+
Plane Surface(7) = {16};
//+
Extrude {0, 0, l1-a} {
  Surface{7}; 
}
