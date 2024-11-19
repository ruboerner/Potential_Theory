//+
SetFactory("OpenCASCADE");
//+
Circle(1) = {0, 0, 0, 0.5, 0, 2*Pi};
//+
Circle(2) = {0, 0, 0, 0.1, 0, 2*Pi};

// BooleanDifference(3) = { Surface{1}; Delete; }{ Surface{2}; Delete; };
Mesh.Algorithm = 6;
Mesh.MeshSizeMin = 0.01;
Mesh.MeshSizeMax = 0.05;

//+
Curve Loop(1) = {1};
//+
Curve Loop(2) = {2};
//+
Plane Surface(1) = {1, 2};
//+
Physical Curve("inner", 3) = {2};
//+
Physical Curve("outer", 4) = {1};
//+
Physical Surface("domain", 5) = {1};
