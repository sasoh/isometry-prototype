isometry-prototype
==================

I'll be using this project to get a better grasp of the 2D isometric projection.

To do:
[x] implement a simple 2d grid

	const int mapColumns    = 10;
	const int mapRows       = 8;
	const int map[mapRows][mapColumns] = {
 	   1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 	   1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
 	   1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
 	   1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 	   1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 	   1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
  	  1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
  	  1, 1, 1, 1, 0, 0, 1, 1, 1, 1,
	};
	const CGFloat tileSize = 30.0;

[x] display grid in normal carthesian coordinate system
[ ] display grid in isometric projection
[ ] detect touch location
[ ] convert touch locations from screen space to isometric & vice versa