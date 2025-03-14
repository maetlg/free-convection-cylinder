// ============= PARAMETERS ============= //
// ====================================== //
// Geometry
d = 0.2;
h = 0.2*d;				// Distance top of cylinder to top wall
H = 1*d;				// Distance bottom of cylinder to bottom wall
W = 8*d;				// Width in terms of hydraulic diameters 
L = 10*d;				// Lenght of cylinder
wout = 0.5*d;           // Width of outer field region

// Number of nodes
Nr      = 15;              // Number of radial nodes 
NcylTop = 110;             // Number of nodes on top 1/4 of cylinder circumference
NcylBot = 15;              // Number of nodes on bottom 1/4 of cylinder circumference
NcylSid = 35;              // Number of nodes on both sides of cylinder
NxOut   = 95;              // Number of horizontal nodes in far field
NyTop   = 45;              // Number of vertical nodes on top of cylinder
NyBot   = 25;              // Number of vertical nodes in far field
NL      = 10*L/h;          // Number of axial (extruded) elements
NxFOut  = 7;

// Progression parameters
progR       = 1.05;
progYTop    = 0.98;
progYBot    = 1.1;
progXOut    = 1.03; // bumpXOut    = 0.13;
progCylSide = 1.06;
cylTopBump  = 1.0;
cylBotBump  = 1.0;
progXFOut   = 1.;


// Coordinates for refinement regions
r      = d/2;
ybox   = 0.8*r;         // height of refinement box
wbox   = ybox;          // Half width of refinement box
rbez   = 1.4*r;			// Distance for Bezier control point
facBez = 1.;            // Factor for sides and bottom control points 
yout   = ybox;	            // y position of outside points
xbez   = r/3;           // Parameters for bezier points between cylinder and top wall 
ybez   = 0.5*h+r;   



// ================ GEOMETRY ================= //
// =========================================== //
// POINTS AND LINES
// Cylinder
Point(1) = {0,0,0};
Point(2) = {r*Sin(Pi/4),r*Cos(Pi/4),0};
Point(3) = {r*Sin(3*Pi/4),r*Cos(3*Pi/4),0};
Point(4) = {r*Sin(-3*Pi/4),r*Cos(-3*Pi/4),0};
Point(5) = {r*Sin(-Pi/4),r*Cos(-Pi/4),0};

Circle(1) = {2,1,3};
Circle(2) = {3,1,4};
Circle(3) = {5,1,4};
Circle(4) = {5,1,2};


// Inside box
Point(6) = {wbox,ybox,0};
Point(7) = {wbox,-ybox,0};
Point(8) = {-wbox,-ybox,0};
Point(9) = {-wbox,ybox,0};

// Bezier control points for top region
Point(98) = {-xbez,ybez,0};
Point(99) = {xbez,ybez,0};

Line(5)  = {2,6};
Line(6)  = {3,7};
Line(7)  = {4,8};
Line(8)  = {5,9};
Bezier(9)  = {9,98,99,6};
Circle(10) = {6,1,7};
Circle(11) = {7,1,8};
Circle(12) = {9,1,8};

// Far Field
Point(22) = {-W/2,h+r,0};
Point(23) = {-wbox,h+r,0};
Point(24) = {wbox,h+r,0};
Point(25) = {W/2,h+r,0};


Point(10) = {W/2,yout,0};
Point(11) = {W/2,-ybox,0};
Point(12) = {W/2,-H-r,0};
Point(13) = {wbox,-H-r,0};
Point(14) = {-wbox,-H-r,0};
Point(15) = {-W/2,-H-r,0};
Point(16) = {-W/2,-ybox,0};
Point(17) = {-W/2,yout,0};


Line(13) = {6,10};
Line(14) = {10,11};
Line(15) = {11,12};
Line(16) = {13,12};
Line(17) = {14,13};
Line(18) = {14,15};
Line(19) = {16,15};
Line(20) = {17,16};
Line(21) = {9,17};
Line(22) = {8,16};
Line(23) = {7,11};
Line(24) = {7,13};
Line(25) = {8,14};

Line(26) = {17,22};
Line(27) = {23,22};
Line(28) = {23,24};
Line(29) = {24,25};
Line(30) = {10,25};
Line(31) = {9,23};
Line(32) = {6,24};

// Outer field
Point(26) = {W/2+wout,h+r,0};
Point(27) = {W/2+wout,yout,0};
Point(28) = {W/2+wout,-ybox,0};
Point(29) = {W/2+wout,-H-r,0};
Point(30) = {-W/2-wout,-H-r,0};
Point(31) = {-W/2-wout,-ybox,0};
Point(32) = {-W/2-wout,yout,0};
Point(33) = {-W/2-wout,h+r,0};

Line(33) = {25,26};
Line(34) = {27,26};
Line(35) = {27,28};
Line(36) = {28,29};
Line(37) = {12,29};
Line(38) = {15,30};
Line(39) = {31,30};
Line(40) = {32,31};
Line(41) = {32,33};
Line(42) = {22,33};
Line(43) = {10,27};
Line(44) = {11,28};
Line(45) = {16,31};
Line(46) = {17,32};


// SURFACES
// Inner box
Line Loop(1) = {-4,8,9,-5};
Line Loop(2) = {-1,5,10,-6};
Line Loop(3) = {-2,6,11,-7};
Line Loop(4) = {3,7,-12,-8};

// Far Field
Line Loop(5) = {-22,25,18,-19};
Line Loop(6) = {-20,-21,12,22};
Line Loop(7) = {26,-27,-31,21};
Line Loop(8) = {28,-32,-9,31};
Line Loop(9) = {29,-30,-13,32};
Line Loop(10) = {-10,13,14,-23};
Line Loop(11) = {23,15,-16,-24};
Line Loop(12) = {-17,-25,-11,24};

// Outer field
Line Loop(13) = {30,33,-34,-43};
Line Loop(14) = {-14,43,35,-44};
Line Loop(15) = {44,36,-37,-15};
Line Loop(16) = {19,38,-39,-45};
Line Loop(17) = {45,-40,-46,20};
Line Loop(18) = {46,41,-42,-26};

ns = 18;
For i In {1:ns}
	Plane Surface(i) = {i};
EndFor


// MESH
Transfinite Line {5,6,7,8} = Nr Using Progression progR;
Transfinite Line {4,9,28} = NcylTop Using Bump cylTopBump;
Transfinite Line {2,11,17} = NcylBot Using Bump cylBotBump;
Transfinite Line {1,3,10,12,14,20,35,40} = NcylSid Using Progression progCylSide;
Transfinite Line {13,16,18,23,29,22,21,27} = NxOut Using Progression progXOut; //Bump bumpXOut; //
Transfinite Line {26,30,31,32,34,41} = NyTop Using Progression progYTop;
Transfinite Line {15,19,24,25,36,39} = NyBot Using Progression progYBot;
Transfinite Line {33,43,44,37,38,45,46,42} = NxFOut Using Progression progXFOut;
Transfinite Surface {1:ns};
Recombine Surface {1:ns};


// Volume
Extrude{0,0,L} { Surface{1:ns}; Layers{NL}; Recombine;} 


// ======== PHYSICAL SURFACES =========== //
// ====================================== //
Physical Surface("frontAndBack")  = {1:ns,398,442,420,156,178,200,310,112,134,90,68,222,244,266,288,376,354,332};			
Physical Surface("cylinder") = {77,99,55,121};		
Physical Surface("sides") = {393,411,433,327,349,367};
Physical Surface("topWall") = {191,209,231};				
Physical Surface("bottom") = {151,389,297,283,371};				
Physical Surface("topOut") = {323,437};
Physical Volume("internal") = {1:ns};



