return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "2018.11.14",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 29,
  height = 13,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 70,
  nextobjectid = 32,
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
      id = 62,
      name = "Ground / Water",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488,
        471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472,
        470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471, 472, 470, 471,
        486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487, 488, 486, 487,
        502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503, 504, 502, 503,
        438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439, 440, 438, 439,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      id = 12,
      name = "Texture",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 4,
          name = "Water",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 1856,
          height = 384,
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
      id = 63,
      name = "Bridge / TreeBottoms / House / Wheat (under)",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205, 205,
        221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221, 221,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 47, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 64,
      name = "Ground Decorations (under)",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 9,
          name = "Player",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 448,
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
      id = 65,
      name = "Over",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 31, 32, 0, 0, 0, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268, 269, 270,
        286, 287, 281, 282, 283, 284, 285, 286, 287, 0, 0, 0, 0, 0, 0, 0, 281, 282, 283, 284, 285, 286, 287, 281, 282, 283, 284, 285, 286,
        302, 303, 297, 298, 299, 300, 301, 302, 303, 0, 0, 0, 0, 0, 0, 0, 297, 298, 299, 300, 301, 302, 303, 297, 298, 299, 300, 301, 302,
        318, 319, 313, 314, 315, 316, 317, 318, 319, 0, 0, 0, 0, 0, 0, 0, 313, 314, 315, 316, 317, 318, 319, 313, 314, 315, 316, 317, 318,
        334, 335, 329, 330, 331, 332, 333, 334, 335, 0, 0, 0, 0, 0, 0, 0, 329, 330, 331, 332, 333, 334, 335, 329, 330, 331, 332, 333, 334,
        350, 351, 345, 346, 347, 348, 349, 350, 351, 0, 0, 0, 0, 0, 0, 0, 345, 346, 347, 348, 349, 350, 351, 345, 346, 347, 348, 349, 350
      }
    },
    {
      type = "tilelayer",
      id = 66,
      name = "Over 2",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        268, 269, 270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268,
        284, 285, 286, 287, 281, 282, 283, 284, 285, 286, 287, 281, 282, 283, 284, 285, 286, 287, 281, 282, 283, 284, 285, 286, 287, 281, 282, 283, 284,
        300, 301, 302, 303, 297, 298, 299, 300, 301, 302, 303, 297, 298, 299, 300, 301, 302, 303, 297, 298, 299, 300, 301, 302, 303, 297, 298, 299, 300,
        316, 317, 318, 319, 313, 314, 315, 316, 317, 318, 319, 313, 314, 315, 316, 317, 318, 319, 313, 314, 315, 316, 317, 318, 319, 313, 314, 315, 316
      }
    },
    {
      type = "tilelayer",
      id = 67,
      name = "Over 3",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268, 269, 270, 271, 265, 266, 267, 268, 269, 270
      }
    },
    {
      type = "tilelayer",
      id = 69,
      name = "Collision",
      x = 0,
      y = 0,
      width = 29,
      height = 13,
      visible = true,
      opacity = 0.48,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        513, 513, 513, 513, 513, 513, 513, 513, 0, 0, 0, 0, 0, 0, 0, 0, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513,
        513, 513, 513, 513, 513, 513, 513, 513, 513, 0, 0, 0, 0, 0, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513,
        513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513,
        513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513, 513
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
          id = 8,
          name = "Transfer to 2",
          type = "Touch",
          shape = "rectangle",
          x = 1792,
          y = 384,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "2",
            ["TransferTileDown"] = 6,
            ["TransferTileRight"] = 0
          }
        },
        {
          id = 18,
          name = "Transfer to 2",
          type = "Touch",
          shape = "rectangle",
          x = 1792,
          y = 448,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "2",
            ["TransferTileDown"] = 7,
            ["TransferTileRight"] = 0
          }
        },
        {
          id = 19,
          name = "Transfer to 2",
          type = "Touch",
          shape = "rectangle",
          x = 1792,
          y = 512,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "2",
            ["TransferTileDown"] = 8,
            ["TransferTileRight"] = 0
          }
        },
        {
          id = 25,
          name = "Transfer to 4",
          type = "Touch",
          shape = "rectangle",
          x = 0,
          y = 512,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "4",
            ["TransferTileDown"] = 8,
            ["TransferTileRight"] = 28
          }
        },
        {
          id = 24,
          name = "Transfer to 4",
          type = "Touch",
          shape = "rectangle",
          x = 0,
          y = 448,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "4",
            ["TransferTileDown"] = 7,
            ["TransferTileRight"] = 28
          }
        },
        {
          id = 22,
          name = "Transfer to 4",
          type = "Touch",
          shape = "rectangle",
          x = 0,
          y = 384,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["TransferPlayer"] = "4",
            ["TransferTileDown"] = 6,
            ["TransferTileRight"] = 28
          }
        },
        {
          id = 23,
          name = "Dead Tree",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 512,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["img"] = "worried",
            ["text"] = "Curiously set apart from the others, this tree looks so alone.",
            ["text2"] = "It seems the winter has not been kind to it."
          }
        },
        {
          id = 26,
          name = "Been Here Before",
          type = "Touch",
          shape = "rectangle",
          x = 1472,
          y = 384,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["img"] = "worried",
            ["text"] = "I can't shake the ominous feeling that I've been here before..."
          }
        },
        {
          id = 29,
          name = "Been Here Before",
          type = "Touch",
          shape = "rectangle",
          x = 1472,
          y = 448,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["img"] = "worried",
            ["text"] = "I can't shake the ominous feeling that I've been here before..."
          }
        },
        {
          id = 30,
          name = "Been Here Before",
          type = "Touch",
          shape = "rectangle",
          x = 1472,
          y = 512,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["img"] = "worried",
            ["text"] = "I can't shake the ominous feeling that I've been here before..."
          }
        },
        {
          id = 31,
          name = "Dead Tree",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 512,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["img"] = "worried",
            ["text"] = "Curiously set apart from the others, this tree looks so alone.",
            ["text2"] = "It seems the winter has not been kind to it."
          }
        }
      }
    }
  }
}
