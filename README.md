isometry-prototype
===

I'll be using this project to get a better grasp of the 2D isometric projection.

To do:
===
- [x] implement a simple 2d grid
- [x] display grid in normal carthesian coordinate system
- [ ] display grid in isometric projection
- [ ] detect touch location
- [ ] convert touch locations from screen space to isometric & vice versa


Done:
===

implement a simple 2d grid
---

I used a simple non-square 2D integer array, each value representing a tile identifier

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
    
display grid in normal carthesian coordinate system
---
![](http://i.imgur.com/qjFMv4r.png)
