local args = ...
local g = args[1]

local song_dir = GAMESTATE:GetCurrentSong():GetSongDir()

local af = Def.ActorFrame{
	InitCommand=function(self)
		self:visible(false):diffusealpha(0)
			:xy(_screen.cx, _screen.h-50)
		g.Dialog.ActorFrame = self
	end,
	ShowCommand=function(self) self:visible(true):linear(0.333):diffusealpha(1) end,
	HideCommand=function(self)
		g.Dialog.Index = 1
		g.Dialog.BoxColor = nil
		g.DialogIsActive = false
		self:visible(false)
	end,


	Def.ActorFrame{
		InitCommand=function(self)
			self:zoom(0.25)
		end,

		LoadActor("./box.png"),

		LoadActor("./box_stroke.png")..{
			InitCommand=function(self)
				self:diffuse(color("#995544"))
			end,
			UpdateColorCommand=function(self, params)
				self:diffuse(params.Color)
			end
		},
	},

	-- the speaker's name
	Def.ActorFrame{
		Name="NameBoxAF",
		InitCommand=function(self)
			self:xy(-270, -46)
		end,
		ClearTextCommand=function(self)
			self:visible(false)
		end,
		UpdateTextCommand=function(self)
			self:visible( g.Dialog.Speaker and g.Dialog.Speaker ~= "" )
		end,

		-- name box stroke
		Def.Quad{
			Name="Stroke",
			InitCommand=function(self)
				self:zoomto(104,36):diffuse(0.15,0.15,0.15,1)
			end
		},
		-- name box
		Def.Quad{
			Name="Box",
			InitCommand=function(self)
				self:zoomto(100,32):diffuse(color("#995544"))
			end,
		},

		--name
		Def.BitmapText{
			File=song_dir.."Fonts/helvetica neue/_helvetica neue 40px.ini",
			Text=g.Dialog.Speaker,
			InitCommand=function(self) self:zoom(0.55):y(-6) end
		}
	},



	Def.BitmapText{
		File=song_dir.."Fonts/helvetica neue/_helvetica neue 40px.ini",

		InitCommand=function(self) self:zoom(0.5):cropright(1) end,
		OnCommand=function(self)
			self:align(0,0):xy( WideScale(-_screen.cx+40 , -_screen.w/3), -24)
				:diffuse(Color.Black)
				:wrapwidthpixels((_screen.w * WideScale(_screen.w-80,0.65))/self:GetZoom())
		end,

		ClearTextCommand=function(self)
			self:settext(""):cropright(1)
		end,
		UpdateTextCommand=function(self, params)
			g.Dialog.IsTweening = true

			-- if type(SRT.Dialog.Words[SRT.Dialog.Index].text) == "string" then
			-- 	text = SRT.Dialog.Words[SRT.Dialog.Index].text
			-- elseif type(SRT.Dialog.Words[SRT.Dialog.Index].text) == "function" then
			-- 	text = SRT.Dialog.Words[SRT.Dialog.Index].text()
			-- end

			if params.text then
				self:settext( params.text ):linear(0.75):cropright(0):queuecommand("FinishUpdateText")
			else
				self:queuecommand("ClearText")
			end
		end,
		FinishUpdateTextCommand=function(self) g.Dialog.IsTweening = false end
	}
}

---------------------------------------------------------------------------------------------
-- Cursor

-- af[#af+1] = Def.ActorFrame{
-- 	InitCommand=function(self)
-- 		SRT.Dialog.Cursor = self
-- 		self:visible(false):y(12)
-- 	end,
--
-- 	ClearTextCommand=function(self)
-- 		self:visible(false)
-- 	end,
-- 	UpdateTextCommand=function(self)
-- 		self:diffusealpha(0)
--
-- 		if SRT.Dialog.Words[SRT.Dialog.Index].choices then
-- 			SRT.Dialog.ChoiceIndex = 1
-- 			self:queuecommand("UpdateCursor")
-- 			self:visible(true):sleep(1):linear(0.2):diffusealpha(1)
-- 		end
-- 	end,
--
-- 	Def.Quad{
-- 		InitCommand=function(self)
-- 			self:diffuse(color("#8563c6")):xy(-_screen.w/3, 2):halign(0)
-- 		end,
-- 		UpdateCursorCommand=function(self)
-- 			if SRT.Dialog.Words[SRT.Dialog.Index].choices then
--
-- 				local char_width = 11
--
-- 				self:zoomto( choiceBMT[SRT.Dialog.ChoiceIndex]:GetText():len() * char_width - 4, 18 )
-- 					:x( choiceBMT[SRT.Dialog.ChoiceIndex]:GetX()-4 )
-- 			end
-- 		end
-- 	},
-- }

---------------------------------------------------------------------------------------------
-- Choice BitmapTexts

-- for i=1,3 do
-- 	af[#af+1] = Def.BitmapText{
-- 		Font="Common normal",
-- 		InitCommand=function(self)
-- 			choiceBMT[i] = self
-- 			self:zoom(0.7)
-- 		end,
-- 		OnCommand=function(self)
-- 			self:halign(0):xy(((_screen.w/4)*i)-_screen.w/1.75, 14):diffuse(Color.Black)
-- 		end,
-- 		ClearTextCommand=function(self)
-- 			self:settext(""):diffusealpha(0)
-- 		end,
-- 		UpdateTextCommand=function(self)
-- 			if SRT.Dialog.Words[SRT.Dialog.Index].choices and SRT.Dialog.Words[SRT.Dialog.Index].choices[i] then
-- 				self:settext( SRT.Dialog.Words[SRT.Dialog.Index].choices[i] ):sleep(1):linear(0.75):diffusealpha(1)
-- 			end
-- 		end
-- 	}
-- end

return af