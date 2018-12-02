return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "2018.11.14",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 20,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 12,
  nextobjectid = 6,
  properties = {},
  tilesets = {
    {
      name = "autumn 16x32",
      firstgid = 1,
      filename = "autumn 16x32.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "autumn 16x32.png",
      imagewidth = 1024,
      imageheight = 2048,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      terrains = {},
      tilecount = 512,
      tiles = {}
    },
    {
      name = "Event-Tileset",
      firstgid = 513,
      filename = "event-tileset.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 2,
      image = "event-tileset (doubleres).png",
      imagewidth = 128,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      terrains = {},
      tilecount = 2,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Ground",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487,
        502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      id = 6,
      name = "Texture",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "Water",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 1280,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["Texture"] = "map_data/WaterTexture.png",
            ["alpha"] = 0.33300000000000002,
            ["vx"] = -0.033300000000000003,
            ["vy"] = 0
          }
        }
      }
    },
    {
      type = "tilelayer",
      id = 2,
      name = "Under",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205,
        221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221,
        363, 364, 365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 362, 363, 364, 365, 366,
        379, 380, 381, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 378, 379, 380, 381, 382,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 401, 338, 339, 0, 338, 339, 385, 0, 0, 0, 0, 0, 0, 0,
        349, 350, 143, 0, 0, 340, 0, 0, 0, 0, 0, 0, 0, 337, 0, 0, 0, 0, 0, 347,
        365, 366, 159, 0, 0, 337, 0, 0, 101, 214, 103, 0, 0, 340, 0, 0, 0, 153, 0, 363,
        381, 382, 0, 0, 0, 0, 323, 0, 0, 0, 0, 0, 325, 0, 0, 0, 0, 0, 0, 379,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 347,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 363,
        348, 349, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 379,
        364, 365, 366, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        380, 381, 382, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 347,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 153, 0, 363,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 379,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 4,
      name = "Under 2",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 143, 0, 0, 362, 363, 364, 365, 366, 0, 0, 137, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 379, 380, 381, 174, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      id = 5,
      name = "Player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 2,
          name = "Player",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 1024,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      id = 3,
      name = "Over",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        315, 316, 317, 318, 319, 0, 329, 330, 331, 332, 333, 334, 335, 0, 313, 314, 315, 316, 317, 318,
        331, 332, 333, 334, 335, 0, 345, 346, 347, 348, 349, 350, 351, 0, 329, 330, 331, 332, 333, 334,
        347, 348, 349, 350, 351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 345, 346, 347, 348, 349, 350,
        269, 270, 271, 158, 159, 0, 0, 4, 5, 6, 7, 8, 0, 0, 153, 154, 0, 57, 0, 0,
        285, 286, 287, 0, 0, 0, 0, 20, 21, 22, 23, 24, 0, 0, 0, 0, 0, 281, 282, 283,
        301, 302, 303, 0, 0, 0, 0, 36, 37, 38, 39, 40, 0, 0, 0, 0, 0, 297, 298, 299,
        317, 318, 319, 0, 0, 0, 0, 52, 53, 54, 55, 56, 0, 0, 0, 0, 0, 313, 314, 315,
        333, 334, 335, 0, 0, 0, 0, 68, 69, 70, 71, 72, 0, 0, 0, 0, 0, 329, 330, 331,
        349, 350, 351, 0, 0, 0, 0, 0, 85, 86, 87, 0, 0, 0, 0, 0, 0, 345, 282, 283,
        268, 269, 270, 271, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 297, 298, 299,
        284, 285, 286, 287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 313, 314, 315,
        300, 301, 302, 303, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 329, 330, 331,
        316, 317, 318, 319, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 345, 346, 347,
        332, 333, 334, 335, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 281, 282, 283,
        348, 349, 350, 351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 297, 298, 299,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 313, 314, 315,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 329, 330, 331,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 345, 346, 347,
        0, 0, 265, 266, 0, 0, 0, 265, 266, 0, 0, 0, 265, 266, 0, 0, 281, 282, 283, 284,
        0, 0, 281, 282, 0, 0, 0, 281, 282, 0, 0, 0, 281, 282, 0, 0, 297, 298, 299, 300
      }
    },
    {
      type = "tilelayer",
      id = 11,
      name = "Over 2",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 266, 267,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 265, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 266, 267,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 281, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 265, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 266, 267,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 266, 267, 268,
        268, 269, 270, 271, 267, 268, 269, 270, 271, 267, 268, 269, 270, 271, 267, 268, 269, 270, 271, 0,
        284, 285, 286, 287, 283, 284, 285, 286, 287, 283, 284, 285, 286, 287, 283, 284, 285, 286, 287, 0
      }
    },
    {
      type = "tilelayer",
      id = 8,
      name = "Collision",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 0.48,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513,
        513, 513, 513, 0, 0, 0, 0, 0, 513, 513, 513, 0, 0, 0, 0, 0, 513, 513, 513, 513,
        513, 513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513, 513, 513, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 513, 513, 513, 513, 513, 513, 513, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 513, 0, 0, 0, 0, 0, 0, 0, 513, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 513, 0, 0, 513, 513, 513, 0, 0, 513, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 513, 0, 0, 0, 0, 0, 513, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513,
        513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513
      }
    },
    {
      type = "objectgroup",
      id = 9,
      name = "Events",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "Transfer to 2",
          type = "Touch",
          shape = "rectangle",
          x = 0,
          y = 1152,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "Winter2",
            ["TransferTileDown"] = 17,
            ["TransferTileRight"] = 39
          }
        },
        {
          id = 4,
          name = "Transfer to 2",
          type = "Touch",
          shape = "rectangle",
          x = 0,
          y = 1088,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "Winter2",
            ["TransferTileDown"] = 17,
            ["TransferTileRight"] = 39
          }
        }
      }
    }
  }
}
