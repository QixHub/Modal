local Modal = (script.Parent.Parent.Parent);

local Fusion = require(Modal.Packages.Fusion);
local Storage = require(Modal.Storage.Information);
local Scoper = require(Modal.Utilities.Scoper);
local Scope = Storage.Scope
local Children = Fusion.Children
type Configuration = {
	Title: string,
	Description: string,
}
local Holder = function(Settings: Configuration, Window)
	local Title = Scope:Value(Settings.Title or "");
	local Description = Scope:Value(Settings.Description or "");

	local Component = Scope:New "Frame" {
		Name = "Paragraph",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -15, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),

		[Children] = {
			Scope:New "UIListLayout" {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 3),
			},

			Scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
			},

			Scope:New "TextLabel" {
				Name = "Title",
				LayoutOrder = 0,
				FontFace = Font.new(
					"rbxassetid://12187365364",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				),
				TextColor3 = Window.Themes.Text.Title.Color,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0, 0),
				TextSize = 13,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				AutomaticSize = Enum.AutomaticSize.Y,

				Text = Scope:Computed(function(Use)
					return Use(Title);
				end),

				Visible = Scope:Computed(function(Use)
					return Use(Title) ~= "";
				end),
			},

			Scope:New "TextLabel" {
				Name = "Description",
				LayoutOrder = 1,
				FontFace = Font.new(
					"rbxassetid://12187365364",
					Enum.FontWeight.Medium,
					Enum.FontStyle.Normal
				),
				TextColor3 = Window.Themes.Text.Description.Color,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0, 0),
				TextSize = 12,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				AutomaticSize = Enum.AutomaticSize.Y,

				Text = Scope:Computed(function(Use)
					return Use(Description);
				end),

				Visible = Scope:Computed(function(Use)
					return Use(Description) ~= "";
				end),
			},
		}
	}

	local Configuration = ({ Object = Component });

	Configuration.Set = function(self, NewTitle: string, NewDescription: string)
		if NewTitle ~= nil then Title:set(NewTitle) end
		if NewDescription ~= nil then Description:set(NewDescription) end
	end

	Configuration.SetTitle = function(self, NewTitle: string)
		Title:set(NewTitle);
	end

	Configuration.SetDescription = function(self, NewDescription: string)
		Description:set(NewDescription);
	end

	return Configuration
end

return Holder
