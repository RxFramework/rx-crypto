-- Variables
local RXCore = exports['rx-core']:GetCoreObject()
local requiredItemsShowed = false
local requiredItems = { [1] = { name = RXCore.Shared.Items['cryptostick']['name'], image = RXCore.Shared.Items['cryptostick']['image'] } }

-- Functions

local function DrawText3Ds(x, y, z, text)
    exports['rx-core']:DrawText3Ds(x, y, z, text)
end

local function ExchangeSuccess()
	TriggerServerEvent('rx-crypto:server:ExchangeSuccess', math.random(1, 10))
end

local function ExchangeFail()
	local Odd = 5
	local RemoveChance = math.random(1, Odd)
	local LosingNumber = math.random(1, Odd)
	if RemoveChance == LosingNumber then
		TriggerServerEvent('rx-crypto:server:ExchangeFail')
		TriggerServerEvent('rx-crypto:server:SyncReboot')
	end
end

local function SystemCrashCooldown()
	CreateThread(function()
		while Crypto.Exchange.RebootInfo.state do
			if (Crypto.Exchange.RebootInfo.percentage + 1) <= 100 then
				Crypto.Exchange.RebootInfo.percentage = Crypto.Exchange.RebootInfo.percentage + 1
				TriggerServerEvent('rx-crypto:server:Rebooting', true, Crypto.Exchange.RebootInfo.percentage)
			else
				Crypto.Exchange.RebootInfo.percentage = 0
				Crypto.Exchange.RebootInfo.state = false
				TriggerServerEvent('rx-crypto:server:Rebooting', false, 0)
			end
			Wait(1200)
		end
	end)
end

CreateThread(function()
	while true do
		local sleep = 5000
		if LocalPlayer.state.isLoggedIn then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			local dist = #(pos - Crypto.Exchange.coords)
			if dist < 15 then
				sleep = 5
				if dist < 1.5 then
					if not Crypto.Exchange.RebootInfo.state then
						DrawText3Ds(Crypto.Exchange.coords, Lang:t('text.enter_usb'))
						if not requiredItemsShowed then
							requiredItemsShowed = true
							TriggerEvent('rx-inventory:client:requiredItems', requiredItems, true)
						end

						if IsControlJustPressed(0, 38) then
							RXCore.Functions.TriggerCallback('rx-crypto:server:HasSticky', function(HasItem)
								if HasItem then
									local success = exports['rx-minigames']:Hacking(5, 30) -- code block size & seconds to solve
									if success then
										ExchangeSuccess()
									else
										ExchangeFail()
									end
								else
									RXCore.Functions.Notify(Lang:t('error.you_dont_have_a_cryptostick'), 'error')
								end
							end)
						end
					else
						DrawText3Ds(Crypto.Exchange.coords, Lang:t('text.system_is_rebooting', { rebootInfoPercentage = Crypto.Exchange.RebootInfo.percentage }))
					end
				else
					if requiredItemsShowed then
						requiredItemsShowed = false
						TriggerEvent('rx-inventory:client:requiredItems', requiredItems, false)
					end
				end
			end
		end
		Wait(sleep)
	end
end)

-- Events

RegisterNetEvent('rx-crypto:client:SyncReboot', function()
	Crypto.Exchange.RebootInfo.state = true
	SystemCrashCooldown()
end)

RegisterNetEvent('RXCore:Client:OnPlayerLoaded', function()
	TriggerServerEvent('rx-crypto:server:FetchWorth')
	TriggerServerEvent('rx-crypto:server:GetRebootState')
end)

RegisterNetEvent('rx-crypto:client:UpdateCryptoWorth', function(crypto, amount, history)
	Crypto.Worth[crypto] = amount
	if history ~= nil then
		Crypto.History[crypto] = history
	end
end)

RegisterNetEvent('rx-crypto:client:GetRebootState', function(RebootInfo)
	if RebootInfo.state then
		Crypto.Exchange.RebootInfo.state = RebootInfo.state
		Crypto.Exchange.RebootInfo.percentage = RebootInfo.percentage
		SystemCrashCooldown()
	end
end)
