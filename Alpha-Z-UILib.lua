local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()

local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

local library = {}
local tabs = {}
local sections ={}

local tabamount = 0
local buttonamount = 0
local slideramount = 0
local toggleamount = 0
local textboxamount = 0
local keybindamount = 0
local colouramount = 0
local dropdownamount = 0
local sectionamount = 0
local notificationamount = 0

-- urvoge & sten were here

function new(classname, class, properties, children)
	local instance = Instance.new(class)

	for index, value in pairs(properties or {}) do
		instance[index] = value
	end

	for index, child in pairs(children or {}) do
		child.Parent = instance
	end

	return instance
end

function library:Drag(target)
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		target:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),'Out','Sine',0.075,true)
	end

	target.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = target.Position

			repeat wait() until input.UserInputState == Enum.UserInputState.End
			dragging = false
		end
	end)
	target.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function library:Resize(btn, target, minX, minY)
	local resizeStart = {}
	local down = false

	btn.MouseButton1Down:Connect(function()
		resizeStart.X = btn.AbsoluteSize.X - (mouse.X - btn.AbsolutePosition.X)
		resizeStart.Y = btn.AbsoluteSize.Y - (mouse.Y - btn.AbsolutePosition.Y)
		down = true
	end)

	uis.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			down = false
		end
	end)

	function clamp(x, min, max)
		return x < min and min or x > max and max or x
	end

	mouse.Move:Connect(function()
		if down then
			local X_main = clamp((mouse.X - target.AbsolutePosition.X) + resizeStart.X, minX, minX + 500)
			local Y_main = clamp((mouse.Y - target.AbsolutePosition.Y) + resizeStart.Y, minY, minY + 500)

			target.Size = UDim2.new(0, X_main, 0, Y_main)
		end
	end)
end

function library:CreateUI(name)
	local uilib = new("","ScreenGui", {
		Name = name,
		Parent = player.PlayerGui
	},{
		new("Main","Frame", {
			Name = "Main",
			BackgroundColor3 = Color3.fromRGB(36, 41, 49),
			Position = UDim2.new(0.4, 0, 0.35, 0),
			Size = UDim2.new(0, 317, 0, 64),
			BorderSizePixel = 0,
			ZIndex = 1
		},{
			new("Shadow","ImageLabel", {
				Name = "Shadow",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ImageColor3 = Color3.fromRGB(15, 15, 15),
				SliceCenter = Rect.new(20, 20, 280, 280),
				Position = UDim2.new(0, -15, 0, -15),
				Image = "rbxassetid://4996891970",
				ScaleType = Enum.ScaleType.Slice,
				Size = UDim2.new(1, 30, 1, 30),
				BackgroundTransparency = 1,
				ImageTransparency = 0.35,
				BorderSizePixel = 0,
				ZIndex = 0
			}),
			new("Resize","TextButton", {
				Name = "Resize",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.new(1, 0, 1, 0),
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.new(0, 10, 0, 10),
				Font = Enum.Font.SourceSans,
				BackgroundTransparency = 1,
				TextSize = 14,
				Text = ""
			}),
			new("Section","Frame", {
				Name = "Section",
				BackgroundColor3 = Color3.fromRGB(42, 47, 58),
				Position = UDim2.new(0.5, 0, 0, 52),
				AnchorPoint = Vector2.new(0.5, 0),
				Size = UDim2.new(1, -8, 1, -56),
				BorderSizePixel = 0,
				ZIndex = 2
			}),
			new("Bar","Frame", {
				Name = "Bar",
				BackgroundColor3 = Color3.fromRGB(51, 57, 70),
				Size = UDim2.new(1, 0, 0, 30),
				BorderSizePixel = 0,
				ZIndex = 2
			}, {
				new("Tabs","Frame", {
					Name = "Tabs",
					BackgroundColor3 = Color3.fromRGB(58, 66, 79),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 18),
					BorderSizePixel = 0,
					ZIndex = 2
				}, {
					new("tabHolder","ScrollingFrame", {
						Name = "tabHolder",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						CanvasSize = UDim2.new(0, 0, 0, 16),
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						ScrollBarThickness = 0,
						BorderSizePixel = 0,
						ZIndex = 3
					}, {
						new("tabList","UIListLayout", {
							Name = "tabList",
							HorizontalAlignment = Enum.HorizontalAlignment.Left,
							FillDirection = Enum.FillDirection.Horizontal,
							SortOrder = Enum.SortOrder.LayoutOrder
						})
					})
				}),
				new("Title","TextLabel", {
					Name = "Title",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(0, 66, 1, 0),
					Font = Enum.Font.GothamBold,
					BackgroundTransparency = 1,
					Text = string.upper(name),
					TextSize = 14,
					ZIndex = 3
				}, {
					new("textShadow","TextLabel", {
						Name = "textShadow",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextXAlignment = Enum.TextXAlignment.Left,
						Position = UDim2.new(0, 0, 0, 2),
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.GothamBold,
						BackgroundTransparency = 1,
						Text = string.upper(name),
						TextTransparency = 0.85,
						TextSize = 14,
						ZIndex = 2
					})
				}),
				new("Search","ImageButton", {
					Name = "Search",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Position = UDim2.new(1, -6, 0.2, 0),
					Image = "rbxassetid://6453294709",
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.new(0, 18, 0, 18),
					BackgroundTransparency = 1,
					Rotation = 360,
					ZIndex = 3
				}, {
					new("iconShadow","ImageLabel", {
						Name = "iconShadow",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Image = "rbxassetid://6453294709",
						Position = UDim2.new(0, 0, 0, 2),
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						ImageTransparency = 0.85,
						ZIndex = 2
					})
				})
			})
		})
	})

	uis.InputBegan:Connect(function(Input)
		if Input.KeyCode == Enum.KeyCode.RightControl then
			uilib.Enabled = not uilib.Enabled
		end
	end)

	library:Drag(uilib.Main)
	library:Resize(uilib.Main.Resize, uilib.Main, 317, 216)	

	--[[TABS]]--
	function library:CreateTab(name)
		tabamount = tabamount+1
		local tabnum = tabamount

		local tab = new("Tab","TextButton", {
			Name = "Tab"..tabamount,
			Parent = uilib.Main.Bar.Tabs.tabHolder,
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = name:gsub("^(.)", string.upper),
			Size = UDim2.new(0, 0, 1, 0),
			Font = Enum.Font.GothamSemibold,
			AutoButtonColor = false,
			LayoutOrder = tabnum,
			BorderSizePixel = 0,
			TextSize = 11,
			ZIndex = 3
		})
		tab.Size = UDim2.new(0,tab.TextBounds.X+6,1,0)
		tab.Parent.CanvasSize = UDim2.new(0,tab.Parent.tabList.AbsoluteContentSize.X,0,0)

		local section = new("sectionHolder","ScrollingFrame", {
			Name = tostring("tab"..tabamount),
			Parent = uilib.Main.Section,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			CanvasSize = UDim2.new(0, 0, 0, 242),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, -8, 1, -8),
			BackgroundTransparency = 1,
			ScrollingEnabled = true,
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
            Visible = false,
			ZIndex = 3
		}, {
			new("sectionList","UIListLayout", {
				Name = "sectionList",
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2)
			})
		})
        tab.MouseButton1Click:Connect(function()
			tab.Font = "GothamBold"
            tab.BackgroundColor3 = Color3.fromRGB(42, 47, 58)
            for i,v in pairs(uilib.Main.Section:GetChildren()) do
                if v.Name == tostring("tab"..tabnum) and v.ClassName == "ScrollingFrame" then
                    ts:Create(uilib.Main, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, uilib.Main.AbsoluteSize.X, 0, math.clamp((uilib.Main.Section["tab"..tabnum].sectionList.AbsoluteContentSize.Y+16)+48,216,284))}):Play()
                end
            end

			for i,v in pairs(uilib.Main.Section:GetChildren()) do
				if v.Name ~= tostring("tab"..tabnum) and v.ClassName == "ScrollingFrame" then
					v.Visible = false
				end
			end
			for i,v in pairs(uilib.Main.Bar.Tabs.tabHolder:GetChildren()) do
				if v.ClassName == "TextButton" and v ~= tab then
					tabs[v.LayoutOrder] = false
					v.Font = "Gotham"
                    v.BackgroundColor3 = Color3.fromRGB(58, 66, 79)
				end
			end

			if section.Visible == true then
				section.Visible = false
				ts:Create(uilib.Main, TweenInfo.new(.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, uilib.Main.AbsoluteSize.X, 0, 64)}):Play()
				tab.BackgroundColor3 = Color3.fromRGB(58, 66, 79)
				tabs[tabnum] = false
			else
				section.Visible = true
				tabs[tabnum] = true
			end
		end)
		tab.MouseEnter:Connect(function()
			tab.Font = "GothamBold"
		end)
		tab.MouseLeave:Connect(function()
			if tabs[tabnum] ~= true then
				tab.Font = "Gotham"
			end
		end)
	end

	--[[BUTTONS]]--
	function library:CreateButton(name, callback)
		local callback = callback or function() end
		buttonamount = buttonamount + 1

		local button = new("Button","TextButton", {
			Name = "Button"..buttonamount,
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			TextColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.new(1, 0, 0, 20),
			Font = Enum.Font.SourceSans,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			TextSize = 14,
			Text = "",
			ZIndex = 4
		}, {
			new("Title","TextLabel", {
				Name = "Title",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 1, 0),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
			new("Icon","ImageLabel", {
				Name = "Icon",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(1, -3, 0.5, 0),
				Image = "rbxassetid://6267058610",
				AnchorPoint = Vector2.new(1, 0.5),
				Size = UDim2.new(0, 14, 0, 14),
				BackgroundTransparency = 1,
				ZIndex = 5
			})
		})
		local Down = false
		button.MouseButton1Down:Connect(function()
			Down = true
			ts:Create(button, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
			ts:Create(button.Title, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(58, 66, 79)}):Play()
			ts:Create(button.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(58, 66, 79)}):Play()
		end)
		uis.InputEnded:Connect(function(input)
			if Down == true then
				Down = false
				ts:Create(button, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(58, 66, 79)}):Play()
				ts:Create(button.Title, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
				ts:Create(button.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
				callback()
			end
		end)

		uilib.Main.Section["tab"..tabamount].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..tabamount].sectionList.AbsoluteContentSize.Y)
	end

    --[[SLIDERS]]--
    function library:CreateSlider(name, settings, callback)
		local location = settings.location or {}
		local flag = settings.flag or self
		local min = settings.min
		local max = settings.max 
		local default = settings.default or min
        local callback = callback or function() end

		slideramount = slideramount + 1

		location[flag] = default

		if default ~= min then
			callback(default)
		end

        local slider = new("Slider","Frame", {
			Name = "Slider"..slideramount,
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			Size = UDim2.new(1, 0, 0, 20),
			BorderSizePixel = 0,
			ZIndex = 4
		}, {
			new("Title","TextLabel", {
				Name = "Title",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 1, 0),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
            new("sliderButton","TextButton", {
                Name = "sliderButton",
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = Color3.fromRGB(42, 47, 58),
                Size = UDim2.new(0.6, 0, 0, 12),
                TextColor3 = Color3.fromRGB(0, 0, 0),
                Position = UDim2.new(1, -5, 0.5, 0),
                Font = Enum.Font.SourceSans,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                TextSize = 14,
                Text = "",
                ZIndex = 5
            }, {
                new("sliderHolder","Frame", {
                    Name = "sliderHolder",
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(95, 109, 130),
                    BorderColor3 = Color3.fromRGB(68, 78, 109),
                    Position = UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(1, -4, 1, -4),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 6
                }, {
                    new("sliderFill","Frame", {
                        Name = "sliderFill",
                        BackgroundColor3 = Color3.fromRGB(95, 109, 130),
                        BorderColor3 = Color3.fromRGB(68, 78, 109),
                        Size = UDim2.new(1 - (max - default or min) / (max - min), 0, 1, 0),
                        BorderSizePixel = 0,
                        ZIndex = 7
                    }),
                    new("sliderAmount","TextLabel", {
                        Name = "sliderAmount",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Enum.Font.SourceSans,
                        BackgroundTransparency = 1,
                        TextSize = 13,
                        Text = default or min,
                        ZIndex = 8,
                    })
                })
            })
        })

        local down = false
        slider.sliderButton.MouseButton1Down:Connect(function()
            down = true
			local Xclamp = math.clamp((mouse.X - slider.sliderButton.AbsolutePosition.X) / (slider.sliderButton.AbsoluteSize.X), 0, 1)
			local Val = min + (max - min) * Xclamp
			
			slider.sliderButton.sliderHolder.sliderFill.Size = UDim2.new(Xclamp,0,1,0)
			slider.sliderButton.sliderHolder.sliderAmount.Text = math.floor(Val)

			location[flag] = math.floor(Val)

			callback(math.floor(Val))
        end)
        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                down = false
            end
        end)
        mouse.Move:Connect(function()
            if down then
                local Xclamp = math.clamp((mouse.X - slider.sliderButton.AbsolutePosition.X) / (slider.sliderButton.AbsoluteSize.X), 0, 1)
                local Val = min + (max - min) * Xclamp

                slider.sliderButton.sliderHolder.sliderFill.Size = UDim2.new(Xclamp,0,1,0)
                slider.sliderButton.sliderHolder.sliderAmount.Text = math.floor(Val)

				location[flag] = math.floor(Val)

                callback(math.floor(Val))
            end
        end)

		uilib.Main.Section["tab"..tabamount].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..tabamount].sectionList.AbsoluteContentSize.Y)
    end

    --[[TOGGLES]]--
    function library:CreateToggle(name, settings, callback)
		local location = settings.location or {}
		local flag = settings.flag or self
		local default = settings.default or false
        local callback = callback or function() end

		toggleamount = toggleamount + 1

        local toggle = new("Slider","Frame", {
			Name = "toggle"..toggleamount,
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			Size = UDim2.new(1, 0, 0, 20),
			BorderSizePixel = 0,
			ZIndex = 4
		}, {
			new("Title","TextLabel", {
				Name = "Title",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 1, 0),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
            new("toggleButton","TextButton", {
                Name = "toggleButton",
                BackgroundColor3 = Color3.fromRGB(42, 47, 58),
                Position = UDim2.new(1, -5, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                Size = UDim2.new(0, 28, 0, 12),
                AutoButtonColor = false,
                BorderSizePixel = 0,
                TextSize = 14,
                Text = "",
                ZIndex = 5
            }, {
                new("toggleFill","Frame", {
                    Name = "toggleFill",
                    BackgroundColor3 = Color3.fromRGB(72, 83, 99),
                    BorderColor3 = Color3.fromRGB(68, 78, 109),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Size = UDim2.new(0.5, -2, 1, -4),
                    BorderSizePixel = 0,
                    ZIndex = 6
                })
            })
        })

        local Tog = false

		if default == true then
			Tog = true

			location[flag] = Tog

			callback(Tog)

			ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(1, -2, 0.5, 0)}):Play()
			ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(95, 109, 130)}):Play()
		end

        local Down = false
        toggle.toggleButton.MouseButton1Down:Connect(function()
            Down = true
        end)
        uis.InputEnded:Connect(function(input)
            if Down == true then
                ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0.5, -2, 1, -4)}):Play()
                if Tog then
                    ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
					ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(72, 83, 99)}):Play()
                else
                    ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(1, -2, 0.5, 0)}):Play()
					ts:Create(toggle.toggleButton.toggleFill, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(95, 109, 130)}):Play()
                end
                Down = false
                Tog = not Tog

				location[flag] = Tog

                callback(Tog)
            end
        end)

		uilib.Main.Section["tab"..tabamount].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..tabamount].sectionList.AbsoluteContentSize.Y)
    end

    --[[TEXTBOXES]]--
    function library:CreateTextbox(name, settings, callback)
		local location = settings.location or {}
		local flag = settings.flag or self
		local default = settings.default or ""
        local callback = callback or function() end

		textboxamount = textboxamount + 1

        local textbox = new("Textbox","Frame", {
			Name = "Textbox"..textboxamount,
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			Size = UDim2.new(1, 0, 0, 20),
			BorderSizePixel = 0,
			ZIndex = 4
		}, {
			new("Title","TextLabel", {
				Name = "Title",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 1, 0),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
            new("textboxBack","Frame", {
                Name = "textboxBack",
                BackgroundColor3 = Color3.fromRGB(42, 47, 58),
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                Position = UDim2.new(1, -5, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                BorderSizePixel = 0,
                ZIndex = 5
            }, {
                new("Textbox","TextBox", {
                    Name = "Textbox",
                    PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(1, -6, 1, -2),
                    Font = Enum.Font.SourceSans,
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    Text = default,
                    TextSize = 12,
                    ZIndex = 6
                })
            })
        })


		location[flag] = default

		callback(default)

        textbox.textboxBack.Size = UDim2.new(0, textbox.textboxBack.Textbox.TextBounds.X + 6, 1, -8)

        textbox.textboxBack.Textbox.Changed:Connect(function()
            ts:Create(textbox.textboxBack, TweenInfo.new(.03, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, math.clamp(textbox.textboxBack.Textbox.TextBounds.X + 6, 26, 178), 1, -8)}):Play()
        end)
        textbox.textboxBack.Textbox.FocusLost:Connect(function()
			location[flag] = textbox.textboxBack.Textbox.Text

            callback(textbox.textboxBack.Textbox.Text)
        end)

		uilib.Main.Section["tab"..tabamount].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..tabamount].sectionList.AbsoluteContentSize.Y)
    end

    --[[KEYBINDS]]--
    function library:CreateKeybind(name, settings, callback)
		local location = settings.location or {}
		local flag = settings.flag or self
		local default = settings.default
        local callback = callback or function() end

		keybindamount = keybindamount + 1

        local keybind = new("Keybind","Frame", {
			Name = "Keybind"..keybindamount,
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			Size = UDim2.new(1, 0, 0, 20),
			BorderSizePixel = 0,
			ZIndex = 4
		}, {
			new("Title","TextLabel", {
				Name = "Title",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 1, 0),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
            new("keybindButton","TextButton", {
                Name = "keybindButton",
                BackgroundColor3 = Color3.fromRGB(42, 47, 58),
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                Position = UDim2.new(1, -5, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Text = "",
                ZIndex = 5
            }, {
                new("keybindText","TextLabel", {
                    Name = "keybindText",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(1, -6, 1, -2),
                    Font = Enum.Font.SourceSans,
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Text = tostring(default):gsub("Enum.KeyCode.", ""),
                    TextSize = 12,
                    ZIndex = 6
                })
            })
        })

        keybind.keybindButton.Size = UDim2.new(0, math.clamp(keybind.keybindButton.keybindText.TextBounds.X + 6, 26, 178), 1, -8)

        local Current = default or nil
        local Awaiting = false

		location[flag] = Current

        keybind.keybindButton.MouseButton1Click:Connect(function()
            Awaiting = true
            keybind.keybindButton.keybindText.Text = ". . ."
        end)

        uis.InputBegan:Connect(function(input)
			if not uis:GetFocusedTextBox() then
				if Awaiting then
					if input.KeyCode == Enum.KeyCode.Unknown then
						Current = Current
						keybind.keybindButton.keybindText.Text = tostring(Current or ". . ."):gsub("Enum.KeyCode.", "")
						return
					end

					Current = input.KeyCode

					location[flag] = Current

					keybind.keybindButton.keybindText.Text = tostring(Current or ". . ."):gsub("Enum.KeyCode.", "")
					
					keybind.keybindButton.Size = UDim2.new(0, math.clamp(keybind.keybindButton.keybindText.TextBounds.X + 6, 26, 178), 1, -8)

					Awaiting = false
					return
				end
				if input.KeyCode == Current and callback then
					callback() 
				end
			end
        end)

		uilib.Main.Section["tab"..tabamount].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..tabamount].sectionList.AbsoluteContentSize.Y)
    end

    --[[COLOURPICKER]]--
    function library:CreateColour(name, settings, callback)
		local location = settings.location or {}
		local flag = settings.flag or self
        local callback = callback or function() end

		colouramount = colouramount + 1
		
		local colour = new("Colour","Frame", {
			Name = "Colour",
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			Size = UDim2.new(1, 0, 0, 20),
			BorderSizePixel = 0,
			LayoutOrder = 3,
			ZIndex = 4
		}, {
			new("Title","TextLabel", {
				Name = "Title",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 1, 0),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
			new("colourButton","TextButton", {
				Name = "colourButton",
				BackgroundColor3 = Color3.fromRGB(42, 47, 58),
				Position = UDim2.new(1, -5, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Size = UDim2.new(0, 12, 0, 12),
				AutoButtonColor = false,
				BorderSizePixel = 0,
				Text = "",
				ZIndex = 5
			}, {
				new("colourFill","Frame", {
					Name = "colourFill",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(68, 78, 109),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(1, -4, 1, -4),
					BorderSizePixel = 0,
					ZIndex = 6
				})
			})
		})
		local picker = new("Picker","Frame", {
			Name = "Colour",
			Parent = uilib.Main,
			BackgroundColor3 = Color3.fromRGB(36, 41, 49),
			Position = UDim2.new(1, 10, 0, 0),
			Size = UDim2.new(0, 131, 0, 156),
			BorderSizePixel = 0,
			Visible = false
		}, {
			new("Shadow","ImageLabel", {
				Name = "Shadow",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ImageColor3 = Color3.fromRGB(15, 15, 15),
				SliceCenter = Rect.new(20, 20, 280, 280),
				Position = UDim2.new(0, -15, 0, -15),
				Image = "rbxassetid://4996891970",
				ScaleType = Enum.ScaleType.Slice,
				Size = UDim2.new(1, 30, 1, 30),
				BackgroundTransparency = 1,
				ImageTransparency = 0.35,
				BorderSizePixel = 0,
				ZIndex = 0
			}),
			new("Section","Frame", {
				Name = "Section",
				BackgroundColor3 = Color3.fromRGB(42, 47, 58),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(1, -8, 1, -8),
				BorderSizePixel = 0,
				ZIndex = 2
			}, {
				new("sectionHolder","Frame", {
					Name = "sectionHolder",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(1, -4, 1, -4),
					BackgroundTransparency = 1,
					ZIndex = 3
				}, {
					new("Hue","TextButton", {
						Name = "Hue",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Position = UDim2.new(0.5, 0, 0, 95),
						AnchorPoint = Vector2.new(0.5, 0),
						Size = UDim2.new(1, -4, 0, 8),
						AutoButtonColor = false,
						BorderSizePixel = 0,
						Text = "",
						ZIndex = 3
					}, {
						new("UIGradient","UIGradient", {
							Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))}
						}),
						new("Line","Frame", {
							Name = "Line",
							BackgroundColor3 = Color3.fromRGB(95, 109, 130),
							Size = UDim2.new(0, 1, 1, 0),
							BorderSizePixel = 0,
							ZIndex = 4
						})
					}),
					new("White","Frame", {
						Name = "White",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Position = UDim2.new(0.5, 0, 0, 3),
						AnchorPoint = Vector2.new(0.5, 0),
						Size = UDim2.new(1, -4, 0, 90),
						BorderSizePixel = 0,
						ZIndex = 3
					}, {
						new("Val","Frame", {
							Name = "Val",
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							Size = UDim2.new(1, 0, 1, 0),
							BorderSizePixel = 0,
							ZIndex = 4,
						}, {
							new("UIGradient","UIGradient", {
								Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(1.00, 0.00)}
							}),
							new("Sat","TextButton", {
								Name = "Sat",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								Size = UDim2.new(1, 0, 1, 0),
								AutoButtonColor = false,
								BorderSizePixel = 0,
								Text = "",
								ZIndex = 5
							}, {
								new("UIGradient","UIGradient", {
									Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))},
									Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(1.00, 0.00)},
									Rotation = 90
								})
							})
						}),
						new("Icon","ImageLabel", {
							Name = "icon",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							ImageColor3 = Color3.fromRGB(95, 109, 130),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Image = "rbxassetid://5052625837",
							Size = UDim2.new(0, 6, 0, 6),
							BackgroundTransparency = 1,
							ZIndex = 6
						})
					}),
					new("rgbHolder","Frame", {
						Name = "rgbHolder",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Position = UDim2.new(0.5, 0, 0, 105),
						AnchorPoint = Vector2.new(0.5, 0),
						Size = UDim2.new(1, -4, 0, 14),
						BackgroundTransparency = 1,
						ZIndex = 3
					}, {
						new("rgbList","UIListLayout", {
							FillDirection = Enum.FillDirection.Horizontal,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 2)
						}),
						new("R","TextBox", {
							Name = "R",
							PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundColor3 = Color3.fromRGB(58, 66, 79),
							TextColor3 = Color3.fromRGB(255, 255, 255),
							BorderColor3 = Color3.fromRGB(45, 45, 45),
							Font = Enum.Font.SourceSansSemibold,
							Size = UDim2.new(0, 37, 1, 0),
							BorderSizePixel = 0,
							Text = "R: 255",
							TextSize = 13,
							ZIndex = 4
						}),
						new("G","TextBox", {
							Name = "G",
							PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundColor3 = Color3.fromRGB(58, 66, 79),
							TextColor3 = Color3.fromRGB(255, 255, 255),
							BorderColor3 = Color3.fromRGB(45, 45, 45),
							Font = Enum.Font.SourceSansSemibold,
							Size = UDim2.new(0, 37, 1, 0),
							BorderSizePixel = 0,
							Text = "G: 255",
							TextSize = 13,
							ZIndex = 4
						}),
						new("B","TextBox", {
							Name = "B",
							PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundColor3 = Color3.fromRGB(58, 66, 79),
							TextColor3 = Color3.fromRGB(255, 255, 255),
							BorderColor3 = Color3.fromRGB(45, 45, 45),
							Font = Enum.Font.SourceSansSemibold,
							Size = UDim2.new(0, 37, 1, 0),
							BorderSizePixel = 0,
							Text = "B: 255",
							TextSize = 13,
							ZIndex = 4
						})
					}),
					new("Submit","TextButton", {
						Name = "Submit",
						BackgroundColor3 = Color3.fromRGB(58, 66, 79),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						BorderColor3 = Color3.fromRGB(45, 45, 45),
						Position = UDim2.new(0.5, 0, 0, 121),
						Font = Enum.Font.SourceSansSemibold,
						AnchorPoint = Vector2.new(0.5, 0),
						Size = UDim2.new(1, -4, 0, 20),
						AutoButtonColor = false,
						BorderSizePixel = 0,
						TextSize = 13,
						Text = "",
						ZIndex = 3
					}, {
						new("Title","TextLabel", {
							Name = "Title",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextXAlignment = Enum.TextXAlignment.Left,
							Position = UDim2.new(0.5, 0, 0, 0),
							AnchorPoint = Vector2.new(0.5, 0),
							Font = Enum.Font.GothamSemibold,
							Size = UDim2.new(1, -8, 1, 0),
							BackgroundTransparency = 1,
							Text = "Submit",
							TextSize = 10,
							ZIndex = 4
						}),
						new("Icon","ImageLabel", {
							Name = "Icon",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							Position = UDim2.new(1, -3, 0.5, 0),
							Image = "rbxassetid://6267058610",
							AnchorPoint = Vector2.new(1, 0.5),
							Size = UDim2.new(0, 14, 0, 14),
							BackgroundTransparency = 1,
							ZIndex = 5
						})
					})
				})
			}),
		})

		local Satdown = false
		local Huedown = false
		local OldHue = 0 / 360
		local OldSat = 0
		local OldVal = 0
		local function UpdColour(NewHue, NewSat, NewVal)
			OldHue = NewHue or OldHue
			OldSat = NewSat or OldSat
			OldVal = NewVal or OldVal
			return Color3.fromHSV(OldHue, OldSat, OldVal)
		end
		local function initTextBox(textBox)
			textBox.Text = string.format('%s: 255', textBox.Name)
			local oldText = textBox.Text
			
			textBox.FocusLost:Connect(function()
				if(not tonumber(textBox.Text:match('%d+'))) then
					print('no')
					textBox.Text = oldText
					return
				end
				
				oldText = textBox.Text
				textBox.Text = string.format('%s: %s', textBox.Name, textBox.Text:match('%d+'))
				
				local R, G, B = picker.Section.sectionHolder.rgbHolder.R.Text, picker.Section.sectionHolder.rgbHolder.G.Text, picker.Section.sectionHolder.rgbHolder.B.Text
				R, G, B = R:match('%d+'), G:match('%d+'), B:match('%d+')
				R, G, B = tonumber(R), tonumber(G), tonumber(B)

				colour.colourButton.colourFill.BackgroundColor3 = Color3.fromRGB(R, G, B)
			end)
		end
		picker.Section.sectionHolder.White.Val.Sat.MouseButton1Down:Connect(function()
			Satdown = true
		end)
		picker.Section.sectionHolder.Hue.MouseButton1Down:Connect(function()
			Huedown = true
		end)
		uis.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Satdown = false
				Huedown = false
			end
		end)
		mouse.Move:Connect(function()
			if Satdown then
				local AbsPos = picker.Section.sectionHolder.White.AbsolutePosition
				local AbsSize = picker.Section.sectionHolder.White.AbsoluteSize

				local SizeX = AbsSize.X
				local SizeY = AbsSize.Y

				local RelX = math.clamp(mouse.X - AbsPos.X, 0, SizeX) / SizeX
				local RelY = math.clamp(mouse.Y - AbsPos.Y, 0, SizeY) / SizeY

				picker.Section.sectionHolder.rgbHolder.R.Text = "R: "..math.floor((colour.colourButton.colourFill.BackgroundColor3.R * 255))
				picker.Section.sectionHolder.rgbHolder.G.Text = "G: "..math.floor((colour.colourButton.colourFill.BackgroundColor3.G * 255))
				picker.Section.sectionHolder.rgbHolder.B.Text = "B: "..math.floor((colour.colourButton.colourFill.BackgroundColor3.B * 255))

				picker.Section.sectionHolder.White.icon.Position = UDim2.new(RelX,0,RelY,0)
				colour.colourButton.colourFill.BackgroundColor3 = UpdColour(nil, RelX, 1 - RelY)
			end
			if Huedown then
				local PosX = picker.Section.sectionHolder.Hue.AbsolutePosition.X
				local SizeX = picker.Section.sectionHolder.Hue.AbsoluteSize.X
				local RelX = math.clamp(mouse.X - PosX, 0, SizeX) / SizeX

				picker.Section.sectionHolder.rgbHolder.R.Text = "R: "..math.floor((colour.colourButton.colourFill.BackgroundColor3.R * 255))
				picker.Section.sectionHolder.rgbHolder.G.Text = "G: "..math.floor((colour.colourButton.colourFill.BackgroundColor3.G * 255))
				picker.Section.sectionHolder.rgbHolder.B.Text = "B: "..math.floor((colour.colourButton.colourFill.BackgroundColor3.B * 255))

				picker.Section.sectionHolder.Hue.Line.Position = UDim2.new(RelX, 0, 0, 0)
				picker.Section.sectionHolder.White.Val.BackgroundColor3 = Color3.fromHSV(RelX, 1, 1)
				colour.colourButton.colourFill.BackgroundColor3 = UpdColour(RelX)
			end
		end)
		picker.Section.sectionHolder.Submit.MouseButton1Click:Connect(function()
			picker.Visible = false

			location[flag] = colour.colourButton.colourFill.BackgroundColor3

			callback(colour.colourButton.colourFill.BackgroundColor3)
		end)
		colour.colourButton.MouseButton1Click:Connect(function()
			picker.Visible = true
		end)
		initTextBox(picker.Section.sectionHolder.rgbHolder.R)
		initTextBox(picker.Section.sectionHolder.rgbHolder.G)
		initTextBox(picker.Section.sectionHolder.rgbHolder.B)
    end

	--[[DROPDOWNS]]--
	function library:CreateDropdown(name, settings, callback)
		local location = settings.location or {}
		local flag = settings.flag or self
		local list = settings.list or {}
		local default = settings.default
		local callback = callback or function() end
		local dropvalamount = 0

		local Connections = {}

		if default == nil then
			if typeof(list) == "Instance" then
				location[flag] = list:GetChildren()[1]
			else
				location[flag] = list[1]
			end
		else
			location[flag] = default
		end

		dropdownamount = dropdownamount + 1

		local dropdown = new("Dropdown","TextButton", {
			Name = "Dropdown"..dropdownamount,
			Parent = uilib.Main.Section["tab"..tabamount],
			BackgroundColor3 = Color3.fromRGB(58, 66, 79),
			TextColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.new(1, 0, 0, 20),
			Font = Enum.Font.SourceSans,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			TextSize = 14,
			Text = "",
			ZIndex = 4
		}, {
			new("Title","TextBox", {
				Name = "Title",
				PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = name:gsub("^(.)", string.upper),
				PlaceholderText = name:gsub("^(.)", string.upper),
				Position = UDim2.new(0, 5, 0, 0),
				Size = UDim2.new(0.35, 0, 0, 20),
				Font = Enum.Font.GothamSemibold,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				BorderSizePixel = 0,
				TextSize = 10,
				ZIndex = 5
			}),
			new("Icon","ImageLabel", {
				Name = "Icon",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(1, -3, 0, 3),
				AnchorPoint = Vector2.new(1, 0),
				Image = "rbxassetid://6267217716",
				Size = UDim2.new(0, 14, 0, 14),
				BackgroundTransparency = 1,
				ZIndex = 6
			}),
			new("Dropframe","Frame", {
				Name = "Dropframe",
				BackgroundColor3 = Color3.fromRGB(36, 41, 49),
				Position = UDim2.new(0, 0, 0, 20),
				Size = UDim2.new(1, 0, 1, -20),
				ClipsDescendants = true,
				BorderSizePixel = 0,
				ZIndex = 9
			}, {
				new("dropHolder","ScrollingFrame", {
					Name = "dropHolder",
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					ScrollBarImageColor3 = Color3.fromRGB(63, 72, 85),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					CanvasSize = UDim2.new(0, 0, 0, 130),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(1, -4, 1, -4),
					BackgroundTransparency = 1,
					ScrollBarThickness = 2,
					BorderSizePixel = 0,
					ZIndex = 10
				}, {
					new("dropList","UIListLayout", {
						Name = "dropList",
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 2)
					})
				})
			})
		})

		local tog = false
		local whatTab = tabamount

		local function Toggle(bool, delay)
			wait(delay)

			if tog == false then
				ts:Create(dropdown.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 180}):Play()
				ts:Create(dropdown, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,math.clamp(dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y+24, 0, 88))}):Play()
			else
				ts:Create(dropdown.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Rotation = 0}):Play()
				ts:Create(dropdown, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(1,0,0,20)}):Play()
			end

			wait(.1)

			uilib.Main.Section["tab"..whatTab].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..whatTab].sectionList.AbsoluteContentSize.Y)
			dropdown.Dropframe.dropHolder.CanvasSize = UDim2.new(0,0,0,dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y)

			tog = not tog
		end

		local function Update()
			local UsedTable = list

			if typeof(list) == "Instance" then
				UsedTable = list:GetChildren()
			end

			for i,v in pairs(dropdown.Dropframe.dropHolder:GetChildren()) do
				if v.Name == "Dropvalue" then
					v:Destroy()
				end
			end

			for i,v in pairs(Connections) do
				v:Disconnect()
			end

			for i,v in next, UsedTable do

				dropvalamount = dropvalamount + 1
				
				local dropvalue = new("Dropvalue","TextButton", {
					Name = "Dropvalue",
					Parent = dropdown.Dropframe.dropHolder,
					BackgroundColor3 = Color3.fromRGB(49, 56, 67),
					Size = UDim2.new(1, -4, 0, 20),
					Font = Enum.Font.SourceSans,
					AutoButtonColor = false,
					BorderSizePixel = 0,
					TextSize = 14,
					Text = "",
					ZIndex = 11
				}, {
					new("Title","TextLabel", {
						Name = "Title",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextXAlignment = Enum.TextXAlignment.Left,
						Text = tostring(v),
						Position = UDim2.new(0, 5, 0, 0),
						Size = UDim2.new(0.35, 0, 1, 0),
						Font = Enum.Font.GothamSemibold,
						BackgroundTransparency = 1,
						ClipsDescendants = true,
						BorderSizePixel = 0,
						TextSize = 10,
						ZIndex = 12
					}),
					new("Icon","ImageLabel", {
						Name = "Icon",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Position = UDim2.new(1, -3, 0.5, 0),
						Image = "rbxassetid://6267058610",
						AnchorPoint = Vector2.new(1, 0.5),
						Size = UDim2.new(0, 14, 0, 14),
						BackgroundTransparency = 1,
						ZIndex = 12
					})
				})

				

				local Down = false
				local Dropdown, InputService
				Dropdown = dropvalue.MouseButton1Down:Connect(function()
					Down = true
					ts:Create(dropvalue, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
					ts:Create(dropvalue.Title, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(49, 56, 67)}):Play()
					ts:Create(dropvalue.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(49, 56, 67)}):Play()

					Toggle(true, 0.1)
				end)
				InputService = uis.InputEnded:Connect(function(input)
					if Down == true then
						
						dropdown.Title.Text = dropvalue.Title.Text

						location[flag] = dropvalue.Title.Text

						callback(dropvalue.Title.Text)
						
						ts:Create(dropvalue, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(49, 56, 67)}):Play()
						ts:Create(dropvalue.Title, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
						ts:Create(dropvalue.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
						Down = false
					end
				end)

				table.insert(Connections, Dropdown)
				table.insert(Connections, InputService)
			end

			if dropvalamount <= 3 then
				for i,v in pairs(dropdown.Dropframe.dropHolder:GetChildren()) do
					if v.ClassName == "TextButton" then
						v.Size = UDim2.new(1, 0, 0, 20)
					end
				end
			end
		end

		dropdown.Title.Focused:Connect(function()
			ts:Create(dropdown.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 180}):Play()
			ts:Create(dropdown, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,math.clamp(dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y+24, 0, 88))}):Play()

			wait(.1)
			
			uilib.Main.Section["tab"..whatTab].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..whatTab].sectionList.AbsoluteContentSize.Y)
			dropdown.Dropframe.dropHolder.CanvasSize = UDim2.new(0,0,0,dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y)
			
			tog = true
		end)

		dropdown.Title:GetPropertyChangedSignal("Text"):Connect(function()
			for i,v in pairs(dropdown.Dropframe.dropHolder:GetChildren()) do
				if v.Name == "Dropvalue" then
					if string.match(v.Title.Text, dropdown.Title.Text:gsub("^(.)", string.upper)) then
						v.Visible = true
					else
						v.Visible = false
					end
				end
			end
			ts:Create(dropdown, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,math.clamp(dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y+24, 0, 88))}):Play()
			dropdown.Dropframe.dropHolder.CanvasSize = UDim2.new(0,0,0,dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y)
		end)
		
		dropdown.MouseButton1Click:Connect(function()
			if typeof(list) == "Instance" then
				Update()
			end

			dropdown.Title.Text = ""

			if tog == false then
				ts:Create(dropdown.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Rotation = 180}):Play()
				ts:Create(dropdown, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,math.clamp(dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y+24, 0, 88))}):Play()
			else
				ts:Create(dropdown.Icon, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Rotation = 0}):Play()
				ts:Create(dropdown, TweenInfo.new(.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(1,0,0,20)}):Play()
			end
			wait(.1)
			uilib.Main.Section["tab"..whatTab].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..whatTab].sectionList.AbsoluteContentSize.Y)
			dropdown.Dropframe.dropHolder.CanvasSize = UDim2.new(0,0,0,dropdown.Dropframe.dropHolder.dropList.AbsoluteContentSize.Y)
			tog = not tog			
		end)

		Update()

		uilib.Main.Section["tab"..whatTab].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..whatTab].sectionList.AbsoluteContentSize.Y)
	end

    --[[SECTIONS]]--
    function library:CreateSection(name)
        sectionamount = sectionamount+1
        
        local section = new("Section", "Frame", {
            Name = "Section",
            Parent = uilib.Main.Section["tab"..tabamount],
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(1, 0, 0, 14),
            BackgroundTransparency = 1,
            ZIndex = 4
        }, {
            new("Line", "Frame", {
                Name = "Line",
                BackgroundColor3 = Color3.fromRGB(58, 66, 79),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(1, 0, 1, -12),
                BorderSizePixel = 0,
                ZIndex = 4
            }, {
                new("Title","TextLabel", {
					Name = "Title",
					BackgroundColor3 = Color3.fromRGB(42, 47, 58),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = Enum.TextXAlignment.Center,
                    Text = name:gsub("^(.)", string.upper),
					Position = UDim2.new(0.5, 0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0),
                    Font = Enum.Font.GothamSemibold,
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 0,
					TextSize = 10,
					ZIndex = 6
				}, {
					new("textShadow","TextLabel", {
						Name = "textShadow",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextXAlignment = Enum.TextXAlignment.Center,
                        Text = name:gsub("^(.)", string.upper),
						Position = UDim2.new(0, 0, 0, 2),
                        Font = Enum.Font.GothamSemibold,
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						TextTransparency = 0.85,
						TextSize = 10,
						ZIndex = 5
					})
				})
            })
        })

        section.Line.Title.Size = UDim2.new(0, section.Line.Title.TextBounds.X+6, 0, 1)
		uilib.Main.Section["tab"..tabamount].CanvasSize = UDim2.new(0,0,0,uilib.Main.Section["tab"..tabamount].sectionList.AbsoluteContentSize.Y)
    end

	--[[NOTIFICATIONS]]--
	function library:CreateNotification(name, msg)
	end

end

return library
