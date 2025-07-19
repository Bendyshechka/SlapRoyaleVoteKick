
local Username
local Time
if _G.Config == nil or _G.Config.Username == nil or _G.Config.Username == "" or _G.Config.Time == nil or _G.Config.Time == "" then
	Time = 15
	Username = "Sigma"
else
	Time = _G.Config.Time
	Username = _G.Config.Username
end








wait(Time)
function showNotice(text)
	local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Получаем элементы интерфейса
local KickNoticeGui = PlayerGui:WaitForChild("KickNotice")
local KickNoticeFrame = KickNoticeGui:WaitForChild("KickNotice")
local UIScale = KickNoticeFrame:WaitForChild("UIScale")

-- Начальные и конечные позиции
local defaultPosition = UDim2.new(0.500260413, 0, 0.9, 0) 
local hiddenPosition = UDim2.new(0.500260413, 0, 1.21765709, 0)
	if text == nil then
		game:GetService("Players").LocalPlayer.PlayerGui.KickNotice.KickNotice.ContentText.Text = "Sigma"
	else
		game:GetService("Players").LocalPlayer.PlayerGui.KickNotice.KickNotice.ContentText.Text = text
	end
	
    -- Устанавливаем начальное состояние (скрытое)
    KickNoticeFrame.Position = hiddenPosition
    UIScale.Scale = 0.7
    KickNoticeFrame.Visible = true
    
    -- Анимация появления
    local tweenInfo = TweenInfo.new(
        0.25, -- Длительность
        Enum.EasingStyle.Exponential, -- Стиль анимации
        Enum.EasingDirection.Out -- Направление
    )
    
    -- Создаем твины для позиции и масштаба
    local positionTween = game:GetService("TweenService"):Create(KickNoticeFrame, tweenInfo, {Position = defaultPosition})
    local scaleTween = game:GetService("TweenService"):Create(UIScale, tweenInfo, {Scale = 1.3})
    
    -- Запускаем анимации
    positionTween:Play()
    scaleTween:Play()
    
    -- Ждем 5 секунд, затем скрываем
    wait(5)
    
    -- Анимация исчезновения
    local hideTweenInfo = TweenInfo.new(
        0.15,
        Enum.EasingStyle.Exponential,
        Enum.EasingDirection.In
    )
    
    local hidePositionTween = game:GetService("TweenService"):Create(KickNoticeFrame, hideTweenInfo, {Position = hiddenPosition})
    local hideScaleTween = game:GetService("TweenService"):Create(UIScale, hideTweenInfo, {Scale = 0.7})
    
    hidePositionTween:Play()
    hideScaleTween:Play()
    
    -- Скрываем фрейм после анимации
    hidePositionTween.Completed:Connect(function()
        KickNoticeFrame.Visible = false
		game:GetService("Players").LocalPlayer.PlayerGui.KickNotice.KickNotice.ContentText.Text = ""
    end)
end

local Current = {
	Yes = 0,
	No = 0
}
task.spawn(function()
	local yes = math.random(6, 9)
	local no = math.random(1, 3)
	task.spawn(function()
		for i = 1, yes do
			if math.random(1, 100) <= 40 then
				wait(math.random(1,1.5))
				Current.Yes = tonumber(Current.Yes + 1)
			else
				wait(math.random(0.8,2))
				Current.Yes = tonumber(Current.Yes + 1)
			end
		end
	end)
	for i = 1, no do
		if math.random(1, 100) <= 40 then
				wait(math.random(1,2))
				Current.No = tonumber(Current.No + 1)
			else
				wait(math.random(0.8,3))
				Current.No = tonumber(Current.No + 1)
			end
	end
end)
local Active = true
local Already = false
local UserInputService = game:GetService("UserInputService")
local keyboardOffset = 0.35
local tween = game:GetService("TweenService")
local popup = game:GetService("Players").LocalPlayer.PlayerGui.VotekickPopup.VotekickPopup
popup.Content.VoteYes.VoteButton.MouseButton1Click:Connect(function()
	if Already == false then
		Already = true
		Current.Yes = tonumber(Current.Yes) + 1
	end
end)
popup.Content.VoteNo.VoteButton.MouseButton1Click:Connect(function()
	if Already == false then
		Already = true
		Current.No = tonumber(Current.No) + 1
	end
end)
local conn
	conn = game:GetService("RunService").RenderStepped:Connect(function()
		if Active == true then
			popup.Content.VoteYes.VoteCounter.Text = Current.Yes .. " Vote"
			popup.Content.VoteNo.VoteCounter.Text = Current.No .. " Vote"
		else
			popup.Content.VoteYes.VoteCounter.Text = "0 Vote"
			popup.Content.VoteNo.VoteCounter.Text = "0 Vote"
			conn:Disconnect()
		end
	end)

popup.Position = UDim2.fromScale(1.1, keyboardOffset)
popup.Content.VoteCalledBy.Text = "Called by " .. Username
popup.Content.Target.DisplayName.Text = "Kick " .. game.Players.LocalPlayer.Name
popup.Content.Target.Reason.Text = "Exploiting/Hacking"
local sigma = TweenInfo.new(0.3, Enum.EasingStyle.Exponential)
tween:Create(popup, sigma, {Position = UDim2.fromScale(0.815, keyboardOffset)}):Play()
wait(14)
task.spawn(function()
	wait(1.5)
	game.Players.LocalPlayer:Kick("You have been vote kicked by " .. Username)
	showNotice(game.Players.LocalPlayer.Name .. " has been kicked by " .. Username .. " for Exploiting/Hacking")
end)
tween:Create(popup, sigma, {Position = UDim2.fromScale(1.1, keyboardOffset)}):Play()
Current.No = 0
Current.Yes = 0
Already = false
Active = false
