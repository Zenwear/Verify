local a, b = function(a)
	local b, c = pcall(a)
	if not b then
		warn('[ZENWEARV5] module failed to load: ' .. tostring(c))
	end
end, setmetatable({}, {
	__index = function(a, b)
		a[b] = Instance.new'BindableEvent'
		return a[b]
	end
})
getgenv().vapeEvents = b
local c = cloneref or function(c)
	return c
end
local function safeGetProto(d, e)
	if not d then
		return nil
	end
	local f, g = pcall(debug.getconstant, d, e)
	if f then
		return g
	end
end
local d = false
local function fireInventoryChanged()
	if d then
		return
	end
	d = true
	task.spawn(function()
		task.wait()
		b.InventoryChanged:Fire()
		d = false
	end)
end
local e, f, g, h, i, j, k, l, m, n, o, p, q, r, s = c(game:GetService'Players'), c(game:GetService'ReplicatedStorage'), c(game:GetService'RunService'), c(game:GetService'UserInputService'), c(game:GetService'TweenService'), c(game:GetService'HttpService'), c(game:GetService'TextChatService'), c(game:GetService'CollectionService'), c(game:GetService'ContextActionService'), c(game:GetService'GuiService'), c(game:GetService'CoreGui'), c(game:GetService'StarterGui'), game:GetService'VirtualInputManager', identifyexecutor and table.find({
	'AWP',
	'Nihon'
}, ({
	identifyexecutor()
})[1]) and isnetworkowner or function()
	return true
end, workspace.CurrentCamera
local t, u, v = e.LocalPlayer, getcustomasset, shared.vape
if v and not v.Clean then
	v.Clean = function(w, x)
		if v.Connections then
			table.insert(v.Connections, x)
		end
		return x
	end
end
if v and not v.Remove then
	v.Remove = function()
	end
end
local w, x, y, z, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q = nil, nil, nil, nil, nil, v.Libraries.entity, v.Libraries.targetinfo, v.Libraries.sessioninfo, v.Libraries.uipallet, v.Libraries.tween, v.Libraries.color, v.Libraries.whitelist, v.Libraries.prediction, v.Libraries.getfontsize, v.Libraries.getcustomasset, {
	attackReach = 0,
	attackReachUpdate = tick(),
	damageBlockFail = tick(),
	hand = {},
	inventory = {
		inventory = {
			items = {},
			armor = {}
		},
		hotbar = {}
	},
	inventories = setmetatable({}, {
		__mode = 'k'
	}),
	matchState = 0,
	queueType = 'bedwars_test',
	tools = {},
	lastToolUpdate = 0
}, {}, {}, {}, {}, {}
local function addBlur(R)
	local S = Instance.new'ImageLabel'
	S.Name = 'Blur'
	S.Size = UDim2.new(1, 89, 1, 52)
	S.Position = UDim2.fromOffset(- 48, - 31)
	S.BackgroundTransparency = 1
	S.Image = K'newvape/assets/new/blur.png'
	S.ScaleType = Enum.ScaleType.Slice
	S.SliceCenter = Rect.new(52, 31, 261, 502)
	S.Parent = R
	return S
end
local function safeCall(R)
	if typeof(R) ~= 'function' then
		return
	end
	xpcall(function()
		R()
	end, function(S)
		warn(S)
	end)
end
local function collection(R, S, T, U)
	R = typeof(R) ~= 'table' and {
		R
	} or R
	local V, W = {}, {}
	for X, Y in R do
		table.insert(W, l:GetInstanceAddedSignal(Y):Connect(function(Z)
			if T then
				T(V, Z, Y)
				return
			end
			table.insert(V, Z)
		end))
		table.insert(W, l:GetInstanceRemovedSignal(Y):Connect(function(Z)
			if U then
				U(V, Z, Y)
				return
			end
			Z = table.find(V, Z)
			if Z then
				table.remove(V, Z)
			end
		end))
		for Z, _ in l:GetTagged(Y) do
			if T then
				T(V, _, Y)
				continue
			end
			table.insert(V, _)
		end
	end
	local X = function(X)
		for Y, Z in W do
			Z:Disconnect()
		end
		table.clear(W)
		table.clear(V)
		table.clear(X)
	end
	if S then
		S:Clean(X)
	end
	return V, X
end
local function getBestArmor(R)
	local S, T = 0
	for U, V in L.inventory.inventory.items do
		local W = V and O.ItemMeta[V.itemType] or {}
		if W.armor and W.armor.slot == R then
			local X = (W.armor.damageReductionMultiplier or 0)
			if X > S then
				T, S = V, X
			end
		end
	end
	return T
end
local function getBow()
	local R, S, T = 0
	for U, V in L.inventory.inventory.items do
		local W = O.ItemMeta[V.itemType].projectileSource
		if W and table.find(W.ammoItemTypes, 'arrow') then
			local X = O.ProjectileMeta[W.projectileType'arrow'].combat.damage or 0
			if X > R then
				S, T, R = V, U, X
			end
		end
	end
	return S, T
end
local function getItem(R, S)
	for T, U in (S or L.inventory.inventory.items) do
		if U.itemType == R then
			return U, T
		end
	end
	return nil
end
local function getRoactRender(R)
	return debug.getupvalue(debug.getupvalue(debug.getupvalue(R, 3).render, 2).render, 1)
end
local function getSword()
	local R, S, T = 0
	for U, V in L.inventory.inventory.items do
		local W = O.ItemMeta[V.itemType].sword
		if W then
			local X = W.damage or 0
			if X > R then
				S, T, R = V, U, X
			end
		end
	end
	return S, T
end
local function getTool(R)
	local S, T, U = 0
	for V, W in L.inventory.inventory.items do
		local X = O.ItemMeta[W.itemType].breakBlock
		if X then
			local Y = X[R] or 0
			if Y > S then
				T, U, S = W, V, Y
			end
		end
	end
	return T, U
end
local function getWool()
	for R, S in L.inventory.inventory.items do
		if S.itemType:find'wool' then
			return S and S.itemType, S and S.amount
		end
	end
end
local function getStrength(R)
	if not R or not R.Player then
		return 0
	end
	local S = 0
	for T, U in (L.inventories[R.Player] or {
		items = {}
	}).items do
		local V = O.ItemMeta[U.itemType]
		if V and V.sword and V.sword.damage > S then
			S = V.sword.damage
		end
	end
	return S
end
local function getPlacedBlock(R)
	if not R then
		return
	end
	local S = O.BlockController:getBlockPosition(R)
	return O.BlockController:getStore():getBlockAt(S), S
end
local function getBlocksInPoints(R, S)
	local T, U = O.BlockController:getStore(), {}
	for V = R.X, S.X do
		for W = R.Y, S.Y do
			for X = R.Z, S.Z do
				local Y = Vector3.new(V, W, X)
				if T:getBlockAt(Y) then
					table.insert(U, Y * 3)
				end
			end
		end
	end
	return U
end
local function getNearGround(R)
	R = Vector3.new(3, 3, 3) * (R or 10)
	local S, T, U = B.character.RootPart.Position, 60
	local V = getBlocksInPoints(O.BlockController:getBlockPosition(S - R), O.BlockController:getBlockPosition(S + R))
	for W, X in V do
		if not getPlacedBlock(X + Vector3.new(0, 3, 0)) then
			local Y = (S - X).Magnitude
			if Y < T then
				T, U = Y, X + Vector3.new(0, 3, 0)
			end
		end
	end
	table.clear(V)
	return U
end
local function getShieldAttribute(R)
	local S = 0
	for T, U in R:GetAttributes() do
		if T:find'Shield' and type(U) == 'number' and U > 0 then
			S += U
		end
	end
	return S
end
local function getSpeed()
	local R, S, T = 0, true, O.SprintController:getMovementStatusModifier():getModifiers()
	for U in T do
		local V = U.constantSpeedMultiplier and U.constantSpeedMultiplier or 0
		if V and V > math.max(R, 1) then
			S = false
			R = V - (0.06 * math.round(V))
		end
	end
	for U in T do
		R += math.max((U.moveSpeedMultiplier or 0) - 1, 0)
	end
	if R > 0 and S then
		R += 0.16 + (0.02 * math.round(R))
	end
	return 20 * (R + 1)
end
local function getTableSize(R)
	local S = 0
	for T in R do
		S += 1
	end
	return S
end
local function hotbarSwitch(R)
	if R and L.inventory.hotbarSlot ~= R then
		O.Store:dispatch{
			type = 'InventorySelectHotbarSlot',
			slot = R
		}
		b.InventoryChanged.Event:Wait()
		return true
	end
	return false
end
local function isFriend(R, S)
	if v.Categories.Friends.Options['Use friends'].Enabled then
		local T = table.find(v.Categories.Friends.ListEnabled, R.Name) and true
		if S then
			T = T and v.Categories.Friends.Options['Recolor visuals'].Enabled
		end
		return T
	end
	return nil
end
local function isTarget(R)
	return table.find(v.Categories.Targets.ListEnabled, R.Name) and true
end
local function notif(...)
	return v:CreateNotification(...)
end
local function removeTags(R)
	R = R:gsub('<br%s*/>', '\n')
	return (R:gsub('<[^<>]->', ''))
end
local function roundPos(R)
	return Vector3.new(math.round(R.X / 3) * 3, math.round(R.Y / 3) * 3, math.round(R.Z / 3) * 3)
end
local function switchItem(R, S)
	S = S or 0.05
	local T = t.Character and t.Character:FindFirstChild'HandInvItem' or nil
	if T and T.Value ~= R and R.Parent ~= nil then
		task.spawn(function()
			O.Client:Get(P.EquipItem):CallServerAsync{
				hand = R
			}
		end)
		T.Value = R
		if S > 0 then
			task.wait(S)
		end
		return true
	end
end
local function waitForChildOfType(R, S, T, U)
	local V, W = tick() + T
	repeat
		W = U and R[S] or R:FindFirstChildOfClass(S)
		if W and W.Name ~= 'UpperTorso' or V < tick() then
			break
		end
		task.wait()
	until false
	return W
end
local R, S, T, U = {}, {}
local function modifyVelocity(V)
	if V:IsA'BasePart' and V.Name ~= 'HumanoidRootPart' and not S[V] then
		S[V] = V.CustomPhysicalProperties or 'none'
		V.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0.2, 0.5, 1, 1)
	end
end
local function updateVelocity(V)
	local W = getTableSize(R) > 0
	if U ~= W or V then
		if T then
			T:Disconnect()
		end
		if W then
			if B.isAlive then
				for X, Y in B.character.Character:GetDescendants() do
					modifyVelocity(Y)
				end
				T = B.character.Character.DescendantAdded:Connect(modifyVelocity)
			end
		else
			for X, Y in S do
				X.CustomPhysicalProperties = Y ~= 'none' and Y or nil
			end
			table.clear(S)
		end
	end
	U = W
end
local function isEveryoneDead()
	return # O.Store:getState().Party.members <= 0
end
local V = {
	hannah = 5,
	spirit_assassin = 4,
	dasher = 3,
	jade = 2,
	regent = 1
}
local function HasSeed(W)
	if not W then
		return false
	end
	return W:FindFirstChild('Seed', true) ~= nil
end
local aa = {
	Damage = function(W, X)
		if not W.Entity or not W.Entity.Character then
			return false
		end
		if not X.Entity or not X.Entity.Character then
			return true
		end
		return W.Entity.Character:GetAttribute'LastDamageTakenTime' < X.Entity.Character:GetAttribute'LastDamageTakenTime'
	end,
	Threat = function(W, X)
		if not W.Entity then
			return false
		end
		if not X.Entity then
			return true
		end
		return getStrength(W.Entity) > getStrength(X.Entity)
	end,
	Kit = function(W, X)
		return (W.Entity.Player and V[W.Entity.Player:GetAttribute'PlayingAsKit'] or 0) > (X.Entity.Player and V[X.Entity.Player:GetAttribute'PlayingAsKit'] or 0)
	end,
	Health = function(W, X)
		return W.Entity.Health < X.Entity.Health
	end,
	Angle = function(W, X)
		if not W.Entity or not W.Entity.RootPart then
			return false
		end
		if not X.Entity or not X.Entity.RootPart then
			return true
		end
		local Y, Z = B.character.RootPart.Position, B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
		local _, aa = math.acos(Z:Dot(((W.Entity.RootPart.Position - Y) * Vector3.new(1, 0, 1)).Unit)), math.acos(Z:Dot(((X.Entity.RootPart.Position - Y) * Vector3.new(1, 0, 1)).Unit))
		return _ < aa
	end,
	Distance = function(aa, W)
		if not aa.Entity or not aa.Entity.RootPart then
			return false
		end
		if not W.Entity or not W.Entity.RootPart then
			return true
		end
		local X = B.character.RootPart.Position
		local Y, Z = (aa.Entity.RootPart.Position - X).Magnitude, (W.Entity.RootPart.Position - X).Magnitude
		return Y < Z
	end,
	Cursor = function(aa, W)
		if not aa.Entity or not aa.Entity.RootPart then
			return false
		end
		if not W.Entity or not W.Entity.RootPart then
			return true
		end
		local X, Y = workspace.CurrentCamera, game:GetService'UserInputService':GetMouseLocation()
		local function screenDist(Z)
			local _, ab = X:WorldToScreenPoint(Z.RootPart.Position)
			if not ab then
				return math.huge
			end
			return (Vector2.new(_.X, _.Y) - Y).Magnitude
		end
		return screenDist(aa.Entity) < screenDist(W.Entity)
	end,
	Forest = function(aa, ab)
		if not aa.Entity then
			return false
		end
		if not ab.Entity then
			return true
		end
		local W, X = HasSeed(aa.Entity.Character), HasSeed(ab.Entity.Character)
		if W and not X then
			return true
		end
		if not W and X then
			return false
		end
		if not aa.Entity.RootPart then
			return false
		end
		if not ab.Entity.RootPart then
			return true
		end
		local Y = B.character.RootPart.Position
		local Z, _ = (aa.Entity.RootPart.Position - Y).Magnitude, (ab.Entity.RootPart.Position - Y).Magnitude
		return Z < _
	end
}
a(function()
	local ab = B.start
	B.start = function()
		if B.Running then
			B.stop()
		end
		ab()
		table.insert(B.Connections, e.PlayerAdded:Connect(function(W)
			B.addPlayer(W)
		end))
		table.insert(B.Connections, e.PlayerRemoving:Connect(function(W)
			B.removePlayer(W)
		end))
		for W, X in e:GetPlayers() do
			B.addPlayer(X)
		end
		local function customEntity(W)
			if e:GetPlayerFromCharacter(W) then
				return
			end
			local X = function(X)
				local Y = X.Character:GetAttribute'Team'
				return t:GetAttribute'Team' ~= Y
			end
			B.addEntity(W, nil, X)
		end
		for W, X in l:GetTagged'entity' do
			customEntity(X)
		end
		table.insert(B.Connections, l:GetInstanceAddedSignal'entity':Connect(customEntity))
		table.insert(B.Connections, l:GetInstanceRemovedSignal'entity':Connect(function(W)
			B.removeEntity(W)
		end))
		table.insert(B.Connections, workspace:GetPropertyChangedSignal'CurrentCamera':Connect(function()
			s = workspace.CurrentCamera or workspace:FindFirstChildWhichIsA'Camera'
		end))
		B.Running = true
	end
	B.addPlayer = function(W)
		if B.PlayerConnections[W] then
			for X, Y in ipairs(B.PlayerConnections[W]) do
				if Y and typeof(Y) == 'RBXScriptConnection' then
					Y:Disconnect()
				end
			end
		end
		if W.Character then
			B.refreshEntity(W.Character, W)
		end
		B.PlayerConnections[W] = {
			W.CharacterAdded:Connect(function(X)
				B.refreshEntity(X, W)
			end),
			W.CharacterRemoving:Connect(function(X)
				B.removeEntity(X, W == t)
			end),
			W:GetAttributeChangedSignal'Team':Connect(function()
				for X, Y in B.List do
					if Y.Targetable ~= B.targetCheck(Y) then
						B.refreshEntity(Y.Character, Y.Player)
					end
				end
				if W == t then
					B.start()
				else
					B.refreshEntity(W.Character, W)
				end
			end)
		}
	end
	B.addEntity = function(W, X, Y)
		if not W then
			return
		end
		B.EntityThreads[W] = task.spawn(function()
			local Z, _, ac
			if X then
				Z = waitForChildOfType(W, 'Humanoid', 10)
				_ = Z and waitForChildOfType(Z, 'RootPart', workspace.StreamingEnabled and 9e9 or 10, true)
				ac = W:WaitForChild('Head', 10) or _
			else
				Z = {
					HipHeight = 0.5
				}
				_ = waitForChildOfType(W, 'PrimaryPart', 10, true)
				ac = _
			end
			local ad = X and X ~= t and {
				W:WaitForChild('ArmorInvItem_0', 5),
				W:WaitForChild('ArmorInvItem_1', 5),
				W:WaitForChild('ArmorInvItem_2', 5),
				W:WaitForChild('HandInvItem', 5)
			} or {}
			if Z and _ then
				local ae = {
					Connections = {},
					Character = W,
					Health = (function()
						local ae, af = W:GetAttribute'Health' or 100, 0
						for ag, ah in pairs(W:GetAttributes()) do
							if type(ag) == 'string' and ag:sub(1, 7) == 'Shield_' and type(ah) == 'number' and ah > 0 then
								af = af + ah
							end
						end
						return ae + af
					end)(),
					Head = ac,
					Humanoid = Z,
					HumanoidRootPart = _,
					HipHeight = Z.HipHeight + (_.Size.Y / 2) + (Z.RigType == Enum.HumanoidRigType.R6 and 2 or 0),
					Jumps = 0,
					JumpTick = tick(),
					Jumping = false,
					LandTick = tick(),
					MaxHealth = W:GetAttribute'MaxHealth' or 100,
					NPC = X == nil,
					Player = X,
					RootPart = _,
					TeamCheck = Y
				}
				if X == t then
					ae.AirTime = tick()
					B.character = ae
					B.isAlive = true
					B.Events.LocalAdded:Fire(ae)
					table.insert(B.Connections, W.AttributeChanged:Connect(function(af)
						b.AttributeChanged:Fire(af)
					end))
				else
					ae.Targetable = B.targetCheck(ae)
					if not X then
						table.insert(ae.Connections, W.AttributeChanged:Connect(function(af)
							if af == 'Team' then
								ae.Targetable = B.targetCheck(ae)
								B.Events.EntityUpdated:Fire(ae)
							end
						end))
					end
					for af, ag in B.getUpdateConnections(ae) do
						table.insert(ae.Connections, ag:Connect(function()
							ae.Health = (W:GetAttribute'Health' or 100) + getShieldAttribute(W)
							ae.MaxHealth = W:GetAttribute'MaxHealth' or 100
							B.Events.EntityUpdated:Fire(ae)
						end))
					end
					local af = {}
					for ag, ah in ad do
						table.insert(ae.Connections, ah:GetPropertyChangedSignal'Value':Connect(function()
							if af[ae] then
								return
							end
							af[ae] = true
							task.delay(0.1, function()
								af[ae] = nil
								if O.getInventory then
									L.inventories[X] = O.getInventory(X)
									B.Events.EntityUpdated:Fire(ae)
								end
							end)
						end))
					end
					if X then
						local ag = W:FindFirstChild'Animate'
						if ag then
							pcall(function()
								ag = ag.jump:FindFirstChildWhichIsA'Animation'.AnimationId
								table.insert(ae.Connections, Z.Animator.AnimationPlayed:Connect(function(ah)
									if ah.Animation.AnimationId == ag then
										ae.JumpTick = tick()
										ae.Jumps += 1
										ae.LandTick = tick() + 1
										ae.Jumping = ae.Jumps > 1
									end
								end))
							end)
						end
						task.delay(0.1, function()
							if O.getInventory then
								L.inventories[X] = O.getInventory(X)
							end
						end)
					end
					table.insert(B.List, ae)
					B.Events.EntityAdded:Fire(ae)
				end
				table.insert(ae.Connections, W.ChildRemoved:Connect(function(af)
					if af == _ or af == Z or af == ac then
						if af == _ and Z.RootPart then
							_ = Z.RootPart
							ae.RootPart = Z.RootPart
							ae.HumanoidRootPart = Z.RootPart
							return
						end
						B.removeEntity(W, X == t)
					end
				end))
			end
			B.EntityThreads[W] = nil
		end)
	end
	B.getUpdateConnections = function(ac)
		local ad = ac.Character
		local ae = {
			ad:GetAttributeChangedSignal'Health',
			ad:GetAttributeChangedSignal'MaxHealth',
			{
				Connect = function()
					ac.Friend = ac.Player and isFriend(ac.Player) or nil
					ac.Target = ac.Player and isTarget(ac.Player) or nil
					return {
						Disconnect = function()
						end
					}
				end
			}
		}
		if ac.Player then
			table.insert(ae, ac.Player:GetAttributeChangedSignal'PlayingAsKit')
		end
		for af, ag in ad:GetAttributes() do
			if af:find'Shield' and type(ag) == 'number' then
				table.insert(ae, ad:GetAttributeChangedSignal(af))
			end
		end
		return ae
	end
	B.targetCheck = function(ac)
		if ac.TeamCheck then
			return ac:TeamCheck()
		end
		if ac.NPC then
			local ad = ac.Character and ac.Character:GetAttribute'Team'
			return t:GetAttribute'Team' ~= ad
		end
		if isFriend(ac.Player) then
			return false
		end
		if not select(2, H:get(ac.Player)) then
			return false
		end
		return t:GetAttribute'Team' ~= ac.Player:GetAttribute'Team'
	end
	v:Clean(B.Events.LocalAdded:Connect(updateVelocity))
end)
B.start()
a(function()
	local ab, ac
	repeat
		ab, ac = pcall(function()
			return debug.getupvalue(require(t.PlayerScripts.TS.knit).setup, 9)
		end)
		if ab then
			break
		end
		task.wait()
	until ab
	if not debug.getupvalue(ac.Start, 1) then
		repeat
			task.wait()
		until debug.getupvalue(ac.Start, 1)
	end
	local ad, ae, af = require(f.rbxts_include.node_modules['@flamework'].core.out).Flamework, require(f.TS.inventory['inventory-util']).InventoryUtil, require(f.TS.remotes).default.Client
	local ag, ah = af.Get
	O = setmetatable({
		RankMeta = require(f.TS.rank['rank-meta']).RankMeta,
		BalanceFile = require(f.TS.balance['balance-file']).BalanceFile,
		ClientSyncEvents = require(t.PlayerScripts.TS['client-sync-events']).ClientSyncEvents,
		SyncEventPriority = require(f.rbxts_include.node_modules['@easy-games']['sync-event'].out),
		AbilityId = require(f.TS.ability['ability-id']).AbilityId,
		IdUtil = require(f.TS.util['id-util']).IdUtil,
		BlockSelector = require(game:GetService'ReplicatedStorage'.rbxts_include.node_modules['@easy-games']['block-engine'].out.client.select['block-selector']).BlockSelector,
		KnockbackUtilInstance = f.TS.damage['knockback-util'],
		BedwarsKitSkin = require(f.TS.games.bedwars['kit-skin']['bedwars-kit-skin-meta']).BedwarsKitSkinMeta,
		KitController = ac.Controllers.KitController,
		FishermanUtil = require(f.TS.games.bedwars.kit.kits.fisherman['fisherman-util']).FishermanUtil,
		FishMeta = require(f.TS.games.bedwars.kit.kits.fisherman['fish-meta']),
		MatchHistroyApp = require(t.PlayerScripts.TS.controllers.global['match-history'].ui['match-history-moderation-app']).MatchHistoryModerationApp,
		MatchHistroyController = ac.Controllers.MatchHistoryController,
		BlockEngine = require(game:GetService'ReplicatedStorage'.rbxts_include.node_modules['@easy-games']['block-engine'].out).BlockEngine,
		BlockSelectorMode = require(game:GetService'ReplicatedStorage'.rbxts_include.node_modules['@easy-games']['block-engine'].out.client.select['block-selector']).BlockSelectorMode,
		EntityUtil = require(game:GetService'ReplicatedStorage'.TS.entity['entity-util']).EntityUtil,
		GamePlayer = require(f.TS.player['game-player']),
		OfflinePlayerUtil = require(f.TS.player['offline-player-util']),
		PlayerUtil = require(f.TS.player['player-util']),
		KKKnitController = require(t.PlayerScripts.TS.lib.knit['knit-controller']),
		AbilityController = ad.resolveDependency'@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController',
		CooldownController = ad.resolveDependency'@easy-games/game-core:client/controllers/cooldown/cooldown-controller@CooldownController',
		AnimationType = require(f.TS.animation['animation-type']).AnimationType,
		AnimationUtil = require(f.rbxts_include.node_modules['@easy-games']['game-core'].out.shared.util['animation-util']).AnimationUtil,
		AppController = require(f.rbxts_include.node_modules['@easy-games']['game-core'].out.client.controllers['app-controller']).AppController,
		BedBreakEffectMeta = require(f.TS.locker['bed-break-effect']['bed-break-effect-meta']).BedBreakEffectMeta,
		BedwarsKitMeta = require(f.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta,
		BlockBreaker = ac.Controllers.BlockBreakController.blockBreaker,
		BlockController = require(f.rbxts_include.node_modules['@easy-games']['block-engine'].out).BlockEngine,
		BlockEngine = require(t.PlayerScripts.TS.lib['block-engine']['client-block-engine']).ClientBlockEngine,
		BlockPlacer = require(f.rbxts_include.node_modules['@easy-games']['block-engine'].out.client.placement['block-placer']).BlockPlacer,
		BowConstantsTable = (ac.Controllers.ProjectileController and ac.Controllers.ProjectileController.enableBeam) and debug.getupvalue(ac.Controllers.ProjectileController.enableBeam, 8) or {},
		ClickHold = require(f.rbxts_include.node_modules['@easy-games']['game-core'].out.client.ui.lib.util['click-hold']).ClickHold,
		Client = af,
		ClientConstructor = require(f.rbxts_include.node_modules['@rbxts'].net.out.client),
		ClientDamageBlock = require(f.rbxts_include.node_modules['@easy-games']['block-engine'].out.shared.remotes).BlockEngineRemotes.Client,
		CombatConstant = require(f.TS.combat['combat-constant']).CombatConstant,
		SharedConstants = require(f.TS['shared-constants']),
		DamageIndicator = ac.Controllers.DamageIndicatorController.spawnDamageIndicator,
		DefaultKillEffect = require(t.PlayerScripts.TS.controllers.global.locker['kill-effect'].effects['default-kill-effect']),
		EmoteType = require(f.TS.locker.emote['emote-type']).EmoteType,
		GameAnimationUtil = require(f.TS.animation['animation-util']).GameAnimationUtil,
		NotificationController = ad.resolveDependency'@easy-games/game-core:client/controllers/notification-controller@NotificationController',
		getIcon = function(W, X)
			local Y = O.ItemMeta[W.itemType]
			return Y and X and Y.image or ''
		end,
		getInventory = function(W)
			local X, Y = pcall(function()
				return ae.getInventory(W)
			end)
			return X and Y or {
				items = {},
				armor = {}
			}
		end,
		MatchHistoryController = require(t.PlayerScripts.TS.controllers.global['match-history']['match-history-controller']),
		PlayerProfileUIController = require(t.PlayerScripts.TS.controllers.global['player-profile']['player-profile-ui-controller']),
		HudAliveCount = require(t.PlayerScripts.TS.controllers.global['top-bar'].ui.game['hud-alive-player-counts']).HudAlivePlayerCounts,
		ItemMeta = debug.getupvalue(require(f.TS.item['item-meta']).getItemMeta, 1),
		KillEffectMeta = require(f.TS.locker['kill-effect']['kill-effect-meta']).KillEffectMeta,
		KillFeedController = ad.resolveDependency'client/controllers/game/kill-feed/kill-feed-controller@KillFeedController',
		Knit = ac,
		KnockbackUtil = require(f.TS.damage['knockback-util']).KnockbackUtil,
		MageKitUtil = require(f.TS.games.bedwars.kit.kits.mage['mage-kit-util']).MageKitUtil,
		NametagController = ac.Controllers.NametagController,
		PartyController = ad.resolveDependency'@easy-games/lobby:client/controllers/party-controller@PartyController',
		ProjectileMeta = require(f.TS.projectile['projectile-meta']).ProjectileMeta,
		QueryUtil = require(f.rbxts_include.node_modules['@easy-games']['game-core'].out).GameQueryUtil,
		QueueCard = require(t.PlayerScripts.TS.controllers.global.queue.ui['queue-card']).QueueCard,
		QueueMeta = require(f.TS.game['queue-meta']).QueueMeta,
		Roact = require(f.rbxts_include.node_modules['@rbxts'].roact.src),
		RuntimeLib = require(f.rbxts_include.RuntimeLib),
		SoundList = require(f.TS.sound['game-sound']).GameSound,
		SoundManager = require(f.rbxts_include.node_modules['@easy-games']['game-core'].out.shared.sound['sound-manager']).SoundManager,
		Store = require(t.PlayerScripts.TS.ui.store).ClientStore,
		TeamUpgradeMeta = debug.getupvalue(require(f.TS.games.bedwars['team-upgrade']['team-upgrade-meta']).getTeamUpgradeMetaForQueue, 6),
		UILayers = require(f.rbxts_include.node_modules['@easy-games']['game-core'].out).UILayers,
		VisualizerUtils = require(t.PlayerScripts.TS.lib.visualizer['visualizer-utils']).VisualizerUtils,
		WeldTable = require(f.TS.util['weld-util']).WeldUtil,
		WinEffectMeta = require(f.TS.locker['win-effect']['win-effect-meta']).WinEffectMeta,
		ZapNetworking = require(t.PlayerScripts.TS.lib.network)
	}, {
		__index = function(W, X)
			rawset(W, X, ac.Controllers[X])
			return rawget(W, X)
		end
	})
	local W = {
		AfkStatus = safeGetProto(ac.Controllers.AfkController.KnitStart, 1),
		AttackEntity = ac.Controllers.SwordController.sendServerRequest,
		BeePickup = ac.Controllers.BeeNetController.trigger,
		CannonAim = safeGetProto(ac.Controllers.CannonController.startAiming, 5),
		CannonLaunch = ac.Controllers.CannonHandController.launchSelf,
		ConsumeBattery = safeGetProto(ac.Controllers.BatteryController.onKitLocalActivated, 1),
		ConsumeItem = safeGetProto(ac.Controllers.ConsumeController.onEnable, 1),
		ConsumeSoul = ac.Controllers.GrimReaperController.consumeSoul,
		ConsumeTreeOrb = safeGetProto(ac.Controllers.EldertreeController.createTreeOrbInteraction, 1),
		DepositPinata = safeGetProto(safeGetProto(ac.Controllers.PiggyBankController.KnitStart, 2), 5),
		DragonBreath = safeGetProto(ac.Controllers.VoidDragonController.onKitLocalActivated, 5),
		DragonEndFly = safeGetProto(ac.Controllers.VoidDragonController.flapWings, 1),
		DragonFly = ac.Controllers.VoidDragonController.flapWings,
		DropItem = ac.Controllers.ItemDropController.dropItemInHand,
		EquipItem = safeGetProto(require(f.TS.entity.entities['inventory-entity']).InventoryEntity.equipItem, 3),
		FireProjectile = debug.getupvalue(ac.Controllers.ProjectileController.launchProjectileWithValues, 2),
		GroundHit = ac.Controllers.FallDamageController.KnitStart,
		GuitarHeal = ac.Controllers.GuitarController.performHeal,
		HannahKill = safeGetProto(ac.Controllers.HannahController.registerExecuteInteractions, 1),
		HarvestCrop = safeGetProto(safeGetProto(ac.Controllers.CropController.KnitStart, 4), 1),
		KaliyahPunch = safeGetProto(ac.Controllers.DragonSlayerController.onKitLocalActivated, 1),
		MageSelect = safeGetProto(ac.Controllers.MageController.registerTomeInteraction, 1),
		MinerDig = safeGetProto(ac.Controllers.MinerController.setupMinerPrompts, 1),
		PickupItem = ac.Controllers.ItemDropController.checkForPickup,
		PickupMetal = safeGetProto(ac.Controllers.HiddenMetalController.onKitLocalActivated, 4),
		ReportPlayer = require(t.PlayerScripts.TS.controllers.global.report['report-controller']).default.reportPlayer,
		ResetCharacter = safeGetProto(ac.Controllers.ResetController.createBindable, 1),
		SummonerClawAttack = ac.Controllers.SummonerClawHandController.attack,
		WarlockTarget = safeGetProto(ac.Controllers.WarlockStaffController.KnitStart, 2)
	}
	local function dumpRemote(X)
		local Y
		for Z, _ in X do
			if _ == 'Client' then
				Y = Z
				break
			end
		end
		return Y and X[Y + 1] or ''
	end
	local X = {
		EquipItem = 'SetInvItem',
		ActivateGravestone = 'ActivateGravestone',
		CollectCollectableEntity = 'CollectCollectableEntity',
		DefenderRequestPlaceBlock = 'DefenderRequestPlaceBlock',
		RequestDragonPunch = 'RequestDragonPunch',
		Harvest = 'CropHarvest',
		DepositCoins = 'DepositCoins',
		BedwarsPurchaseItem = 'BedwarsPurchaseItem',
		BedBreakEffectTriggered = 'BedBreakEffectTriggered',
		BloodAssassinSelectContract = 'BloodAssassinSelectContract',
		MimicBlock = 'MimicBlock',
		TeleportToLobby = 'TeletoLobby',
		FishCaught = 'FishCaught',
		SpawnRaven = 'SpawnRaven',
		PaladinAbilityRequest = 'PaladinAbilityRequest',
		OwlActionAbilities = 'OwlActionAbilities',
		DrillAttack = 'DrillAttack',
		UpgradeFrostyHammer = 'UpgradeFrostyHammer',
		UpgradeFlamethrower = 'UpgradeFlamethrower',
		TryBlockKick = 'TryBlockKick',
		Ranks = 'FetchRanks',
		ResearchEnchant = 'EnchantTableResearch',
		DropDroneItem = 'DropDroneItem',
		AttemptFireOasisProjectiles = 'AttemptFireOasisProjectiles',
		WinEffectTriggered = 'WinEffectTriggered',
		ExtractFromDrill = 'ExtractFromDrill',
		HannahPromptTrigger = 'HannahPromptTrigger',
		DragonFlap = 'DragonFlap',
		DragonBreath = 'DragonBreath',
		AttemptCardThrow = 'AttemptCardThrow',
		LearnElementTome = 'LearnElementTome',
		RequestMoveSlime = 'RequestMoveSlime',
		SummonOwl = 'SummonOwl',
		RemoveOwl = 'RemoveOwl',
		MimicBlockPickPocketPlayer = 'MimicBlockPickPocketPlayer',
		DestroyPetrifiedPlayer = 'DestroyPetrifiedPlayer',
		UseAbility = 'useAbility'
	}
	for Y, Z in pairs(X) do
		if not P[Y] then
			P[Y] = Z
		end
	end
	for Y, Z in W do
		local _
		if type(Z) == 'string' then
			_ = Z
		elseif type(Z) == 'function' then
			local ai = debug.getconstants(Z)
			_ = dumpRemote(ai)
		else
			_ = ''
		end
		if _ == '' or _ == nil then
			if not X[Y] then
				notif('Vape', 'Failed to grab remote (' .. tostring(Y) .. ')', 10, 'alert')
			end
			_ = X[Y] or ''
		end
		P[Y] = _
	end
	ah = O.BlockController.isBlockBreakable
	af.Get = function(ai, Y)
		local Z = ag(ai, Y)
		if Y == P.AttackEntity then
			return {
				instance = Z.instance,
				SendToServer = function(_, aj, ...)
					local ak, al = pcall(function()
						return e:GetPlayerFromCharacter(aj.entityInstance)
					end)
					local am, an = aj.validate.selfPosition.value, aj.validate.targetPosition.value
					L.attackReach = ((am - an).Magnitude * 100) // 1 / 100
					L.attackReachUpdate = tick() + 1
					if M.Enabled or N.Enabled then
						aj.validate.raycast = aj.validate.raycast or {}
						aj.validate.selfPosition.value += CFrame.lookAt(am, an).LookVector * math.max((am - an).Magnitude - 14.399, 0)
					end
					if ak and al then
						if not select(2, H:get(al)) then
							return
						end
					end
					return Z:SendToServer(aj, ...)
				end
			}
		elseif Y == 'StepOnSnapTrap' and y.Enabled then
			return {
				SendToServer = function()
				end
			}
		end
		return Z
	end
	O.BlockController.isBlockBreakable = function(ai, aj, ak)
		local al = O.BlockController:getStore():getBlockAt(aj.blockPosition)
		if al and al.Name == 'bed' then
			for am, an in e:GetPlayers() do
				if al:GetAttribute('Team' .. (an:GetAttribute'Team' or 0) .. 'NoBreak') and not select(2, H:get(an)) then
					return false
				end
			end
		end
		return ah(ai, aj, ak)
	end
	local ai, aj = {}, {
		blockHealth = - 1,
		breakingBlockPosition = Vector3.zero
	}
	task.spawn(function()
		while v.Loaded do
			task.wait(60)
			table.clear(ai)
		end
	end)
	L.blockPlacer = O.BlockPlacer.new(O.BlockEngine, 'wool_white')
	local function getBlockHealth(ak, al)
		local am = O.BlockController:getStore():getBlockData(al)
		return (am and (am:GetAttribute'1' or am:GetAttribute'Health') or ak:GetAttribute'Health')
	end
	local function getBlockHits(ak, al)
		if not ak then
			return 0
		end
		local am = O.ItemMeta[ak.Name].block.breakType
		local an = L.tools[am]
		an = an and O.ItemMeta[an.itemType].breakBlock[am] or 2
		return getBlockHealth(ak, O.BlockController:getBlockPosition(al)) / an
	end
	local function calculatePath(ak, al)
		if ai[al] then
			return unpack(ai[al])
		end
		local am, an, Y, Z, _ = {}, {
			{
				0,
				al
			}
		}, {
			[al] = 0
		}, {}, {}
		for ao = 1, 10000 do
			local ap, aq = next(an)
			if not aq then
				break
			end
			table.remove(an, 1)
			am[aq[2] ] = true
			for ar, as in Q do
				as = aq[2] + as
				if am[as] then
					continue
				end
				local at = getPlacedBlock(as)
				if not at or at:GetAttribute'NoBreak' or at == ak then
					if not at then
						Z[aq[2] ] = true
					end
					continue
				end
				local au = getBlockHits(at, as) + aq[1]
				if au < (Y[as] or math.huge) then
					table.insert(an, {
						au,
						as
					})
					Y[as] = au
					_[as] = aq[2]
				end
			end
		end
		local ao, ap = (math.huge)
		for aq in Z do
			if Y[aq] < ao then
				ap, ao = aq, Y[aq]
			end
		end
		if ap then
			local aq = {
				ap,
				ao,
				_,
				timestamp = tick()
			}
			ai[al] = aq
			return ap, ao, _
		end
	end
	O.placeBlock = function(ak, al)
		if getItem(al) then
			L.blockPlacer.blockType = al
			return L.blockPlacer:placeBlock(O.BlockController:getBlockPosition(ak))
		end
	end
	O.breakBlock = function(ak, al, am, an, ao, ap, aq)
		if t:GetAttribute'DenyBlockBreak' or not B.isAlive then
			return
		end
		local ar, as, at, au, Y = O.BlockController:getHandlerRegistry():getHandler(ak.Name), math.huge
		local Z, _ = 9e9, (ar and ar:getContainedPositions(ak) or {
			ak.Position / 3
		})
		for av, aw in _ do
			local ax, ay, az = calculatePath(ak, aw * 3)
			local aA = ax and (B.character.RootPart.Position - ax).Magnitude
			if ax and ay < as and aA < Z then
				as, at, au, Y, Z = ay, ax, aw * 3, az, aA
			end
		end
		if at then
			if (B.character.RootPart.Position - at).Magnitude > 30 then
				return
			end
			local av, aw = getPlacedBlock(at)
			if not av then
				return
			end
			if not aq and (workspace:GetServerTimeNow() - O.SwordController.lastAttack) > 0.2 then
				local ax = O.ItemMeta[av.Name].block.breakType
				local ay = L.tools[ax]
				if ay then
					if ao then
						for az, aA in L.inventory.hotbar do
							if aA.item and aA.item.tool == ay.tool and az ~= (L.inventory.hotbarSlot + 1) then
								hotbarSwitch(az - 1)
								break
							end
						end
					else
						switchItem(ay.tool)
					end
				end
			end
			if aj.blockHealth == - 1 or aw ~= aj.breakingBlockPosition then
				aj.blockHealth = getBlockHealth(av, aw)
				aj.breakingBlockPosition = aw
			end
			if not aq then
				O.ClientDamageBlock:Get'DamageBlock':CallServerAsync{
					blockRef = {
						blockPosition = aw
					},
					hitPosition = at,
					hitNormal = Vector3.FromNormalId(Enum.NormalId.Top)
				}:andThen(function(ax)
					if ax then
						if ax == 'cancelled' then
							L.damageBlockFail = os.clock() + 1
							table.clear(ai)
							return
						end
						if ax == 'destroyed' then
							table.clear(ai)
						end
						if al then
							local ay = (aj.blockHealth - (ax == 'destroyed' and 0 or getBlockHealth(av, aw)))
							an = an or O.BlockBreaker.updateHealthbar
							an(O.BlockBreaker, {
								blockPosition = aw
							}, aj.blockHealth, av:GetAttribute'MaxHealth', ay, av)
							aj.blockHealth = math.max(aj.blockHealth - ay, 0)
							pcall(function()
								if aj.blockHealth <= 0 then
									O.BlockBreaker.breakEffect:playBreak(av.Name, aw, t)
									O.BlockBreaker.healthbarMaid:DoCleaning()
									aj.breakingBlockPosition = Vector3.zero
								else
									O.BlockBreaker.breakEffect:playHit(av.Name, aw, t)
								end
							end)
						end
						if am then
							local ay = O.AnimationUtil:playAnimation(t, O.BlockController:getAnimationController():getAssetId(1))
							O.ViewmodelController:playAnimation(15)
							task.wait(0.3)
							ay:Stop()
							ay:Destroy()
						end
					end
				end)
			end
			if al then
				return at, Y, au
			end
		end
	end
	for ak, al in Enum.NormalId:GetEnumItems() do
		table.insert(Q, Vector3.FromNormalId(al) * 3)
	end
	local function updateStore(ak, al)
		if ak.Bedwars ~= al.Bedwars then
			L.equippedKit = ak.Bedwars.kit ~= 'none' and ak.Bedwars.kit or ''
		end
		if ak.Game ~= al.Game then
			L.matchState = ak.Game.matchState
			L.queueType = ak.Game.queueType or 'bedwars_test'
		end
		if ak.Inventory ~= al.Inventory then
			local am, an = (ak.Inventory and ak.Inventory.observedInventory or {
				inventory = {}
			}), (al.Inventory and al.Inventory.observedInventory or {
				inventory = {}
			})
			L.inventory = am
			if am ~= an then
				fireInventoryChanged()
			end
			if am.inventory.items ~= an.inventory.items then
				b.InventoryAmountChanged:Fire()
				local ao = tick()
				if not L.lastToolUpdate or ao - L.lastToolUpdate > 0.5 then
					L.lastToolUpdate = ao
					L.tools.sword = getSword()
					for ap, aq in {
						'stone',
						'wood',
						'wool'
					} do
						L.tools[aq] = getTool(aq)
					end
				end
			end
			if am.inventory.hand ~= an.inventory.hand then
				local ao, ap = ak.Inventory.observedInventory.inventory.hand, ''
				if ao then
					local aq = O.ItemMeta[ao.itemType]
					ap = aq.sword and 'sword' or aq.block and 'block' or ao.itemType:find'bow' and 'bow'
				end
				L.hand = {
					tool = ao and ao.tool,
					amount = ao and ao.amount or 0,
					toolType = ap
				}
			end
		end
	end
	local ak = O.Store.changed:connect(updateStore)
	v:Clean(function()
		ak:disconnect()
	end)
	updateStore(O.Store:getState(), {})
	for al, am in {
		'MatchEndEvent',
		'EntityDeathEvent',
		'BedwarsBedBreak',
		'BalloonPopped',
		'AngelProgress',
		'GrapplingHookFunctions'
	} do
		if not v.Connections then
			return
		end
		O.Client:WaitFor(am):andThen(function(an)
			v:Clean(an:Connect(function(...)
				b[am]:Fire(...)
			end))
		end)
	end
	v:Clean(O.ZapNetworking.EntityDamageEventZap.On(function(...)
		b.EntityDamageEvent:Fire{
			entityInstance = ...,
			damage = select(2, ...),
			damageType = select(3, ...),
			fromPosition = select(4, ...),
			fromEntity = select(5, ...),
			knockbackMultiplier = select(6, ...),
			knockbackId = select(7, ...),
			disableDamageHighlight = select(13, ...)
		}
	end))
	v:Clean(e.PlayerRemoving:Connect(function(al)
		L.inventories[al] = nil
	end))
	for al, am in {
		'PlaceBlockEvent',
		'BreakBlockEvent'
	} do
		v:Clean(O.ZapNetworking[am .. 'Zap'].On(function(...)
			local an = {
				blockRef = {
					blockPosition = ...
				},
				player = select(5, ...)
			}
			b[am]:Fire(an)
		end))
	end
	L.blocks = collection('block', v)
	L.shop = collection({
		'BedwarsItemShop',
		'TeamUpgradeShopkeeper'
	}, v, function(al, am)
		table.insert(al, {
			Id = am.Name,
			RootPart = am,
			Shop = am:HasTag'BedwarsItemShop',
			Upgrades = am:HasTag'TeamUpgradeShopkeeper'
		})
	end)
	L.enchant = collection({
		'enchant-table',
		'broken-enchant-table'
	}, v, nil, function(al, am, an)
		if am:HasTag'enchant-table' and an == 'broken-enchant-table' then
			return
		end
		am = table.find(al, am)
		if am then
			table.remove(al, am)
		end
	end)
	local al, am, an, ao, ap = D:AddItem'Kills', D:AddItem'Beds', D:AddItem'Wins', D:AddItem'Games', 'Unknown'
	D:AddItem('Map', 0, function()
		return ap
	end, false)
	task.delay(1, function()
		ao:Increment()
	end)
	task.spawn(function()
		pcall(function()
			repeat
				task.wait()
			until L.matchState ~= 0 or v.Loaded == nil
			if v.Loaded == nil then
				return
			end
			ap = workspace:WaitForChild('Map', 5):WaitForChild('Worlds', 5):GetChildren()[1].Name
			ap = string.gsub(string.split(ap, '_')[2] or ap, '-', '') or 'Blank'
		end)
	end)
	v:Clean(b.BedwarsBedBreak.Event:Connect(function(aq)
		if aq.player and aq.player.UserId == t.UserId then
			am:Increment()
		end
	end))
	v:Clean(b.MatchEndEvent.Event:Connect(function(aq)
		if (O.Store:getState().Game.myTeam or {}).id == aq.winningTeamId or t.Neutral then
			an:Increment()
		end
	end))
	v:Clean(b.EntityDeathEvent.Event:Connect(function(aq)
		local ar, as = e:GetPlayerFromCharacter(aq.fromEntity), e:GetPlayerFromCharacter(aq.entityInstance)
		if not as or not ar then
			return
		end
		if as ~= t and ar == t then
			al:Increment()
		end
	end))
	pcall(function()
		O.Shop = require(f.TS.games.bedwars.shop['bedwars-shop']).BedwarsShop
		O.ShopItems = O.Shop.ShopItems
		O.Shop.getShopItem('iron_sword', t)
		L.shopLoaded = true
	end)
	v:Clean(function()
		af.Get = ag
		O.BlockController.isBlockBreakable = ah
		L.blockPlacer:disable()
		for aq, ar in b do
			ar:Destroy()
		end
		for aq, ar in ai do
			table.clear(ar[3])
			table.clear(ar)
		end
		table.clear(L.blockPlacer)
		table.clear(b)
		table.clear(O)
		table.clear(L)
		table.clear(ai)
		table.clear(Q)
		table.clear(P)
		ak:disconnect()
		ak = nil
		if B.Connections then
			for aq, ar in ipairs(B.Connections) do
				if ar and type(ar) == 'userdata' and ar.Connected then
					ar:Disconnect()
				end
			end
			table.clear(B.Connections)
		end
		if B.PlayerConnections then
			for aq, ar in pairs(B.PlayerConnections) do
				if type(ar) == 'table' then
					for as, at in ipairs(ar) do
						if at and type(at) == 'userdata' and at.Connected then
							at:Disconnect()
						end
					end
				end
			end
			table.clear(B.PlayerConnections)
		end
		if B.EntityThreads then
			for aq, ar in pairs(B.EntityThreads) do
				if ar and task.cancel then
					task.cancel(ar)
				end
			end
			table.clear(B.EntityThreads)
		end
		if B.List then
			for aq, ar in ipairs(B.List) do
				if ar.Connections then
					for as, at in ipairs(ar.Connections) do
						if at and type(at) == 'userdata' and at.Connected then
							at:Disconnect()
						end
					end
					table.clear(ar.Connections)
				end
			end
			table.clear(B.List)
		end
		if B.stop then
			B.stop()
		end
	end)
end)
for ab, ac in {
	'AntiRagdoll',
	'TriggerBot',
	'SilentAim',
	'AutoRejoin',
	'Rejoin',
	'Disabler',
	'Timer',
	'ServerHop',
	'MouseTP',
	'MurderMystery',
	'NameTags'
} do
	v:Remove(ac)
end
local ab, ac = 0, false
local function isFirstPerson()
	local ad = tick()
	if ad - ab < 0.1 then
		return ac
	end
	ab = ad
	if not (t.Character and t.Character:FindFirstChild'Head') then
		ac = false
		return false
	end
	ac = (t.Character.Head.Position - s.CFrame.Position).Magnitude < 2
	return ac
end
local function isFrozen(ad, ae)
	ae = ae or 10
	local af
	if type(ad) == 'table' and ad.Character then
		af = ad.Character
	elseif type(ad) == 'Instance' and ad:IsA'Model' then
		af = ad
	elseif ad == nil then
		if not B.isAlive then
			return false
		end
		af = B.character.Character
	else
		return false
	end
	local ag = af:GetAttribute'ColdStacks' or af:GetAttribute'FrostStacks' or af:GetAttribute'FreezeStacks' or af:GetAttribute'FROZEN_STACKS'
	if ag and ag >= ae then
		return true
	end
	local ah = af:GetAttribute'StatusEffects'
	if type(ah) == 'table' then
		for ai, aj in pairs(ah) do
			local ak = tostring(ai):lower()
			if ak:match'[cold|frost|freeze]' then
				if type(aj) == 'number' then
					if aj >= ae then
						return true
					end
				elseif aj then
					return true
				end
			end
		end
	end
	if af:FindFirstChild'IceBlock' or af:FindFirstChild'FrozenBlock' or af:FindFirstChild'IceShell' then
		return true
	end
	local ai = af:FindFirstChildOfClass'Humanoid'
	if ai and ai.WalkSpeed <= 5 then
		return true
	end
	return false
end
local ad = RaycastParams.new()
ad.FilterType = Enum.RaycastFilterType.Include
ad.FilterDescendantsInstances = {
	workspace:FindFirstChild'Map' or workspace
}
local function cloneRaycast()
	local ae = RaycastParams.new()
	ae.FilterType = ad.FilterType
	ae.FilterDescendantsInstances = ad.FilterDescendantsInstances
	ae.RespectCanCollide = ad.RespectCanCollide
	return ae
end
local function isSword()
	return L.hand and L.hand.toolType == 'sword'
end
local function hasValidWeapon()
	if not L.hand or not L.hand.tool then
		return false
	end
	local ae, af = L.hand.toolType, L.hand.tool.Name:lower()
	if af:find'headhunter' then
		return true
	end
	return ae == 'sword' or ae == 'bow' or ae == 'crossbow'
end
local function isHoldingProjectile()
	if not L.hand or not L.hand.tool then
		return false
	end
	local ae = L.hand.tool.Name:lower()
	return ae:find'bow' or ae:find'crossbow' or ae == 'headhunter' or (O.ItemMeta[ae] and O.ItemMeta[ae].projectileSource)
end
local function isHoldingBowCrossbow()
	if not L.hand or not L.hand.tool then
		return false
	end
	local ae = L.hand.tool.Name:lower()
	return ae:find'bow' or ae:find'crossbow' or ae:find'headhunter'
end
local function isHoldingPickaxe()
	if not L.hand or not L.hand.tool then
		return false
	end
	local ae = L.hand.tool.Name:lower()
	return ae:find'pickaxe' or ae:find'drill' or ae:find'gauntlet' or ae:find'hammer' or ae:find'axe'
end
local function isEnemy(ae)
	if not ae then
		return false
	end
	if ae.Player then
		local af, ag = t:GetAttribute'Team', ae.Player:GetAttribute'Team'
		if not af or not ag or af == ag then
			return false
		end
		return select(2, H:get(ae.Player))
	elseif ae.NPC then
		local af = ae.Character:GetAttribute'Team'
		if af then
			return t:GetAttribute'Team' ~= af
		end
		return true
	end
	return false
end
local function checkFaceAdjacent(ae, af)
	af = af or {
		Vector3.new(3, 0, 0),
		Vector3.new(- 3, 0, 0),
		Vector3.new(0, 3, 0),
		Vector3.new(0, - 3, 0),
		Vector3.new(0, 0, 3),
		Vector3.new(0, 0, - 3)
	}
	for ag, ah in ipairs(af) do
		if getPlacedBlock(ae + ah) then
			return true
		end
	end
	return false
end
local function hasFaceBelowOrSide(ae)
	if getPlacedBlock(ae - Vector3.new(0, 3, 0)) then
		return true
	end
	local af = {
		Vector3.new(3, 0, 0),
		Vector3.new(- 3, 0, 0),
		Vector3.new(0, 0, 3),
		Vector3.new(0, 0, - 3)
	}
	for ag, ah in ipairs(af) do
		if getPlacedBlock(ae + ah) then
			return true
		end
	end
	return false
end
local function nearCorner(ae, af)
	local ag, ah, ai = ae - Vector3.new(3, 3, 3), ae + Vector3.new(3, 3, 3), (af - ae).Unit * 100
	local aj = ae + ai
	return Vector3.new(math.clamp(aj.X, ag.X, ah.X), math.clamp(aj.Y, ag.Y, ah.Y), math.clamp(aj.Z, ag.Z, ah.Z))
end
local function blockProximity(ae, af)
	af = af or 21
	local ag, ah, ai = 60, (getBlocksInPoints(O.BlockController:getBlockPosition(ae - Vector3.new(af, af, af)), O.BlockController:getBlockPosition(ae + Vector3.new(af, af, af))))
	for aj, ak in ipairs(ah) do
		local al = nearCorner(ak, ae)
		local am = (ae - al).Magnitude
		if hasFaceBelowOrSide(al) and am < ag then
			ag, ai = am, al
		end
	end
	return ai
end
local function getBlocksInPoints(ae, af)
	local ag, ah = O.BlockController:getStore(), {}
	for ai = ae.X, af.X do
		for aj = ae.Y, af.Y do
			for ak = ae.Z, af.Z do
				if ag:getBlockAt(Vector3.new(ai, aj, ak)) then
					table.insert(ah, Vector3.new(ai, aj, ak) * 3)
				end
			end
		end
	end
	return ah
end
local function isGUIOpen()
	return O.AppController:isLayerOpen(O.UILayers.MAIN) or O.AppController:isLayerOpen(O.UILayers.DIALOG) or O.AppController:isLayerOpen(O.UILayers.POPUP) or O.AppController:isAppOpen'BedwarsItemShopApp' or (O.Store:getState().Inventory and O.Store:getState().Inventory.open)
end
local function isTargetValid(ae, af, ag)
	if not ae or not ae.RootPart or not ae.Character then
		return false
	end
	if not B.isAlive then
		return false
	end
	local ah = (ae.RootPart.Position - B.character.RootPart.Position).Magnitude
	if ah > af then
		return false
	end
	if ag then
		local ai = workspace:Raycast(B.character.RootPart.Position, (ae.RootPart.Position - B.character.RootPart.Position), ad)
		if ai then
			return false
		end
	end
	local ai = ae.Character:FindFirstChild'Humanoid'
	return ai and ai.Health > 0
end
local ae = h.TouchEnabled and not h.KeyboardEnabled and not h.MouseEnabled
local function getTeammates()
	local af, ag = {}, t:GetAttribute'Team'
	if not ag then
		return af
	end
	for ah, ai in e:GetPlayers() do
		if ai ~= t and ai:GetAttribute'Team' == ag then
			if ai.Character and ai.Character:FindFirstChild'Humanoid' and ai.Character.Humanoid.Health > 0 then
				table.insert(af, ai)
			end
		end
	end
	return af
end
local function getTeammateNames()
	local af, ag = {}, t:GetAttribute'Team'
	if not ag then
		return af
	end
	for ah, ai in e:GetPlayers() do
		if ai ~= t and ai:GetAttribute'Team' == ag then
			table.insert(af, ai.Name)
		end
	end
	table.sort(af)
	return af
end
local function getNearestTeammateInRange(af, ag)
	if not B.isAlive then
		return nil
	end
	local ah, ai, aj = B.character.RootPart.Position, (math.huge)
	for ak, al in ipairs(getTeammates()) do
		if al.Character and al.Character.PrimaryPart then
			local am = (al.Character.PrimaryPart.Position - ah).Magnitude
			if am <= af then
				if ag and not ag(al) then
					continue
				end
				if am < ai then
					ai = am
					aj = al
				end
			end
		end
	end
	return aj
end
local function getPlayerHealth(af)
	if not af or not af.Character then
		return 0, 100
	end
	local ag, ah = af.Character:GetAttribute'Health' or (af.Character:FindFirstChildOfClass'Humanoid' and af.Character.Humanoid.Health) or 0, af.Character:GetAttribute'MaxHealth' or (af.Character:FindFirstChildOfClass'Humanoid' and af.Character.Humanoid.MaxHealth) or 100
	return ag, ah
end
local function getPlayerHealthPercent(af)
	local ag, ah = getPlayerHealth(af)
	if ah == 0 then
		return 0
	end
	return (ag / ah) * 100
end
local function leftClick()
	pcall(function()
		q:SendMouseButtonEvent(0, 0, 0, true, game, 0)
		task.wait(0.05)
		q:SendMouseButtonEvent(0, 0, 0, false, game, 0)
	end)
end
local af
task.spawn(function()
	af = O.Client:Get(P.FireProjectile).instance
end)
a(function()
	local ag, ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at, au, av, aw, ax, ay, az = (Random.new())
	local function getSmoothedSpeed(aA, W, X)
		local Y, Z = 0.008, 1.35
		local _, aB = Y * (Z ^ aA), 1 - ((W - 1) / 9) * 0.85
		return math.min(_, 0.95) * aB
	end
	local function isFirstPerson()
		local aA = t.Character and t.Character:FindFirstChild'Head'
		if aA then
			return (aA.Position - s.CFrame.Position).Magnitude < 2
		end
		return false
	end
	local function isProjectileWeapon()
		if L.hand and L.hand.tool then
			local aA = L.hand.tool.Name:lower()
			return aA:find'bow' or aA:find'crossbow' or aA:find'headhunter'
		end
		return false
	end
	local function getClosestPartToCursor(aA)
		local aB = h:GetMouseLocation()
		local W, X, Y, Z = s:ViewportPointToRay(aB.X, aB.Y, 0), math.huge, {
			'HumanoidRootPart',
			'Head',
			'UpperTorso',
			'LowerTorso',
			'LeftUpperArm',
			'RightUpperArm',
			'LeftLowerArm',
			'RightLowerArm',
			'LeftUpperLeg',
			'RightUpperLeg',
			'LeftLowerLeg',
			'RightLowerLeg',
			'LeftFoot',
			'RightFoot',
			'LeftHand',
			'RightHand'
		}
		for _, aC in Y do
			local aD = aA:FindFirstChild(aC)
			if aD then
				local aE = (aD.Position - W.Origin).Unit
				local aF = math.acos(math.clamp(W.Direction:Dot(aE), - 1, 1))
				if aF < X then
					X = aF
					Z = aD
				end
			end
		end
		return Z
	end
	local function isTargetStillValid(aA)
		if not aA or not aA.RootPart then
			return false
		end
		if not aA.Character or not aA.Character.Parent then
			return false
		end
		if (aA.Health or 0) <= 0 then
			return false
		end
		local aB = (aA.RootPart.Position - B.character.RootPart.Position).Magnitude
		if aB > an.Value then
			return false
		end
		return true
	end
	ah = v.Categories.Combat:CreateModule{
		Name = 'AimAssist',
		Function = function(aA)
			if aA then
				ah:Clean(g.Heartbeat:Connect(function(aB)
					if not B.isAlive then
						az = nil
						return
					end
					local aC = L.hand.toolType == 'sword'
					if ay and ay.Enabled then
						aC = aC or isProjectileWeapon()
					end
					if not aC then
						az = nil
						return
					end
					if ar and ar.Enabled then
						if (workspace:GetServerTimeNow() - O.SwordController.lastAttack) >= 0.4 then
							az = nil
							return
						end
					end
					local aD = isFirstPerson()
					if au.Value == 'First Person' and not aD then
						return
					end
					if au.Value == 'Third Person' and aD then
						return
					end
					if as and as.Enabled then
						if t.PlayerGui and t.PlayerGui:FindFirstChild'ItemShop' then
							az = nil
							return
						end
					end
					local aE
					if av and av.Enabled and az then
						if isTargetStillValid(az) then
							local aF, W = (az.RootPart.Position - B.character.RootPart.Position), B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
							local X = aF * Vector3.new(1, 0, 1)
							if X.Magnitude > 0.001 then
								local Y = math.acos(math.clamp(W:Dot(X.Unit), - 1, 1))
								if Y < (math.rad(ao.Value) / 2) then
									aE = az
								else
									az = nil
								end
							else
								az = nil
							end
						else
							az = nil
						end
					end
					if not aE then
						if aq and aq.Enabled and L.KillauraTarget then
							local aF = L.KillauraTarget
							local W, X = (aF.Player and ai.Players.Enabled) or (aF.NPC and ai.NPCs.Enabled), aF.RootPart and (aF.RootPart.Position - B.character.RootPart.Position).Magnitude
							local Y = X and X <= an.Value
							if W and Y then
								aE = aF
							end
						end
						if not aE then
							aE = B.EntityPosition{
								Range = an.Value,
								Part = 'RootPart',
								Wallcheck = ai.Walls.Enabled,
								Players = ai.Players.Enabled,
								NPCs = ai.NPCs.Enabled,
								Sort = aa[aj.Value]
							}
						end
						if av and av.Enabled and aE then
							az = aE
						end
					end
					if not aE or not aE.RootPart or (aE.Health or 0) <= 0 then
						if av and av.Enabled then
							az = nil
						end
						return
					end
					do
						local aF, W = (aE.RootPart.Position - B.character.RootPart.Position), B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
						local X = aF * Vector3.new(1, 0, 1)
						if X.Magnitude > 0.001 then
							local Y = math.acos(math.clamp(W:Dot(X.Unit), - 1, 1))
							if Y >= (math.rad(ao.Value) / 2) then
								if av and av.Enabled then
									az = nil
								end
								return
							end
						else
							return
						end
					end
					C.Targets[aE] = tick() + 1
					local aF = aE.RootPart.Position
					if at.Value == 'Head' then
						local W = aE.Character and aE.Character:FindFirstChild'Head'
						if W then
							aF = W.Position
						end
					elseif at.Value == 'Closest' then
						if aE.Character then
							local W = getClosestPartToCursor(aE.Character)
							if W then
								aF = W.Position
							end
						end
					else
						local W = aE.Character and (aE.Character:FindFirstChild'UpperTorso' or aE.Character:FindFirstChild'Torso')
						if W then
							aF = W.Position
						end
					end
					if aw and aw.Enabled and ax.Value > 0 then
						local W = ax.Value / 10
						aF = aF + Vector3.new((ag:NextNumber() - 0.5) * W, (ag:NextNumber() - 0.5) * W, (ag:NextNumber() - 0.5) * W)
					end
					local W
					if am and am.Enabled then
						local X = getSmoothedSpeed(ak.Value, al.Value, aB)
						if ap and ap.Enabled then
							if h:IsKeyDown(Enum.KeyCode.A) or h:IsKeyDown(Enum.KeyCode.D) then
								X = X * 1.15
							end
						end
						W = X
						local Y = CFrame.lookAt(s.CFrame.p, aF)
						s.CFrame = s.CFrame:Lerp(Y, W)
					else
						local X = ak.Value
						if ap and ap.Enabled then
							if h:IsKeyDown(Enum.KeyCode.A) or h:IsKeyDown(Enum.KeyCode.D) then
								X = X + 10
							end
						end
						local Y = CFrame.lookAt(s.CFrame.p, aF)
						s.CFrame = s.CFrame:Lerp(Y, X * aB)
					end
				end))
			else
				az = nil
			end
		end,
		Tooltip = 'Aim assist with smooth target tracking'
	}
	ai = ah:CreateTargets{
		Players = true,
		Walls = true
	}
	local aA = {
		'Damage',
		'Distance'
	}
	for aB in aa do
		if not table.find(aA, aB) then
			table.insert(aA, aB)
		end
	end
	aj = ah:CreateDropdown{
		Name = 'Target Mode',
		List = aA,
		Tooltip = 'How to prioritize targets'
	}
	at = ah:CreateDropdown{
		Name = 'Aim Part',
		List = {
			'Torso',
			'Head',
			'Closest'
		},
		Default = 'Torso'
	}
	au = ah:CreateDropdown{
		Name = 'View Mode',
		List = {
			'First Person',
			'Third Person',
			'Both'
		},
		Default = 'Both',
		Tooltip = 'Only aim in first person, third person, or always'
	}
	ak = ah:CreateSlider{
		Name = 'Aim Speed',
		Min = 1,
		Max = 20,
		Default = 6,
		Tooltip = 'How fast aim assist moves toward the target'
	}
	an = ah:CreateSlider{
		Name = 'Distance',
		Min = 1,
		Max = 30,
		Default = 25,
		Suffix = function(aB)
			return aB == 1 and 'stud' or 'studs'
		end
	}
	ao = ah:CreateSlider{
		Name = 'Max Angle',
		Min = 1,
		Max = 360,
		Default = 60,
		Tooltip = 'FOV cone for target acquisition'
	}
	am = ah:CreateToggle{
		Name = 'Smoothness',
		Default = false,
		Tooltip = 'Makes aim assist feel more legit',
		Function = function(aB)
			if al then
				al.Object.Visible = aB
			end
		end
	}
	al = ah:CreateSlider{
		Name = 'Smoothness Amount',
		Min = 1,
		Max = 10,
		Default = 5,
		Tooltip = 'Higher = smoother and more legit.',
		Visible = false
	}
	av = ah:CreateToggle{
		Name = 'Priority Mode',
		Default = false,
		Tooltip = 'Locks onto one target until they leave range or angle. Ignores new targets.'
	}
	ar = ah:CreateToggle{
		Name = 'Click Aim',
		Default = true,
		Tooltip = 'Only aims when attacking'
	}
	aq = ah:CreateToggle{
		Name = 'Use Killaura Target',
		Tooltip = 'Follow the same target as Killaura'
	}
	ap = ah:CreateToggle{
		Name = 'Strafe Boost',
		Tooltip = 'Increases aim speed slightly when strafing'
	}
	aw = ah:CreateToggle{
		Name = 'Shake',
		Default = false,
		Tooltip = 'Adds slight jitter to aim to look more human',
		Function = function(aB)
			if ax then
				ax.Object.Visible = aB
			end
		end
	}
	ax = ah:CreateSlider{
		Name = 'Shake Amount',
		Min = 1,
		Max = 10,
		Default = 3,
		Visible = false
	}
	as = ah:CreateToggle{
		Name = 'Shop Check',
		Default = false,
		Tooltip = 'Disables aim assist when the shop is open'
	}
	ay = ah:CreateToggle{
		Name = 'Work With Projectiles',
		Default = false,
		Tooltip = 'Also activates when holding bows or crossbows'
	}
	task.defer(function()
		if al and al.Object then
			al.Object.Visible = am and am.Enabled or false
		end
		if ax and ax.Object then
			ax.Object.Visible = false
		end
	end)
end)
a(function()
	local ag, ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF = cloneRaycast(), Random.new(), false, 0, false, {
		predictStrafingMovement = function(ag, ah, ai, aj, ak)
			if not ag or not ag.Character or not ah then
				return ah and ah.Position or Vector3.zero
			end
			local al, am = ah.Position, ah.Velocity
			local an = (al - ak).Magnitude
			local ao, ap = an / ai, Vector3.new(am.X, 0, am.Z)
			local aq, ar = ap.Magnitude, 1
			if ai >= 450 then
				if an > 80 then
					ar = 0.92
				elseif an > 50 then
					ar = 0.95
				else
					ar = 0.98
				end
			elseif ai >= 350 then
				if an > 80 then
					ar = 0.88
				elseif an > 50 then
					ar = 0.92
				else
					ar = 0.95
				end
			else
				if an > 80 then
					ar = 1.15
				elseif an > 50 then
					ar = 1.1
				else
					ar = 1.05
				end
			end
			local as, at = ap * ao * ar, am.Y
			local au, av, aw, ax, ay = at < - 50, at < - 15 and at >= - 50, at > 10, at >= - 3 and at <= 3, 0.5
			if au then
				ay = 0.8
			elseif av then
				ay = 0.75
			elseif aw then
				ay = 0.6
			elseif ax then
				ay = 0.4
			else
				ay = 0.5
			end
			local az, aA = at * ao * ay, 0
			if aj > 0 then
				aA = 0.5 * aj * (ao * ao)
				if ai >= 450 then
					aA = aA * 0.6
				elseif ai >= 350 then
					aA = aA * 0.75
				end
			end
			local aB, aC, aD = al.X + as.X, al.Y + az + aA, al.Z + as.Z
			local aE = Vector3.new(aB, aC, aD)
			if an > 100 then
				local aF = 1.5
				if ao > aF then
					local W, X, Y = ap * aF * ar, at * aF * ay, 0.5 * aj * (aF * aF)
					if ai >= 450 then
						Y = Y * 0.6
					elseif ai >= 350 then
						Y = Y * 0.75
					end
					aE = Vector3.new(al.X + W.X, al.Y + X + Y, al.Z + W.Z)
				end
			end
			return aE
		end
	}
	local function getAimSpeed(W)
		local X, Y = 0.008, 1.35
		local Z = X * (Y ^ W)
		return math.min(Z, 0.95)
	end
	local function getTargetPart(W)
		if not W or not W.Character then
			return nil
		end
		if at.Value == 'Head' then
			return W.Character:FindFirstChild'Head' or W.Head or W.RootPart
		elseif at.Value == 'Torso' then
			return W.Character:FindFirstChild'Torso' or W.Character:FindFirstChild'UpperTorso' or W.RootPart
		else
			return W.RootPart
		end
	end
	local function getPredictedPosition(W, X)
		if not W or not W.RootPart then
			return nil
		end
		local Y = getTargetPart(W)
		if not Y then
			return nil
		end
		if ao.Value == 'Aero' then
			local Z, _ = 100, 196.2
			if L.hand and L.hand.tool then
				local aG = L.hand.tool.Name
				local aH = O.ItemMeta[aG]
				if aH and aH.projectileSource then
					local aI = aH.projectileSource
					local aJ = aI.projectileType
					if type(aJ) == 'function' then
						local aK, aL = pcall(aJ, nil)
						if aK then
							aJ = aL
						end
					end
					if aJ then
						local aK = O.ProjectileMeta[aJ]
						if aK then
							Z = aK.launchVelocity or 100
							_ = (aK.gravitationalAcceleration or 196.2)
						end
					end
				end
			end
			local aG = al.predictStrafingMovement(W.Player, Y, Z, _, X)
			return aG
		else
			local aG, aH = workspace.Gravity, W.Character:GetAttribute'InflatedBalloons'
			if aH and aH > 0 then
				aG = workspace.Gravity * (1 - (aH >= 4 and 1.2 or aH >= 3 and 1 or 0.975))
			end
			if W.Character.PrimaryPart:FindFirstChild'rbxassetid://8200754399' then
				aG = 6
			end
			if W.Player and W.Player:GetAttribute'IsOwlTarget' then
				for aI, aJ in l:GetTagged'Owl' do
					if aJ:GetAttribute'Target' == W.Player.UserId and aJ:GetAttribute'Status' == 2 then
						aG = 0
						break
					end
				end
			end
			local aI, aJ = 100, 196.2
			if L.hand and L.hand.tool then
				local aK = L.hand.tool.Name
				local aL = O.ItemMeta[aK]
				if aL and aL.projectileSource then
					local Z = aL.projectileSource
					local _ = Z.projectileType
					if type(_) == 'function' then
						local aM, aN = pcall(_, nil)
						if aM then
							_ = aN
						end
					end
					if _ then
						local aM = O.ProjectileMeta[_]
						if aM then
							aI = aM.launchVelocity or 100
							aJ = (aM.gravitationalAcceleration or 196.2)
						end
					end
				end
			end
			local aK = I.SolveTrajectory(X, aI, aJ, Y.Position, Y.Velocity, aG, W.HipHeight, W.Jumping and 42.6 or nil, ag)
			return aK
		end
	end
	am = v.Categories.Combat:CreateModule{
		Name = 'ProjectileAimAssist',
		Function = function(aG)
			if aG then
				am:Clean(g.RenderStepped:Connect(function(aH)
					if not (B.isAlive and isHoldingBowCrossbow() and ((not av.Enabled) or (workspace:GetServerTimeNow() - O.SwordController.lastAttack) < 0.4)) then
						aD = nil
						aF = nil
						ak = false
						return
					end
					if aA.Enabled then
						local aI = t:FindFirstChild'PlayerGui' and t.PlayerGui:FindFirstChild'ItemShop'
						if aI then
							return
						end
					end
					if aB.Enabled and not isFirstPerson() then
						return
					end
					local aI
					if au.Enabled then
						if aD and isTargetValid(aD, ar.Value, an.Walls.Enabled) then
							local aJ, aK = (aD.RootPart.Position - B.character.RootPart.Position), B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
							local aL = math.acos(aK:Dot((aJ * Vector3.new(1, 0, 1)).Unit))
							if aL < (math.rad(as.Value) / 2) then
								aI = aD
							else
								aD = nil
								aF = nil
								ak = false
							end
						else
							aD = nil
						end
						if not aI then
							aI = B.EntityPosition{
								Range = ar.Value,
								Part = 'RootPart',
								Wallcheck = an.Walls.Enabled,
								Players = an.Players.Enabled,
								NPCs = an.NPCs.Enabled,
								Sort = aa.Distance
							}
							if aI then
								aD = aI
							end
						end
					else
						aD = nil
						aI = B.EntityPosition{
							Range = ar.Value,
							Part = 'RootPart',
							Wallcheck = an.Walls.Enabled,
							Players = an.Players.Enabled,
							NPCs = an.NPCs.Enabled,
							Sort = aa.Distance
						}
					end
					if aI then
						if aF ~= aI then
							aF = aI
							ak = false
							aj = tick()
						end
						if not ak then
							local aJ = aq.Value / 1000
							local aK = (ah:NextNumber() - 0.5) * 0.3 * aJ
							local aL = aJ + aK
							if (tick() - aj) < aL then
								return
							else
								ak = true
							end
						end
						pcall(function()
							local aJ = aI
							vapeTargetInfo.Targets.ProjectileAimAssist = {
								Humanoid = {
									Health = (aJ.Character:GetAttribute'Health' or aJ.Humanoid.Health) + getShieldAttribute(aJ.Character),
									MaxHealth = aJ.Character:GetAttribute'MaxHealth' or aJ.Humanoid.MaxHealth
								},
								Player = aJ.Player
							}
						end)
						local aJ, aK = (aI.RootPart.Position - B.character.RootPart.Position), B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
						local aL = math.acos(aK:Dot((aJ * Vector3.new(1, 0, 1)).Unit))
						if aL >= (math.rad(as.Value) / 2) then
							return
						end
						C.Targets[aI] = tick() + 1
						local aM = B.character.RootPart.Position
						local aN = getPredictedPosition(aI, aM)
						if not aN then
							return
						end
						local W = aN
						if aw.Enabled then
							W = W + Vector3.new(0, ax.Value, 0)
						end
						local X = getAimSpeed(ap.Value)
						if aC.Enabled and (h:IsKeyDown(Enum.KeyCode.A) or h:IsKeyDown(Enum.KeyCode.D)) then
							X = X * 1.15
						end
						if ay.Enabled and az.Value > 0 then
							local Y = az.Value / 10
							local Z = 1 + ((ah:NextNumber() - 0.5) * Y * 0.3)
							X = X * Z
							local _ = az.Value * 0.1
							local aO = Vector3.new((ah:NextNumber() - 0.5) * _, (ah:NextNumber() - 0.5) * _, (ah:NextNumber() - 0.5) * _)
							W = W + aO
						end
						local aO = CFrame.lookAt(s.CFrame.p, W)
						s.CFrame = s.CFrame:Lerp(aO, X)
						aE = aO
						ai = true
					else
						aF = nil
						ak = false
						if ai and aE then
							local aJ = 0.05
							if (s.CFrame.Position - aE.Position).Magnitude > 0.1 then
								s.CFrame = s.CFrame:Lerp(CFrame.new(s.CFrame.Position, s.CFrame.Position + s.CFrame.LookVector), aJ)
							else
								ai = false
								aE = nil
							end
						end
						if au.Enabled then
							aD = nil
						end
					end
				end))
			else
				aD = nil
				ai = false
				aE = nil
				aF = nil
				ak = false
			end
		end,
		Tooltip = 'Projectile aim assist with prediction'
	}
	an = am:CreateTargets{
		Players = true,
		Walls = true
	}
	ao = am:CreateDropdown{
		Name = 'Prediction Mode',
		List = {
			'Vape',
			'Aero'
		},
		Default = 'Aero',
		Tooltip = 'Vape = Built-in | Aero = Custom'
	}
	ap = am:CreateSlider{
		Name = 'Aim Speed',
		Min = 1,
		Max = 20,
		Default = 6,
		Tooltip = 'How fast the aim assistant tracks'
	}
	aq = am:CreateSlider{
		Name = 'Reaction Time',
		Min = 0,
		Max = 300,
		Default = 80,
		Suffix = 'ms',
		Tooltip = 'Delay before aim assist activates'
	}
	ar = am:CreateSlider{
		Name = 'Distance',
		Min = 1,
		Max = 30,
		Default = 25,
		Suffix = function(aG)
			return aG == 1 and 'stud' or 'studs'
		end
	}
	as = am:CreateSlider{
		Name = 'Max Angle',
		Min = 1,
		Max = 360,
		Default = 60,
		Tooltip = 'FOV angle for target acquisition'
	}
	at = am:CreateDropdown{
		Name = 'Aim Part',
		List = {
			'Root',
			'Torso',
			'Head'
		},
		Default = 'Root'
	}
	au = am:CreateToggle{
		Name = 'Priority Mode',
		Default = false,
		Tooltip = 'Lock onto one target'
	}
	av = am:CreateToggle{
		Name = 'Click Aim',
		Default = true,
		Tooltip = 'Only aim when attacking'
	}
	aw = am:CreateToggle{
		Name = 'Vertical Offset',
		Default = false,
		Function = function(aG)
			ax.Object.Visible = aG
		end
	}
	ax = am:CreateSlider{
		Name = 'Offset',
		Min = - 3,
		Max = 3,
		Default = 0,
		Decimal = 10,
		Visible = false
	}
	ay = am:CreateToggle{
		Name = 'Shake',
		Default = false,
		Function = function(aG)
			az.Object.Visible = aG
		end,
		Tooltip = 'Add jitter to aim'
	}
	az = am:CreateSlider{
		Name = 'Shake Amount',
		Min = 1,
		Max = 10,
		Default = 3,
		Visible = false
	}
	aA = am:CreateToggle{
		Name = 'Shop Check',
		Default = false,
		Tooltip = 'Disable when shop is open'
	}
	aB = am:CreateToggle{
		Name = 'First Person Only',
		Default = false,
		Tooltip = 'Only work in first person'
	}
	aC = am:CreateToggle{
		Name = 'Strafe Boost',
		Tooltip = 'Faster aim when strafing'
	}
	task.defer(function()
		if ax and ax.Object then
			ax.Object.Visible = false
		end
		if az and az.Object then
			az.Object.Visible = false
		end
	end)
end)
a(function()
	if ae then
		local ag, ah, ai, aj, ak = {}
		local function getSafeCPS()
			if L.hand and L.hand.toolType == 'block' and ag and ag.GetRandomValue then
				return ag
			end
			if ai and ai.GetRandomValue then
				return ai
			end
			return nil
		end
		local al
		local function AutoClick()
			if aj then
				task.cancel(aj)
				aj = nil
			end
			local am = getSafeCPS()
			if not am then
				return
			end
			aj = task.delay(1 / am.GetRandomValue(), function()
				repeat
					if not O.AppController:isLayerOpen(O.UILayers.MAIN) then
						local an, ao = O.BlockPlacementController and O.BlockPlacementController.blockPlacer, L.hand and L.hand.toolType
						if ao == 'block' and an then
							task.spawn(function()
								if ak and ak.Enabled and al then
									local ap = s:ScreenPointToRay(al.X, al.Y)
									local aq = an.clientManager:getBlockSelector():getMouseInfo(0, {
										ray = ap
									})
									if aq and aq.placementPosition == aq.placementPosition then
										an:placeBlock(aq.placementPosition)
									end
								else
									an:autoBridge(workspace:GetServerTimeNow() - O.KnockbackController:getLastKnockbackTime() >= 0.2)
								end
							end)
						elseif ao == 'sword' then
							O.SwordController:swingSwordAtMouse(0.39)
						end
					end
					local an = getSafeCPS()
					if not an then
						task.wait(0.1)
					else
						task.wait(1 / an.GetRandomValue())
					end
				until not ah.Enabled
			end)
		end
		local function StopClick()
			if aj then
				task.cancel(aj)
				aj = nil
			end
		end
		ah = v.Categories.Combat:CreateModule{
			Name = 'AutoClicker',
			Function = function(am)
				if am then
					ah:Clean(h.InputBegan:Connect(function(an)
						if an.UserInputType == Enum.UserInputType.MouseButton1 then
							AutoClick()
						end
					end))
					ah:Clean(h.InputEnded:Connect(function(an)
						if an.UserInputType == Enum.UserInputType.MouseButton1 then
							StopClick()
						end
					end))
					for an, ao in {
						'2',
						'5'
					} do
						pcall(function()
							ah:Clean(t.PlayerGui.MobileUI[ao].MouseButton1Down:Connect(AutoClick))
							ah:Clean(t.PlayerGui.MobileUI[ao].MouseButton1Up:Connect(StopClick))
						end)
					end
					ah:Clean(h.TouchStarted:Connect(function(an, ao)
						if ak and ak.Enabled then
							al = an.Position
							AutoClick()
						end
					end))
					ah:Clean(h.TouchMoved:Connect(function(an, ao)
						if ak and ak.Enabled then
							al = an.Position
						end
					end))
					ah:Clean(h.TouchEnded:Connect(function(an, ao)
						if ak and ak.Enabled then
							al = nil
							StopClick()
						end
					end))
				else
					StopClick()
				end
			end,
			Tooltip = 'Hold attack button to automatically click'
		}
		ai = ah:CreateTwoSlider{
			Name = 'CPS',
			Min = 1,
			Max = 9,
			DefaultMin = 7,
			DefaultMax = 7
		}
		ah:CreateToggle{
			Name = 'Place Blocks',
			Default = true,
			Function = function(am)
				if ag.Object then
					ag.Object.Visible = am
				end
			end
		}
		ag = ah:CreateTwoSlider{
			Name = 'Block CPS',
			Min = 1,
			Max = 20,
			DefaultMin = 12,
			DefaultMax = 12,
			Darker = true
		}
		ak = ah:CreateToggle{
			Name = 'Draggable',
			Default = true,
			Tooltip = 'When enabled, touching anywhere on screen triggers autoclicker'
		}
		task.defer(function()
			if ag and ag.Object then
				ag.Object.Visible = PlaceBlocksToggle and PlaceBlocksToggle.Enabled
			end
		end)
	else
		local ag, ah, ai, aj, ak, al, am, an, ao, ap = {}, {}, task.wait, task.spawn, function()
			return workspace:GetServerTimeNow()
		end
		local function getSafeCPS()
			local aq = L.hand and L.hand.toolType or nil
			if aq == 'block' and an and an.Enabled and ag and ag.GetRandomValue then
				return ag
			elseif aq == 'sword' and ao and ao.Enabled and ah and ah.GetRandomValue then
				return ah
			elseif am and am.GetRandomValue then
				return am
			end
			return nil
		end
		local function AutoClickAero()
			if ap then
				task.cancel(ap)
			end
			ap = aj(function()
				repeat
					if not O.AppController:isLayerOpen(O.UILayers.MAIN) then
						local aq = L.hand and L.hand.toolType
						if an.Enabled and aq == 'block' then
							local ar = O.BlockPlacementController and O.BlockPlacementController.blockPlacer
							if ar then
								if (ak() - O.BlockCpsController.lastPlaceTimestamp) >= (4.1666666666666664E-2) then
									local as = ar.clientManager:getBlockSelector():getMouseInfo(0)
									if as and as.placementPosition == as.placementPosition then
										aj(ar.placeBlock, ar, as.placementPosition)
									end
								end
							end
						elseif ao.Enabled and aq == 'sword' then
							O.SwordController:swingSwordAtMouse(0.39)
						end
					end
					local aq = getSafeCPS()
					ai(1 / (aq and aq.GetRandomValue() or 7))
				until not al.Enabled
			end)
		end
		local function StopAutoClick()
			if ap then
				task.cancel(ap)
				ap = nil
			end
		end
		local aq, ar = 0.12
		al = v.Categories.Combat:CreateModule{
			Name = 'AutoClicker',
			Function = function(as)
				if as then
					al:Clean(h.InputBegan:Connect(function(at)
						if at.UserInputType == Enum.UserInputType.MouseButton1 then
							ar = task.delay(aq, function()
								ar = nil
								if h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
									AutoClickAero()
								end
							end)
						end
					end))
					al:Clean(h.InputEnded:Connect(function(at)
						if at.UserInputType == Enum.UserInputType.MouseButton1 then
							if ar then
								task.cancel(ar)
								ar = nil
							end
							if ap then
								task.cancel(ap)
								ap = nil
							end
						end
					end))
				else
					StopAutoClick()
				end
			end,
			Tooltip = 'Clicks for you'
		}
		an = al:CreateToggle{
			Name = 'Place Blocks',
			Default = false,
			Function = function(as)
				task.defer(function()
					if ag and ag.Object then
						ag.Object.Visible = as
					end
				end)
			end
		}
		ag = al:CreateTwoSlider{
			Name = 'Block CPS',
			Min = 1,
			Max = 20,
			DefaultMin = 12,
			DefaultMax = 12,
			Darker = true
		}
		ao = al:CreateToggle{
			Name = 'Swing Sword',
			Default = false,
			Function = function(as)
				if ah.Object then
					ah.Object.Visible = as
				end
			end
		}
		ah = al:CreateTwoSlider{
			Name = 'Sword CPS',
			Min = 1,
			Max = 9,
			DefaultMin = 7,
			DefaultMax = 7,
			Darker = true
		}
		task.defer(function()
			if ag and ag.Object then
				ag.Object.Visible = an and an.Enabled
			end
			if ah and ah.Object then
				ah.Object.Visible = ao and ao.Enabled
			end
		end)
	end
end)
a(function()
	local ag, ah = e
	local ai = ag.LocalPlayer
	local aj, ak, al, am, an = ai:WaitForChild'PlayerGui', {none = 'rbxassetid://16493320215',random = 'rbxassetid://79773209697352',cowgirl = 'rbxassetid://9155462968',davey = 'rbxassetid://9155464612',warlock = 'rbxassetid://15186338366',ember = 'rbxassetid://9630017904',black_market_trader = 'rbxassetid://18922642482',yeti = 'rbxassetid://9166205917',scarab = 'rbxassetid://137137517627492',defender = 'rbxassetid://131690429591874',cactus = 'rbxassetid://104436517801089',oasis = 'rbxassetid://120283205213823',berserker = 'rbxassetid://90258047545241',sword_shield = 'rbxassetid://131690429591874',airbender = 'rbxassetid://74712750354593',gun_blade = 'rbxassetid://138231219644853',frost_hammer_kit = 'rbxassetid://11838567073',spider_queen = 'rbxassetid://95237509752482',archer = 'rbxassetid://9224796984',axolotl = 'rbxassetid://9155466713',baker = 'rbxassetid://9155463919',barbarian = 'rbxassetid://9166207628',builder = 'rbxassetid://9155463708',necromancer = 'rbxassetid://11343458097',cyber = 'rbxassetid://9507126891',sorcerer = 'rbxassetid://97940108361528',bigman = 'rbxassetid://9155467211',spirit_assassin = 'rbxassetid://10406002412',farmer_cletus = 'rbxassetid://9155466936',ice_queen = 'rbxassetid://9155466204',grim_reaper = 'rbxassetid://9155467410',spirit_gardener = 'rbxassetid://132108376114488',hannah = 'rbxassetid://10726577232',shielder = 'rbxassetid://9155464114',summoner = 'rbxassetid://18922378956',glacial_skater = 'rbxassetid://84628060516931',dragon_sword = 'rbxassetid://16215630104',lumen = 'rbxassetid://9630018371',flower_bee = 'rbxassetid://101569742252812',jellyfish = 'rbxassetid://18129974852',melody = 'rbxassetid://9155464915',mimic = 'rbxassetid://14783283296',miner = 'rbxassetid://9166208461',nazar = 'rbxassetid://18926951849',seahorse = 'rbxassetid://11902552560',elk_master = 'rbxassetid://15714972287',rebellion_leader = 'rbxassetid://18926409564',void_hunter = 'rbxassetid://122370766273698',taliyah = 'rbxassetid://13989437601',angel = 'rbxassetid://9166208240',harpoon = 'rbxassetid://18250634847',void_walker = 'rbxassetid://78915127961078',spirit_summoner = 'rbxassetid://95760990786863',triple_shot = 'rbxassetid://9166208149',void_knight = 'rbxassetid://73636326782144',regent = 'rbxassetid://9166208904',vulcan = 'rbxassetid://9155465543',owl = 'rbxassetid://12509401147',dasher = 'rbxassetid://9155467645',disruptor = 'rbxassetid://11596993583',wizard = 'rbxassetid://13353923546',aery = 'rbxassetid://9155463221',agni = 'rbxassetid://17024640133',alchemist = 'rbxassetid://9155462512',spearman = 'rbxassetid://9166207341',beekeeper = 'rbxassetid://9312831285',falconer = 'rbxassetid://17022941869',bounty_hunter = 'rbxassetid://9166208649',blood_assassin = 'rbxassetid://12520290159',battery = 'rbxassetid://10159166528',steam_engineer = 'rbxassetid://15380413567',vesta = 'rbxassetid://9568930198',beast = 'rbxassetid://9155465124',dino_tamer = 'rbxassetid://9872357009',drill = 'rbxassetid://12955100280',elektra = 'rbxassetid://13841413050',fisherman = 'rbxassetid://9166208359',queen_bee = 'rbxassetid://12671498918',card = 'rbxassetid://13841410580',frosty = 'rbxassetid://9166208762',gingerbread_man = 'rbxassetid://9155464364',ghost_catcher = 'rbxassetid://9224802656',tinker = 'rbxassetid://17025762404',ignis = 'rbxassetid://13835258938',oil_man = 'rbxassetid://9166206259',jade = 'rbxassetid://9166306816',dragon_slayer = 'rbxassetid://10982192175',paladin = 'rbxassetid://11202785737',pinata = 'rbxassetid://10011261147',merchant = 'rbxassetid://9872356790',metal_detector = 'rbxassetid://9378298061',slime_tamer = 'rbxassetid://15379766168',nyoka = 'rbxassetid://17022941410',midnight = 'rbxassetid://9155462763',pyro = 'rbxassetid://9155464770',raven = 'rbxassetid://9166206554',santa = 'rbxassetid://9166206101',sheep_herder = 'rbxassetid://9155465730',smoke = 'rbxassetid://9155462247',spirit_catcher = 'rbxassetid://9166207943',star_collector = 'rbxassetid://9872356516',styx = 'rbxassetid://17014536631',block_kicker = 'rbxassetid://15382536098',trapper = 'rbxassetid://9166206875',hatter = 'rbxassetid://12509388633',ninja = 'rbxassetid://15517037848',jailor = 'rbxassetid://11664116980',warrior = 'rbxassetid://9166207008',mage = 'rbxassetid://10982191792',void_dragon = 'rbxassetid://10982192753',cat = 'rbxassetid://15350740470',wind_walker = 'rbxassetid://9872355499',skeleton = 'rbxassetid://120123419412119',winter_lady = 'rbxassetid://83274578564074'}, {}, {}
	local function createkitrender(ao)
		local ap = Instance.new'ImageLabel'
		ap.Name = 'AeroV4KitRender'
		ap.AnchorPoint = Vector2.new(1, 0.5)
		ap.BackgroundTransparency = 1
		ap.Position = UDim2.new(1.05, 0, 0.5, 0)
		ap.Size = UDim2.new(1.5, 0, 1.5, 0)
		ap.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ap.ImageTransparency = 0.4
		ap.ScaleType = Enum.ScaleType.Crop
		local aq = Instance.new'UIAspectRatioConstraint'
		aq.AspectRatio = 1
		aq.AspectType = Enum.AspectType.FitWithinMaxSize
		aq.DominantAxis = Enum.DominantAxis.Width
		aq.Parent = ap
		ap.Image = ak[ao:GetAttribute'PlayingAsKit'] or ak.none
		return ap
	end
	local function removeallkitrenders()
		for ao, ap in pairs(al) do
			al[ao] = nil
		end
		table.clear(am)
		if an then
			task.cancel(an)
			an = nil
		end
		for ao, ap in ipairs(aj:GetDescendants()) do
			if ap:IsA'ImageLabel' and ap.Name == 'AeroV4KitRender' then
				ap:Destroy()
			end
		end
	end
	local function refreshicon(ao, ap)
		if not ao or not ao.Parent then
			return
		end
		local aq = ap:GetAttribute'PlayingAsKit'
		local ar = ak[aq] or ak.none
		if ao.Image ~= ar then
			ao.Image = ar
		end
	end
	local function findPlayer(ao, ap)
		local aq = ap:FindFirstChild('PlayerRender', true)
		if aq and aq:IsA'ImageLabel' and aq.Image then
			local ar = string.match(aq.Image, 'id=(%d+)')
			if ar then
				local as = ag:GetPlayerByUserId(tonumber(ar))
				if as then
					return as
				end
			end
		end
		local ar = ao.Text
		for as, at in ipairs(ag:GetPlayers()) do
			if at.Name == ar or at.DisplayName == ar or at:GetAttribute'DisguiseDisplayName' == ar then
				return at
			end
		end
	end
	local function handleLabel(ao)
		if not (ao:IsA'TextLabel' and ao.Name == 'PlayerName') then
			return
		end
		task.spawn(function()
			local ap = ao.Parent
			for aq = 1, 3 do
				if ap and ap.Parent then
					ap = ap.Parent
				end
			end
			if not ap or not ap:IsA'Frame' then
				return
			end
			local aq = findPlayer(ao, ap)
			if not aq then
				task.wait(0.5)
				aq = findPlayer(ao, ap)
			end
			if not aq then
				return
			end
			ap.Name = aq.Name
			local ar = ap:FindFirstChild'1' and ap['1']:FindFirstChild'MatchDraftPlayerCard'
			if not ar then
				return
			end
			local as = ar:FindFirstChild'AeroV4KitRender'
			if not as then
				as = createkitrender(aq)
				as.Parent = ar
			end
			local at = aq.UserId
			if al[at] then
				al[at] = nil
			end
			al[at] = true
			task.spawn(function()
				while al[at] and ap and ap.Parent and ah.Enabled do
					local au = tick()
					if not am[at] or (au - am[at]) >= 0.3 then
						am[at] = au
						local av = findPlayer(ao, ap)
						if av and av ~= aq then
							aq = av
						end
						if aq and as and as.Parent then
							refreshicon(as, aq)
						end
					end
					task.wait(0.3)
				end
				al[at] = nil
				am[at] = nil
			end)
		end)
	end
	local function setupKitRender()
		local ao, ap = pcall(function()
			return aj:FindFirstChild'MatchDraftApp' and aj.MatchDraftApp:FindFirstChild'DraftAppBackground' and aj.MatchDraftApp.DraftAppBackground:FindFirstChild'BodyContainer' and aj.MatchDraftApp.DraftAppBackground.BodyContainer:FindFirstChild'Team2Column'
		end)
		if not ao or not ap then
			return false
		end
		for aq, ar in ipairs(ap:GetDescendants()) do
			if ah.Enabled then
				handleLabel(ar)
			end
		end
		ah:Clean(ap.DescendantAdded:Connect(function(aq)
			if ah.Enabled then
				handleLabel(aq)
			end
		end))
		return true
	end
	ah = v.Categories.Utility:CreateModule{
		Name = 'KitRender (5v5)',
		Tooltip = "Allows you to see everyone's kit during kit phase (5v5, Ranked)",
		Function = function(ao)
			if ao then
				local ap = setupKitRender()
				if not ap then
					an = task.spawn(function()
						while ah.Enabled do
							task.wait(1)
							if setupKitRender() then
								break
							end
						end
					end)
				end
			else
				removeallkitrenders()
			end
		end
	}
end)
a(function()
	local ag, ah, ai, aj, ak, al = {}, {}, {}, {}
	KitRender = v.Categories.Utility:CreateModule{
		Name = 'KitRender (squads)',
		Function = function(am)
			if am then
				local function createKitLabel(an, ao)
					if ah[an] then
						ah[an]:Destroy()
					end
					local ap = Instance.new'ImageLabel'
					ap.Name = 'AeroV4KitIcon'
					ap.Size = UDim2.new(1, 0, 1, 0)
					ap.Position = UDim2.new(1.1, 0, 0, 0)
					ap.BackgroundTransparency = 1
					ap.Image = ao
					ap.Parent = an
					ah[an] = ap
					return ap
				end
				local function setupKitRender(an)
					if an.Name == 'PlayerRender' and an.Parent and an.Parent.Parent and an.Parent.Parent.Parent and an.Parent.Parent.Parent.Parent and an.Parent.Parent.Parent.Parent.Parent and an.Parent.Parent.Parent.Parent.Parent.Name == 'MatchDraftTeamCardRow' then
						local ao = an.Parent:FindFirstChild'3'
						if not ao then
							return
						end
						local ap = string.match(an.Image, 'id=(%d+)')
						if not ap then
							return
						end
						local aq = tonumber(ap)
						if not aq then
							return
						end
						local ar = e:GetPlayerByUserId(aq)
						if not ar then
							return
						end
						local as = ar.UserId
						aj[as] = true
						if ag[as] then
							ag[as]:Disconnect()
							ag[as] = nil
						end
						local function updateKit()
							if not KitRender.Enabled then
								return
							end
							if not ao or not ao.Parent then
								if ag[as] then
									ag[as]:Disconnect()
									ag[as] = nil
								end
								if ah[ao] then
									ah[ao]:Destroy()
									ah[ao] = nil
								end
								return
							end
							local at = ar:GetAttribute'PlayingAsKits'
							if not at then
								at = 'none'
							end
							local au = O.BedwarsKitMeta[at] or O.BedwarsKitMeta.none
							if ah[ao] then
								ah[ao].Image = au.renderImage
							else
								createKitLabel(ao, au.renderImage)
							end
						end
						updateKit()
						local at = ar:GetAttributeChangedSignal'PlayingAsKits':Connect(function()
							local at = tick()
							if not ai[as] or (at - ai[as]) >= 0.1 then
								ai[as] = at
								updateKit()
							end
						end)
						ag[as] = at
						KitRender:Clean(at)
					end
				end
				local function setupSquadsRender()
					local an = t.PlayerGui:FindFirstChild'MatchDraftApp'
					if not an then
						return false
					end
					task.wait(0.5)
					for ao, ap in an:GetDescendants() do
						if KitRender.Enabled then
							task.spawn(function()
								setupKitRender(ap)
							end)
						end
					end
					KitRender:Clean(an.DescendantAdded:Connect(function(ao)
						if KitRender.Enabled then
							task.wait(0.1)
							setupKitRender(ao)
						end
					end))
					return true
				end
				al = task.spawn(function()
					while KitRender.Enabled do
						task.wait(0.5)
						local an = t.PlayerGui:FindFirstChild'MatchDraftApp'
						if an then
							for ao, ap in an:GetDescendants() do
								if ap.Name == 'PlayerRender' and KitRender.Enabled then
									local aq = string.match(ap.Image, 'id=(%d+)')
									if aq then
										local ar = tonumber(aq)
										if ar and not aj[ar] then
											task.spawn(function()
												setupKitRender(ap)
											end)
										end
									end
								end
							end
						end
					end
				end)
				task.spawn(function()
					local an = setupSquadsRender()
					if not an then
						ak = task.spawn(function()
							while KitRender.Enabled do
								task.wait(1)
								if setupSquadsRender() then
									break
								end
							end
						end)
					end
				end)
			else
				if ak then
					task.cancel(ak)
					ak = nil
				end
				if al then
					task.cancel(al)
					al = nil
				end
				for an, ao in pairs(ag) do
					if ao then
						ao:Disconnect()
					end
					ag[an] = nil
				end
				for an, ao in pairs(ah) do
					if ao then
						ao:Destroy()
					end
					ah[an] = nil
				end
				table.clear(ai)
				table.clear(aj)
			end
		end,
		Tooltip = "Shows everyone's kit next to their rank during kit phase (squads ranked!)"
	}
end)
a(function()
	local ag, ah, ai, aj, ak, al
	M = v.Categories.Combat:CreateModule{
		Name = 'Reach',
		Function = function(am)
			if am then
				aj = O.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE
				O.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = ag.Value + 2
				task.spawn(function()
					repeat
						task.wait(0.1)
					until O.BlockBreakController or not M.Enabled
					if not M.Enabled then
						return
					end
					pcall(function()
						local an = O.BlockBreakController:getBlockBreaker()
						if an then
							ak = ak or an:getRange()
							an:setRange(ah.Value)
						end
					end)
				end)
				task.spawn(function()
					repeat
						task.wait(0.1)
					until O.BlockEngine or not M.Enabled
					if not M.Enabled then
						return
					end
					pcall(function()
						if not al then
							al = O.BlockEngine.isAllowedPlacement
							O.BlockEngine.isAllowedPlacement = function(an, ao, ap, aq, ar, as)
								local at = al(an, ao, ap, aq, ar, as)
								if not at and ao == game.Players.LocalPlayer then
									local au = an:getStore():getBlockAt(aq)
									if not au then
										return true
									end
								end
								return at
							end
						end
					end)
				end)
				task.spawn(function()
					repeat
						task.wait(0.1)
					until O.BlockPlacementController or not M.Enabled
					if not M.Enabled then
						return
					end
					pcall(function()
						local an = O.BlockPlacementController:getBlockPlacer()
						if an and an.blockHighlighter then
							an.blockHighlighter:setRange(ai.Value)
							an.blockHighlighter.range = ai.Value
						end
					end)
				end)
				task.spawn(function()
					while M.Enabled do
						if O.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE ~= ag.Value + 2 then
							O.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = ag.Value + 2
						end
						pcall(function()
							local an = O.BlockBreakController:getBlockBreaker()
							if an and an:getRange() ~= ah.Value then
								an:setRange(ah.Value)
							end
						end)
						pcall(function()
							local an = O.BlockPlacementController:getBlockPlacer()
							if an and an.blockHighlighter then
								if an.blockHighlighter.range ~= ai.Value then
									an.blockHighlighter:setRange(ai.Value)
									an.blockHighlighter.range = ai.Value
								end
							end
						end)
						task.wait(0.5)
					end
				end)
			else
				O.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = aj or 14.4
				pcall(function()
					local an = O.BlockBreakController:getBlockBreaker()
					if an then
						an:setRange(ak or 18)
					end
				end)
				pcall(function()
					local an = O.BlockPlacementController:getBlockPlacer()
					if an and an.blockHighlighter then
						an.blockHighlighter:setRange(18)
						an.blockHighlighter.range = 18
					end
				end)
				if al then
					pcall(function()
						O.BlockEngine.isAllowedPlacement = al
					end)
				end
				aj, ak, al = nil, nil, nil
			end
		end,
		Tooltip = 'Extends reach for attacking, mining, and placing blocks'
	}
	ag = M:CreateSlider{
		Name = 'Attack Range',
		Min = 0,
		Max = 20,
		Default = 18,
		Function = function(am)
			if M.Enabled then
				O.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = am + 2
			end
		end,
		Suffix = function(am)
			return am == 1 and 'stud' or 'studs'
		end
	}
	ah = M:CreateSlider{
		Name = 'Mine Range',
		Min = 0,
		Max = 30,
		Default = 18,
		Function = function(am)
			if M.Enabled then
				pcall(function()
					local an = O.BlockBreakController:getBlockBreaker()
					if an then
						an:setRange(am)
					end
				end)
			end
		end,
		Suffix = function(am)
			return am == 1 and 'stud' or 'studs'
		end
	}
	ai = M:CreateSlider{
		Name = 'Place Range',
		Min = 0,
		Max = 30,
		Default = 18,
		Function = function(am)
			if M.Enabled then
				pcall(function()
					local an = O.BlockPlacementController:getBlockPlacer()
					if an and an.blockHighlighter then
						an.blockHighlighter:setRange(am)
						an.blockHighlighter.range = am
					end
				end)
			end
		end,
		Suffix = function(am)
			return am == 1 and 'stud' or 'studs'
		end
	}
end)
a(function()
	local ag, ah
	ag = v.Categories.Combat:CreateModule{
		Name = 'Sprint',
		Function = function(ai)
			if ai then
				if h.TouchEnabled then
					pcall(function()
						t.PlayerGui.MobileUI['4'].Visible = false
					end)
				end
				ah = O.SprintController.stopSprinting
				O.SprintController.stopSprinting = function(...)
					local aj = ah(...)
					O.SprintController:startSprinting()
					return aj
				end
				ag:Clean(B.Events.LocalAdded:Connect(function()
					task.delay(0.1, function()
						O.SprintController:stopSprinting()
					end)
				end))
				O.SprintController:stopSprinting()
			else
				if h.TouchEnabled then
					pcall(function()
						t.PlayerGui.MobileUI['4'].Visible = true
					end)
				end
				O.SprintController.stopSprinting = ah
				O.SprintController:stopSprinting()
			end
		end,
		Tooltip = 'Sets your sprinting to true.'
	}
end)
a(function()
	local ag, ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at = nil, nil, nil, nil, nil, nil, nil, nil, cloneRaycast(), 0, false, tick, task.wait, (- 1)
	ag = v.Categories.Combat:CreateModule{
		Name = 'TriggerBot',
		Function = function(au)
			if au then
				local av = 0
				repeat
					av = av + 1
					local aw, ax = false, isHoldingProjectile()
					if not O.AppController:isLayerOpen(O.UILayers.MAIN) and B.isAlive then
						if ai.Enabled and ax then
							if al.Enabled and not isFirstPerson() then
								aq = false
							else
								if ax and not aq then
									as(ak.Value)
									leftClick()
									ap = ar()
									aq = true
								elseif ax then
									local ay = ar()
									if (ay - ap) >= aj.Value then
										leftClick()
										ap = ay
									end
								else
									aq = false
								end
							end
						elseif L.hand.toolType == 'sword' and O.DaoController.chargingMaid == nil then
							local ay = L.hand.tool
							if ay ~= an then
								an = ay
								local az = O.ItemMeta[ay.Name]
								am = az and az.sword and az.sword.attackRange or 14.4
							end
							local az = am or 14.4
							if av % 2 == 0 then
								ao.FilterDescendantsInstances = {
									t.Character
								}
								local aA, aB, aC = t:GetMouse().UnitRay, B.character.RootPart.Position, az
								local aD = O.QueryUtil:raycast(aA.Origin, aA.Direction * 200, ao)
								if aD and (aB - aD.Instance.Position).Magnitude <= aC then
									local aE = B.List
									for aF = 1, # aE do
										local aG = aE[aF]
										aw = aG.Targetable and aD.Instance:IsDescendantOf(aG.Character) and (aB - aG.RootPart.Position).Magnitude <= aC
										if aw then
											break
										end
									end
								end
							end
							if not aw then
								aw = O.SwordController:getTargetInRegion(az or 11.399999999999999, 0)
							end
							if aw then
								O.SwordController:swingSwordAtMouse()
							end
						else
							aq = false
						end
					end
					if aw and not ax then
						as(1 / ah.GetRandomValue())
					else
						as(ax and 0.033 or 0.05)
					end
				until not ag.Enabled
			else
				am = nil
				an = nil
				at = - 1
				aq = false
			end
		end,
		Tooltip = 'Automatically swings when hovering over a entity'
	}
	ah = ag:CreateTwoSlider{
		Name = 'CPS',
		Min = 1,
		Max = 9,
		DefaultMin = 7,
		DefaultMax = 7
	}
	ai = ag:CreateToggle{
		Name = 'Projectile Mode',
		Tooltip = 'Auto-shoots crossbow/bow when holding projectile weapon'
	}
	aj = ag:CreateSlider{
		Name = 'Projectile Fire Rate',
		Min = 0.1,
		Max = 3,
		Default = 1.2,
		Decimal = 10,
		Suffix = function(au)
			return au == 1 and 'second' or 'seconds'
		end,
		Tooltip = 'How fast to auto-fire (1.2 = every 1.2 seconds)',
		Visible = function()
			return ai.Enabled
		end
	}
	ak = ag:CreateSlider{
		Name = 'Projectile Wait Delay',
		Min = 0,
		Max = 1,
		Default = 0,
		Decimal = 100,
		Suffix = 's',
		Tooltip = 'Delay before shooting (helps prevent ghosting)',
		Visible = function()
			return ai.Enabled
		end
	}
	al = ag:CreateToggle{
		Name = 'Projectile First Person Only',
		Default = false,
		Tooltip = 'Only works in first person mode',
		Visible = function()
			return ai.Enabled
		end
	}
	task.defer(function()
		if aj and aj.Object then
			aj.Object.Visible = false
		end
		if ak and ak.Object then
			ak.Object.Visible = false
		end
		if al and al.Object then
			al.Object.Visible = false
		end
	end)
end)
a(function()
	local ag, ah, ai, aj, ak, al, am, an = nil, nil, nil, nil, nil, nil, Random.new()
	local ao, ap, aq, ar, as, at = 0, false, 0.5, true, true, tick
	ag = v.Categories.Combat:CreateModule{
		Name = 'Velocity',
		Function = function(au)
			if au then
				an = O.KnockbackUtil.applyKnockback
				O.KnockbackUtil.applyKnockback = function(av, aw, ax, ay, ...)
					local az, aA = ah.Value, ai.Value
					if az == 100 and aA == 100 then
						return an(av, aw, ax, ay, ...)
					end
					local aB, aC = aj.Value, ak.Value
					local aD, aE, aF = (aB >= 100) or (aB > 0 and am:NextNumber(0, 100) <= aB), (aC >= 100) or (aC > 0 and am:NextNumber(0, 100) <= aC), true
					if al.Enabled then
						local aG = at()
						if aG - ao > aq then
							ao = aG
							local aH = B.EntityPosition{
								Range = 50,
								Part = 'RootPart',
								Players = true
							}
							ap = aH ~= nil
						end
						aF = ap
					end
					if not aF then
						return an(av, aw, ax, ay, ...)
					end
					if not aD and not aE then
						return an(av, aw, ax, ay, ...)
					end
					if ay then
						local aG = ay
						if aD and az ~= 100 then
							aG = {
								horizontal = (ay.horizontal or 1) * (az / 100),
								vertical = ay.vertical or 1
							}
							ay = aG
						end
						if aE and aA ~= 100 then
							if aG == ay then
								aG = {
									horizontal = ay.horizontal or 1,
									vertical = (ay.vertical or 1) * (aA / 100)
								}
							else
								aG.vertical = (ay.vertical or 1) * (aA / 100)
							end
							ay = aG
						end
					else
						local aG, aH = (aD and az ~= 100) and (az / 100) or 1, (aE and aA ~= 100) and (aA / 100) or 1
						ay = {
							horizontal = aG,
							vertical = aH
						}
					end
					return an(av, aw, ax, ay, ...)
				end
			else
				O.KnockbackUtil.applyKnockback = an
				ao = 0
				ap = false
			end
		end,
		Tooltip = 'Reduces knockback taken'
	}
	ah = ag:CreateSlider{
		Name = 'Horizontal',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%',
		Function = function(au)
			ar = au ~= 100
		end
	}
	aj = ag:CreateSlider{
		Name = 'Horizontal Chance',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%'
	}
	ai = ag:CreateSlider{
		Name = 'Vertical',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%',
		Function = function(au)
			as = au ~= 100
		end
	}
	ak = ag:CreateSlider{
		Name = 'Vertical Chance',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%'
	}
	al = ag:CreateToggle{
		Name = 'Only when targeting',
		Function = function(au)
			if not au then
				ap = false
				ao = 0
			end
		end
	}
end)
local ag
a(function()
	local ah, ai, aj, ak, al = (cloneRaycast())
	ah.RespectCanCollide = true
	local am, an, ao, ap, aq = math.huge, tick, task.wait, Vector3.new, Vector3.zero
	local ar, as, at = am, 0, 2
	local function getLowGround()
		local au = an()
		if au - as < at and ar ~= am then
			return ar
		end
		as = au
		local av, aw = am, O.BlockController:getStore()
		local ax = aw:getAllBlockPositions()
		for ay = 1, # ax do
			local az = ax[ay] * 3
			if az.Y < av and not getPlacedBlock(az + ap(0, 3, 0)) then
				av = az.Y
			end
		end
		ar = av
		return av
	end
	ai = v.Categories.Blatant:CreateModule{
		Name = 'AntiFall',
		Function = function(au)
			if au then
				repeat
					ao()
				until L.matchState ~= 0 or (not ai.Enabled)
				if not ai.Enabled then
					return
				end
				local av, aw = getLowGround(), an()
				if av ~= am then
					z = Instance.new'Part'
					z.Size = ap(10000, 1, 10000)
					z.Transparency = 1 - al.Opacity
					z.Material = Enum.Material[ak.Value]
					z.Color = Color3.fromHSV(al.Hue, al.Sat, al.Value)
					z.Position = ap(0, av - 2, 0)
					z.CanCollide = aj.Value == 'Collide'
					z.Anchored = true
					z.CanQuery = false
					z.Parent = workspace
					ai:Clean(z)
					ai:Clean(z.Touched:Connect(function(ax)
						if ax.Parent == t.Character and B.isAlive and aw < an() then
							aw = an() + 0.1
							if aj.Value == 'Normal' then
								local ay = getNearGround()
								if ay then
									local az, aA, aB, aC = t:GetAttribute'LastTeleported', 0, (v.Modules)
									local aD, aE, aF, aG, aH = aB.Fly, aB.InfiniteFly, aB.LongJump, ap(1, 0, 1), ap(0, 1, 0)
									aC = g.PreSimulation:Connect(function()
										aA = aA + 1
										if aA % 5 == 0 then
											if aD.Enabled or aE.Enabled or aF.Enabled then
												aC:Disconnect()
												ag = nil
												return
											end
										end
										if B.isAlive and t:GetAttribute'LastTeleported' == az then
											local aI = B.character.RootPart
											local aJ = aI.Position
											local aK = (ay - aJ) * aG
											ag = aK.Unit == aK.Unit and aK.Unit or aq
											aI.Velocity *= aG
											if aA % 3 == 0 then
												ah.FilterDescendantsInstances = {
													s,
													t.Character
												}
												ah.CollisionGroup = aI.CollisionGroup
												local aL = workspace:Raycast(aJ, ag, ah)
												if aL then
													for aM = 1, 5 do
														local aN = roundPos(aL.Position + aL.Normal * 1.5) + ap(0, 3, 0)
														if not getPlacedBlock(aN) then
															ay = ap(ay.X, av.Y, ay.Z)
															break
														end
													end
												end
											end
											local aL = ay.Y - aJ.Y
											aI.CFrame += ap(0, aL, 0)
											if not R.Speed then
												local aM = getSpeed()
												local aN = (ag * aM) + ap(0, aI.AssemblyLinearVelocity.Y, 0)
												aI.AssemblyLinearVelocity = aN
											end
											if aK.Magnitude < 1 then
												aC:Disconnect()
												ag = nil
											end
										else
											aC:Disconnect()
											ag = nil
										end
									end)
									ai:Clean(aC)
								end
							elseif aj.Value == 'Velocity' then
								local ay = B.character.RootPart.Velocity
								B.character.RootPart.Velocity = ap(ay.X, 100, ay.Z)
							end
						end
					end))
				end
			else
				ag = nil
				ar = am
				as = 0
			end
		end,
		Tooltip = "Help's you with your Parkinson's\nPrevents you from falling into the void."
	}
	aj = ai:CreateDropdown{
		Name = 'Move Mode',
		List = {
			'Normal',
			'Collide',
			'Velocity'
		},
		Function = function(au)
			if z then
				z.CanCollide = au == 'Collide'
			end
		end,
		Tooltip = 'Normal - Smoothly moves you towards the nearest safe point\nVelocity - Launches you upward after touching\nCollide - Allows you to walk on the part'
	}
	local au = {
		'ForceField'
	}
	for av, aw in Enum.Material:GetEnumItems() do
		if aw.Name ~= 'ForceField' then
			table.insert(au, aw.Name)
		end
	end
	ak = ai:CreateDropdown{
		Name = 'Material',
		List = au,
		Function = function(av)
			if z then
				z.Material = Enum.Material[av]
			end
		end
	}
	al = ai:CreateColorSlider{
		Name = 'Color',
		DefaultOpacity = 0.5,
		Function = function(av, aw, ax, ay)
			if z then
				z.Color = Color3.fromHSV(av, aw, ax)
				z.Transparency = 1 - ay
			end
		end
	}
end)
a(function()
	local ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at, au, av = string.lower, string.find, task.wait, l, {}, {}, 0, 5
	local function isBed(aw)
		if not aw then
			return false
		end
		local ax = al[aw]
		if ax ~= nil then
			return ax
		end
		local ay = false
		pcall(function()
			if ak:HasTag(aw, 'bed') or (aw.Parent and ak:HasTag(aw.Parent, 'bed')) then
				ay = true
			elseif ai(ah(aw.Name), 'bed', 1, true) then
				ay = true
			end
		end)
		al[aw] = ay
		return ay
	end
	local aw = {}
	local function updateBlacklistCache()
		if not at or not at.ListEnabled then
			return
		end
		aw = {}
		for ax, ay in pairs(at.ListEnabled) do
			table.insert(aw, ah(ay))
		end
	end
	local function isBlacklisted(ax)
		if not ax or # aw == 0 then
			return false
		end
		local ay = am[ax]
		if ay ~= nil then
			return ay
		end
		local az, aA = ah(ax.Name), false
		for aB = 1, # aw do
			if ai(az, aw[aB], 1, true) then
				aA = true
				break
			end
		end
		am[ax] = aA
		return aA
	end
	local function shouldSkip(ax)
		if not ax then
			return false
		end
		if ar and ar.Enabled and isBed(ax) then
			return true
		end
		if as and as.Enabled and isBlacklisted(ax) then
			return true
		end
		return false
	end
	local ax, ay, az = 0, 0.05, false
	local function updateBreakSpeed()
		if not ap or not ap.Enabled then
			return
		end
		local aA = tick()
		if aA - ax < ay then
			az = true
			return
		end
		ax = aA
		az = false
		pcall(function()
			local aB = (shouldSkip(au)) and 0.3 or aq.Value
			O.BlockBreakController.blockBreaker:setCooldown(aB)
		end)
	end
	ap = v.Categories.Blatant:CreateModule{
		Name = 'FastBreak',
		Function = function(aA)
			if aA then
				av = O.BlockBreaker.hitBlock
				local aB
				O.BlockBreaker.hitBlock = function(aC, aD, aE, ...)
					local aF
					pcall(function()
						local aG = aC.clientManager:getBlockSelector():getMouseInfo(1, {
							ray = aE
						})
						if aG and aG.target and aG.target.blockInstance then
							aF = aG.target.blockInstance
						end
					end)
					local aG = L.inventory and L.inventory.hotbarSlot
					local aH = aG ~= aB
					if aH then
						aB = aG
					end
					if aF ~= au or aH then
						au = aF
						updateBreakSpeed()
					end
					return av and av(aC, aD, aE, ...)
				end
				updateBlacklistCache()
				task.spawn(function()
					while ap.Enabled do
						if tick() - an > ao then
							an = tick()
							al = {}
							am = {}
						end
						if az then
							updateBreakSpeed()
						end
						aj(0.5)
					end
				end)
			else
				pcall(function()
					O.BlockBreakController.blockBreaker:setCooldown(0.3)
				end)
				if av then
					O.BlockBreaker.hitBlock = av
					av = nil
				end
				au = nil
				lastHotbarSlot = nil
				al, am, aw = {}, {}, {}
			end
		end,
		Tooltip = 'Decreases block hit cooldown'
	}
	aq = ap:CreateSlider{
		Name = 'Break speed',
		Min = 0,
		Max = 0.3,
		Default = 0.25,
		Decimal = 100,
		Suffix = 'seconds',
		Function = function()
			updateBreakSpeed()
		end
	}
	ar = ap:CreateToggle{
		Name = 'Bed Check',
		Default = false,
		Tooltip = 'Use normal break speed when breaking beds',
		Function = function()
			al = {}
			updateBreakSpeed()
		end
	}
	as = ap:CreateToggle{
		Name = 'Blacklist Blocks',
		Default = false,
		Tooltip = 'Use normal break speed on blacklisted blocks',
		Function = function(aA)
			if at then
				at.Object.Visible = aA
			end
			am = {}
			if aA then
				updateBlacklistCache()
			end
			updateBreakSpeed()
		end
	}
	at = ap:CreateTextList{
		Name = 'Blacklisted Blocks',
		Placeholder = 'bed',
		Visible = false,
		Function = function()
			updateBlacklistCache()
			am = {}
			updateBreakSpeed()
		end
	}
	task.defer(function()
		if at and at.Object then
			at.Object.Visible = false
		end
	end)
end)
local ah, ai
a(function()
	local aj, ak, al, am, an, ao, ap, aq, ar, as = false, {
		Enabled = false
	}, (RaycastParams.new())
	al.RespectCanCollide = true
	local at, au, av = 0, 0
	local aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO = nil, {}, false, false, 0, 2.5, tick, task.wait, math.max, math.floor, string.format, Vector3.new, Vector3.zero, UDim2.new, CFrame.lookAlong, 0, 0, 0.2, 0
	local W, X = aC(), 0
	local function createMobileButton(Y, Z, _)
		local aP = Instance.new'TextButton'
		aP.Name = Y
		aP.Size = aJ(0, 60, 0, 60)
		aP.Position = Z
		aP.BackgroundTransparency = 0.2
		aP.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		aP.BorderSizePixel = 0
		aP.Text = _
		aP.TextScaled = true
		aP.TextColor3 = Color3.fromRGB(255, 255, 255)
		aP.Font = Enum.Font.SourceSansBold
		local aQ = Instance.new'UICorner'
		aQ.CornerRadius = UDim.new(0, 8)
		aQ.Parent = aP
		return aP
	end
	local function cleanupMobileControls()
		for aP, aQ in pairs(ax) do
			if aQ then
				aQ:Destroy()
			end
		end
		ax = {}
	end
	local aP = 0
	local function updateProgressBar()
		if not as then
			return
		end
		if not B.isAlive then
			as.Visible = false
			return
		end
		local aQ = aC()
		if aQ - aM > aN then
			aM = aQ
			aL = t.Character:GetAttribute'InflatedBalloons' or 0
			aO = L.matchState
		end
		local Y = aL > 0 or aO == 2
		if Y then
			as.Frame.Size = aJ(1, 0, 0, 20)
			as.TextLabel.Text = '\u{221e}'
			as.Visible = ak.Enabled
			return
		end
		aP = aP + 1
		if aP % 3 == 0 then
			local Z = B.character.Humanoid.HipHeight
			local _ = B.character.HumanoidRootPart.Position + aH(0, (Z * - 2) - 1, 0)
			local aR = getPlacedBlock(_)
			ay = aR ~= nil
		end
		if ay then
			aw = nil
			az = false
			aA = aQ
			as.Frame.Size = aJ(1, 0, 0, 20)
			as.TextLabel.Text = aG('%.1fs', aB)
			as.Visible = ak.Enabled and ah.Enabled
			local aR = as.Frame:FindFirstChild'Tween'
			if aR then
				aR:Destroy()
			end
		else
			if not aw then
				aw = aQ + aB
				az = false
			end
			local aR = aE(0, aw - aQ)
			local Z = aR / aB
			as.Frame.Size = aJ(Z, 0, 0, 20)
			as.TextLabel.Text = aG('%.1fs', aR)
			as.Visible = ak.Enabled and ah.Enabled
			if aR <= 0 and not az then
				az = true
			end
		end
		aj = ay
	end
	ah = v.Categories.Blatant:CreateModule{
		Name = 'Fly',
		Function = function(aQ)
			R.Fly = aQ or nil
			updateVelocity()
			if aQ then
				at, au, av = 0, 0, O.BalloonController.deflateBalloon
				O.BalloonController.deflateBalloon = function()
				end
				local aR, Y, Z = aC(), true
				if t.Character and (t.Character:GetAttribute'InflatedBalloons' or 0) == 0 and getItem'balloon' then
					O.BalloonController:inflateBalloon()
				end
				ah:Clean(b.AttributeChanged.Event:Connect(function(_)
					if _ == 'InflatedBalloons' then
						aL = t.Character:GetAttribute'InflatedBalloons' or 0
						if aL == 0 and getItem'balloon' then
							O.BalloonController:inflateBalloon()
						end
					end
				end))
				local _ = 0
				ah:Clean(g.RenderStepped:Connect(function(aS)
					if ak.Enabled and ah.Enabled then
						_ = _ + 1
						if _ % 2 == 0 then
							updateProgressBar()
						end
					end
				end))
				local aS, aT, aU = 0, 0, 0.05
				ah:Clean(g.PreSimulation:Connect(function(aV)
					if B.isAlive and r(B.character.RootPart) then
						aS = aS + 1
						local aW = aC()
						if aS % 12 == 0 then
							aL = t.Character:GetAttribute'InflatedBalloons' or 0
							aO = L.matchState
						end
						local aX = B.character.Humanoid
						if aX.FloorMaterial ~= Enum.Material.Air then
							W = aW
						end
						X = aW - W
						local aY, aZ = aL > 0 or aO == 2, (aW % 0.4 < 0.2) and - 1 or 1
						local a_, a0, a1, a2 = (1.95 + (aY and 6 or 0) * aZ) + ((at + au) * an.Value), B.character.RootPart, B.character.Humanoid.MoveDirection, getSpeed()
						local a3 = (a1 * aE(am.Value - a2, 0) * aV)
						if ao.Enabled and (aW - aT) > aU then
							aT = aW
							al.FilterDescendantsInstances = {
								t.Character,
								s,
								AntiVoidPart
							}
							al.CollisionGroup = a0.CollisionGroup
							local a4 = workspace:Raycast(a0.Position, a3, al)
							if a4 then
								a3 = ((a4.Position + a4.Normal) - a0.Position)
							end
						end
						if not aY then
							if Y then
								if X > 2 then
									if not Z then
										al.FilterDescendantsInstances = {
											t.Character,
											s,
											AntiVoidPart
										}
										al.CollisionGroup = a0.CollisionGroup
										local a4 = workspace:Raycast(a0.Position, aH(0, - 1E3, 0), al)
										if a4 and aq.Enabled then
											Y = false
											Z = a0.Position.Y
											aR = aW + 0.11
											a0.CFrame = aK(aH(a0.Position.X, a4.Position.Y + B.character.HipHeight, a0.Position.Z), a0.CFrame.LookVector)
										end
									end
								end
							else
								if Z then
									if aR < aW then
										local a4 = aH(a0.Position.X, Z, a0.Position.Z)
										a0.CFrame = aK(a4, a0.CFrame.LookVector)
										Y = true
										Z = nil
									else
										a_ = 0
									end
								end
							end
						end
						a0.CFrame += a3
						a0.AssemblyLinearVelocity = (a1 * a2) + aH(0, a_, 0)
					end
				end))
				local aV = h.TouchEnabled and not h.KeyboardEnabled and not h.MouseEnabled
				local aW = ar.Enabled or aV
				if aW then
					local aX = Instance.new'ScreenGui'
					aX.Name = 'FlyControls'
					aX.ResetOnSpawn = false
					aX.Parent = t.PlayerGui
					local aY, aZ = createMobileButton('UpButton', aJ(0.9, - 70, 0.7, - 140), '\u{2191}'), createMobileButton('DownButton', aJ(0.9, - 70, 0.7, - 70), '\u{2193}')
					ax.UpButton = aY
					ax.DownButton = aZ
					ax.ScreenGui = aX
					aY.Parent = aX
					aZ.Parent = aX
					ah:Clean(aY.MouseButton1Down:Connect(function()
						at = 1
					end))
					ah:Clean(aY.MouseButton1Up:Connect(function()
						at = 0
					end))
					ah:Clean(aZ.MouseButton1Down:Connect(function()
						au = - 1
					end))
					ah:Clean(aZ.MouseButton1Up:Connect(function()
						au = 0
					end))
				end
				ah:Clean(h.InputBegan:Connect(function(aX)
					if not h:GetFocusedTextBox() then
						if aX.KeyCode == Enum.KeyCode.Space or aX.KeyCode == Enum.KeyCode.ButtonA then
							at = 1
						elseif aX.KeyCode == Enum.KeyCode.LeftShift or aX.KeyCode == Enum.KeyCode.ButtonL2 then
							au = - 1
						end
					end
				end))
				ah:Clean(h.InputEnded:Connect(function(aX)
					if aX.KeyCode == Enum.KeyCode.Space or aX.KeyCode == Enum.KeyCode.ButtonA then
						at = 0
					elseif aX.KeyCode == Enum.KeyCode.LeftShift or aX.KeyCode == Enum.KeyCode.ButtonL2 then
						au = 0
					end
				end))
				if h.TouchEnabled then
					pcall(function()
						local aX = t.PlayerGui.TouchGui.TouchControlFrame.JumpButton
						ah:Clean(aX:GetPropertyChangedSignal'ImageRectOffset':Connect(function()
							if not ax.UpButton then
								at = aX.ImageRectOffset.X == 146 and 1 or 0
							end
						end))
					end)
				end
			else
				if as then
					as.Visible = false
				end
				aj = nil
				aw = nil
				az = false
				O.BalloonController.deflateBalloon = av
				if ap.Enabled and B.isAlive and (t.Character:GetAttribute'InflatedBalloons' or 0) > 0 then
					for aR = 1, 3 do
						O.BalloonController:deflateBalloon()
					end
				end
				cleanupMobileControls()
				aL = 0
				aM = 0
				aO = 0
			end
		end,
		ExtraText = function()
			return 'Heatseeker'
		end,
		Tooltip = 'Makes you go zoom.'
	}
	am = ah:CreateSlider{
		Name = 'Speed',
		Min = 1,
		Max = 23,
		Default = 23,
		Suffix = function(aQ)
			return aQ == 1 and 'stud' or 'studs'
		end
	}
	an = ah:CreateSlider{
		Name = 'Vertical Speed',
		Min = 1,
		Max = 150,
		Default = 50,
		Suffix = function(aQ)
			return aQ == 1 and 'stud' or 'studs'
		end
	}
	ao = ah:CreateToggle{
		Name = 'Wall Check',
		Default = true
	}
	ap = ah:CreateToggle{
		Name = 'Pop Balloons',
		Default = true
	}
	ak = ah:CreateToggle{
		Name = 'Progress Bar',
		Function = function(aQ)
			if aQ then
				as = Instance.new'Frame'
				as.AnchorPoint = Vector2.new(0.5, 0)
				as.Position = aJ(0.5, 0, 1, - 200)
				as.Size = aJ(0.2, 0, 0, 20)
				as.BackgroundTransparency = 0.5
				as.BorderSizePixel = 0
				as.BackgroundColor3 = Color3.new(0, 0, 0)
				as.Visible = false
				as.Parent = v.gui
				local aR = Instance.new'Frame'
				aR.Name = 'Frame'
				aR.AnchorPoint = Vector2.new(0, 0)
				aR.Position = aJ(0, 0, 0, 0)
				aR.Size = aJ(1, 0, 0, 20)
				aR.BackgroundTransparency = 0
				aR.BorderSizePixel = 0
				aR.BackgroundColor3 = Color3.fromHSV(v.GUIColor.Hue, v.GUIColor.Sat, v.GUIColor.Value)
				aR.Visible = true
				aR.Parent = as
				local aS = Instance.new'TextLabel'
				aS.Name = 'TextLabel'
				aS.Text = '2.5s'
				aS.Font = Enum.Font.Gotham
				aS.TextStrokeTransparency = 0
				aS.TextColor3 = Color3.new(0.9, 0.9, 0.9)
				aS.TextSize = 20
				aS.Size = aJ(1, 0, 1, 0)
				aS.BackgroundTransparency = 1
				aS.Position = aJ(0, 0, 0, 0)
				aS.Parent = as
			else
				if as then
					as:Destroy()
					as = nil
				end
			end
		end,
		Tooltip = 'show amount of Fly time',
		Default = true
	}
	aq = ah:CreateToggle{
		Name = 'TP Down',
		Default = true
	}
	ar = ah:CreateToggle{
		Name = 'Mobile Buttons',
		Function = function()
			if ah.Enabled then
				ah:Toggle()
				ah:Toggle()
			end
		end
	}
end)
a(function()
	local aj, ak, al, am, an, ao, ap, aq, ar, as, at, au, av, aw, ax, ay = {}, {}, false, false, tick, task.wait, Vector3.new, Vector3.one, {
		Red = Color3.fromRGB(255, 0, 0),
		Blue = Color3.fromRGB(0, 100, 255),
		Green = Color3.fromRGB(0, 255, 0),
		Yellow = Color3.fromRGB(255, 255, 0),
		Orange = Color3.fromRGB(255, 140, 0),
		Purple = Color3.fromRGB(180, 0, 255),
		White = Color3.fromRGB(255, 255, 255),
		Cyan = Color3.fromRGB(0, 255, 255),
		Pink = Color3.fromRGB(255, 50, 150),
		Black = Color3.fromRGB(0, 0, 0)
	}
	local function shouldCreateHitbox(az)
		if not az.Targetable then
			return false
		end
		if az.Player and ax and ax.Players and ax.Players.Enabled then
			return true
		end
		if not az.Player and ax and ax.NPCs and ax.NPCs.Enabled then
			return true
		end
		return false
	end
	local az = RaycastParams.new()
	az.FilterType = Enum.RaycastFilterType.Exclude
	local function isTargetBehindWall(aA)
		if not ax or not ax.Walls or not ax.Walls.Enabled then
			return false
		end
		if not aA.RootPart then
			return false
		end
		local aB, aC = B.character.RootPart.Position, aA.RootPart.Position
		local aD = aC - aB
		az.FilterDescendantsInstances = {
			B.character,
			aA.Character
		}
		local aE = workspace:Raycast(aB, aD, az)
		if aE then
			local aF, aG = (aE.Position - aB).Magnitude, aD.Magnitude
			if aF < aG - 0.5 then
				return true
			end
		end
		return false
	end
	local aA, aB = ap(3, 6, 3), 0
	local function updateExpandSize(aC)
		if aC ~= aB then
			aB = aC
			aA = ap(3, 6, 3) + aq * (aC / 5)
		end
	end
	local function createHitbox(aC)
		if not shouldCreateHitbox(aC) then
			return
		end
		if isTargetBehindWall(aC) then
			return
		end
		if aj[aC] then
			return
		end
		local aD = Instance.new'Part'
		aD.Size = aA
		aD.Position = aC.RootPart.Position
		aD.CanCollide = false
		aD.Massless = true
		aD.Transparency = av and av.Enabled and 0.5 or 1
		if av and av.Enabled and aw then
			aD.Color = ar[aw.Value] or ar.Red
		end
		aD.Parent = aC.Character
		local aE = Instance.new'Motor6D'
		aE.Part0 = aD
		aE.Part1 = aC.RootPart
		aE.Parent = aD
		aj[aC] = aD
	end
	local aC, aD = 0, 0.1
	local function handleAutoToggle()
		if not au.Enabled or as.Value ~= 'Player' then
			return
		end
		local aE = an()
		if aE - aC < aD then
			return
		end
		local aF = isSword()
		if aF ~= al then
			al = aF
			aC = aE
			if aF then
				if not N.Enabled and not am then
					N:Toggle()
				end
			else
				if N.Enabled then
					am = false
					N:Toggle()
				end
			end
		end
	end
	local function refreshAllHitboxes()
		for aE, aF in pairs(aj) do
			aF:Destroy()
		end
		table.clear(aj)
		local aE = B.List
		for aF = 1, # aE do
			createHitbox(aE[aF])
		end
	end
	N = v.Categories.Blatant:CreateModule{
		Name = 'HitBoxes',
		Function = function(aE)
			if aE then
				am = false
				updateExpandSize(at.Value)
				if as.Value == 'Sword' then
					debug.setconstant(O.SwordController.swingSwordInRegion, 6, (at.Value / 3))
					ak = true
				else
					N:Clean(B.Events.EntityAdded:Connect(function(aF)
						createHitbox(aF)
					end))
					N:Clean(B.Events.EntityRemoving:Connect(function(aF)
						local aG = aj[aF]
						if aG then
							aG:Destroy()
							aj[aF] = nil
						end
					end))
					refreshAllHitboxes()
					local aF = 0
					N:Clean(g.Heartbeat:Connect(function()
						if not ax or not ax.Walls or not ax.Walls.Enabled then
							return
						end
						aF = aF + 1
						if aF % 6 ~= 0 then
							return
						end
						for aG, aH in pairs(aj) do
							if isTargetBehindWall(aG) then
								aH:Destroy()
								aj[aG] = nil
							end
						end
						local aG = B.List
						for aH = 1, # aG do
							local aI = aG[aH]
							if not aj[aI] then
								createHitbox(aI)
							end
						end
					end))
				end
			else
				if au.Enabled and isSword() then
					am = true
				end
				if ak then
					debug.setconstant(O.SwordController.swingSwordInRegion, 6, 3.8)
					ak = nil
				end
				for aF, aG in pairs(aj) do
					aG:Destroy()
				end
				table.clear(aj)
				if not au.Enabled then
					al = false
				end
			end
		end,
		Tooltip = 'Expands attack hitbox'
	}
	ax = N:CreateTargets{
		Players = true,
		Walls = false,
		NPCs = false,
		Function = function()
			if N.Enabled and as.Value == 'Player' then
				refreshAllHitboxes()
			end
		end
	}
	as = N:CreateDropdown{
		Name = 'Mode',
		List = {
			'Sword',
			'Player'
		},
		Function = function(aE)
			local aF = aE == 'Player'
			if au then
				au.Object.Visible = aF
			end
			if av then
				av.Object.Visible = aF
			end
			if aw then
				aw.Object.Visible = aF and av.Enabled
			end
			if N.Enabled then
				N:Toggle()
				N:Toggle()
			end
		end,
		Tooltip = 'Sword - Increases the range around you to hit entities\nPlayer - Increases the players hitbox'
	}
	at = N:CreateSlider{
		Name = 'Expand amount',
		Min = 0,
		Max = 50,
		Default = 14.4,
		Decimal = 10,
		Function = function(aE)
			updateExpandSize(aE)
			if N.Enabled then
				if as.Value == 'Sword' then
					debug.setconstant(O.SwordController.swingSwordInRegion, 6, (aE / 3))
				else
					for aF, aG in pairs(aj) do
						aG.Size = aA
					end
				end
			end
		end,
		Suffix = function(aE)
			return aE == 1 and 'stud' or 'studs'
		end
	}
	local aE = 0
	au = N:CreateToggle{
		Name = 'Auto Toggle',
		Default = false,
		Tooltip = 'Automatically enables hitbox when holding a sword',
		Function = function(aF)
			if aF then
				if ay then
					ay:Disconnect()
				end
				al = false
				aE = 0
				ay = g.Heartbeat:Connect(function()
					aE = aE + 1
					if aE % 5 == 0 then
						handleAutoToggle()
					end
				end)
				N:Clean(ay)
				handleAutoToggle()
			else
				if ay then
					ay:Disconnect()
					ay = nil
				end
				al = false
			end
		end
	}
	av = N:CreateToggle{
		Name = 'Visible',
		Default = false,
		Tooltip = 'Makes the hitbox visible on screen',
		Function = function(aF)
			if aw then
				aw.Object.Visible = aF
			end
			if N.Enabled and as.Value == 'Player' then
				local aG, aH = aF and 0.5 or 1, aF and aw and (ar[aw.Value] or ar.Red) or nil
				for aI, aJ in pairs(aj) do
					aJ.Transparency = aG
					if aH then
						aJ.Color = aH
					end
				end
			end
		end
	}
	aw = N:CreateDropdown{
		Name = 'Hitbox Color',
		List = {
			'Red',
			'Blue',
			'Green',
			'Yellow',
			'Orange',
			'Purple',
			'White',
			'Cyan',
			'Pink',
			'Black'
		},
		Default = 'Red',
		Visible = false,
		Tooltip = 'Color of the visible hitbox',
		Function = function(aF)
			if N.Enabled and as.Value == 'Player' and av.Enabled then
				local aG = ar[aF] or ar.Red
				for aH, aI in pairs(aj) do
					aI.Color = aG
				end
			end
		end
	}
	task.spawn(function()
		repeat
			ao()
		until as and as.Value
		local aF = as.Value == 'Player'
		au.Object.Visible = aF
		av.Object.Visible = aF
	end)
	task.defer(function()
		if aw and aw.Object then
			aw.Object.Visible = false
		end
	end)
end)
a(function()
	v.Categories.Blatant:CreateModule{
		Name = 'KeepSprint',
		Function = function(aj)
			debug.setconstant(O.SprintController.startSprinting, 5, aj and 'blockSprinting' or 'blockSprint')
			O.SprintController:stopSprinting()
		end,
		Tooltip = 'Lets you sprint with a speed potion.'
	}
end)
local aj
a(function()
	local ak, al, am, an, ao, ap, aq, ar, as, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP, aQ, aR, aS, aT, aU, aV, aW, aX, aY, aZ, a_, a0, a1 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0, 0, 0, nil, nil, nil, 0, nil, nil, 0, 0, {}, {}, v.Libraries.auraanims, tick()
	local a2, a3, a4, W, X, Y, Z, _, a5, a6, a7, a8, a9, ba, bb, bc, bd, be, bf, bg, bh, bi = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0, 10, {
		InvokeServer = function()
		end
	}, {}, tick(), 1
	task.spawn(function()
		a2 = O.Client:Get(P.AttackEntity)
		bf = O.Client:Get(P.FireProjectile).instance
	end)
	local function optimizeHitData(bj, bk)
		local bl, bm, bn, bo = (bk - bj).Unit, (bj - bk).Magnitude, bj, bk
		if bm > 18 then
			bn = bj + (bl * 2.2)
			bo = bk - (bl * 0.5)
		elseif bm > 14.4 then
			bn = bj + (bl * 1.8)
			bo = bk - (bl * 0.3)
		elseif bm > 10 then
			bn = bj + (bl * 1.2)
		else
			bn = bj + (bl * 0.6)
		end
		bn = bn + Vector3.new(0, 0.8, 0)
		bo = bo + Vector3.new(0, 1.2, 0)
		return bn, bo
	end
	local function canHitWithCustomReg()
		if not a4 or not a4.Enabled then
			return true
		end
		if not W then
			return true
		end
		local bj, bk = tick(), W.Value
		local bl = 1 / bk
		if bj - bd >= bl then
			bd = bd + bl
			if bj - bd > bl then
				bd = bj
			end
			return true
		end
		return false
	end
	local function FireAttackRemote(bj, ...)
		if not a2 then
			return
		end
		if not canHitWithCustomReg() then
			return
		end
		local bk, bl = pcall(function()
			return e:GetPlayerFromCharacter(bj.entityInstance)
		end)
		local bm, bn = bj.validate.selfPosition.value, bj.validate.targetPosition.value
		local bo = (bm - bn).Magnitude
		L.attackReach = (bo * 100) // 1 / 100
		L.attackReachUpdate = tick() + 1
		if bo > 14.4 and bo <= 30 then
			local bp, bq, br = (bn - bm).Unit, math.min(bo - 14.3, 8), math.min(bo - 14.3, 4)
			local bs, bt = bm + (bp * bq), bn - (bp * br)
			local bu = (bs - bt).Magnitude
			if bu <= 14.4 then
				bj.validate.selfPosition.value = bs
				bj.validate.targetPosition.value = bt
				local bv = bm + (bp * math.min(bo - 12, 15))
				bj.validate.raycast = bj.validate.raycast or {}
				bj.validate.raycast.cameraPosition = {
					value = bv
				}
				bj.validate.raycast.cursorDirection = {
					value = bp
				}
			end
		end
		if bc.Enabled then
			newselfpos, newtargetpos = optimizeHitData(bj.validate.selfPosition.value, bj.validate.targetPosition.value)
			bj.validate.selfPosition.value = newselfpos
			bj.validate.targetPosition.value = newtargetpos
		end
		if bk and bl then
			if not select(2, H:get(bl)) then
				return
			end
		end
		return a2:SendToServer(bj, ...)
	end
	local function createRangeCircle()
		local bj = pcall(function()
			if (not shared.CheatEngineMode) then
				aq = Instance.new'MeshPart'
				aq.MeshId = 'rbxassetid://3726303797'
				if shared.RiseMode and GuiLibrary.GUICoreColor and GuiLibrary.GUICoreColorChanged then
					aq.Color = GuiLibrary.GUICoreColor
					GuiLibrary.GUICoreColorChanged.Event:Connect(function()
						aq.Color = GuiLibrary.GUICoreColor
					end)
				else
					aq.Color = Color3.fromHSV(ax.Hue, ax.Sat, ax.Value)
				end
				aq.CanCollide = false
				aq.Anchored = true
				aq.Material = Enum.Material.Neon
				aq.Size = Vector3.new(an.Value * 0.7, 0.01, an.Value * 0.7)
				if ak.Enabled then
					aq.Parent = s
				end
				aq:SetAttribute('gamecore_GameQueryIgnore', true)
			end
		end)
		if (not bj) then
			pcall(function()
				if aq then
					aq:Destroy()
					aq = nil
				end
				notif('Killaura - Range Visualiser Circle', 'There was an error creating the circle. Disabling...', 2)
			end)
		end
	end
	local function getAttackData()
		if aP and aP.Enabled then
			if isFrozen(nil, be) then
				return false
			end
		end
		if au.Enabled then
			local bj = aK.Enabled and (tick() - O.SwordController.lastSwing) <= 0.2
			if not bj then
				local bk = h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
				if not bk then
					return false
				end
			end
		end
		if aw.Enabled then
			if O.AppController:isLayerOpen(O.UILayers.MAIN) then
				return false
			end
		end
		local bj = aJ.Enabled and L.hand or L.tools.sword
		if not bj or not bj.tool then
			return false
		end
		local bk = O.ItemMeta[bj.tool.Name]
		if aJ.Enabled then
			if L.hand.toolType ~= 'sword' or O.DaoController.chargingMaid then
				return false
			end
		end
		if aK.Enabled then
			if (tick() - O.SwordController.lastSwing) > 0.2 then
				return false
			end
		end
		if aQ.Enabled then
			local bl = aR.Value
			return bj, bk, (tick() - aM) >= bl
		else
			return bj, bk, true
		end
	end
	local function resetSwordCooldown()
		if O.SwordController then
			O.SwordController.lastAttack = 0
			O.SwordController.lastSwing = 0
			if O.SwordController.lastChargedAttackTimeMap then
				for bj, bk in pairs(O.SwordController.lastChargedAttackTimeMap) do
					O.SwordController.lastChargedAttackTimeMap[bj] = 0
				end
			end
		end
	end
	local function shouldContinueSwinging()
		if not aT.Enabled then
			return false
		end
		if aV == 0 then
			return false
		end
		local bj, bk = tick() - aV, aU.Value
		if bj <= bk then
			return true
		end
		return false
	end
	local function getAmmo(bj)
		for bk, bl in L.inventory.inventory.items do
			if bj.ammoItemTypes and table.find(bj.ammoItemTypes, bl.itemType) then
				return bl.itemType
			end
		end
		return
	end
	local function getProjectiles()
		local bj = {}
		for bk, bl in L.inventory.inventory.items do
			local bm = O.ItemMeta[bl.itemType].projectileSource
			local bn = bm and getAmmo(bm)
			if bn and table.find({
				'arrow'
			}, bn) then
				table.insert(bj, {
					bl,
					bn,
					bm.projectileType(bn),
					bm
				})
			end
		end
		return bj
	end
	local function canShoot(bj)
		return tick() > (bg[bj[1].itemType] or 0)
	end
	local function shootFunc(bj, bk, bl, bm, bn, bo, bp)
		local bq = O.ProjectileMeta[bl]
		local br, bs, bt = bq.launchVelocity, bq.gravitationalAcceleration or 196.2
		bt = switchItem(bj.tool, 0.05)
		local bu = bo.RootPart
		local bv, bw, bx = bu.Velocity, workspace.Gravity, bo.Character and bo.Character:GetAttribute'InflatedBalloons'
		if bx and bx > 0 then
			bw = workspace.Gravity * (1 - (bx >= 4 and 1.2 or bx >= 3 and 1 or 0.975))
		end
		if bo.Character and bo.Character.PrimaryPart and bo.Character.PrimaryPart:FindFirstChild'rbxassetid://8200754399' then
			bw = 6
		end
		if bo.Player and bo.Player:GetAttribute'IsOwlTarget' then
			for by, bz in ipairs(l:GetTagged'Owl') do
				if bz:GetAttribute'Target' == bo.Player.UserId and bz:GetAttribute'Status' == 2 then
					bw = 0
					break
				end
			end
		end
		local by, bz, bA = O.BowConstantsTable.RelX or 0, O.BowConstantsTable.RelY or 0, O.BowConstantsTable.RelZ or 0
		local bB = CFrame.new(bn, bu.Position) * CFrame.new(Vector3.new(by, bz, bA))
		local bC = I.SolveTrajectory(bB.p, br, bs, bu.Position, bv, bw, bo.HipHeight, bo.Jumping and 42.6 or nil, RaycastParams.new())
		if bC then
			C.Targets[bo] = tick() + 1
			task.spawn(function()
				local bD, bE, bF = CFrame.lookAt(bB.Position, bC).LookVector, j:GenerateGUID(true), (CFrame.new(bB.Position, bC) * CFrame.new(Vector3.new(- by, - bz, - bA))).Position
				O.ProjectileController:createLocalProjectile(bq, bk, bl, bF, bE, bD * br, {
					drawDurationSeconds = 1
				})
				local bG = bf:InvokeServer(bj.tool, bk, bl, bF, bn, bD * br, bE, {
					drawDurationSeconds = 1,
					shotId = j:GenerateGUID(false)
				}, workspace:GetServerTimeNow() - 0.045)
				if not bG then
					bg[bj.itemType] = tick()
				else
					bG.Parent = f
					local bH = bm.launchSound
					bH = bH and bH[math.random(1, # bH)] or nil
					if bH then
						O.SoundManager:playSound(bH)
					end
				end
			end)
			bg[bj.itemType] = tick() + bm.fireDelaySec
			if bt and not bp then
				task.wait(0.05)
			end
		end
	end
	local function doFastHitsNEW(bj)
		if not bj or not bj.RootPart then
			return
		end
		local bk, bl = B.character.RootPart.Position, getProjectiles()
		NEWFastHitsUsage += 1
		if not bl[NEWFastHitsUsage] then
			NEWFastHitsUsage = 1
		end
		if bl and bl[NEWFastHitsUsage] and canShootNEW(bl[NEWFastHitsUsage]) then
			local bm, bn, bo, bp = unpack(bl[NEWFastHitsUsage])
			shootFuncNEW(bm, bn, bo, bp, bk, bj)
		end
	end
	cloneRaycast()
	local function doFastHitsVirtualInput(bj)
		if not bj or not bj.RootPart then
			return
		end
		if not hasArrows() then
			return
		end
		if a8.Enabled and not isFirstPerson() then
			return
		end
		local bk = tick()
		if (bk - lastAutoShootTime) < bb.Value then
			return
		end
		local bl = getBows()
		if # bl == 0 then
			return
		end
		local bm, bn = bl[1], L.inventory.hotbarSlot
		if hotbarSwitch(bm) then
			task.wait(ba.Value)
			local bo = L.inventory.hotbar[bm + 1]
			if bo and bo.item then
				local bp = O.ItemMeta[bo.item.itemType]
				if bp and bp.projectileSource then
					local bq = bp.projectileSource
					if bq.ammoItemTypes and # bq.ammoItemTypes > 0 then
						local br, bs = (bq.ammoItemTypes[1])
						if type(bq.projectileType) == 'function' then
							local bt, bu = pcall(function()
								return bq.projectileType(br)
							end)
							if bt then
								bs = bu
							end
						else
							bs = bq.projectileType
						end
						if bs then
							local bt = B.character.RootPart.Position
							if a9.Value > 0 then
								task.wait(a9.Value)
							end
							local bu = O.ProjectileMeta[bs]
							local bv, bw = bu.launchVelocity, bu.gravitationalAcceleration or 196.2
							local bx = I.SolveTrajectory(bt, bv, bw, bj.RootPart.Position, bj.RootPart.Velocity, workspace.Gravity, bj.HipHeight, bj.Jumping and 42.6 or nil, RaycastParams.new())
							if bx then
								local by = CFrame.lookAt(bt, bx).LookVector
								q:SendMouseButtonEvent(0, 0, 0, true, game, 1)
								task.wait(0.05)
								q:SendMouseButtonEvent(0, 0, 0, false, game, 1)
							else
								q:SendMouseButtonEvent(0, 0, 0, true, game, 1)
								task.wait(0.05)
								q:SendMouseButtonEvent(0, 0, 0, false, game, 1)
							end
						end
					end
				end
			end
			task.wait(0.05)
		end
		local bo = getSwordSlot()
		if bo then
			hotbarSwitch(bo)
		else
			hotbarSwitch(bn)
		end
		lastAutoShootTime = bk
	end
	local function getEntityFromCharacterFH(bj)
		for bk, bl in ipairs(B.List) do
			if bl.Character == bj then
				return bl
			end
		end
		return nil
	end
	local function doFastHits()
		if not Z.Enabled then
			return
		end
		if not aj then
			return
		end
		if not L.KillauraTarget then
			return
		end
		if a7 and a7.Enabled then
			if not fastHitsActivationReady then
				return
			end
			if fastHitsTrackedEntity and fastHitsTrackedEntity ~= L.KillauraTarget then
				fastHitsActivationReady = false
				return
			end
		end
		local bj = L.KillauraTarget
		if not bj or not bj.RootPart then
			return
		end
		local bk = B.character.RootPart.Position
		local bl = (bj.RootPart.Position - bk).Magnitude
		if bl > bb.Value * 30 then
			return
		end
		if a5.Value == 'OGFastHits' then
			doFastHitsVirtualInput(bj)
		elseif a5.Value == 'NEWFastHits' then
			doFastHitsNEW(bj)
		end
	end
	local function startAutoShootLoop()
		if autoShootLoop then
			return
		end
		fastHitsHitTarget = nil
		fastHitsTrackedEntity = nil
		fastHitsHitCount = 0
		fastHitsActivationReady = false
		fastHitsLastHitTime = 0
		if a7 and a7.Enabled then
			local bj
			bj = b.EntityDamageEvent.Event:Connect(function(bk)
				if not Z.Enabled or not a7.Enabled then
					return
				end
				local bl, bm = bk.fromEntity, bk.entityInstance
				if not bl or not bm then
					return
				end
				local bn = t.Character and bl == t.Character
				if not bn then
					local bo = e:GetPlayerFromCharacter(bl)
					if bo == t then
						bn = true
					end
				end
				if not bn then
					return
				end
				local bo = tick()
				if bo - fastHitsLastHitTime < FASTHITS_HIT_DEBOUNCE then
					return
				end
				fastHitsLastHitTime = bo
				local bp = getEntityFromCharacterFH(bm)
				if not bp then
					return
				end
				if fastHitsHitTarget == bm then
					fastHitsHitCount = fastHitsHitCount + 1
				else
					fastHitsHitTarget = bm
					fastHitsTrackedEntity = bp
					fastHitsHitCount = 1
					fastHitsActivationReady = false
				end
				if fastHitsHitCount >= (a6 and a6.Value or 2) then
					fastHitsActivationReady = true
				end
			end)
			Z:Clean(bj)
		end
		autoShootLoop = task.spawn(function()
			while ak.Enabled and Z.Enabled do
				doFastHits()
				task.wait(0.05)
			end
			autoShootLoop = nil
		end)
	end
	local function stopAutoShootLoop()
		if autoShootLoop then
			task.cancel(autoShootLoop)
			autoShootLoop = nil
		end
		table.clear(FastHitsFireDelays)
		table.clear(NEWFastHitsProjectileDelay)
		NEWFastHitsLastShot = 0
		NEWFastHitsUsage = 1
		fastHitsHitTarget = nil
		fastHitsTrackedEntity = nil
		fastHitsHitCount = 0
		fastHitsActivationReady = false
		fastHitsLastHitTime = 0
	end
	ak = v.Categories.Blatant:CreateModule{
		Name = 'Killaura',
		Function = function(bj)
			if bj then
				aN = Workspace:GetServerTimeNow()
				aO = 0
				aM = 0
				aS = 0
				resetSwordCooldown()
				aV = 0
				aW = 0
				if ap.Enabled then
					createRangeCircle()
				end
				if h.TouchEnabled and not preserveSwordIcon then
					pcall(function()
						t.PlayerGui.MobileUI['2'].Visible = aJ.Enabled
					end)
				end
				if aF.Enabled and not (identifyexecutor and table.find({
					'Argon',
					'Delta'
				}, ({
					identifyexecutor()
				})[1])) then
					task.spawn(function()
						local bk = false
						repeat
							if aj then
								if not a1 then
									a1 = s.Viewmodel.RightHand.RightWrist.C0
								end
								local bl = not bk
								bk = true
								if aG.Value == 'Random' then
									aZ.Random = {
										{
											CFrame = CFrame.Angles(math.rad(math.random(1, 360)), math.rad(math.random(1, 360)), math.rad(math.random(1, 360))),
											Time = 0.12
										}
									}
								end
								for bm, bn in aZ[aG.Value] do
									a0 = i:Create(s.Viewmodel.RightHand.RightWrist, TweenInfo.new(bl and (aI.Enabled and 0.001 or 0.1) or bn.Time / aH.Value, Enum.EasingStyle.Linear), {
										C0 = a1 * bn.CFrame
									})
									a0:Play()
									a0.Completed:Wait()
									bl = false
									if (not ak.Enabled) or (not aj) then
										break
									end
								end
							elseif bk then
								bk = false
								a0 = i:Create(s.Viewmodel.RightHand.RightWrist, TweenInfo.new(aI.Enabled and 0.001 or 0.3, Enum.EasingStyle.Exponential), {
									C0 = a1
								})
								a0:Play()
							end
							if not bk then
								task.wait(1 / ar.Value)
							end
						until (not ak.Enabled) or (not aF.Enabled)
					end)
				end
				repeat
					if aP and aP.Enabled then
						if isFrozen(nil, be) then
							aj = false
							L.KillauraTarget = nil
							task.wait(0.3)
							continue
						end
					end
					pcall(function()
						if B.isAlive and B.character.HumanoidRootPart then
							aq.Position = B.character.HumanoidRootPart.Position - Vector3.new(0, B.character.Humanoid.HipHeight, 0)
						end
					end)
					local bk, bl, bm, bn = {}, getAttackData()
					aj = false
					L.KillauraTarget = nil
					pcall(function()
						vapeTargetInfo.Targets.Killaura = nil
					end)
					if bl and bn then
						local bo, bp, bq, br, bs, bt = string.find(string.lower(tostring(bl and bl.itemType or '')), 'summoner_claw'), B.character.RootPart.Position, B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1), math.rad(as.Value) / 2, {}, {}
						if al.Players.Enabled then
							local bu = B.AllPosition{
								Range = ao.Value,
								Wallcheck = false,
								Part = 'RootPart',
								Players = true,
								NPCs = false,
								Limit = at.Value,
								Sort = aa[am.Value]
							}
							for bv, bw in bu do
								table.insert(bs, {
									entity = bw,
									isPlayer = true
								})
							end
						end
						if al.NPCs.Enabled then
							local bu = B.AllPosition{
								Range = ao.Value,
								Wallcheck = false,
								Part = 'RootPart',
								Players = false,
								NPCs = true,
								Limit = at.Value,
								Sort = aa[am.Value]
							}
							for bv, bw in bu do
								table.insert(bs, {
									entity = bw,
									isPlayer = false
								})
							end
						end
						if a3.Value == 'Players First' then
							table.sort(bs, function(bu, bv)
								if bu.isPlayer ~= bv.isPlayer then
									return bu.isPlayer
								end
								return (bu.entity.RootPart.Position - bp).Magnitude < (bv.entity.RootPart.Position - bp).Magnitude
							end)
						elseif a3.Value == 'NPCs First' then
							table.sort(bs, function(bu, bv)
								if bu.isPlayer ~= bv.isPlayer then
									return not bu.isPlayer
								end
								return (bu.entity.RootPart.Position - bp).Magnitude < (bv.entity.RootPart.Position - bp).Magnitude
							end)
						else
							table.sort(bs, function(bu, bv)
								return (bu.entity.RootPart.Position - bp).Magnitude < (bv.entity.RootPart.Position - bp).Magnitude
							end)
						end
						local bu = {}
						for bv = 1, math.min(# bs, at.Value) do
							table.insert(bu, bs[bv].entity)
						end
						if al.Players.Enabled then
							local bv = B.AllPosition{
								Range = an.Value,
								Wallcheck = al.Walls.Enabled or nil,
								Part = 'RootPart',
								Players = true,
								NPCs = false,
								Limit = at.Value,
								Sort = aa[am.Value]
							}
							for bw, bx in bv do
								table.insert(bt, {
									entity = bx,
									isPlayer = true
								})
							end
						end
						if al.NPCs.Enabled then
							local bv = B.AllPosition{
								Range = an.Value,
								Wallcheck = al.Walls.Enabled or nil,
								Part = 'RootPart',
								Players = false,
								NPCs = true,
								Limit = at.Value,
								Sort = aa[am.Value]
							}
							for bw, bx in bv do
								table.insert(bt, {
									entity = bx,
									isPlayer = false
								})
							end
						end
						if a3.Value == 'Players First' then
							table.sort(bt, function(bv, bw)
								if bv.isPlayer ~= bw.isPlayer then
									return bv.isPlayer
								end
								return (bv.entity.RootPart.Position - bp).Magnitude < (bw.entity.RootPart.Position - bp).Magnitude
							end)
						elseif a3.Value == 'NPCs First' then
							table.sort(bt, function(bv, bw)
								if bv.isPlayer ~= bw.isPlayer then
									return not bv.isPlayer
								end
								return (bv.entity.RootPart.Position - bp).Magnitude < (bw.entity.RootPart.Position - bp).Magnitude
							end)
						else
							table.sort(bt, function(bv, bw)
								return (bv.entity.RootPart.Position - bp).Magnitude < (bw.entity.RootPart.Position - bp).Magnitude
							end)
						end
						local bv = {}
						for bw = 1, math.min(# bt, at.Value) do
							table.insert(bv, bt[bw].entity)
						end
						local bw, bx = false, false
						for by, bz in bu do
							local bA = (bz.RootPart.Position - bp)
							local bB = math.acos(bq:Dot((bA * Vector3.new(1, 0, 1)).Unit))
							if bB <= br then
								bw = true
								break
							end
						end
						for by, bz in bv do
							local bA = (bz.RootPart.Position - bp)
							local bB = math.acos(bq:Dot((bA * Vector3.new(1, 0, 1)).Unit))
							if bB <= br then
								bx = true
								break
							end
						end
						if bw or bx then
							aV = tick()
						end
						local by = bw or bx or shouldContinueSwinging()
						if by then
							switchItem(bl.tool, 0)
							if bx then
								for bz, bA in bv do
									local bB = (bA.RootPart.Position - bp)
									local bC, bD = math.acos(bq:Dot((bB * Vector3.new(1, 0, 1)).Unit)), math.rad(as.Value)
									if bC > (bD / 2) then
										continue
									end
									table.insert(bk, {
										Entity = bA,
										Check = bB.Magnitude > ao.Value and ax or ay
									})
									C.Targets[bA] = tick() + 1
									pcall(function()
										local bE = bA
										vapeTargetInfo.Targets.Killaura = {
											Humanoid = {
												Health = (bE.Character:GetAttribute'Health' or bE.Humanoid.Health) + getShieldAttribute(bE.Character),
												MaxHealth = bE.Character:GetAttribute'MaxHealth' or bE.Humanoid.MaxHealth
											},
											Player = bE.Player
										}
									end)
									if not aj then
										aj = true
										L.KillauraTarget = bA
										if not bo then
											local bE = bB.Magnitude < 14.4
											local bF = not av.Enabled and a_ <= tick() and (not aK.Enabled or (not aK.Enabled and not au.Enabled) or (bE and (tick() - aS) >= math.max(aQ.Enabled and aR.Value or 0.25, 0.11)))
											if bF then
												local bG = 0.25
												if aQ.Enabled then
													bG = math.max(aR.Value, 0.11)
												elseif bm.sword.respectAttackSpeedForEffects then
													bG = bm.sword.attackSpeed
												end
												a_ = tick() + bG
												pcall(function()
													O.SwordController:playSwordEffect(bm, false)
													if bm.displayName:find' Scythe' then
														O.ScytheController:playLocalAnimation()
													end
												end)
												safeCall(function()
													if v.ThreadFix and setthreadidentity then
														pcall(setthreadidentity, 8)
													end
												end)
											end
										end
									end
									local bE, bF = bB.Magnitude <= ao.Value, bB.Magnitude <= (ao.Value + 0.8)
									if not bE and not bF then
										continue
									end
									if X and X.Enabled then
										local bG = bA.Character:FindFirstChildOfClass'Humanoid'
										if bG then
											local bH = bG:GetState()
											if bH == Enum.HumanoidStateType.Jumping or bH == Enum.HumanoidStateType.Freefall or bH == Enum.HumanoidStateType.Physics then
												if math.random(1, 100) > Y.Value then
													continue
												end
											end
										end
									end
									if aL.Enabled then
										local bG, bH = aQ.Enabled and aR.Value or (bm.sword.respectAttackSpeedForEffects and bm.sword.attackSpeed or 0.42), tick() - aS
										local bI = math.max(bG * 0.4, 0.03)
										if bH < bI then
											continue
										end
									end
									local bG = bA.Character.PrimaryPart
									if bG then
										local bH, bI, bJ = CFrame.lookAt(bp, bG.Position).LookVector, bp, bG.Position
										if not aL.Enabled or (tick() - aS) >= 0.1 then
											aS = tick()
										end
										aO = workspace:GetServerTimeNow() - aN
										aN = workspace:GetServerTimeNow()
										L.attackReach = (bB.Magnitude * 100) // 1 / 100
										L.attackReachUpdate = tick() + 1
										if aQ.Enabled then
											aM = tick()
											if bB.Magnitude < 14.4 and aR.Value > 0.11 then
												a_ = tick()
											end
										end
										if bo then
											KaidaController:request(bA.Character)
										else
											local bK = {
												weapon = bl.tool,
												entityInstance = bA.Character,
												chargedAttack = {
													chargeRatio = 0
												},
												validate = {
													raycast = {
														cameraPosition = {
															value = bI + Vector3.new(0, 2, 0)
														},
														cursorDirection = {
															value = bH
														}
													},
													targetPosition = {
														value = bJ
													},
													selfPosition = {
														value = bI + Vector3.new(0, 1, 0)
													}
												}
											}
											bK.validate = bK.validate or {}
											bK.validate.raycast = bK.validate.raycast or {}
											bK.validate.targetPosition = bK.validate.targetPosition or {
												value = bJ
											}
											bK.validate.selfPosition = bK.validate.selfPosition or {
												value = bI
											}
											bK.validate.raycast.cameraPosition = bK.validate.raycast.cameraPosition or {
												value = bI
											}
											bK.validate.raycast.cursorDirection = bK.validate.raycast.cursorDirection or {
												value = bH
											}
											FireAttackRemote(bK)
											if Z.Enabled and (tick() - bh) >= (0.2 + t:GetNetworkPing() + _.Value) then
												local bL = getProjectiles()
												bi += 1
												if not bL[bi] then
													bi = 1
												end
												if bL and bL[bi] and canShoot(bL[bi]) then
													local bM, bN, bO, bP = unpack(bL[bi])
													shootFunc(bM, bN, bO, bP, bp, bA, true)
													bh = tick()
												end
											end
										end
									end
								end
							else
								aj = true
								if not bo then
									if not av.Enabled and a_ <= tick() and not aK.Enabled then
										local bz = 0.25
										if aQ.Enabled then
											bz = math.max(aR.Value, 0.11)
										elseif bm.sword.respectAttackSpeedForEffects then
											bz = bm.sword.attackSpeed
										end
										a_ = tick() + bz
										pcall(function()
											O.SwordController:playSwordEffect(bm, false)
											if bm.displayName:find' Scythe' then
												O.ScytheController:playLocalAnimation()
											end
										end)
										safeCall(function()
											if v.ThreadFix and setthreadidentity then
												pcall(setthreadidentity, 8)
											end
										end)
									end
								end
								local bz = aQ.Enabled and aR.Value or (bm.sword.respectAttackSpeedForEffects and bm.sword.attackSpeed or 0.42)
								local bA = math.max(bz, 0.05)
								if not aL.Enabled or (tick() - aS) >= bA then
									aS = tick()
								end
							end
						end
					end
					pcall(function()
						for bo, bp in aY do
							bp.Adornee = bk[bo] and bk[bo].Entity.RootPart or nil
							if bp.Adornee then
								bp.Color3 = Color3.fromHSV(bk[bo].Check.Hue, bk[bo].Check.Sat, bk[bo].Check.Value)
								bp.Transparency = 1 - bk[bo].Check.Opacity
							end
						end
						for bo, bp in aX do
							bp.Position = bk[bo] and bk[bo].Entity.RootPart.Position or Vector3.new(9e9, 9e9, 9e9)
							bp.Parent = bk[bo] and s or nil
						end
					end)
					if aD.Enabled and bk[1] then
						do
							local bo = bk[1].Entity.RootPart.Position * Vector3.new(1, 0, 1)
							local bp, bq = CFrame.lookAt(B.character.RootPart.Position, Vector3.new(bo.X, B.character.RootPart.Position.Y + 0.001, bo.Z)), aE and aE.Value or 15
							local br = math.clamp(bq / 100, 0.01, 1)
							B.character.RootPart.CFrame = B.character.RootPart.CFrame:Lerp(bp, br)
						end
					end
					pcall(function()
						if aq ~= nil then
							aq.Parent = s
						end
					end)
					task.wait(1 / ar.Value)
				until not ak.Enabled
			else
				table.clear(bg)
				L.KillauraTarget = nil
				for bk, bl in aY do
					bl.Adornee = nil
				end
				for bk, bl in aX do
					bl.Parent = nil
				end
				if h.TouchEnabled then
					pcall(function()
						t.PlayerGui.MobileUI['2'].Visible = true
					end)
				end
				aj = false
				if a1 then
					a0 = i:Create(s.Viewmodel.RightHand.RightWrist, TweenInfo.new(aI.Enabled and 0.001 or 0.3, Enum.EasingStyle.Exponential), {
						C0 = a1
					})
					a0:Play()
				end
				if aq ~= nil then
					aq:Destroy()
				end
			end
		end,
		Tooltip = 'Attack players around you\nwithout aiming at them.'
	}
	pcall(function()
		local bj = ak:CreateToggle{
			Name = 'Preserve Sword Icon',
			Function = function(bj)
				preserveSwordIcon = bj
			end,
			Default = true
		}
		bj.Object.Visible = h.TouchEnabled
	end)
	al = ak:CreateTargets{
		Players = true,
		NPCs = true
	}
	a3 = ak:CreateDropdown{
		Name = 'Target Priority',
		List = {
			'Players First',
			'NPCs First',
			'Distance'
		},
		Default = 'Players First',
		Tooltip = 'Choose which targets to prioritize'
	}
	local bj = {
		'Damage',
		'Distance'
	}
	for bk in aa do
		if not table.find(bj, bk) then
			table.insert(bj, bk)
		end
	end
	an = ak:CreateSlider{
		Name = 'Swing range',
		Min = 1,
		Max = 40,
		Default = 22,
		Suffix = function(bk)
			return bk == 1 and 'stud' or 'studs'
		end
	}
	ao = ak:CreateSlider{
		Name = 'Attack range',
		Min = 1,
		Max = 22,
		Default = 22,
		Suffix = function(bk)
			return bk == 1 and 'stud' or 'studs'
		end
	}
	ap = ak:CreateToggle{
		Name = 'Range Visualiser',
		Function = function(bk)
			if bk then
				createRangeCircle()
			else
				if aq then
					aq:Destroy()
					aq = nil
				end
			end
		end
	}
	as = ak:CreateSlider{
		Name = 'Max angle',
		Min = 1,
		Max = 360,
		Default = 360
	}
	ar = ak:CreateSlider{
		Name = 'Update rate',
		Min = 1,
		Max = 120,
		Default = 60,
		Suffix = 'hz'
	}
	at = ak:CreateSlider{
		Name = 'Max targets',
		Min = 1,
		Max = 5,
		Default = 5
	}
	am = ak:CreateDropdown{
		Name = 'Target Mode',
		List = bj
	}
	au = ak:CreateToggle{
		Name = 'Require mouse down'
	}
	av = ak:CreateToggle{
		Name = 'No Swing'
	}
	aw = ak:CreateToggle{
		Name = 'GUI check'
	}
	bc = ak:CreateToggle{
		Name = 'Dynamic Reach',
		Default = false
	}
	aQ = ak:CreateToggle{
		Name = 'Custom Swing Time',
		Function = function(bk)
			aR.Object.Visible = bk
		end
	}
	aR = ak:CreateSlider{
		Name = 'Swing Time',
		Min = 0,
		Max = 1,
		Default = 0.42,
		Decimal = 100,
		Visible = false
	}
	aT = ak:CreateToggle{
		Name = 'Continue Swinging',
		Tooltip = 'Swing X times after losing target (based on swing speed)',
		Function = function(bk)
			if aU then
				aU.Object.Visible = bk
			end
		end
	}
	aU = ak:CreateSlider{
		Name = 'Swing Duration',
		Min = 0,
		Max = 5,
		Default = 1,
		Decimal = 10,
		Suffix = 's',
		Visible = false
	}
	a4 = ak:CreateToggle{
		Name = 'Custom Hit Reg',
		Tooltip = 'Limit how many hits per second',
		Function = function(bk)
			if W then
				W.Object.Visible = bk
			end
			if bk then
				bd = 0
			end
		end
	}
	W = ak:CreateSlider{
		Name = 'Hits Per Second',
		Min = 1,
		Max = 36,
		Default = 30,
		Tooltip = 'Maximum hits per second',
		Visible = false
	}
	aL = ak:CreateToggle{
		Name = 'Sync Hits',
		Tooltip = 'Waits for sword animation before attacking'
	}
	ak:CreateToggle{
		Name = 'Show target',
		Function = function(bk)
			ax.Object.Visible = bk
			ay.Object.Visible = bk
			if bk then
				for bl = 1, 10 do
					local bm = Instance.new'BoxHandleAdornment'
					bm.Adornee = nil
					bm.AlwaysOnTop = true
					bm.Size = Vector3.new(3, 5, 3)
					bm.CFrame = CFrame.new(0, - 0.5, 0)
					bm.ZIndex = 0
					bm.Parent = v.gui
					aY[bl] = bm
				end
			else
				for bl, bm in aY do
					bm:Destroy()
				end
				table.clear(aY)
			end
		end
	}
	ax = ak:CreateColorSlider{
		Name = 'Target Color',
		Darker = true,
		DefaultHue = 0.6,
		DefaultOpacity = 0.5,
		Visible = false,
		Function = function(bk, bl, bm)
			if ak.Enabled and aq ~= nil then
				aq.Color = Color3.fromHSV(bk, bl, bm)
			end
		end
	}
	ay = ak:CreateColorSlider{
		Name = 'Attack Color',
		Darker = true,
		DefaultOpacity = 0.5,
		Visible = false
	}
	ak:CreateToggle{
		Name = 'Target particles',
		Function = function(bk)
			az.Object.Visible = bk
			aA.Object.Visible = bk
			aB.Object.Visible = bk
			aC.Object.Visible = bk
			if bk then
				for bl = 1, 10 do
					local bm = Instance.new'Part'
					bm.Size = Vector3.new(2, 4, 2)
					bm.Anchored = true
					bm.CanCollide = false
					bm.Transparency = 1
					bm.CanQuery = false
					bm.Parent = ak.Enabled and s or nil
					local bn = Instance.new'ParticleEmitter'
					bn.Brightness = 1.5
					bn.Size = NumberSequence.new(aC.Value)
					bn.Shape = Enum.ParticleEmitterShape.Sphere
					bn.Texture = az.Value
					bn.Transparency = NumberSequence.new(0)
					bn.Lifetime = NumberRange.new(0.4)
					bn.Speed = NumberRange.new(16)
					bn.Rate = 128
					bn.Drag = 16
					bn.ShapePartial = 1
					bn.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromHSV(aA.Hue, aA.Sat, aA.Value)),
						ColorSequenceKeypoint.new(1, Color3.fromHSV(aB.Hue, aB.Sat, aB.Value))
					}
					bn.Parent = bm
					aX[bl] = bm
				end
			else
				for bl, bm in aX do
					bm:Destroy()
				end
				table.clear(aX)
			end
		end
	}
	az = ak:CreateTextBox{
		Name = 'Texture',
		Default = 'rbxassetid://14736249347',
		Function = function()
			for bk, bl in aX do
				bl.ParticleEmitter.Texture = az.Value
			end
		end,
		Darker = true,
		Visible = false
	}
	aA = ak:CreateColorSlider{
		Name = 'Color Begin',
		Function = function(bk, bl, bm)
			for bn, bo in aX do
				bo.ParticleEmitter.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromHSV(bk, bl, bm)),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(aB.Hue, aB.Sat, aB.Value))
				}
			end
		end,
		Darker = true,
		Visible = false
	}
	aB = ak:CreateColorSlider{
		Name = 'Color End',
		Function = function(bk, bl, bm)
			for bn, bo in aX do
				bo.ParticleEmitter.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromHSV(aA.Hue, aA.Sat, aA.Value)),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(bk, bl, bm))
				}
			end
		end,
		Darker = true,
		Visible = false
	}
	aC = ak:CreateSlider{
		Name = 'Size',
		Min = 0,
		Max = 1,
		Default = 0.2,
		Decimal = 100,
		Function = function(bk)
			for bl, bm in aX do
				bm.ParticleEmitter.Size = NumberSequence.new(bk)
			end
		end,
		Darker = true,
		Visible = false
	}
	aD = ak:CreateToggle{
		Name = 'Face target',
		Function = function(bk)
			if aE then
				aE.Object.Visible = bk
			end
		end
	}
	aE = ak:CreateSlider{
		Name = 'Face Speed',
		Min = 1,
		Max = 100,
		Default = 15,
		Decimal = 10,
		Darker = true,
		Visible = false,
		Tooltip = 'How fast to snap towards target (lower = slower/smoother)'
	}
	aF = ak:CreateToggle{
		Name = 'Custom Animation',
		Function = function(bk)
			aG.Object.Visible = bk
			aI.Object.Visible = bk
			aH.Object.Visible = bk
			if ak.Enabled then
				ak:Toggle()
				ak:Toggle()
			end
		end
	}
	local bk = {}
	for bl in aZ do
		table.insert(bk, bl)
	end
	aG = ak:CreateDropdown{
		Name = 'Animation Mode',
		List = bk,
		Darker = true,
		Visible = false
	}
	aH = ak:CreateSlider{
		Name = 'Animation Speed',
		Min = 0,
		Max = 2,
		Default = 1,
		Decimal = 10,
		Darker = true,
		Visible = false
	}
	aI = ak:CreateToggle{
		Name = 'No Tween',
		Darker = true,
		Visible = false
	}
	aJ = ak:CreateToggle{
		Name = 'Limit to items',
		Function = function(bl)
			if h.TouchEnabled and ak.Enabled then
				pcall(function()
					t.PlayerGui.MobileUI['2'].Visible = bl
				end)
			end
		end,
		Tooltip = 'Only attacks when the sword is held'
	}
	aK = ak:CreateToggle{
		Name = 'Swing only',
		Tooltip = 'Only attacks while swinging manually'
	}
	X = ak:CreateToggle{
		Name = 'Air Hits',
		Default = true,
		Tooltip = 'Control hit chance when target is airborne',
		Function = function(bl)
			if Y then
				Y.Object.Visible = bl
			end
			if ak.Enabled and bl and Y and Y.Object then
				Y.Object.Visible = true
			end
		end
	}
	Y = ak:CreateSlider{
		Name = 'Air Hits Chance',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%',
		Decimal = 5,
		Darker = true,
		Visible = false
	}
	aP = ak:CreateToggle{
		Name = 'Sophia Check',
		Tooltip = 'Stops Killaura ONLY when completely frozen (uses global isFrozen)',
		Function = function(bl)
		end,
		Default = false
	}
	Z = ak:CreateToggle{
		Name = 'Fast Hits',
		Tooltip = 'Deals more damage quicker using projectiles',
		Default = false,
		Function = function(bl)
			_.Object.Visible = bl
			a5.Object.Visible = bl
			bb.Object.Visible = bl
			ba.Object.Visible = bl
			a9.Object.Visible = bl
			a8.Object.Visible = bl
			if a7 then
				a7.Object.Visible = bl
			end
			if bl then
				startAutoShootLoop()
			else
				stopAutoShootLoop()
			end
		end
	}
	a5 = ak:CreateDropdown{
		Name = 'Fast Hits Mode',
		List = {
			'OGFastHits',
			'NEWFastHits'
		},
		Default = 'OGFastHits',
		Darker = true,
		Visible = false,
		Tooltip = 'Choose which Fast Hits method to use'
	}
	bb = ak:CreateSlider{
		Name = 'Shoot Interval',
		Min = 0.1,
		Max = 2,
		Default = 0.5,
		Decimal = 100,
		Suffix = 's',
		Darker = true,
		Visible = false,
		Tooltip = 'Time between auto shots'
	}
	ba = ak:CreateSlider{
		Name = 'Switch Speed',
		Min = 0,
		Max = 0.5,
		Default = 0.05,
		Decimal = 100,
		Suffix = 's',
		Darker = true,
		Visible = false,
		Tooltip = 'Delay after switching to bow'
	}
	a9 = ak:CreateSlider{
		Name = 'Wait Delay',
		Min = 0,
		Max = 0.5,
		Default = 0,
		Decimal = 100,
		Suffix = 's',
		Darker = true,
		Visible = false,
		Tooltip = 'Additional delay before shooting'
	}
	a8 = ak:CreateToggle{
		Name = 'First Person Only',
		Darker = true,
		Visible = false,
		Tooltip = 'Only auto-shoot in first person view'
	}
	a7 = ak:CreateToggle{
		Name = 'Hits Required',
		Darker = true,
		Visible = false,
		Tooltip = 'Require X hits before activating Fast Hits',
		Function = function(bl)
			if a6 then
				a6.Object.Visible = bl
			end
		end
	}
	a6 = ak:CreateSlider{
		Name = 'Required Hits',
		Min = 1,
		Max = 10,
		Default = 2,
		Darker = true,
		Visible = false,
		Tooltip = 'Number of hits needed before Fast Hits activates'
	}
	_ = ak:CreateSlider{
		Name = 'Fire rate',
		Suffix = 's',
		Min = 0,
		Max = 2,
		Decimal = 100,
		Darker = true,
		Visible = false,
		Default = 0
	}
	task.defer(function()
		if X and X.Enabled and Y and Y.Object then
			Y.Object.Visible = true
		end
	end)
end)
local ak
a(function()
	local al, am, an, ao, ap, aq, ar, as, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP, aQ = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, {}, {}, {}, v.Libraries.auraanims, tick()
	local aR = {
		FireServer = function()
		end
	}
	task.spawn(function()
		aR = O.Client:Get(P.AttackEntity).instance
	end)
	local function flatAngle(aS, aT, aU)
		local aV = (aT - aS) * Vector3.new(1, 0, 1)
		if aV.Magnitude < 0.001 then
			return 0
		end
		return math.acos(math.clamp(aU:Dot(aV.Unit), - 1, 1))
	end
	local function flatFacing(aS)
		local aT = aS.LookVector * Vector3.new(1, 0, 1)
		if aT.Magnitude < 0.001 then
			return aS.RightVector * Vector3.new(1, 0, 1)
		end
		return aT.Unit
	end
	local aS = 0
	local function getAttackData()
		if aA and aA.Enabled then
			if isFrozen(nil, 10) then
				return false
			end
		end
		if au and au.Enabled then
			local aT = h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
			if not aT then
				return false
			end
		end
		if aw and aw.Enabled then
			if O.AppController:isLayerOpen(O.UILayers.MAIN) then
				return false
			end
		end
		local aT = (aJ and aJ.Enabled) and L.hand or L.tools.sword
		if not aT or not aT.tool then
			return false
		end
		local aU = O.ItemMeta[aT.tool.Name]
		if not aU or not aU.sword then
			return false
		end
		if aJ and aJ.Enabled then
			if L.hand.toolType ~= 'sword' or O.DaoController.chargingMaid then
				return false
			end
		end
		if aK and aK.Enabled then
			local aV = O.SwordController.lastSwing or 0
			if (tick() - aV) > 0.5 then
				return false
			end
			if aV == aS then
				return false
			end
		end
		return aT, aU
	end
	al = v.Categories.Blatant:CreateModule{
		Name = 'GrandKillaura',
		Function = function(aT)
			if aT then
				if h.TouchEnabled then
					pcall(function()
						t.PlayerGui.MobileUI['2'].Visible = aJ and aJ.Enabled
					end)
				end
				if aF and aF.Enabled and not (identifyexecutor and table.find({
					'Argon',
					'Delta'
				}, ({
					identifyexecutor()
				})[1])) then
					local aU = {
						Controllers = {
							ViewmodelController = {
								isVisible = function()
									return not ak
								end,
								playAnimation = function(...)
									if not ak then
										O.ViewmodelController:playAnimation(select(2, ...))
									end
								end
							}
						}
					}
					debug.setupvalue(x or O.SwordController.playSwordEffect, 6, aU)
					debug.setupvalue(O.ScytheController.playLocalAnimation, 3, aU)
					task.spawn(function()
						local aV = false
						repeat
							if aA and aA.Enabled then
								if isFrozen(nil, 10) then
									ak = false
									L.KillauraTarget = nil
									task.wait(0.3)
									continue
								end
							end
							if ak then
								if not aQ then
									aQ = s.Viewmodel.RightHand.RightWrist.C0
								end
								local aW = not aV
								aV = true
								if aG.Value == 'Random' then
									aN.Random = {
										{
											CFrame = CFrame.Angles(math.rad(math.random(1, 360)), math.rad(math.random(1, 360)), math.rad(math.random(1, 360))),
											Time = 0.12
										}
									}
								end
								for aX, aY in aN[aG.Value] do
									aP = i:Create(s.Viewmodel.RightHand.RightWrist, TweenInfo.new(aW and (aI.Enabled and 0.001 or 0.1) or aY.Time / aH.Value, Enum.EasingStyle.Linear), {
										C0 = aQ * aY.CFrame
									})
									aP:Play()
									aP.Completed:Wait()
									aW = false
									if not al.Enabled or not ak then
										break
									end
								end
							elseif aV then
								aV = false
								aP = i:Create(s.Viewmodel.RightHand.RightWrist, TweenInfo.new(aI.Enabled and 0.001 or 0.3, Enum.EasingStyle.Exponential), {
									C0 = aQ
								})
								aP:Play()
							end
							if not aV then
								task.wait(1 / ar.Value)
							end
						until not al.Enabled or not aF.Enabled
					end)
				end
				local aU = 0
				repeat
					if aA and aA.Enabled then
						if isFrozen(nil, 10) then
							ak = false
							L.KillauraTarget = nil
							task.wait(0.3)
							continue
						end
					end
					local aV, aW, aX = {}, getAttackData()
					ak = false
					L.KillauraTarget = nil
					if aW then
						local aY = B.AllPosition{
							Range = ao.Value,
							Wallcheck = am.Walls.Enabled or nil,
							Part = 'RootPart',
							Players = am.Players.Enabled,
							NPCs = am.NPCs.Enabled,
							Limit = at.Value,
							Sort = aa[an.Value]
						}
						if # aY > 0 then
							switchItem(aW.tool, 0)
							local aZ, a_, a0 = B.character.RootPart.Position, flatFacing(B.character.RootPart.CFrame), math.rad(as.Value) / 2
							for a1, a2 in aY do
								local a3 = (a2.RootPart.Position - aZ)
								if flatAngle(aZ, a2.RootPart.Position, a_) > a0 then
									continue
								end
								table.insert(aV, {
									Entity = a2,
									Check = a3.Magnitude > ap.Value and ax or ay
								})
								C.Targets[a2] = tick() + 1
								if not ak then
									ak = true
									L.KillauraTarget = a2
									local a4, a5 = a3.Magnitude < 14.4, not (av and av.Enabled) and aO < tick() and not (aK and aK.Enabled)
									if a5 then
										aO = tick() + (aX.sword.respectAttackSpeedForEffects and aX.sword.attackSpeed or math.max(aq.Value, 0.11))
										O.SwordController:playSwordEffect(aX, false)
										if aX.displayName:find' Scythe' then
											O.ScytheController:playLocalAnimation()
										end
										safeCall(function()
											if v.ThreadFix then
												setthreadidentity(8)
											end
										end)
									end
								end
								if a3.Magnitude > ap.Value then
									continue
								end
								if a3.Magnitude < 14.4 and (tick() - aU) < math.max(aq.Value, 0.02) then
									continue
								end
								local a4 = a2.Character.PrimaryPart
								if not a4 then
									continue
								end
								local a5 = CFrame.lookAt(aZ, a4.Position).LookVector
								local a6 = aZ + a5 * math.max(a3.Magnitude - 14.399, 0)
								aU = tick()
								if aK and aK.Enabled then
									aS = O.SwordController.lastSwing or 0
								end
								O.SwordController.lastAttack = workspace:GetServerTimeNow()
								L.attackReach = (a3.Magnitude * 100) // 1 / 100
								L.attackReachUpdate = tick() + 1
								if a3.Magnitude < 14.4 and aq.Value > 0.11 then
									aO = tick()
								end
								aR:FireServer{
									weapon = aW.tool,
									chargedAttack = {
										chargeRatio = 0
									},
									lastSwingServerTimeDelta = 0.5,
									entityInstance = a2.Character,
									validate = {
										raycast = {
											cameraPosition = {
												value = a6
											},
											cursorDirection = {
												value = a5
											}
										},
										targetPosition = {
											value = a4.Position
										},
										selfPosition = {
											value = a6
										}
									}
								}
							end
						end
					end
					pcall(function()
						for aY, aZ in aM do
							aZ.Adornee = aV[aY] and aV[aY].Entity.RootPart or nil
							if aZ.Adornee then
								aZ.Color3 = Color3.fromHSV(aV[aY].Check.Hue, aV[aY].Check.Sat, aV[aY].Check.Value)
								aZ.Transparency = 1 - aV[aY].Check.Opacity
							end
						end
						for aY, aZ in aL do
							aZ.Position = aV[aY] and aV[aY].Entity.RootPart.Position or Vector3.new(9e9, 9e9, 9e9)
							aZ.Parent = aV[aY] and s or nil
						end
					end)
					if aE and aE.Enabled and aV[1] then
						local aY = aV[1].Entity.RootPart.Position * Vector3.new(1, 0, 1)
						B.character.RootPart.CFrame = CFrame.lookAt(B.character.RootPart.Position, Vector3.new(aY.X, B.character.RootPart.Position.Y + 0.001, aY.Z))
					end
					task.wait(1 / ar.Value)
				until not al.Enabled
			else
				L.KillauraTarget = nil
				for aU, aV in aM do
					aV.Adornee = nil
				end
				for aU, aV in aL do
					aV.Parent = nil
				end
				if h.TouchEnabled then
					pcall(function()
						t.PlayerGui.MobileUI['2'].Visible = true
					end)
				end
				pcall(function()
					debug.setupvalue(x or O.SwordController.playSwordEffect, 6, O.Knit)
					debug.setupvalue(O.ScytheController.playLocalAnimation, 3, O.Knit)
				end)
				ak = false
				if aQ then
					aP = i:Create(s.Viewmodel.RightHand.RightWrist, TweenInfo.new(aI and aI.Enabled and 0.001 or 0.3, Enum.EasingStyle.Exponential), {
						C0 = aQ
					})
					aP:Play()
				end
			end
		end,
		Tooltip = 'Attack players around you\nwithout aiming at them.'
	}
	am = al:CreateTargets{
		Players = true,
		NPCs = true
	}
	local aT = {
		'Damage',
		'Distance'
	}
	for aU in aa do
		if not table.find(aT, aU) then
			table.insert(aT, aU)
		end
	end
	ao = al:CreateSlider{
		Name = 'Swing range',
		Min = 1,
		Max = 18,
		Default = 18,
		Suffix = function(aU)
			return aU == 1 and 'stud' or 'studs'
		end
	}
	ap = al:CreateSlider{
		Name = 'Attack range',
		Min = 1,
		Max = 18,
		Default = 18,
		Suffix = function(aU)
			return aU == 1 and 'stud' or 'studs'
		end
	}
	aq = al:CreateSlider{
		Name = 'Swing time',
		Min = 0,
		Max = 0.5,
		Default = 0.42,
		Decimal = 100
	}
	as = al:CreateSlider{
		Name = 'Max angle',
		Min = 1,
		Max = 360,
		Default = 360
	}
	ar = al:CreateSlider{
		Name = 'Update rate',
		Min = 1,
		Max = 120,
		Default = 60,
		Suffix = 'hz'
	}
	at = al:CreateSlider{
		Name = 'Max targets',
		Min = 1,
		Max = 5,
		Default = 5
	}
	an = al:CreateDropdown{
		Name = 'Target Mode',
		List = aT
	}
	au = al:CreateToggle{
		Name = 'Require mouse down'
	}
	av = al:CreateToggle{
		Name = 'No Swing'
	}
	aw = al:CreateToggle{
		Name = 'GUI check'
	}
	al:CreateToggle{
		Name = 'Show target',
		Function = function(aU)
			ax.Object.Visible = aU
			ay.Object.Visible = aU
			if aU then
				for aV = 1, 10 do
					local aW = Instance.new'BoxHandleAdornment'
					aW.Adornee = nil
					aW.AlwaysOnTop = true
					aW.Size = Vector3.new(3, 5, 3)
					aW.CFrame = CFrame.new(0, - 0.5, 0)
					aW.ZIndex = 0
					aW.Parent = v.gui
					aM[aV] = aW
				end
			else
				for aV, aW in aM do
					aW:Destroy()
				end
				table.clear(aM)
			end
		end
	}
	ax = al:CreateColorSlider{
		Name = 'Target Color',
		Darker = true,
		DefaultHue = 0.6,
		DefaultOpacity = 0.5,
		Visible = false
	}
	ay = al:CreateColorSlider{
		Name = 'Attack Color',
		Darker = true,
		DefaultOpacity = 0.5,
		Visible = false
	}
	al:CreateToggle{
		Name = 'Target particles',
		Function = function(aU)
			az.Object.Visible = aU
			aB.Object.Visible = aU
			aC.Object.Visible = aU
			aD.Object.Visible = aU
			if aU then
				for aV = 1, 10 do
					local aW = Instance.new'Part'
					aW.Size = Vector3.new(2, 4, 2)
					aW.Anchored = true
					aW.CanCollide = false
					aW.Transparency = 1
					aW.CanQuery = false
					aW.Parent = al.Enabled and s or nil
					local aX = Instance.new'ParticleEmitter'
					aX.Brightness = 1.5
					aX.Size = NumberSequence.new(aD.Value)
					aX.Shape = Enum.ParticleEmitterShape.Sphere
					aX.Texture = az.Value
					aX.Transparency = NumberSequence.new(0)
					aX.Lifetime = NumberRange.new(0.4)
					aX.Speed = NumberRange.new(16)
					aX.Rate = 128
					aX.Drag = 16
					aX.ShapePartial = 1
					aX.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromHSV(aB.Hue, aB.Sat, aB.Value)),
						ColorSequenceKeypoint.new(1, Color3.fromHSV(aC.Hue, aC.Sat, aC.Value))
					}
					aX.Parent = aW
					aL[aV] = aW
				end
			else
				for aV, aW in aL do
					aW:Destroy()
				end
				table.clear(aL)
			end
		end
	}
	az = al:CreateTextBox{
		Name = 'Texture',
		Default = 'rbxassetid://14736249347',
		Function = function()
			for aU, aV in aL do
				aV.ParticleEmitter.Texture = az.Value
			end
		end,
		Darker = true,
		Visible = false
	}
	aB = al:CreateColorSlider{
		Name = 'Color Begin',
		Function = function(aU, aV, aW)
			for aX, aY in aL do
				aY.ParticleEmitter.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromHSV(aU, aV, aW)),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(aC.Hue, aC.Sat, aC.Value))
				}
			end
		end,
		Darker = true,
		Visible = false
	}
	aC = al:CreateColorSlider{
		Name = 'Color End',
		Function = function(aU, aV, aW)
			for aX, aY in aL do
				aY.ParticleEmitter.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromHSV(aB.Hue, aB.Sat, aB.Value)),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(aU, aV, aW))
				}
			end
		end,
		Darker = true,
		Visible = false
	}
	aD = al:CreateSlider{
		Name = 'Size',
		Min = 0,
		Max = 1,
		Default = 0.2,
		Decimal = 100,
		Function = function(aU)
			for aV, aW in aL do
				aW.ParticleEmitter.Size = NumberSequence.new(aU)
			end
		end,
		Darker = true,
		Visible = false
	}
	aE = al:CreateToggle{
		Name = 'Face target'
	}
	aF = al:CreateToggle{
		Name = 'Custom Animation',
		Function = function(aU)
			aG.Object.Visible = aU
			aI.Object.Visible = aU
			aH.Object.Visible = aU
			if al.Enabled then
				al:Toggle()
				al:Toggle()
			end
		end
	}
	local aU = {}
	for aV in aN do
		table.insert(aU, aV)
	end
	aG = al:CreateDropdown{
		Name = 'Animation Mode',
		List = aU,
		Darker = true,
		Visible = false
	}
	aH = al:CreateSlider{
		Name = 'Animation Speed',
		Min = 0,
		Max = 2,
		Default = 1,
		Decimal = 10,
		Darker = true,
		Visible = false
	}
	aI = al:CreateToggle{
		Name = 'No Tween',
		Darker = true,
		Visible = false
	}
	aJ = al:CreateToggle{
		Name = 'Limit to items',
		Function = function(aV)
			if h.TouchEnabled and al.Enabled then
				pcall(function()
					t.PlayerGui.MobileUI['2'].Visible = aV
				end)
			end
		end,
		Tooltip = 'Only attacks when the sword is held'
	}
	aK = al:CreateToggle{
		Name = 'Swing only',
		Tooltip = 'Only attacks while swinging manually'
	}
	aA = al:CreateToggle{
		Name = 'Sophia Check',
		Tooltip = 'Stops Killaura when frozen by Sophia',
		Default = false
	}
end)
a(function()
	local al, am, an, ao, ap, aq = tick(), 0
	local ar = {
		InvokeServer = function()
		end
	}
	task.spawn(function()
		ar = O.Client:Get(P.FireProjectile).instance
	end)
	local function launchProjectile(as, at, au, av, aw)
		if not at then
			return
		end
		at = at - aw * 0.1
		local ax = (CFrame.lookAlong(at, Vector3.new(0, - av, 0)) * CFrame.new(Vector3.new(- O.BowConstantsTable.RelX, - O.BowConstantsTable.RelY, - O.BowConstantsTable.RelZ)))
		switchItem(as.tool, 0)
		task.wait(0.1)
		O.ProjectileController:createLocalProjectile(O.ProjectileMeta[au], au, au, ax.Position, '', ax.LookVector * av, {
			drawDurationSeconds = 1
		})
		if ar:InvokeServer(as.tool, au, au, ax.Position, at, ax.LookVector * av, j:GenerateGUID(true), {
			drawDurationSeconds = 1
		}, workspace:GetServerTimeNow() - 0.045) then
			local ay = O.ItemMeta[as.itemType].projectileSource.launchSound
			ay = ay and ay[math.random(1, # ay)] or nil
			if ay then
				O.SoundManager:playSound(ay)
			end
		end
	end
	local at = {
		cannon = function(as, at, au)
			at = at - Vector3.new(0, (B.character.HipHeight + (B.character.RootPart.Size.Y / 2)) - 3, 0)
			local av = Vector3.new(math.round(at.X / 3) * 3, math.round(at.Y / 3) * 3, math.round(at.Z / 3) * 3)
			O.placeBlock(av, 'cannon', false)
			task.delay(0, function()
				local aw, ax = getPlacedBlock(av)
				if aw and aw.Name == 'cannon' and (B.character.RootPart.Position - aw.Position).Magnitude < 20 then
					local ay = O.ItemMeta[aw.Name].block.breakType
					local az = L.tools[ay]
					if az then
						switchItem(az.tool)
					end
					O.Client:Get(P.CannonAim):SendToServer{
						cannonBlockPos = ax,
						lookVector = au
					}
					local aA = 0.1
					if O.BlockController:calculateBlockDamage(t, {
						blockPosition = ax
					}) < aw:GetAttribute'Health' then
						aA = 0.4
						O.breakBlock(aw, true, true)
					end
					task.delay(aA, function()
						for aB = 1, 3 do
							local aC = O.Client:Get(P.CannonLaunch):CallServer{
								cannonBlockPos = ax
							}
							if aC then
								O.breakBlock(aw, true, true)
								am = 5.25 * ao.Value
								al = tick() + 2.3
								an = Vector3.new(au.X, 0, au.Z).Unit
								break
							end
							task.wait(0.1)
						end
					end)
				end
			end)
		end,
		cat = function(as, at, au)
			ai:Clean(b.CatPounce.Event:Connect(function()
				am = 4 * ao.Value
				al = tick() + 2.5
				an = Vector3.new(au.X, 0, au.Z).Unit
				B.character.RootPart.Velocity = Vector3.zero
			end))
			if not O.AbilityController:canUseAbility'CAT_POUNCE' then
				repeat
					task.wait()
				until O.AbilityController:canUseAbility'CAT_POUNCE' or not ai.Enabled
			end
			if O.AbilityController:canUseAbility'CAT_POUNCE' and ai.Enabled then
				O.AbilityController:useAbility'CAT_POUNCE'
			end
		end,
		fireball = function(at, au, av)
			launchProjectile(at, au, 'fireball', 60, av)
		end,
		grappling_hook = function(at, au, av)
			launchProjectile(at, au, 'grappling_hook_projectile', 140, av)
		end,
		jade_hammer = function(at, au, av)
			if not O.AbilityController:canUseAbility(at.itemType .. '_jump') then
				repeat
					task.wait()
				until O.AbilityController:canUseAbility(at.itemType .. '_jump') or not ai.Enabled
			end
			if O.AbilityController:canUseAbility(at.itemType .. '_jump') and ai.Enabled then
				O.AbilityController:useAbility(at.itemType .. '_jump')
				am = 1.4 * ao.Value
				al = tick() + 2.5
				an = Vector3.new(av.X, 0, av.Z).Unit
			end
		end,
		tnt = function(at, au, av)
			au = au - Vector3.new(0, (B.character.HipHeight + (B.character.RootPart.Size.Y / 2)) - 3, 0)
			local aw = Vector3.new(math.round(au.X / 3) * 3, math.round(au.Y / 3) * 3, math.round(au.Z / 3) * 3)
			aq = Vector3.new(aw.X, aq.Y, aw.Z) + (av * (at.itemType == 'pirate_gunpowder_barrel' and 2.6 or 0.2))
			O.placeBlock(aw, at.itemType, false)
		end,
		wood_dao = function(at, au, av)
			if (t.Character:GetAttribute'CanDashNext' or 0) > workspace:GetServerTimeNow() or not O.AbilityController:canUseAbility'dash' then
				repeat
					task.wait()
				until (t.Character:GetAttribute'CanDashNext' or 0) < workspace:GetServerTimeNow() and O.AbilityController:canUseAbility'dash' or not ai.Enabled
			end
			if ai.Enabled then
				O.SwordController.lastAttack = workspace:GetServerTimeNow()
				switchItem(at.tool, 0.1)
				f['events-@easy-games/game-core:shared/game-core-networking@getEvents.Events'].useAbility:FireServer('dash', {
					direction = av,
					origin = au,
					weapon = at.itemType
				})
				am = 4.5 * ao.Value
				al = tick() + 2.4
				an = Vector3.new(av.X, 0, av.Z).Unit
			end
		end
	}
	for au, av in {
		'stone_dao',
		'iron_dao',
		'diamond_dao',
		'emerald_dao'
	} do
		at[av] = at.wood_dao
	end
	at.void_axe = at.jade_hammer
	at.siege_tnt = at.tnt
	at.pirate_gunpowder_barrel = at.tnt
	ai = v.Categories.Blatant:CreateModule{
		Name = 'LongJump',
		Function = function(au)
			R.LongJump = au or nil
			updateVelocity()
			if au then
				ai:Clean(b.EntityDamageEvent.Event:Connect(function(av)
					if av.entityInstance == t.Character and av.fromEntity == t.Character and (not av.knockbackMultiplier or not av.knockbackMultiplier.disabled) then
						local aw = O.KnockbackUtil.calculateKnockbackVelocity(Vector3.one, 1, {
							vertical = 0,
							horizontal = (av.knockbackMultiplier and av.knockbackMultiplier.horizontal or 1)
						}).Magnitude * 1.1
						if aw >= am then
							local ax = av.fromPosition and Vector3.new(av.fromPosition.X, av.fromPosition.Y, av.fromPosition.Z) or av.fromEntity and av.fromEntity.PrimaryPart.Position
							if not ax then
								return
							end
							local ay = (B.character.RootPart.Position - ax)
							am = aw
							al = tick() + 2.5
							an = Vector3.new(ay.X, 0, ay.Z).Unit
						end
					end
				end))
				ai:Clean(b.GrapplingHookFunctions.Event:Connect(function(av)
					if av.hookFunction == 'PLAYER_IN_TRANSIT' then
						local aw = B.character.RootPart.CFrame.LookVector
						am = 2.5 * ao.Value
						al = tick() + 2.5
						an = Vector3.new(aw.X, 0, aw.Z).Unit
					end
				end))
				aq = B.isAlive and B.character.RootPart.Position or nil
				ai:Clean(g.PreSimulation:Connect(function(av)
					local aw = B.isAlive and B.character.RootPart or nil
					if aw and r(aw) then
						if al > tick() then
							aw.AssemblyLinearVelocity = an * (getSpeed() + ((al - tick()) > 1.1 and am or 0)) + Vector3.new(0, aw.AssemblyLinearVelocity.Y, 0)
							if B.character.Humanoid.FloorMaterial == Enum.Material.Air and not aq then
								aw.AssemblyLinearVelocity += Vector3.new(0, av * (workspace.Gravity - 23), 0)
							else
								aw.AssemblyLinearVelocity = Vector3.new(aw.AssemblyLinearVelocity.X, 15, aw.AssemblyLinearVelocity.Z)
							end
							aq = nil
						else
							if aq then
								aw.CFrame = CFrame.lookAlong(aq, aw.CFrame.LookVector)
							end
							aw.AssemblyLinearVelocity = Vector3.zero
							am = 0
						end
					else
						aq = nil
					end
				end))
				if L.hand and at[L.hand.tool.Name] then
					task.spawn(at[L.hand.tool.Name], getItem(L.hand.tool.Name), aq, (ap.Enabled and s or B.character.RootPart).CFrame.LookVector)
					return
				end
				for av, aw in at do
					local ax = getItem(av)
					if ax or L.equippedKit == av then
						task.spawn(aw, ax, aq, (ap.Enabled and s or B.character.RootPart).CFrame.LookVector)
						break
					end
				end
			else
				al = tick()
				an = nil
				am = 0
			end
		end,
		ExtraText = function()
			return 'Heatseeker'
		end,
		Tooltip = 'Lets you jump farther'
	}
	ao = ai:CreateSlider{
		Name = 'Speed',
		Min = 1,
		Max = 37,
		Default = 37,
		Suffix = function(au)
			return au == 1 and 'stud' or 'studs'
		end
	}
	ap = ai:CreateToggle{
		Name = 'Camera Direction'
	}
end)
a(function()
	local al = {
		Connection = nil,
		CurrentDuration = 1,
		CachedPrompts = {}
	}
	local function updateAllPrompts(am)
		for an in pairs(al.CachedPrompts) do
			if an and an.Parent then
				an.HoldDuration = am
			else
				al.CachedPrompts[an] = nil
			end
		end
	end
	local function cacheExistingPrompts()
		al.CachedPrompts = {}
		for am, an in workspace:GetDescendants() do
			if an:IsA'ProximityPrompt' then
				al.CachedPrompts[an] = true
				an.HoldDuration = al.CurrentDuration
			end
		end
	end
	local am = v.Categories.Utility:CreateModule{
		Name = 'ProximityPromptDuration',
		Function = function(am)
			if am then
				if al.Connection then
					al.Connection:Disconnect()
					al.Connection = nil
				end
				cacheExistingPrompts()
				al.Connection = workspace.DescendantAdded:Connect(function(an)
					if an:IsA'ProximityPrompt' then
						al.CachedPrompts[an] = true
						an.HoldDuration = al.CurrentDuration
					end
				end)
			else
				if al.Connection then
					al.Connection:Disconnect()
					al.Connection = nil
				end
				al.CachedPrompts = {}
			end
		end,
		Tooltip = 'Set custom duration for all proximity prompts'
	}
	am:CreateSlider{
		Name = 'Duration',
		Min = 0,
		Max = 10,
		Default = 1,
		Decimal = 100,
		Suffix = 's',
		Function = function(an)
			al.CurrentDuration = an
			if am.Enabled then
				updateAllPrompts(an)
			end
		end
	}
end)
a(function()
	local al, am, an = 10
	local ao = v.Categories.Blatant:CreateModule{
		Name = 'NoSlowdown',
		Function = function(ao)
			local ap = O.SprintController:getMovementStatusModifier()
			if ao then
				am = ap.addModifier
				ap.addModifier = function(aq, ar)
					if an and an.Enabled and isFrozen(nil, al) then
						return am(aq, ar)
					end
					if ar.moveSpeedMultiplier then
						ar.moveSpeedMultiplier = math.max(ar.moveSpeedMultiplier, 1)
					end
					return am(aq, ar)
				end
				for aq in ap.modifiers do
					if (aq.moveSpeedMultiplier or 1) < 1 then
						ap:removeModifier(aq)
					end
				end
			else
				ap.addModifier = am
				am = nil
			end
		end,
		Tooltip = 'Prevents slowing down when using items.'
	}
	an = ao:CreateToggle{
		Name = 'Sophia Check',
		Tooltip = 'Allows slowdown ONLY when completely frozen',
		Default = false
	}
end)
a(function()
	local al, am, an = 0
	am = v.Categories.Kits:CreateModule{
		Name = 'AutoVanessa',
		Function = function(ao)
			if ao then
				task.spawn(function()
					repeat
						task.wait()
					until O.TripleShotProjectileController
					if O.TripleShotProjectileController then
						an = O.TripleShotProjectileController.getChargeTime
						O.TripleShotProjectileController.getChargeTime = function(ap)
							return 0
						end
						O.TripleShotProjectileController.overchargeStartTime = tick()
					end
				end)
			else
				if an and O.TripleShotProjectileController then
					O.TripleShotProjectileController.getChargeTime = an
				end
				al = 0
			end
		end,
		Tooltip = 'Auto charges Vanessa triple shot \u{2013} instant charge (no delay)'
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP, aQ, aR, aS, aT, aU = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, false, cloneRaycast(), math.sqrt, math.rad, math.cos, math.clamp, math.min, math.max, false
	local function runPAFOVCircle(aV)
		if aL then
			aL:Disconnect()
			aL = nil
		end
		if aJ then
			aJ:Remove()
			aJ = nil
		end
		if aV then
			aJ = Drawing.new'Circle'
			aJ.Visible = false
			aJ.Thickness = 1
			aJ.Color = Color3.fromRGB(255, 255, 255)
			aJ.Filled = false
			aJ.NumSides = 64
			aL = g.RenderStepped:Connect(function()
				if aJ and an and an.Value then
					local aW = false
					if aH and aH.Enabled and aI and aI.Enabled then
						local aX = L.hand and L.hand.tool
						local aY = aX and aX.Name or ''
						local aZ = O.ItemMeta and O.ItemMeta[aY]
						if aZ and aZ.projectileSource then
							local a_ = aZ.projectileSource
							local a0, a1 = a_.ammoItemTypes and table.find(a_.ammoItemTypes, 'arrow'), aY:find'headhunter'
							if a0 or a1 then
								aW = true
							elseif ap and ap.Enabled then
								local a2, a3 = a_.projectileType and (type(a_.projectileType) == 'function' and a_.projectileType'arrow' or a_.projectileType) or '', false
								for a4, a5 in ipairs(aq and aq.ListEnabled or {}) do
									if tostring(a2):find(a5) then
										a3 = true
										break
									end
								end
								if not a3 then
									aW = true
								end
							end
						end
					end
					aJ.Visible = aW
					local aX = h:GetMouseLocation()
					aJ.Position = Vector2.new(aX.X, aX.Y)
					aJ.Radius = an.Value
				end
			end)
		end
	end
	local function hasBowEquipped()
		if not L.hand or not L.hand.toolType then
			return false
		end
		return L.hand.toolType == 'bow' or L.hand.toolType == 'crossbow'
	end
	local function shouldHideCursor()
		if not aA or not aA.Enabled then
			return false
		end
		if aD and aD.Enabled and isGUIOpen() then
			return false
		end
		if aC and aC.Enabled and not hasBowEquipped() then
			return false
		end
		local aV = isFirstPerson()
		if aB then
			if aB.Value == 'First Person' then
				return aV
			elseif aB.Value == 'Third Person' then
				return not aV
			end
		end
		return true
	end
	local function updateCursor()
		pcall(function()
			h.MouseIconEnabled = not shouldHideCursor()
		end)
	end
	local function checkGUIState()
		local aV = isGUIOpen()
		if aM ~= aV then
			updateCursor()
			aM = aV
		end
	end
	local function shouldPAWork()
		if not az then
			return true
		end
		local aV = isFirstPerson()
		if az.Value == 'First Person' then
			return aV
		elseif az.Value == 'Third Person' then
			return not aV
		end
		return true
	end
	local function isBlacklisted(aV)
		if not ap.Enabled then
			return not aV:find'arrow'
		end
		for aW, aX in ipairs(aq.ListEnabled) do
			if aV:find(aX) then
				return true
			end
		end
		return false
	end
	local function pickRandomPart(aV)
		local aW = math.random(1, 100)
		if aW <= au.Value then
			return aV:FindFirstChild'Head' or aV:FindFirstChild'HumanoidRootPart'
		else
			return aV:FindFirstChild'HumanoidRootPart'
		end
	end
	local function getClosestPart(aV, aW)
		local aX, aY = {
			'HumanoidRootPart',
			'Head',
			'LeftHand',
			'RightHand',
			'LeftLowerArm',
			'RightLowerArm',
			'LeftUpperArm',
			'RightUpperArm',
			'LeftFoot',
			'RightFoot',
			'LeftLowerLeg',
			'RightLowerLeg',
			'LeftUpperLeg',
			'RightUpperLeg',
			'LowerTorso',
			'UpperTorso'
		}, s
		local aZ, a_, a0, a1 = aY.CFrame.Position, aY:ScreenPointToRay(aW.X, aW.Y, 0).Direction, (math.huge)
		for a2, a3 in ipairs(aX) do
			local a4 = aV:FindFirstChild(a3)
			if a4 then
				local a5 = (a4.Position - aZ).Unit
				local a6 = math.acos(aR(a_:Dot(a5), - 1, 1))
				if a6 < a0 then
					a0 = a6
					a1 = a4
				end
			end
		end
		return a1 or aV:FindFirstChild'HumanoidRootPart'
	end
	aI = v.Categories.Blatant:CreateModule{
		Name = 'ProjectileAimbot',
		Function = function(aV)
			if aV then
				if aH then
					runPAFOVCircle(aH.Enabled)
				end
				if aA and aA.Enabled and not aE then
					aE = g.RenderStepped:Connect(function()
						checkGUIState()
						updateCursor()
					end)
				end
				aF = O.ProjectileController.calculateImportantLaunchValues
				O.ProjectileController.calculateImportantLaunchValues = function(...)
					local aW, aX, aY, aZ, a_ = ...
					local a0 = B.isAlive and (a_ or (B.character and B.character.RootPart and B.character.RootPart.Position)) or Vector3.zero
					if not aU then
						aG = nil
					end
					aU = true
					local a1 = (al.Value == 'Head') and 'Head' or 'RootPart'
					local a2 = B.EntityMouse{
						Part = a1,
						Range = an.Value,
						Players = am.Players.Enabled,
						NPCs = (am.NPCs and am.NPCs.Enabled) or false,
						Wallcheck = am.Walls.Enabled,
						Origin = a0
					}
					if not a2 then
						aU = false
						local a3, a4 = pcall(aF, ...)
						return a3 and a4 or nil
					end
					if not shouldPAWork() then
						aU = false
						return aF(...)
					end
					local a3
					if al.Value == 'Dynamic' then
						local a4 = L.hand and L.hand.tool
						local a5 = tostring(a4 and a4.Name or ''):lower()
						local a6 = a5:find'headhunter'
						a3 = a6 and (a2.Character:FindFirstChild'Head' or a2.RootPart) or a2.RootPart
					elseif al.Value == 'RootPart' then
						a3 = a2.RootPart
					elseif al.Value == 'Head' then
						a3 = a2.Head or a2.RootPart
					elseif al.Value == 'Closest' then
						local a4 = h:GetMouseLocation()
						a3 = getClosestPart(a2.Character, a4)
					elseif al.Value == 'Randomize' then
						if not aG or not aG.Parent then
							aG = pickRandomPart(a2.Character)
						end
						a3 = aG
					else
						a3 = a2.RootPart
					end
					if not a3 then
						aU = false
						return aF(...)
					end
					local a4 = (a3.Position - a0).Magnitude
					if a4 > ao.Value then
						aU = false
						return aF(...)
					end
					local a5 = a_ or aW:getLaunchPosition(aZ)
					if not a5 then
						aU = false
						return aF(...)
					end
					local a6 = aX.projectile or ''
					if isBlacklisted(a6) then
						aU = false
						return aF(...)
					end
					local a7 = aX:getProjectileMeta()
					local a8, a9, ba, bb, bc, bd = (aY and a7.predictionLifetimeSec or a7.lifetimeSec or 3), (a7.gravitationalAcceleration or 196.2) * aX.gravityMultiplier, (a7.launchVelocity or 100), a5 + (aX.projectile == 'owl_projectile' and Vector3.zero or aX.fromPositionOffset), a2.Character and a2.Character:GetAttribute'InflatedBalloons', workspace.Gravity
					if bc and bc > 0 then
						bd = workspace.Gravity * (1 - (bc >= 4 and 1.2 or bc >= 3 and 1 or 0.975))
					end
					if a2.Character and a2.Character.PrimaryPart and a2.Character.PrimaryPart:FindFirstChild'rbxassetid://8200754399' then
						bd = 6
					end
					if a2.Player and a2.Player:GetAttribute'IsOwlTarget' then
						for be, bf in ipairs(l:GetTagged'Owl') do
							if bf:GetAttribute'Target' == a2.Player.UserId and bf:GetAttribute'Status' == 2 then
								bd = 0
								break
							end
						end
					end
					local be = a3.Velocity
					if aw and aw.Enabled then
						local bf, bg = (ax and ax.Value or 100) / 100, (ay and ay.Value or 100) / 100
						be = Vector3.new(be.X * bf, be.Y * bg, be.Z * bf)
					end
					local bf, bg, bh = O.BowConstantsTable.RelX or 0, O.BowConstantsTable.RelY or 0, O.BowConstantsTable.RelZ or 0
					local bi = CFrame.new(bb, a3.Position) * CFrame.new(aX.projectile == 'owl_projectile' and Vector3.zero or Vector3.new(bf, bg, bh))
					local bj = I.SolveTrajectory(bi.p, ba, a9, a3.Position, aX.projectile == 'telepearl' and Vector3.zero or be, bd, a2.HipHeight, a2.Jumping and 42.6 or nil, aN)
					if bj then
						if C and C.Targets then
							C.Targets[a2] = tick() + 1
						end
						local bk = 5
						if aK.Enabled then
							if aX.projectile:find'arrow' then
								bk = 0.58 * (at.Value / 100)
							elseif aX.projectile:find'frosty_snowball' then
								local bl = L.hand and L.hand.tool
								if bl and bl.Name:find'frost_staff' then
									local bm = (bl.Name:find'frost_staff_3' and 0.16) or (bl.Name:find'frost_staff_2' and 0.18) or 0.2
									bk = bm * (at.Value / 100)
								end
							end
						else
							bk = 5
						end
						aU = false
						return {
							initialVelocity = CFrame.new(bi.Position, bj).LookVector * ba,
							positionFrom = bb,
							deltaT = a8,
							gravitationalAcceleration = a9,
							drawDurationSeconds = bk
						}
					end
					aU = false
					return aF(...)
				end
			else
				O.ProjectileController.calculateImportantLaunchValues = aF
				aU = false
				aG = nil
				if aE then
					aE:Disconnect()
					aE = nil
				end
				runPAFOVCircle(false)
				pcall(function()
					h.MouseIconEnabled = true
				end)
			end
		end,
		Tooltip = 'Silently adjusts your aim towards the enemy'
	}
	am = aI:CreateTargets{
		Players = true,
		NPCs = true,
		Walls = true
	}
	al = aI:CreateDropdown{
		Name = 'Part',
		List = {
			'Dynamic',
			'RootPart',
			'Head',
			'Closest',
			'Randomize'
		},
		Default = 'RootPart',
		Tooltip = 'Select which body part to aim at',
		Function = function()
			aG = nil
			aU = false
		end
	}
	ar = aI:CreateDropdown{
		Name = 'Sort Method',
		List = {
			'Distance',
			'Damage',
			'Threat',
			'Kit',
			'Health',
			'Angle',
			'Cursor',
			'Forest'
		},
		Default = 'Distance',
		Tooltip = 'Prioritize targets when multiple are in range'
	}
	az = aI:CreateDropdown{
		Name = 'PA Work Mode',
		List = {
			'First Person',
			'Third Person',
			'Both'
		},
		Default = 'Both',
		Tooltip = 'Which perspective the aimbot works in'
	}
	ao = aI:CreateSlider{
		Name = 'Range',
		Min = 10,
		Max = 500,
		Default = 100,
		Tooltip = 'Maximum distance (in studs) for targeting'
	}
	an = aI:CreateSlider{
		Name = 'FOV',
		Min = 1,
		Max = 1000,
		Default = 1000
	}
	aH = aI:CreateToggle{
		Name = 'FOV Circle',
		Tooltip = 'Shows a circle representing your FOV on screen',
		Function = function(aV)
			runPAFOVCircle(aV)
		end
	}
	au = aI:CreateSlider{
		Name = 'Head Chance',
		Min = 0,
		Max = 100,
		Default = 50,
		Darker = true,
		Tooltip = 'Chance to aim at head when Part is set to Randomize',
		Visible = false
	}
	av = aI:CreateSlider{
		Name = 'Torso Chance',
		Min = 0,
		Max = 100,
		Default = 50,
		Darker = true,
		Tooltip = 'Chance to aim at torso when Part is set to Randomize',
		Visible = false
	}
	local function updateRandomizeVisibility()
		local aV = (al.Value == 'Randomize')
		au.Object.Visible = aV
		av.Object.Visible = aV
	end
	if al.AddHook then
		al:AddHook(updateRandomizeVisibility)
	end
	updateRandomizeVisibility()
	aA = aI:CreateToggle{
		Name = 'Hide Cursor',
		Default = false,
		Tooltip = 'Hides the cursor while aiming',
		Function = function(aV)
			if aB then
				aB.Object.Visible = aV
			end
			if aC then
				aC.Object.Visible = aV
			end
			if aD then
				aD.Object.Visible = aV
			end
			if aV and aI.Enabled then
				if not aE then
					aE = g.RenderStepped:Connect(function()
						checkGUIState()
						updateCursor()
					end)
				end
				updateCursor()
			else
				if aE then
					aE:Disconnect()
					aE = nil
				end
				pcall(function()
					h.MouseIconEnabled = true
				end)
			end
		end
	}
	aB = aI:CreateDropdown{
		Name = 'Cursor View Mode',
		List = {
			'First Person',
			'Third Person',
			'Both'
		},
		Default = 'First Person',
		Darker = true,
		Visible = false,
		Function = function()
			if aI.Enabled and aA.Enabled then
				updateCursor()
			end
		end
	}
	aC = aI:CreateToggle{
		Name = 'Limit to Bow',
		Darker = true,
		Visible = false,
		Tooltip = 'Only hides cursor when bow/crossbow is equipped',
		Function = function()
			if aI.Enabled and aA.Enabled then
				updateCursor()
			end
		end
	}
	aD = aI:CreateToggle{
		Name = 'Show on GUI',
		Darker = true,
		Visible = false,
		Tooltip = 'Shows cursor when a GUI is open',
		Function = function()
			if aI.Enabled and aA.Enabled then
				updateCursor()
			end
		end
	}
	aw = aI:CreateToggle{
		Name = 'Custom Prediction',
		Default = false,
		Tooltip = 'Enable to customize horizontal/vertical prediction multipliers',
		Function = function()
			if ax then
				ax.Object.Visible = aw.Enabled
			end
			if ay then
				ay.Object.Visible = aw.Enabled
			end
		end
	}
	ax = aI:CreateSlider{
		Name = 'Horizontal Multiplier',
		Min = 0,
		Max = 200,
		Default = 100,
		Suffix = '%',
		Darker = true,
		Visible = false,
		Tooltip = 'Adjust horizontal prediction strength (0% = none, 100% = normal, 200% = double)'
	}
	ay = aI:CreateSlider{
		Name = 'Vertical Multiplier',
		Min = 0,
		Max = 200,
		Default = 100,
		Suffix = '%',
		Darker = true,
		Visible = false,
		Tooltip = 'Adjust vertical prediction strength (0% = none, 100% = normal, 200% = double)'
	}
	ap = aI:CreateToggle{
		Name = 'Other Projectiles',
		Default = true,
		Function = function(aV)
			if aq then
				aq.Object.Visible = aV
			end
		end
	}
	aq = aI:CreateTextList{
		Name = 'Blacklist',
		Darker = true,
		Default = {
			'telepearl'
		},
		Visible = ap.Enabled
	}
	aK = aI:CreateToggle{
		Name = 'AutoCharge',
		Default = true,
		Function = function(aV)
			if at and at.Object then
				at.Object.Visible = aV
			end
		end
	}
	at = aI:CreateSlider{
		Name = 'Charge Percent',
		Min = 1,
		Max = 100,
		Default = 100,
		Tooltip = 'Bow/frost staff charge percentage (affects damage)'
	}
end)
a(function()
	TaxRemover = v.Categories.Blatant:CreateModule{
		Name = 'TaxRemover',
		Function = function(al)
			if al then
				oldtax = O.ShopTaxController.isTaxed
				oldadded = O.ShopTaxController.getAddedTax
				olditems = O.ShopTaxController.getTaxedItems
				oldDispatch = O.Store.dispatch
				task.spawn(function()
					O.Store.dispatch = function(...)
						local am = select(2, ...)
						if am and typeof(am) == 'table' and am.type == 'IncrementTaxState' then
							return false
						end
						return oldDispatch(...)
					end
				end)
				task.spawn(function()
					O.ShopTaxController.isTaxed = function(...)
						return false
					end
				end)
				task.spawn(function()
					O.ShopTaxController.getTaxedItems = function(...)
						return {}
					end
				end)
				task.spawn(function()
					O.ShopTaxController.getAddedTax = function(...)
						return 0
					end
				end)
				task.spawn(function()
					if O.ShopTaxController.taxStateUpdateEvent then
						oldConnect = O.ShopTaxController.taxStateUpdateEvent.Connect
						O.ShopTaxController.taxStateUpdateEvent.Connect = function()
							return {
								Disconnect = function()
								end
							}
						end
					end
				end)
				task.spawn(function()
					O.ShopTaxController.hasTax = false
					O.ShopTaxController.taxedItems = {}
					O.ShopTaxController.addedTaxMap = {}
				end)
			else
				O.Store.dispatch = oldDispatch
				O.ShopTaxController.isTaxed = oldtax
				O.ShopTaxController.getAddedTax = oldadded
				O.ShopTaxController.getTaxedItems = olditems
				O.ShopTaxController.taxStateUpdateEvent.Connect = oldConnect
				oldDispatch = nil
				oldtax = nil
				oldadded = nil
				olditems = nil
				oldConnect = nil
			end
		end
	}
end)
a(function()
	local al, am, an, ao, ap
	local function getAmmo(aq)
		for ar, at in L.inventory.inventory.items do
			if aq.ammoItemTypes and table.find(aq.ammoItemTypes, at.itemType) then
				return at.itemType
			end
		end
		return
	end
	local function getProjectiles()
		local aq = {}
		for ar, at in L.inventory.inventory.items do
			local au = O.ItemMeta[at.itemType].projectileSource
			local av = au and getAmmo(au)
			if av and table.find(am.ListEnabled, av) then
				table.insert(aq, {
					at,
					av,
					au.projectileType(av),
					au
				})
			end
		end
		return aq
	end
	local aq = {}
	local function getAttackData()
		local ar = L.hand
		if not ar or not ar.tool then
			return
		end
		local at = O.ItemMeta[ar.tool.Name]
		if not at or not at.projectileSource then
			return
		end
		if (aq[ar.tool.Name] or 0) > tick() then
			return
		end
		local au, av = getAmmo(at.projectileSource), ar.tool.Name:find'frost_staff'
		if not au and not av then
			return
		end
		if av then
			au = ar.tool.Name:gsub('frost_staff', 'frosty_snowball')
		end
		local aw = canDebug and at.projectileType or function(aw)
			return 'arrow'
		end
		return ar, at, au, aw(au)
	end
	local function shootFunc()
		if not h.MouseEnabled then
			local ar, at, au, av = getAttackData()
			if ar then
				local aw = O.ProjectileMeta[au]
				local ax, ay = aw.launchVelocity, B.character.RootPart.Position
				local az = ay + s.CFrame.LookVector * 50
				local aA, aB, aC = CFrame.lookAt(ay, az).LookVector, (CFrame.new(ay, az) * CFrame.new(Vector3.new(- O.BowConstantsTable.RelX, - O.BowConstantsTable.RelY, - O.BowConstantsTable.RelZ))).Position, j:GenerateGUID(true)
				O.ProjectileController:createLocalProjectile(at, au, av, aB, aC, aA * ax, {
					drawDurationSeconds = 1
				})
				O.Client:Get(P.FireProjectile):CallServerAsync(ar.tool, au, av, aB, ay, aA * ax, aC, {
					drawDurationSeconds = 1,
					shotId = j:GenerateGUID(false)
				}, workspace:GetServerTimeNow() - 0.045):andThen(function(aD)
					if aD then
						aD.Parent = f
					end
				end)
				local aD = at.projectileSource.launchSound
				aD = aD and aD[math.random(1, # aD)] or nil
				if aD then
					O.SoundManager:playSound(aD)
				end
			end
		else
			mouse1click()
		end
	end
	al = v.Categories.Utility:CreateModule{
		Name = 'AutoShoot',
		Disabled = not canDebug,
		Tooltip = 'Automatically swaps to another projectile source while swinging ur sword',
		Function = function(ar)
			if ar then
				LPH_NO_VIRTUALIZE(function()
					local at = tick()
					repeat
						if L.hand.toolType == 'sword' then
							if (tick() - O.SwordController.lastSwing) < 0.29 then
								if tick() > at then
									for au, av in getProjectiles() do
										if (aq[av[1].itemType] or 0) < tick() then
											local aw, ax = getHotbar(av[1].tool), L.hand.tool and getHotbar(L.hand.tool) or 0
											if aw and ax and hotbarSwitch(aw) then
												task.wait(an.Value)
												shootFunc()
												if v.Modules['Auto Clicker'].Enabled and h.MouseEnabled then
													task.delay(g.PostSimulation:Wait(), mouse1press)
												end
												task.wait(an.Value)
												aq[av[1].itemType] = tick() + (av[4].fireDelaySec + ap:GetRandomValue())
												hotbarSwitch(ax)
												task.wait(ao.Value)
												if (tick() - O.SwordController.lastSwing) > 0.29 then
													break
												end
											end
										end
									end
								end
							else
								at = tick() + 0.75
							end
						end
						task.wait(0.1)
					until not al.Enabled
				end)()
			end
		end
	}
	am = al:CreateTextList{
		Name = 'Projectiles',
		Default = {
			'arrow'
		},
		Placeholder = 'projectile'
	}
	ap = al:CreateTwoSlider{
		Name = 'Fire Rate',
		Min = 0,
		Max = 1,
		DefaultMin = 0.05,
		DefaultMax = 0.12,
		Decimal = 100
	}
	ao = al:CreateSlider{
		Name = 'Change Delay',
		Min = 0,
		Max = 1,
		Decimal = 100,
		Suffix = 'seconds',
		Default = 0.75
	}
	an = al:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 1,
		Decimal = 100,
		Suffix = 'seconds',
		Default = 0.05
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au = cloneRaycast(), {
		InvokeServer = function()
		end
	}, {}
	task.spawn(function()
		am = O.Client:Get(P.FireProjectile).instance
	end)
	local function getAmmo(av)
		for aw, ax in L.inventory.inventory.items do
			if av.ammoItemTypes and table.find(av.ammoItemTypes, ax.itemType) then
				return ax.itemType
			end
		end
	end
	local function getProjectiles()
		local av = {}
		for aw, ax in L.inventory.inventory.items do
			local ay = O.ItemMeta[ax.itemType]
			local az = ay and ay.projectileSource
			local aA = az and getAmmo(az)
			if aA and table.find(ar.ListEnabled, aA) then
				table.insert(av, {
					ax,
					aA,
					az.projectileType(aA),
					az
				})
			end
		end
		return av
	end
	ao = v.Categories.Blatant:CreateModule{
		Name = 'ProjectileAura',
		Function = function(av)
			if av then
				repeat
					local aw, ax = L.hand and L.hand.tool and L.hand.tool.Name:find'crossbow', L.hand and L.hand.tool and L.hand.tool.Name:find'bow'
					if at.Enabled and not aw and not ax then
						task.wait(0.1)
						continue
					end
					if (workspace:GetServerTimeNow() - O.SwordController.lastAttack) > 0.5 then
						local ay = B.EntityPosition{
							Part = 'RootPart',
							Range = aq.Value,
							Players = ap.Players.Enabled,
							NPCs = ap.NPCs.Enabled,
							Wallcheck = ap.Walls.Enabled
						}
						if ay then
							local az = B.character.RootPart.Position
							for aA, aB in getProjectiles() do
								local aC, aD, aE, aF = unpack(aB)
								if (an[aC.itemType] or 0) < tick() then
									al.FilterDescendantsInstances = {
										workspace.Map
									}
									local aG = O.ProjectileMeta[aE]
									local aH, aI = aG.launchVelocity, aG.gravitationalAcceleration or 196.2
									local aJ = I.SolveTrajectory(az, aH, aI, ay.RootPart.Position, ay.RootPart.Velocity, workspace.Gravity, ay.HipHeight, ay.Jumping and 42.6 or nil, al)
									if aJ then
										C.Targets[ay] = tick() + 1
										local aK = switchItem(aC.tool)
										task.spawn(function()
											local aL, aM, aN = CFrame.lookAt(az, aJ).LookVector, j:GenerateGUID(true), (CFrame.new(az, aJ) * CFrame.new(Vector3.new(- O.BowConstantsTable.RelX, - O.BowConstantsTable.RelY, - O.BowConstantsTable.RelZ))).Position
											if aw then
												O.ViewmodelController:playAnimation(O.AnimationType.FP_CROSSBOW_FIRE)
												O.GameAnimationUtil:playAnimation(t, O.AnimationType.CROSSBOW_FIRE)
											elseif ax then
												O.ViewmodelController:playAnimation(O.AnimationType.FP_CROSSBOW_FIRE)
												O.GameAnimationUtil:playAnimation(t, O.AnimationType.BOW_FIRE)
											else
												local aO = O.ItemMeta[aC.tool.Name].thirdPerson and O.ItemMeta[aC.tool.Name].thirdPerson.shootAnimation
												if aO then
													O.GameAnimationUtil:playAnimation(t, aO)
												end
											end
											O.ProjectileController:createLocalProjectile(aG, aD, aE, aN, aM, aL * aH, {
												drawDurationSeconds = 1
											})
											local aO = am:InvokeServer(aC.tool, aD, aE, aN, az, aL * aH, aM, {
												drawDurationSeconds = 1,
												shotId = j:GenerateGUID(false)
											}, workspace:GetServerTimeNow() - 0.045)
											if not aO then
												an[aC.itemType] = tick()
											else
												local aP = aF.launchSound
												aP = aP and aP[math.random(1, # aP)] or nil
												if aP then
													O.SoundManager:playSound(aP)
												end
											end
										end)
										an[aC.itemType] = tick() + (aF.fireDelaySec / au.Value)
										if aK then
											task.wait(0.05)
										end
									end
								end
							end
						end
					end
					task.wait(0.1)
				until not ao.Enabled
			end
		end,
		Tooltip = 'Shoots people around you with viewmodel animations'
	}
	ap = ao:CreateTargets{
		Players = true,
		Walls = true
	}
	ar = ao:CreateTextList{
		Name = 'Projectiles',
		Default = {
			'arrow',
			'snowball'
		}
	}
	aq = ao:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 50,
		Default = 50,
		Suffix = function(av)
			return av == 1 and 'stud' or 'studs'
		end
	}
	at = ao:CreateToggle{
		Name = 'Hand Check',
		Default = false,
		Tooltip = 'Only shoot when holding a bow or crossbow'
	}
	au = ao:CreateSlider{
		Name = 'Fire Speed',
		Min = 0.5,
		Max = 3,
		Default = 1,
		Decimal = 10,
		Tooltip = 'Lower = faster, Higher = slower. 1.0 = normal speed'
	}
end)
a(function()
	local al = {
		Enabled = false
	}
	al = v.Categories.World:CreateModule{
		Name = 'Leave Party',
		Function = function(am)
			if am then
				al:Toggle(false)
				game:GetService'ReplicatedStorage':WaitForChild'events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events':WaitForChild'leaveParty':FireServer()
			end
		end
	}
end)
a(function()
	local al, am, an, ao = {
		Enabled = false
	}, 0.58
	al = v.Categories.Utility:CreateModule{
		Name = 'AutoChargeBow',
		Function = function(ap)
			if ap then
				ao = O.ProjectileController.calculateImportantLaunchValues
				O.ProjectileController.calculateImportantLaunchValues = function(...)
					local aq = ao(...)
					if aq then
						aq.drawDurationSeconds = (an.Value / 100) * am
					end
					return aq
				end
			else
				if ao then
					O.ProjectileController.calculateImportantLaunchValues = ao
					ao = nil
				end
			end
		end,
		Tooltip = 'Automatically charges your bow with controllable charge percentage'
	}
	an = al:CreateSlider{
		Name = 'Charge Percent',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%',
		Tooltip = 'Control bow charge percentage (affects damage): 100% = full damage, 50% = half damage, etc.'
	}
end)
a(function()
	local al, am, an, ao, ap = {}, {}, {}, {
		'titan',
		'golem',
		'bhaa',
		'spiritgolem',
		'voidgolem'
	}
	local function matchesTitanPattern(aq)
		local ar = aq:lower()
		for at, au in ipairs(ao) do
			if ar:find(au, 1, true) then
				return true
			end
		end
		return false
	end
	local aq = v.Categories.BoostFPS:CreateModule{
		Name = 'Titan Remover',
		Function = function(aq)
			if aq then
				for ar, at in ipairs(al) do
					if at and type(at) == 'userdata' and at.Connected then
						at:Disconnect()
					end
				end
				al = {}
				am = {}
				an = {}
				local function processModel(ar)
					if am[ar] then
						return
					end
					am[ar] = true
					local at, au = ap and ap.Enabled, ar:GetDescendants()
					for av, aw in ipairs(au) do
						if aw.Name == 'Nametag' and aw.Parent and aw.Parent.Name == 'Head' then
							continue
						end
						if aw:IsA'BasePart' and not at then
							if not an[aw] then
								an[aw] = {
									Transparency = aw.Transparency,
									CanCollide = aw.CanCollide,
									CastShadow = aw.CastShadow,
									CanQuery = aw.CanQuery
								}
								aw.Transparency = 1
								aw.CanCollide = false
								aw.CastShadow = false
								aw.CanQuery = false
							end
						elseif (aw:IsA'Decal' or aw:IsA'Texture') and not at then
							if not an[aw] then
								an[aw] = {
									Transparency = aw.Transparency
								}
								aw.Transparency = 1
							end
						elseif aw:IsA'ParticleEmitter' then
							if not an[aw] then
								an[aw] = {
									Enabled = aw.Enabled
								}
								aw.Enabled = false
							end
						elseif aw:IsA'Sound' then
							if not an[aw] then
								an[aw] = {
									Volume = aw.Volume
								}
								aw.Volume = 0
							end
						elseif aw:IsA'SurfaceGui' or aw:IsA'BillboardGui' then
							if not an[aw] then
								an[aw] = {
									Enabled = aw.Enabled
								}
								aw.Enabled = false
							end
						end
					end
				end
				local function hideTitanAssets()
					for ar, at in ipairs(workspace:GetChildren()) do
						if at:IsA'Model' and matchesTitanPattern(at.Name) then
							processModel(at)
						end
					end
					local function hideBossBars()
						for ar, at in ipairs(o:GetDescendants()) do
							if at:IsA'ScreenGui' and (at.Name:find'BossBar' or at.Name:find'Boss') then
								if not an[at] then
									an[at] = {
										Enabled = at.Enabled
									}
									at.Enabled = false
								end
							end
						end
						local ar = e.LocalPlayer
						if ar and ar:FindFirstChild'PlayerGui' then
							for at, au in ipairs(ar.PlayerGui:GetDescendants()) do
								if au:IsA'ScreenGui' and (au.Name:find'BossBar' or au.Name:find'Boss') then
									if not an[au] then
										an[au] = {
											Enabled = au.Enabled
										}
										au.Enabled = false
									end
								end
							end
						end
					end
					pcall(hideBossBars)
				end
				hideTitanAssets()
				local ar = workspace.DescendantAdded:Connect(function(ar)
					if ar:IsA'Model' then
						if not matchesTitanPattern(ar.Name) then
							return
						end
						task.delay(0.1, function()
							if ar.Parent then
								processModel(ar)
							end
						end)
					elseif ar:IsA'ParticleEmitter' then
						local at = ar.Parent
						if not at or not matchesTitanPattern(at.Name) then
							return
						end
						if not an[ar] then
							an[ar] = {
								Enabled = ar.Enabled
							}
							ar.Enabled = false
						end
					elseif ar:IsA'Sound' then
						if not matchesTitanPattern(ar.Name) then
							return
						end
						if not an[ar] then
							an[ar] = {
								Volume = ar.Volume
							}
							ar.Volume = 0
						end
					end
				end)
				table.insert(al, ar)
				task.spawn(function()
					local at, au = l, {
						'Bhaa',
						'spiritGolem',
						'GolemBoss',
						'Titan'
					}
					for av, aw in ipairs(au) do
						local ax, ay = pcall(function()
							return at:GetTagged(aw)
						end)
						if ax then
							for az, aA in ipairs(ay) do
								if aA:IsA'Model' and not am[aA] then
									processModel(aA)
								end
							end
							local az = at:GetInstanceAddedSignal(aw):Connect(function(az)
								if az:IsA'Model' and not am[az] then
									task.delay(0.1, function()
										if az.Parent then
											processModel(az)
										end
									end)
								end
							end)
							table.insert(al, az)
						end
					end
				end)
			else
				for ar, at in ipairs(al) do
					if at and type(at) == 'userdata' and at.Connected then
						pcall(function()
							at:Disconnect()
						end)
					end
				end
				al = {}
				for ar, at in pairs(an) do
					if ar and ar.Parent then
						pcall(function()
							for au, av in pairs(at) do
								if ar[au] ~= nil then
									ar[au] = av
								end
							end
						end)
					end
				end
				am = {}
				an = {}
			end
		end,
		Tooltip = 'Removes Titan/Bhaa models and effects for FPS boost'
	}
	ap = aq:CreateToggle{
		Name = 'Effects Only',
		Default = false,
		Tooltip = 'Only hides particles keeps titan models visible',
		Function = function(ar)
			if aq.Enabled then
				for at, au in pairs(an) do
					if at and at.Parent then
						pcall(function()
							for av, aw in pairs(au) do
								if at[av] ~= nil then
									at[av] = aw
								end
							end
						end)
					end
				end
				am = {}
				an = {}
				aq:Toggle()
				task.wait()
				aq:Toggle()
			end
		end
	}
end)
a(function()
	local al, am, an, ao, ap, aq = (cloneRaycast())
	al.RespectCanCollide = true
	A = v.Categories.Blatant:CreateModule{
		Name = 'Speed',
		Function = function(ar)
			R.Speed = ar or nil
			updateVelocity()
			pcall(function()
				debug.setconstant(O.WindWalkerController.updateSpeed, 7, ar and 'constantSpeedMultiplier' or 'moveSpeedMultiplier')
			end)
			if ar then
				A:Clean(g.PreSimulation:Connect(function(at)
					O.StatefulEntityKnockbackController.lastImpulseTime = ar and math.huge or time()
					if B.isAlive then
						if not ah.Enabled and not ai.Enabled then
							O.SprintController:setSpeed(am.Value == 'CFrame' and 20 or an.Value)
							if am.Value == 'CFrame' then
								local au = B.character.Humanoid:GetState()
								if au == Enum.HumanoidStateType.Climbing then
									return
								end
								local av, aw, ax = B.character.RootPart, getSpeed(), ag or B.character.Humanoid.MoveDirection
								local ay = (ax * math.max(an.Value - aw, 0) * at)
								if ao.Enabled then
									al.FilterDescendantsInstances = {
										t.Character,
										s
									}
									al.CollisionGroup = av.CollisionGroup
									local az = workspace:Raycast(av.Position, ay, al)
									if az then
										ay = ((az.Position + az.Normal) - av.Position)
									end
								end
								av.CFrame += ay
								av.AssemblyLinearVelocity = (ax * aw) + Vector3.new(0, av.AssemblyLinearVelocity.Y, 0)
								if ap.Enabled and (au == Enum.HumanoidStateType.Running or au == Enum.HumanoidStateType.Landed) and ax ~= Vector3.zero and (ak or aq.Enabled) then
									B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
								end
							end
						end
					end
				end))
			else
				O.SprintController:setSpeed(O.SprintController:isSprinting() and 20 or 14)
			end
		end,
		ExtraText = function()
			return 'Heatseeker'
		end,
		Tooltip = 'Increases your movement with various methods.'
	}
	am = A:CreateDropdown{
		Name = 'Method',
		List = {
			'Bedwars',
			'CFrame'
		},
		Default = 'CFrame'
	}
	an = A:CreateSlider{
		Name = 'Speed',
		Min = 1,
		Max = 23,
		Default = 23,
		Suffix = function(ar)
			return ar == 1 and 'stud' or 'studs'
		end
	}
	ao = A:CreateToggle{
		Name = 'Wall Check',
		Default = true
	}
	ap = A:CreateToggle{
		Name = 'AutoJump',
		Function = function(ar)
			aq.Object.Visible = ar
		end
	}
	aq = A:CreateToggle{
		Name = 'Always Jump',
		Visible = false,
		Darker = true
	}
	task.defer(function()
		if aq and aq.Object then
			aq.Object.Visible = false
		end
	end)
end)
a(function()
	local al
	al = v.Categories.Utility:CreateModule{
		Name = 'GrimReaperFix',
		Function = function(am)
			if am then
				al:Clean(g.Heartbeat:Connect(function()
					if not B.isAlive then
						return
					end
					local an = B.character.Humanoid
					if an.HipHeight > 2.1 then
						an.HipHeight = 2.05
					end
				end))
			end
		end,
		Tooltip = 'Fixes Grim Reaper height (prevents being too tall)'
	}
end)
a(function()
	local al, am, an = {}, (Instance.new'Folder')
	am.Parent = v.gui
	local function Added(ao)
		if not an.Enabled then
			return
		end
		local ap = Instance.new'Folder'
		ap.Parent = am
		al[ao] = ap
		local aq = ao:GetChildren()
		table.sort(aq, function(ar, at)
			return ar.Name > at.Name
		end)
		for ar, at in aq do
			if at:IsA'BasePart' and at.Name ~= 'Blanket' then
				local au = Instance.new'BoxHandleAdornment'
				au.Size = at.Size + Vector3.new(0.01, 0.01, 0.01)
				au.AlwaysOnTop = true
				au.ZIndex = 2
				au.Visible = true
				au.Adornee = at
				au.Color3 = at.Color
				if at.Name == 'Legs' then
					au.Color3 = Color3.fromRGB(167, 112, 64)
					au.Size = at.Size + Vector3.new(0.01, - 1, 0.01)
					au.CFrame = CFrame.new(0, - 0.4, 0)
					au.ZIndex = 0
				end
				au.Parent = ap
			end
		end
		table.clear(aq)
	end
	an = v.Categories.Render:CreateModule{
		Name = 'BedESP',
		Function = function(ao)
			if ao then
				an:Clean(l:GetInstanceAddedSignal'bed':Connect(function(ap)
					task.delay(0.2, Added, ap)
				end))
				an:Clean(l:GetInstanceRemovedSignal'bed':Connect(function(ap)
					if al[ap] then
						al[ap]:Destroy()
						al[ap] = nil
					end
				end))
				for ap, aq in l:GetTagged'bed' do
					Added(aq)
				end
			else
				am:ClearAllChildren()
				table.clear(al)
			end
		end,
		Tooltip = 'Render Beds through walls'
	}
end)
a(function()
	local al
	al = v.Categories.Render:CreateModule{
		Name = 'Health',
		Function = function(am)
			if am then
				local an = Instance.new'TextLabel'
				an.Size = UDim2.fromOffset(100, 20)
				an.Position = UDim2.new(0.5, 6, 0.5, 30)
				an.BackgroundTransparency = 1
				an.AnchorPoint = Vector2.new(0.5, 0)
				an.Text = B.isAlive and math.round(t.Character:GetAttribute'Health') .. ' \u{2764}\u{fe0f}' or ''
				an.TextColor3 = B.isAlive and Color3.fromHSV((t.Character:GetAttribute'Health' / t.Character:GetAttribute'MaxHealth') / 2.8, 0.86, 1) or Color3.new()
				an.TextSize = 18
				an.Font = Enum.Font.Arial
				an.Parent = v.gui
				al:Clean(an)
				al:Clean(b.AttributeChanged.Event:Connect(function()
					an.Text = B.isAlive and math.round(t.Character:GetAttribute'Health') .. ' \u{2764}\u{fe0f}' or ''
					an.TextColor3 = B.isAlive and Color3.fromHSV((t.Character:GetAttribute'Health' / t.Character:GetAttribute'MaxHealth') / 2.8, 0.86, 1) or Color3.new()
				end))
			end
		end,
		Tooltip = 'Displays your health in the center of your screen.'
	}
end)
a(function()
	local al, am, an, ao, ap, aq = {}, {}, (Instance.new'Folder')
	an.Parent = v.gui
	local ar, at, au = {
		alchemist = {
			'alchemist_ingedients',
			'wild_flower'
		},
		beekeeper = {
			'bee',
			'bee'
		},
		bigman = {
			'treeOrb',
			'natures_essence_1'
		},
		ghost_catcher = {
			'ghost',
			'ghost_orb'
		},
		metal_detector = {
			'hidden-metal',
			'iron'
		},
		sheep_herder = {
			'SheepModel',
			'purple_hay_bale'
		},
		sorcerer = {
			'alchemy_crystal',
			'wild_flower'
		},
		star_collector = {
			'stars',
			'crit_star'
		},
		black_market_trader = {
			'shadow_coin',
			'shadow_coin'
		},
		miner = {
			'petrified-player',
			'large_rock'
		},
		trapper = {
			'snap_trap',
			'snap_trap'
		},
		mage = {
			'ElementTome',
			'mage_spellbook'
		}
	}, {
		necromancer = {
			'Gravestone',
			true
		},
		battery = {
			'Open',
			true
		}
	}, {
		farmer_cletus = {
			{
				'carrot',
				'carrot_seeds'
			},
			{
				'melon',
				'melon_seeds'
			},
			{
				'pumpkin',
				'pumpkin_seeds'
			}
		}
	}
	local function getStarImage(av)
		local aw = av and av.Parent
		if aw and aw:IsA'Model' then
			local ax = aw.Name
			if ax == 'CritStar' or ax:lower():find'crit' then
				return O.getIcon({
					itemType = 'crit_star'
				}, true)
			elseif ax == 'VitalityStar' or ax:lower():find'vitality' then
				return O.getIcon({
					itemType = 'vitality_star'
				}, true)
			end
		end
		return O.getIcon({
			itemType = 'crit_star'
		}, true)
	end
	local function Added(av, aw, ax)
		if am[av] then
			return
		end
		if ap.Enabled then
			v:CreateNotification('KitESP', "3885322581", 2)
		end
		local ay = Instance.new'BillboardGui'
		ay.Parent = an
		ay.Name = aw
		ay.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		ay.Size = UDim2.fromOffset(36, 36)
		ay.AlwaysOnTop = true
		ay.ClipsDescendants = false
		ay.Adornee = av
		local az = addBlur(ay)
		az.Visible = aq.Enabled
		local aA = Instance.new'ImageLabel'
		aA.Size = UDim2.fromOffset(36, 36)
		aA.Position = UDim2.fromScale(0.5, 0.5)
		aA.AnchorPoint = Vector2.new(0.5, 0.5)
		aA.BackgroundColor3 = Color3.fromHSV(al.Hue, al.Sat, al.Value)
		aA.BackgroundTransparency = 1 - (aq.Enabled and al.Opacity or 0)
		aA.BorderSizePixel = 0
		if ax then
			aA.Image = aw
		else
			aA.Image = O.getIcon({
				itemType = aw
			}, true)
		end
		aA.Parent = ay
		local aB = Instance.new'UICorner'
		aB.CornerRadius = UDim.new(0, 4)
		aB.Parent = aA
		am[av] = ay
	end
	local function AddedStar(av)
		if not av or not av.Parent then
			return
		end
		if am[av] then
			return
		end
		if ap.Enabled then
			v:CreateNotification('KitESP', "3885322581", 2)
		end
		local aw = Instance.new'BillboardGui'
		aw.Parent = an
		aw.Name = 'star'
		aw.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aw.Size = UDim2.fromOffset(36, 36)
		aw.AlwaysOnTop = true
		aw.ClipsDescendants = false
		aw.Adornee = av
		local ax = addBlur(aw)
		ax.Visible = aq.Enabled
		local ay = Instance.new'ImageLabel'
		ay.Size = UDim2.fromOffset(36, 36)
		ay.Position = UDim2.fromScale(0.5, 0.5)
		ay.AnchorPoint = Vector2.new(0.5, 0.5)
		ay.BackgroundColor3 = Color3.fromHSV(al.Hue, al.Sat, al.Value)
		ay.BackgroundTransparency = 1 - (aq.Enabled and al.Opacity or 0)
		ay.BorderSizePixel = 0
		ay.Image = getStarImage(av)
		ay.Parent = aw
		local az = Instance.new'UICorner'
		az.CornerRadius = UDim.new(0, 4)
		az.Parent = ay
		am[av] = aw
	end
	local av, aw = {}
	local function disconnectAll()
		for ax, ay in ipairs(av) do
			ay:Disconnect()
		end
		table.clear(av)
	end
	local function addKit(ax, ay)
		if ax == 'stars' then
			local az = l:GetInstanceAddedSignal(ax):Connect(function(az)
				if az:IsA'Model' and az.PrimaryPart then
					task.wait(0.1)
					AddedStar(az.PrimaryPart)
				end
			end)
			table.insert(av, az)
			local aA = l:GetInstanceRemovedSignal(ax):Connect(function(aA)
				if aA.PrimaryPart and am[aA.PrimaryPart] then
					am[aA.PrimaryPart]:Destroy()
					am[aA.PrimaryPart] = nil
				end
			end)
			table.insert(av, aA)
			for aB, aC in l:GetTagged(ax) do
				if aC:IsA'Model' and aC.PrimaryPart then
					AddedStar(aC.PrimaryPart)
				end
			end
			return
		end
		local az = l:GetInstanceAddedSignal(ax):Connect(function(az)
			if ax == 'bee' and (az.Name:find'TamedBee' or az:FindFirstChild'TamedBee') then
				return
			end
			Added(az.PrimaryPart, ay, false)
		end)
		table.insert(av, az)
		local aA = l:GetInstanceRemovedSignal(ax):Connect(function(aA)
			if am[aA.PrimaryPart] then
				am[aA.PrimaryPart]:Destroy()
				am[aA.PrimaryPart] = nil
			end
		end)
		table.insert(av, aA)
		for aB, aC in l:GetTagged(ax) do
			if ax == 'bee' and (aC.Name:find'TamedBee' or aC:FindFirstChild'TamedBee') then
				continue
			end
			Added(aC.PrimaryPart, ay, false)
		end
	end
	local function addKitNon(ax, ay)
		if typeof(ay) == 'boolean' then
			if ax == 'Gravestone' then
				ay = 'rbxassetid://6307844310'
			elseif ax == 'Open' then
				ay = 'rbxassetid://10159166528'
			else
				ay = O.getIcon({
					itemType = ay
				}, true) or ''
			end
		else
			ay = O.getIcon({
				itemType = ay
			}, true)
		end
		local az = workspace.ChildAdded:Connect(function(az)
			if az:IsA'Model' and az.Name == ax then
				task.wait(0.1)
				if az.PrimaryPart then
					Added(az, ay, true)
				end
			end
		end)
		table.insert(av, az)
		local aA = workspace.ChildRemoved:Connect(function(aA)
			if aA:IsA'Model' and aA.Name == ax then
				if am[aA] then
					am[aA]:Destroy()
					am[aA] = nil
				end
			end
		end)
		table.insert(av, aA)
	end
	local function addKitDescendant(ax, ay)
		local az = O.getIcon({
			itemType = ay
		}, true)
		local function shouldSkip(aA)
			local aB = aA.Parent
			while aB and aB ~= workspace do
				if aB.Name == ax then
					return true
				end
				aB = aB.Parent
			end
			return false
		end
		for aA, aB in workspace:GetDescendants() do
			if aB:IsA'BasePart' and aB.Name == ax and not shouldSkip(aB) then
				if not am[aB] then
					Added(aB, az, true)
				end
			end
		end
		local aA = workspace.DescendantAdded:Connect(function(aA)
			if aA:IsA'BasePart' and aA.Name == ax and not shouldSkip(aA) then
				task.wait(0.1)
				if not am[aA] then
					Added(aA, az, true)
				end
			end
		end)
		table.insert(av, aA)
		local aB = workspace.DescendantRemoving:Connect(function(aB)
			if aB:IsA'BasePart' and aB.Name == ax and am[aB] then
				am[aB]:Destroy()
				am[aB] = nil
			end
		end)
		table.insert(av, aB)
	end
	local function setupKit(ax)
		local ay, az, aA = ar[ax], at[ax], au[ax]
		if ay then
			addKit(ay[1], ay[2])
		end
		if az then
			addKitNon(az[1], az[2])
		end
		if aA then
			for aB, aC in ipairs(aA) do
				addKitDescendant(aC[1], aC[2])
			end
		end
	end
	ao = v.Categories.Kits:CreateModule{
		Name = 'KitESP',
		Function = function(ax)
			if ax then
				task.spawn(function()
					while ao.Enabled do
						if not aw then
							repeat
								task.wait()
							until L.equippedKit ~= '' or not ao.Enabled
							if not ao.Enabled then
								break
							end
						end
						local ay = L.equippedKit
						if ay ~= aw then
							disconnectAll()
							an:ClearAllChildren()
							table.clear(am)
							if ay ~= '' then
								setupKit(ay)
							end
							aw = ay
						end
						task.wait(1)
					end
					disconnectAll()
					an:ClearAllChildren()
					table.clear(am)
					aw = nil
				end)
			else
				disconnectAll()
				an:ClearAllChildren()
				table.clear(am)
				aw = nil
			end
		end,
		Tooltip = 'ESP for certain kit related objects'
	}
	ap = ao:CreateToggle{
		Name = 'Notify',
		Default = false
	}
	aq = ao:CreateToggle{
		Name = 'Background',
		Function = function(ax)
			if al.Object then
				al.Object.Visible = ax
			end
			for ay, az in am do
				az.ImageLabel.BackgroundTransparency = 1 - (ax and al.Opacity or 0)
				az.Blur.Visible = ax
			end
		end,
		Default = true
	}
	al = ao:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(ax, ay, az, aA)
			for aB, aC in am do
				aC.ImageLabel.BackgroundColor3 = Color3.fromHSV(ax, ay, az)
				aC.ImageLabel.BackgroundTransparency = 1 - aA
			end
		end,
		Darker = true
	}
	task.defer(function()
		if al and al.Object then
			al.Object.Visible = aq.Enabled
		end
	end)
end)
a(function()
	local al, am, an, ao, ap, aq = {}, (Instance.new'Folder')
	am.Parent = v.gui
	local ar, at = l, {
		iron = {
			keywords = {
				'iron'
			},
			color = Color3.fromRGB(200, 200, 200),
			icon = 'iron',
			displayName = 'IRON'
		},
		diamond = {
			keywords = {
				'diamond'
			},
			color = Color3.fromRGB(85, 200, 255),
			icon = 'diamond',
			displayName = 'DIAMOND'
		},
		emerald = {
			keywords = {
				'emerald'
			},
			color = Color3.fromRGB(0, 255, 100),
			icon = 'emerald',
			displayName = 'EMERALD'
		}
	}
	local function getLootType(au)
		local av = au:lower()
		for aw, ax in pairs(at) do
			for ay, az in ipairs(ax.keywords) do
				if av:find(az, 1, true) then
					return aw, ax
				end
			end
		end
		return nil
	end
	local function isLootEnabled(au)
		if au == 'iron' then
			return ao.Enabled
		elseif au == 'diamond' then
			return ap.Enabled
		elseif au == 'emerald' then
			return aq.Enabled
		end
		return false
	end
	local function getProperIcon(au)
		local av = O.getIcon({
			itemType = au
		}, true)
		if not av or av == '' then
			return nil
		end
		return av
	end
	local function Added(au, av, aw)
		if not isLootEnabled(av) then
			return
		end
		if al[au] then
			return
		end
		local ax = Instance.new'BillboardGui'
		ax.Parent = am
		ax.Name = av
		ax.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		ax.Size = UDim2.fromOffset(40, 40)
		ax.AlwaysOnTop = true
		ax.ClipsDescendants = false
		ax.Adornee = au
		local ay = addBlur(ax)
		ay.Visible = true
		local az = getProperIcon(aw.icon)
		if az then
			local aA = Instance.new'ImageLabel'
			aA.Size = UDim2.fromOffset(40, 40)
			aA.Position = UDim2.fromScale(0.5, 0.5)
			aA.AnchorPoint = Vector2.new(0.5, 0.5)
			aA.BackgroundColor3 = Color3.new(0, 0, 0)
			aA.BackgroundTransparency = 0.3
			aA.BorderSizePixel = 0
			aA.Image = az
			aA.Parent = ax
			local aB = Instance.new'UICorner'
			aB.CornerRadius = UDim.new(0, 4)
			aB.Parent = aA
		else
			local aA = Instance.new'Frame'
			aA.Size = UDim2.fromScale(1, 1)
			aA.BackgroundColor3 = Color3.new(0, 0, 0)
			aA.BackgroundTransparency = 0.3
			aA.BorderSizePixel = 0
			aA.Parent = ax
			local aB = Instance.new'UICorner'
			aB.CornerRadius = UDim.new(0, 4)
			aB.Parent = aA
			local aC = Instance.new'TextLabel'
			aC.Size = UDim2.fromScale(1, 1)
			aC.Position = UDim2.fromScale(0.5, 0.5)
			aC.AnchorPoint = Vector2.new(0.5, 0.5)
			aC.BackgroundTransparency = 1
			aC.Text = aw.displayName
			aC.TextColor3 = aw.color
			aC.TextScaled = true
			aC.Font = Enum.Font.GothamBold
			aC.TextStrokeTransparency = 0.5
			aC.TextStrokeColor3 = Color3.new(0, 0, 0)
			aC.Parent = aA
		end
		al[au] = ax
	end
	local function Removed(au)
		if al[au] then
			al[au]:Destroy()
			al[au] = nil
		end
	end
	local function findExistingLoot()
		local au = ar:GetTagged'ItemDrop'
		for av, aw in ipairs(au) do
			local ax = aw:FindFirstChild'Handle'
			if ax then
				local ay, az = getLootType(aw.Name)
				if ay and isLootEnabled(ay) then
					if not al[ax] then
						Added(ax, ay, az)
					end
				end
			end
		end
	end
	local function refreshLootType(au)
		if not an.Enabled then
			return
		end
		local av = isLootEnabled(au)
		if not av then
			for aw, ax in pairs(al) do
				if ax.Name == au then
					ax:Destroy()
					al[aw] = nil
				end
			end
		else
			local aw = ar:GetTagged'ItemDrop'
			for ax, ay in ipairs(aw) do
				local az = ay:FindFirstChild'Handle'
				if az then
					local aA, aB = getLootType(ay.Name)
					if aA == au and not al[az] then
						Added(az, au, aB)
					end
				end
			end
		end
	end
	an = v.Categories.Render:CreateModule{
		Name = 'LootESP',
		Function = function(au)
			if au then
				findExistingLoot()
				an:Clean(ar:GetInstanceAddedSignal'ItemDrop':Connect(function(av)
					if not an.Enabled then
						return
					end
					task.defer(function()
						local aw = av:FindFirstChild'Handle'
						if not aw then
							return
						end
						local ax, ay = getLootType(av.Name)
						if ax and isLootEnabled(ax) then
							Added(aw, ax, ay)
						end
					end)
				end))
				an:Clean(ar:GetInstanceRemovedSignal'ItemDrop':Connect(function(av)
					local aw = av:FindFirstChild'Handle'
					if aw then
						Removed(aw)
					end
				end))
			else
				for av, aw in pairs(al) do
					aw:Destroy()
				end
				table.clear(al)
			end
		end,
		Tooltip = 'ESP for loot drops (iron, diamond, emerald)'
	}
	ao = an:CreateToggle{
		Name = 'Iron',
		Function = function(au)
			refreshLootType'iron'
		end,
		Default = true
	}
	ap = an:CreateToggle{
		Name = 'Diamond',
		Function = function(au)
			refreshLootType'diamond'
		end,
		Default = true
	}
	aq = an:CreateToggle{
		Name = 'Emerald',
		Function = function(au)
			refreshLootType'emerald'
		end,
		Default = true
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH = {}, {}, {}, (Instance.new'Folder')
	ao.Parent = v.gui
	local aI, aJ, aK, aL, aM, aN, aO, aP, aQ, aR, aS, aT, aU, aV, aW, aX, aY, aZ, a_, a0 = nil, nil, {}, {}, {}, {}, {}, {}, tick, math.floor, math.round, math.clamp, math.huge, string.format, Vector2.new, Vector3.new, Color3.fromHSV, Color3.new, UDim2.fromOffset, {none = 'rbxassetid://16493320215',random = 'rbxassetid://79773209697352',cowgirl = 'rbxassetid://9155462968',davey = 'rbxassetid://9155464612',warlock = 'rbxassetid://15186338366',ember = 'rbxassetid://9630017904',black_market_trader = 'rbxassetid://18922642482',yeti = 'rbxassetid://9166205917',scarab = 'rbxassetid://137137517627492',defender = 'rbxassetid://131690429591874',cactus = 'rbxassetid://104436517801089',oasis = 'rbxassetid://120283205213823',berserker = 'rbxassetid://90258047545241',sword_shield = 'rbxassetid://131690429591874',airbender = 'rbxassetid://74712750354593',gun_blade = 'rbxassetid://138231219644853',frost_hammer_kit = 'rbxassetid://11838567073',spider_queen = 'rbxassetid://95237509752482',archer = 'rbxassetid://9224796984',axolotl = 'rbxassetid://9155466713',baker = 'rbxassetid://9155463919',barbarian = 'rbxassetid://9166207628',builder = 'rbxassetid://9155463708',necromancer = 'rbxassetid://11343458097',cyber = 'rbxassetid://9507126891',sorcerer = 'rbxassetid://97940108361528',bigman = 'rbxassetid://9155467211',spirit_assassin = 'rbxassetid://10406002412',farmer_cletus = 'rbxassetid://9155466936',ice_queen = 'rbxassetid://9155466204',grim_reaper = 'rbxassetid://9155467410',spirit_gardener = 'rbxassetid://132108376114488',hannah = 'rbxassetid://10726577232',shielder = 'rbxassetid://9155464114',summoner = 'rbxassetid://18922378956',glacial_skater = 'rbxassetid://84628060516931',dragon_sword = 'rbxassetid://16215630104',lumen = 'rbxassetid://9630018371',flower_bee = 'rbxassetid://101569742252812',jellyfish = 'rbxassetid://18129974852',melody = 'rbxassetid://9155464915',mimic = 'rbxassetid://14783283296',miner = 'rbxassetid://9166208461',nazar = 'rbxassetid://18926951849',seahorse = 'rbxassetid://11902552560',elk_master = 'rbxassetid://15714972287',rebellion_leader = 'rbxassetid://18926409564',void_hunter = 'rbxassetid://122370766273698',taliyah = 'rbxassetid://13989437601',angel = 'rbxassetid://9166208240',harpoon = 'rbxassetid://18250634847',void_walker = 'rbxassetid://78915127961078',spirit_summoner = 'rbxassetid://95760990786863',triple_shot = 'rbxassetid://9166208149',void_knight = 'rbxassetid://73636326782144',regent = 'rbxassetid://9166208904',vulcan = 'rbxassetid://9155465543',owl = 'rbxassetid://12509401147',dasher = 'rbxassetid://9155467645',disruptor = 'rbxassetid://11596993583',wizard = 'rbxassetid://13353923546',aery = 'rbxassetid://9155463221',agni = 'rbxassetid://17024640133',alchemist = 'rbxassetid://9155462512',spearman = 'rbxassetid://9166207341',beekeeper = 'rbxassetid://9312831285',falconer = 'rbxassetid://17022941869',bounty_hunter = 'rbxassetid://9166208649',blood_assassin = 'rbxassetid://12520290159',battery = 'rbxassetid://10159166528',steam_engineer = 'rbxassetid://15380413567',vesta = 'rbxassetid://9568930198',beast = 'rbxassetid://9155465124',dino_tamer = 'rbxassetid://9872357009',drill = 'rbxassetid://12955100280',elektra = 'rbxassetid://13841413050',fisherman = 'rbxassetid://9166208359',queen_bee = 'rbxassetid://12671498918',card = 'rbxassetid://13841410580',frosty = 'rbxassetid://9166208762',gingerbread_man = 'rbxassetid://9155464364',ghost_catcher = 'rbxassetid://9224802656',tinker = 'rbxassetid://17025762404',ignis = 'rbxassetid://13835258938',oil_man = 'rbxassetid://9166206259',jade = 'rbxassetid://9166306816',dragon_slayer = 'rbxassetid://10982192175',paladin = 'rbxassetid://11202785737',pinata = 'rbxassetid://10011261147',merchant = 'rbxassetid://9872356790',metal_detector = 'rbxassetid://9378298061',slime_tamer = 'rbxassetid://15379766168',nyoka = 'rbxassetid://17022941410',midnight = 'rbxassetid://9155462763',pyro = 'rbxassetid://9155464770',raven = 'rbxassetid://9166206554',santa = 'rbxassetid://9166206101',sheep_herder = 'rbxassetid://9155465730',smoke = 'rbxassetid://9155462247',spirit_catcher = 'rbxassetid://9166207943',star_collector = 'rbxassetid://9872356516',styx = 'rbxassetid://17014536631',block_kicker = 'rbxassetid://15382536098',trapper = 'rbxassetid://9166206875',hatter = 'rbxassetid://12509388633',ninja = 'rbxassetid://15517037848',jailor = 'rbxassetid://11664116980',warrior = 'rbxassetid://9166207008',mage = 'rbxassetid://10982191792',void_dragon = 'rbxassetid://10982192753',cat = 'rbxassetid://15350740470',wind_walker = 'rbxassetid://9872355499',skeleton = 'rbxassetid://120123419412119',winter_lady = 'rbxassetid://83274578564074'}
	local function buildEnchantMap()
		if aJ then
			return aJ
		end
		aJ = {}
		task.spawn(function()
			safeCall(function()
				if v.ThreadFix then
					setthreadidentity(8)
				end
			end)
			local a1, a2 = pcall(function()
				return require(game:GetService'ReplicatedStorage'.TS.enchant['enchant-meta'])
			end)
			if not a1 or not a2 then
				return
			end
			for a3, a4 in pairs{
				a2.EnchantMeta,
				a2.ToolEnchantMeta,
				a2.ArmorEnchantMeta
			} do
				if type(a4) == 'table' then
					for a5, a6 in pairs(a4) do
						if type(a6) == 'table' and a6.statusEffect and a6.image then
							aJ[a6.statusEffect] = a6.image
						end
					end
				end
			end
		end)
		return aJ
	end
	local function getActiveEnchantImage(a1)
		if not a1 then
			return ''
		end
		local a2 = buildEnchantMap()
		for a3, a4 in pairs(a1:GetAttributes()) do
			if a3:sub(1, 13) == 'StatusEffect_' and type(a4) == 'number' and a4 < 0 then
				local a5 = a3:sub(14)
				if not a5:find'stacks' then
					local a6 = a2[a5]
					if a6 and a6 ~= '' then
						return a6
					end
				end
			end
		end
		return ''
	end
	local a1, a2, a3, a4, a5 = {
		Normal = function(a1)
			if not aq.Players.Enabled and a1.Player then
				return
			end
			if not aq.NPCs.Enabled and a1.NPC then
				return
			end
			if aF.Enabled and (not a1.Targetable) and (not a1.Friend) then
				return
			end
			al[a1] = a1.Player and H:tag(a1.Player, true) .. (au.Enabled and a1.Player.DisplayName or a1.Player.Name) or a1.Character.Name
			if av.Enabled then
				al[a1] = al[a1] .. ' ' .. aS(a1.Health)
			end
			if aw.Enabled then
				al[a1] = '[%s] ' .. al[a1]
			end
			local a2, a3 = 14 * aD.Value, aE.Value
			local a4, a5 = J(removeTags(al[a1]), a2, a3, aW(100000, 100000)), Instance.new'TextLabel'
			a5.Name = a1.Player and a1.Player.Name or a1.Character.Name
			a5.Size = a_(a4.X + 8, a4.Y + 7)
			a5.AnchorPoint = aW(0.5, 1)
			a5.BackgroundColor3 = aZ()
			a5.BackgroundTransparency = at.Value
			a5.BorderSizePixel = 0
			a5.Visible = false
			a5.Text = al[a1]
			a5.TextColor3 = B.getEntityColor(a1) or aY(ar.Hue, ar.Sat, ar.Value)
			a5.RichText = true
			a5.TextSize = a2
			a5.FontFace = a3
			a5.Parent = ao
			if ax.Enabled then
				for a6, a7 in {
					'Hand',
					'Helmet',
					'Chestplate',
					'Boots'
				} do
					local a8 = Instance.new'ImageLabel'
					a8.Name = a7
					a8.Size = a_(30, 30)
					a8.Position = a_(- 60 + (a6 * 30), - 30)
					a8.BackgroundTransparency = 1
					a8.Image = ''
					a8.Parent = a5
				end
				if a1.Player and L.inventories[a1.Player] then
					local a6 = L.inventories[a1.Player]
					if a5.Hand then
						a5.Hand.Image = O.getIcon(a6.hand or {
							itemType = ''
						}, true)
					end
					if a5.Helmet then
						a5.Helmet.Image = O.getIcon(a6.armor[4] or {
							itemType = ''
						}, true)
					end
					if a5.Chestplate then
						a5.Chestplate.Image = O.getIcon(a6.armor[5] or {
							itemType = ''
						}, true)
					end
					if a5.Boots then
						a5.Boots.Image = O.getIcon(a6.armor[6] or {
							itemType = ''
						}, true)
					end
				end
			end
			if az.Enabled and a1.Player then
				local a6 = Instance.new'ImageLabel'
				a6.Name = 'KitIcon'
				a6.Size = a_(30, 30)
				a6.AnchorPoint = aW(0.5, 0)
				a6.BackgroundTransparency = 1
				a6.Image = ''
				if ax.Enabled then
					a6.Position = a_(110, - 30)
				else
					a6.Position = UDim2.new(0.5, 0, 0, - 35)
				end
				a6.Parent = a5
				local a7 = a1.Player:GetAttribute'PlayingAsKits'
				if a7 then
					local a8 = a0[a7:lower()]
					a6.Image = a8 or a0.none
					aL[a1] = a8 or a0.none
				else
					a6.Image = a0.none
					aL[a1] = a0.none
				end
			end
			if aA.Enabled and a1.Player then
				local a6 = Instance.new'ImageLabel'
				a6.Name = 'RankIcon'
				a6.Size = a_(30, 30)
				a6.Position = a_(a4.X + 10, - 4)
				a6.BackgroundTransparency = 1
				a6.Image = ''
				a6.Parent = a5
				task.spawn(function()
					safeCall(function()
						if v.ThreadFix then
							setthreadidentity(8)
						end
					end)
					local a7 = e:GetPlayerFromCharacter(a1.Character)
					if not a7 then
						return
					end
					local a8, a9, ba = pcall(function()
						return O.Client:Get(P.Ranks):CallServerAsync{
							a7.UserId
						}:await()
					end)
					safeCall(function()
						if v.ThreadFix then
							setthreadidentity(8)
						end
					end)
					if a8 and a9 and type(ba) == 'table' then
						local bb = ba[1] and ba[1].rankDivision
						if bb and O.RankMeta and O.RankMeta[bb] then
							a6.Image = O.RankMeta[bb].image
						end
					end
				end)
			end
			if aB and aB.Enabled and a1.Character then
				local a6 = Instance.new'ImageLabel'
				a6.Name = 'GloopIcon'
				a6.Size = a_(24, 24)
				a6.BackgroundTransparency = 1
				a6.Image = O.getIcon({
					itemType = 'glue_projectile'
				}, true)
				a6.Visible = false
				if aA.Enabled then
					a6.Position = a_(a4.X + 42, - 2)
				else
					a6.Position = a_(a4.X + 10, - 2)
				end
				a6.Parent = a5
				local a7
				aP[a1] = a1.Character.AttributeChanged:Connect(function(a8)
					if a8 ~= 'GlueSlow' then
						return
					end
					local a9 = a1.Character:GetAttribute'GlueSlow'
					if a9 ~= nil and a9 ~= 0 then
						a6.Visible = true
						if a7 then
							task.cancel(a7)
						end
						a7 = task.delay(10, function()
							a6.Visible = false
							a7 = nil
						end)
					end
				end)
			end
			if aC.Enabled and a1.Player and a1.Character then
				local a6 = Instance.new'ImageLabel'
				a6.Name = 'EnchantIcon'
				a6.Size = a_(30, 30)
				a6.Position = a_(- 30, - 4)
				a6.BackgroundTransparency = 1
				a6.Image = getActiveEnchantImage(a1.Character)
				a6.Parent = a5
				aN[a1] = a6.Image
				aO[a1] = a1.Character.AttributeChanged:Connect(function(a7)
					if a7:sub(1, 13) ~= 'StatusEffect_' then
						return
					end
					local a8 = a1.Character:GetAttribute(a7)
					if type(a8) ~= 'number' then
						return
					end
					local a9 = getActiveEnchantImage(a1.Character)
					if aN[a1] ~= a9 then
						a6.Image = a9
						aN[a1] = a9
					end
				end)
			end
			an[a1] = a5
			aK[a1] = 0
		end,
		Drawing = function(a1)
			if not aq.Players.Enabled and a1.Player then
				return
			end
			if not aq.NPCs.Enabled and a1.NPC then
				return
			end
			if aF.Enabled and (not a1.Targetable) and (not a1.Friend) then
				return
			end
			local a2 = {}
			a2.BG = Drawing.new'Square'
			a2.BG.Filled = true
			a2.BG.Transparency = 1 - at.Value
			a2.BG.Color = aZ()
			a2.BG.ZIndex = 1
			a2.Text = Drawing.new'Text'
			a2.Text.Size = 15 * aD.Value
			a2.Text.Font = 0
			a2.Text.ZIndex = 2
			al[a1] = a1.Player and H:tag(a1.Player, true) .. (au.Enabled and a1.Player.DisplayName or a1.Player.Name) or a1.Character.Name
			if av.Enabled then
				al[a1] = al[a1] .. ' ' .. aS(a1.Health)
			end
			if aw.Enabled then
				al[a1] = '[%s] ' .. al[a1]
			end
			if az.Enabled and a1.Player then
				local a3 = a1.Player:GetAttribute'PlayingAsKits'
				if a3 then
					local a4 = a3:gsub('_', ' '):gsub('^%l', string.upper)
					al[a1] = al[a1] .. ' (' .. a4 .. ')'
				end
			end
			a2.Text.Text = al[a1]
			a2.Text.Color = B.getEntityColor(a1) or aY(ar.Hue, ar.Sat, ar.Value)
			a2.BG.Size = aW(a2.Text.TextBounds.X + 8, a2.Text.TextBounds.Y + 7)
			an[a1] = a2
			aK[a1] = 0
		end
	}, {
		Normal = function(a1)
			local a2 = an[a1]
			if a2 then
				an[a1] = nil
				al[a1] = nil
				am[a1] = nil
				aK[a1] = nil
				aL[a1] = nil
				aM[a1] = nil
				aN[a1] = nil
				if aO[a1] then
					aO[a1]:Disconnect()
					aO[a1] = nil
				end
				if aP[a1] then
					aP[a1]:Disconnect()
					aP[a1] = nil
				end
				a2:Destroy()
			end
		end,
		Drawing = function(a1)
			local a2 = an[a1]
			if a2 then
				an[a1] = nil
				al[a1] = nil
				am[a1] = nil
				aK[a1] = nil
				aL[a1] = nil
				for a3, a4 in a2 do
					pcall(function()
						a4.Visible = false
						a4:Remove()
					end)
				end
			end
		end
	}, {
		Normal = function(a1)
			local a2 = an[a1]
			if not a2 then
				return
			end
			local a3 = aQ()
			if aK[a1] and (a3 - aK[a1]) < 0.2 then
				return
			end
			aK[a1] = a3
			am[a1] = nil
			al[a1] = a1.Player and H:tag(a1.Player, true) .. (au.Enabled and a1.Player.DisplayName or a1.Player.Name) or a1.Character.Name
			if av.Enabled then
				al[a1] = al[a1] .. ' ' .. aS(a1.Health)
			end
			if aw.Enabled then
				al[a1] = '[%s] ' .. al[a1]
			end
			if ax.Enabled and a1.Player and L.inventories[a1.Player] then
				local a4 = L.inventories[a1.Player]
				local a5 = {
					a4.hand and a4.hand.itemType or '',
					a4.armor[4] and a4.armor[4].itemType or '',
					a4.armor[5] and a4.armor[5].itemType or '',
					a4.armor[6] and a4.armor[6].itemType or ''
				}
				local a6 = table.concat(a5, '|')
				if aM[a1] ~= a6 then
					aM[a1] = a6
					if a2.Hand then
						a2.Hand.Image = O.getIcon(a4.hand or {
							itemType = ''
						}, true)
					end
					if a2.Helmet then
						a2.Helmet.Image = O.getIcon(a4.armor[4] or {
							itemType = ''
						}, true)
					end
					if a2.Chestplate then
						a2.Chestplate.Image = O.getIcon(a4.armor[5] or {
							itemType = ''
						}, true)
					end
					if a2.Boots then
						a2.Boots.Image = O.getIcon(a4.armor[6] or {
							itemType = ''
						}, true)
					end
				end
			end
			local a4 = J(removeTags(al[a1]), a2.TextSize, a2.FontFace, aW(100000, 100000))
			a2.Size = a_(a4.X + 8, a4.Y + 7)
			a2.Text = al[a1]
		end,
		Drawing = function(a1)
			local a2 = an[a1]
			if a2 then
				safeCall(function()
					if v.ThreadFix then
						setthreadidentity(8)
					end
				end)
				am[a1] = nil
				al[a1] = a1.Player and H:tag(a1.Player, true) .. (au.Enabled and a1.Player.DisplayName or a1.Player.Name) or a1.Character.Name
				if av.Enabled then
					al[a1] = al[a1] .. ' ' .. aS(a1.Health)
				end
				if aw.Enabled then
					al[a1] = '[%s] ' .. al[a1]
					a2.Text.Text = B.isAlive and aV(al[a1], aR((B.character.RootPart.Position - a1.RootPart.Position).Magnitude)) or al[a1]
				else
					a2.Text.Text = al[a1]
				end
				if az.Enabled and a1.Player then
					local a3 = a1.Player:GetAttribute'PlayingAsKits'
					if a3 then
						local a4 = a3:gsub('_', ' '):gsub('^%l', string.upper)
						a2.Text.Text = a2.Text.Text .. ' (' .. a4 .. ')'
					end
				end
				a2.BG.Size = aW(a2.Text.TextBounds.X + 8, a2.Text.TextBounds.Y + 7)
				a2.Text.Color = B.getEntityColor(a1) or aY(ar.Hue, ar.Sat, ar.Value)
			end
		end
	}, {
		Normal = function(a1, a2, a3)
			local a4 = aY(a1, a2, a3)
			for a5, a6 in an do
				a6.TextColor3 = B.getEntityColor(a5) or a4
			end
		end,
		Drawing = function(a1, a2, a3)
			local a4 = aY(a1, a2, a3)
			for a5, a6 in an do
				a6.Text.Color = B.getEntityColor(a5) or a4
			end
		end
	}, 0
	Loop = {
		Normal = function()
			a5 = a5 + 1
			local a6 = a5 % 2 == 0
			for a7, a8 in an do
				if aG.Enabled then
					local a9 = B.isAlive and (B.character.RootPart.Position - a7.RootPart.Position).Magnitude or aU
					if a9 < aH.ValueMin or a9 > aH.ValueMax then
						a8.Visible = false
						continue
					end
				end
				local a9, ba = s:WorldToViewportPoint(a7.RootPart.Position + aX(0, a7.HipHeight + 1, 0))
				a8.Visible = ba
				if not ba then
					continue
				end
				if a6 then
					a8.Position = a_(a9.X, a9.Y)
				end
				if aw.Enabled then
					local bb = B.isAlive and aR((B.character.RootPart.Position - a7.RootPart.Position).Magnitude) or 0
					if am[a7] ~= bb then
						a8.Text = aV(al[a7], bb)
						if a5 % 6 == 0 then
							local bc = J(removeTags(a8.Text), a8.TextSize, a8.FontFace, aW(100000, 100000))
							a8.Size = a_(bc.X + 8, bc.Y + 7)
						end
						am[a7] = bb
					end
				end
				if ax.Enabled and a5 % 30 == 0 then
					if a7.Player and L.inventories[a7.Player] then
						local bb = L.inventories[a7.Player]
						local bc = {
							bb.hand and bb.hand.itemType or '',
							bb.armor[4] and bb.armor[4].itemType or '',
							bb.armor[5] and bb.armor[5].itemType or '',
							bb.armor[6] and bb.armor[6].itemType or ''
						}
						local bd = table.concat(bc, '|')
						if aM[a7] ~= bd then
							aM[a7] = bd
							if a8.Hand then
								a8.Hand.Image = O.getIcon(bb.hand or {
									itemType = ''
								}, true)
							end
							if a8.Helmet then
								a8.Helmet.Image = O.getIcon(bb.armor[4] or {
									itemType = ''
								}, true)
							end
							if a8.Chestplate then
								a8.Chestplate.Image = O.getIcon(bb.armor[5] or {
									itemType = ''
								}, true)
							end
							if a8.Boots then
								a8.Boots.Image = O.getIcon(bb.armor[6] or {
									itemType = ''
								}, true)
							end
						end
					end
				end
				if az.Enabled and a5 % 30 == 0 then
					local bb = a8:FindFirstChild'KitIcon'
					if bb and a7.Player then
						local bc = a7.Player:GetAttribute'PlayingAsKits'
						local bd = bc and (a0[bc:lower()] or a0.none) or a0.none
						if aL[a7] ~= bd then
							bb.Image = bd
							aL[a7] = bd
						end
					end
				end
			end
		end,
		Drawing = function()
			a5 = a5 + 1
			local a6 = a5 % 2 ~= 0
			for a7, a8 in an do
				if aG.Enabled then
					local a9 = B.isAlive and (B.character.RootPart.Position - a7.RootPart.Position).Magnitude or aU
					if a9 < aH.ValueMin or a9 > aH.ValueMax then
						a8.Text.Visible = false
						a8.BG.Visible = false
						continue
					end
				end
				local a9, ba = s:WorldToViewportPoint(a7.RootPart.Position + aX(0, a7.HipHeight + 1, 0))
				a8.Text.Visible = ba
				a8.BG.Visible = ba
				if not ba then
					continue
				end
				if a6 then
					continue
				end
				if aw.Enabled then
					local bb = B.isAlive and aR((B.character.RootPart.Position - a7.RootPart.Position).Magnitude) or 0
					if am[a7] ~= bb then
						a8.Text.Text = aV(al[a7], bb)
						a8.BG.Size = aW(a8.Text.TextBounds.X + 8, a8.Text.TextBounds.Y + 7)
						am[a7] = bb
					end
				end
				a8.BG.Position = aW(a9.X - (a8.BG.Size.X / 2), a9.Y - a8.BG.Size.Y)
				a8.Text.Position = a8.BG.Position + aW(4, 3)
			end
		end
	}
	ap = v.Categories.Render:CreateModule{
		Name = 'NameTags',
		Function = function(a6)
			if a6 then
				aI = ay.Enabled and 'Drawing' or 'Normal'
				a5 = 0
				if a2[aI] then
					ap:Clean(B.Events.EntityRemoved:Connect(a2[aI]))
				end
				if a1[aI] then
					for a7, a8 in B.List do
						if an[a8] then
							a2[aI](a8)
						end
						a1[aI](a8)
					end
					ap:Clean(B.Events.EntityAdded:Connect(function(a7)
						if an[a7] then
							a2[aI](a7)
						end
						a1[aI](a7)
					end))
				end
				if a3[aI] then
					ap:Clean(B.Events.EntityUpdated:Connect(a3[aI]))
					for a7, a8 in B.List do
						a3[aI](a8)
					end
				end
				if a4[aI] then
					ap:Clean(v.Categories.Friends.ColorUpdate.Event:Connect(function()
						a4[aI](ar.Hue, ar.Sat, ar.Value)
					end))
				end
				if Loop[aI] then
					ap:Clean(g.RenderStepped:Connect(Loop[aI]))
				end
			else
				if a2[aI] then
					for a7 in an do
						a2[aI](a7)
					end
				end
				aK = {}
				aL = {}
				aM = {}
				aN = {}
				aO = {}
			end
		end,
		Tooltip = 'Renders nametags on entities through walls.'
	}
	aq = ap:CreateTargets{
		Players = true,
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	aE = ap:CreateFont{
		Name = 'Font',
		Blacklist = 'Arial',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	ar = ap:CreateColorSlider{
		Name = 'Player Color',
		Function = function(a6, a7, a8)
			if ap.Enabled and a4[aI] then
				a4[aI](a6, a7, a8)
			end
		end
	}
	aD = ap:CreateSlider{
		Name = 'Scale',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end,
		Default = 1,
		Min = 0.1,
		Max = 1.5,
		Decimal = 10
	}
	at = ap:CreateSlider{
		Name = 'Transparency',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end,
		Default = 0.5,
		Min = 0,
		Max = 1,
		Decimal = 10
	}
	av = ap:CreateToggle{
		Name = 'Health',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	aw = ap:CreateToggle{
		Name = 'Distance',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	ax = ap:CreateToggle{
		Name = 'Equipment',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	az = ap:CreateToggle{
		Name = 'Show Kits',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end,
		Tooltip = 'Shows player kits with icons in nametags'
	}
	aA = ap:CreateToggle{
		Name = 'Rank',
		Tooltip = "Displays player's rank icon",
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	aB = ap:CreateToggle{
		Name = 'Gloop',
		Default = true,
		Tooltip = 'Shows a gloop icon on nametags when a player is glooped',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	aC = ap:CreateToggle{
		Name = 'Enchant',
		Tooltip = 'Displays active weapon enchant icon',
		Default = true,
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	au = ap:CreateToggle{
		Name = 'Use Displayname',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end,
		Default = true
	}
	aF = ap:CreateToggle{
		Name = 'Priority Only',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end,
		Default = true
	}
	ay = ap:CreateToggle{
		Name = 'Drawing',
		Function = function()
			if ap.Enabled then
				ap:Toggle()
				ap:Toggle()
			end
		end
	}
	aG = ap:CreateToggle{
		Name = 'Distance Check',
		Function = function(a6)
			aH.Object.Visible = a6
		end
	}
	aH = ap:CreateTwoSlider{
		Name = 'Player Distance',
		Min = 0,
		Max = 256,
		DefaultMin = 0,
		DefaultMax = 64,
		Darker = true,
		Visible = false
	}
	task.defer(function()
		if aH and aH.Object then
			aH.Object.Visible = false
		end
	end)
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI = false, {}, {}, 0, {}, {}, {}
	local function getKitName(aJ)
		if O.BedwarsKitMeta[aJ] then
			return O.BedwarsKitMeta[aJ].name
		end
		return aJ:gsub('_', ' '):gsub('^%l', string.upper)
	end
	local function getOwnBed()
		local aJ = tick()
		if aG and aG.Parent and (aJ - ao) < 2 then
			return aG, aH
		end
		if not B.isAlive then
			aG = nil
			aH = nil
			return nil
		end
		local aK = t:GetAttribute'Team'
		if not aK then
			aG = nil
			aH = nil
			return nil
		end
		local aL = l:GetTagged'bed'
		for aM, aN in ipairs(aL) do
			if aN:GetAttribute('Team' .. aK .. 'NoBreak') then
				aG = aN
				aH = aN.Position
				ao = aJ
				return aN, aH
			end
		end
		aG = nil
		aH = nil
		return nil
	end
	local function getPlayerName(aJ)
		if not aJ.Player then
			return aJ.Character.Name
		end
		return ax.Enabled and aJ.Player.DisplayName or aJ.Player.Name
	end
	local function getPlayerKit(aJ)
		if not aJ.Player then
			return nil
		end
		local aK = aJ.Player:GetAttribute'PlayingAsKits'
		if aK and aK ~= 'none' then
			return getKitName(aK)
		end
		return nil
	end
	local function isHoldingPearl(aJ, aK)
		if not aJ.Player then
			return false
		end
		local aL = aq[aJ] or 0
		if (aK - aL) < 0.5 and ap[aJ] ~= nil then
			return ap[aJ]
		end
		local aM = L.inventories[aJ.Player]
		if not aM then
			ap[aJ] = false
			aq[aJ] = aK
			return false
		end
		local aN = aM.hand
		if aN and aN.itemType then
			local aO = aN.itemType:lower()
			local aP = aO == 'telepearl' or aO == 'teleport_pearl' or aO:find('pearl', 1, true)
			ap[aJ] = aP
			aq[aJ] = aK
			return aP
		end
		ap[aJ] = false
		aq[aJ] = aK
		return false
	end
	local function createHighlight(aJ)
		if not aB.Enabled then
			return
		end
		if ar[aJ] then
			return
		end
		local aK = aJ.Character
		if not aK then
			return
		end
		local aL = Instance.new'Highlight'
		aL.Name = 'BedAlarmHighlight'
		aL.Adornee = aK
		local aM, aN, aO = aC.Hue, aC.Sat, aC.Value
		local aP = Color3.fromHSV(aM, aN, aO)
		aL.FillColor = aP
		aL.OutlineColor = aP
		aL.FillTransparency = 0.5
		aL.OutlineTransparency = 0
		aL.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		aL.Parent = aK
		ar[aJ] = aL
	end
	local function removeHighlight(aJ)
		if ar[aJ] then
			ar[aJ]:Destroy()
			ar[aJ] = nil
		end
	end
	local function playAlarm()
		if not aD.Enabled then
			return
		end
		if aI and aI.Playing then
			return
		end
		if not aI then
			aI = Instance.new'Sound'
			aI.Name = 'BedAlarmSound'
			aI.SoundId = 'rbxassetid://' .. aE.Value
			aI.Volume = aF.Value / 100
			aI.Looped = true
			aI.Parent = workspace
		end
		aI.SoundId = 'rbxassetid://' .. aE.Value
		aI.Volume = aF.Value / 100
		aI:Play()
	end
	local function stopAlarm()
		if aI and aI.Playing then
			aI:Stop()
		end
	end
	local function createNotification(aJ, aK)
		local aL = getPlayerName(aJ)
		local aM = aL .. ' is near your bed!'
		if aK then
			aM = aL .. ' is near your bed WITH A PEARL!'
		end
		if ay.Enabled then
			local aN = getPlayerKit(aJ)
			if aN then
				if aK then
					aM = aL .. ' is near your bed WITH A PEARL! (Kit: ' .. aN .. ')'
				else
					aM = aL .. ' is near your bed! (Kit: ' .. aN .. ')'
				end
			end
		end
		notif('Bed Alarm', aM, 3)
	end
	local aJ = 0
	local function checkPlayers()
		if not at.Enabled then
			return
		end
		if not B.isAlive then
			return
		end
		local aK = tick()
		if (aK - aJ) < 0.1 then
			return
		end
		aJ = aK
		local aL, aM = getOwnBed()
		if not aL or not aM then
			return
		end
		local aN, aO, aP = {}, au.Value, az.Enabled
		local aQ, aR = aP and aA.Value or aO, aO * aO
		local aS, aT = aQ * aQ, false
		for aU, aV in ipairs(B.List) do
			if not aV.Targetable then
				continue
			end
			local aW = aV.RootPart.Position - aM
			local aX, aY, aZ = aW.X * aW.X + aW.Y * aW.Y + aW.Z * aW.Z, false, false
			if aP and aX <= aS then
				aY = isHoldingPearl(aV, aK)
				if aY then
					aZ = true
				end
			end
			if not aZ and aX <= aR then
				aZ = true
			end
			if aZ then
				aN[aV] = true
				aT = true
				createHighlight(aV)
				local a_ = false
				if not am[aV] then
					a_ = true
				elseif av.Enabled then
					local a0 = an[aV] or 0
					if aK - a0 >= aw.Value then
						a_ = true
					end
				end
				if a_ then
					createNotification(aV, aY)
					an[aV] = aK
				end
			else
				removeHighlight(aV)
			end
		end
		if aT then
			playAlarm()
		else
			stopAlarm()
		end
		for aU, aV in pairs(ar) do
			if not aN[aU] then
				removeHighlight(aU)
			end
		end
		am = aN
	end
	at = v.Categories.Utility:CreateModule{
		Name = 'BedAlarm',
		Function = function(aK)
			if aK then
				local aL = getOwnBed()
				if not aL then
					notif('BedAlarm', 'Cannot locate your bed!', 3)
					at:Toggle()
					return
				end
				al = true
				am = {}
				an = {}
				ap = {}
				aq = {}
				ar = {}
				aJ = 0
				at:Clean(g.Heartbeat:Connect(checkPlayers))
			else
				al = false
				stopAlarm()
				if aI then
					aI:Destroy()
					aI = nil
				end
				for aL, aM in pairs(ar) do
					if aM then
						aM:Destroy()
					end
				end
				table.clear(am)
				table.clear(an)
				table.clear(ap)
				table.clear(aq)
				table.clear(ar)
				aG = nil
				aH = nil
			end
		end,
		Tooltip = 'Alerts you when enemies are near your bed'
	}
	au = at:CreateSlider{
		Name = 'Detection Range',
		Function = function()
		end,
		Default = 30,
		Min = 10,
		Max = 100,
		Tooltip = 'Distance in studs to detect players near bed'
	}
	az = at:CreateToggle{
		Name = 'Telepearl Check',
		Function = function(aK)
			if aA and aA.Object then
				aA.Object.Visible = aK
			end
		end,
		Default = false,
		Tooltip = 'Extended detection range for players holding pearls'
	}
	aA = at:CreateSlider{
		Name = 'Pearl Range',
		Function = function()
		end,
		Default = 250,
		Min = 100,
		Max = 500,
		Visible = false,
		Tooltip = 'Detection range for players with pearls'
	}
	av = at:CreateToggle{
		Name = 'Repeat Notifications',
		Function = function(aK)
			if aw and aw.Object then
				aw.Object.Visible = aK
			end
		end,
		Default = false,
		Tooltip = 'Continue notifying while players remain near bed'
	}
	aw = at:CreateSlider{
		Name = 'Notification Delay',
		Function = function()
		end,
		Default = 5,
		Min = 1,
		Max = 10,
		Visible = false,
		Tooltip = 'Seconds between repeat notifications'
	}
	ax = at:CreateToggle{
		Name = 'Show Display Name',
		Function = function()
		end,
		Default = true,
		Tooltip = 'Show player display names instead of usernames'
	}
	ay = at:CreateToggle{
		Name = 'Notify Kits',
		Function = function()
		end,
		Default = true,
		Tooltip = 'Include player kit in notification'
	}
	aB = at:CreateToggle{
		Name = 'Highlight Enemies',
		Function = function(aK)
			if aC and aC.Object then
				aC.Object.Visible = aK
			end
			if not aK then
				for aL, aM in pairs(ar) do
					if aM then
						aM:Destroy()
					end
				end
				table.clear(ar)
			end
		end,
		Default = false,
		Tooltip = 'Highlight enemies near your bed through walls'
	}
	aC = at:CreateColorSlider{
		Name = 'Highlight Color',
		Function = function(aK, aL, aM)
			local aN = Color3.fromHSV(aK, aL, aM)
			for aO, aP in pairs(ar) do
				if aP then
					aP.FillColor = aN
					aP.OutlineColor = aN
				end
			end
		end,
		Default = 1,
		Visible = false,
		Tooltip = 'Color of the enemy highlight'
	}
	aD = at:CreateToggle{
		Name = 'Play Alarm Sound',
		Function = function(aK)
			if aE and aE.Object then
				aE.Object.Visible = aK
			end
			if aF and aF.Object then
				aF.Object.Visible = aK
			end
			if not aK then
				stopAlarm()
			end
		end,
		Default = false,
		Tooltip = 'Play alarm sound when enemies are near bed'
	}
	aE = at:CreateTextBox{
		Name = 'Alarm Sound ID',
		Function = function(aK)
			if aI then
				aI.SoundId = 'rbxassetid://' .. aK
			end
		end,
		Default = '6518811702',
		Visible = false,
		Tooltip = 'Roblox sound asset ID'
	}
	aF = at:CreateSlider{
		Name = 'Alarm Volume',
		Function = function(aK)
			if aI then
				aI.Volume = aK / 100
			end
		end,
		Default = 50,
		Min = 1,
		Max = 100,
		Visible = false,
		Tooltip = 'Volume of the alarm sound'
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar = {}, {}, {}, (Instance.new'Folder')
	ao.Parent = v.gui
	local function getEnabledItemsSet()
		local at = {}
		for au, av in ipairs(aq.ListEnabled) do
			at[av] = true
		end
		return at
	end
	local function nearStorageItem(at, au)
		for av in pairs(au) do
			if at:find(av, 1, true) then
				return av
			end
		end
		return nil
	end
	local function refreshAdornee(at)
		local au = at.Adornee:FindFirstChild'ChestFolderValue'
		au = au and au.Value or nil
		if not au then
			at.Enabled = false
			return
		end
		local av, aw, ax = au:GetChildren(), getEnabledItemsSet(), {}
		for ay, az in ipairs(av) do
			if aw[az.Name] or nearStorageItem(az.Name, aw) then
				ax[az.Name] = true
			end
		end
		local ay = table.concat(table.create(# av, function(ay)
			return av[ay].Name
		end), '|')
		if an[at] == ay then
			return
		end
		an[at] = ay
		for az, aA in ipairs(at.Frame:GetChildren()) do
			if aA:IsA'ImageLabel' and aA.Name ~= 'Blur' then
				if not ax[aA.Name] then
					aA:Destroy()
				else
					ax[aA.Name] = nil
				end
			end
		end
		at.Enabled = next(ax) ~= nil or # at.Frame:GetChildren() > 1
		for az in pairs(ax) do
			local aA = Instance.new'ImageLabel'
			aA.Name = az
			aA.Size = UDim2.fromOffset(31, 31)
			aA.BackgroundTransparency = 1
			aA.Image = O.getIcon({
				itemType = az
			}, true)
			aA.Parent = at.Frame
		end
	end
	local function Added(at)
		if am[at] then
			return
		end
		local au = Instance.new'BillboardGui'
		au.Parent = ao
		au.Name = 'chest'
		au.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		au.Size = UDim2.fromOffset(35, 35)
		au.AlwaysOnTop = true
		au.Adornee = at
		local av = Instance.new'Frame'
		av.Size = UDim2.fromScale(1, 1)
		av.BackgroundColor3 = Color3.fromHSV(al.Hue, al.Sat, al.Value)
		av.BackgroundTransparency = ar.Enabled and (1 - al.Opacity) or 1
		av.BorderSizePixel = 0
		av.Parent = au
		local aw = Instance.new'UIListLayout'
		aw.FillDirection = Enum.FillDirection.Horizontal
		aw.HorizontalAlignment = Enum.HorizontalAlignment.Left
		aw.VerticalAlignment = Enum.VerticalAlignment.Top
		aw.SortOrder = Enum.SortOrder.LayoutOrder
		aw.Padding = UDim.new(0, 2)
		aw.Parent = av
		local ax = addBlur(au)
		ax.Name = 'Blur'
		ax.Visible = ar.Enabled
		ax.Parent = av
		am[at] = au
		an[at] = ''
		refreshAdornee(au)
	end
	local function Removed(at)
		if am[at] then
			am[at]:Destroy()
			am[at] = nil
			an[at] = nil
		end
	end
	ap = v.Categories.Render:CreateModule{
		Name = 'StorageESP',
		Function = function(at)
			if at then
				local au = l:GetTagged'chest'
				for av, aw in ipairs(au) do
					Added(aw)
				end
				ap:Clean(l:GetInstanceAddedSignal'chest':Connect(Added))
				ap:Clean(l:GetInstanceRemovedSignal'chest':Connect(Removed))
				ap:Clean(l:GetInstanceAddedSignal'chest':Connect(function(av)
					if am[av] then
						refreshAdornee(am[av])
					end
				end))
				ap:Clean(g.Heartbeat:Connect(function()
					local av = tick()
					if not ap._lastCleanup or av - ap._lastCleanup < 2 then
						return
					end
					ap._lastCleanup = av
					for aw, ax in pairs(am) do
						if not aw or not aw.Parent then
							Removed(aw)
						end
					end
				end))
			else
				for au in pairs(am) do
					Removed(au)
				end
			end
		end,
		Tooltip = 'Displays items in chests'
	}
	aq = ap:CreateTextList{
		Name = 'Item',
		Function = function()
			table.clear(an)
			for at, au in pairs(am) do
				refreshAdornee(au)
			end
		end
	}
	ar = ap:CreateToggle{
		Name = 'Background',
		Function = function(at)
			if al.Object then
				al.Object.Visible = at
			end
			for au, av in pairs(am) do
				av.Frame.BackgroundTransparency = 1 - (at and al.Opacity or 0)
				local aw = av.Frame:FindFirstChild'Blur'
				if aw then
					aw.Visible = at
				end
			end
		end,
		Default = true
	}
	al = ap:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(at, au, av, aw)
			for ax, ay in pairs(am) do
				ay.Frame.BackgroundColor3 = Color3.fromHSV(at, au, av)
				ay.Frame.BackgroundTransparency = 1 - aw
			end
		end,
		Darker = true
	}
	task.defer(function()
		if al and al.Object then
			al.Object.Visible = ar.Enabled
		end
	end)
end)
a(function()
	local al, am, an, ao, ap = {}
	local function kitCollection(aq, ar, at, au)
		repeat
			if B.isAlive then
				local av, aw = type(aq) == 'table' and aq or collection(aq, am), B.character.RootPart.Position
				for ax, ay in av do
					if not am.Enabled then
						break
					end
					local az = not ay:IsA'Model' and ay or ay.PrimaryPart
					if az and (az.Position - aw).Magnitude <= at then
						pcall(ar, ay)
						task.wait(0.05)
					end
				end
			end
			task.wait(0.1)
		until not am.Enabled
	end
	am = v.Categories.Utility:CreateModule{
		Name = 'AutoKit',
		Function = function(aq)
			if aq then
				repeat
					task.wait()
				until L.equippedKit ~= '' and L.matchState ~= 0 or (not am.Enabled)
				if am.Enabled and ap[L.equippedKit] and al[L.equippedKit].Enabled then
					ap[L.equippedKit]()
				end
			end
		end,
		Tooltip = 'Automatically uses kit abilities.'
	}
	ao = am:CreateTargets{
		Players = true,
		NPCs = true,
		Walls = true
	}
	an = am:CreateToggle{
		Name = 'Legit'
	}
	ap = {
		falconer = function()
			local aq = false
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local ar = B.EntityPosition{
					Range = 18,
					Part = 'RootPart',
					Players = true,
					Sort = aa[Sorts.Value],
					Wallcheck = an.Enabled
				}
				if ar and (t.Character:GetAttribute'Health' or 0) > 0 then
					if ar.RootPart:FindFirstChild'BillboardGui' then
						task.wait(0.1)
						continue
					end
					if O.AbilityController:canUseAbility'SEND_FALCON' then
						aq = true
						O.AbilityController:useAbility('SEND_FALCON', newproxy(true), {
							target = ar.RootPart.Position
						})
					end
				else
					if O.AbilityController:canUseAbility'RECALL_FALCON' and aq then
						aq = false
						O.AbilityController:useAbility'RECALL_FALCON'
					end
				end
				task.wait(0.233)
			until not am.Enabled
		end,
		rebellion_leader = function()
			local aq = 0
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local ar, at = B.EntityPosition{
					Range = 18,
					Part = 'RootPart',
					Players = true,
					Sort = aa[Sorts.Value]
				}, 0
				at = 45
				if t.Character:GetAttribute'Health' <= at then
					if O.AbilityController:canUseAbility'rebellion_shield' then
						O.AbilityController:useAbility'rebellion_shield'
					end
				end
				if ar and (t.Character:GetAttribute'Health' or 0) > 0 then
					local au = tick()
					if (au - aq) >= 0.03 then
						task.wait(0.01)
						aq = au
						continue
					end
					if O.AbilityController:canUseAbility'rebellion_aura_swap' then
						O.AbilityController:useAbility'rebellion_aura_swap'
					end
				end
				task.wait(0.45)
			until not am.Enabled
		end,
		styx = function()
			local aq = ''
			O.Client:Get(P.StyxExitPortal):Connect(function(ar)
				aq = ar.exitPortalData.connectedEntrancePortalUUID
			end)
			kitCollection(t.Name .. ':styx_entrance_portal', function(ar)
				O.Client:Get(P.StyxPortal):SendToServer{
					entrancePortalData = {
						proximityPrompt = ar:WaitForChild'ProximityPrompt',
						uuid = aq,
						blockPosition = O.BlockController:getBlockPosition(ar.Position),
						whirpoolSpinHeartbeatConnection = (nil),
						blockUUID = ar:GetAttribute'BlockUUID',
						beam = workspace:WaitForChild'StyxPortalBeam',
						worldPosition = O.BlockController:getWorldPosition(ar.Position),
						teamId = B.character:GetAttribute'Team'
					}
				}
			end, 12, false)
			am:Clean(workspace.ChildAdded:Connect(function(ar)
				if ar.Name == 'StyxPortal' then
					local at, au = 8, (ar.Pivot.Position - B.character.RootPart.Position).Magnitude
					if au <= at then
						local av = {
							aq
						}
						f:WaitForChild'rbxts_include':WaitForChild'node_modules':WaitForChild'@rbxts':WaitForChild'net':WaitForChild'out':WaitForChild'_NetManaged':WaitForChild'StyxTryOpenExitPortalFromClient':InvokeServer(unpack(av))
					end
				end
			end))
		end,
		yeti = function()
			local function getBedNear()
				local aq = B.isAlive and B.character.RootPart.Position or Vector3.zero
				for ar, at in l:GetTagged'bed' do
					if (aq - at.Position).Magnitude < 15 then
						if at:GetAttribute('Team' .. (t:GetAttribute'Team' or - 1) .. 'NoBreak') then
							return nil
						end
						return at
					end
				end
			end
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aq = getBedNear()
				if aq then
					if O.AbilityController:canUseAbility'yeti_glacial_roar' then
						O.AbilityController:useAbility'yeti_glacial_roar'
					end
				end
				task.wait(0.45)
			until not am.Enabled
		end,
		spider_queen = function()
			local aq, ar = false
			repeat
				if B.isAlive and O.AbilityController then
					if aq and (not ar or not ar.RootPart) then
						aq = false
						ar = nil
					end
					if not aq then
						local at = B.EntityPosition{
							Range = an.Enabled and 50 or 80,
							Part = 'RootPart',
							Players = ao.Players.Enabled,
							NPCs = ao.NPCs.Enabled,
							Wallcheck = ao.Walls.Enabled,
							Sort = aa.Distance
						}
						if at and O.AbilityController:canUseAbility'spider_queen_web_bridge_aim' then
							ar = at
							O.AbilityController:useAbility'spider_queen_web_bridge_aim'
							aq = true
						end
					end
					if aq and ar and ar.RootPart then
						if O.AbilityController:canUseAbility'spider_queen_web_bridge_fire' then
							local at, au = B.character.RootPart.Position, ar.RootPart.Position
							local av = (au - at).Unit
							O.AbilityController:useAbility('spider_queen_web_bridge_fire', newproxy(true), {
								direction = av
							})
							aq = false
							ar = nil
							task.wait(0.3)
						end
					end
					if O.AbilityController:canUseAbility'spider_queen_summon_spiders' then
						O.AbilityController:useAbility'spider_queen_summon_spiders'
					end
				end
				task.wait(0.05)
			until not am.Enabled
		end,
		sorcerer = function()
			kitCollection('alchemy_crystal', function(aq)
				O.Client:Get(P.collectEntity):SendToServer{
					id = aq:GetAttribute'Id',
					collectableName = aq.Name
				}
			end, 12, false)
		end,
		berserker = function()
			local aq, ar = workspace:FindFirstChild'MapCFrames', t.Character:GetAttribute'Team' or 1
			if aq then
				for at, au in pairs(aq:GetChildren()) do
					if au:IsA'CFrameValue' and string.match(au.Name, '_bed') then
						if not string.match(au.Name, ar .. '_bed') then
							local av = Instance.new'Part'
							av.Transparency = 1
							av.CanCollide = false
							av.Anchored = true
							av.Size = Vector3.new(64, 64, 64)
							av.CFrame = au.Value
							av.Parent = workspace
							av.Name = 'AutoKitRagnarPartWMAEROV4'
							O.QueryUtil:setQueryIgnored(av, true)
							av.Touched:Connect(function(aw)
								if aw.Parent.Name == t.Name then
									if O.AbilityController:canUseAbility'berserker_rage' then
										O.AbilityController:useAbility'berserker_rage'
									end
								end
							end)
						end
					end
				end
			end
			am:Clean(function()
				for at, au in workspace:GetChildren() do
					if au:IsA'BasePart' and au.Name == 'AutoKitRagnarPart' then
						au:Destory()
					end
				end
			end)
		end,
		hatter = function()
			repeat
				for aq, ar in pairs(t.PlayerGui.NotificationApp:GetDescendants()) do
					if ar:IsA'TextLabel' then
						local at = string.lower(ar.Text)
						if string.find(at, 'teleport') then
							if O.AbilityController:canUseAbility'HATTER_TELEPORT' then
								task.wait(0.05)
								O.AbilityController:useAbility'HATTER_TELEPORT'
							end
						end
					end
				end
				task.wait(0.34)
			until not am.Enabled
		end,
		gingerbread_man = function()
			local aq = O.LaunchPadController.attemptLaunch
			O.LaunchPadController.attemptLaunch = function(...)
				local ar, at, au = {
					aq(...)
				}, ...
				if (workspace:GetServerTimeNow() - at.lastLaunch) < 0.4 then
					if au:GetAttribute'PlacedByUserId' == t.UserId and (au.Position - B.character.RootPart.Position).Magnitude < 30 then
						if not an.Enabled or isHoldingPickaxe() then
							task.spawn(O.breakBlock, au, false, nil, true)
							task.spawn(O.breakBlock, au, false, nil, true)
						end
					end
				end
				return unpack(ar)
			end
			am:Clean(function()
				O.LaunchPadController.attemptLaunch = aq
			end)
		end,
		wizard = function()
			math.randomseed(os.clock() * 1e6)
			local aq = math.random(0, 100)
			repeat
				local ar = t:GetAttribute'WizardAbility'
				if not ar then
					task.wait(0.85)
					continue
				end
				local at = B.EntityPosition{
					Range = an.Enabled and 32 or 50,
					Part = 'RootPart',
					Players = ao.Players.Enabled,
					NPCs = ao.NPCs.Enabled,
					Wallcheck = ao.Walls.Enabled,
					Sort = aa.Distance
				}
				if not at or not L.hand.tool then
					task.wait(0.85)
					continue
				end
				local au, av = L.hand.tooltype, at.RootPart.Position
				if O.AbilityController:canUseAbility(ar) then
					O.AbilityController:useAbility(ar, newproxy(true), {
						target = av
					})
				end
				if au == 'wizard_staff_2' or au == 'wizard_staff_3' then
					local aw = B.EntityPosition{
						Range = an.Enabled and 13 or 20,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled,
						Sort = aa.Distance
					}
					if aw then
						local ax = aw.RootPart.Position
						if aq <= 50 then
							if O.AbilityController:canUseAbility'SHOCKWAVE' then
								O.AbilityController:useAbility('SHOCKWAVE', newproxy(true), {
									target = Vector3.zero
								})
								aq = math.random(0, 100)
							end
						else
							if O.AbilityController:canUseAbility(ar) then
								O.AbilityController:useAbility(ar, newproxy(true), {
									target = ax
								})
								aq = math.random(0, 100)
							end
						end
					end
				end
				if au == 'wizard_staff_3' then
					local aw = B.EntityPosition{
						Range = an.Enabled and 12 or 18,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled,
						Sort = aa.Distance
					}
					if aw then
						local ax = aw.RootPart.Position
						if aq <= 40 then
							if O.AbilityController:canUseAbility(ar) then
								O.AbilityController:useAbility(ar, newproxy(true), {
									target = ax
								})
								aq = math.random(0, 100)
							end
						elseif aq <= 70 then
							if O.AbilityController:canUseAbility'SHOCKWAVE' then
								O.AbilityController:useAbility('SHOCKWAVE', newproxy(true), {
									target = Vector3.zero
								})
								aq = math.random(0, 100)
							end
						else
							if O.AbilityController:canUseAbility'LIGHTNING_STORM' then
								O.AbilityController:useAbility('LIGHTNING_STORM', newproxy(true), {
									target = ax
								})
								aq = math.random(0, 100)
							end
						end
					end
				end
				task.wait(0.85)
			until not am.Enabled
		end,
		necromancer = function()
			local aq = an.Enabled and 8 or 12
			kitCollection('Gravestone', function(ar)
				local at, au, av, aw, ax = ar:GetAttribute'ArmorType', ar:GetAttribute'SwordType', ar:GetAttribute'GravestonePlayerUserId', ar:GetAttribute'GravestoneSecret', ar:GetAttribute'GravestonePosition'
				local ay, az = pcall(function()
					return O.Client:Get(P.ActivateGravestone).instance:InvokeServer{
						skeletonData = {
							armorType = at,
							weaponType = au,
							associatedPlayerUserId = av
						},
						secret = aw,
						position = ax
					}
				end)
				if ay and az and az.success then
					local aA = O.Knit.Controllers.NecromancerController
					if aA then
						pcall(function()
							aA:useGravestone(t, ar)
						end)
					end
				end
			end, aq, false)
		end,
		midnight = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				if O.AbilityController:canUseAbility'midnight' then
					local aq = B.EntityPosition{
						Range = an.Enabled and 20 or 30,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled,
						Sort = aa.Distance
					}
					if aq or not an.Enabled then
						O.AbilityController:useAbility'midnight'
						task.wait(0.5)
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		fisherman = function()
			local aq = O.FishingMinigameController.startMinigame
			O.FishingMinigameController.startMinigame = function(ar, at, au)
				if an.Enabled then
					task.spawn(function()
						local av = O.GameAnimationUtil:playAnimation(t.Character, O.AnimationType.FISHING_ROD_PULLING)
						task.wait(3.5)
						pcall(function()
							if av then
								av:Stop()
							end
						end)
						pcall(function()
							au{
								win = true
							}
						end)
					end)
				else
					pcall(function()
						au{
							win = true
						}
					end)
				end
			end
			am:Clean(function()
				O.FishingMinigameController.startMinigame = aq
			end)
		end,
		davey = function()
			local aq = O.CannonHandController.launchSelf
			O.CannonHandController.launchSelf = function(...)
				local ar, at, au = {
					aq(...)
				}, ...
				if au:GetAttribute'PlacedByUserId' == t.UserId and (au.Position - B.character.RootPart.Position).Magnitude < 30 then
					task.spawn(O.breakBlock, au, false, nil, true)
				end
				return unpack(ar)
			end
			am:Clean(function()
				O.CannonHandController.launchSelf = aq
			end)
		end,
		battery = function()
			repeat
				if B.isAlive then
					local aq = OverlapParams.new()
					aq.MaxParts = 0
					local ar = an.Enabled and 6 or 25
					for at, au in workspace:GetPartBoundsInRadius(B.character.RootPart.Position, ar, aq) do
						if au:IsA'BasePart' then
							local av = O.BatteryEffectsController:getBatteryIdFromPart(au)
							if av and av ~= 0 then
								local aw = O.BatteryEffectsController:getBatteryInfo(av)
								if aw then
									local ax = workspace:GetServerTimeNow()
									if aw.activateTime < ax and (aw.consumeTime or 0) + 0.5 < ax then
										aw.consumeTime = ax
										pcall(function()
											O.Client:Get(P.ConsumeBattery):SendToServer{
												batteryId = av
											}
										end)
									end
								end
							end
						end
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		alchemist = function()
			local aq = an.Enabled and 8 or 16
			kitCollection('alchemist_ingedients', function(ar)
				O.Client:Get(P.CollectCollectableEntity):SendToServer{
					id = ar:GetAttribute'Id',
					collectableName = ar.Name
				}
			end, aq, false)
		end,
		defender = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aq = false
				if an.Enabled then
					local ar = t.Character:FindFirstChild'HandInvItem'
					aq = ar and ar.Value and ar.Value.Name:find'defense_scanner'
					if not aq then
						task.wait(0.1)
						continue
					end
				end
				local ar = O.Knit.Controllers.DefenderKitController
				if not ar then
					task.wait(0.1)
					continue
				end
				for at, au in ar.currentSchematic do
					if not am.Enabled then
						break
					end
					if not B.isAlive then
						break
					end
					if an.Enabled then
						local av = t.Character:FindFirstChild'HandInvItem'
						local aw = av and av.Value and av.Value.Name:find'defense_scanner'
						if not aw then
							break
						end
					end
					pcall(function()
						ar:requestPlaceDefenderBlock(at)
					end)
					task.wait(an.Enabled and 0.3 or 0.05)
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		block_kicker = function()
			local aq = game.Players.LocalPlayer
			repeat
				if B.isAlive and O.AbilityController then
					local ar, at = aq.Character, 0
					if ar then
						at = ar:GetAttribute'BlockKickerKit_BlockCount' or aq:GetAttribute'BlockKickerKit_BlockCount' or 0
					else
						at = aq:GetAttribute'BlockKickerKit_BlockCount' or 0
					end
					if at <= 2 and O.AbilityController:canUseAbility'BLOCK_STOMP' then
						O.AbilityController:useAbility'BLOCK_STOMP'
						task.wait(0.8)
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		dragon_slayer = function()
			kitCollection('KaliyahPunchInteraction', function(aq)
				local ar = e.LocalPlayer.Character
				if not ar or not ar.PrimaryPart then
					return
				end
				O.DragonSlayerController:deleteEmblem(aq)
				local at = ar:GetPrimaryPartCFrame().Position
				local au = aq:GetPrimaryPartCFrame().Position * Vector3.new(1, 0, 1) + Vector3.new(0, at.Y, 0)
				local av = CFrame.new(at, au)
				ar:PivotTo(av)
				O.DragonSlayerController:playPunchAnimation(av - av.Position)
				O.Client:Get(P.RequestDragonPunch):SendToServer{
					target = aq
				}
			end, 18, true)
		end,
		drill = function()
			local aq = t.UserId
			repeat
				if B.isAlive then
					local ar = l:GetTagged'Drill'
					for at, au in ipairs(ar) do
						if au:GetAttribute'PlacedByUserId' == aq then
							pcall(function()
								O.Client:Get(P.ExtractFromDrill).instance:FireServer{
									drill = au
								}
							end)
						end
					end
				end
				task.wait(0.5)
			until not am.Enabled
		end,
		hannah = function()
			local aq = an.Enabled and 12 or 30
			kitCollection('HannahExecuteInteraction', function(ar)
				local at = O.Client:Get(P.HannahPromptTrigger).instance:InvokeServer{
					user = t,
					victimEntity = ar
				}
				if at then
					local au = ar:FindFirstChild'Hannah Execution Icon'
					if au then
						au:Destroy()
					end
				end
			end, aq, true)
		end,
		jailor = function()
			local aq = an.Enabled and 9 or 20
			kitCollection('jailor_soul', function(ar)
				O.JailorController:collectEntity(t, ar, 'JailorSoul')
			end, aq, false)
		end,
		grim_reaper = function()
			local aq = an.Enabled and 35 or 120
			kitCollection(O.GrimReaperController.soulsByPosition, function(ar)
				if B.isAlive and t.Character:GetAttribute'Health' <= (t.Character:GetAttribute'MaxHealth' / 4) and (not t.Character:GetAttribute'GrimReaperChannel') then
					O.Client:Get(P.ConsumeSoul):CallServer{
						secret = ar:GetAttribute'GrimReaperSoulSecret'
					}
				end
			end, aq, false)
		end,
		farmer_cletus = function(aq)
			local ar = an.Enabled and 6 or 10
			kitCollection('HarvestableCrop', function(at)
				O.Client:Get(P.Harvest):CallServer{
					position = O.BlockController:getBlockPosition(at.Position)
				}
				O.GameAnimationUtil:playAnimation(t.Character, O.AnimationType.PUNCH)
				O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
				O.SoundManager:playSound(O.SoundList.CROP_HARVEST)
			end, ar, false)
		end,
		taliyah = function(aq)
			local ar = an.Enabled and 6 or 8
			kitCollection('HarvestableCrop', function(at)
				O.Client:Get(P.Harvest):CallServer{
					position = O.BlockController:getBlockPosition(at.Position)
				}
				O.GameAnimationUtil:playAnimation(t.Character, O.AnimationType.PUNCH)
				O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
				O.SoundManager:playSound(O.SoundList[currentsound] or O.SoundList.CHICKEN_ATTACK_1)
			end, ar, false)
		end,
		melody = function()
			repeat
				local aq, ar, at = 30, math.huge
				if B.isAlive then
					local au = B.character.RootPart.Position
					for av, aw in B.List do
						if aw.Player and aw.Player:GetAttribute'Team' == t:GetAttribute'Team' then
							local ax = (au - aw.RootPart.Position).Magnitude
							if ax <= aq and aw.Health < ar and aw.Health < aw.MaxHealth then
								aq, ar, at = ax, aw.Health, aw
							end
						end
					end
				end
				if at and getItem'guitar' then
					O.Client:Get(P.GuitarHeal):SendToServer{
						healTarget = at.Character
					}
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		mimic = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aq = B.character.RootPart.Position
				for ar, at in B.List do
					if at.Targetable and at.Character and at.Player then
						local au = (at.RootPart.Position - aq).Magnitude
						if au <= (an.Enabled and 12 or 30) then
							if l:HasTag(at.Character, 'MimicBLockPickPocketPlayer') then
								pcall(function()
									O.Client:Get(P.MimicBlockPickPocketPlayer).instance:InvokeServer(at.Player)
								end)
								task.wait(0.5)
							end
						end
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		pinata = function()
			local aq = an.Enabled and 8 or 18
			kitCollection(t.Name .. ':pinata', function(ar)
				if getItem'candy' then
					O.Client:Get(P.DepositCoins):CallServer(ar)
				end
			end, aq, true)
		end,
		spirit_assassin = function()
			local aq = an.Enabled and 35 or 120
			kitCollection('EvelynnSoul', function(ar)
				O.SpiritAssassinController:useSpirit(t, ar)
			end, aq, true)
		end,
		void_knight = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aq, ar = t:GetAttribute'VoidKnightTier' or 0, t:GetAttribute'VoidKnightHaltedProgress'
				if ar then
					task.wait(0.5)
					continue
				end
				if aq < 4 then
					if aq < 3 then
						local at = getItem'iron'
						at = at and at.amount or 0
						if at >= 10 and O.AbilityController:canUseAbility'void_knight_consume_iron' then
							O.AbilityController:useAbility'void_knight_consume_iron'
							task.wait(0.5)
						end
					end
					if aq >= 2 and aq < 4 then
						local at = getItem'emerald'
						at = at and at.amount or 0
						if at >= 1 and O.AbilityController:canUseAbility'void_knight_consume_emerald' then
							O.AbilityController:useAbility'void_knight_consume_emerald'
							task.wait(0.5)
						end
					end
				end
				if aq >= 4 and O.AbilityController:canUseAbility'void_knight_ascend' then
					local at, au, av = false, t.Character:GetAttribute'Health' or 100, t.Character:GetAttribute'MaxHealth' or 100
					if au < (av * 0.5) then
						at = true
					end
					if not at then
						local aw = B.EntityPosition{
							Range = an.Enabled and 30 or 50,
							Part = 'RootPart',
							Players = ao.Players.Enabled,
							NPCs = ao.NPCs.Enabled,
							Wallcheck = ao.Walls.Enabled,
							Sort = aa.Distance
						}
						if aw then
							at = true
						end
					end
					if at then
						O.AbilityController:useAbility'void_knight_ascend'
						task.wait(16)
					end
				end
				task.wait(0.5)
			until not am.Enabled
		end,
		void_dragon = function()
			local aq, ar = t, O.VoidDragonController.flapWings
			O.VoidDragonController.flapWings = function(at, ...)
				local au = ar(at, ...)
				if au ~= false and at.inDragonForm then
					local av = O.SprintController:getMovementStatusModifier():addModifier{
						blockSprint = true,
						constantSpeedMultiplier = 2
					}
					at.SpeedMaid:GiveTask(av)
				end
				return au
			end
			am:Clean(function()
				O.VoidDragonController.flapWings = ar
			end)
			repeat
				if B.isAlive and O.VoidDragonController and O.VoidDragonController.inDragonForm then
					local at = B.EntityPosition{
						Range = 30,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled,
						Sort = aa.Distance
					}
					if at and at.RootPart then
						local au = true
						if an.Enabled then
							local av, aw = B.character.RootPart.Position, B.character.RootPart.CFrame.LookVector
							local ax = (at.RootPart.Position - av).Unit
							local ay = aw:Dot(ax)
							local az = math.acos(ay) * (180 / math.pi)
							if az > 90 then
								au = false
							end
						end
						if au then
							O.Client:Get(P.DragonBreath).instance:FireServer{
								player = aq,
								targetPoint = at.RootPart.Position
							}
							task.wait(1)
						end
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		cactus = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				if O.AbilityController:canUseAbility'cactus_fire' then
					local aq = B.EntityPosition{
						Range = an.Enabled and 8 or 18,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled,
						Sort = aa.Distance
					}
					if aq then
						O.AbilityController:useAbility'cactus_fire'
						task.wait(0.5)
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		card = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				if O.AbilityController:canUseAbility'CARD_THROW' then
					local aq = B.EntityPosition{
						Range = an.Enabled and 30 or 60,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled,
						Sort = aa.Distance
					}
					if aq then
						O.AbilityController:useAbility'CARD_THROW'
						task.wait(0.1)
						pcall(function()
							O.Client:Get(P.AttemptCardThrow).instance:FireServer{
								targetEntityInstance = aq.Character
							}
						end)
						task.wait(0.5)
					end
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		black_market_trader = function()
			local aq = an.Enabled and 8 or 16
			kitCollection('shadow_coin', function(ar)
				O.Client:Get(P.CollectCollectableEntity):SendToServer{
					id = ar:GetAttribute'Id',
					collectableName = 'shadow_coin'
				}
			end, aq, false)
		end,
		beekeeper = function()
			local aq = an.Enabled and 8 or 30
			kitCollection('bee', function(ar)
				O.Client:Get(P.BeePickup):SendToServer{
					beeId = ar:GetAttribute'BeeId'
				}
			end, aq, false)
		end,
		summoner = function()
			local aq, ar = 0, 0.65
			local function getPlayerClawLevel()
				local at = t.Character and t.Character:FindFirstChild'HandInvItem'
				if at and at.Value then
					local au = at.Value.Name
					if au == 'summoner_claw_1' then
						return 1
					end
					if au == 'summoner_claw_2' then
						return 2
					end
					if au == 'summoner_claw_3' then
						return 3
					end
					if au == 'summoner_claw_4' then
						return 4
					end
				end
				if L and L.inventory and L.inventory.hotbar then
					for au, av in pairs(L.inventory.hotbar) do
						if av.item then
							local aw = av.item.itemType
							if aw == 'summoner_claw_1' then
								return 1
							end
							if aw == 'summoner_claw_2' then
								return 2
							end
							if aw == 'summoner_claw_3' then
								return 3
							end
							if aw == 'summoner_claw_4' then
								return 4
							end
						end
					end
				end
				return 1
			end
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local at = false
				if an.Enabled then
					if t.Character:GetAttribute'Casting' or t.Character:GetAttribute'UsingAbility' or t.Character:GetAttribute'SummonerCasting' then
						at = true
					end
					local au = t.Character:FindFirstChildOfClass'Humanoid'
					if au and au:GetState() == Enum.HumanoidStateType.Freefall then
						at = true
					end
				end
				if an.Enabled and at then
					task.wait(0.1)
					continue
				end
				if (workspace:GetServerTimeNow() - aq) < ar then
					task.wait(0.1)
					continue
				end
				local au = t.Character:FindFirstChild'HandInvItem'
				local av = au and au.Value and au.Value.Name:find'summoner_claw'
				if not av then
					task.wait(0.1)
					continue
				end
				local aw = B.EntityPosition{
					Range = an.Enabled and 23 or 35,
					Part = 'RootPart',
					Players = ao.Players.Enabled,
					NPCs = ao.NPCs.Enabled,
					Wallcheck = ao.Walls.Enabled,
					Sort = aa.Distance
				}
				if aw and an.Enabled and (B.character.RootPart.Position - aw.RootPart.Position).Magnitude > 23 then
					aw = nil
				end
				if aw and (not an.Enabled or (t.Character:GetAttribute'Health' or 0) > 0) then
					local ax = B.character.RootPart.Position
					local ay = CFrame.lookAt(ax, aw.RootPart.Position).LookVector
					ax += ay * math.max((ax - aw.RootPart.Position).Magnitude - 16, 0)
					aq = workspace:GetServerTimeNow()
					pcall(function()
						O.AnimationUtil:playAnimation(t, O.GameAnimationUtil:getAssetId(O.AnimationType.SUMMONER_CHARACTER_SWIPE), {
							looped = false
						})
					end)
					task.spawn(function()
						pcall(function()
							local az = f.Assets.Misc.Kaida.Summoner_DragonClaw:Clone()
							az.Parent = workspace
							local aA, aB, aC = getPlayerClawLevel(), {
								Color3.fromRGB(75, 75, 75),
								Color3.fromRGB(255, 255, 255),
								Color3.fromRGB(43, 229, 229),
								Color3.fromRGB(49, 229, 94)
							}, az:FindFirstChild'dragon_claw_nail_mesh'
							if aC and aC:IsA'MeshPart' then
								aC.Color = aB[aA] or aB[1]
							end
							if O.KnightClient and O.KnightClient.Controllers.SummonerKitSkinController then
								if O.KnightClient.Controllers.SummonerKitSkinController:isPrismaticSkin(t) then
									O.KnightClient.Controllers.SummonerKitSkinController:applyClawRGB(az)
								end
							end
							if s.CFrame.Position and (s.CFrame.Position - B.character.RootPart.Position).Magnitude < 1 then
								for aD, aE in az:GetDescendants() do
									if aE:IsA'MeshPart' then
										aE.Transparency = 0.6
									end
								end
							end
							local aD, aE = B.character.RootPart, Vector3.new(ay.X, 0, ay.Z).Unit
							local aF = aD.Position + aE:Cross(Vector3.new(0, 1, 0)).Unit * - 1 * 5 + aE * 6
							local aG = (aF + ay * 13 - aF).Unit
							local aH = CFrame.new(aF, aF + aG)
							az:PivotTo(aH)
							az.PrimaryPart.Anchored = true
							if az:FindFirstChild'AnimationController' then
								local aI = az.AnimationController:FindFirstChildOfClass'Animator'
								if aI then
									O.AnimationUtil:playAnimation(aI, O.GameAnimationUtil:getAssetId(O.AnimationType.SUMMONER_CLAW_ATTACK), {
										looped = false,
										speed = 1
									})
								end
							end
							pcall(function()
								local aI = {
									O.SoundList.SUMMONER_CLAW_ATTACK_1,
									O.SoundList.SUMMONER_CLAW_ATTACK_2,
									O.SoundList.SUMMONER_CLAW_ATTACK_3,
									O.SoundList.SUMMONER_CLAW_ATTACK_4
								}
								O.SoundManager:playSound(aI[math.random(1, # aI)], {
									position = aD.Position
								})
							end)
							task.wait(0.65)
							az:Destroy()
						end)
					end)
					O.Client:Get(P.SummonerClawAttack):SendToServer{
						position = ax,
						direction = ay,
						clientTime = workspace:GetServerTimeNow()
					}
				end
				task.wait(0.1)
			until not am.Enabled
		end,
		bigman = function()
			local aq = an.Enabled and 6 or 10
			kitCollection('treeOrb', function(ar)
				if not ar or not ar.Parent then
					return
				end
				local at = ar:GetAttribute'TreeOrbSecret'
				if not at then
					return
				end
				if B.isAlive then
					O.GameAnimationUtil:playAnimation(t, O.AnimationType.PUNCH)
					O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
					O.SoundManager:playSound(O.SoundList.CROP_HARVEST)
				end
				local au = O.Client:Get'ConsumeTreeOrb':CallServer{
					treeOrbSecret = at
				}
				if au then
					ar:Destroy()
				end
			end, aq, false)
		end,
		star_collector = function()
			local aq, ar, at = an.Enabled and 10 or 18, {}, 0.5
			kitCollection('stars', function(au)
				if ar[au] and tick() - ar[au] < at then
					return
				end
				ar[au] = tick()
				O.GameAnimationUtil:playAnimation(t, O.AnimationType.PUNCH)
				O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
				O.StarCollectorController:collectEntity(t, au, au.Name)
			end, aq, false)
		end,
		spirit_summoner = function()
			repeat
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aq = false
				for ar, at in L.inventory.inventory.items do
					if at.itemType == 'spirit_staff' then
						aq = true
						break
					end
				end
				if aq then
					local ar = t:GetAttribute'ReadySummonedAttackSpirits' or 0
					if ar < 10 then
						local at = false
						for au, av in L.inventory.inventory.items do
							if av.itemType == 'summon_stone' then
								at = true
								break
							end
						end
						if at and O.AbilityController:canUseAbility'summon_attack_spirit' then
							O.AbilityController:useAbility'summon_attack_spirit'
							task.wait(0.5)
						end
					end
				end
				task.wait(0.2)
			until not am.Enabled
		end,
		metal_detector = function()
			local aq = an.Enabled and 8 or 10
			kitCollection('hidden-metal', function(ar)
				if an.Enabled then
					O.GameAnimationUtil:playAnimation(t, O.AnimationType.SHOVEL_DIG)
					O.SoundManager:playSound(O.SoundList.SNAP_TRAP_CONSUME_MARK)
				end
				O.Client:Get'CollectCollectableEntity':SendToServer{
					id = ar:GetAttribute'Id',
					collectableName = ar.Name
				}
			end, aq, false)
		end,
		mage = function()
			local aq = an.Enabled and 8 or 16
			kitCollection('ElementTome', function(ar)
				local at = ar:GetAttribute'TomeSecret'
				if at then
					O.GameAnimationUtil:playAnimation(t, O.AnimationType.PUNCH)
					O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
					local au = O.Client:Get(P.LearnElementTome).instance:InvokeServer{
						secret = at
					}
					if au and au.success then
						ar:Destroy()
						task.wait(0.5)
					end
				end
			end, aq, false)
		end,
		warlock = function()
			local aq, ar, at = false, an.Enabled and 12 or 30
			repeat
				if not B.isAlive then
					at = nil
					aq = false
					task.wait(0.1)
					continue
				end
				if L.hand.tool and L.hand.tool.Name == 'warlock_staff' then
					local au = B.EntityPosition{
						Range = ar,
						Part = 'RootPart',
						Players = ao.Players.Enabled,
						NPCs = ao.NPCs.Enabled,
						Wallcheck = ao.Walls.Enabled
					}
					if au and au.Character ~= at then
						if not aq then
							O.AbilityController:useAbility'WARLOCK_LINK'
							aq = true
						end
						local av = pcall(function()
							O.Client:Get(P.WarlockTarget):CallServer{
								target = au.Character
							}
						end)
						if not av then
							au = nil
							aq = false
						end
					end
					if not au then
						aq = false
					end
					at = au and au.Character
				else
					at = nil
					aq = false
				end
				task.wait(0.1)
			until not am.Enabled
		end
	}
	local aq = {}
	for ar in ap do
		table.insert(aq, ar)
	end
	table.sort(aq, function(ar, at)
		return O.BedwarsKitMeta[ar].name < O.BedwarsKitMeta[at].name
	end)
	for ar, at in aq do
		al[at] = am:CreateToggle{
			Name = O.BedwarsKitMeta[at].name,
			Default = true
		}
	end
end)
a(function()
	local al, am = O.CannonHandController, O.CannonController
	local an, ao, ap, aq, ar, at, au, av, aw, ax, ay, az, aA = al.launchSelf, am.stopAiming, am.startAiming, false, false
	local function getPickaxeSlot()
		for aB, aC in pairs(L.inventory.hotbar) do
			if aC.item and O.ItemMeta[aC.item.itemType] then
				local aD = O.ItemMeta[aC.item.itemType]
				if aD.breakBlock then
					return aB - 1
				end
			end
		end
		return nil
	end
	local function getCannonSlot()
		for aB, aC in pairs(L.inventory.hotbar) do
			if aC.item then
				local aD = tostring(aC.item.itemType):lower()
				if aD:find'cannon' then
					return aB - 1
				end
			end
		end
		return nil
	end
	local function hasWoodPickaxeOnly()
		local aB = 0
		for aC, aD in pairs(L.inventory.hotbar) do
			if aD.item then
				local aE = tostring(aD.item.itemType):lower()
				if aE == 'wood_pickaxe' and aB < 1 then
					aB = 1
				elseif (aE:find'pickaxe' or aE:find'drill') and aE ~= 'wood_pickaxe' then
					aB = 2
				end
			end
		end
		return aB == 1
	end
	local function getNearestCannon()
		if not B.isAlive then
			return nil
		end
		local aB, aC = (math.huge)
		for aD, aE in pairs(am.getCannons()) do
			pcall(function()
				local aF = (aE.Position - B.character.RootPart.Position).Magnitude
				if aF < aB and aF < 30 then
					aB = aF
					aC = aE
				end
			end)
		end
		return aC
	end
	local function findCannonModel(aB)
		local aC, aD = 8
		for aE, aF in pairs(workspace:GetDescendants()) do
			if aF:IsA'BasePart' and aF.Name == 'cannon' then
				local aG = (aF.Position - aB).Magnitude
				if aG < aC then
					aC = aG
					aD = aF
				end
			end
		end
		return aD
	end
	local function doBreakCannon(aB)
		if not B.isAlive then
			return
		end
		if not aB or not aB.Parent then
			return
		end
		local aC = getPlacedBlock(aB.Position)
		if aC and aC.Name == 'cannon' and (B.character.RootPart.Position - aC.Position).Magnitude < 30 then
			pcall(O.breakBlock, aC, false, nil, true)
		else
			local aD = findCannonModel(aB.Position)
			if aD and aD.Parent then
				pcall(O.breakBlock, aD, false, nil, true)
			end
		end
	end
	local function breakCannon(aB, aC)
		if not B.isAlive then
			aq = false
			return aC()
		end
		local aD
		if ay.Enabled and not isHoldingPickaxe() then
			local aE = getPickaxeSlot()
			if not aE then
				notif('BetterDavey', 'No pickaxe found in hotbar!', 3)
				if au.Enabled and B.isAlive and B.character.Humanoid then
					B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				aq = false
				return aC()
			end
			aD = getCannonSlot()
			if hotbarSwitch(aE) then
				task.wait(0.05)
			end
		end
		if ax.Enabled and not isHoldingPickaxe() then
			notif('BetterDavey', 'You need to HOLD a pickaxe to break cannons!', 3)
			if au.Enabled and B.isAlive and B.character.Humanoid then
				B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			aq = false
			return aC()
		end
		if aA.Value > 0 then
			task.wait(aA.Value)
		end
		local aE = aB
		if au.Enabled and B.isAlive and B.character.Humanoid then
			B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
		aC()
		aq = false
		task.spawn(function()
			task.wait(0.05)
			doBreakCannon(aE)
			task.wait(0.35)
			if aE and aE.Parent then
				doBreakCannon(aE)
			end
			if ay.Enabled and aD then
				task.wait(0.05)
				hotbarSwitch(aD)
			end
		end)
	end
	at = v.Categories.Kits:CreateModule{
		Name = 'AutoDavey',
		Function = function(aB)
			if aB then
				al.launchSelf = function(...)
					if aq then
						aq = false
						return an(...)
					end
					aq = true
					if az.Value > 0 then
						task.wait(az.Value)
					end
					if aw.Enabled then
						local aC = getNearestCannon()
						if aC then
							local aD = {
								...
							}
							breakCannon(aC, function()
								an(unpack(aD))
							end)
							return
						else
							if au.Enabled and B.isAlive and B.character.Humanoid then
								B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
							end
							local aD = an(...)
							aq = false
							return aD
						end
					else
						if au.Enabled and B.isAlive and B.character.Humanoid then
							B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						end
						local aC = an(...)
						aq = false
						return aC
					end
				end
				local aC
				am.startAiming = function(...)
					ar = false
					aq = false
					local aD = ap(...)
					aC = getNearestCannon()
					return aD
				end
				am.stopAiming = function(...)
					local aD, aE = aC or getNearestCannon(), ao(...)
					aC = nil
					aq = false
					if av.Enabled and not ar then
						ar = true
						if aw.Enabled and ax.Enabled and not isHoldingPickaxe() and not ay.Enabled then
							notif('BetterDavey', 'Hold a pickaxe to auto-break!', 3)
							return aE
						end
						if aD then
							task.spawn(function()
								pcall(al.launchSelf, al, aD)
							end)
						end
					end
					return aE
				end
				at:Clean(workspace.DescendantAdded:Connect(function(aD)
					if not (aD:IsA'BasePart' and aD.Name == 'cannon') then
						return
					end
					task.spawn(function()
						task.wait(0.1)
						if aw.Enabled and hasWoodPickaxeOnly() then
							local aE = B.isAlive and (B.character.RootPart.Position - aD.Position).Magnitude or math.huge
							if aE < 20 and aD.Parent then
								firstHitCannon(aD)
							end
						end
					end)
				end))
			else
				al.launchSelf = an
				am.stopAiming = ao
				am.startAiming = ap
				aq = false
				ar = false
			end
		end,
		Tooltip = 'Advanced cannon automation with ESP'
	}
	az = at:CreateSlider{
		Name = 'Launch Delay',
		Min = 0,
		Max = 2,
		Default = 0,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay before launching from cannon'
	}
	aA = at:CreateSlider{
		Name = 'Break Delay',
		Min = 0,
		Max = 2,
		Default = 0,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay before breaking cannon'
	}
	au = at:CreateToggle{
		Name = 'Auto Jump',
		Default = true,
		Tooltip = 'Automatically jumps when launching from a cannon'
	}
	av = at:CreateToggle{
		Name = 'Auto Launch',
		Default = true,
		Tooltip = 'Automatically launches you from a cannon when you finish aiming'
	}
	aw = at:CreateToggle{
		Name = 'Auto Break',
		Default = true,
		Tooltip = 'Automatically breaks a cannon when you launch from it'
	}
	ax = at:CreateToggle{
		Name = 'Pickaxe Check',
		Default = true,
		Tooltip = 'Must be HOLDING a pickaxe to break cannons'
	}
	ay = at:CreateToggle{
		Name = 'Auto-Switch Pickaxe',
		Default = false,
		Tooltip = 'Automatically switch to pickaxe when breaking cannon, then switch back'
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at = 0
	aq = v.Categories.World:CreateModule{
		Name = 'NightmareEmote',
		Function = function(au)
			if au then
				local av
				if (not shared.CheatEngineMode) then
					av = require(game:GetService'ReplicatedStorage'.rbxts_include.node_modules['@easy-games']['game-core'].out).GameQueryUtil
				else
					local aw = {}
					function aw.setQueryIgnored(ax)
					end
					av = aw
				end
				local aw, ax = i, e.LocalPlayer
				local ay = ax.Character
				if not ay then
					aq:Toggle()
					return
				end
				local az, aA = ay:WaitForChild'Humanoid', ay.PrimaryPart or ay:FindFirstChild'HumanoidRootPart'
				if not aA then
					aq:Toggle()
					return
				end
				ar = aA
				at = az
				ap = aA.Position
				al = 0
				local aB = game:GetService'ReplicatedStorage':WaitForChild'Assets':WaitForChild'Effects':WaitForChild'NightmareEmote':Clone()
				an = aB
				aB.Parent = game.Workspace
				local aC = aB:GetDescendants()
				for aD, aE in ipairs(aC) do
					if aE:IsA'BasePart' then
						av:setQueryIgnored(aE, true)
						aE.CanCollide = false
						aE.Anchored = true
					end
				end
				local aD = aB:FindFirstChild'Outer'
				if aD then
					aw:Create(aD, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, - 1), {
						Orientation = aD.Orientation + Vector3.new(0, 360, 0)
					}):Play()
				end
				local aE = aB:FindFirstChild'Middle'
				if aE then
					aw:Create(aE, TweenInfo.new(12.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, - 1), {
						Orientation = aE.Orientation + Vector3.new(0, - 360, 0)
					}):Play()
				end
				am = Instance.new'Animation'
				am.AnimationId = 'rbxassetid://9191822700'
				am = az:LoadAnimation(am)
				am:Play()
				local aF = 1.0000000000000002E-2
				ao = g.RenderStepped:Connect(function()
					if not an or not an.Parent then
						if ao then
							ao:Disconnect()
						end
						return
					end
					local aG = tick()
					if (aG - al) > 0.5 then
						if not ay or not ay.Parent then
							an:Destroy()
							an = nil
							if ao then
								ao:Disconnect()
							end
							aq:Toggle()
							return
						end
						if not ar or not ar.Parent then
							ar = ay.PrimaryPart or ay:FindFirstChild'HumanoidRootPart'
						end
						if not at or not at.Parent then
							at = ay:FindFirstChildOfClass'Humanoid'
						end
						if not ar or not at or at.Health <= 0 then
							an:Destroy()
							an = nil
							if ao then
								ao:Disconnect()
							end
							aq:Toggle()
							return
						end
						al = aG
					end
					if ap and ar then
						local aH = ar.Position
						local aI, aJ, aK = aH.X - ap.X, aH.Y - ap.Y, aH.Z - ap.Z
						local aL = aI * aI + aJ * aJ + aK * aK
						if aL > aF then
							an:Destroy()
							an = nil
							if ao then
								ao:Disconnect()
							end
							aq:Toggle()
							return
						end
						ap = aH
					end
					if ar then
						aB:SetPrimaryPartCFrame(ar.CFrame * CFrame.new(0, - 3, 0))
					end
				end)
				aq:Clean(ao)
			else
				if ao then
					ao:Disconnect()
					ao = nil
				end
				if am then
					am:Stop()
					am = nil
				end
				if an then
					an:Destroy()
					an = nil
				end
				ap = nil
				ar = nil
				at = nil
				al = 0
			end
		end
	}
end)
a(function()
	local al, am, an
	local function fixPosition(ao)
		if O and O.BlockController and O.BlockController.getBlockPosition then
			return O.BlockController:getBlockPosition(ao) * 3
		end
		return ao * 3
	end
	local ao, ap, aq, ar, at = {}, {}, {}, {}, O.placeBlock
	O.placeBlock = function(au, av, ...)
		local aw = at(au, av, ...)
		if av == 'tnt' then
			local ax = fixPosition(au)
			local ay = string.format('%.0f,%.0f,%.0f', ax.X, ax.Y, ax.Z)
			ap[ay] = true
		end
		return aw
	end
	local function isEnemyTnt(au)
		if not au or not au.Parent then
			return false
		end
		if ao[au] then
			return false
		end
		local av = fixPosition(au.Position)
		local aw = string.format('%.0f,%.0f,%.0f', av.X, av.Y, av.Z)
		if ap[aw] then
			ao[au] = true
			return false
		end
		local ax = au:GetAttribute'PlacedByUserId'
		if ax and ax == t.UserId then
			ao[au] = true
			ap[aw] = true
			return false
		end
		return true
	end
	local function isHoldingTnt()
		local au = L.hand.tool
		return au and au.Name == 'tnt'
	end
	al = v.Categories.World:CreateModule{
		Name = 'AutoCounter',
		Function = function(au)
			if au then
				table.clear(ar)
				local av = workspace.DescendantAdded:Connect(function(av)
					if av.Name == 'tnt' and av:IsA'Part' then
						aq[av] = true
						task.defer(function()
							local aw = fixPosition(av.Position)
							local ax, ay = string.format('%.0f,%.0f,%.0f', aw.X, aw.Y, aw.Z), av:GetAttribute'PlacedByUserId'
							if ay and ay == t.UserId then
								ao[av] = true
								ap[ax] = true
							elseif ap[ax] then
								ao[av] = true
							end
						end)
						local aw
						aw = av.AncestryChanged:Connect(function()
							if not av.Parent then
								ao[av] = nil
								aq[av] = nil
								ar[av] = nil
								local ax = fixPosition(av.Position)
								local ay = string.format('%.0f,%.0f,%.0f', ax.X, ax.Y, ax.Z)
								ap[ay] = nil
								if aw then
									aw:Disconnect()
								end
							end
						end)
					end
				end)
				al:Clean(av)
				for aw in pairs(aq) do
					if aw.Parent then
						local ax = aw:GetAttribute'PlacedByUserId'
						if ax and ax == t.UserId then
							ao[aw] = true
							local ay = fixPosition(aw.Position)
							local az = string.format('%.0f,%.0f,%.0f', ay.X, ay.Y, ay.Z)
							ap[az] = true
						end
					end
				end
				local aw = {}
				for ax, ay in ipairs(Enum.NormalId:GetEnumItems()) do
					local az = Vector3.fromNormalId(ay)
					if az.Y == 0 then
						table.insert(aw, az)
					end
				end
				repeat
					if not B.isAlive then
						task.wait(0.1)
						continue
					end
					if an.Enabled and not isHoldingTnt() then
						task.wait(0.1)
						continue
					end
					if not getItem'tnt' then
						task.wait(0.1)
						continue
					end
					local ax, ay = B.character.RootPart.Position, 30
					local az = ay * ay
					for aA in pairs(aq) do
						if aA.Parent and not ar[aA] then
							if isEnemyTnt(aA) then
								local aB = aA.Position - ax
								local aC = aB.X * aB.X + aB.Y * aB.Y + aB.Z * aB.Z
								if aC <= az then
									local aD, aE = 0, am.Value
									for aF, aG in ipairs(aw) do
										if an.Enabled and not isHoldingTnt() then
											break
										end
										if aD >= aE then
											break
										end
										local aH = fixPosition(aA.Position + aG * 3.5)
										if not getPlacedBlock(aH) and getItem'tnt' then
											if an.Enabled and not isHoldingTnt() then
												break
											end
											O.placeBlock(aH, 'tnt')
											aD = aD + 1
											task.wait(0.05)
										end
									end
									ar[aA] = true
									task.defer(function()
										if aA.Parent then
											aA.AncestryChanged:Wait()
										end
										ar[aA] = nil
									end)
								end
							end
						end
					end
					task.wait(0.1)
				until not al.Enabled
			else
				table.clear(ao)
				table.clear(ap)
				table.clear(ar)
			end
		end,
		Tooltip = 'Automatically places TNT around enemy TNT'
	}
	am = al:CreateSlider{
		Name = 'TNT Count',
		Min = 1,
		Max = 5,
		Default = 3
	}
	an = al:CreateToggle{
		Name = 'Limit to TNT',
		Default = true,
		Tooltip = 'Only works when holding TNT'
	}
end)
a(function()
	local al, am
	local function isEveryoneDead()
		return # O.Store:getState().Party.members <= 0
	end
	local function joinQueue()
		if not O.Store:getState().Game.customMatch and O.Store:getState().Party.leader.userId == t.UserId and O.Store:getState().Party.queueState == 0 then
			if am.Enabled then
				local an = {}
				for ao, ap in O.QueueMeta do
					if not ap.disabled and not ap.voiceChatOnly and not ap.rankCategory then
						table.insert(an, ao)
					end
				end
				O.QueueController:joinQueue(an[math.random(1, # an)])
			else
				O.QueueController:joinQueue(L.queueType)
			end
		end
	end
	al = v.Categories.Utility:CreateModule{
		Name = 'Auto Play',
		Function = function(an)
			if an then
				al:Clean(b.EntityDeathEvent.Event:Connect(function(ao)
					if ao.finalKill and ao.entityInstance == t.Character and isEveryoneDead() and L.matchState ~= 2 then
						joinQueue()
					end
				end))
				al:Clean(b.MatchEndEvent.Event:Connect(joinQueue))
			end
		end,
		Tooltip = 'Automatically queues after the match ends.'
	}
	am = al:CreateToggle{
		Name = 'Random',
		Tooltip = 'Chooses a random mode'
	}
end)
a(function()
	local al, am, an, ao, ap, aq = {}, {}
	an = v.Categories.Utility:CreateModule{
		Name = 'ProximityExtender',
		Function = function(ar)
			if ar then
				table.clear(al)
				table.clear(am)
				local function applyToPrompt(at)
					if not at:IsA'ProximityPrompt' then
						return
					end
					if am[at] then
						return
					end
					am[at] = true
					al[at] = at.MaxActivationDistance
					at.MaxActivationDistance = ao.Value
				end
				local function scanForPrompts(at)
					for au, av in ipairs(at:GetDescendants()) do
						if av:IsA'ProximityPrompt' then
							applyToPrompt(av)
						end
					end
				end
				scanForPrompts(workspace)
				ap = workspace.DescendantAdded:Connect(function(at)
					if at:IsA'ProximityPrompt' then
						applyToPrompt(at)
					end
				end)
				aq = workspace.DescendantRemoving:Connect(function(at)
					if at:IsA'ProximityPrompt' then
						al[at] = nil
						am[at] = nil
					end
				end)
				ao.Function = function(at)
					for au in pairs(am) do
						if au and au.Parent then
							au.MaxActivationDistance = at
						end
					end
				end
			else
				if ap then
					ap:Disconnect()
					ap = nil
				end
				if aq then
					aq:Disconnect()
					aq = nil
				end
				for at, au in pairs(al) do
					if at and at.Parent then
						pcall(function()
							at.MaxActivationDistance = au
						end)
					end
				end
				table.clear(al)
				table.clear(am)
				ao.Function = function()
				end
			end
		end,
		Tooltip = 'Increases the MaxActivationDistance for all ProximityPrompts in the game'
	}
	ao = an:CreateSlider{
		Name = 'Max Distance',
		Min = 10,
		Max = 20,
		Default = 20,
		Tooltip = 'Control the distance it extends'
	}
end)
a(function()
	local al, am, an, ao, ap = {
		iron = nil,
		diamond = nil,
		emerald = nil,
		gold = nil
	}, false, 0
	ao = v.Categories.Utility:CreateModule{
		Name = 'AutoDeathDrop',
		Function = function(aq)
			if aq then
				am = false
				an = 0
				local ar = B.character.Humanoid.HealthChanged:Connect(function(ar)
					if not ao.Enabled then
						return
					end
					if not B.isAlive then
						am = false
						return
					end
					local at = tick()
					if (at - an) < 0.1 then
						return
					end
					an = at
					local au = B.character.Humanoid.MaxHealth
					local av = (ar / au) * 100
					if av <= ap.Value and not am then
						am = true
						for aw, ax in pairs(al) do
							if ax.Enabled then
								local ay = getItem(aw)
								if ay then
									local az = O.Client:Get(P.DropItem):CallServer{
										item = ay.tool,
										amount = ay.amount
									}
									if az then
										az:SetAttribute('ClientDropTime', tick() + 100)
									end
								end
							end
						end
					elseif av > ap.Value then
						am = false
					end
				end)
				ao:Clean(ar)
			else
				am = false
			end
		end,
		Tooltip = 'Drops resources when health is low to prevent enemies from getting them'
	}
	ap = ao:CreateSlider{
		Name = 'Health Threshold',
		Min = 1,
		Max = 50,
		Suffix = '%',
		Default = 20,
		Tooltip = 'Drop items when health reaches this percentage'
	}
	al.iron = ao:CreateToggle{
		Name = 'Drop Iron',
		Tooltip = 'Drop iron when health is low',
		Default = true
	}
	al.diamond = ao:CreateToggle{
		Name = 'Drop Diamond',
		Tooltip = 'Drop diamonds when health is low',
		Default = true
	}
	al.emerald = ao:CreateToggle{
		Name = 'Drop Emerald',
		Tooltip = 'Drop emeralds when health is low',
		Default = true
	}
	al.gold = ao:CreateToggle{
		Name = 'Drop Gold',
		Tooltip = 'Drop gold when health is low',
		Default = true
	}
end)
a(function()
	local al, am, an, ao = {
		iron = nil,
		diamond = nil,
		emerald = nil,
		gold = nil
	}
	am = v.Categories.Utility:CreateModule{
		Name = 'AutoVoidDrop',
		Function = function(ap)
			if ap then
				repeat
					task.wait()
				until L.matchState ~= 0 or (not am.Enabled)
				if not am.Enabled then
					return
				end
				ao = math.huge
				for aq, ar in pairs(L.blocks) do
					local at = (ar.Position.Y - (ar.Size.Y / 2)) - 50
					if at < ao then
						ao = at
					end
				end
				repeat
					if B.isAlive then
						local aq = B.character.RootPart
						if aq.Position.Y < ao and (t.Character:GetAttribute'InflatedBalloons' or 0) <= 0 and not getItem'balloon' then
							if not an.Enabled or not aq:FindFirstChild'OwlLiftForce' then
								for ar, at in pairs(al) do
									if at.Enabled then
										local au = getItem(ar)
										if au then
											local av = O.Client:Get(P.DropItem):CallServer{
												item = au.tool,
												amount = au.amount
											}
											if av then
												av:SetAttribute('ClientDropTime', tick() + 100)
											end
										end
									end
								end
								break
							end
						end
					end
					task.wait(0.1)
				until not am.Enabled
			end
		end,
		Tooltip = 'Drops resources when you fall into the void'
	}
	an = am:CreateToggle{
		Name = 'Owl check',
		Default = true,
		Tooltip = 'Refuses to drop items if being picked up by an owl'
	}
	al.iron = am:CreateToggle{
		Name = 'Drop Iron',
		Tooltip = 'Drop iron when falling into void',
		Default = true
	}
	al.diamond = am:CreateToggle{
		Name = 'Drop Diamond',
		Tooltip = 'Drop diamonds when falling into void',
		Default = true
	}
	al.emerald = am:CreateToggle{
		Name = 'Drop Emerald',
		Tooltip = 'Drop emeralds when falling into void',
		Default = true
	}
	al.gold = am:CreateToggle{
		Name = 'Drop Gold',
		Tooltip = 'Drop gold when falling into void',
		Default = true
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at = 0
	am = v.Categories.Utility:CreateModule{
		Name = 'PickupRange',
		Function = function(au)
			if au then
				local av, aw = collection('ItemDrop', am), an.Value * an.Value
				if ar.Enabled then
					task.spawn(function()
						repeat
							if B.isAlive then
								local ax = B.character.RootPart.Position
								for ay, az in av do
									if tick() - (az:GetAttribute'ClientDropTime' or 0) < 0.1 then
										continue
									end
									task.spawn(function()
										task.wait(at.Value)
										if O and O.Client and P.PickupItem then
											O.Client:Get(P.PickupItem):CallServerAsync{
												itemDrop = az
											}:andThen(function(aA)
												if aA and O.SoundList then
													O.SoundManager:playSound(O.SoundList.PICKUP_ITEM_DROP)
													local aB = O.ItemMeta[az.Name]
													if aB then
														local aC = aB.pickUpOverlaySound
														if aC then
															O.SoundManager:playSound(aC, {
																position = az.Position,
																volumeMultiplier = 0.9
															})
														end
													end
												end
											end)
										end
									end)
								end
							end
							task.wait(0.05)
						until not am.Enabled or not ar.Enabled
					end)
				end
				repeat
					if B.isAlive then
						local ax, ay, az, aA = B.character.RootPart.Position, B.character.Humanoid.Health, tick(), aq.Value / 1000
						aw = an.Value * an.Value
						for aB, aC in pairs(av) do
							if (az - (aC:GetAttribute'ClientDropTime' or 0)) < 2 then
								continue
							end
							if (az - al) < aA then
								continue
							end
							if r(aC) and ap.Enabled and ay > 0 then
								aC.CFrame = CFrame.new(ax - Vector3.new(0, 3, 0))
							end
							local aD = aC.Position - ax
							local aE = aD.X * aD.X + aD.Y * aD.Y + aD.Z * aD.Z
							if aE <= aw then
								if ao.Enabled and (ax.Y - aC.Position.Y) < (B.character.HipHeight - 1) then
									continue
								end
								O.Client:Get(P.PickupItem):CallServerAsync{
									itemDrop = aC
								}:andThen(function(aF)
									if aF then
										al = tick()
										if O.SoundList then
											O.SoundManager:playSound(O.SoundList.PICKUP_ITEM_DROP)
											local aG = O.ItemMeta[aC.Name]
											if aG then
												local aH = aG.pickUpOverlaySound
												if aH then
													O.SoundManager:playSound(aH, {
														position = aC.Position,
														volumeMultiplier = 0.9
													})
												end
											end
										end
									end
								end)
							end
						end
					end
					task.wait(0.1)
				until not am.Enabled
			else
				al = 0
			end
		end,
		Tooltip = 'Picks up items from a farther distance'
	}
	an = am:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 10,
		Default = 10,
		Suffix = function(au)
			return au == 1 and 'stud' or 'studs'
		end
	}
	ap = am:CreateToggle{
		Name = 'Network TP',
		Default = true
	}
	aq = am:CreateSlider{
		Name = 'Pickup Delay',
		Min = 0,
		Max = 500,
		Default = 0,
		Tooltip = 'Delay between picking up items (milliseconds)',
		Suffix = 'ms'
	}
	ao = am:CreateToggle{
		Name = 'Feet Check'
	}
	ar = am:CreateToggle{
		Name = 'Fast Pickup',
		Default = false,
		Tooltip = 'Instantly picks up all loot in range',
		Function = function(au)
			if at and at.Object then
				at.Object.Visible = au
			end
		end
	}
	at = am:CreateSlider{
		Name = 'Fast Pickup Delay',
		Min = 0,
		Max = 0.5,
		Default = 0.05,
		Decimal = 100,
		Suffix = 's',
		Tooltip = 'Delay before fast picking up items',
		Visible = false
	}
	task.defer(function()
		if at and at.Object then
			at.Object.Visible = false
		end
	end)
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw = {}, Vector3.zero, 0
	for ax = - 3, 3, 3 do
		for ay = - 3, 3, 3 do
			for az = - 3, 3, 3 do
				local aA = Vector3.new(ax, ay, az)
				if aA ~= Vector3.zero then
					table.insert(al, aA)
				end
			end
		end
	end
	local function nearCorner(ax, ay)
		local az, aA, aB = ax - Vector3.new(3, 3, 3), ax + Vector3.new(3, 3, 3), ax + (ay - ax).Unit * 100
		return Vector3.new(math.clamp(aB.X, az.X, aA.X), math.clamp(aB.Y, az.Y, aA.Y), math.clamp(aB.Z, az.Z, aA.Z))
	end
	local function blockProximity(ax)
		local ay, az = 60
		local aA = getBlocksInPoints(O.BlockController:getBlockPosition(ax - Vector3.new(21, 21, 21)), O.BlockController:getBlockPosition(ax + Vector3.new(21, 21, 21)))
		for aB, aC in aA do
			local aD = nearCorner(aC, ax)
			local aE = (ax - aD).Magnitude
			if aE < ay then
				ay, az = aE, aD
			end
		end
		table.clear(aA)
		return az
	end
	local function checkAdjacent(ax)
		for ay, az in al do
			if getPlacedBlock(ax + az) then
				return true
			end
		end
		return false
	end
	local function getScaffoldBlock()
		if L.hand.toolType == 'block' then
			return L.hand.tool.Name, L.hand.amount
		elseif (not au.Enabled) then
			local ax = L.hand.toolType == 'sword' or (L.hand.tool and O.ItemMeta[L.hand.tool.Name].sword)
			if not ax then
				local ay, az = getWool()
				if ay then
					return ay, az
				else
					for aA, aB in L.inventory.inventory.items do
						if O.ItemMeta[aB.itemType].block then
							return aB.itemType, aB.amount
						end
					end
				end
			end
		end
		return nil, 0
	end
	ao = v.Categories.Utility:CreateModule{
		Name = 'Scaffold',
		Function = function(ax)
			if ax then
				an = 0
				repeat
					if B.isAlive then
						local ay = getScaffoldBlock()
						if av.Enabled then
							if not h:IsMouseButtonPressed(0) then
								ay = nil
							end
						end
						if ay then
							local az = B.character.RootPart
							if aq.Enabled and h:IsKeyDown(Enum.KeyCode.Space) and (not h:GetFocusedTextBox()) then
								az.Velocity = Vector3.new(az.Velocity.X, 38, az.Velocity.Z)
							end
							for aA = ap.Value, 1, - 1 do
								local aB = roundPos(az.Position - Vector3.new(0, B.character.HipHeight + (ar.Enabled and h:IsKeyDown(Enum.KeyCode.LeftShift) and 4.5 or 1.5), 0) + B.character.Humanoid.MoveDirection * (aA * 3))
								if at.Enabled then
									if math.abs(math.round(math.deg(math.atan2(- B.character.Humanoid.MoveDirection.X, - B.character.Humanoid.MoveDirection.Z)) / 45) * 45) % 90 == 45 then
										local aC = (am - aB)
										if ((aC.X == 0 and aC.Z ~= 0) or (aC.X ~= 0 and aC.Z == 0)) and ((am - az.Position) * Vector3.new(1, 0, 1)).Magnitude < 2.5 then
											aB = am
										end
									end
								end
								local aC, aD = getPlacedBlock(aB)
								if not aC then
									if tick() - an >= (aw.Value / 1000) then
										aD = checkAdjacent(aD * 3) and aD * 3 or blockProximity(aB)
										if aD then
											task.spawn(O.placeBlock, aD, ay, false)
											an = tick()
										end
									end
								end
								am = aB
							end
						end
					end
					task.wait(0.03)
				until not ao.Enabled
			else
				an = 0
			end
		end,
		Tooltip = 'Helps you make bridges/scaffold walk.'
	}
	ap = ao:CreateSlider{
		Name = 'Expand',
		Min = 1,
		Max = 6
	}
	aq = ao:CreateToggle{
		Name = 'Tower',
		Default = true
	}
	ar = ao:CreateToggle{
		Name = 'Downwards',
		Default = true
	}
	at = ao:CreateToggle{
		Name = 'Diagonal',
		Default = true
	}
	au = ao:CreateToggle{
		Name = 'Limit to items'
	}
	av = ao:CreateToggle{
		Name = 'Require mouse down'
	}
	aw = ao:CreateSlider{
		Name = 'Place Delay',
		Min = 0,
		Max = 200,
		Default = 0,
		Tooltip = 'Delay between block placements (milliseconds)',
		Suffix = 'ms'
	}
end)
a(function()
	local al, am, an, ao, ap = {}, {}, {}
	local function applyBypassToItem(aq)
		if aq and type(aq) == 'table' then
			if not al[aq] then
				al[aq] = aq.tiered
			end
			if not am[aq] then
				am[aq] = aq.nextTier
			end
			aq.nextTier = nil
			aq.tiered = nil
			an[aq] = true
		end
	end
	local function applyBypassToTable(aq)
		if aq and type(aq) == 'table' then
			for ar, at in pairs(aq) do
				if type(at) == 'table' then
					applyBypassToItem(at)
				end
			end
		end
	end
	local function getShopController()
		local aq, ar = pcall(function()
			local aq = require(game:GetService'ReplicatedStorage':WaitForChild'rbxts_include':WaitForChild'RuntimeLib')
			if aq then
				return aq.import(script, game:GetService'ReplicatedStorage', 'TS', 'games', 'bedwars', 'shop', 'bedwars-shop')
			end
		end)
		if aq then
			return ar
		end
		local at = game:GetService'ReplicatedStorage':FindFirstChild'TS':FindFirstChild'games':FindFirstChild'bedwars':FindFirstChild'shop':FindFirstChild'bedwars-shop'
		if at and at:IsA'ModuleScript' then
			return require(at)
		end
		return nil
	end
	ao = v.Categories.Utility:CreateModule{
		Name = 'ShopTierBypass',
		Function = function(aq)
			if aq then
				local function collectAndBypass()
					local ar = {}
					if O.Shop and O.Shop.ShopItems then
						for at, au in pairs(O.Shop.ShopItems) do
							ar[au] = true
						end
					end
					if O.ShopItems then
						for at, au in pairs(O.ShopItems) do
							ar[au] = true
						end
					end
					local at = getShopController()
					if at and at.BedwarsShop and at.BedwarsShop.getShop then
						local au = at.BedwarsShop.getShop()
						if type(au) == 'table' then
							for av, aw in pairs(au) do
								ar[aw] = true
							end
						end
					end
					for au, av in pairs(ar) do
						applyBypassToItem(au)
					end
				end
				collectAndBypass()
				if O.Shop and O.Shop.getShop and not ap then
					ap = O.Shop.getShop
					O.Shop.getShop = function(...)
						local ar = ap(...)
						if type(ar) == 'table' then
							applyBypassToTable(ar)
						end
						return ar
					end
				end
				local ar = getShopController()
				if ar and ar.BedwarsShop and ar.BedwarsShop.getShop then
					if not al.shopControllerHooked then
						al.shopControllerHooked = true
						local at = ar.BedwarsShop.getShop
						ar.BedwarsShop.getShop = function(...)
							local au = at(...)
							if type(au) == 'table' then
								applyBypassToTable(au)
							end
							return au
						end
					end
				end
			else
				for ar, at in pairs(an) do
					if ar and type(ar) == 'table' then
						if al[ar] ~= nil then
							ar.tiered = al[ar]
						end
						if am[ar] ~= nil then
							ar.nextTier = am[ar]
						end
					end
				end
				if al.shopControllerHooked then
					al.shopControllerHooked = nil
				end
				if ap then
					O.Shop.getShop = ap
					ap = nil
				end
				table.clear(al)
				table.clear(am)
				table.clear(an)
			end
		end,
		Tooltip = 'Lets you buy things like armor and tools early.'
	}
end)
a(function()
	v.Categories.World:CreateModule{
		Name = 'AntiAFK',
		Function = function(al)
			if al then
				pcall(function()
					for am, an in getconnections(t.Idled) do
						an:Disconnect()
					end
				end)
				pcall(function()
					for am, an in getconnections(g.Heartbeat) do
						if type(an.Function) == 'function' then
							local ao = debug.getconstants(an.Function)
							if ao and table.find(ao, P.AfkStatus) then
								an:Disconnect()
							end
						end
					end
				end)
				pcall(function()
					local am = O.Client:Get(P.AfkStatus)
					if am then
						am:SendToServer{
							afk = false
						}
					end
				end)
			end
		end,
		Tooltip = 'Lets you stay ingame without getting kicked'
	}
end)
a(function()
	local al, am
	local function getScaffoldBlock()
		if am.Enabled then
			if L.hand.toolType == 'block' then
				return L.hand.tool.Name
			end
			return nil
		else
			local an = getWool()
			if an then
				return an
			else
				for ao, ap in L.inventory.inventory.items do
					if O.ItemMeta[ap.itemType].block then
						return ap.itemType
					end
				end
			end
		end
		return nil
	end
	local function canPlaceAtPosition(an)
		if not checkFaceAdjacent(an) then
			return false
		end
		local ao, ap = an - Vector3.new(0, 3, 0), false
		for aq = 1, 10 do
			if getPlacedBlock(ao) then
				ap = true
				break
			end
			ao = ao - Vector3.new(0, 3, 0)
		end
		return ap or hasFaceBelowOrSide(an)
	end
	al = v.Categories.World:CreateModule{
		Name = 'AutoBuildUp',
		Function = function(an)
			if an then
				repeat
					if B.isAlive then
						local ao = getScaffoldBlock()
						if ao then
							local ap = B.character.RootPart
							if h:IsKeyDown(Enum.KeyCode.Space) and (not h:GetFocusedTextBox()) then
								local aq = roundPos(ap.Position - Vector3.new(0, B.character.HipHeight + 1.5, 0))
								local ar, at = getPlacedBlock(aq)
								if not ar then
									at = at * 3
									if hasFaceBelowOrSide(at) then
										if canPlaceAtPosition(at) then
											task.spawn(O.placeBlock, at, ao, false)
										end
									else
										local au = blockProximity(aq)
										if au and canPlaceAtPosition(au) then
											task.spawn(O.placeBlock, au, ao, false)
										end
									end
								end
							end
						end
					end
					task.wait(0.03)
				until not al.Enabled
			end
		end,
		Tooltip = 'Automatically places blocks under you ONLY when jumping (no corner connections)'
	}
	am = al:CreateToggle{
		Name = 'Limit to items',
		Default = false,
		Tooltip = 'Only place blocks when holding a block item'
	}
end)
a(function()
	local al, am, an
	local function getScaffoldBlock()
		if am.Enabled then
			if L.hand.toolType == 'block' then
				return L.hand.tool.Name
			end
			return nil
		else
			local ao = getWool()
			if ao then
				return ao
			else
				for ap, aq in L.inventory.inventory.items do
					if O.ItemMeta[aq.itemType].block then
						return aq.itemType
					end
				end
			end
		end
		return nil
	end
	al = v.Categories.World:CreateModule{
		Name = 'AutoBuildStraight',
		Function = function(ao)
			if ao then
				repeat
					if B.isAlive then
						local ap = getScaffoldBlock()
						if ap then
							local aq, ar = B.character.RootPart, B.character.Humanoid
							if ar.MoveDirection.Magnitude > 0.1 then
								local at = s.CFrame.LookVector
								local au, av = Vector3.new(at.X, 0, at.Z).Unit, aq.Position - Vector3.new(0, B.character.HipHeight + 1.5, 0)
								for aw = 3, an.Value, 3 do
									local ax = av + (au * aw)
									local ay = roundPos(ax)
									local az, aA = getPlacedBlock(ay)
									if not az then
										aA = aA * 3
										if checkFaceAdjacent(aA) then
											task.spawn(O.placeBlock, aA, ap, false)
											break
										end
									end
								end
							end
						end
					end
					task.wait(0.05)
				until not al.Enabled
			end
		end,
		Tooltip = 'Automatically extends blocks straight ahead when moving'
	}
	an = al:CreateSlider{
		Name = 'Range',
		Min = 3,
		Max = 30,
		Default = 12,
		Tooltip = 'Maximum distance ahead to place blocks'
	}
	am = al:CreateToggle{
		Name = 'Limit to items',
		Default = false,
		Tooltip = 'Only place blocks when holding a block item'
	}
end)
a(function()
	local al, am, an, ao = false
	local function hotbarSwitchItem(ap)
		if ap and not ap:GetAttribute'NoBreak' and not ap:GetAttribute('Team' .. (t:GetAttribute'Team' or 0) .. 'NoBreak') then
			local aq = O.ItemMeta[ap.Name]
			if not aq or not aq.block then
				return false
			end
			local ar, at = (L.tools[aq.block.breakType])
			if ar then
				for au, av in L.inventory.hotbar do
					if av.item and av.item.itemType == ar.itemType then
						at = au - 1
						break
					end
				end
				if hotbarSwitch(at) then
					if ao and (h:IsMouseButtonPressed(0) or al) then
						ao:Fire()
					end
					return true
				end
			end
		end
	end
	am = v.Categories.World:CreateModule{
		Name = 'AutoTool',
		Function = function(ap)
			if ap then
				if not O.BlockBreaker or not O.BlockBreaker.hitBlock then
					warn'autoTool: bedwars.BlockBreaker not ready skipping ts hook'
					return
				end
				ao = Instance.new'BindableEvent'
				am:Clean(ao)
				am:Clean(ao.Event:Connect(function()
					pcall(function()
						m:CallFunction('block-break', Enum.UserInputState.Begin, newproxy(true))
					end)
				end))
				am:Clean(h.InputBegan:Connect(function(aq)
					if aq.UserInputType == Enum.UserInputType.Touch then
						al = true
					end
				end))
				am:Clean(h.InputEnded:Connect(function(aq)
					if aq.UserInputType == Enum.UserInputType.Touch then
						al = false
					end
				end))
				if not an then
					an = O.BlockBreaker.hitBlock
				end
				O.BlockBreaker.hitBlock = function(aq, ar, at, ...)
					local au
					pcall(function()
						local av = aq.clientManager:getBlockSelector():getMouseInfo(1, {
							ray = at
						})
						au = av and av.target and av.target.blockInstance or nil
					end)
					local av = false
					pcall(function()
						av = hotbarSwitchItem(au)
					end)
					if av then
						return
					end
					if an then
						local aw, ax = pcall(an, aq, ar, at, ...)
						if aw then
							return ax
						end
					end
				end
			else
				if an and O.BlockBreaker then
					O.BlockBreaker.hitBlock = an
				end
				an = nil
				al = false
			end
		end,
		Tooltip = 'Automatically selects the correct tool'
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw = 12, false, {}
	local function initCPS()
		pcall(function()
			av = require(f.TS['shared-constants']).CpsConstants
		end)
		if not av then
			pcall(function()
				av = O.CpsConstants
			end)
		end
		if av then
			al = av.BLOCK_PLACE_CPS
		end
	end
	local function setCPS(ax)
		if av then
			av.BLOCK_PLACE_CPS = ax
		end
	end
	local function getSpeedCPS()
		if ap.Value == 'Fast' then
			return 50
		elseif ap.Value == 'Medium' then
			return 35
		else
			return 75
		end
	end
	local function getBedNear()
		if not B.isAlive then
			return nil
		end
		local ax = B.character.RootPart.Position
		for ay, az in l:GetTagged'bed' do
			local aA = 'Team' .. (t:GetAttribute'Team' or - 1) .. 'NoBreak'
			if (ax - az.Position).Magnitude < 30 and az:GetAttribute(aA) then
				return az
			end
		end
		return nil
	end
	local function getHotbarSlotForBlock(ax)
		if not ax then
			return nil
		end
		for ay, az in pairs(L.inventory.hotbar) do
			if az.item and az.item.tool == ax then
				return ay - 1
			end
		end
		return nil
	end
	local function isValidBlock(ax)
		if not ax then
			return false
		end
		local ay = ax:lower()
		if ay:find'tnt' or ay:find'explosive' or ay:find'spawn' or ay:find'egg' or ay:find'bed' or ay:find'potion' then
			return false
		end
		local az = {
			'wool',
			'stone',
			'plank',
			'wood',
			'brick',
			'ceramic',
			'obsidian',
			'glass',
			'sandstone'
		}
		for aA, aB in ipairs(az) do
			if ay:find(aB) then
				return true
			end
		end
		return false
	end
	local function getBlocks()
		local ax = {}
		for ay, az in pairs(L.inventory.inventory.items) do
			if O.ItemMeta[az.itemType] and O.ItemMeta[az.itemType].block then
				if isValidBlock(az.itemType) then
					local aA, aB = O.ItemMeta[az.itemType], getHotbarSlotForBlock(az.tool) ~= nil
					table.insert(ax, {
						itemType = az.itemType,
						health = aA.block.health or 0,
						tool = az.tool,
						inHotbar = aB
					})
				end
			end
		end
		table.sort(ax, function(ay, az)
			return ay.health > az.health
		end)
		if at.Enabled then
			local ay = {}
			for az, aA in ipairs(ax) do
				if aA.inHotbar then
					table.insert(ay, aA)
				end
			end
			return ay
		end
		return ax
	end
	local function switchToBlock(ax)
		if not at.Enabled or not ax then
			return false
		end
		local ay = getHotbarSlotForBlock(ax)
		if ay then
			local az = pcall(function()
				hotbarSwitch(ay)
			end)
			if az then
				task.wait(0.05)
				return true
			end
		end
		return false
	end
	local function detectBedOrientation(ax)
		if not ax then
			return nil
		end
		local ay, az, aA = ax.Position, 'Team' .. (t:GetAttribute'Team' or - 1) .. 'NoBreak', {
			Vector3.new(3, 0, 0),
			Vector3.new(- 3, 0, 0),
			Vector3.new(0, 0, 3),
			Vector3.new(0, 0, - 3)
		}
		for aB, aC in ipairs(aA) do
			local aD = ay + aC
			local aE = getPlacedBlock(aD)
			if aE and aE:GetAttribute(az) and aE.Name == 'bed' then
				if math.abs(aC.X) > 0 then
					return {
						axis = 'X',
						direction = aC
					}
				else
					return {
						axis = 'Z',
						direction = aC
					}
				end
			end
		end
		return {
			axis = 'X',
			direction = Vector3.new(3, 0, 0)
		}
	end
	local function getBedPositions(ax, ay)
		local az = ax.Position
		local aA = az + ay.direction
		return {
			az,
			aA
		}
	end
	local function getPyramidPositions(ax)
		local ay, az = {}, ax + 1
		for aA = - az, az do
			for aB = 0, ax do
				for aC = - az, az do
					if aB <= ax then
						local aD = math.abs(aA) + math.abs(aC) + math.abs(aB)
						if aD <= az and aB <= ax then
							table.insert(ay, Vector3.new(aA, aB, aC) * 3)
						end
					end
				end
			end
		end
		return ay
	end
	local function placeBlockAt(ax, ay, az)
		if not ax or not ay then
			return false
		end
		if getPlacedBlock(ax) then
			return false
		end
		if at.Enabled and ar.Enabled then
			switchToBlock(az)
		end
		local aA = pcall(function()
			O.placeBlock(ax, ay, false)
		end)
		if aA then
			an[ax] = {
				blockType = ay,
				placed = tick()
			}
		end
		return aA
	end
	local function executeProtection()
		if am then
			return
		end
		am = true
		aw = task.spawn(function()
			local ax = getBedNear()
			if not ax then
				notif('bedprotector', 'cannot find your bed', 3)
				am = false
				ao:Toggle()
				return
			end
			if ar.Enabled and not at.Enabled then
				if not (L.hand and L.hand.toolType == 'block') then
					notif('bedprotector', 'hold a block to use hand check', 3)
					am = false
					ao:Toggle()
					return
				end
			end
			local ay = detectBedOrientation(ax)
			local az, aA = getBedPositions(ax, ay), getSpeedCPS()
			local aB = 1 / aA
			setCPS(aA)
			an = {}
			notif('bedprotector', 'bed orientation: ' .. ay.axis, 2)
			local aC = 0
			for aD = 0, aq.Value - 1 do
				if not ao.Enabled then
					break
				end
				local aE = getBlocks()
				if # aE == 0 then
					notif('bedprotector', 'no valid blocks in inventory', 3)
					break
				end
				local aF
				if au.Enabled then
					aF = 1
				else
					aF = # aE
				end
				if aD > 0 and au.Enabled then
					aF = math.min(aD + 1, # aE)
				elseif aD > 0 and not au.Enabled then
					aF = math.max(# aE - aD, 1)
				end
				local aG = aE[aF]
				local aH = O.ItemMeta[aG.itemType].displayName or aG.itemType
				notif('bedprotector', 'layer ' .. (aD + 1) .. ': ' .. aH, 1.5)
				local aI, aJ = getPyramidPositions(aD), 0
				for aK, aL in ipairs(az) do
					if not ao.Enabled then
						break
					end
					for aM, aN in ipairs(aI) do
						if not ao.Enabled then
							break
						end
						local aO = aL + aN
						if not getPlacedBlock(aO) then
							local aP = placeBlockAt(aO, aG.itemType, aG.tool)
							if aP then
								aJ = aJ + 1
								aC = aC + 1
							end
							task.wait(aB)
						end
					end
				end
				if aJ > 0 then
					notif('bedprotector', 'layer ' .. (aD + 1) .. ': ' .. aJ .. ' blocks', 1.5)
				end
			end
			setCPS(al)
			am = false
			if ao.Enabled and aC > 0 then
				notif('bedprotector', 'placed ' .. aC .. ' blocks around bed', 3)
				ao:Toggle()
			elseif ao.Enabled then
				notif('bedprotector', 'no blocks placed - check inventory', 3)
				ao:Toggle()
			end
		end)
	end
	ao = v.Categories.World:CreateModule{
		Name = 'BedProtector',
		Function = function(ax)
			if ax then
				initCPS()
				executeProtection()
			else
				am = false
				if aw then
					pcall(function()
						task.cancel(aw)
					end)
					aw = nil
				end
				setCPS(al)
				an = {}
			end
		end,
		Tooltip = 'Automatically protects your bed with pyramid layers'
	}
	ap = ao:CreateDropdown{
		Name = 'Speed',
		List = {
			'Medium',
			'Fast',
			'Super Fast'
		},
		Default = 'Fast',
		Tooltip = 'Block placement speed\nMedium: 35 CPS\nFast: 50 CPS\nSuper Fast: 75 CPS',
		Function = function(ax)
			if ao.Enabled then
				setCPS(getSpeedCPS())
			end
		end
	}
	aq = ao:CreateSlider{
		Name = 'Layers',
		Min = 1,
		Max = 5,
		Default = 3,
		Tooltip = 'Number of pyramid layers around bed',
		Function = function()
		end
	}
	au = ao:CreateToggle{
		Name = 'Strongest First',
		Default = true,
		Tooltip = 'Layer 1: Strongest block\nLayer 2: 2nd strongest\nLayer 3: 3rd strongest\netc.',
		Function = function()
		end
	}
	ar = ao:CreateToggle{
		Name = 'Hand Check',
		Default = false,
		Tooltip = 'Only place blocks when holding a block',
		Function = function(ax)
			if at and at.Object then
				at.Object.Visible = ax
			end
		end
	}
	at = ao:CreateToggle{
		Name = 'Auto Switch',
		Default = true,
		Visible = false,
		Tooltip = 'Automatically switch to blocks in hotbar',
		Function = function()
		end
	}
	task.defer(function()
		if at and at.Object then
			at.Object.Visible = false
		end
	end)
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at = {}
	local function isTeamChest(au)
		if not at.Enabled then
			return false
		end
		local av, aw = au:GetAttribute'Team', t:GetAttribute'Team'
		return av and aw and av == aw
	end
	local function lootChest(au)
		au = au and au.Value or nil
		if not au then
			return
		end
		if isTeamChest(au) then
			return
		end
		local av = au and au:GetChildren() or {}
		if # av > 1 and (al[au] or 0) < tick() then
			al[au] = tick() + (aq.Enabled and ar.Value or 0.2)
			O.Client:GetNamespace'Inventory':Get'SetObservedChest':SendToServer(au)
			for aw, ax in av do
				if ax:IsA'Accessory' then
					if aq.Enabled then
						task.wait(ar.Value / # av)
					end
					task.spawn(function()
						pcall(function()
							O.Client:GetNamespace'Inventory':Get'ChestGetItem':CallServer(au, ax)
						end)
					end)
				end
			end
			O.Client:GetNamespace'Inventory':Get'SetObservedChest':SendToServer(nil)
		end
	end
	am = v.Categories.World:CreateModule{
		Name = 'ChestSteal',
		Function = function(au)
			if au then
				local av = collection('chest', am)
				repeat
					task.wait()
				until L.queueType ~= 'bedwars_test'
				if (not ap.Enabled) or L.queueType:find'skywars' then
					repeat
						if B.isAlive and L.matchState ~= 2 then
							if ao.Enabled then
								if O.AppController:isAppOpen'ChestApp' then
									lootChest(t.Character:FindFirstChild'ObservedChestFolder')
								end
							else
								local aw = B.character.RootPart.Position
								for ax, ay in av do
									if (aw - ay.Position).Magnitude <= an.Value then
										lootChest(ay:FindFirstChild'ChestFolderValue')
									end
								end
							end
						end
						task.wait(0.1)
					until not am.Enabled
				end
			end
		end,
		Tooltip = 'Grabs items from near chests.'
	}
	an = am:CreateSlider{
		Name = 'Range',
		Min = 0,
		Max = 18,
		Default = 18,
		Suffix = function(au)
			return au == 1 and 'stud' or 'studs'
		end
	}
	ao = am:CreateToggle{
		Name = 'GUI Check'
	}
	ap = am:CreateToggle{
		Name = 'Only Skywars',
		Function = function()
			if am.Enabled then
				am:Toggle()
				am:Toggle()
			end
		end,
		Default = true
	}
	at = am:CreateToggle{
		Name = 'Team Chest Filter',
		Tooltip = "Avoid stealing from your own team's chests",
		Default = false
	}
	aq = am:CreateToggle{
		Name = 'Delay',
		Function = function(au)
			ar.Object.Visible = au
			if am.Enabled then
				am:Toggle()
				am:Toggle()
			end
		end
	}
	ar = am:CreateSlider{
		Name = 'Delay Time',
		Min = 0.1,
		Max = 5,
		Default = 1,
		Decimal = 10,
		Suffix = 's',
		Visible = false
	}
	task.defer(function()
		if ar and ar.Object then
			ar.Object.Visible = false
		end
	end)
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw, ax, ay, az = {}, {
		iron = nil,
		diamond = nil,
		emerald = nil
	}, 0, 0, {}
	local function addItem(aA, aB)
		local aC = Instance.new'ImageLabel'
		aC.Image = O.getIcon({
			itemType = aA
		}, true)
		aC.Size = UDim2.fromOffset(32, 32)
		aC.Name = aA
		aC.BackgroundTransparency = 1
		aC.LayoutOrder = # au:GetChildren()
		aC.Parent = au
		local aD = Instance.new'TextLabel'
		aD.Name = 'Amount'
		aD.Size = UDim2.fromScale(1, 1)
		aD.BackgroundTransparency = 1
		aD.Text = ''
		aD.TextColor3 = Color3.new(1, 1, 1)
		aD.TextSize = 16
		aD.TextStrokeTransparency = 0.3
		aD.Font = Enum.Font.Arial
		aD.Parent = aC
		al[aA] = {
			Object = aD,
			Type = aB
		}
	end
	local function refreshBank(aA)
		for aB, aC in pairs(al) do
			local aD = aA:FindFirstChild(aB)
			aC.Object.Text = aD and aD:GetAttribute'Amount' or ''
		end
	end
	local function nearChest()
		if not B.isAlive then
			return false
		end
		local aA, aB = B.character.RootPart.Position, 484
		for aC, aD in pairs(av) do
			if aD.Parent then
				local aE = aD.Position - aA
				local aF = aE.X * aE.X + aE.Y * aE.Y + aE.Z * aE.Z
				if aF < aB then
					return true
				end
			end
		end
		return false
	end
	local function isEnemyChest(aA)
		if not az.Enabled then
			return true
		end
		local aB, aC = aA:GetAttribute'Team', t:GetAttribute'Team'
		if not aB or not aC then
			return true
		end
		return aB ~= aC
	end
	local function handleState()
		local aA = tick()
		if not aw or not aw.Parent or (aA - an) > 1 then
			aw = f.Inventories:FindFirstChild(t.Name .. '_personal')
			an = aA
		end
		if not aw then
			return
		end
		if not nearChest() and not at.Enabled then
			return
		end
		local aB = {}
		for aC, aD in ipairs(L.inventory.inventory.items) do
			local aE = al[aD.itemType]
			if aE and am[aD.itemType] and am[aD.itemType].Enabled then
				table.insert(aB, aD)
			end
		end
		if # aB > 0 then
			for aC, aD in ipairs(aB) do
				O.Client:GetNamespace'Inventory':Get'ChestGiveItem':CallServer(aw, aD.tool)
			end
			task.defer(function()
				if aw and aw.Parent then
					refreshBank(aw)
				end
			end)
		end
	end
	local function handleLootBank(aA)
		if not ax.Enabled then
			return
		end
		if not B.isAlive then
			return
		end
		if not aw or not aw.Parent then
			return
		end
		local aB, aC = B.character.RootPart.Position, ay.Value
		for aD, aE in ipairs(aA) do
			if (aB - aE.Position).Magnitude <= 18 then
				local aF = aE:FindFirstChild'ChestFolderValue'
				local aG = aF and aF.Value or nil
				if not aG then
					continue
				end
				if not isEnemyChest(aE) then
					continue
				end
				local aH = aG:GetChildren()
				if # aH <= 1 then
					continue
				end
				if (ap[aG] or 0) >= tick() then
					continue
				end
				ap[aG] = tick() + aC
				O.Client:GetNamespace'Inventory':Get'SetObservedChest':SendToServer(aG)
				task.wait(0.05)
				for aI, aJ in ipairs(aH) do
					if aJ:IsA'Accessory' then
						pcall(function()
							O.Client:GetNamespace'Inventory':Get'ChestGetItem':CallServer(aG, aJ)
						end)
						task.wait(0.05)
						pcall(function()
							O.Client:GetNamespace'Inventory':Get'ChestGiveItem':CallServer(aw, aJ)
						end)
					end
				end
				O.Client:GetNamespace'Inventory':Get'SetObservedChest':SendToServer(nil)
				task.defer(function()
					if aw and aw.Parent then
						refreshBank(aw)
					end
				end)
			end
		end
	end
	aq = v.Categories.Inventory:CreateModule{
		Name = 'AutoBank',
		Function = function(aA)
			if aA then
				av = collection('chest', aq)
				aw = nil
				an = 0
				ao = 0
				table.clear(ap)
				au = Instance.new'Frame'
				au.Size = UDim2.new(1, 0, 0, 32)
				au.Position = UDim2.fromOffset(0, - 240)
				au.BackgroundTransparency = 1
				au.Visible = ar.Enabled
				au.Parent = v.gui
				aq:Clean(au)
				local aB = Instance.new'UIListLayout'
				aB.FillDirection = Enum.FillDirection.Horizontal
				aB.HorizontalAlignment = Enum.HorizontalAlignment.Center
				aB.SortOrder = Enum.SortOrder.LayoutOrder
				aB.Parent = au
				addItem('iron', true)
				addItem('diamond', false)
				addItem('emerald', true)
				local aC, aD = (n:GetGuiInset().Y)
				repeat
					local aE = tick()
					if (aE - ao) > 0.5 then
						local aF = t.PlayerGui
						if aF then
							local aG = aF:FindFirstChild'hotbar'
							if aG then
								local aH = aG['1']:FindFirstChild'HotbarHealthbarContainer'
								if aH then
									aD = aH
									au.Position = UDim2.fromOffset(0, (aH.AbsolutePosition.Y + aC) - 40)
									ao = aE
								end
							end
						end
					end
					local aF = false
					if at.Enabled then
						aF = O.AppController:isAppOpen'ChestApp' or O.AppController:isAppOpen'BedwarsAppIds.CHEST_INVENTORY'
					else
						aF = nearChest()
					end
					if aF then
						handleState()
					end
					if ax.Enabled then
						handleLootBank(av)
					end
					task.wait(0.1)
				until (not aq.Enabled)
			else
				table.clear(al)
				table.clear(ap)
				aw = nil
			end
		end,
		Tooltip = 'automatically puts resources in ender chest'
	}
	ar = aq:CreateToggle{
		Name = 'UI',
		Function = function(aA)
			if aq.Enabled and au then
				au.Visible = aA
			end
		end,
		Default = true
	}
	at = aq:CreateToggle{
		Name = 'GUI Check',
		Tooltip = 'only banks when chest is open (bypasses distance limit)'
	}
	am.iron = aq:CreateToggle{
		Name = 'Bank Iron',
		Tooltip = 'auto bank iron',
		Default = true
	}
	am.diamond = aq:CreateToggle{
		Name = 'Bank Diamond',
		Tooltip = 'auto bank diamonds',
		Default = true
	}
	am.emerald = aq:CreateToggle{
		Name = 'Bank Emerald',
		Tooltip = 'auto bank emeralds',
		Default = true
	}
	ax = aq:CreateToggle{
		Name = 'Rob',
		Tooltip = 'takes loot from enemy chests nearby and sends it straight to ur bank',
		Function = function(aA)
			if ay then
				ay.Object.Visible = aA
			end
			if az then
				az.Object.Visible = aA
			end
			if not aA then
				table.clear(ap)
			end
		end,
		Default = false
	}
	ay = aq:CreateSlider{
		Name = 'Rob Delay',
		Min = 0.1,
		Max = 5,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'cooldown per chest so u dont spam it',
		Visible = false
	}
	az = aq:CreateToggle{
		Name = 'Skip Team Chests',
		Tooltip = 'never rob ur own team fr',
		Default = true,
		Visible = false
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw = 12, false, {
		Vector3.new(3, 0, 0),
		Vector3.new(- 3, 0, 0),
		Vector3.new(0, 3, 0),
		Vector3.new(0, - 3, 0),
		Vector3.new(0, 0, 3),
		Vector3.new(0, 0, - 3)
	}
	local function checkFaceAdjacent(ax)
		for ay, az in an do
			if getPlacedBlock(ax + az) then
				return true
			end
		end
		return false
	end
	local function hasFaceBelowOrSide(ax)
		if getPlacedBlock(ax - Vector3.new(0, 3, 0)) then
			return true
		end
		for ay, az in an do
			if az.Y == 0 and getPlacedBlock(ax + az) then
				return true
			end
		end
		return false
	end
	local function nearCorner(ax, ay)
		local az, aA, aB = ax - Vector3.new(3, 3, 3), ax + Vector3.new(3, 3, 3), ax + (ay - ax).Unit * 100
		return Vector3.new(math.clamp(aB.X, az.X, aA.X), math.clamp(aB.Y, az.Y, aA.Y), math.clamp(aB.Z, az.Z, aA.Z))
	end
	local function blockProximity(ax)
		local ay, az = 60
		local aA = getBlocksInPoints(O.BlockController:getBlockPosition(ax - Vector3.new(21, 21, 21)), O.BlockController:getBlockPosition(ax + Vector3.new(21, 21, 21)))
		for aB, aC in aA do
			local aD = nearCorner(aC, ax)
			local aE = (ax - aD).Magnitude
			if hasFaceBelowOrSide(aD) and aE < ay then
				ay, az = aE, aD
			end
		end
		table.clear(aA)
		return az
	end
	local function canPlaceAtPosition(ax)
		if not checkFaceAdjacent(ax) then
			return false
		end
		local ay, az = ax - Vector3.new(0, 3, 0), false
		for aA = 1, 10 do
			if getPlacedBlock(ay) then
				az = true
				break
			end
			ay = ay - Vector3.new(0, 3, 0)
		end
		return az or hasFaceBelowOrSide(ax)
	end
	local function initCPS()
		pcall(function()
			av = require(f.TS['shared-constants']).CpsConstants
		end)
		if not av then
			pcall(function()
				av = O.CpsConstants
			end)
		end
		if av then
			al = av.BLOCK_PLACE_CPS
		end
	end
	local function setCPS(ax)
		if av then
			av.BLOCK_PLACE_CPS = ax
		end
	end
	local function getBlocks()
		local ax = {}
		for ay, az in pairs(L.inventory.inventory.items) do
			if O.ItemMeta[az.itemType] and O.ItemMeta[az.itemType].block then
				local aA = O.ItemMeta[az.itemType]
				table.insert(ax, {
					itemType = az.itemType,
					health = aA.block.health or 0,
					tool = az.tool
				})
			end
		end
		table.sort(ax, function(ay, az)
			return ay.health > az.health
		end)
		return ax
	end
	local function getHotbarSlotForBlock(ax)
		for ay, az in pairs(L.inventory.hotbar) do
			if az.item and az.item.tool == ax then
				return ay - 1
			end
		end
		return nil
	end
	local function hasBlockAt(ax)
		local ay = getPlacedBlock(ax)
		return ay ~= nil
	end
	local function getScaffoldBlock()
		if at.Enabled then
			if L.hand and L.hand.toolType == 'block' then
				return L.hand.tool.Name
			end
			return nil
		else
			local ax = getBlocks()
			if # ax == 0 then
				return nil
			end
			if au.Enabled then
				return ax[1].itemType
			else
				local ay, az = (math.huge)
				for aA, aB in ipairs(ax) do
					local aC = getHotbarSlotForBlock(aB.tool)
					if aC then
						if aB.health < ay then
							ay = aB.health
							az = aB
						end
					end
				end
				if az then
					return az.itemType
				else
					return ax[1].itemType
				end
			end
		end
	end
	local function findGaps(ax)
		local ay, az = {}, {
			Vector3.new(3, 0, 0),
			Vector3.new(- 3, 0, 0),
			Vector3.new(0, 3, 0),
			Vector3.new(0, - 3, 0),
			Vector3.new(0, 0, 3),
			Vector3.new(0, 0, - 3),
			Vector3.new(3, 3, 0),
			Vector3.new(- 3, 3, 0),
			Vector3.new(0, 3, 3),
			Vector3.new(0, 3, - 3),
			Vector3.new(0, 6, 0)
		}
		for aA, aB in ipairs(az) do
			local aC = ax + aB
			if not hasBlockAt(aC) then
				table.insert(ay, aC)
			end
		end
		return ay
	end
	local function hasMovedSignificantly(ax, ay)
		local az = (ax - ay).Magnitude
		return az > 2
	end
	local function executeBlockIn()
		if am then
			return
		end
		am = true
		aw = task.spawn(function()
			while ao.Enabled and am do
				if not B.isAlive then
					notif('BlockIn', 'Not alive', 2)
					am = false
					ao:Toggle()
					return
				end
				local ax = getScaffoldBlock()
				if not ax then
					task.wait(0.1)
					continue
				end
				setCPS(ap.Value)
				local ay = B.character.RootPart.Position
				local az = findGaps(ay)
				if # az == 0 then
					if ar.Enabled and not at.Enabled then
						pcall(function()
							hotbarSwitch(L.inventory.hotbarSlot)
						end)
					end
					setCPS(al)
					am = false
					task.wait(0.1)
					if ao.Enabled then
						ao:Toggle()
					end
					return
				end
				local aA, aB = L.inventory.hotbarSlot, aq.Value / 1000
				local function restoreSlot()
					if ar.Enabled and not at.Enabled and aA then
						pcall(function()
							hotbarSwitch(aA)
						end)
					end
				end
				if ar.Enabled and not at.Enabled then
					local aC = getBlocks()
					if # aC > 0 then
						local aD
						if au.Enabled then
							aD = aC[1]
						else
							local aE, aF = (math.huge)
							for aG, aH in ipairs(aC) do
								local aI = getHotbarSlotForBlock(aH.tool)
								if aI then
									if aH.health < aE then
										aE = aH.health
										aF = aH
									end
								end
							end
							aD = aF or aC[1]
						end
						if aD then
							local aE = getHotbarSlotForBlock(aD.tool)
							if aE then
								hotbarSwitch(aE)
								task.wait(0.05)
							end
						end
					end
				end
				for aC, aD in ipairs(az) do
					if not ao.Enabled or not am then
						break
					end
					local aE = getScaffoldBlock()
					if not aE then
						break
					end
					if not B.isAlive then
						break
					end
					local aF = B.character.RootPart.Position
					if hasMovedSignificantly(ay, aF) then
					end
					if not hasBlockAt(aD) then
						if hasFaceBelowOrSide(aD) then
							if canPlaceAtPosition(aD) then
								pcall(O.placeBlock, aD, aE, false)
							end
						else
							local aG = blockProximity(aD)
							if aG and canPlaceAtPosition(aG) then
								pcall(O.placeBlock, aG, aE, false)
							end
						end
					end
					if aC < # az then
						task.wait(aB)
					end
				end
				restoreSlot()
				task.wait(0.1)
			end
			restoreSlot()
			setCPS(al)
			am = false
		end)
	end
	ao = v.Categories.Utility:CreateModule{
		Name = 'BlockIn',
		Function = function(ax)
			if ax then
				initCPS()
				executeBlockIn()
			else
				am = false
				if aw then
					pcall(function()
						task.cancel(aw)
					end)
					aw = nil
				end
				setCPS(al)
			end
		end,
		Tooltip = 'Surrounds you with blocks (real-time gap detection)'
	}
	ap = ao:CreateSlider{
		Name = 'Speed',
		Min = 1,
		Max = 12,
		Default = 12,
		Suffix = ' CPS',
		Function = function(ax)
			if ao.Enabled then
				setCPS(ax)
			end
		end,
		Tooltip = 'Block placement speed'
	}
	aq = ao:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 200,
		Default = 50,
		Suffix = 'ms',
		Function = function(ax)
		end,
		Tooltip = 'Delay between blocks'
	}
	ar = ao:CreateToggle{
		Name = 'Auto Switch',
		Default = true,
		Function = function(ax)
		end,
		Tooltip = 'Auto switch to blocks'
	}
	at = ao:CreateToggle{
		Name = 'Hand Check',
		Default = false,
		Function = function(ax)
		end,
		Tooltip = 'Only build when holding block'
	}
	au = ao:CreateToggle{
		Name = 'Strongest Only',
		Default = false,
		Function = function(ax)
		end,
		Tooltip = 'Use strongest block only (obsidian)'
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw, ax, ay = {}, {}, {}, {}
	local az, aA, aB, aC, aD, aE = {
		al,
		ao,
		am
	}, tick(), {
		'wood_sword',
		'stone_sword',
		'iron_sword',
		'diamond_sword',
		'emerald_sword'
	}, {
		'none',
		'leather_chestplate',
		'iron_chestplate',
		'diamond_chestplate',
		'emerald_chestplate'
	}, {
		'none',
		'wood_axe',
		'stone_axe',
		'iron_axe',
		'diamond_axe'
	}, {
		'none',
		'wood_pickaxe',
		'stone_pickaxe',
		'iron_pickaxe',
		'diamond_pickaxe'
	}
	local function getShopNPC()
		local aF, aG, aH, aI = false, false
		if B.isAlive then
			local aJ = B.character.RootPart.Position
			for aK, aL in L.shop do
				if (aL.RootPart.Position - aJ).Magnitude <= 20 then
					aH = aL.Upgrades or aL.Shop or nil
					aG = aG or aL.Upgrades
					aF = aF or aL.Shop
					aI = aL.Shop and aL.Id or aI
				end
			end
		end
		return aH, aF, aG, aI
	end
	local function canBuy(aF, aG, aH)
		aH = aH or 1
		if not aG[aF.currency] then
			local aI = getItem(aF.currency)
			aG[aF.currency] = aI and aI.amount or 0
		end
		if aF.ignoredByKit and table.find(aF.ignoredByKit, L.equippedKit or '') then
			return false
		end
		if aF.lockedByForge or aF.disabled then
			return false
		end
		if aF.require and aF.require.teamUpgrade then
			if (O.Store:getState().Bedwars.teamUpgrades[aF.require.teamUpgrade.upgradeId] or - 1) < aF.require.teamUpgrade.lowestTierIndex then
				return false
			end
		end
		return aG[aF.currency] >= (aF.price * aH)
	end
	local function buyItem(aF, aG)
		if not ap then
			return
		end
		notif('AutoBuy', 'Bought ' .. O.ItemMeta[aF.itemType].displayName, 3)
		O.Client:Get(P.BedwarsPurchaseItem):CallServerAsync{
			shopItem = aF,
			shopId = ap
		}:andThen(function(aH)
			if aH then
				O.SoundManager:playSound(O.SoundList.BEDWARS_PURCHASE_ITEM)
				O.Store:dispatch{
					type = 'BedwarsAddItemPurchased',
					itemType = aF.itemType
				}
			end
		end)
		aG[aF.currency] -= aF.price
	end
	local function buyUpgrade(aF, aG)
		if not au.Enabled then
			return
		end
		local aH, aI = O.TeamUpgradeMeta[aF], O.Store:getState().Bedwars.teamUpgrades[t:GetAttribute'Team'] or {}
		local aJ, aK = (aI[aF] or 0) + 1, false
		for aL = aJ, # aH.tiers do
			local aM = aH.tiers[aL]
			if aM.availableOnlyInQueue and not table.find(aM.availableOnlyInQueue, L.queueType) then
				continue
			end
			if canBuy({
				currency = 'diamond',
				price = aM.cost
			}, aG) then
				notif('AutoBuy', 'Bought ' .. (aH.name == 'Armor' and 'Protection' or aH.name) .. ' ' .. aL, 3)
				O.Client:Get'RequestPurchaseTeamUpgrade':CallServerAsync(aF)
				aG.diamond -= aM.cost
				aK = true
			else
				break
			end
		end
		return aK
	end
	local function buyTool(aF, aG, aH)
		local aI, aJ = false
		aF = aF and table.find(aG, aF.itemType) and table.find(aG, aF.itemType) + 1 or math.huge
		for aK = aF, # aG do
			local aL = O.Shop.getShopItem(aG[aK], t)
			if canBuy(aL, aH) then
				if ay.Enabled and O.ItemMeta[aG[aK] ].breakBlock and aK > 2 then
					if at.Enabled then
						local aM = L.inventory.inventory.armor[2]
						aM = aM and aM ~= 'empty' and aM.itemType or 'none'
						if (table.find(aC, aM) or 3) < 3 then
							break
						end
					end
					if ar.Enabled then
						if L.tools.sword and (table.find(aB, L.tools.sword.itemType) or 2) < 2 then
							break
						end
					end
				end
				aI = true
				aJ = aL
			end
			if av.Enabled and aL.nextTier then
				break
			end
		end
		if aJ then
			buyItem(aJ, aH)
		end
		return aI
	end
	aq = v.Categories.Inventory:CreateModule{
		Name = 'AutoBuy',
		Function = function(aF)
			if aF then
				repeat
					task.wait()
				until L.queueType ~= 'bedwars_test'
				if aw.Enabled and not L.queueType:find'bedwars' then
					return
				end
				local aG
				aq:Clean(b.InventoryAmountChanged.Event:Connect(function()
					if (aA - tick()) > 1 then
						aA = tick()
					end
				end))
				repeat
					local aH, aI, aJ, aK = getShopNPC()
					ap = aK
					if ax.Enabled then
						if not (O.AppController:isAppOpen'BedwarsItemShopApp' or O.AppController:isAppOpen'TeamUpgradeApp') then
							aH = nil
						end
					end
					if aH and aG ~= aJ then
						if (aA - tick()) > 1 then
							aA = tick()
						end
						aG = aJ
					end
					if aH and aA <= tick() and L.matchState ~= 2 and L.shopLoaded then
						local aL, aM = {}
						for aN, aO in az do
							for aP, aQ in aO do
								if aQ(aL, aI, aJ) then
									aM = true
								end
							end
						end
						aA = tick() + (aM and 0.4 or math.huge)
					end
					task.wait(0.1)
				until not aq.Enabled
			else
				aA = tick()
			end
		end,
		Tooltip = 'Automatically buys items when you go near the shop'
	}
	ar = aq:CreateToggle{
		Name = 'Buy Sword',
		Function = function(aF)
			aA = tick()
			ao[2] = aF and function(aG, aH)
				if not aH then
					return
				end
				if L.equippedKit == 'dasher' then
					aB = {
						[1] = 'wood_dao',
						[2] = 'stone_dao',
						[3] = 'iron_dao',
						[4] = 'diamond_dao',
						[5] = 'emerald_dao'
					}
				elseif L.equippedKit == 'ice_queen' then
					aB[5] = 'ice_sword'
				elseif L.equippedKit == 'ember' then
					aB[5] = 'infernal_saber'
				elseif L.equippedKit == 'lumen' then
					aB[5] = 'light_sword'
				end
				return buyTool(L.tools.sword, aB, aG)
			end or nil
		end
	}
	at = aq:CreateToggle{
		Name = 'Buy Armor',
		Function = function(aF)
			aA = tick()
			ao[1] = aF and function(aG, aH)
				if not aH then
					return
				end
				local aI = L.inventory.inventory.armor[2] ~= 'empty' and L.inventory.inventory.armor[2] or getBestArmor(1)
				aI = aI and aI.itemType or 'none'
				return buyTool({
					itemType = aI
				}, aC, aG)
			end or nil
		end,
		Default = true
	}
	aq:CreateToggle{
		Name = 'Buy Axe',
		Function = function(aF)
			aA = tick()
			ao[3] = aF and function(aG, aH)
				if not aH then
					return
				end
				return buyTool(L.tools.wood or {
					itemType = 'none'
				}, aD, aG)
			end or nil
		end
	}
	aq:CreateToggle{
		Name = 'Buy Pickaxe',
		Function = function(aF)
			aA = tick()
			ao[4] = aF and function(aG, aH)
				if not aH then
					return
				end
				return buyTool(L.tools.stone, aE, aG)
			end or nil
		end
	}
	au = aq:CreateToggle{
		Name = 'Buy Upgrades',
		Function = function(aF)
			for aG, aH in an do
				aH.Object.Visible = aF
			end
		end,
		Default = true
	}
	local aF = 0
	for aG, aH in O.TeamUpgradeMeta do
		local aI = aF
		table.insert(an, aq:CreateToggle{
			Name = 'Buy ' .. (aH.name == 'Armor' and 'Protection' or aH.name),
			Function = function(aJ)
				aA = tick()
				ao[5 + aI + (aH.name == 'Armor' and 20 or 0)] = aJ and function(aK, aL, aM)
					if not aM then
						return
					end
					if aH.disabledInQueue and table.find(aH.disabledInQueue, L.queueType) then
						return
					end
					return buyUpgrade(aG, aK)
				end or nil
			end,
			Darker = true,
			Default = (aG == 'ARMOR' or aG == 'DAMAGE')
		})
		aF += 1
	end
	av = aq:CreateToggle{
		Name = 'Tier Check'
	}
	aw = aq:CreateToggle{
		Name = 'Only Bedwars',
		Function = function()
			if aq.Enabled then
				aq:Toggle()
				aq:Toggle()
			end
		end,
		Default = true
	}
	ax = aq:CreateToggle{
		Name = 'GUI check'
	}
	ay = aq:CreateToggle{
		Name = 'Smart check',
		Default = true,
		Tooltip = 'Buys iron armor before iron axe'
	}
	local aG = aq:CreateToggle{
		Name = 'Keep Buying',
		Tooltip = 'Always buys the set amount from item list, ignoring current inventory',
		Function = function(aG)
			if aG then
				aA = tick()
			end
		end
	}
	aq:CreateTextList{
		Name = 'Item',
		Placeholder = 'priority/item/amount/skip50',
		Function = function(aH)
			table.clear(al)
			table.clear(am)
			for aI, aJ in aH do
				local aK = aJ:split'/'
				local aL = tonumber(aK[1])
				if aL then
					local aM, aN = aK[4] and aK[4]:lower():find'after', aK[4] and tonumber(aK[4]:match'%d+') or nil
					(aM and am or al)[aL] = function(aO, aP)
						if not aP then
							return
						end
						if not L.shopLoaded then
							return
						end
						local aQ, aR = pcall(function()
							return O.Shop.getShopItem(aK[2], t)
						end)
						if not aQ or not aR then
							return false
						end
						local aS = getItem(aK[2] == 'wool_white' and O.Shop.getTeamWool(t:GetAttribute'Team') or aK[2])
						local aT, aU = aS and aS.amount or 0, tonumber(aK[3])
						if aK[2] == 'arrow' and aN then
							local aV, aW, aX = getBow(), getItem'crossbow', getItem'headhunter_bow'
							if not (aV or aW or aX) then
								return false
							end
						end
						if aG.Enabled then
							local aV = math.ceil(aU / aR.amount)
							if aV > 0 and canBuy(aR, aO, aV) then
								for aW = 1, aV do
									buyItem(aR, aO)
								end
								return true
							end
						else
							local aV = math.max(0, aU - aT)
							if aV <= 0 then
								return false
							end
							if aN and aT >= aN then
								return false
							end
							local aW = math.ceil(aV / aR.amount)
							if canBuy(aR, aO, aW) then
								for aX = 1, aW do
									buyItem(aR, aO)
								end
								return true
							end
						end
						return false
					end
				end
			end
		end
	}
end)
a(function()
	local al, am, an, ao, ap
	local function consumeCheck(aq)
		if B.isAlive then
			if an.Enabled and (not aq or aq == 'StatusEffect_speed') then
				local ar = getItem'speed_potion'
				if ar and (not t.Character:GetAttribute'StatusEffect_speed') then
					for at = 1, 4 do
						if O.Client:Get(P.ConsumeItem):CallServer{
							item = ar.tool
						} then
							break
						end
					end
				end
			end
			if ao.Enabled and (not aq or aq:find'Health') then
				if (t.Character:GetAttribute'Health' / t.Character:GetAttribute'MaxHealth') <= (am.Value / 100) then
					local ar = getItem'orange' or (not t.Character:GetAttribute'StatusEffect_golden_apple' and getItem'golden_apple') or getItem'apple'
					if ar then
						O.Client:Get(P.ConsumeItem):CallServerAsync{
							item = ar.tool
						}
					end
				end
			end
			if ap.Enabled and (not aq or aq:find'Shield') then
				if (t.Character:GetAttribute'Shield_POTION' or 0) == 0 then
					local ar = getItem'big_shield' or getItem'mini_shield'
					if ar then
						O.Client:Get(P.ConsumeItem):CallServerAsync{
							item = ar.tool
						}
					end
				end
			end
		end
	end
	al = v.Categories.Inventory:CreateModule{
		Name = 'AutoConsume',
		Function = function(aq)
			if aq then
				al:Clean(b.InventoryAmountChanged.Event:Connect(consumeCheck))
				al:Clean(b.AttributeChanged.Event:Connect(function(ar)
					if ar:find'Shield' or ar:find'Health' or ar == 'StatusEffect_speed' then
						consumeCheck(ar)
					end
				end))
				consumeCheck()
			end
		end,
		Tooltip = 'Automatically heals for you when health or shield is under threshold.'
	}
	am = al:CreateSlider{
		Name = 'Health Percent',
		Min = 1,
		Max = 99,
		Default = 70,
		Suffix = '%'
	}
	an = al:CreateToggle{
		Name = 'Speed Potions',
		Default = true
	}
	ao = al:CreateToggle{
		Name = 'Apple',
		Default = true
	}
	ap = al:CreateToggle{
		Name = 'Shield Potions',
		Default = true
	}
end)
a(function()
	local al, am, an, ao, ap
	local function CreateWindow(aq)
		local ar, at = 1, Instance.new'Frame'
		at.Name = 'HotbarGUI'
		at.Size = UDim2.fromOffset(660, 465)
		at.Position = UDim2.fromScale(0.5, 0.5)
		at.BackgroundColor3 = E.Main
		at.AnchorPoint = Vector2.new(0.5, 0.5)
		at.Visible = false
		at.Parent = v.gui.ScaledGui
		local au = Instance.new'TextLabel'
		au.Name = 'Title'
		au.Size = UDim2.new(1, - 10, 0, 20)
		au.Position = UDim2.fromOffset(math.abs(au.Size.X.Offset), 12)
		au.BackgroundTransparency = 1
		au.Text = 'AutoHotbar'
		au.TextXAlignment = Enum.TextXAlignment.Left
		au.TextColor3 = E.Text
		au.TextSize = 13
		au.FontFace = E.Font
		au.Parent = at
		local av = Instance.new'Frame'
		av.Name = 'Divider'
		av.Size = UDim2.new(1, 0, 0, 1)
		av.Position = UDim2.fromOffset(0, 40)
		av.BackgroundColor3 = G.Light(E.Main, 0.04)
		av.BorderSizePixel = 0
		av.Parent = at
		addBlur(at)
		local aw = Instance.new'TextButton'
		aw.Text = ''
		aw.BackgroundTransparency = 1
		aw.Modal = true
		aw.Parent = at
		local ax = Instance.new'UICorner'
		ax.CornerRadius = UDim.new(0, 5)
		ax.Parent = at
		local ay = Instance.new'ImageButton'
		ay.Name = 'Close'
		ay.Size = UDim2.fromOffset(24, 24)
		ay.Position = UDim2.new(1, - 35, 0, 9)
		ay.BackgroundColor3 = Color3.new(1, 1, 1)
		ay.BackgroundTransparency = 1
		ay.Image = K'newvape/assets/new/close.png'
		ay.ImageColor3 = G.Light(E.Text, 0.2)
		ay.ImageTransparency = 0.5
		ay.AutoButtonColor = false
		ay.Parent = at
		ay.MouseEnter:Connect(function()
			ay.ImageTransparency = 0.3
			F:Tween(ay, TweenInfo.new(0.2), {
				BackgroundTransparency = 0.6
			})
		end)
		ay.MouseLeave:Connect(function()
			ay.ImageTransparency = 0.5
			F:Tween(ay, TweenInfo.new(0.2), {
				BackgroundTransparency = 1
			})
		end)
		ay.MouseButton1Click:Connect(function()
			at.Visible = false
			v.gui.ScaledGui.ClickGui.Visible = true
		end)
		local az = Instance.new'UICorner'
		az.CornerRadius = UDim.new(1, 0)
		az.Parent = ay
		local aA = Instance.new'Frame'
		aA.Size = UDim2.fromOffset(110, 111)
		aA.Position = UDim2.fromOffset(11, 71)
		aA.BackgroundColor3 = G.Dark(E.Main, 0.02)
		aA.Parent = at
		local aB = Instance.new'UICorner'
		aB.CornerRadius = UDim.new(0, 4)
		aB.Parent = aA
		local aC = Instance.new'UIStroke'
		aC.Color = G.Light(E.Main, 0.034)
		aC.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		aC.Parent = aA
		local aD = Instance.new'TextLabel'
		aD.Size = UDim2.fromOffset(80, 20)
		aD.Position = UDim2.fromOffset(25, 200)
		aD.BackgroundTransparency = 1
		aD.Text = 'SLOT 1'
		aD.TextColor3 = G.Dark(E.Text, 0.1)
		aD.TextSize = 12
		aD.FontFace = E.Font
		aD.Parent = at
		for aE = 1, 9 do
			local aF = Instance.new'TextButton'
			aF.Name = 'Slot' .. aE
			aF.Size = UDim2.fromOffset(51, 52)
			aF.Position = UDim2.fromOffset(89 + (aE * 55), 382)
			aF.BackgroundColor3 = G.Dark(E.Main, 0.02)
			aF.Text = ''
			aF.AutoButtonColor = false
			aF.Parent = at
			local aG = Instance.new'ImageLabel'
			aG.Size = UDim2.fromOffset(32, 32)
			aG.Position = UDim2.new(0.5, - 16, 0.5, - 16)
			aG.BackgroundTransparency = 1
			aG.Image = ''
			aG.Parent = aF
			local aH = Instance.new'UICorner'
			aH.CornerRadius = UDim.new(0, 4)
			aH.Parent = aF
			local aI = Instance.new'UIStroke'
			aI.Color = G.Light(E.Main, 0.04)
			aI.Thickness = 2
			aI.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			aI.Enabled = aE == ar
			aI.Parent = aF
			aF.MouseEnter:Connect(function()
				aF.BackgroundColor3 = G.Light(E.Main, 0.034)
			end)
			aF.MouseLeave:Connect(function()
				aF.BackgroundColor3 = G.Dark(E.Main, 0.02)
			end)
			aF.MouseButton1Click:Connect(function()
				at['Slot' .. ar].UIStroke.Enabled = false
				ar = aE
				aI.Enabled = true
				aD.Text = 'SLOT ' .. ar
			end)
			aF.MouseButton2Click:Connect(function()
				local aJ = aq.Hotbars[aq.Selected]
				if aJ then
					at['Slot' .. aE].ImageLabel.Image = ''
					aJ.Hotbar[tostring(aE)] = nil
					aJ.Object['Slot' .. aE].Image = '\t'
				end
			end)
		end
		local aE = Instance.new'Frame'
		aE.Size = UDim2.fromOffset(496, 31)
		aE.Position = UDim2.fromOffset(142, 80)
		aE.BackgroundColor3 = G.Light(E.Main, 0.034)
		aE.Parent = at
		local aF = Instance.new'TextBox'
		aF.Size = UDim2.new(1, - 10, 0, 31)
		aF.Position = UDim2.fromOffset(10, 0)
		aF.BackgroundTransparency = 1
		aF.Text = ''
		aF.PlaceholderText = ''
		aF.TextXAlignment = Enum.TextXAlignment.Left
		aF.TextColor3 = E.Text
		aF.TextSize = 12
		aF.FontFace = E.Font
		aF.ClearTextOnFocus = false
		aF.Parent = aE
		local aG = Instance.new'UICorner'
		aG.CornerRadius = UDim.new(0, 4)
		aG.Parent = aE
		local aH = Instance.new'ImageLabel'
		aH.Size = UDim2.fromOffset(14, 14)
		aH.Position = UDim2.new(1, - 26, 0, 8)
		aH.BackgroundTransparency = 1
		aH.Image = K'newvape/assets/new/search.png'
		aH.ImageColor3 = G.Light(E.Main, 0.37)
		aH.Parent = aE
		local aI = Instance.new'ScrollingFrame'
		aI.Name = 'Children'
		aI.Size = UDim2.fromOffset(500, 240)
		aI.Position = UDim2.fromOffset(144, 122)
		aI.BackgroundTransparency = 1
		aI.BorderSizePixel = 0
		aI.ScrollBarThickness = 2
		aI.ScrollBarImageTransparency = 0.75
		aI.CanvasSize = UDim2.new()
		aI.Parent = at
		local aJ = Instance.new'UIGridLayout'
		aJ.SortOrder = Enum.SortOrder.LayoutOrder
		aJ.FillDirectionMaxCells = 9
		aJ.CellSize = UDim2.fromOffset(51, 52)
		aJ.CellPadding = UDim2.fromOffset(4, 3)
		aJ.Parent = aI
		aJ:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
			safeCall(function()
				if v.ThreadFix then
					setthreadidentity(8)
				end
			end)
			aI.CanvasSize = UDim2.fromOffset(0, aJ.AbsoluteContentSize.Y / v.guiscale.Scale)
		end)
		table.insert(v.Windows, at)
		local function createitem(aK, aL)
			local aM = Instance.new'TextButton'
			aM.BackgroundColor3 = G.Light(E.Main, 0.02)
			aM.Text = ''
			aM.AutoButtonColor = false
			aM.Parent = aI
			local aN = Instance.new'ImageLabel'
			aN.Size = UDim2.fromOffset(32, 32)
			aN.Position = UDim2.new(0.5, - 16, 0.5, - 16)
			aN.BackgroundTransparency = 1
			aN.Image = aL
			aN.Parent = aM
			local aO = Instance.new'UICorner'
			aO.CornerRadius = UDim.new(0, 4)
			aO.Parent = aM
			aM.MouseEnter:Connect(function()
				aM.BackgroundColor3 = G.Light(E.Main, 0.04)
			end)
			aM.MouseLeave:Connect(function()
				aM.BackgroundColor3 = G.Light(E.Main, 0.02)
			end)
			aM.MouseButton1Click:Connect(function()
				local aP = aq.Hotbars[aq.Selected]
				if aP then
					at['Slot' .. ar].ImageLabel.Image = aL
					aP.Hotbar[tostring(ar)] = aK
					aP.Object['Slot' .. ar].Image = aL
				end
			end)
		end
		local function indexSearch(aK)
			for aL, aM in aI:GetChildren() do
				if aM:IsA'TextButton' then
					aM:ClearAllChildren()
					aM:Destroy()
				end
			end
			if aK == '' then
				for aL, aM in {
					'diamond_sword',
					'diamond_pickaxe',
					'diamond_axe',
					'shears',
					'wood_bow',
					'wool_white',
					'fireball',
					'apple',
					'iron',
					'gold',
					'diamond',
					'emerald'
				} do
					createitem(aM, O.ItemMeta[aM].image)
				end
				return
			end
			for aL, aM in O.ItemMeta do
				if aK:lower() == aL:lower():sub(1, aK:len()) then
					if not aM.image then
						continue
					end
					createitem(aL, aM.image)
				end
			end
		end
		aF:GetPropertyChangedSignal'Text':Connect(function()
			indexSearch(aF.Text)
		end)
		indexSearch''
		return at
	end
	v.Components.HotbarList = function(aq, ar, at)
		safeCall(function()
			if v.ThreadFix then
				setthreadidentity(8)
			end
		end)
		local au, av = {
			Type = 'HotbarList',
			Hotbars = {},
			Selected = 1
		}, Instance.new'TextButton'
		av.Name = 'HotbarList'
		av.Size = UDim2.fromOffset(220, 40)
		av.BackgroundColor3 = aq.Darker and (ar.BackgroundColor3 == G.Dark(E.Main, 0.02) and G.Dark(E.Main, 0.04) or G.Dark(E.Main, 0.02)) or ar.BackgroundColor3
		av.Text = ''
		av.BorderSizePixel = 0
		av.AutoButtonColor = false
		av.Parent = ar
		local aw = Instance.new'Frame'
		aw.Name = 'BKG'
		aw.Size = UDim2.new(1, - 20, 0, 31)
		aw.Position = UDim2.fromOffset(10, 4)
		aw.BackgroundColor3 = G.Light(E.Main, 0.034)
		aw.Parent = av
		local ax = Instance.new'UICorner'
		ax.CornerRadius = UDim.new(0, 4)
		ax.Parent = aw
		local ay = Instance.new'TextButton'
		ay.Name = 'HotbarList'
		ay.Size = UDim2.new(1, - 2, 1, - 2)
		ay.Position = UDim2.fromOffset(1, 1)
		ay.BackgroundColor3 = E.Main
		ay.Text = ''
		ay.AutoButtonColor = false
		ay.Parent = aw
		ay.MouseEnter:Connect(function()
			F:Tween(aw, TweenInfo.new(0.2), {
				BackgroundColor3 = G.Light(E.Main, 0.14)
			})
		end)
		ay.MouseLeave:Connect(function()
			F:Tween(aw, TweenInfo.new(0.2), {
				BackgroundColor3 = G.Light(E.Main, 0.034)
			})
		end)
		local az = Instance.new'UICorner'
		az.CornerRadius = UDim.new(0, 4)
		az.Parent = ay
		local aA = Instance.new'ImageLabel'
		aA.Size = UDim2.fromOffset(12, 12)
		aA.Position = UDim2.fromScale(0.5, 0.5)
		aA.AnchorPoint = Vector2.new(0.5, 0.5)
		aA.BackgroundTransparency = 1
		aA.Image = K'newvape/assets/new/add.png'
		aA.ImageColor3 = Color3.fromHSV(0.46, 0.96, 0.52)
		aA.Parent = ay
		local aB = Instance.new'Frame'
		aB.Size = UDim2.new(1, 0, 1, - 40)
		aB.Position = UDim2.fromOffset(0, 40)
		aB.BackgroundTransparency = 1
		aB.Parent = av
		local aC = Instance.new'UIListLayout'
		aC.SortOrder = Enum.SortOrder.LayoutOrder
		aC.HorizontalAlignment = Enum.HorizontalAlignment.Center
		aC.Padding = UDim.new(0, 3)
		aC.Parent = aB
		aC:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
			safeCall(function()
				if v.ThreadFix then
					setthreadidentity(8)
				end
			end)
			av.Size = UDim2.fromOffset(220, math.min(43 + aC.AbsoluteContentSize.Y / v.guiscale.Scale, 603))
		end)
		ay.MouseButton1Click:Connect(function()
			au:AddHotbar()
		end)
		au.Window = CreateWindow(au)
		function au.Save(aD, aE)
			local aF = {}
			for aG, aH in aD.Hotbars do
				table.insert(aF, aH.Hotbar)
			end
			aE.HotbarList = {
				Selected = aD.Selected,
				Hotbars = aF
			}
		end
		function au.Load(aD, aE)
			for aF, aG in aD.Hotbars do
				aG.Object:ClearAllChildren()
				aG.Object:Destroy()
				table.clear(aG.Hotbar)
			end
			table.clear(aD.Hotbars)
			for aF, aG in aE.Hotbars do
				aD:AddHotbar(aG)
			end
			aD.Selected = aE.Selected or 1
		end
		function au.AddHotbar(aD, aE)
			local aF = {
				Hotbar = aE or {}
			}
			table.insert(aD.Hotbars, aF)
			local aG = Instance.new'TextButton'
			aG.Size = UDim2.fromOffset(200, 27)
			aG.BackgroundColor3 = table.find(aD.Hotbars, aF) == aD.Selected and G.Light(E.Main, 0.034) or E.Main
			aG.Text = ''
			aG.AutoButtonColor = false
			aG.Parent = aB
			aF.Object = aG
			local aH = Instance.new'UICorner'
			aH.CornerRadius = UDim.new(0, 4)
			aH.Parent = aG
			for aI = 1, 9 do
				local aJ = Instance.new'ImageLabel'
				aJ.Name = 'Slot' .. aI
				aJ.Size = UDim2.fromOffset(17, 18)
				aJ.Position = UDim2.fromOffset(- 7 + (aI * 18), 5)
				aJ.BackgroundColor3 = G.Dark(E.Main, 0.02)
				aJ.Image = aF.Hotbar[tostring(aI)] and O.getIcon({
					itemType = aF.Hotbar[tostring(aI)]
				}, true) or ''
				aJ.BorderSizePixel = 0
				aJ.Parent = aG
			end
			aG.MouseButton1Click:Connect(function()
				local aI = table.find(au.Hotbars, aF)
				if aI == au.Selected then
					v.gui.ScaledGui.ClickGui.Visible = false
					au.Window.Visible = true
					for aJ = 1, 9 do
						au.Window['Slot' .. aJ].ImageLabel.Image = aF.Hotbar[tostring(aJ)] and O.getIcon({
							itemType = aF.Hotbar[tostring(aJ)]
						}, true) or ''
					end
				else
					if au.Hotbars[au.Selected] then
						au.Hotbars[au.Selected].Object.BackgroundColor3 = E.Main
					end
					aG.BackgroundColor3 = G.Light(E.Main, 0.034)
					au.Selected = aI
				end
			end)
			local aI = Instance.new'ImageButton'
			aI.Name = 'Close'
			aI.Size = UDim2.fromOffset(16, 16)
			aI.Position = UDim2.new(1, - 23, 0, 6)
			aI.BackgroundColor3 = Color3.new(1, 1, 1)
			aI.BackgroundTransparency = 1
			aI.Image = K'newvape/assets/new/closemini.png'
			aI.ImageColor3 = G.Light(E.Text, 0.2)
			aI.ImageTransparency = 0.5
			aI.AutoButtonColor = false
			aI.Parent = aG
			local aJ = Instance.new'UICorner'
			aJ.CornerRadius = UDim.new(1, 0)
			aJ.Parent = aI
			aI.MouseEnter:Connect(function()
				aI.ImageTransparency = 0.3
				F:Tween(aI, TweenInfo.new(0.2), {
					BackgroundTransparency = 0.6
				})
			end)
			aI.MouseLeave:Connect(function()
				aI.ImageTransparency = 0.5
				F:Tween(aI, TweenInfo.new(0.2), {
					BackgroundTransparency = 1
				})
			end)
			aI.MouseButton1Click:Connect(function()
				local aK, aL = table.find(aD.Hotbars, aF), aD.Hotbars[aD.Selected]
				local aM = aD.Hotbars[aK]
				if aL and aM then
					aM.Object:ClearAllChildren()
					aM.Object:Destroy()
					table.remove(aD.Hotbars, aK)
					aK = table.find(aD.Hotbars, aL)
					aD.Selected = table.find(aD.Hotbars, aL) or 1
				end
			end)
		end
		at.Options.HotbarList = au
		return au
	end
	local function getBlock()
		local aq = table.clone(L.inventory.inventory.items)
		table.sort(aq, function(ar, at)
			return ar.amount < at.amount
		end)
		for ar, at in aq do
			local au = O.ItemMeta[at.itemType].block
			if au and not au.seeThrough then
				return at
			end
		end
	end
	local function getCustomItem(aq)
		if aq == 'diamond_sword' then
			local ar = L.tools.sword
			aq = ar and ar.itemType or 'wood_sword'
		elseif aq == 'diamond_pickaxe' then
			local ar = L.tools.stone
			aq = ar and ar.itemType or 'wood_pickaxe'
		elseif aq == 'diamond_axe' then
			local ar = L.tools.wood
			aq = ar and ar.itemType or 'wood_axe'
		elseif aq == 'wood_bow' then
			local ar = getBow()
			aq = ar and ar.itemType or 'wood_bow'
		elseif aq == 'wool_white' then
			local ar = getBlock()
			aq = ar and ar.itemType or 'wool_white'
		end
		return aq
	end
	local function findItemInTable(aq, ar)
		for at, au in aq do
			if ar.itemType == getCustomItem(au) then
				return tonumber(at)
			end
		end
	end
	local function findInHotbar(aq)
		for ar, at in L.inventory.hotbar do
			if at.item and at.item.itemType == aq.itemType then
				return ar - 1, at.item
			end
		end
	end
	local function findInInventory(aq)
		for ar, at in L.inventory.inventory.items do
			if at.itemType == aq.itemType then
				return at
			end
		end
	end
	local function dispatch(...)
		O.Store:dispatch(...)
		b.InventoryChanged.Event:Wait()
	end
	local function sortCallback()
		if ap then
			return
		end
		ap = true
		local aq = (ao.Hotbars[ao.Selected] and ao.Hotbars[ao.Selected].Hotbar or {})
		for ar, at in L.inventory.inventory.items do
			local au = findItemInTable(aq, at)
			if au then
				local av = L.inventory.hotbar[au]
				if av.item and av.item.itemType == at.itemType then
					continue
				end
				if av.item then
					dispatch{
						type = 'InventoryRemoveFromHotbar',
						slot = au - 1
					}
				end
				local aw = findInHotbar(at)
				if aw then
					dispatch{
						type = 'InventoryRemoveFromHotbar',
						slot = aw
					}
					if av.item then
						dispatch{
							type = 'InventoryAddToHotbar',
							item = findInInventory(av.item),
							slot = aw
						}
					end
				end
				dispatch{
					type = 'InventoryAddToHotbar',
					item = findInInventory(at),
					slot = au - 1
				}
			elseif an.Enabled then
				local av = findInHotbar(at)
				if av then
					dispatch{
						type = 'InventoryRemoveFromHotbar',
						slot = av
					}
				end
			end
		end
		ap = false
	end
	al = v.Categories.Inventory:CreateModule{
		Name = 'AutoHotbar',
		Function = function(aq)
			if aq then
				task.spawn(sortCallback)
				if am.Value == 'On Key' then
					al:Toggle()
					return
				end
				al:Clean(b.InventoryAmountChanged.Event:Connect(sortCallback))
			end
		end,
		Tooltip = 'Automatically arranges hotbar to your liking.'
	}
	am = al:CreateDropdown{
		Name = 'Activation',
		List = {
			'Toggle',
			'On Key'
		},
		Function = function()
			if al.Enabled then
				al:Toggle()
				al:Toggle()
			end
		end
	}
	an = al:CreateToggle{
		Name = 'Clear Hotbar'
	}
	ao = al:CreateHotbarList{}
end)
a(function()
	local al, am, an
	local ao = v.Categories.Inventory:CreateModule{
		Name = 'FastConsume',
		Function = function(ao)
			if ao then
				am = O.ClickHold.startClick
				an = O.ClickHold.showProgress
				O.ClickHold.startClick = function(ap)
					ap.startedClickTime = tick()
					local aq, ar = ap:showProgress(), ap.startedClickTime
					O.RuntimeLib.Promise.defer(function()
						task.wait(ap.durationSeconds * (al.Value / 40))
						if aq == ap.handle and ar == ap.startedClickTime and ap.closeOnComplete then
							ap:hideProgress()
							if ap.onComplete then
								ap.onComplete()
							end
							if ap.onPartialComplete then
								ap.onPartialComplete(1)
							end
							ap.startedClickTime = - 1
						end
					end)
				end
				O.ClickHold.showProgress = function(ap)
					local aq = debug.getupvalue(an, 1)
					local ar = aq.mount(aq.createElement('ScreenGui', {}, {
						aq.createElement('Frame', {
							[aq.Ref] = ap.wrapperRef,
							Size = UDim2.new(),
							Position = UDim2.fromScale(0.5, 0.55),
							AnchorPoint = Vector2.new(0.5, 0),
							BackgroundColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 0.8
						}, {
							aq.createElement('Frame', {
								[aq.Ref] = ap.progressRef,
								Size = UDim2.fromScale(0, 1),
								BackgroundColor3 = Color3.new(1, 1, 1),
								BackgroundTransparency = 0.5
							})
						})
					}), t:FindFirstChild'PlayerGui')
					ap.handle = ar
					local at, au = i:Create(ap.wrapperRef:getValue(), TweenInfo.new(0.1), {
						Size = UDim2.fromScale(0.11, 0.005)
					}), i:Create(ap.progressRef:getValue(), TweenInfo.new(ap.durationSeconds * (al.Value / 40), Enum.EasingStyle.Linear), {
						Size = UDim2.fromScale(1, 1)
					})
					at:Play()
					au:Play()
					table.insert(ap.tweens, au)
					table.insert(ap.tweens, at)
					return ar
				end
			else
				O.ClickHold.startClick = am
				O.ClickHold.showProgress = an
				am = nil
				an = nil
			end
		end,
		Tooltip = 'Use/Consume items quicker.'
	}
	al = ao:CreateSlider{
		Name = 'Multiplier',
		Min = 0,
		Max = 100
	}
end)
a(function()
	local al, am, an, ao = 0
	am = v.Categories.Inventory:CreateModule{
		Name = 'FastDrop',
		Function = function(ap)
			if ap then
				al = 0
				repeat
					if B.isAlive and (not L.inventory.opened) and (h:IsKeyDown(Enum.KeyCode.H) or h:IsKeyDown(Enum.KeyCode.Backspace)) and h:GetFocusedTextBox() == nil then
						if tick() - al >= (an.Value / 1000) then
							local aq = L.hand and L.hand.tool
							if aq then
								local ar, at, au = aq.Name, ao.ListEnabled, true
								if # at > 0 then
									au = table.find(at, ar) ~= nil
								end
								if au then
									task.spawn(O.ItemDropController.dropItemInHand)
									al = tick()
								end
							end
							task.wait()
						else
							task.wait(0.01)
						end
					else
						task.wait(0.1)
					end
				until not am.Enabled
			else
				al = 0
			end
		end,
		Tooltip = 'Drops items fast'
	}
	an = am:CreateSlider{
		Name = 'Drop Delay',
		Min = 0,
		Max = 500,
		Default = 0,
		Tooltip = 'Delay between drops (milliseconds)',
		Suffix = 'ms'
	}
	ao = am:CreateTextList{
		Name = 'Item Whitelist',
		Placeholder = 'Item name (e.g., wool_blue)',
		Tooltip = 'Only drop these items (leave empty to drop all)\nUse item meta names like: wool_blue, iron, diamond'
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar = {}, {}, {}, (Instance.new'Folder')
	ao.Parent = v.gui
	local at = {
		[1] = {
			name = 'Blue',
			color = Color3.fromRGB(85, 150, 255)
		},
		[2] = {
			name = 'Orange',
			color = Color3.fromRGB(255, 150, 50)
		},
		[3] = {
			name = 'Pink',
			color = Color3.fromRGB(255, 100, 200)
		},
		[4] = {
			name = 'Yellow',
			color = Color3.fromRGB(255, 255, 50)
		}
	}
	local function getBedTeamColor(au)
		local av = au:GetAttribute'TeamID'
		if av and at[av] then
			return at[av]
		end
		return Color3.new(1, 1, 1)
	end
	local function scanSide(au, av, aw)
		for ax, ay in ipairs(Q) do
			for az = 1, 15 do
				local aA = getPlacedBlock(av + (ay * az))
				if not aA or aA == au then
					break
				end
				if not aA:GetAttribute'NoBreak' and not table.find(aw, aA.Name) then
					table.insert(aw, aA.Name)
				end
			end
		end
	end
	local function refreshAdornee(au)
		local av, aw = au.Adornee.Position, {}
		scanSide(au.Adornee, av, aw)
		scanSide(au.Adornee, av + Vector3.new(0, 0, 3), aw)
		table.sort(aw, function(ax, ay)
			local az, aA = O.ItemMeta[ax], O.ItemMeta[ay]
			local aB, aC = az and az.block and az.block.health or 0, aA and aA.block and aA.block.health or 0
			return aB > aC
		end)
		local ax = table.concat(aw, ',')
		if an[au] == ax then
			au.Enabled = # aw > 0
			return
		end
		an[au] = ax
		local ay = au.Frame:GetChildren()
		for az, aA in ipairs(ay) do
			if aA:IsA'ImageLabel' and aA.Name ~= 'Blur' then
				aA:Destroy()
			end
		end
		au.Enabled = # aw > 0
		for az, aA in ipairs(aw) do
			local aB = Instance.new'ImageLabel'
			aB.Size = UDim2.fromOffset(32, 32)
			aB.BackgroundTransparency = 1
			aB.Image = O.getIcon({
				itemType = aA
			}, true)
			aB.Parent = au.Frame
		end
	end
	local function Added(au)
		if am[au] then
			return
		end
		local av = Instance.new'BillboardGui'
		av.Parent = ao
		av.Name = 'bed'
		av.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		av.Size = UDim2.fromOffset(36, 36)
		av.AlwaysOnTop = true
		av.ClipsDescendants = false
		av.Adornee = au
		local aw = addBlur(av)
		aw.Visible = aq.Enabled
		local ax = Instance.new'Frame'
		ax.Size = UDim2.fromScale(1, 1)
		ax.BackgroundColor3 = ar.Enabled and getBedTeamColor(au) or Color3.fromHSV(al.Hue, al.Sat, al.Value)
		ax.BackgroundTransparency = 1 - (aq.Enabled and (ar.Enabled and 0.5 or al.Opacity) or 0)
		ax.Parent = av
		local ay = Instance.new'UIListLayout'
		ay.FillDirection = Enum.FillDirection.Horizontal
		ay.Padding = UDim.new(0, 4)
		ay.VerticalAlignment = Enum.VerticalAlignment.Center
		ay.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ay:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
			av.Size = UDim2.fromOffset(math.max(ay.AbsoluteContentSize.X + 4, 36), 36)
		end)
		ay.Parent = ax
		local az = Instance.new'UICorner'
		az.CornerRadius = UDim.new(0, 4)
		az.Parent = ax
		am[au] = av
		an[au] = ''
		refreshAdornee(av)
	end
	local function refreshNear(au)
		local av, aw = au.blockRef.blockPosition * 3, 900
		for ax, ay in pairs(am) do
			if ax.Parent then
				local az = av - ax.Position
				local aA = az.X * az.X + az.Y * az.Y + az.Z * az.Z
				if aA <= aw then
					refreshAdornee(ay)
				end
			end
		end
	end
	ap = v.Categories.Minigames:CreateModule{
		Name = 'BedPlates',
		Function = function(au)
			if au then
				table.clear(an)
				local av = l:GetTagged'bed'
				for aw, ax in ipairs(av) do
					Added(ax)
				end
				ap:Clean(b.PlaceBlockEvent.Event:Connect(refreshNear))
				ap:Clean(b.BreakBlockEvent.Event:Connect(refreshNear))
				ap:Clean(l:GetInstanceAddedSignal'bed':Connect(Added))
				ap:Clean(l:GetInstanceRemovedSignal'bed':Connect(function(aw)
					if am[aw] then
						am[aw]:Destroy()
						am[aw] = nil
						an[aw] = nil
					end
				end))
			else
				for av, aw in pairs(am) do
					aw:Destroy()
				end
				table.clear(am)
				table.clear(an)
			end
		end,
		Tooltip = 'Displays blocks over the bed'
	}
	aq = ap:CreateToggle{
		Name = 'Background',
		Function = function(au)
			if al.Object then
				al.Object.Visible = au and not ar.Enabled
			end
			for av, aw in pairs(am) do
				aw.Frame.BackgroundTransparency = 1 - (au and (ar.Enabled and 0.5 or al.Opacity) or 0)
				local ax = aw:FindFirstChild'Blur'
				if ax then
					ax.Visible = au
				end
			end
		end,
		Default = true
	}
	ar = ap:CreateToggle{
		Name = 'Team Color',
		Tooltip = 'Use bed team color instead of custom color',
		Default = true,
		Function = function(au)
			if al.Object then
				al.Object.Visible = aq.Enabled and not au
			end
			for av, aw in pairs(am) do
				aw.Frame.BackgroundColor3 = au and getBedTeamColor(av) or Color3.fromHSV(al.Hue, al.Sat, al.Value)
				aw.Frame.BackgroundTransparency = 1 - (aq.Enabled and (au and 0.5 or al.Opacity) or 0)
			end
		end
	}
	al = ap:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(au, av, aw, ax)
			for ay, az in pairs(am) do
				if not ar.Enabled then
					az.Frame.BackgroundColor3 = Color3.fromHSV(au, av, aw)
				end
				if aq.Enabled and not ar.Enabled then
					az.Frame.BackgroundTransparency = 1 - ax
				end
			end
		end,
		Visible = false,
		Darker = true
	}
end)
a(function()
	local al, am
	al = v.Categories.Utility:CreateModule{
		PerformanceModeBlacklisted = true,
		Name = 'Headless',
		Tooltip = 'free headless 2026',
		Function = function(an)
			if an then
				local function applyHeadless()
					if not (B.isAlive and B.character and B.character.Character and B.character.Head) then
						return
					end
					local ao = B.character.Head
					if am == nil then
						local ap = ao:FindFirstChild'face'
						if ap and ap:IsA'Decal' then
							am = ap.Transparency
						end
					end
					ao.Transparency = 1
					local ap = ao:FindFirstChild'face'
					if ap and ap:IsA'Decal' then
						ap.Transparency = 1
					end
				end
				applyHeadless()
				al:Clean(B.Events.LocalAdded:Connect(function()
					am = nil
					applyHeadless()
				end))
				al:Clean(b.AttributeChanged.Event:Connect(function(ao)
					if ao == 'Health' then
						applyHeadless()
					end
				end))
			else
				if B.isAlive and B.character and B.character.Character and B.character.Head then
					B.character.Head.Transparency = 0
					local ao = B.character.Head:FindFirstChild'face'
					if ao and ao:IsA'Decal' then
						ao.Transparency = am ~= nil and am or 0
						am = nil
					end
				end
			end
		end,
		Default = false
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH = {}, {}, {}
	local function customHealthbar(aI, aJ, aK, aL, aM, aN)
		if aN:GetAttribute'NoHealthbar' then
			return
		end
		if not aI.healthbarPart or not aI.healthbarBlockRef or aI.healthbarBlockRef.blockPosition ~= aJ.blockPosition then
			aI.healthbarMaid:DoCleaning()
			aI.healthbarBlockRef = aJ
			local aO, aP, aQ, aR = O.Roact.createElement, math.clamp(aK / aL, 0, 1), true, Instance.new'Part'
			aR.Size = Vector3.one
			aR.CFrame = CFrame.new(O.BlockController:getWorldPosition(aJ.blockPosition))
			aR.Transparency = 1
			aR.Anchored = true
			aR.CanCollide = false
			aR.Parent = workspace
			aI.healthbarPart = aR
			O.QueryUtil:setQueryIgnored(aI.healthbarPart, true)
			local aS = O.Roact.mount(aO('BillboardGui', {
				Size = UDim2.fromOffset(249, 102),
				StudsOffset = Vector3.new(0, 2.5, 0),
				Adornee = aR,
				MaxDistance = 40,
				AlwaysOnTop = true
			}, {
				aO('Frame', {
					Size = UDim2.fromOffset(160, 50),
					Position = UDim2.fromOffset(44, 32),
					BackgroundColor3 = Color3.new(),
					BackgroundTransparency = 0.5
				}, {
					aO('UICorner', {
						CornerRadius = UDim.new(0, 5)
					}),
					aO('ImageLabel', {
						Size = UDim2.new(1, 89, 1, 52),
						Position = UDim2.fromOffset(- 48, - 31),
						BackgroundTransparency = 1,
						Image = K'newvape/assets/new/blur.png',
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(52, 31, 261, 502)
					}),
					aO('TextLabel', {
						Size = UDim2.fromOffset(145, 14),
						Position = UDim2.fromOffset(13, 12),
						BackgroundTransparency = 1,
						Text = O.ItemMeta[aN.Name].displayName or aN.Name,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
						TextColor3 = Color3.new(),
						TextScaled = true,
						Font = Enum.Font.Arial
					}),
					aO('TextLabel', {
						Size = UDim2.fromOffset(145, 14),
						Position = UDim2.fromOffset(12, 11),
						BackgroundTransparency = 1,
						Text = O.ItemMeta[aN.Name].displayName or aN.Name,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
						TextColor3 = G.Dark(E.Text, 0.16),
						TextScaled = true,
						Font = Enum.Font.Arial
					}),
					aO('Frame', {
						Size = UDim2.fromOffset(138, 4),
						Position = UDim2.fromOffset(12, 32),
						BackgroundColor3 = E.Main
					}, {
						aO('UICorner', {
							CornerRadius = UDim.new(1, 0)
						}),
						aO('Frame', {
							[O.Roact.Ref] = aI.healthbarProgressRef,
							Size = UDim2.fromScale(aP, 1),
							BackgroundColor3 = Color3.fromHSV(math.clamp(aP / 2.5, 0, 1), 0.89, 0.75)
						}, {
							aO('UICorner', {
								CornerRadius = UDim.new(1, 0)
							})
						})
					})
				})
			}), aR)
			aI.healthbarMaid:GiveTask(function()
				aQ = false
				aI.healthbarBlockRef = nil
				O.Roact.unmount(aS)
				if aI.healthbarPart then
					aI.healthbarPart:Destroy()
				end
				aI.healthbarPart = nil
			end)
			O.RuntimeLib.Promise.delay(5):andThen(function()
				if aQ then
					aI.healthbarMaid:DoCleaning()
				end
			end)
		end
		local aO = math.clamp((aK - aM) / aL, 0, 1)
		i:Create(aI.healthbarProgressRef:getValue(), TweenInfo.new(0.3), {
			Size = UDim2.fromScale(aO, 1),
			BackgroundColor3 = Color3.fromHSV(math.clamp(aO / 2.5, 0, 1), 0.89, 0.75)
		}):Play()
	end
	local aI = 0
	local function isSameTeam(aJ)
		if not aJ then
			return false
		end
		local aK = t.Team
		if not aK then
			return false
		end
		for aL, aM in e:GetPlayers() do
			if aM.UserId == aJ and aM.Team == aK then
				return true
			end
		end
		return false
	end
	local function passesChecks(aJ)
		if not aC.Enabled then
			if aJ:GetAttribute'PlacedByUserId' == t.UserId then
				return false
			end
			if isSameTeam(aJ:GetAttribute'PlacedByUserId') then
				return false
			end
		end
		if (aJ:GetAttribute'BedShieldEndTime' or 0) > workspace:GetServerTimeNow() then
			return false
		end
		if aE.Enabled and not (L.hand.tool and O.ItemMeta[L.hand.tool.Name].breakBlock) then
			return false
		end
		return true
	end
	local function doBreak(aJ)
		aI += 1
		local aK, aL, aM = O.breakBlock(aJ, aA.Enabled, aB.Enabled, al.Enabled and customHealthbar or nil, aD.Enabled or aF.Enabled)
		if aL then
			local aN = aK
			for aO, aP in an do
				aP.Position = aN or Vector3.zero
				if aN then
					aP.BoxHandleAdornment.Color3 = aN == aM and Color3.new(1, 0.2, 0.2) or aN == aK and Color3.new(0.2, 0.2, 1) or Color3.new(0.2, 1, 0.2)
				end
				aN = aL[aN]
			end
		end
		task.wait(aD.Enabled and (L.damageBlockFail > tick() and 4.5 or 0) or aq.Value)
		return true
	end
	local function findPathBlock(aJ, aK)
		local aL = (aJ - aK)
		local aM = aL.Magnitude
		if aM < 3 then
			return nil
		end
		aL = aL.Unit
		local aN, aO = {}, 3
		for aP = aO, aM - aO, aO do
			local aQ = roundPos(aK + aL * aP)
			local aR = aQ.X .. ',' .. aQ.Y .. ',' .. aQ.Z
			if aN[aR] then
				continue
			end
			aN[aR] = true
			if (aQ - aJ).Magnitude < 4 then
				continue
			end
			local aS = getPlacedBlock(aQ)
			if aS and O.BlockController:isBlockBreakable({
				blockPosition = aQ / 3
			}, t) then
				return aS
			end
		end
		return nil
	end
	local function attemptBreak(aJ, aK)
		if not aJ then
			return false
		end
		if aH and aH.Enabled and not h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			return false
		end
		for aL, aM in aJ do
			if (aM.Position - aK).Magnitude < ap.Value and O.BlockController:isBlockBreakable({
				blockPosition = aM.Position / 3
			}, t) then
				if not passesChecks(aM) then
					continue
				end
				if aG and aG.Enabled then
					local aN = findPathBlock(aM.Position, aK)
					if aN and passesChecks(aN) then
						return doBreak(aN)
					end
				end
				return doBreak(aM)
			end
		end
		return false
	end
	local function attemptBreakNamed(aJ, aK)
		if aH and aH.Enabled and not h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			return false
		end
		local aL, aM = (math.huge)
		for aN, aO in L.blocks do
			if aO and aO:IsA'BasePart' and table.find(aJ, aO.Name) then
				local aP = (aO.Position - aK).Magnitude
				if aP < ap.Value and aP < aL then
					if O.BlockController:isBlockBreakable({
						blockPosition = aO.Position / 3
					}, t) then
						if passesChecks(aO) then
							aM = aO
							aL = aP
						end
					end
				end
			end
		end
		if aM then
			return doBreak(aM)
		end
		return false
	end
	ao = v.Categories.Minigames:CreateModule{
		Name = 'Breaker',
		Function = function(aJ)
			if aJ then
				for aK = 1, 30 do
					local aL = Instance.new'Part'
					aL.Anchored = true
					aL.CanQuery = false
					aL.CanCollide = false
					aL.Transparency = 1
					aL.Parent = s
					local aM = Instance.new'BoxHandleAdornment'
					aM.Size = Vector3.one
					aM.AlwaysOnTop = true
					aM.ZIndex = 1
					aM.Transparency = 0.5
					aM.Adornee = aL
					aM.Parent = aL
					table.insert(an, aL)
				end
				local aK, aL, aM = collection('bed', ao), collection('LuckyBlock', ao), collection('iron_ore_mesh_block', ao)
				am = collection('block', ao, function(aN, aO)
					if table.find(at.ListEnabled, aO.Name) then
						table.insert(aN, aO)
					end
				end)
				repeat
					task.wait(1 / ar.Value)
					if not ao.Enabled then
						break
					end
					if B.isAlive then
						local aN = B.character.RootPart.Position
						if attemptBreak(au.Enabled and aK, aN) then
							continue
						end
						if attemptBreak(am, aN) then
							continue
						end
						if attemptBreak(av.Enabled and aL, aN) then
							continue
						end
						if attemptBreak(aw.Enabled and aM, aN) then
							continue
						end
						do
							local aO = {}
							if ax and ax.Enabled then
								table.insert(aO, 'tesla_trap')
							end
							if ay and ay.Enabled then
								table.insert(aO, 'beehive')
							end
							if az and az.Enabled then
								table.insert(aO, 'pinata')
							end
							if # aO > 0 then
								if attemptBreakNamed(aO, aN) then
									continue
								end
							end
						end
						for aO, aP in an do
							aP.Position = Vector3.zero
						end
					end
				until not ao.Enabled
			else
				for aK, aL in an do
					aL:ClearAllChildren()
					aL:Destroy()
				end
				table.clear(an)
			end
		end,
		Tooltip = 'Break blocks around you automatically'
	}
	ap = ao:CreateSlider{
		Name = 'Break range',
		Min = 1,
		Max = 30,
		Default = 30,
		Suffix = function(aJ)
			return aJ == 1 and 'stud' or 'studs'
		end
	}
	aq = ao:CreateSlider{
		Name = 'Break speed',
		Min = 0,
		Max = 0.3,
		Default = 0.25,
		Decimal = 100,
		Suffix = 'seconds'
	}
	ar = ao:CreateSlider{
		Name = 'Update rate',
		Min = 1,
		Max = 120,
		Default = 60,
		Suffix = 'hz'
	}
	at = ao:CreateTextList{
		Name = 'Custom',
		Function = function()
			if not am then
				return
			end
			table.clear(am)
			for aJ, aK in L.blocks do
				if table.find(at.ListEnabled, aK.Name) then
					table.insert(am, aK)
				end
			end
		end
	}
	au = ao:CreateToggle{
		Name = 'Break Bed',
		Default = true
	}
	av = ao:CreateToggle{
		Name = 'Break Lucky Block',
		Default = true
	}
	aw = ao:CreateToggle{
		Name = 'Break Iron Ore',
		Default = true
	}
	ax = ao:CreateToggle{
		Name = 'Break Tesla',
		Default = true
	}
	ay = ao:CreateToggle{
		Name = 'Break Hive',
		Default = true
	}
	az = ao:CreateToggle{
		Name = 'Break Pinata',
		Default = false
	}
	aA = ao:CreateToggle{
		Name = 'Show Healthbar & Effects',
		Function = function(aJ)
			if al.Object then
				al.Object.Visible = aJ
			end
		end,
		Default = true
	}
	al = ao:CreateToggle{
		Name = 'Custom Healthbar',
		Default = true,
		Darker = true
	}
	aB = ao:CreateToggle{
		Name = 'Animation'
	}
	aC = ao:CreateToggle{
		Name = 'Self Break'
	}
	aD = ao:CreateToggle{
		Name = 'Instant Break'
	}
	aF = ao:CreateToggle{
		Name = 'Auto Tool',
		Tooltip = 'Automatically switches to the best tool for breaking blocks'
	}
	aE = ao:CreateToggle{
		Name = 'Limit to items',
		Tooltip = 'Only breaks when tools are held'
	}
	aG = ao:CreateToggle{
		Name = 'Break Closest Block',
		Tooltip = 'Breaks blocks blocking the path to the target instead of the target directly'
	}
	aH = ao:CreateToggle{
		Name = 'Require Mouse Down',
		Tooltip = 'Only breaks blocks when holding left click'
	}
	task.defer(function()
		if al and al.Object then
			al.Object.Visible = aA.Enabled
		end
	end)
end)
a(function()
	local al, am, an = nil, nil, {}
	al = v.Categories.Legit:CreateModule{
		Name = 'BedBreakEffect',
		Function = function(ao)
			if ao then
				al:Clean(b.BedwarsBedBreak.Event:Connect(function(ap)
					firesignal(O.Client:Get(P.BedBreakEffectTriggered).instance.OnClientEvent, {
						player = ap.player,
						position = ap.bedBlockPosition * 3,
						effectType = an[am.Value],
						teamId = ap.brokenBedTeam.id,
						centerBedPosition = ap.bedBlockPosition * 3
					})
				end))
			end
		end,
		Tooltip = 'Custom bed break effects'
	}
	local ao = {}
	for ap, aq in O.BedBreakEffectMeta do
		table.insert(ao, aq.name)
		an[aq.name] = ap
	end
	table.sort(ao)
	am = al:CreateDropdown{
		Name = 'Effect',
		List = ao
	}
end)
a(function()
	v.Categories.BoostFPS:CreateModule{
		Name = 'CleanKit',
		Function = function(al)
			if al then
				O.WindWalkerController.spawnOrb = function()
				end
				local am = t.PlayerGui:FindFirstChild('WindWalkerEffect', true)
				if am then
					am.Visible = false
				end
			end
		end,
		Tooltip = 'Removes zephyr status indicator'
	}
end)
a(function()
	local al, am
	local an = v.Categories.Legit:CreateModule{
		Name = 'Crosshair',
		Function = function(an)
			if an then
				local ao = am.Value or ''
				if ao == '' then
					notif('Crosshair', 'Enter an image ID first', 2)
					task.defer(function()
						if Crosshair then
							Crosshair:Toggle()
						end
					end)
					return
				end
				if not ao:find'rbxassetid://' then
					ao = 'rbxassetid://' .. ao
				end
				local ap = O.ViewmodelController.showCrosshair
				local aq, ar = pcall(debug.getconstants, ap)
				if aq and ar then
					for at, au in pairs(ar) do
						if type(au) == 'string' and au:find'rbxassetid://' then
							if not al then
								al = au
							end
							debug.setconstant(ap, at, ao)
						end
					end
				end
			else
				if al then
					local ao = O.ViewmodelController.showCrosshair
					local ap, aq = pcall(debug.getconstants, ao)
					if ap and aq then
						for ar, at in pairs(aq) do
							if type(at) == 'string' and at:find'rbxassetid://' then
								debug.setconstant(ao, ar, al)
							end
						end
					end
					al = nil
				end
			end
			if O.CameraPerspectiveController:getCameraPerspective() == 0 then
				O.ViewmodelController:hideCrosshair()
				O.ViewmodelController:showCrosshair()
			end
		end,
		Tooltip = 'Custom first person crosshair depending on the image chosen.'
	}
	am = an:CreateTextBox{
		Name = 'Image',
		Placeholder = 'image id (roblox)',
		Function = function(ao)
			if ao and an.Enabled then
				an:Toggle()
				an:Toggle()
			end
		end
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar, at = nil, nil, nil, nil, nil, nil, pcall(function()
		return debug.getupvalue(O.DamageIndicator, 2)
	end)
	at = ar and at or {}
	local au, av = {}
	al = v.Categories.Legit:CreateModule{
		Name = 'DamageIndicator',
		Function = function(aw)
			if aw then
				au = table.clone(at)
				av = debug.getconstant(O.DamageIndicator, 86)
				debug.setconstant(O.DamageIndicator, 86, Enum.Font[am.Value])
				debug.setconstant(O.DamageIndicator, 119, aq.Enabled and 'Thickness' or 'Enabled')
				at.strokeThickness = aq.Enabled and 1 or false
				at.textSize = ao.Value
				at.blowUpSize = ao.Value
				at.blowUpDuration = 0
				at.baseColor = Color3.fromHSV(an.Hue, an.Sat, an.Value)
				at.blowUpCompleteDuration = 0
				at.anchoredDuration = ap.Value
			else
				for ax, ay in au do
					at[ax] = ay
				end
				debug.setconstant(O.DamageIndicator, 86, av)
				debug.setconstant(O.DamageIndicator, 119, 'Thickness')
			end
		end,
		Tooltip = 'Customize the damage indicator'
	}
	local aw = {
		'GothamBlack'
	}
	for ax, ay in Enum.Font:GetEnumItems() do
		if ay.Name ~= 'GothamBlack' then
			table.insert(aw, ay.Name)
		end
	end
	am = al:CreateDropdown{
		Name = 'Font',
		List = aw,
		Function = function(ax)
			if al.Enabled then
				debug.setconstant(O.DamageIndicator, 86, Enum.Font[ax])
			end
		end
	}
	an = al:CreateColorSlider{
		Name = 'Color',
		DefaultHue = 0,
		Function = function(ax, ay, az)
			if al.Enabled then
				at.baseColor = Color3.fromHSV(ax, ay, az)
			end
		end
	}
	ao = al:CreateSlider{
		Name = 'Size',
		Min = 1,
		Max = 32,
		Default = 32,
		Function = function(ax)
			if al.Enabled then
				at.textSize = ax
				at.blowUpSize = ax
			end
		end
	}
	ap = al:CreateSlider{
		Name = 'Anchor',
		Min = 0,
		Max = 1,
		Decimal = 10,
		Function = function(ax)
			if al.Enabled then
				at.anchoredDuration = ax
			end
		end
	}
	aq = al:CreateToggle{
		Name = 'Stroke',
		Function = function(ax)
			if al.Enabled then
				debug.setconstant(O.DamageIndicator, 119, ax and 'Thickness' or 'Enabled')
				at.strokeThickness = ax and 1 or false
			end
		end
	}
end)
a(function()
	local al, am, an, ao
	al = v.Categories.Legit:CreateModule{
		Name = 'FOV',
		Function = function(ap)
			if ap then
				an = O.FovController.setFOV
				ao = O.FovController.getFOV
				O.FovController.setFOV = function(aq)
					return an(aq, am.Value)
				end
				O.FovController.getFOV = function()
					return am.Value
				end
			else
				O.FovController.setFOV = an
				O.FovController.getFOV = ao
			end
			O.FovController:setFOV(O.Store:getState().Settings.fov)
		end,
		Tooltip = 'Adjusts camera vision'
	}
	am = al:CreateSlider{
		Name = 'FOV',
		Min = 30,
		Max = 120
	}
end)
a(function()
	local al, am, an, ao, ap, aq, ar = {}, {}, false
	ao = v.Categories.BoostFPS:CreateModule{
		Name = 'FPSBoost',
		Function = function(at)
			if at then
				if ap.Enabled then
					for au, av in O.KillEffectController.killEffects do
						if not au:find'Custom' then
							al[au] = av
							O.KillEffectController.killEffects[au] = {
								new = function()
									return {
										onKill = function()
										end,
										isPlayDefaultKillEffect = function()
											return true
										end
									}
								end
							}
						end
					end
				end
				if aq.Enabled then
					local au = {
						'beam',
						'Beam',
						'projectile',
						'Projectile',
						'draw',
						'Draw',
						'line',
						'Line',
						'ray',
						'Ray',
						'arc',
						'Arc'
					}
					for av, aw in O.VisualizerUtils do
						local ax = false
						for ay, az in au do
							if tostring(av):lower():find(az:lower()) then
								ax = true
								break
							end
						end
						if not ax then
							am[av] = aw
							O.VisualizerUtils[av] = function()
							end
						end
					end
				end
			else
				for au, av in al do
					O.KillEffectController.killEffects[au] = av
				end
				for au, av in am do
					O.VisualizerUtils[au] = av
				end
				if an and ar then
					O.NametagController.addGameNametag = ar
					an = false
				end
				table.clear(al)
				table.clear(am)
			end
		end,
		Tooltip = 'Improves the framerate by turning off certain effects'
	}
	ap = ao:CreateToggle{
		Name = 'Kill Effects',
		Function = function()
			if ao.Enabled then
				ao:Toggle()
				ao:Toggle()
			end
		end,
		Default = true
	}
	aq = ao:CreateToggle{
		Name = 'Visualizer',
		Function = function()
			if ao.Enabled then
				ao:Toggle()
				ao:Toggle()
			end
		end,
		Default = true
	}
end)
a(function()
	local al, am, an = {}
	am = v.Categories.Legit:CreateModule{
		Name = 'HitColor',
		Function = function(ao)
			if ao then
				repeat
					for ap, aq in B.List do
						local ar = aq.Character and aq.Character:FindFirstChild'_DamageHighlight_'
						if ar then
							if not table.find(al, ar) then
								table.insert(al, ar)
							end
							ar.FillColor = Color3.fromHSV(an.Hue, an.Sat, an.Value)
							ar.FillTransparency = an.Opacity
						end
					end
					task.wait(0.1)
				until not am.Enabled
			else
				for ap, aq in al do
					aq.FillColor = Color3.new(1, 0, 0)
					aq.FillTransparency = 0.4
				end
				table.clear(al)
			end
		end,
		Tooltip = 'Customize the hit highlight options'
	}
	an = am:CreateColorSlider{
		Name = 'Color',
		DefaultOpacity = 0.4
	}
end)
a(function()
	HitFix = v.Categories.Legit:CreateModule{
		Name = 'HitFix',
		Function = function(al)
			debug.setconstant(O.SwordController.swingSwordAtMouse, 23, al and 'raycast' or 'Raycast')
			debug.setupvalue(O.SwordController.swingSwordAtMouse, 4, al and O.QueryUtil or workspace)
		end,
		Tooltip = 'Changes the raycast function to the correct one'
	}
end)
a(function()
	local al, am, an, ao, ap, aq = require(t.PlayerScripts.TS.controllers.global.hotbar.ui['hotbar-open-inventory']).HotbarOpenInventory, require(t.PlayerScripts.TS.controllers.global.hotbar.ui.healthbar['hotbar-healthbar']).HotbarHealthbar, getRoactRender(require(t.PlayerScripts.TS.controllers.global.hotbar.ui['hotbar-app']).HotbarApp.render), {}, {}
	v:Clean(function()
		for ar, at in ap do
			table.clear(at)
		end
		for ar, at in ao do
			table.clear(at)
		end
		table.clear(ap)
		table.clear(ao)
	end)
	local function modifyconstant(ar, at, au)
		if not ar then
			return
		end
		if not ao[ar] then
			ao[ar] = {}
		end
		if not ap[ar] then
			ap[ar] = {}
		end
		if not ao[ar][at] then
			ao[ar][at] = debug.getconstant(ar, at)
		end
		if typeof(ao[ar][at]) ~= typeof(au) then
			return
		end
		ap[ar][at] = au
		if aq.Enabled then
			if au then
				debug.setconstant(ar, at, au)
			else
				debug.setconstant(ar, at, ao[ar][at])
				ao[ar][at] = nil
			end
		end
	end
	aq = v.Categories.Legit:CreateModule{
		Name = 'Interface',
		Function = function(ar)
			for at, au in (ar and ap or ao) do
				for av, aw in au do
					debug.setconstant(at, av, aw)
				end
			end
		end,
		Tooltip = 'Customize bedwars UI'
	}
	local ar = {
		'LuckiestGuy'
	}
	for at, au in Enum.Font:GetEnumItems() do
		if au.Name ~= 'LuckiestGuy' then
			table.insert(ar, au.Name)
		end
	end
	aq:CreateDropdown{
		Name = 'Health Font',
		List = ar,
		Function = function(at)
			modifyconstant(am.render, 77, at)
		end
	}
	aq:CreateColorSlider{
		Name = 'Health Color',
		Function = function(at, au, av)
			modifyconstant(am.render, 16, tonumber(Color3.fromHSV(at, au, av):ToHex(), 16))
			if aq.Enabled then
				local aw = t.PlayerGui:FindFirstChild'hotbar'
				aw = aw and aw:FindFirstChild('HealthbarProgressWrapper', true)
				if aw then
					aw['1'].BackgroundColor3 = Color3.fromHSV(at, au, av)
				end
			end
		end
	}
	aq:CreateColorSlider{
		Name = 'Hotbar Color',
		DefaultOpacity = 0.8,
		Function = function(at, au, av, aw)
			local ax = w or al.render
			modifyconstant(debug.getupvalue(an, 23).render, 51, tonumber(Color3.fromHSV(at, au, av):ToHex(), 16))
			modifyconstant(debug.getupvalue(an, 23).render, 58, tonumber(Color3.fromHSV(at, au, math.clamp(av > 0.5 and av - 0.2 or av + 0.2, 0, 1)):ToHex(), 16))
			modifyconstant(debug.getupvalue(an, 23).render, 54, 1 - aw)
			modifyconstant(debug.getupvalue(an, 23).render, 55, math.clamp(1.2 - aw, 0, 1))
			modifyconstant(ax, 31, tonumber(Color3.fromHSV(at, au, av):ToHex(), 16))
			modifyconstant(ax, 32, math.clamp(1.2 - aw, 0, 1))
			modifyconstant(ax, 34, tonumber(Color3.fromHSV(at, au, math.clamp(av > 0.5 and av - 0.2 or av + 0.2, 0, 1)):ToHex(), 16))
		end
	}
end)
a(function()
	local ar, at, au, av, aw = {}, {
		Gravity = function(al, am, an, ao)
			an:BreakJoints()
			local ap, aq = an:FindFirstChildWhichIsA'Highlight', an:FindFirstChild('Nametag', true)
			if ap then
				ap:Destroy()
			end
			if aq then
				aq:Destroy()
			end
			task.spawn(function()
				local ar = {}
				for at, au in an:GetDescendants() do
					if au:IsA'BasePart' then
						ar[au.Name] = au.Velocity
					end
				end
				an.Archivable = true
				local at = an:Clone()
				at.Humanoid.Health = 100
				at.Parent = workspace
				game:GetService'Debris':AddItem(at, 30)
				an:Destroy()
				task.wait(0.01)
				at.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
				at:BreakJoints()
				task.wait(0.01)
				for au, av in at:GetDescendants() do
					if av:IsA'BasePart' then
						local aw = Instance.new'BodyForce'
						aw.Force = Vector3.new(0, (workspace.Gravity - 10) * av:GetMass(), 0)
						aw.Parent = av
						av.CanCollide = true
						av.Velocity = ar[av.Name] or Vector3.zero
					end
				end
			end)
		end,
		Lightning = function(an, ao, ap, aq)
			ap:BreakJoints()
			local ar = ap:FindFirstChildWhichIsA'Highlight'
			if ar then
				ar:Destroy()
			end
			local at, au = 1125, ap.PrimaryPart.CFrame.p - Vector3.new(0, 8, 0)
			local av = Vector3.new((math.random(1, 10) - 5) * 2, at, (math.random(1, 10) - 5) * 2)
			for aw = at - 75, 0, - 75 do
				local ax = Vector3.new((math.random(1, 10) - 5) * 2, aw, (math.random(1, 10) - 5) * 2)
				if aw == 0 then
					ax = Vector3.zero
				end
				local ay = Instance.new'Part'
				ay.Size = Vector3.new(1.5, 1.5, 77)
				ay.Material = Enum.Material.SmoothPlastic
				ay.Anchored = true
				ay.Material = Enum.Material.Neon
				ay.CanCollide = false
				ay.CFrame = CFrame.new(au + av + ((ax - av) * 0.5), au + ax)
				ay.Parent = workspace
				local az = ay:Clone()
				az.Size = Vector3.new(3, 3, 78)
				az.Color = Color3.new(0.7, 0.7, 0.7)
				az.Transparency = 0.7
				az.Material = Enum.Material.SmoothPlastic
				az.Parent = workspace
				game:GetService'Debris':AddItem(ay, 0.5)
				game:GetService'Debris':AddItem(az, 0.5)
				O.QueryUtil:setQueryIgnored(ay, true)
				O.QueryUtil:setQueryIgnored(az, true)
				if aw == 0 then
					local aA = Instance.new'Part'
					aA.Transparency = 1
					aA.Anchored = true
					aA.Size = Vector3.zero
					aA.Position = au
					aA.Parent = workspace
					O.QueryUtil:setQueryIgnored(aA, true)
					local aB = Instance.new'Sound'
					aB.SoundId = 'rbxassetid://6993372814'
					aB.Volume = 2
					aB.Pitch = 0.5 + (math.random(1, 3) / 10)
					aB.Parent = aA
					aB:Play()
					aB.Ended:Connect(function()
						aA:Destroy()
					end)
				end
				av = ax
			end
		end,
		Delete = function(ap, aq, ar, at)
			ar:Destroy()
		end
	}
	au = v.Categories.Legit:CreateModule{
		Name = 'KillEffect',
		Function = function(ax)
			if ax then
				for ay, az in at do
					O.KillEffectController.killEffects['Custom' .. ay] = {
						new = function()
							return {
								onKill = az,
								isPlayDefaultKillEffect = function()
									return false
								end
							}
						end
					}
				end
				au:Clean(t:GetAttributeChangedSignal'KillEffectType':Connect(function()
					t:SetAttribute('KillEffectType', av.Value == 'Bedwars' and ar[aw.Value] or 'Custom' .. av.Value)
				end))
				t:SetAttribute('KillEffectType', av.Value == 'Bedwars' and ar[aw.Value] or 'Custom' .. av.Value)
			else
				for ay in at do
					O.KillEffectController.killEffects['Custom' .. ay] = nil
				end
				t:SetAttribute('KillEffectType', 'default')
			end
		end,
		Tooltip = 'Custom final kill effects'
	}
	local ax = {
		'Bedwars'
	}
	for ay in at do
		table.insert(ax, ay)
	end
	av = au:CreateDropdown{
		Name = 'Mode',
		List = ax,
		Function = function(ay)
			aw.Object.Visible = ay == 'Bedwars'
			if au.Enabled then
				t:SetAttribute('KillEffectType', ay == 'Bedwars' and ar[aw.Value] or 'Custom' .. ay)
			end
		end
	}
	local ay = {}
	for az, aA in O.KillEffectMeta do
		table.insert(ay, aA.name)
		ar[aA.name] = az
	end
	table.sort(ay)
	aw = au:CreateDropdown{
		Name = 'Bedwars',
		List = ay,
		Function = function(az)
			if au.Enabled then
				t:SetAttribute('KillEffectType', ar[az])
			end
		end,
		Darker = true
	}
	task.defer(function()
		if aw and aw.Object then
			aw.Object.Visible = (av.Value == 'Bedwars')
		end
	end)
end)
a(function()
	local ar, at
	ar = v.Categories.Legit:CreateModule{
		Name = 'ReachDisplay',
		Function = function(au)
			if au then
				repeat
					at.Text = (L.attackReachUpdate > tick() and L.attackReach or '0.00') .. ' studs'
					task.wait(0.4)
				until not ar.Enabled
			end
		end,
		Size = UDim2.fromOffset(100, 41)
	}
	ar:CreateFont{
		Name = 'Font',
		Blacklist = 'Gotham',
		Function = function(au)
			at.FontFace = au
		end
	}
	ar:CreateColorSlider{
		Name = 'Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(au, av, aw, ax)
			at.BackgroundColor3 = Color3.fromHSV(au, av, aw)
			at.BackgroundTransparency = 1 - ax
		end
	}
	at = Instance.new'TextLabel'
	at.Size = UDim2.fromScale(1, 1)
	at.BackgroundTransparency = 0.5
	at.TextSize = 15
	at.Font = Enum.Font.Gotham
	at.Text = '0.00 studs'
	at.TextColor3 = Color3.new(1, 1, 1)
	at.BackgroundColor3 = Color3.new()
	at.Parent = ar.Children
	local au = Instance.new'UICorner'
	au.CornerRadius = UDim.new(0, 4)
	au.Parent = at
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC = {}, {}, (tick())
	local function choosesong()
		local aD = aw.ListEnabled
		if # at >= # aD then
			table.clear(at)
		end
		if # aD <= 0 then
			notif('SongBeats', 'no songs', 10)
			av:Toggle()
			return
		end
		local aE = aD[math.random(1, # aD)]
		if # aD > 1 and table.find(at, aE) then
			repeat
				task.wait()
				aE = aD[math.random(1, # aD)]
			until not table.find(at, aE) or not av.Enabled
		end
		if not av.Enabled then
			return
		end
		local aF = aE:split'/'
		if not isfile(aF[1]) then
			notif('SongBeats', 'Missing song (' .. aF[1] .. ')', 10)
			av:Toggle()
			return
		end
		aA.SoundId = u(aF[1])
		repeat
			task.wait()
		until aA.IsLoaded or not av.Enabled
		if av.Enabled then
			au = tick() + (tonumber(aF[3]) or 0)
			aB = 60 / (tonumber(aF[2]) or 50)
			aA:Play()
		end
	end
	av = v.Categories.Legit:CreateModule{
		Name = 'SongBeats',
		Function = function(aD)
			if aD then
				aA = Instance.new'Sound'
				aA.Volume = ay.Value / 100
				aA.Parent = workspace
				repeat
					if not aA.Playing then
						choosesong()
					end
					if au < tick() and av.Enabled and ax.Enabled then
						au = tick() + aB
						az = math.min(O.FovController:getFOV() * (O.SprintController.sprinting and 1.1 or 1), 120)
						s.FieldOfView = az - ar.Value
						aC = i:Create(s, TweenInfo.new(math.min(aB, 0.2), Enum.EasingStyle.Linear), {
							FieldOfView = az
						})
						aC:Play()
					end
					task.wait()
				until not av.Enabled
			else
				if aA then
					aA:Destroy()
				end
				if aC then
					aC:Cancel()
				end
				if az then
					s.FieldOfView = az
				end
				table.clear(at)
			end
		end,
		Tooltip = 'Built in mp3 player'
	}
	aw = av:CreateTextList{
		Name = 'Songs',
		Placeholder = 'filepath/bpm/start'
	}
	ax = av:CreateToggle{
		Name = 'Beat FOV',
		Function = function(aD)
			if ar.Object then
				ar.Object.Visible = aD
			end
			if av.Enabled then
				av:Toggle()
				av:Toggle()
			end
		end,
		Default = true
	}
	ar = av:CreateSlider{
		Name = 'Adjustment',
		Min = 1,
		Max = 30,
		Default = 5,
		Darker = true
	}
	ay = av:CreateSlider{
		Name = 'Volume',
		Function = function(aD)
			if aA then
				aA.Volume = aD / 100
			end
		end,
		Min = 1,
		Max = 100,
		Default = 100,
		Suffix = '%'
	}
	task.defer(function()
		if ar and ar.Object then
			ar.Object.Visible = ax.Enabled
		end
	end)
end)
a(function()
	local ar, at, au, av = {}
	at = v.Categories.Legit:CreateModule{
		Name = 'SoundChanger',
		Function = function(aw)
			if aw then
				av = O.SoundManager.playSound
				O.SoundManager.playSound = function(ax, ay, ...)
					if ar[ay] then
						ay = ar[ay]
					end
					return av(ax, ay, ...)
				end
			else
				O.SoundManager.playSound = av
				av = nil
			end
		end,
		Tooltip = 'Change ingame sounds to custom ones.'
	}
	au = at:CreateTextList{
		Name = 'Sounds',
		Placeholder = '(DAMAGE_1/ben.mp3)',
		Function = function()
			table.clear(ar)
			for aw, ax in au.ListEnabled do
				local ay = ax:split'/'
				local az = O.SoundList[ay[1] ]
				if az and # ay > 1 then
					ar[az] = ay[2]:find'rbxasset' and ay[2] or isfile(ay[2]) and u(ay[2]) or ''
				end
			end
		end
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA = getRoactRender(require(t.PlayerScripts.TS.controllers.global.hotbar.ui['hotbar-app']).HotbarApp.render), require(t.PlayerScripts.TS.controllers.global.hotbar.ui['hotbar-open-inventory']).HotbarOpenInventory, {}, {}
	v:Clean(function()
		for aB, aC in av do
			table.clear(aC)
		end
		for aB, aC in au do
			table.clear(aC)
		end
		table.clear(av)
		table.clear(au)
	end)
	local function modifyconstant(aB, aC, aD)
		if not au[aB] then
			au[aB] = {}
		end
		if not av[aB] then
			av[aB] = {}
		end
		if not au[aB][aC] then
			local aE = type(au[aB][aC])
			if aE == 'function' or aE == 'userdata' then
				return
			end
			au[aB][aC] = debug.getconstant(aB, aC)
		end
		if typeof(au[aB][aC]) ~= typeof(aD) and aD ~= nil then
			return
		end
		av[aB][aC] = aD
		if aw.Enabled then
			if aD then
				debug.setconstant(aB, aC, aD)
			else
				debug.setconstant(aB, aC, au[aB][aC])
				au[aB][aC] = nil
			end
		end
	end
	aw = v.Categories.Legit:CreateModule{
		Name = 'UICleanup',
		Function = function(aB)
			for aC, aD in (aB and av or au) do
				for aE, aF in aD do
					debug.setconstant(aC, aE, aF)
				end
			end
			if aB then
				if ax.Enabled then
					w = at.render
					at.render = function()
						return O.Roact.createElement('TextButton', {
							Visible = false
						}, {})
					end
				end
				if ay.Enabled then
					aA = O.KillFeedController.addToKillFeed
					O.KillFeedController.addToKillFeed = function()
					end
				end
				if az.Enabled then
					p:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
				end
			else
				if w then
					at.render = w
					w = nil
				end
				if ay.Enabled then
					O.KillFeedController.addToKillFeed = aA
					aA = nil
				end
				if az.Enabled then
					p:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
				end
			end
		end,
		Tooltip = 'Cleans up the UI for kits & main'
	}
	aw:CreateToggle{
		Name = 'Resize Health',
		Function = function(aB)
			modifyconstant(ar, 60, aB and 1 or nil)
			modifyconstant(debug.getupvalue(ar, 15).render, 30, aB and 1 or nil)
			modifyconstant(debug.getupvalue(ar, 23).tweenPosition, 16, aB and 0 or nil)
		end,
		Default = true
	}
	aw:CreateToggle{
		Name = 'No Hotbar Numbers',
		Function = function(aB)
			local aC = w or at.render
			modifyconstant(debug.getupvalue(ar, 23).render, 90, aB and 0 or nil)
			modifyconstant(aC, 71, aB and 0 or nil)
		end,
		Default = true
	}
	ax = aw:CreateToggle{
		Name = 'No Inventory Button',
		Function = function(aB)
			modifyconstant(ar, 78, aB and 0 or nil)
			if aw.Enabled then
				if aB then
					w = at.render
					at.render = function()
						return O.Roact.createElement('TextButton', {
							Visible = false
						}, {})
					end
				else
					at.render = w
					w = nil
				end
			end
		end,
		Default = true
	}
	ay = aw:CreateToggle{
		Name = 'No Kill Feed',
		Function = function(aB)
			if aw.Enabled then
				if aB then
					aA = O.KillFeedController.addToKillFeed
					O.KillFeedController.addToKillFeed = function()
					end
				else
					O.KillFeedController.addToKillFeed = aA
					aA = nil
				end
			end
		end,
		Default = true
	}
	az = aw:CreateToggle{
		Name = 'Old Player List',
		Function = function(aB)
			if aw.Enabled then
				p:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, aB)
			end
		end,
		Default = true
	}
	aw:CreateToggle{
		Name = 'Fix Queue Card',
		Function = function(aB)
			modifyconstant(O.QueueCard.render, 15, aB and 0.1 or nil)
		end,
		Default = true
	}
end)
a(function()
	local ar, at, au = {}
	at = v.Categories.Legit:CreateModule{
		Name = 'WinEffect',
		Function = function(av)
			if av then
				at:Clean(b.MatchEndEvent.Event:Connect(function()
					for aw, ax in getconnections(O.Client:Get(P.WinEffectTriggered).instance.OnClientEvent) do
						if ax.Function then
							ax.Function{
								winEffectType = ar[au.Value],
								winningPlayer = t
							}
						end
					end
				end))
			end
		end,
		Tooltip = 'Allows you to select any clientside win effect'
	}
	local av = {}
	for aw, ax in O.WinEffectMeta do
		table.insert(av, ax.name)
		ar[ax.name] = aw
	end
	table.sort(av)
	au = at:CreateDropdown{
		Name = 'Effects',
		List = av
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az = {}
	at = v.Categories.Combat:CreateModule{
		Name = 'Viewmodel',
		Function = function(aA)
			local aB = s:FindFirstChild'Viewmodel'
			if aA then
				ay = O.ViewmodelController.playAnimation
				az = aB and aB.RightHand.RightWrist.C1 or CFrame.identity
				if ax.Enabled then
					O.ViewmodelController.playAnimation = function(aC, aD, ...)
						if O.AnimationType and aD == O.AnimationType.FP_WALK then
							return
						end
						return ay(aC, aD, ...)
					end
				end
				O.InventoryViewmodelController:handleStore(O.Store:getState())
				if aB then
					s.Viewmodel.RightHand.RightWrist.C1 = az * CFrame.Angles(math.rad(ar[1].Value), math.rad(ar[2].Value), math.rad(ar[3].Value))
				end
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_DEPTH_OFFSET', - au.Value)
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_HORIZONTAL_OFFSET', av.Value)
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_VERTICAL_OFFSET', aw.Value)
			else
				O.ViewmodelController.playAnimation = ay
				if aB then
					aB.RightHand.RightWrist.C1 = az
				end
				O.InventoryViewmodelController:handleStore(O.Store:getState())
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_DEPTH_OFFSET', 0)
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_HORIZONTAL_OFFSET', 0)
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_VERTICAL_OFFSET', 0)
				ay = nil
			end
		end,
		Tooltip = 'Changes the viewmodel animations'
	}
	au = at:CreateSlider{
		Name = 'Depth',
		Min = 0,
		Max = 2,
		Default = 0.8,
		Decimal = 10,
		Function = function(aA)
			if at.Enabled then
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_DEPTH_OFFSET', - aA)
			end
		end
	}
	av = at:CreateSlider{
		Name = 'Horizontal',
		Min = 0,
		Max = 2,
		Default = 0.8,
		Decimal = 10,
		Function = function(aA)
			if at.Enabled then
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_HORIZONTAL_OFFSET', aA)
			end
		end
	}
	aw = at:CreateSlider{
		Name = 'Vertical',
		Min = - 0.2,
		Max = 2,
		Default = - 0.2,
		Decimal = 10,
		Function = function(aA)
			if at.Enabled then
				t.PlayerScripts.TS.controllers.global.viewmodel['viewmodel-controller']:SetAttribute('ConstantManager_VERTICAL_OFFSET', aA)
			end
		end
	}
	for aA, aB in {
		'Rotation X',
		'Rotation Y',
		'Rotation Z'
	} do
		table.insert(ar, at:CreateSlider{
			Name = aB,
			Min = 0,
			Max = 360,
			Function = function(aC)
				if at.Enabled then
					s.Viewmodel.RightHand.RightWrist.C1 = az * CFrame.Angles(math.rad(ar[1].Value), math.rad(ar[2].Value), math.rad(ar[3].Value))
				end
			end
		})
	end
	ax = at:CreateToggle{
		Name = 'No Bobbing',
		Default = true,
		Function = function()
			if at.Enabled then
				at:Toggle()
				at:Toggle()
			end
		end
	}
end)
a(function()
	local ar
	ar = v.Categories.Utility:CreateModule{
		Name = 'ClearMatchHistory',
		Tooltip = 'Resets ur match history',
		Function = function(at)
			if at then
				ar:Toggle(false)
				local au = game:GetService'TeleportService'
				local av = au:GetLocalPlayerTeleportData()
				au:Teleport(game.PlaceId, game.Players.LocalPlayer, av)
			end
		end
	}
end)
a(function()
	local ar
	ar = v.Categories.Utility:CreateModule{
		Name = 'ViewMatchHistory',
		Function = function(at)
			if at then
				ar:Toggle(false)
				O.MatchHistroyController:requestMatchHistory(t.Name):andThen(function(au)
					if au then
						O.AppController:openApp({
							app = O.MatchHistroyApp,
							appId = 'MatchHistoryApp'
						}, au)
					end
				end)
			else
				return
			end
		end,
		Tooltip = 'matchhisory'
	}
end)
a(function()
	local ar, at, au, av, aw, ax = c(game:GetService'Lighting'), {}, {
		Enabled = false
	}, 0, 0.016
	au = v.Categories.World:CreateModule{
		Name = 'Fullbright',
		Function = function(ay)
			if ay then
				at = {
					Brightness = ar.Brightness,
					ClockTime = ar.ClockTime,
					FogEnd = ar.FogEnd,
					GlobalShadows = ar.GlobalShadows,
					OutdoorAmbient = ar.OutdoorAmbient,
					Ambient = ar.Ambient,
					ExposureCompensation = ar.ExposureCompensation
				}
				local az = ax and ax.Value or 5
				av = tick()
				ar.Brightness = az
				ar.ClockTime = 14
				ar.FogEnd = 100000
				ar.GlobalShadows = false
				ar.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
				ar.Ambient = Color3.fromRGB(255, 255, 255)
				ar.ExposureCompensation = 1
				local function protectProperty(aA, aB)
					return ar:GetPropertyChangedSignal(aA):Connect(function()
						local aC = tick()
						if aC - av > aw then
							av = aC
							ar[aA] = aB
						end
					end)
				end
				au:Clean(protectProperty('Brightness', az))
				au:Clean(protectProperty('Ambient', Color3.fromRGB(255, 255, 255)))
				au:Clean(protectProperty('ExposureCompensation', 1))
			else
				av = tick()
				for az, aA in pairs(at) do
					if aA ~= nil then
						ar[az] = aA
					end
				end
				table.clear(at)
			end
		end,
		HoverText = 'Makes everything bright and removes shadows'
	}
	ax = au:CreateSlider{
		Name = 'Brightness',
		Min = 1,
		Max = 10,
		Default = 5,
		Function = function(ay)
			if au.Enabled then
				av = tick()
				ar.Brightness = ay
			end
		end
	}
	do
		au:CreateToggle{
			Name = 'Extra Bright',
			Function = function(ay)
				if au.Enabled then
					av = tick()
					if ay then
						ar.Brightness = 10
						ar.Ambient = Color3.fromRGB(255, 255, 255)
						ar.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
						ar.ExposureCompensation = 2
						if not ar:FindFirstChild'VapeSun' then
							local az = Instance.new'SunRaysEffect'
							az.Name = 'VapeSun'
							az.Intensity = 0.1
							az.Spread = 1
							az.Parent = ar
						end
					else
						ar.Brightness = ax.Value
						ar.Ambient = Color3.fromRGB(255, 255, 255)
						ar.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
						ar.ExposureCompensation = 1
						local az = ar:FindFirstChild'VapeSun'
						if az then
							az:Destroy()
						end
					end
				end
			end
		}
		au:CreateToggle{
			Name = 'No Shadows',
			Function = function(ay)
				if au.Enabled then
					av = tick()
					ar.GlobalShadows = not ay
				end
			end,
			Default = true
		}
	end
end)
a(function()
	local ar, at, au, av, aw, ax, ay = {}, false, {
		Value = 'First Person'
	}, {
		Enabled = false
	}, {
		Enabled = false
	}
	local function hasBowEquipped()
		if not L.hand or not L.hand.tool then
			return false
		end
		local az = L.hand.tool.Name:lower()
		return az:find'bow' ~= nil or az:find'crossbow' ~= nil
	end
	local function shouldHideCursor()
		if not at then
			return false
		end
		if aw.Enabled and isGUIOpen() then
			return false
		end
		if av.Enabled and not hasBowEquipped() then
			return false
		end
		local az = isFirstPerson()
		if au.Value == 'First Person' then
			return az
		elseif au.Value == 'Third Person' then
			return not az
		elseif au.Value == 'Both' then
			return true
		end
		return false
	end
	local function updateCursor()
		local az = shouldHideCursor()
		if ay == az then
			return
		end
		ay = az
		h.MouseIconEnabled = not az
	end
	ar = v.Categories.Utility:CreateModule{
		Name = 'InvisibleCursor',
		Function = function(az)
			if az then
				at = true
				ay = nil
				if ax then
					ax:Disconnect()
				end
				ax = g.RenderStepped:Connect(updateCursor)
				ar:Clean(ax)
				ar:Clean(b.InventoryChanged.Event:Connect(updateCursor))
			else
				at = false
				if ax then
					ax:Disconnect()
					ax = nil
				end
				h.MouseIconEnabled = true
				ay = nil
			end
		end,
		Tooltip = 'Hides cursor based on view mode and item settings'
	}
	au = ar:CreateDropdown{
		Name = 'View Mode',
		List = {
			'First Person',
			'Third Person',
			'Both'
		},
		Default = 'First Person',
		Tooltip = 'Choose when to hide cursor\nFirst Person: Only in 1st person\nThird Person: Only in 3rd person\nBoth: Always hide',
		Function = function(az)
			au.Value = az
			updateCursor()
		end
	}
	av = ar:CreateToggle{
		Name = 'Limit to Bow',
		Default = false,
		Tooltip = 'Only hide cursor when holding a bow/crossbow',
		Function = function(az)
			av.Enabled = az
			updateCursor()
		end
	}
	aw = ar:CreateToggle{
		Name = 'Show on GUI',
		Default = false,
		Tooltip = 'Show cursor when any GUI is open (inventory, shop, etc)',
		Function = function(az)
			aw.Enabled = az
			updateCursor()
		end
	}
end)
a(function()
	local ar, at, au
	ar = v.Categories.Blatant:CreateModule{
		Name = 'BlockCPSRemover',
		Function = function(av)
			if av then
				task.wait(1)
				pcall(function()
					au = require(f.TS['shared-constants']).CpsConstants
				end)
				if not au then
					pcall(function()
						au = O.CpsConstants
					end)
				end
				if au then
					local aw = at.Value == 0 and 1000 or at.Value
					au.BLOCK_PLACE_CPS = aw
					if ae then
						for ax, ay in {
							'2',
							'5'
						} do
							pcall(function()
								ar:Clean(t.PlayerGui.MobileUI[ay].MouseButton1Down:Connect(function()
									if au then
										local az = at.Value == 0 and 1000 or at.Value
										au.BLOCK_PLACE_CPS = az
									end
								end))
							end)
						end
					end
					task.spawn(function()
						while ar.Enabled do
							local ax = at.Value == 0 and 1000 or at.Value
							if au.BLOCK_PLACE_CPS ~= ax then
								au.BLOCK_PLACE_CPS = ax
							end
							task.wait(0.3)
						end
					end)
				end
			else
				if au then
					au.BLOCK_PLACE_CPS = 12
				end
			end
		end,
		Tooltip = 'Simple CPS modifier (Mobile + Desktop)'
	}
	at = ar:CreateSlider{
		Name = 'CPS Limit',
		Suffix = 'CPS',
		Tooltip = 'Higher = faster but more ghost blocks',
		Default = 12,
		Min = 12,
		Max = 20,
		Function = function()
			if ar.Enabled and au then
				local av = at.Value == 0 and 1000 or at.Value
				au.BLOCK_PLACE_CPS = av
			end
		end
	}
end)
a(function()
	local ar, at, au = {
		Enabled = false
	}, {
		Value = 100
	}
	ar = v.Categories.Utility:CreateModule{
		Name = 'SetPlayerLevel',
		Tooltip = 'Sets your player level to 100 (client sided)',
		Function = function(av)
			if av then
				if ar.Enabled and not au then
					au = game.Players.LocalPlayer:GetAttribute'PlayerLevel' or 1
				end
				game.Players.LocalPlayer:SetAttribute('PlayerLevel', at.Value)
			else
				if au then
					game.Players.LocalPlayer:SetAttribute('PlayerLevel', au)
					au = nil
				end
			end
		end
	}
	at = ar:CreateSlider{
		Name = 'Sets your player level(client side)',
		Function = function()
			if ar.Enabled then
				game.Players.LocalPlayer:SetAttribute('PlayerLevel', at.Value)
			end
		end,
		Min = 1,
		Max = 1000,
		Default = 100
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI = {}, {
		'gg',
		'gg2',
		'DV',
		'DV2'
	}, {
		1502104539,
		3826146717,
		4531785383,
		1049767300,
		4926350670,
		653085195,
		184655415,
		2752307430,
		5087196317,
		5744061325,
		1536265275
	}, {
		phantomviperr2 = true,
		gavin2015shadow = true,
		clocksurge = true,
		amcoolll3 = true,
		zorflow = true,
		dreamingnostaigia = true,
		featheredtwilight = true,
		imabot122356 = true,
		hobyboynum = true
	}, {
		[1] = 'Blue',
		[2] = 'Orange',
		[3] = 'Pink',
		[4] = 'Yellow'
	}, {}, {}, {}
	getgenv()._aerov4_staffCounts = {
		spec = 0,
		closet = 0,
		mod = 0,
		impossible = 0
	}
	local function refreshStaffCounts()
		local aJ = {
			spec = 0,
			closet = 0,
			mod = 0,
			impossible = 0
		}
		for aK, aL in pairs(ay) do
			local aM = aL.checktype
			if aM == 'spectator' then
				aJ.spec += 1
			elseif aM == 'closet' then
				aJ.closet += 1
			elseif aM == 'impossible_join' then
				aJ.impossible += 1
			else
				aJ.mod += 1
			end
		end
		getgenv()._aerov4_staffCounts = aJ
		b.StaffCountUpdate:Fire()
	end
	local function getRole(aJ, aK)
		local aL, aM = pcall(function()
			return aJ:GetRankInGroup(aK)
		end)
		if not aL then
			notif('StaffDetector', aM, 30, 'alert')
		end
		return aL and aM or 0
	end
	local function staffFunction(aJ, aK)
		if ay[aJ.UserId] then
			return
		end
		if not v.Loaded then
			repeat
				task.wait()
			until v.Loaded
		end
		local aL, aM, aN = aG.Value, aJ.Name, aJ.UserId
		ay[aN] = {
			name = aM,
			checktype = aK,
			detectedTime = tick()
		}
		local aO = 'Staff Detected (' .. aK .. '): ' .. aM .. ' (' .. aN .. ')'
		notif('StaffDetector', aO, aL, 'alert')
		H.customtags[aM] = {
			{
				text = 'GAME STAFF',
				color = Color3.new(1, 0, 0)
			}
		}
		if aH.Enabled then
			ar[aJ] = true
		end
		local aP = aK:find'clan'
		if aD.Enabled and not aP then
			pcall(O.PartyController.leaveParty)
		end
		local aQ = aB.Value
		if aQ == 'Uninject' then
			task.spawn(function()
				v:Uninject()
			end)
			game:GetService'StarterGui':SetCore('SendNotification', {
				Title = 'StaffDetector',
				Text = 'Staff Detected (' .. aK .. ')\n' .. aM .. ' (' .. aN .. ')',
				Duration = aL
			})
		elseif aQ == 'Requeue' then
			pcall(O.QueueController.leaveQueue)
			O.QueueController:joinQueue(L.queueType)
		elseif aQ == 'Profile' then
			v.Save = function()
			end
			if v.Profile ~= aE.Value then
				v:Load(true, aE.Value)
			end
		elseif aQ == 'AutoConfig' then
			local aR = {
				AutoClicker = true,
				Reach = true,
				Sprint = true,
				HitFix = true,
				StaffDetector = true
			}
			v.Save = function()
			end
			for aS, aT in v.Modules do
				if not (aR[aS] or aT.Category == 'Render') then
					if aT.Enabled then
						aT:Toggle()
					end
					aT:SetBind''
				end
			end
		end
		aA:Clean(e.PlayerRemoving:Connect(function(aR)
			if aH.Enabled then
				if ar[aR] then
					ar[aR] = nil
					notif('StaffDetector', "-938997667", 10, 'warning')
				end
			end
		end))
		refreshStaffCounts()
	end
	local function closetFunction(aJ)
		if ay[aJ.UserId] then
			return
		end
		if not v.Loaded then
			repeat
				task.wait()
			until v.Loaded
		end
		local aK, aL, aM, aN = aG.Value, aJ.Name, aJ.UserId, tonumber(aJ:GetAttribute'Team')
		local aO = aN and aw[aN] or 'Unknown'
		ay[aM] = {
			name = aL,
			checktype = 'closet',
			detectedTime = tick()
		}
		local aP = 'KNOWN CLOSETCHEATER: ' .. aL .. ' | Team: ' .. aO
		notif('StaffDetector', aP, aK, 'alert')
		H.customtags[aL] = {
			{
				text = 'CHEATER',
				color = Color3.fromRGB(255, 140, 0)
			}
		}
		refreshStaffCounts()
	end
	local function checkCloset(aJ)
		if not aI or not aI.Enabled then
			return false
		end
		if aJ == t then
			return false
		end
		local aK = aJ.Name:lower()
		if av[aK] then
			task.spawn(function()
				local aL = 0
				while not aJ:GetAttribute'Team' and aL < 10 do
					task.wait(0.5)
					aL = aL + 0.5
				end
				closetFunction(aJ)
			end)
			return true
		end
		return false
	end
	local function playerAdded(aJ)
		ax[aJ.UserId] = aJ.Name
		if aJ == t then
			return
		end
		if az[aJ.UserId] then
			return
		end
		az[aJ.UserId] = true
		if checkCloset(aJ) then
			az[aJ.UserId] = nil
			return
		end
		if table.find(au, aJ.UserId) or (aF and table.find(aF.ListEnabled, tostring(aJ.UserId))) then
			staffFunction(aJ, 'blacklisted_user')
			az[aJ.UserId] = nil
			return
		end
		if getRole(aJ, 5774246) >= 100 then
			staffFunction(aJ, 'staff_role')
			az[aJ.UserId] = nil
			return
		end
		local function spectatorFunction(aK)
			if ay[aK.UserId] then
				return
			end
			if not v.Loaded then
				repeat
					task.wait()
				until v.Loaded
			end
			local aL, aM, aN = aG.Value, aK.Name, aK.UserId
			ay[aN] = {
				name = aM,
				checktype = 'spectator',
				detectedTime = tick()
			}
			local aO = 'Spectator: ' .. aM .. ' (' .. tostring(aN) .. ') [Has friend in server]'
			notif('StaffDetector', aO, aL, 'warning')
			refreshStaffCounts()
		end
		local function checkJoin()
			if not aJ:GetAttribute'Team' and aJ:GetAttribute'Spectator' then
				local aK = false
				for aL, aM in ipairs(e:GetPlayers()) do
					if aM ~= aJ then
						local aN, aO = pcall(function()
							return aJ:IsFriendsWith(aM.UserId)
						end)
						if aN and aO then
							aK = true
							break
						end
					end
				end
				if aK then
					spectatorFunction(aJ)
				else
					staffFunction(aJ, 'impossible_join')
				end
				return true
			end
			return false
		end
		local aK
		aK = aJ:GetAttributeChangedSignal'Spectator':Connect(function()
			if checkJoin() then
				aK:Disconnect()
				az[aJ.UserId] = nil
			end
		end)
		aA:Clean(aK)
		if checkJoin() then
			az[aJ.UserId] = nil
			return
		end
		if aC.Enabled then
			local function checkClanTag()
				local aL = aJ:GetAttribute'ClanTag'
				if aL and table.find(at, aL) then
					staffFunction(aJ, 'blacklisted_clan_' .. aL:lower())
				end
			end
			if aJ:GetAttribute'ClanTag' then
				checkClanTag()
			else
				local aL
				aL = aJ:GetAttributeChangedSignal'ClanTag':Connect(function()
					aL:Disconnect()
					checkClanTag()
				end)
				aA:Clean(aL)
				task.delay(5, function()
					if aL then
						aL:Disconnect()
					end
				end)
			end
		end
		az[aJ.UserId] = nil
	end
	local function playerRemoving(aJ)
		local aK = aJ.UserId
		ax[aK] = nil
		az[aK] = nil
		if ay[aK] then
			local aL = ay[aK]
			local aM = aL.name .. ' (' .. aL.checktype .. ') has left the server'
			notif('StaffDetector', aM, aG.Value, 'warning')
			if H.customtags[aL.name] then
				H.customtags[aL.name] = nil
			end
			ay[aK] = nil
			refreshStaffCounts()
		end
	end
	aA = v.Categories.Utility:CreateModule{
		Name = 'StaffDetector',
		Function = function(aJ)
			if aJ then
				aA:Clean(e.PlayerAdded:Connect(playerAdded))
				aA:Clean(e.PlayerRemoving:Connect(playerRemoving))
				for aK, aL in e:GetPlayers() do
					task.spawn(playerAdded, aL)
				end
			else
				table.clear(ax)
				table.clear(az)
				table.clear(ay)
				refreshStaffCounts()
			end
		end,
		Tooltip = 'Detects people with a staff rank ingame'
	}
	aB = aA:CreateDropdown{
		Name = 'Mode',
		List = {
			'Uninject',
			'Profile',
			'Requeue',
			'AutoConfig',
			'Notify'
		},
		Function = function(aJ)
			if aE.Object then
				aE.Object.Visible = aJ == 'Profile'
			end
		end
	}
	aG = aA:CreateSlider{
		Name = 'Alert Duration',
		Min = 5,
		Max = 120,
		Default = 60,
		Suffix = 's',
		Tooltip = 'How long the alert notification stays on screen'
	}
	aC = aA:CreateToggle{
		Name = 'Blacklist clans',
		Default = true
	}
	aD = aA:CreateToggle{
		Name = 'Leave party'
	}
	aI = aA:CreateToggle{
		Name = 'Known Cheaters',
		Default = true,
		Tooltip = 'Alerts when a known closet cheater joins your game'
	}
	aE = aA:CreateTextBox{
		Name = 'Profile',
		Default = 'default',
		Darker = true,
		Visible = false
	}
	aF = aA:CreateTextList{
		Name = 'Users',
		Placeholder = 'player (userid)',
		Function = function()
		end
	}
	aH = aA:CreateToggle{
		Name = 'Leave Detection',
		Tooltip = 'when an impossible/blacklisted/staff detection has happend and when they leave it notifs you.'
	}
	task.defer(function()
		if aE and aE.Object then
			aE.Object.Visible = (aB.Value == 'Profile')
		end
	end)
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF = 5774246, 100, {
		phantomviperr2 = true,
		gavin2015shadow = true,
		clocksurge = true,
		amcoolll3 = true,
		zorflow = true,
		dreamingnostaigia = true,
		featheredtwilight = true,
		imabot122356 = true,
		hobyboynum = true
	}, {
		1502104539,
		3826146717,
		4531785383,
		1049767300,
		4926350670,
		653085195,
		184655415,
		2752307430,
		5087196317,
		5744061325,
		1536265275
	}, {
		{
			key = 'spec',
			label = 'Spec',
			color = Color3.fromRGB(100, 180, 255),
			order = 1
		},
		{
			key = 'closet',
			label = 'Closet',
			color = Color3.fromRGB(255, 140, 0),
			order = 2
		},
		{
			key = 'mod',
			label = 'Mod',
			color = Color3.fromRGB(255, 60, 60),
			order = 3
		},
		{
			key = 'impossible',
			label = 'Impossible',
			color = Color3.fromRGB(200, 50, 255),
			order = 4
		}
	}, {}, {
		spec = 0,
		closet = 0,
		mod = 0,
		impossible = 0
	}, {}, (Instance.new'ScreenGui')
	aA.Name = 'StaffHUD'
	aA.ResetOnSpawn = false
	aA.DisplayOrder = 15
	aA.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	aA.Parent = v.gui
	aA.Enabled = false
	local aG = Instance.new'Frame'
	aG.Name = 'Container'
	aG.Parent = aA
	aG.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	aG.BackgroundTransparency = 0.3
	aG.BorderSizePixel = 0
	aG.AnchorPoint = Vector2.new(1, 1)
	aG.Position = UDim2.new(1, - 8, 1, - 8)
	aG.Size = UDim2.new(0, 110, 0, 14)
	aG.AutomaticSize = Enum.AutomaticSize.Y
	local aH = Instance.new'UICorner'
	aH.CornerRadius = UDim.new(0, 6)
	aH.Parent = aG
	local aI = Instance.new'UIPadding'
	aI.PaddingLeft = UDim.new(0, 6)
	aI.PaddingRight = UDim.new(0, 6)
	aI.PaddingTop = UDim.new(0, 4)
	aI.PaddingBottom = UDim.new(0, 4)
	aI.Parent = aG
	local aJ = Instance.new'UIListLayout'
	aJ.SortOrder = Enum.SortOrder.LayoutOrder
	aJ.Padding = UDim.new(0, 2)
	aJ.Parent = aG
	local aK = {}
	for aL, aM in aw do
		local aN = Instance.new'TextLabel'
		aN.Name = aM.key
		aN.Parent = aG
		aN.BackgroundTransparency = 1
		aN.Size = UDim2.new(1, 0, 0, 13)
		aN.TextColor3 = aM.color
		aN.TextSize = 11
		aN.Font = Enum.Font.GothamBold
		aN.TextXAlignment = Enum.TextXAlignment.Left
		aN.TextStrokeTransparency = 0.4
		aN.TextStrokeColor3 = Color3.new(0, 0, 0)
		aN.LayoutOrder = aM.order
		aN.Visible = false
		aK[aM.key] = aN
	end
	local function updateDisplay()
		if not aB or not aB.Enabled then
			aA.Enabled = false
			return
		end
		local aL, aM = {
			spec = aC,
			closet = aD,
			mod = aE,
			impossible = aF
		}, false
		for aN, aO in aw do
			local aP = aL[aO.key] and aL[aO.key].Enabled
			aK[aO.key].Text = aO.label .. ': ' .. (ay[aO.key] or 0)
			aK[aO.key].Visible = aP
			if aP then
				aM = true
			end
		end
		aA.Enabled = aM
	end
	local function setTracked(aL, aM)
		local aN = ax[aL]
		if aN == aM then
			return
		end
		if aN then
			ay[aN] = math.max(0, (ay[aN] or 1) - 1)
		end
		if aM then
			ax[aL] = aM
			ay[aM] = (ay[aM] or 0) + 1
		else
			ax[aL] = nil
		end
		updateDisplay()
	end
	local function removePlayer(aL)
		setTracked(aL, nil)
		if az[aL] then
			for aM, aN in ipairs(az[aL]) do
				pcall(function()
					aN:Disconnect()
				end)
			end
			az[aL] = nil
		end
	end
	local function hasFriendInServer(aL)
		for aM, aN in ipairs(e:GetPlayers()) do
			if aN ~= aL then
				local aO, aP = pcall(function()
					return aL:IsFriendsWith(aN.UserId)
				end)
				if aO and aP then
					return true
				end
			end
		end
		return false
	end
	local function recheckSpec(aL)
		if not aB or not aB.Enabled then
			return
		end
		local aM = ax[aL.UserId]
		if aM == 'closet' or aM == 'mod' then
			return
		end
		if aL:GetAttribute'Spectator' == true then
			task.spawn(function()
				local aN = hasFriendInServer(aL)
				setTracked(aL.UserId, aN and 'spec' or 'impossible')
			end)
		else
			if aM == 'spec' or aM == 'impossible' then
				setTracked(aL.UserId, nil)
			end
		end
	end
	local function watchPlayer(aL)
		if aL == t or az[aL.UserId] then
			return
		end
		local aM = {}
		table.insert(aM, aL:GetAttributeChangedSignal'Spectator':Connect(function()
			recheckSpec(aL)
		end))
		table.insert(aM, aL:GetAttributeChangedSignal'Team':Connect(function()
			recheckSpec(aL)
		end))
		az[aL.UserId] = aM
	end
	local function classifyPlayer(aL)
		if aL == t then
			return
		end
		if au[aL.Name:lower()] or table.find(av, aL.UserId) then
			setTracked(aL.UserId, 'closet')
			watchPlayer(aL)
			return
		end
		watchPlayer(aL)
		recheckSpec(aL)
		task.spawn(function()
			if not aB or not aB.Enabled then
				return
			end
			local aM, aN = pcall(function()
				return aL:GetRankInGroup(ar)
			end)
			if aM and aN >= at then
				setTracked(aL.UserId, 'mod')
			end
		end)
	end
	local function cleanAll()
		for aL, aM in pairs(az) do
			for aN, aO in ipairs(aM) do
				pcall(function()
					aO:Disconnect()
				end)
			end
		end
		table.clear(az)
		table.clear(ax)
		ay = {
			spec = 0,
			closet = 0,
			mod = 0,
			impossible = 0
		}
	end
	aB = v.Categories.Utility:CreateModule{
		Name = 'StaffHUD',
		Function = function(aL)
			if aL then
				cleanAll()
				for aM, aN in ipairs(e:GetPlayers()) do
					classifyPlayer(aN)
				end
				aB:Clean(e.PlayerAdded:Connect(function(aM)
					classifyPlayer(aM)
				end))
				aB:Clean(e.PlayerRemoving:Connect(function(aM)
					removePlayer(aM.UserId)
				end))
				updateDisplay()
			else
				cleanAll()
				aA.Enabled = false
			end
		end,
		Tooltip = 'Live corner counter: Spectators, Closet Cheaters, Mods and Impossible Joins'
	}
	aC = aB:CreateToggle{
		Name = 'Spectators',
		Default = true,
		Function = function()
			updateDisplay()
		end
	}
	aD = aB:CreateToggle{
		Name = 'Closet Cheaters',
		Default = true,
		Function = function()
			updateDisplay()
		end
	}
	aE = aB:CreateToggle{
		Name = 'Mods',
		Default = true,
		Function = function()
			updateDisplay()
		end
	}
	aF = aB:CreateToggle{
		Name = 'Impossible Joins',
		Default = true,
		Function = function()
			updateDisplay()
		end
	}
	v:Clean(function()
		cleanAll()
		pcall(function()
			aA:Destroy()
		end)
	end)
end)
a(function()
	local ar = cloneRaycast()
	ar.RespectCanCollide = true
	local at, au
	v.Categories.World:CreateModule{
		Name = 'SafeWalk',
		Function = function(av)
			if av then
				if not at then
					local aw = pcall(function()
						at = require(t.PlayerScripts.PlayerModule).controls
					end)
					if not aw then
						at = {}
					end
				end
				au = at.moveFunction
				at.moveFunction = function(aw, ax, ay)
					if B.isAlive then
						ar.FilterDescendantsInstances = {
							t.Character,
							s
						}
						local az = B.character.RootPart
						local aA = az.Position + ax
						local aB = game.Workspace:Raycast(aA, Vector3.new(0, - 15, 0), ar)
						if not aB then
							local aC = game.Workspace:Blockcast(az.CFrame, Vector3.new(3, 1, 3), Vector3.new(0, - (B.character.HipHeight + 1), 0), ar)
							if aC then
								ax = (aC.Instance:GetClosestPointOnSurface(aA) - az.Position) * Vector3.new(1, 0, 1)
							end
						end
					end
					return au(aw, ax, ay)
				end
			else
				if at and au then
					at.moveFunction = au
				end
			end
		end,
		Tooltip = '"I need safe walk to main jugg" - desire'
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH = 0, 0, 0.65, 22, false
	local function getSummonerController()
		if aH then
			return aH
		end
		pcall(function()
			aH = O.KnitClient.Controllers.SummonerKitController
		end)
		return aH
	end
	local function isActuallyCharging()
		if aw then
			return true
		end
		local aI = getSummonerController()
		if aI then
			local aJ, aK = pcall(function()
				return aI:isPlayerCastingSpell(t)
			end)
			if aJ and aK then
				return true
			end
		end
		return false
	end
	local function getSpellLevel()
		local aI = 1
		pcall(function()
			local aJ = require(game:GetService'ReplicatedStorage'.TS.games.bedwars.kit.kits.summoner['summoner-kit-util'])
			local aK = aJ.summoner_getPlayerSpellLevel(t)
			if aK then
				aI = aK
			end
		end)
		return aI
	end
	local function getCastTime(aI)
		local aJ = 2
		pcall(function()
			local aK = require(game:GetService'ReplicatedStorage'.TS.games.bedwars.kit.kits.summoner['summoner-kit-util'])
			local aL = aK.summoner_getTotalCastTimeRequired(aI)
			if aL then
				aJ = aL
			end
		end)
		return aJ
	end
	local function fireUseAbility(aI)
		pcall(function()
			game:GetService'ReplicatedStorage':WaitForChild'events-@easy-games/game-core:shared/game-core-networking@getEvents.Events':WaitForChild'useAbility':FireServer(aI)
		end)
	end
	local function doAutoAbility()
		if aw then
			return
		end
		aw = true
		fireUseAbility'summoner_start_charging'
		local aI = getSpellLevel()
		local aJ = getCastTime(aI)
		task.wait(math.max(aJ, 0.5))
		if aw then
			fireUseAbility'summoner_finish_charging'
		end
		at = tick()
		aw = false
	end
	local function getPlayerClawLevel()
		local aI = t.Character and t.Character:FindFirstChild'HandInvItem'
		if aI and aI.Value then
			local aJ = aI.Value.Name
			if aJ == 'summoner_claw_1' then
				return 1
			end
			if aJ == 'summoner_claw_2' then
				return 2
			end
			if aJ == 'summoner_claw_3' then
				return 3
			end
			if aJ == 'summoner_claw_4' then
				return 4
			end
		end
		if L and L.inventory and L.inventory.hotbar then
			for aJ, aK in pairs(L.inventory.hotbar) do
				if aK.item then
					local aL = aK.item.itemType
					if aL == 'summoner_claw_1' then
						return 1
					end
					if aL == 'summoner_claw_2' then
						return 2
					end
					if aL == 'summoner_claw_3' then
						return 3
					end
					if aL == 'summoner_claw_4' then
						return 4
					end
				end
			end
		end
		return 1
	end
	ax = v.Categories.Kits:CreateModule{
		Name = 'AutoKaida',
		Function = function(aI)
			if aI then
				ar = 0
				at = 0
				aw = false
				repeat
					if not B.isAlive then
						task.wait(0.1)
						continue
					end
					if aC.Enabled then
						if O.AppController:isLayerOpen(O.UILayers.MAIN) then
							task.wait(0.1)
							continue
						end
					end
					local aJ, aK = t.Character:FindFirstChild'HandInvItem', false
					if aJ and aJ.Value then
						aK = aJ.Value.Name:find'summoner_claw' ~= nil
					end
					if not aK then
						task.wait(0.1)
						continue
					end
					if aB.Enabled then
						if not h:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
							task.wait(1.2)
							continue
						end
					end
					local aL = B.EntityPosition{
						Range = az.Value,
						Part = 'RootPart',
						Players = ay.Players.Enabled,
						NPCs = ay.NPCs.Enabled,
						Wallcheck = ay.Walls.Enabled or nil
					}
					if aL then
						local aM = B.character.RootPart.Position
						local aN, aO = (aM - aL.RootPart.Position).Magnitude, tick()
						if aE.Enabled and aN <= aF.Value then
							if not aw and (aO - at) >= av then
								task.spawn(doAutoAbility)
							end
						end
						local aP = isActuallyCharging()
						if not aG.Enabled and aP then
							task.wait(0.05)
							continue
						end
						if (aO - ar) >= au then
							local aQ = CFrame.lookAt(aM, aL.RootPart.Position).LookVector
							aM += aQ * math.max((aM - aL.RootPart.Position).Magnitude - 16, 0)
							ar = aO
							if aD.Enabled then
								task.spawn(function()
									pcall(function()
										local aR = getPlayerClawLevel()
										O.AnimationUtil:playAnimation(t, O.GameAnimationUtil:getAssetId(O.AnimationType.SUMMONER_CHARACTER_SWIPE), {
											looped = false
										})
										local aS, aT = f.Assets.Misc.Kaida.Summoner_DragonClaw:Clone(), {
											Color3.fromRGB(75, 75, 75),
											Color3.fromRGB(255, 255, 255),
											Color3.fromRGB(43, 229, 229),
											Color3.fromRGB(49, 229, 94)
										}
										local aU = aS:FindFirstChild'dragon_claw_nail_mesh'
										if aU and aU:IsA'MeshPart' then
											aU.Color = aT[aR] or aT[1]
										end
										if O.KnightClient and O.KnightClient.Controllers.SummonerKitSkinController then
											if O.KnightClient.Controllers.SummonerKitSkinController:isPrismaticSkin(t) then
												O.KnightClient.Controllers.SummonerKitSkinController:applyClawRGB(aS)
											end
										end
										aS.Parent = workspace
										local aV = workspace.CurrentCamera
										if aV and (aV.CFrame.Position - B.character.RootPart.Position).Magnitude < 1 then
											for aW, aX in aS:GetDescendants() do
												if aX:IsA'MeshPart' then
													aX.Transparency = 0.6
												end
											end
										end
										local aW, aX = B.character.RootPart, Vector3.new(aQ.X, 0, aQ.Z).Unit
										local aY = aW.Position + aX:Cross(Vector3.new(0, 1, 0)).Unit * - 1 * 5 + aX * 6
										local aZ = (aY + aQ * 13 - aY).Unit
										local a_ = CFrame.new(aY, aY + aZ)
										aS:PivotTo(a_)
										aS.PrimaryPart.Anchored = true
										if aS:FindFirstChild'AnimationController' then
											local a0 = aS.AnimationController:FindFirstChildOfClass'Animator'
											if a0 then
												O.AnimationUtil:playAnimation(a0, O.GameAnimationUtil:getAssetId(O.AnimationType.SUMMONER_CLAW_ATTACK), {
													looped = false,
													speed = 1
												})
											end
										end
										pcall(function()
											local a0 = {
												O.SoundList.SUMMONER_CLAW_ATTACK_1,
												O.SoundList.SUMMONER_CLAW_ATTACK_2,
												O.SoundList.SUMMONER_CLAW_ATTACK_3,
												O.SoundList.SUMMONER_CLAW_ATTACK_4
											}
											O.SoundManager:playSound(a0[math.random(1, # a0)], {
												position = aW.Position
											})
										end)
										task.wait(0.75)
										aS:Destroy()
									end)
								end)
							end
							O.Client:Get(P.SummonerClawAttack):SendToServer{
								position = aM,
								direction = aQ,
								clientTime = workspace:GetServerTimeNow()
							}
						end
					else
						if aw then
							aw = false
							fireUseAbility'summoner_finish_charging'
						end
					end
					task.wait(1 / aA.Value)
				until not ax.Enabled
				aw = false
			end
		end,
		Tooltip = 'Auto attacks with Summoner claw'
	}
	ay = ax:CreateTargets{
		Players = true,
		NPCs = true,
		Walls = true
	}
	az = ax:CreateSlider{
		Name = 'Attack Range',
		Min = 1,
		Max = 32,
		Default = 22,
		Suffix = function(aI)
			return aI == 1 and 'stud' or 'studs'
		end
	}
	aA = ax:CreateSlider{
		Name = 'Update Rate',
		Min = 1,
		Max = 120,
		Default = 60,
		Suffix = 'hz'
	}
	aB = ax:CreateToggle{
		Name = 'Require Mouse Down',
		Tooltip = 'Only attacks while holding left click'
	}
	aC = ax:CreateToggle{
		Name = 'GUI Check'
	}
	aD = ax:CreateToggle{
		Name = 'Show Animation',
		Default = true
	}
	aG = ax:CreateToggle{
		Name = 'Swing During Ability',
		Default = true,
		Tooltip = 'Continue claw attacks while charging ability'
	}
	aE = ax:CreateToggle{
		Name = 'Auto Ability',
		Default = false,
		Tooltip = 'Automatically uses ability when enemy is within distance',
		Function = function(aI)
			if not aI then
				aw = false
			end
			aF.Object.Visible = aI
		end
	}
	aF = ax:CreateSlider{
		Name = 'Ability Distance',
		Min = 3,
		Max = 15,
		Default = 6,
		Visible = false,
		Tooltip = 'Distance to trigger ability',
		Suffix = function(aI)
			return aI == 1 and 'stud' or 'studs'
		end
	}
	task.defer(function()
		if aF and aF.Object then
			aF.Object.Visible = false
		end
	end)
end)
a(function()
	local ar
	local function removePlayerLevels(at)
		for au, av in at:GetDescendants() do
			if av:IsA'TextLabel' and av.Name == 'PlayerLevel' then
				av:Destroy()
			end
		end
	end
	ar = v.Categories.Render:CreateModule{
		Name = 'RemovePlayerLevelUI',
		Function = function(at)
			if at then
				local au = t.PlayerGui:FindFirstChild'TabListScreenGui'
				if au then
					removePlayerLevels(au)
				end
				ar:Clean(t.PlayerGui.ChildAdded:Connect(function(av)
					if av.Name == 'TabListScreenGui' then
						removePlayerLevels(av)
						ar:Clean(av.DescendantAdded:Connect(function(aw)
							if aw:IsA'TextLabel' and aw.Name == 'PlayerLevel' then
								aw:Destroy()
							end
						end))
					end
				end))
			end
		end,
		Tooltip = 'Removes player levels from the TabList'
	}
end)
a(function()
	local ar, at, au, av, aw, ax = {}, {}, {}, {}, {}
	local function getWorldFolder()
		local ay = workspace:WaitForChild('Map', math.huge)
		local az = ay:WaitForChild('Worlds', math.huge)
		if not az then
			return nil
		end
		return az:GetChildren()[1]
	end
	local ay = getWorldFolder()
	if not ay then
		return
	end
	local az = ay:WaitForChild'Blocks'
	local function isValidWoolBlock(aA)
		if not aA:IsA'BasePart' then
			return false
		end
		if aA.Name ~= 'wool_orange' and aA.Name ~= 'wool_pink' then
			return false
		end
		local aB = aA.Parent
		if aB then
			if aB.Name == 'Viewmodel' or aB.Parent and aB.Parent.Name == 'Viewmodel' then
				return false
			end
			if aB:IsA'Accessory' or aB:IsA'Tool' then
				return false
			end
			local aC = aB
			while aC do
				if aC:IsA'Model' and e:GetPlayerFromCharacter(aC) then
					return false
				end
				aC = aC.Parent
			end
		end
		return true
	end
	local function removeNumTeamMembers(aA)
		if not aA then
			return
		end
		local aB = aA:FindFirstChild'TopBarApp'
		if not aB then
			return
		end
		local aC = aB:FindFirstChild'5'
		if not aC then
			return
		end
		local aD = aC:FindFirstChild'4'
		if not aD then
			return
		end
		for aE, aF in pairs{
			'2',
			'3',
			'4',
			'5'
		} do
			local aG = aD:FindFirstChild(aF)
			if aG and aG:IsA'Frame' then
				local aH = aG:FindFirstChild'NumTeamMembers'
				if aH and aH:IsA'TextLabel' then
					aw[aH] = {
						Parent = aH.Parent,
						Name = aH.Name,
						Text = aH.Text,
						Position = aH.Position,
						Size = aH.Size,
						Visible = aH.Visible
					}
					aH:Destroy()
				end
			end
		end
	end
	local function restoreNumTeamMembers()
		for aA, aB in pairs(aw) do
			if aB.Parent and aB.Parent.Parent then
				local aC = Instance.new'TextLabel'
				aC.Name = aB.Name
				aC.Text = aB.Text
				aC.Position = aB.Position
				aC.Size = aB.Size
				aC.Visible = aB.Visible
				aC.Parent = aB.Parent
			end
		end
		table.clear(aw)
	end
	ax = v.Categories.Render:CreateModule{
		Name = 'OG4v4v4v4',
		Function = function(aA)
			if aA then
				local aB = Instance.new'MaterialVariant'
				aB.Parent = c(game:GetService'MaterialService')
				aB.Name = 'rbxassetid://16991768606_red'
				aB.ColorMap = 'rbxassetid://16991768606'
				aB.StudsPerTile = 3
				aB.RoughnessMap = 'rbxassetid://16991768606'
				aB.BaseMaterial = 'Fabric'
				local aC = Instance.new'MaterialVariant'
				aC.Parent = c(game:GetService'MaterialService')
				aC.Name = 'rbxassetid://16991768606_green'
				aC.ColorMap = 'rbxassetid://16991768606'
				aC.StudsPerTile = 3
				aC.RoughnessMap = 'rbxassetid://16991768606'
				aC.BaseMaterial = 'Fabric'
				local aD = t.PlayerGui:FindFirstChild'TopBarAppGui'
				if aD then
					removeNumTeamMembers(aD)
				end
				ax:Clean(t.PlayerGui.ChildAdded:Connect(function(aE)
					if aE.Name == 'TopBarAppGui' then
						removeNumTeamMembers(aE)
						ax:Clean(aE.DescendantAdded:Connect(function(aF)
							if aF:IsA'Frame' and (aF.Name == '2' or aF.Name == '3' or aF.Name == '4' or aF.Name == '5') then
								local aG = aF.Parent
								if aG and aG.Name == '4' then
									local aH = aG.Parent
									if aH and aH.Name == '5' then
										local aI = aH.Parent
										if aI and aI.Name == 'TopBarApp' then
											task.wait(0.1)
											local aJ = aF:FindFirstChild'NumTeamMembers'
											if aJ and aJ:IsA'TextLabel' then
												aw[aJ] = {
													Parent = aJ.Parent,
													Name = aJ.Name,
													Text = aJ.Text,
													Position = aJ.Position,
													Size = aJ.Size,
													Visible = aJ.Visible
												}
												aJ:Destroy()
											end
										end
									end
								end
							end
						end))
					end
				end))
				local aE = s:FindFirstChild'Viewmodel'
				if aE then
					ax:Clean(aE.ChildAdded:Connect(function(aF)
						if aF.Name == 'wool_orange' then
							task.wait(0.01)
							if aF:FindFirstChild'Handle' then
								for aG, aH in aF:FindFirstChild'Handle':GetChildren() do
									if aH:IsA'Texture' then
										au[aH] = aH.Texture
										av[aH] = aH.Color3
										aH.Texture = 'rbxassetid://16991768606'
										aH.Color3 = Color3.fromRGB(196, 40, 28)
									end
								end
							end
						elseif aF.Name == 'wool_pink' then
							task.wait(0.01)
							if aF:FindFirstChild'Handle' then
								for aG, aH in aF:FindFirstChild'Handle':GetChildren() do
									if aH:IsA'Texture' then
										au[aH] = aH.Texture
										av[aH] = aH.Color3
										aH.Texture = 'rbxassetid://16991768606'
										aH.Color3 = Color3.fromRGB(15, 185, 55)
									end
								end
							end
						end
					end))
				end
				ax:Clean(t.Character.ChildAdded:Connect(function(aF)
					if aF.Name == 'wool_orange' then
						task.wait(0.01)
						if aF:FindFirstChild'Handle' then
							for aG, aH in aF:FindFirstChild'Handle':GetChildren() do
								if aH:IsA'Texture' then
									au[aH] = aH.Texture
									av[aH] = aH.Color3
									aH.Texture = 'rbxassetid://16991768606'
									aH.Color3 = Color3.fromRGB(196, 40, 28)
								end
							end
						end
					elseif aF.Name == 'wool_pink' then
						task.wait(0.01)
						if aF:FindFirstChild'Handle' then
							for aG, aH in aF:FindFirstChild'Handle':GetChildren() do
								if aH:IsA'Texture' then
									au[aH] = aH.Texture
									av[aH] = aH.Color3
									aH.Texture = 'rbxassetid://16991768606'
									aH.Color3 = Color3.fromRGB(15, 185, 55)
								end
							end
						end
					end
				end))
				ax:Clean(az.ChildAdded:Connect(function(aF)
					if aF.Name == 'wool_orange' and isValidWoolBlock(aF) then
						ar[aF] = aF.MaterialVariant
						at[aF] = aF.Color
						aF.MaterialVariant = 'rbxassetid://16991768606_red'
						aF.Color = Color3.fromRGB(196, 40, 28)
					elseif aF.Name == 'wool_pink' and isValidWoolBlock(aF) then
						ar[aF] = aF.MaterialVariant
						at[aF] = aF.Color
						aF.MaterialVariant = 'rbxassetid://16991768606_green'
						aF.Color = Color3.fromRGB(15, 185, 55)
					end
				end))
				ax:Clean(workspace.ChildAdded:Connect(function(aF)
					if aF.Name == 'wool_orange' and isValidWoolBlock(aF) then
						ar[aF] = aF.MaterialVariant
						at[aF] = aF.Color
						aF.MaterialVariant = 'rbxassetid://16991768606_red'
						aF.Color = Color3.fromRGB(196, 40, 28)
					elseif aF.Name == 'wool_pink' and isValidWoolBlock(aF) then
						ar[aF] = aF.MaterialVariant
						at[aF] = aF.Color
						aF.MaterialVariant = 'rbxassetid://16991768606_green'
						aF.Color = Color3.fromRGB(15, 185, 55)
					end
				end))
				for aF, aG in az:GetChildren() do
					if aG.Name == 'wool_orange' and isValidWoolBlock(aG) then
						ar[aG] = aG.MaterialVariant
						at[aG] = aG.Color
						aG.MaterialVariant = 'rbxassetid://16991768606_red'
						aG.Color = Color3.fromRGB(196, 40, 28)
					elseif aG.Name == 'wool_pink' and isValidWoolBlock(aG) then
						ar[aG] = aG.MaterialVariant
						at[aG] = aG.Color
						aG.MaterialVariant = 'rbxassetid://16991768606_green'
						aG.Color = Color3.fromRGB(15, 185, 55)
					end
				end
				task.spawn(function()
					while ax.Enabled do
						local aF = t.PlayerGui:FindFirstChild'TopBarAppGui'
						if aF then
							for aG, aH in aF:GetDescendants() do
								if aH:IsA'Frame' and aH.Name == '3' then
									if aH.BackgroundColor3 == Color3.fromRGB(242, 142, 41) then
										aH.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
										if aH.Parent then
											for aI, aJ in aH.Parent:GetChildren() do
												if aJ:IsA'UIStroke' then
													aJ.Color = Color3.fromRGB(196, 40, 28)
												end
											end
										end
									elseif aH.BackgroundColor3 == Color3.fromRGB(255, 102, 204) or aH.BackgroundColor3 == Color3.fromRGB(255, 85, 255) or aH.BackgroundColor3 == Color3.fromRGB(218, 133, 222) then
										aH.BackgroundColor3 = Color3.fromRGB(15, 185, 55)
										if aH.Parent then
											for aI, aJ in aH.Parent:GetChildren() do
												if aJ:IsA'UIStroke' then
													aJ.Color = Color3.fromRGB(15, 185, 55)
												end
											end
										end
									end
								end
							end
						end
						task.wait(0.5)
					end
				end)
				ax:Clean(t.PlayerGui.ChildAdded:Connect(function(aF)
					if aF.Name == 'TabListScreenGui' then
						for aG, aH in aF:GetDescendants() do
							if aH:IsA'Frame' and aH.Name == '2' then
								if aH.BackgroundColor3 == Color3.fromRGB(242, 142, 41) then
									aH.BackgroundColor3 = Color3.fromRGB(196, 40, 28)
									if aH.Parent then
										for aI, aJ in aH.Parent:GetChildren() do
											if aJ:IsA'UIStroke' then
												aJ.Color = Color3.fromRGB(196, 40, 28)
											end
										end
									end
									if aH:FindFirstChild'TeamName' then
										aH:FindFirstChild'TeamName'.RichText = true
										aH:FindFirstChild'TeamName'.Text = '<b>Red Team</b>'
									end
								elseif aH.BackgroundColor3 == Color3.fromRGB(255, 102, 204) or aH.BackgroundColor3 == Color3.fromRGB(255, 85, 255) or aH.BackgroundColor3 == Color3.fromRGB(218, 133, 222) then
									aH.BackgroundColor3 = Color3.fromRGB(15, 185, 55)
									if aH.Parent then
										for aI, aJ in aH.Parent:GetChildren() do
											if aJ:IsA'UIStroke' then
												aJ.Color = Color3.fromRGB(15, 185, 55)
											end
										end
									end
									if aH:FindFirstChild'TeamName' then
										aH:FindFirstChild'TeamName'.RichText = true
										aH:FindFirstChild'TeamName'.Text = '<b>Green Team</b>'
									end
								end
							end
						end
					end
				end))
			else
				for aB, aC in t.PlayerGui:FindFirstChild'TopBarAppGui':GetDescendants() do
					if aC:IsA'Frame' and aC.Name == '3' then
						if aC.BackgroundColor3 == Color3.fromRGB(196, 40, 28) then
							aC.BackgroundColor3 = Color3.fromRGB(242, 142, 41)
							if aC.Parent then
								for aD, aE in aC.Parent:GetChildren() do
									if aE:IsA'UIStroke' then
										aE.Color = Color3.fromRGB(242, 142, 41)
									end
								end
							end
						elseif aC.BackgroundColor3 == Color3.fromRGB(15, 185, 55) then
							aC.BackgroundColor3 = Color3.fromRGB(255, 102, 204)
							if aC.Parent then
								for aD, aE in aC.Parent:GetChildren() do
									if aE:IsA'UIStroke' then
										aE.Color = Color3.fromRGB(255, 102, 204)
									end
								end
							end
						end
					end
				end
				restoreNumTeamMembers()
				for aB, aC in pairs(au) do
					if aB and aB.Parent then
						aB.Texture = aC
					end
				end
				for aB, aC in pairs(av) do
					if aB and aB.Parent then
						aB.Color3 = aC
					end
				end
				for aB, aC in pairs(ar) do
					if aB and aB.Parent then
						aB.MaterialVariant = aC
						if at[aB] then
							aB.Color = at[aB]
						end
					end
				end
				table.clear(ar)
				table.clear(at)
				table.clear(au)
				table.clear(av)
			end
		end,
		Tooltip = 'OG team colors: Orange->Red, Pink->Dark Green + Remove NumTeamMembers'
	}
end)
a(function()
	local ar, at, au, av = {}, {}
	local function removeNametag(aw)
		if not au or not au.Enabled then
			return
		end
		if not aw then
			return
		end
		local ax = aw:FindFirstChild'Head'
		if not ax then
			return
		end
		pcall(function()
			local ay = ax:FindFirstChild'Nametag'
			if ay then
				if not ar[aw] then
					ar[aw] = ay:Clone()
				end
				ay:Destroy()
			end
		end)
	end
	local function restoreNametag(aw)
		if not aw then
			return
		end
		local ax = aw:FindFirstChild'Head'
		if not ax then
			return
		end
		pcall(function()
			local ay = ax:FindFirstChild'Nametag'
			if ay then
				ay:Destroy()
			end
			if ar[aw] then
				local az = ar[aw]:Clone()
				az.Parent = ax
				az.Visible = true
				ar[aw] = nil
			end
		end)
	end
	au = v.Categories.Utility:CreateModule{
		Name = 'NoNameTag',
		Tooltip = 'Removes nametags for all players',
		Function = function(aw)
			if aw then
				av = g.RenderStepped:Connect(function()
					pcall(function()
						for ax, ay in e:GetPlayers() do
							if ay.Character then
								removeNametag(ay.Character)
							end
						end
						for ax, ay in l:GetTagged'entity' do
							if ay:IsA'Model' then
								removeNametag(ay)
							end
						end
					end)
				end)
				for ax, ay in e:GetPlayers() do
					if ay.Character then
						removeNametag(ay.Character)
					end
					local az = ay.CharacterAdded:Connect(function(az)
						task.wait(0.5)
						if au.Enabled then
							removeNametag(az)
						end
					end)
					table.insert(at, az)
				end
				local ax = e.PlayerAdded:Connect(function(ax)
					if ax.Character then
						removeNametag(ax.Character)
					end
					local ay = ax.CharacterAdded:Connect(function(ay)
						task.wait(0.5)
						if au.Enabled then
							removeNametag(ay)
						end
					end)
					table.insert(at, ay)
				end)
				table.insert(at, ax)
			else
				if av then
					av:Disconnect()
					av = nil
				end
				for ax, ay in pairs(at) do
					if ay then
						ay:Disconnect()
					end
				end
				table.clear(at)
				for ax, ay in e:GetPlayers() do
					if ay.Character then
						restoreNametag(ay.Character)
					end
				end
				for ax, ay in l:GetTagged'entity' do
					if ay:IsA'Model' then
						restoreNametag(ay)
					end
				end
				table.clear(ar)
			end
		end
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA = {}, {}, {}, '#B9B9B9', (e.LocalPlayer)
	local function create(aB, aC)
		local aD = Instance.new(aB)
		for aE, aF in pairs(aC) do
			aD[aE] = aF
		end
		return aD
	end
	local function getHead(aB)
		return aB:FindFirstChild'Head' or aB:WaitForChild('Head', 5)
	end
	local function getClan(aB)
		if not aB then
			return ''
		end
		return aB:GetAttribute'ClanTag' or aB:GetAttribute'Clan' or ''
	end
	local function getNameColor(aB)
		if not aB then
			return Color3.fromRGB(255, 80, 80)
		end
		if aw.Team and aB.Team and aw.Team == aB.Team then
			return Color3.fromRGB(90, 255, 90)
		end
		return Color3.fromRGB(255, 80, 80)
	end
	local function getTeamDotColor(aB)
		if not aB or not aB.Team then
			return Color3.new(1, 1, 1)
		end
		local aC = string.lower(aB.Team.Name)
		if aC:find'pink' then
			return Color3.fromRGB(90, 255, 90)
		elseif aC:find'orange' then
			return Color3.fromRGB(255, 80, 80)
		elseif aC:find'blue' then
			return Color3.fromRGB(80, 160, 255)
		elseif aC:find'yellow' then
			return Color3.fromRGB(255, 220, 80)
		end
		return Color3.new(1, 1, 1)
	end
	local function removeOtherNameTags(aB)
		local aC = aB:FindFirstChildOfClass'Humanoid'
		if aC then
			aC.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			aC.NameDisplayDistance = 0
		end
		local aD = aB:FindFirstChild'Head'
		if not aD then
			return
		end
		for aE, aF in ipairs(aD:GetChildren()) do
			if aF:IsA'BillboardGui' and aF.Name ~= 'OGNametag' and aF.Name ~= 'Nametag' then
				aF:Destroy()
			end
		end
	end
	local function updateTag(aB)
		local aC = au[aB]
		if not aC then
			return
		end
		local aD, aE, aF = getNameColor(aB), getTeamDotColor(aB), getClan(aB)
		aC.dot.BackgroundColor3 = aE
		aC.stroke.Color = aD
		local aG = aB.DisplayName ~= '' and aB.DisplayName or aB.Name
		if aF ~= '' then
			aC.txt.Text = string.format('<font color="%s" size="140">[%s]</font>&nbsp;<font color="rgb(%d,%d,%d)" size="130">%s</font>', av, aF, aD.R * 255, aD.G * 255, aD.B * 255, aG)
		else
			aC.txt.Text = string.format('<font color="rgb(%d,%d,%d)" size="130">%s</font>', aD.R * 255, aD.G * 255, aD.B * 255, aG)
		end
	end
	local function CreatePlayerTag(aB, aC)
		if not ax or not ax.Enabled then
			return
		end
		if aC and ay and ay.Enabled then
			return
		end
		local aD = aB.Character
		if not aD then
			return
		end
		local aE = getHead(aD)
		if not aE then
			return
		end
		removeOtherNameTags(aD)
		local aF = aE:FindFirstChild'Nametag'
		if aF then
			ar[aD] = aF:Clone()
			aF:Destroy()
		end
		local aG = aE:FindFirstChild'OGNametag'
		if aG then
			aG:Destroy()
		end
		local aH, aI, aJ, aK, aL, aM = getNameColor(aB), getTeamDotColor(aB), getClan(aB), az and az.Value or 22, aA and aA.Value or 0.1, create('BillboardGui', {
			Name = 'OGNametag',
			AlwaysOnTop = false,
			Parent = aE,
			Size = UDim2.fromScale(5.35, 0.6),
			StudsOffsetWorldSpace = Vector3.new(0, 1.6, 0),
			Adornee = aE
		})
		local aN = create('Frame', {
			Parent = aM,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1)
		})
		local aO = create('Frame', {
			Parent = aN,
			BackgroundColor3 = aI,
			BackgroundTransparency = 0.1,
			Position = UDim2.fromScale(0.02, 0.1),
			Size = UDim2.fromScale(0.17, 0.88),
			BorderSizePixel = 0
		})
		create('UIAspectRatioConstraint', {
			Parent = aO,
			AspectRatio = 1,
			DominantAxis = Enum.DominantAxis.Height
		})
		create('UICorner', {
			Parent = aO,
			CornerRadius = UDim.new(1, 0)
		})
		local aP = create('Frame', {
			Parent = aN,
			BackgroundColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 0.65,
			Position = UDim2.fromScale(0.19, 0.14),
			Size = UDim2.fromScale(0.82, 0.72),
			BorderSizePixel = 0
		})
		create('UICorner', {
			Parent = aP,
			CornerRadius = UDim.new(0, 0)
		})
		local aQ, aR, aS = create('UIStroke', {
			Parent = aP,
			Color = aH,
			Thickness = 1.2,
			Transparency = 0.3
		}), create('TextLabel', {
			Parent = aP,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.99, 1.15),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.GothamMedium,
			TextScaled = true,
			RichText = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center
		}), aB.DisplayName ~= '' and aB.DisplayName or aB.Name
		if aJ ~= '' then
			aR.Text = string.format('<font color="%s" size="140">[%s]</font>&nbsp;<font color="rgb(%d,%d,%d)" size="130">%s</font>', av, aJ, aH.R * 255, aH.G * 255, aH.B * 255, aS)
		else
			aR.Text = string.format('<font color="rgb(%d,%d,%d)" size="130">%s</font>', aH.R * 255, aH.G * 255, aH.B * 255, aS)
		end
		au[aB] = {
			bar = aP,
			dot = aO,
			stroke = aQ,
			txt = aR,
			head = aE,
			char = aD,
			gui = aM
		}
	end
	local function hook(aB)
		local function onCharAdded()
			task.wait(0.25)
			CreatePlayerTag(aB, aB == aw)
		end
		local aC = aB.CharacterAdded:Connect(onCharAdded)
		table.insert(at, aC)
		if aB.Character then
			task.wait(0.25)
			CreatePlayerTag(aB, aB == aw)
		end
	end
	local aB
	ax = v.Categories.Render:CreateModule{
		Name = 'OGNametags',
		Function = function(aC)
			if aC then
				for aD, aE in ipairs(e:GetPlayers()) do
					hook(aE)
				end
				local aD = e.PlayerAdded:Connect(hook)
				table.insert(at, aD)
				local aE = e.PlayerRemoving:Connect(function(aE)
					au[aE] = nil
				end)
				table.insert(at, aE)
				aB = game:GetService'RunService'.RenderStepped:Connect(function()
					local aF = aw.Character
					if not aF then
						return
					end
					local aG = aF:FindFirstChild'Head'
					if not aG then
						return
					end
					for aH, aI in pairs(au) do
						if aI.head and aI.gui then
							updateTag(aH)
							local aJ = (aI.head.Position - aG.Position).Magnitude
							aI.gui.AlwaysOnTop = aJ <= 18
						end
					end
				end)
			else
				if aB then
					aB:Disconnect()
					aB = nil
				end
				for aD, aE in ipairs(at) do
					if aE then
						aE:Disconnect()
					end
				end
				table.clear(at)
				table.clear(au)
				for aD, aE in ipairs(e:GetPlayers()) do
					if aE.Character then
						local aF = aE.Character:FindFirstChild'Head'
						if aF then
							local aG = aF:FindFirstChild'OGNametag'
							if aG then
								aG:Destroy()
							end
							if ar[aE.Character] then
								ar[aE.Character]:Clone().Parent = aF
								ar[aE.Character] = nil
							end
						end
					end
				end
				table.clear(ar)
			end
		end,
		Tooltip = "OG BedWars nametags with Koli's UI"
	}
	ay = ax:CreateToggle{
		Name = 'Hide Self Nametag',
		Tooltip = 'Removes your own nametag for cleaner screen',
		Default = true,
		Function = function(aC)
			if ax.Enabled then
				if aC then
					local aD = aw.Character and aw.Character:FindFirstChild'Head'
					if aD then
						local aE = aD:FindFirstChild'OGNametag'
						if aE then
							aE:Destroy()
						end
					end
				else
					CreatePlayerTag(aw, true)
				end
			end
		end
	}
	az = ax:CreateSlider{
		Name = 'Dot Size',
		Min = 4,
		Max = 60,
		Default = 22,
		Decimal = 1,
		Suffix = 'px',
		Tooltip = 'Adjust the size of the colored team dot',
		Function = function(aC)
			for aD, aE in pairs(au) do
				if aE and aE.dot then
					aE.dot.Size = UDim2.fromOffset(aC, aC)
				end
			end
		end
	}
	aA = ax:CreateSlider{
		Name = 'Dot Position',
		Min = 0.01,
		Max = 0.3,
		Default = 0.1,
		Decimal = 100,
		Tooltip = 'Move the dot up or down',
		Function = function(aC)
			for aD, aE in pairs(au) do
				if aE and aE.dot then
					aE.dot.Position = UDim2.fromScale(0.02, aC)
				end
			end
		end
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG = (Instance.new'Folder')
	ar.Parent = v.gui
	local aH, aI, aJ, aK, aL, aM, aN, aO = {}, 0, false, {}, 1, false, {}, {}
	local function isHoldingMetalDetector()
		if not L.hand or not L.hand.tool then
			return false
		end
		return L.hand.tool.Name == 'metal_detector'
	end
	local function sendNotification(aP)
		notif('Metal ESP', string.format('%d metals spawned', aP), 3)
	end
	local function processSpawnQueue()
		if # aK == 0 then
			return
		end
		local aP = tick()
		local aQ = aL - (aP - aI)
		if aQ <= 0 then
			sendNotification(# aK)
			aI = aP
			aK = {}
			aJ = false
		elseif not aJ then
			aJ = true
			task.delay(aQ, function()
				if # aK > 0 then
					sendNotification(# aK)
					aI = tick()
					aK = {}
				end
				aJ = false
			end)
		end
	end
	local function getProperImage()
		return O.getIcon({
			itemType = 'iron'
		}, true)
	end
	local function Added(aP)
		if aH[aP] then
			return
		end
		local aQ = Instance.new'BillboardGui'
		aQ.Parent = ar
		aQ.Name = 'hidden-metal'
		aQ.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aQ.Size = UDim2.fromOffset(36, 36)
		aQ.AlwaysOnTop = true
		aQ.ClipsDescendants = false
		aQ.Adornee = aP
		local aR = addBlur(aQ)
		aR.Visible = aC.Enabled
		local aS = Instance.new'ImageLabel'
		aS.Size = UDim2.fromOffset(36, 36)
		aS.Position = UDim2.fromScale(0.5, 0.5)
		aS.AnchorPoint = Vector2.new(0.5, 0.5)
		aS.BackgroundColor3 = Color3.fromHSV(aD.Hue, aD.Sat, aD.Value)
		aS.BackgroundTransparency = 1 - (aC.Enabled and aD.Opacity or 0)
		aS.BorderSizePixel = 0
		aS.Image = getProperImage()
		aS.Parent = aQ
		local aT = Instance.new'UICorner'
		aT.CornerRadius = UDim.new(0, 4)
		aT.Parent = aS
		aH[aP] = aQ
		if aB.Enabled then
			table.insert(aK, {
				item = 'metal',
				time = tick()
			})
			processSpawnQueue()
		end
	end
	local function Removed(aP)
		if aH[aP] then
			aH[aP]:Destroy()
			aH[aP] = nil
		end
	end
	local function setupESP()
		for aP, aQ in l:GetTagged'hidden-metal' do
			if aQ:IsA'Model' and aQ.PrimaryPart then
				Added(aQ.PrimaryPart)
			end
		end
		at:Clean(l:GetInstanceAddedSignal'hidden-metal':Connect(function(aP)
			if aP:IsA'Model' and aP.PrimaryPart then
				Added(aP.PrimaryPart)
			end
		end))
		at:Clean(l:GetInstanceRemovedSignal'hidden-metal':Connect(function(aP)
			if aP.PrimaryPart then
				Removed(aP.PrimaryPart)
			end
		end))
		at:Clean(g.RenderStepped:Connect(function()
			if not aA.Enabled then
				return
			end
			for aP, aQ in pairs(aH) do
				if not aP or not aP.Parent then
					Removed(aP)
					continue
				end
				local aR = true
				if aE.Enabled and not isHoldingMetalDetector() then
					aR = false
				end
				if aR and aF.Enabled and B.isAlive then
					local aS = (B.character.RootPart.Position - aP.Position).Magnitude
					if aS < aG.ValueMin or aS > aG.ValueMax then
						aR = false
					end
				end
				aQ.Enabled = aR
			end
		end))
	end
	local function collectMetal(aP)
		local aQ = aP:GetAttribute'Id'
		if not aQ then
			return false
		end
		if aN[aQ] then
			return false
		end
		aN[aQ] = true
		local aR = pcall(function()
			O.Client:Get(P.CollectCollectableEntity).instance:FireServer{
				id = aQ
			}
		end)
		if aw.Enabled then
			local aS = tick()
			if not aO[aQ] or (aS - aO[aQ]) >= 0.5 then
				aO[aQ] = aS
				pcall(function()
					O.GameAnimationUtil:playAnimation(t, O.AnimationType.SHOVEL_DIG)
					O.SoundManager:playSound(O.SoundList.SNAP_TRAP_CONSUME_MARK)
				end)
			end
		end
		task.delay(2, function()
			aN[aQ] = nil
			aO[aQ] = nil
		end)
		return aR
	end
	local function startAutoCollect()
		if aM then
			return
		end
		aM = true
		task.spawn(function()
			while at.Enabled and au.Enabled and aM do
				if not B.isAlive then
					task.wait(0.5)
					continue
				end
				if av.Enabled and not isHoldingMetalDetector() then
					task.wait(0.5)
					continue
				end
				local aP, aQ, aR = B.character.RootPart.Position, az.Value, false
				for aS, aT in l:GetTagged'hidden-metal' do
					if not at.Enabled or not au.Enabled or not aM then
						break
					end
					if aT:IsA'Model' and aT.PrimaryPart then
						local aU = (aP - aT.PrimaryPart.Position).Magnitude
						if aU <= aQ then
							if collectMetal(aT) then
								aR = true
								if ax.Enabled and ay.Value > 0 then
									task.wait(ay.Value)
								else
									task.wait(0.15)
								end
							end
						end
					end
				end
				task.wait(aR and 0.3 or 0.5)
			end
			aM = false
		end)
	end
	local function stopAutoCollect()
		aM = false
		table.clear(aN)
		table.clear(aO)
	end
	at = v.Categories.Kits:CreateModule{
		Name = 'AutoMetal',
		Function = function(aP)
			if aP then
				if aA.Enabled then
					setupESP()
				end
				if au.Enabled then
					startAutoCollect()
				end
			else
				stopAutoCollect()
				ar:ClearAllChildren()
				table.clear(aH)
				aK = {}
				aI = 0
				aJ = false
			end
		end,
		Tooltip = 'automatically collects hidden metal and esp'
	}
	au = at:CreateToggle{
		Name = 'Auto Collect',
		Default = true,
		Tooltip = 'automatically collect metals',
		Function = function(aP)
			if av and av.Object then
				av.Object.Visible = aP
			end
			if aw and aw.Object then
				aw.Object.Visible = aP
			end
			if ax and ax.Object then
				ax.Object.Visible = aP
			end
			if az and az.Object then
				az.Object.Visible = aP
			end
			if ay and ay.Object then
				ay.Object.Visible = aP and ax and ax.Enabled
			end
			if at.Enabled then
				if aP then
					startAutoCollect()
				else
					stopAutoCollect()
				end
			end
		end
	}
	av = at:CreateToggle{
		Name = 'Limit to Items',
		Default = true,
		Tooltip = 'only works when holding metal_detector'
	}
	aw = at:CreateToggle{
		Name = 'Animation',
		Default = true,
		Tooltip = 'play shovel dig animation and sound'
	}
	ax = at:CreateToggle{
		Name = 'Collection Delay',
		Default = false,
		Tooltip = 'add delay before collecting metal',
		Function = function(aP)
			if ay and ay.Object then
				ay.Object.Visible = aP
			end
		end
	}
	ay = at:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Visible = false,
		Tooltip = 'delay in seconds before collecting'
	}
	az = at:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 10,
		Default = 10,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'control distance you want to collect metal'
	}
	aA = at:CreateToggle{
		Name = 'Metal ESP',
		Default = false,
		Tooltip = 'shows metal locations',
		Function = function(aP)
			if aB and aB.Object then
				aB.Object.Visible = aP
			end
			if aC and aC.Object then
				aC.Object.Visible = aP
			end
			if aD and aD.Object then
				aD.Object.Visible = aP
			end
			if aE and aE.Object then
				aE.Object.Visible = aP
			end
			if aF and aF.Object then
				aF.Object.Visible = aP
			end
			if aG and aG.Object then
				aG.Object.Visible = (aP and aF.Enabled)
			end
			if not aP then
				if aD and aD.Object then
					aD.Object.Visible = false
				end
				if aG and aG.Object then
					aG.Object.Visible = false
				end
			else
				if aC and aC.Enabled then
					if aD and aD.Object then
						aD.Object.Visible = true
					end
				end
				if aF and aF.Enabled then
					if aG and aG.Object then
						aG.Object.Visible = true
					end
				end
			end
			if at.Enabled then
				if aP then
					setupESP()
				else
					ar:ClearAllChildren()
					table.clear(aH)
				end
			end
		end
	}
	aB = at:CreateToggle{
		Name = 'Notify',
		Default = false,
		Tooltip = 'get notifications when metals spawn'
	}
	aC = at:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aP)
			if aD and aD.Object then
				aD.Object.Visible = aP
			end
			for aQ, aR in aH do
				if aR and aR:FindFirstChild'ImageLabel' then
					local aS = aR:FindFirstChild'BlurEffect'
					if aS then
						aS.Visible = aP
					end
					aR.ImageLabel.BackgroundTransparency = 1 - (aP and aD.Opacity or 0)
				end
			end
		end
	}
	aD = at:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(aP, aQ, aR, aS)
			for aT, aU in aH do
				if aU and aU:FindFirstChild'ImageLabel' then
					aU.ImageLabel.BackgroundColor3 = Color3.fromHSV(aP, aQ, aR)
					aU.ImageLabel.BackgroundTransparency = 1 - aS
				end
			end
		end,
		Darker = true
	}
	aE = at:CreateToggle{
		Name = 'Holding Detector',
		Default = false,
		Tooltip = 'only show esp when holding metal detector'
	}
	aF = at:CreateToggle{
		Name = 'Distance Check',
		Default = false,
		Tooltip = 'only show metals within distance range',
		Function = function(aP)
			if aG and aG.Object then
				aG.Object.Visible = aP
			end
		end
	}
	aG = at:CreateTwoSlider{
		Name = 'Metal Distance',
		Min = 0,
		Max = 256,
		DefaultMin = 0,
		DefaultMax = 64,
		Darker = true,
		Tooltip = 'distance range for showing metals'
	}
	task.defer(function()
		if ay and ay.Object then
			ay.Object.Visible = ax.Enabled
		end
		if aB and aB.Object then
			aB.Object.Visible = false
		end
		if aC and aC.Object then
			aC.Object.Visible = false
		end
		if aD and aD.Object then
			aD.Object.Visible = false
		end
		if aE and aE.Object then
			aE.Object.Visible = false
		end
		if aF and aF.Object then
			aF.Object.Visible = false
		end
		if aG and aG.Object then
			aG.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, at, au, av, aw = {}, {}, 0
	local function removeCollision(ax)
		if not ax then
			return
		end
		local ay = at[ax]
		if not ay then
			ay = {}
			at[ax] = ay
			for az, aA in ax:GetDescendants() do
				if aA:IsA'BasePart' then
					table.insert(ay, {
						part = aA,
						origCollide = aA.CanCollide,
						origQuery = aA.CanQuery
					})
					aA.CanCollide = false
					aA.CanQuery = false
				end
			end
		else
			for az, aA in ay do
				if aA.part and aA.part.Parent then
					aA.part.CanCollide = false
					aA.part.CanQuery = false
				end
			end
		end
	end
	local function restoreCollision(ax)
		if not ax then
			return
		end
		local ay = at[ax]
		if ay then
			for az, aA in ay do
				if aA.part and aA.part.Parent then
					aA.part.CanCollide = aA.origCollide
					aA.part.CanQuery = aA.origQuery
				end
			end
		end
	end
	local function updateAllCollisions(ax)
		au = au + 1
		local ay = ax or (au % 3 == 0)
		if not ay then
			return
		end
		local az = hasValidWeapon()
		if not ax and aw == az then
			return
		end
		aw = az
		for aA, aB in B.List do
			if aB.Character and aB.Character.Parent then
				if az then
					restoreCollision(aB.Character)
				else
					removeCollision(aB.Character)
				end
			end
		end
	end
	local ax = {}
	local function updateMotorParts()
		for ay, az in B.List do
			if az.Character then
				local aA = ax[az.Character]
				if not aA then
					aA = {}
					ax[az.Character] = aA
					for aB, aC in az.Character:GetChildren() do
						if aC:IsA'BasePart' and aC.Name == 'Part' and aC:FindFirstChildOfClass'Motor6D' then
							table.insert(aA, aC)
						end
					end
				end
				for aB, aC in aA do
					if aC and aC.Parent then
						aC.CanCollide = false
					end
				end
			end
		end
	end
	av = v.Categories.World:CreateModule{
		Name = 'NoCollision',
		Function = function(ay)
			if ay then
				local az = 0
				local aA = g.Heartbeat:Connect(function()
					if not av.Enabled then
						return
					end
					az = az + 1
					updateAllCollisions(false)
					if az % 5 == 0 then
						updateMotorParts()
					end
				end)
				table.insert(ar, aA)
				aw = hasValidWeapon()
				for aB, aC in B.List do
					if aC.Character and aC.Character.Parent then
						if not aw then
							removeCollision(aC.Character)
						end
					end
				end
				local aB = B.Events.EntityAdded:Connect(function(aB)
					if not av.Enabled then
						return
					end
					if aB.Character then
						task.wait(0.05)
						if not hasValidWeapon() then
							removeCollision(aB.Character)
						end
					end
				end)
				table.insert(ar, aB)
				local aC = B.Events.EntityRemoved:Connect(function(aC)
					if aC.Character then
						at[aC.Character] = nil
						ax[aC.Character] = nil
					end
				end)
				table.insert(ar, aC)
				if b and b.InventoryChanged then
					local aD = b.InventoryChanged.Event:Connect(function()
						if av.Enabled then
							updateAllCollisions(true)
						end
					end)
					table.insert(ar, aD)
				else
					local aD, aE = L.hand and L.hand.tool, 0
					local aF = g.Heartbeat:Connect(function()
						if not av.Enabled then
							return
						end
						aE = aE + 1
						if aE % 5 == 0 then
							local aF = L.hand and L.hand.tool
							if aF ~= aD then
								aD = aF
								updateAllCollisions(true)
							end
						end
					end)
					table.insert(ar, aF)
				end
				updateAllCollisions(true)
			else
				for az, aA in ar do
					aA:Disconnect()
				end
				table.clear(ar)
				for az, aA in B.List do
					if aA.Character then
						restoreCollision(aA.Character)
					end
				end
				table.clear(at)
				table.clear(ax)
				aw = nil
				au = 0
			end
		end,
		Tooltip = 'Mine/build through players and NPCs'
	}
end)
a(function()
	local ar, at, au = 0
	at = v.Categories.Blatant:CreateModule{
		Name = 'InfiniteJump',
		Tooltip = 'jumpjumpjump',
		Function = function(av)
			if av then
				ar = 0
				at:Clean(g.Heartbeat:Connect(function()
					if B.isAlive then
						local aw = B.character.Humanoid
						if aw.FloorMaterial and aw.FloorMaterial ~= Enum.Material.Air then
							ar = 0
						end
					end
				end))
				at:Clean(h.JumpRequest:Connect(function()
					if not B.isAlive then
						return
					end
					ar += 1
					if au.Value == 'Velocity' then
						if ar > 1 then
							local aw = math.sqrt(2 * workspace.Gravity * B.character.Humanoid.JumpHeight)
							B.character.RootPart.Velocity = Vector3.new(B.character.RootPart.Velocity.X, aw, B.character.RootPart.Velocity.Z)
						end
					elseif au.Value == 'Jump' then
						if ar > 1 then
							B.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						end
					end
				end))
			end
		end,
		ExtraText = function()
			return au.Value
		end
	}
	au = at:CreateDropdown{
		Name = 'Mode',
		List = {
			'Jump',
			'Velocity'
		},
		Default = 'Velocity'
	}
end)
a(function()
	local ar, at, au, av, aw = {}, {}, {}, {
		ParticleEmitter = true,
		Trail = true,
		Beam = true,
		Fire = true,
		Smoke = true,
		Sparkles = true
	}
	local function removeParticle(ax)
		if au[ax] then
			return
		end
		local ay = ax.ClassName
		if av[ay] then
			if not at[ax] then
				at[ax] = ax.Enabled
			end
			ax.Enabled = false
			au[ax] = true
		end
	end
	aw = v.Categories.BoostFPS:CreateModule{
		Name = 'ParticleRemover',
		Function = function(ax)
			if ax then
				local ay = workspace:GetDescendants()
				task.spawn(function()
					for az, aA in ay do
						removeParticle(aA)
						if az % 100 == 0 then
							task.wait()
						end
					end
				end)
				local az = workspace.DescendantAdded:Connect(function(az)
					if aw.Enabled then
						removeParticle(az)
					end
				end)
				table.insert(ar, az)
			else
				for ay, az in pairs(at) do
					if ay and ay.Parent then
						pcall(function()
							ay.Enabled = az
						end)
					end
				end
				for ay, az in ar do
					az:Disconnect()
				end
				table.clear(ar)
				table.clear(at)
				table.clear(au)
			end
		end,
		Tooltip = 'Removes all particle effects for FPS boost'
	}
end)
a(function()
	local ar, at, au, av = {}, {}, {}
	local function removeShadow(aw)
		if aw:IsA'BasePart' and not au[aw] then
			if not at[aw] then
				at[aw] = aw.CastShadow
			end
			aw.CastShadow = false
			au[aw] = true
		end
	end
	av = v.Categories.BoostFPS:CreateModule{
		Name = 'ShadowRemover',
		Function = function(aw)
			if aw then
				local ax = workspace:GetDescendants()
				task.spawn(function()
					for ay, az in ax do
						removeShadow(az)
						if ay % 100 == 0 then
							task.wait()
						end
					end
				end)
				local ay = workspace.DescendantAdded:Connect(function(ay)
					if av.Enabled then
						removeShadow(ay)
					end
				end)
				table.insert(ar, ay)
			else
				for ax, ay in pairs(at) do
					if ax and ax.Parent then
						pcall(function()
							ax.CastShadow = ay
						end)
					end
				end
				for ax, ay in ar do
					ay:Disconnect()
				end
				table.clear(ar)
				table.clear(at)
				table.clear(au)
			end
		end,
		Tooltip = 'Removes shadows from all parts for FPS boost'
	}
end)
a(function()
	local ar
	ar = v.Categories.Legit:CreateModule{
		Name = 'WhiteHits',
		Function = function(at)
			repeat
				for au, av in B.List do
					local aw = av.Character and av.Character:FindFirstChild'_DamageHighlight_'
					if aw then
						aw.FillTransparency = 1
						if not aw:GetAttribute'TransparencyHooked' then
							aw:GetPropertyChangedSignal'FillTransparency':Connect(function()
								aw.FillTransparency = 1
							end)
							aw:SetAttribute('TransparencyHooked', true)
						end
					end
				end
				task.wait(0.1)
			until not ar.Enabled
		end
	}
end)
a(function()
	local ar, at, au, av, aw = {}
	at = v.Categories.Legit:CreateModule{
		Name = 'DamageHighlight',
		Function = function(ax)
			if ax then
				repeat
					for ay, az in B.List do
						local aA = az.Character and az.Character:FindFirstChild'_DamageHighlight_'
						if aA and not ar[aA] then
							local aB = Color3.fromHSV(au.Hue, au.Sat, au.Value)
							aA.FillColor = aB
							aA.OutlineColor = aB
							aA.FillTransparency = av.Value
							aA.OutlineTransparency = aw.Value
							aA:GetPropertyChangedSignal'FillColor':Connect(function()
								if at.Enabled then
									local aC = Color3.fromHSV(au.Hue, au.Sat, au.Value)
									aA.FillColor = aC
								end
							end)
							aA:GetPropertyChangedSignal'OutlineColor':Connect(function()
								if at.Enabled then
									local aC = Color3.fromHSV(au.Hue, au.Sat, au.Value)
									aA.OutlineColor = aC
								end
							end)
							aA:GetPropertyChangedSignal'FillTransparency':Connect(function()
								if at.Enabled then
									aA.FillTransparency = av.Value
								end
							end)
							aA:GetPropertyChangedSignal'OutlineTransparency':Connect(function()
								if at.Enabled then
									aA.OutlineTransparency = aw.Value
								end
							end)
							ar[aA] = true
						elseif aA and ar[aA] then
							local aB = Color3.fromHSV(au.Hue, au.Sat, au.Value)
							aA.FillColor = aB
							aA.OutlineColor = aB
							aA.FillTransparency = av.Value
							aA.OutlineTransparency = aw.Value
						end
					end
					task.wait(0.1)
				until not at.Enabled
			else
				table.clear(ar)
			end
		end,
		Tooltip = 'Customize damage highlight colors and transparency'
	}
	au = at:CreateColorSlider{
		Name = 'Highlight Color',
		DefaultValue = 0,
		DefaultOpacity = 1,
		Tooltip = 'Color for damage highlights',
		Function = function()
			if at.Enabled then
				for ax, ay in B.List do
					local az = ay.Character and ay.Character:FindFirstChild'_DamageHighlight_'
					if az then
						local aA = Color3.fromHSV(au.Hue, au.Sat, au.Value)
						az.FillColor = aA
						az.OutlineColor = aA
					end
				end
			end
		end
	}
	av = at:CreateSlider{
		Name = 'Fill Transparency',
		Min = 0,
		Max = 1,
		Default = 0.5,
		Decimal = 100,
		Tooltip = 'Transparency of the fill (0 = solid, 1 = invisible)',
		Function = function()
			if at.Enabled then
				for ax, ay in B.List do
					local az = ay.Character and ay.Character:FindFirstChild'_DamageHighlight_'
					if az then
						az.FillTransparency = av.Value
					end
				end
			end
		end
	}
	aw = at:CreateSlider{
		Name = 'Outline Transparency',
		Min = 0,
		Max = 1,
		Default = 0,
		Decimal = 100,
		Tooltip = 'Transparency of the outline (0 = solid, 1 = invisible)',
		Function = function()
			if at.Enabled then
				for ax, ay in B.List do
					local az = ay.Character and ay.Character:FindFirstChild'_DamageHighlight_'
					if az then
						az.OutlineTransparency = aw.Value
					end
				end
			end
		end
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH = false, false
	local function isHoldingScepter()
		if not B.isAlive then
			return false
		end
		local aI = L.inventory
		if aI and aI.inventory and aI.inventory.hand then
			local aJ = aI.inventory.hand
			if aJ and aJ.itemType == 'scepter' then
				return true
			end
		end
		return false
	end
	local function isPlayerAlive(aI)
		if not aI or not aI.Character then
			return false
		end
		local aJ = aI.Character:FindFirstChild'Humanoid'
		return aJ and aJ.Health > 0
	end
	local function isPlayerInVoid(aI)
		if not aI or not aI.Character then
			return true
		end
		local aJ = aI.Character:FindFirstChild'HumanoidRootPart'
		if aJ then
			return aJ.Position.Y < 0
		end
		return true
	end
	local function getTargetPlayer()
		local aI = t:GetAttribute'Team'
		if not aI then
			return nil
		end
		local aJ = aC.Value
		if aJ == 'Specific Player' then
			local aK = av.Value
			if not aK or aK == '' then
				return nil
			end
			local aL = e:FindFirstChild(aK)
			if aL and aL:GetAttribute'Team' == aI then
				if isPlayerAlive(aL) and not isPlayerInVoid(aL) then
					return aL
				end
			end
			return nil
		elseif aJ == 'Lowest Health' then
			local aK, aL = (math.huge)
			for aM, aN in e:GetPlayers() do
				if aN ~= t and aN:GetAttribute'Team' == aI then
					if isPlayerAlive(aN) and not isPlayerInVoid(aN) then
						local aO = getPlayerHealthPercent(aN)
						if aO < aK and aO > 0 then
							aK = aO
							aL = aN
						end
					end
				end
			end
			return aL
		elseif aJ == 'Closest' then
			if not B.isAlive then
				return nil
			end
			local aK, aL, aM = B.character.RootPart.Position, (math.huge)
			for aN, aO in e:GetPlayers() do
				if aO ~= t and aO:GetAttribute'Team' == aI then
					if isPlayerAlive(aO) and not isPlayerInVoid(aO) then
						if aO.Character and aO.Character:FindFirstChild'HumanoidRootPart' then
							local aP = (aO.Character.HumanoidRootPart.Position - aK).Magnitude
							if aP < aL then
								aL = aP
								aM = aO
							end
						end
					end
				end
			end
			return aM
		elseif aJ == 'Furthest' then
			if not B.isAlive then
				return nil
			end
			local aK, aL, aM = B.character.RootPart.Position, 0
			for aN, aO in e:GetPlayers() do
				if aO ~= t and aO:GetAttribute'Team' == aI then
					if isPlayerAlive(aO) and not isPlayerInVoid(aO) then
						if aO.Character and aO.Character:FindFirstChild'HumanoidRootPart' then
							local aP = (aO.Character.HumanoidRootPart.Position - aK).Magnitude
							if aP > aL then
								aL = aP
								aM = aO
							end
						end
					end
				end
			end
			return aM
		elseif aJ == 'Random' then
			local aK = {}
			for aL, aM in e:GetPlayers() do
				if aM ~= t and aM:GetAttribute'Team' == aI then
					if isPlayerAlive(aM) and not isPlayerInVoid(aM) then
						table.insert(aK, aM)
					end
				end
			end
			if # aK > 0 then
				return aK[math.random(1, # aK)]
			end
			return nil
		end
		return nil
	end
	local function shouldActivateByHealth()
		if not aD.Enabled then
			return true
		end
		if not B.isAlive then
			return false
		end
		local aI = getPlayerHealthPercent(t)
		if aI <= aE.Value then
			return true
		end
		if aF.Enabled then
			local aJ = getTargetPlayer()
			if aJ then
				local aK = getPlayerHealthPercent(aJ)
				if aK <= aG.Value then
					return true
				end
			end
		end
		return false
	end
	local function getShopNPC()
		if not B.isAlive then
			return false
		end
		local aI = B.character.RootPart.Position
		for aJ, aK in L.shop do
			if (aK.RootPart.Position - aI).Magnitude <= 20 then
				return true
			end
		end
		return false
	end
	local function buyScepter()
		pcall(function()
			O.Client:Get(P.BedwarsPurchaseItem).instance:InvokeServer{
				shopItem = {
					currency = 'iron',
					itemType = 'scepter',
					amount = 1,
					price = 45,
					category = 'Combat',
					requiresKit = {
						'paladin'
					},
					lockAfterPurchase = true
				},
				shopId = '1_item_shop'
			}
		end)
	end
	local function startBuyLoop()
		if aH then
			task.cancel(aH)
			aH = nil
		end
		at = true
		aH = task.spawn(function()
			while at and ay.Enabled and au.Enabled do
				local aI = az.Enabled and O.AppController:isAppOpen'BedwarsItemShopApp' or (not az.Enabled and getShopNPC())
				if aI then
					buyScepter()
				end
				task.wait(aA.Value)
			end
			aH = nil
		end)
	end
	local function stopBuyLoop()
		at = false
		if aH then
			task.cancel(aH)
			aH = nil
		end
	end
	au = v.Categories.Kits:CreateModule{
		Name = 'AutoLani',
		Function = function(aI)
			ar = aI
			if aI then
				task.spawn(function()
					au:Clean(t:GetAttributeChangedSignal'PaladinStartTime':Connect(function()
						if not ar then
							return
						end
						if not shouldActivateByHealth() then
							return
						end
						if aB.Enabled and not isHoldingScepter() then
							notif('AutoLani', 'bro u aint even holding the scepter \u{1f480}', 3)
							return
						end
						pcall(function()
							local aJ = L.inventory and L.inventory.inventory and L.inventory.inventory.hand
							if aJ then
								O.Client:Get(P.ConsumeItem).instance:InvokeServer{
									item = aJ.tool
								}
							end
						end)
						task.wait(ax.Value)
						if O.AbilityController:canUseAbility'PALADIN_ABILITY' then
							local aJ = getTargetPlayer()
							if aJ and aJ.Character then
								O.Client:Get(P.PaladinAbilityRequest):SendToServer{
									target = aJ
								}
								notif('AutoLani', "tp'd to " .. aJ.Name .. " don't die lol", 2)
							else
								O.Client:Get(P.PaladinAbilityRequest):SendToServer{}
								notif('AutoLani', 'used ability on self fr fr', 2)
							end
							task.wait(0.022)
							O.AbilityController:useAbility'PALADIN_ABILITY'
						else
							notif('AutoLani', 'ability on cooldown rn \u{1f62d}', 2)
						end
					end))
				end)
				if ay.Enabled then
					startBuyLoop()
				end
				au:Clean(e.PlayerAdded:Connect(function()
					task.wait(0.5)
					av:SetList(getTeammateNames())
				end))
				au:Clean(e.PlayerRemoving:Connect(function()
					task.wait(0.5)
					av:SetList(getTeammateNames())
				end))
				au:Clean(t:GetAttributeChangedSignal'Team':Connect(function()
					task.wait(1)
					av:SetList(getTeammateNames())
				end))
			else
				ar = false
				stopBuyLoop()
			end
		end,
		Tooltip = 'auto tp to teammates w paladin scepter'
	}
	aC = au:CreateDropdown{
		Name = 'Target Mode',
		List = {
			'Specific Player',
			'Lowest Health',
			'Closest',
			'Furthest',
			'Random'
		},
		Default = 'Specific Player',
		Function = function(aI)
			if av then
				av.Object.Visible = (aI == 'Specific Player')
			end
		end,
		Tooltip = 'who to tp to'
	}
	local function teammateListWithNone()
		local aI = {
			'None'
		}
		for aJ, aK in ipairs(getTeammateNames()) do
			table.insert(aI, aK)
		end
		return aI
	end
	av = au:CreateDropdown{
		Name = 'Teammate',
		List = teammateListWithNone(),
		Tooltip = 'pick ur teammate'
	}
	aw = au:CreateButton{
		Name = 'Refresh Teammates',
		Function = function()
			task.spawn(function()
				local aI, aJ = getTeammateNames(), {
					'None'
				}
				for aK, aL in ipairs(aI) do
					table.insert(aJ, aL)
				end
				if av then
					pcall(function()
						av:Change(aJ)
						if # aJ > 1 then
							if not av.Value or av.Value == '' or not table.find(aJ, av.Value) then
								av:SetValue(aJ[2] or 'None')
							else
								av:SetValue(av.Value)
							end
						end
					end)
				end
				notif('AutoLani', # aJ > 0 and 'refreshed, got ' .. # aJ .. ' teammates \u{1f44d}' or 'no teammates found bro \u{1f480}', 2)
			end)
		end,
		Tooltip = 'refresh the teammate list'
	}
	ax = au:CreateSlider{
		Name = 'Teleport Delay',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'delay before tping'
	}
	aB = au:CreateToggle{
		Name = 'Limit to Scepter',
		Default = true,
		Tooltip = 'only tp when u holdin the scepter'
	}
	aD = au:CreateToggle{
		Name = 'Health Activation',
		Default = false,
		Function = function(aI)
			if aE then
				aE.Object.Visible = aI
			end
			if aF then
				aF.Object.Visible = aI
			end
			if not aI then
				if aG and aG.Object then
					aG.Object.Visible = false
				end
			else
				if aF and aF.Enabled then
					if aG and aG.Object then
						aG.Object.Visible = true
					end
				end
			end
		end,
		Tooltip = 'only use ability based on hp'
	}
	aE = au:CreateSlider{
		Name = 'Self Health %',
		Min = 1,
		Max = 100,
		Default = 50,
		Suffix = '%',
		Tooltip = 'use ability when ur hp is below this',
		Visible = false
	}
	aF = au:CreateToggle{
		Name = 'Teammate Health Check',
		Default = false,
		Function = function(aI)
			if aG then
				aG.Object.Visible = aI
			end
		end,
		Tooltip = 'also check teammate hp',
		Visible = false
	}
	aG = au:CreateSlider{
		Name = 'Teammate Health %',
		Min = 1,
		Max = 100,
		Default = 30,
		Suffix = '%',
		Tooltip = 'use ability when teammate hp is below this',
		Visible = false
	}
	ay = au:CreateToggle{
		Name = 'Auto Buy Scepter',
		Default = false,
		Function = function(aI)
			if az then
				az.Object.Visible = aI
			end
			if aA then
				aA.Object.Visible = aI
			end
			if aI and au.Enabled then
				startBuyLoop()
			else
				stopBuyLoop()
			end
		end,
		Tooltip = 'auto cop scepters from shop'
	}
	az = au:CreateToggle{
		Name = 'GUI Check',
		Default = false,
		Tooltip = 'only buy when shop is open',
		Visible = false
	}
	aA = au:CreateSlider{
		Name = 'Buy Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.3,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'delay between buys',
		Visible = false
	}
	task.defer(function()
		if av and av.Object then
			av.Object.Visible = true
		end
		if aE and aE.Object then
			aE.Object.Visible = false
		end
		if aF and aF.Object then
			aF.Object.Visible = false
		end
		if aG and aG.Object then
			aG.Object.Visible = false
		end
		if az and az.Object then
			az.Object.Visible = false
		end
		if aA and aA.Object then
			aA.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, at, au = (cloneRaycast())
	ar.RespectCanCollide = true
	local av = cloneRaycast()
	av.RespectCanCollide = true
	av.FilterType = Enum.RaycastFilterType.Exclude
	local aw = {
		InvokeServer = function()
		end
	}
	task.spawn(function()
		aw = O.Client:Get(P.FireProjectile).instance
	end)
	local function isHoldingPearl()
		if not B.isAlive then
			return false
		end
		local ax = L.inventory and L.inventory.inventory and L.inventory.inventory.hand
		return ax and ax.itemType == 'telepearl'
	end
	local function getPearlHotbarSlot()
		for ax, ay in L.inventory.hotbar do
			if ay.item and ay.item.itemType == 'telepearl' then
				return ax - 1, ay.item
			end
		end
		return nil, nil
	end
	local function throwPearl(ax, ay, az)
		local aA, aB, aC, aD = O.ProjectileMeta.telepearl, {
			Vector3.new(0, - 1.5, 0),
			Vector3.new(0, 0, 0),
			Vector3.new(0, 1, 0),
			Vector3.new(0, - 3, 0)
		}
		for aE, aF in aB do
			local aG = ay + aF
			aC = I.SolveTrajectory(ax, aA.launchVelocity, aA.gravitationalAcceleration, aG, Vector3.zero, workspace.Gravity, 0, 0, nil, false, t:GetNetworkPing())
			if aC then
				aD = aG
				break
			end
		end
		if not aC then
			return false
		end
		local aE = CFrame.lookAt(ax, aC).LookVector * aA.launchVelocity
		aw:InvokeServer(az, 'telepearl', 'telepearl', ax, ax, aE, j:GenerateGUID(true), {
			drawDurationSeconds = 1,
			shotId = j:GenerateGUID(false)
		}, workspace:GetServerTimeNow() - 0.045)
		return true
	end
	local function isValidLandingSpot(ax, ay)
		local az = workspace:Raycast(ax + Vector3.new(0, 0.1, 0), Vector3.new(0, 3, 0), ay)
		if az then
			return false
		end
		local aA = workspace:Raycast(ax + Vector3.new(0, 0.5, 0), Vector3.new(0, - 2, 0), ay)
		return aA ~= nil
	end
	local function findBestLandingSpot(ax)
		local ay = t.Character
		if not ay then
			return nil
		end
		av.FilterDescendantsInstances = {
			ay,
			s
		}
		local az, aA, aB, aC = O.ProjectileMeta.telepearl, {}, {
			4,
			6,
			8,
			10,
			12,
			16,
			20,
			24,
			30
		}, 32
		for aD, aE in aB do
			for aF = 0, aC - 1 do
				local aG = (aF / aC) * math.pi * 2
				local aH, aI = math.cos(aG) * aE, math.sin(aG) * aE
				local aJ = Vector3.new(ax.X + aH, ax.Y + 50, ax.Z + aI)
				local aK = workspace:Raycast(aJ, Vector3.new(0, - 120, 0), av)
				if aK then
					local aL, aM, aN = aK.Position, aK.Normal, aK.Instance
					if aM.Y > 0.7 and aN and aN:IsA'BasePart' then
						local aO = aL + Vector3.new(0, 0.1, 0)
						if isValidLandingSpot(aO, av) then
							local aP = I.SolveTrajectory(ax, az.launchVelocity, az.gravitationalAcceleration, aO, Vector3.zero, workspace.Gravity, 0, 0, nil, false, t:GetNetworkPing())
							if aP then
								local aQ, aR = Vector2.new(ax.X - aO.X, ax.Z - aO.Z).Magnitude, aO.Y - ax.Y
								table.insert(aA, {
									spot = aO,
									dist = aQ,
									heightDiff = aR,
									calc = aP
								})
							end
						end
					end
				end
			end
		end
		if # aA == 0 then
			return nil
		end
		table.sort(aA, function(aD, aE)
			local aF, aG = aD.heightDiff >= - 10, aE.heightDiff >= - 10
			if aF ~= aG then
				return aF
			end
			return aD.dist < aE.dist
		end)
		return aA[1].spot
	end
	local function doPearl(ax, ay, az)
		local aA, aB = getPearlHotbarSlot()
		if not aA or not aB then
			return
		end
		if au.Enabled then
			if not isHoldingPearl() then
				return
			end
			throwPearl(ax, ay, aB.tool)
			return
		end
		local aC = L.inventory.hotbarSlot
		if isHoldingPearl() then
			throwPearl(ax, ay, aB.tool)
		else
			hotbarSwitch(aA)
			task.wait(0.08)
			throwPearl(ax, ay, aB.tool)
			task.wait(0.05)
			hotbarSwitch(aC)
		end
	end
	at = v.Categories.Utility:CreateModule{
		Name = 'AutoPearl',
		Function = function(ax)
			if ax then
				local ay, az, aA, aB, aC, aD, aE = 0, 0.3, false, (RaycastParams.new())
				aB.FilterType = Enum.RaycastFilterType.Blacklist
				aB.FilterDescendantsInstances = {
					t.Character,
					s
				}
				repeat
					if B.isAlive then
						local aF, aG, aH = B.character.RootPart, getItem'telepearl', tick()
						aB.FilterDescendantsInstances = {
							t.Character,
							s
						}
						local aI = aF.AssemblyLinearVelocity.Y
						local aJ, aK, aL = aI < - 60, aI > 5, not workspace:Raycast(aF.Position, Vector3.new(0, - 120, 0), aB)
						if not aJ then
							aC = nil
							aD = nil
						elseif aJ and aC == nil then
							aC = aG and aG.amount or 0
						end
						local aM = aG and aG.amount or 0
						if aC ~= nil and aM < aC and not aA then
							aD = aH
							aC = aM
						end
						local aN = aD and (aH - aD) < 3
						if aJ and aL then
							if not aE then
								aE = aH
							end
						else
							aE = nil
						end
						local aO = aE and (aH - aE) or 0
						if aG and aJ and aL and not aK and not aN and aO >= 0.25 then
							if not aA and (aH - ay) >= az then
								aA = true
								ay = aH
								local aP = findBestLandingSpot(aF.Position)
								if aP then
									task.spawn(doPearl, aF.Position, aP, aG)
								end
							end
						else
							aA = false
						end
					else
						aA = false
					end
					task.wait(0.05)
				until not at.Enabled
			end
		end,
		Tooltip = 'automatically pearls to safety when falling into void'
	}
	au = at:CreateToggle{
		Name = 'Limit to Pearl',
		Default = false,
		Tooltip = 'only pearls when already holding pearl, no switching'
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, l, false, {}, 0, {
		['Emerald > Diamond > Gold'] = {
			'emerald',
			'diamond',
			'iron'
		},
		['Diamond > Emerald > Gold'] = {
			'diamond',
			'emerald',
			'iron'
		},
		['Gold > Diamond > Emerald'] = {
			'iron',
			'diamond',
			'emerald'
		}
	}, {
		emerald = {
			'Emerald',
			'EmeraldOre'
		},
		diamond = {
			'Diamond',
			'DiamondOre'
		},
		iron = {
			'IronIngot',
			'IronOre'
		}
	}
	local function updateOutline(aK)
		if aB then
			aB:Destroy()
			aB = nil
		end
		if aK and ay.Enabled then
			aB = Instance.new'Highlight'
			aB.FillTransparency = 0.5
			aB.OutlineColor = Color3.fromRGB(255, 215, 0)
			aB.OutlineTransparency = 0
			aB.Adornee = aK
			aB.Parent = aK
		end
	end
	local function clearOutline()
		if aB then
			aB:Destroy()
			aB = nil
		end
	end
	local function updateGeneratorCache()
		if tick() - aH < 2 then
			return
		end
		aG = {}
		for aK, aL in ipairs(workspace:GetDescendants()) do
			if aL.Name == 'GeneratorAdornee' then
				table.insert(aG, aL)
			end
		end
		aH = tick()
	end
	local function isGeneratorLoot(aK)
		if aK:GetAttribute'OreGenDrop' then
			return true
		end
		updateGeneratorCache()
		local aL = aK:FindFirstChild'Handle' and aK.Handle.Position
		if not aL then
			return false
		end
		for aM, aN in ipairs(aG) do
			local aO = aN:GetPivot().Position
			if (aL - aO).Magnitude <= 20 then
				return true
			end
		end
		return false
	end
	local function getClosestLoot(aK)
		local aL, aM, aN = math.huge, aI[az.Value] or aI['Emerald > Diamond > Iron']
		for aO, aP in ipairs(aM) do
			for aQ, aR in ipairs(aE:GetTagged'ItemDrop') do
				if not aR:FindFirstChild'Handle' then
					continue
				end
				if not isGeneratorLoot(aR) then
					continue
				end
				local aS, aT = aR.Name:lower(), false
				for aU, aV in ipairs(aJ[aP]) do
					if aS:find(aV:lower()) then
						aT = true
						break
					end
				end
				if aT then
					local aU = (aR.Handle.Position - aK).Magnitude
					if aU <= aw.Value and aU < aL then
						aN = aR.Handle
						aL = aU
					end
				end
			end
			if aN then
				return aN
			end
		end
		return aN
	end
	local function switchAffinity(aK)
		local aL = t:GetAttribute'SpiritSummonerAffinity'
		if aL ~= aK then
			pcall(function()
				if O.AbilityController:canUseAbility'spirit_summoner_switch_affinity' then
					O.AbilityController:useAbility'spirit_summoner_switch_affinity'
					task.wait(0.1)
				end
			end)
		end
	end
	local function getTeammateHealth(aK)
		if not aK.Character then
			return 100
		end
		local aL, aM = aK.Character:GetAttribute'Health' or 100, aK.Character:GetAttribute'MaxHealth' or 100
		return aL, aM
	end
	local function getLowHealthTeammate()
		local aK = t:GetAttribute'Team'
		if not aK then
			return nil
		end
		for aL, aM in ipairs(game:GetService'Players':GetPlayers()) do
			if aM ~= t and aM:GetAttribute'Team' == aK then
				local aN = getTeammateHealth(aM)
				if aN <= 40 and aN > 0 then
					return aM
				end
			end
		end
		return nil
	end
	local function startAutoSummon()
		if aD then
			task.cancel(aD)
			aD = nil
		end
		aD = task.spawn(function()
			while ar.Enabled and ax.Enabled do
				if not B.isAlive then
					task.wait(0.5)
					continue
				end
				local aK = false
				for aL, aM in ipairs(L.inventory.inventory.items) do
					if aM.itemType == 'spirit_staff' then
						aK = true
						break
					end
				end
				if aK then
					local aL, aM = t:GetAttribute'ReadySummonedAttackSpirits' or 0, t:GetAttribute'ReadySummonedHealSpirits' or 0
					local aN = aL + aM
					if aN < 10 then
						local aO = false
						for aP, aQ in ipairs(L.inventory.inventory.items) do
							if aQ.itemType == 'summon_stone' then
								aO = true
								break
							end
						end
						if aO then
							pcall(function()
								if O.AbilityController:canUseAbility'summon_attack_spirit' then
									O.AbilityController:useAbility'summon_attack_spirit'
									task.wait(0.5)
								end
							end)
						end
					end
				end
				task.wait(0.5)
			end
		end)
	end
	local function stopAutoSummon()
		if aD then
			task.cancel(aD)
			aD = nil
		end
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoUma',
		Function = function(aK)
			if aK then
				aC = O.ProjectileController.calculateImportantLaunchValues
				O.ProjectileController.calculateImportantLaunchValues = function(...)
					aF = true
					local aL, aM, aN, aO, aP = ...
					if not (aM.projectile == 'attack_spirit' or aM.projectile == 'heal_spirit') then
						aF = false
						clearOutline()
						return aC(...)
					end
					local aQ, aR, aS = B.isAlive and (aP or (B.character and B.character.RootPart and B.character.RootPart.Position)) or Vector3.zero
					if at.Enabled then
						local aT = getClosestLoot(aQ)
						if aT and (aT.Position - aQ).Magnitude <= aw.Value then
							aR = aT
							aS = aT.Position
							updateOutline(aT)
						else
							clearOutline()
						end
					end
					if av.Enabled and not at.Enabled then
						local aT = getLowHealthTeammate()
						if aT and aT.Character and aT.Character.PrimaryPart then
							switchAffinity'heal'
							local aU = (aT.Character.PrimaryPart.Position - aQ).Magnitude
							if aU <= aw.Value then
								aR = aT.Character.PrimaryPart
								aS = aT.Character.PrimaryPart.Position + Vector3.new(0, 2, 0)
								updateOutline(aT.Character)
							else
								clearOutline()
							end
						else
							clearOutline()
						end
					end
					if au.Enabled and not at.Enabled and not (av.Enabled and getLowHealthTeammate()) then
						switchAffinity'attack'
						local aT = B.EntityMouse{
							Part = 'RootPart',
							Range = 1000,
							Players = true,
							NPCs = true,
							Wallcheck = false,
							Origin = aQ
						}
						if aT and aT.RootPart and (aT.RootPart.Position - aQ).Magnitude <= aw.Value then
							aR = aT.RootPart
							aS = aT.RootPart.Position + Vector3.new(0, 2, 0)
							updateOutline(aT.Character)
						else
							clearOutline()
						end
					end
					if aR and aS then
						local aT = aP or aL:getLaunchPosition(aO)
						if not aT then
							aF = false
							clearOutline()
							return aC(...)
						end
						local aU = aM:getProjectileMeta()
						local aV, aW, aX, aY = (aN and aU.predictionLifetimeSec or aU.lifetimeSec or 3), (aU.gravitationalAcceleration or 196.2) * aM.gravityMultiplier, (aU.launchVelocity or 100), aT + aM.fromPositionOffset
						local aZ, a_ = CFrame.new(aY, aS), (aR and aR.Velocity) or Vector3.zero
						local a0 = I.SolveTrajectory(aZ.p, aX, aW, aS, a_, workspace.Gravity, 0, nil, nil)
						aF = false
						return {
							initialVelocity = a0 and CFrame.new(aZ.Position, a0).LookVector * aX or aZ.LookVector * aX,
							positionFrom = aY,
							deltaT = aV,
							gravitationalAcceleration = aW,
							drawDurationSeconds = 5
						}
					end
					aF = false
					clearOutline()
					return aC(...)
				end
				if ax.Enabled then
					startAutoSummon()
				end
			else
				if aC then
					O.ProjectileController.calculateImportantLaunchValues = aC
					aC = nil
				end
				clearOutline()
				stopAutoSummon()
				aA = nil
			end
		end,
		Tooltip = 'Spirit Summoner automation - lock onto loot, enemies, or heal teammates'
	}
	at = ar:CreateToggle{
		Name = 'Cycle',
		Function = function(aK)
			if aK then
				if au.Enabled then
					au:Toggle()
				end
				if av.Enabled then
					av:Toggle()
				end
				az.Object.Visible = true
			else
				az.Object.Visible = false
				clearOutline()
			end
		end,
		Tooltip = 'Lock onto generator loot (iron/diamond/emerald) with priority system'
	}
	az = ar:CreateDropdown{
		Name = 'Loot Priority',
		List = {
			'Emerald > Diamond > Iron',
			'Diamond > Emerald > Iron',
			'Iron > Diamond > Emerald'
		},
		Default = 'Emerald > Diamond > Iron',
		Darker = true
	}
	az.Object.Visible = false
	au = ar:CreateToggle{
		Name = 'Attack',
		Function = function(aK)
			if aK then
				if at.Enabled then
					at:Toggle()
				end
				if av.Enabled then
					av:Toggle()
				end
				clearOutline()
			else
				clearOutline()
			end
		end,
		Tooltip = 'Lock onto enemies and attack them'
	}
	av = ar:CreateToggle{
		Name = 'Heal',
		Function = function(aK)
			if aK then
				if at.Enabled then
					at:Toggle()
				end
				if au.Enabled then
					au:Toggle()
				end
				clearOutline()
			else
				clearOutline()
			end
		end,
		Tooltip = 'Heal teammates below 40 HP'
	}
	ax = ar:CreateToggle{
		Name = 'Auto Summon',
		Function = function(aK)
			if aK and ar.Enabled then
				startAutoSummon()
			else
				stopAutoSummon()
			end
		end,
		Default = true,
		Tooltip = 'Automatically summons spirits when you have summon stones'
	}
	ay = ar:CreateToggle{
		Name = 'Target Visualiser',
		Function = function(aK)
			if not aK then
				clearOutline()
			end
		end,
		Default = true,
		Tooltip = 'Shows gold outline on locked target'
	}
	aw = ar:CreateSlider{
		Name = 'Lock Range',
		Min = 10,
		Max = 500,
		Default = 70,
		Tooltip = 'Maximum distance to lock onto targets'
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az = {}, e
	local aA, aB, aC, aD = at.LocalPlayer, 0, 0
	local function selectContract(aE)
		if not B.isAlive then
			return false
		end
		if tick() - aC < 0.1 then
			return false
		end
		local aF = O.Store:getState()
		local aG, aH = aF.Kit.activeContract, aF.Kit.availableContracts or {}
		if aG then
			return false
		end
		if # aH == 0 then
			return false
		end
		for aI, aJ in pairs(aH) do
			if aJ.target == aE then
				O.Client:Get(P.BloodAssassinSelectContract):SendToServer{
					contractId = aJ.id
				}
				aC = tick()
				return true
			end
		end
		return false
	end
	local function executeOnLowHealth()
		if not aD or tick() - aB > 3 then
			aD = nil
			return
		end
		if not aD.Character then
			return
		end
		local aE, aF = aD.Character:FindFirstChild'Humanoid', aD.Character:FindFirstChild'HumanoidRootPart'
		if aE and aF and aA.Character and aA.Character:FindFirstChild'HumanoidRootPart' then
			local aG, aH = aE.Health, (aA.Character.HumanoidRootPart.Position - aF.Position).Magnitude
			if aG > 0 and aG <= aw.Value and aH <= ax.Value then
				selectContract(aD)
			end
		end
	end
	local function contractOnHit()
		if not aD or tick() - aB > 0.5 then
			aD = nil
			return
		end
		if not aD.Character then
			return
		end
		local aE = aD.Character:FindFirstChild'HumanoidRootPart'
		if aE and aA.Character and aA.Character:FindFirstChild'HumanoidRootPart' then
			local aF = (aA.Character.HumanoidRootPart.Position - aE.Position).Magnitude
			if aF <= ay.Value then
				selectContract(aD)
			end
		end
	end
	local function proximityContract()
		if not B.isAlive then
			return
		end
		local aE = aA.Character and aA.Character:FindFirstChild'HumanoidRootPart'
		if not aE then
			return
		end
		local aF, aG = (az.Value)
		for aH, aI in pairs(at:GetPlayers()) do
			if aI ~= aA and aI.Character then
				local aJ, aK = aI.Character:FindFirstChild'HumanoidRootPart', aI.Character:FindFirstChild'Humanoid'
				if aJ and aK and aK.Health > 0 then
					local aL = (aE.Position - aJ.Position).Magnitude
					if aL < aF then
						aF = aL
						aG = aI
					end
				end
			end
		end
		if aG then
			selectContract(aG)
		end
	end
	au = v.Categories.Kits:CreateModule{
		Name = 'AutoCaitlyn',
		Function = function(aE)
			if aE then
				local aF = b.EntityDamageEvent.Event:Connect(function(aF)
					if not B.isAlive then
						return
					end
					local aG, aH = e:GetPlayerFromCharacter(aF.fromEntity), e:GetPlayerFromCharacter(aF.entityInstance)
					if aG == aA and aH and aH ~= aA then
						aD = aH
						aB = tick()
					end
				end)
				table.insert(ar, aF)
				task.spawn(function()
					repeat
						if B.isAlive then
							local aG = av.Value
							if aG == 'Execute on Low HP' then
								executeOnLowHealth()
							elseif aG == 'Contract on Hit' then
								contractOnHit()
							elseif aG == 'Proximity Select' then
								proximityContract()
							end
						end
						task.wait(0.1)
					until not au.Enabled
				end)
			else
				for aF, aG in pairs(ar) do
					if typeof(aG) == 'RBXScriptConnection' then
						aG:Disconnect()
					end
				end
				table.clear(ar)
				aD = nil
				aB = 0
			end
		end,
		Tooltip = 'Auto contract selection for Caitlyn'
	}
	av = au:CreateDropdown{
		Name = 'Method',
		List = {
			'Execute on Low HP',
			'Contract on Hit',
			'Proximity Select'
		},
		Default = 'Execute on Low HP',
		Tooltip = 'Contract selection method',
		Function = function(aE)
			aw.Object.Visible = (aE == 'Execute on Low HP')
			ax.Object.Visible = (aE == 'Execute on Low HP')
			ay.Object.Visible = (aE == 'Contract on Hit')
			az.Object.Visible = (aE == 'Proximity Select')
		end
	}
	aw = au:CreateSlider{
		Name = 'Select HP',
		Min = 10,
		Max = 100,
		Default = 30,
		Tooltip = 'HP value to execute contract'
	}
	ax = au:CreateSlider{
		Name = 'Select Range',
		Min = 5,
		Max = 50,
		Default = 20,
		Suffix = ' studs',
		Tooltip = 'Range to select contract'
	}
	ay = au:CreateSlider{
		Name = 'Hit Range',
		Min = 10,
		Max = 200,
		Default = 100,
		Suffix = ' studs',
		Tooltip = 'Max range to select a contract when hitting the player'
	}
	az = au:CreateSlider{
		Name = 'Proximity Range',
		Min = 10,
		Max = 200,
		Default = 50,
		Suffix = ' studs',
		Tooltip = 'Range to auto select nearby players'
	}
	aw.Object.Visible = true
	ax.Object.Visible = true
	ay.Object.Visible = false
	az.Object.Visible = false
end)
a(function()
	local ar, at, au, av, aw, ax = {
		Enabled = false
	}, {}, {}, 0
	local function cleanupDeadReferences()
		for ay, az in pairs(at) do
			if not ay or not ay.Parent then
				at[ay] = nil
				au[ay] = nil
			end
		end
	end
	local function removeNeonFromPart(ay)
		if ay:IsA'BasePart' then
			if au[ay] then
				return
			end
			if ay.Material == Enum.Material.Neon then
				if not at[ay] then
					at[ay] = {
						Material = ay.Material,
						Reflectance = ay.Reflectance
					}
				end
				ay.Material = Enum.Material.Plastic
				ay.Reflectance = 0
				au[ay] = true
			end
		end
	end
	local function restoreNeon()
		for ay, az in pairs(at) do
			if ay and ay.Parent then
				pcall(function()
					ay.Material = az.Material
					ay.Reflectance = az.Reflectance
				end)
			end
		end
		table.clear(at)
		table.clear(au)
	end
	local function batchProcessParts(ay, az)
		local aA = 0
		for aB, aC in ipairs(ay) do
			if aC and aC.Parent then
				removeNeonFromPart(aC)
				aA = aA + 1
			end
			if aB % az == 0 then
				task.wait()
			end
		end
		return aA
	end
	ar = v.Categories.BoostFPS:CreateModule{
		Name = 'RemoveNeon',
		Function = function(ay)
			if ay then
				task.spawn(function()
					local az = {}
					for aA, aB in pairs(workspace:GetDescendants()) do
						if aB:IsA'BasePart' then
							table.insert(az, aB)
						end
					end
					batchProcessParts(az, 50)
				end)
				aw = workspace.DescendantAdded:Connect(function(az)
					if ar.Enabled then
						removeNeonFromPart(az)
					end
				end)
				ax = task.spawn(function()
					while ar.Enabled do
						task.wait(5)
						if ar.Enabled then
							local az = {}
							for aA, aB in pairs(workspace:GetDescendants()) do
								if aB:IsA'BasePart' and not au[aB] and aB.Material == Enum.Material.Neon then
									table.insert(az, aB)
								end
							end
							if # az > 0 then
								batchProcessParts(az, 25)
							end
							if tick() - av > 15 then
								cleanupDeadReferences()
								av = tick()
							end
						end
					end
				end)
			else
				if aw then
					aw:Disconnect()
					aw = nil
				end
				if ax then
					task.cancel(ax)
					ax = nil
				end
				restoreNeon()
			end
		end,
		Tooltip = 'Removes all neon materials for better FPS'
	}
end)
a(function()
	local ar, at, au
	ar = v.Categories.Utility:CreateModule{
		Name = 'MiloExploit',
		Function = function(av)
			if not av then
				return
			end
			ar:Toggle(false)
			au = O.MimicController.onAbilityUsed
			O.MimicController.onAbilityUsed = function(aw, ax)
				if not B.isAlive then
					return nil
				end
				task.spawn(function()
					local ay = {
						data = {
							blockType = at.Value or 'wool_red'
						}
					}
					O.Client:Get(P.MimicBlock):SendToServer(ay)
				end)
			end
			if O.AbilityController:canUseAbility'MIMIC_BLOCK' then
				O.AbilityController:useAbility'MIMIC_BLOCK'
				task.wait(2)
				O.MimicController.onAbilityUsed = au
				au = nil
			end
		end,
		Tooltip = 'Allows you to mimic any block you want without the block being there'
	}
	at = ar:CreateTextBox{
		Name = 'Blocks',
		Tooltip = 'Only use meta names (ex. wool_blue wool_red (like its customs))',
		Default = 'obsidian'
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI = e, g, {
		autoMinigameActive = false,
		pullAnimationTrack = nil,
		successAnimationTrack = nil,
		espHook = nil,
		notifQueue = {},
		heartbeatConn = nil
	}, {
		fishNames = {
			fish_iron = 'Iron Fish',
			fish_diamond = 'Diamond Fish',
			fish_gold = 'Gold Fish',
			fish_special = 'Special Fish',
			fish_emerald = 'Emerald Fish'
		},
		defaultBlacklist = {
			'fish_iron'
		}
	}
	local function safeCall(aJ, ...)
		local aK, aL = pcall(aJ, ...)
		if not aK then
			warn('[AeroV4] Error:', aL)
		end
		return aK, aL
	end
	local function buildMessage(aJ, aK)
		local aL = av.fishNames[aJ] or aJ
		if aJ == 'fish_special' then
			if aK and aK[1] then
				return string.format('You caught a %s! You will receive a %s', aL, tostring(aK[1].itemType))
			else
				return string.format('You caught a %s! (special item incoming)', aL)
			end
		end
		if aK and aK[1] then
			local aM = aK[1]
			return string.format('You caught a %s! Receiving %dx %s', aL, aM.amount or 0, tostring(aM.itemType))
		end
		return string.format('You caught a %s!', aL)
	end
	local function queueNotification(aJ, aK, aL)
		table.insert(au.notifQueue, {
			title = aJ,
			message = aK,
			duration = aL or 5
		})
	end
	local function stopAllAnimations()
		if au.pullAnimationTrack then
			safeCall(function()
				au.pullAnimationTrack:Stop()
			end)
			au.pullAnimationTrack = nil
		end
		if au.successAnimationTrack then
			safeCall(function()
				au.successAnimationTrack:Stop()
			end)
			au.successAnimationTrack = nil
		end
	end
	local function playAnimation(aJ)
		if not O or not O.GameAnimationUtil then
			return nil
		end
		local aK, aL = safeCall(function()
			return O.GameAnimationUtil:playAnimation(t, aJ)
		end)
		return aK and aL or nil
	end
	local function setupESP()
		if not O or not O.FishingMinigameController then
			warn'[AutoFisher] FishingMinigameController not found'
			return
		end
		if au.espHook then
			return
		end
		au.espHook = O.FishingMinigameController.startMinigame
		O.FishingMinigameController.startMinigame = function(aJ, aK, aL)
			if aF.Enabled and aG.Enabled and aK and aK.fishModel then
				queueNotification('Fisherman ESP', buildMessage(aK.fishModel, aK.drops), 8)
			end
			return au.espHook(aJ, aK, aL)
		end
		aw:Clean(function()
			if au.espHook then
				O.FishingMinigameController.startMinigame = au.espHook
				au.espHook = nil
			end
		end)
	end
	local function cleanupESP()
		if au.espHook then
			O.FishingMinigameController.startMinigame = au.espHook
			au.espHook = nil
		end
	end
	local function shouldBlacklistFish(aJ)
		if not aD.Enabled or not aJ then
			return false
		end
		return table.find(aE.ListEnabled, aJ) ~= nil
	end
	local function getCompletionDelay()
		if aH and aH.Enabled then
			local aJ, aK = aI.ValueMin, aI.ValueMax
			return aJ + (aK - aJ) * math.random()
		else
			return ay.Value
		end
	end
	local function makePlayerJump()
		local aJ = t.Character
		if not aJ then
			return
		end
		local aK = aJ:FindFirstChildOfClass'Humanoid'
		if aK and aK:GetState() ~= Enum.HumanoidStateType.Jumping then
			aK:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
	local function setupAutoMinigame()
		if not O or not O.FishingMinigameController then
			warn'[AutoFisher] FishingMinigameController not found'
			return
		end
		local aJ = O.FishingMinigameController.startMinigame
		O.FishingMinigameController.startMinigame = function(aK, aL, aM)
			if not ax.Enabled then
				return aJ(aK, aL, aM)
			end
			if shouldBlacklistFish(aL and aL.fishModel) then
				makePlayerJump()
				return aJ(aK, aL, aM)
			end
			au.autoMinigameActive = true
			stopAllAnimations()
			local aN = getCompletionDelay()
			task.spawn(function()
				if az.Enabled and aN > 0 then
					au.pullAnimationTrack = playAnimation(O.AnimationType.FISHING_ROD_PULLING)
				end
				if aN > 0 then
					task.wait(aN)
				end
				if au.pullAnimationTrack then
					safeCall(function()
						au.pullAnimationTrack:Stop()
					end)
					au.pullAnimationTrack = nil
				end
				if aA.Enabled then
					au.successAnimationTrack = playAnimation(O.AnimationType.FISHING_ROD_CATCH_SUCCESS)
				end
				if aM then
					safeCall(function()
						aM{
							win = true
						}
					end)
				end
				task.wait(0.5)
				if au.successAnimationTrack then
					safeCall(function()
						au.successAnimationTrack:Stop()
					end)
					au.successAnimationTrack = nil
				end
				au.autoMinigameActive = false
			end)
		end
		aw:Clean(function()
			O.FishingMinigameController.startMinigame = aJ
			stopAllAnimations()
		end)
	end
	local function isTeammate(aJ)
		return aJ and aJ.Team == t.Team
	end
	local function setupFishermanSpy()
		if not O or not O.Client then
			warn'[AutoFisher] bedwars.Client not found'
			return
		end
		O.Client:WaitFor(P.FishCaught):andThen(function(aJ)
			aw:Clean(aJ:Connect(function(aK)
				local aL = aK.catchingPlayer and aK.catchingPlayer.Character
				if not aL then
					return
				end
				if aC.Enabled then
					local aM = ar:GetPlayerFromCharacter(aL)
					if isTeammate(aM) then
						return
					end
				end
				local aM, aN = aK.dropData and aK.dropData.fishModel, aL.Name
				local aO, aP = aN:sub(1, 1):upper() .. aN:sub(2), av.fishNames[tostring(aM)] or 'Unknown Fish'
				queueNotification('Fisherman Spy', string.format('%s caught a %s', aO, aP), 8)
			end))
		end)
	end
	local function updateUIVisibility()
		local aJ, aK, aL, aM, aN = ax and ax.Enabled, aH and aH.Enabled, aF and aF.Enabled, aD and aD.Enabled, aB and aB.Enabled
		if ay and ay.Object then
			ay.Object.Visible = aJ and not aK
		end
		if aH and aH.Object then
			aH.Object.Visible = aJ
		end
		if aI and aI.Object then
			aI.Object.Visible = aJ and aK
		end
		if az and az.Object then
			az.Object.Visible = aJ
		end
		if aA and aA.Object then
			aA.Object.Visible = aJ
		end
		if aG and aG.Object then
			aG.Object.Visible = aL
		end
		if aE and aE.Object then
			aE.Object.Visible = aM
		end
		if aC and aC.Object then
			aC.Object.Visible = aN
		end
	end
	local function startNotificationQueue()
		au.heartbeatConn = at.Heartbeat:Connect(function()
			if # au.notifQueue == 0 then
				return
			end
			local aJ = table.remove(au.notifQueue, 1)
			safeCall(notif, aJ.title, aJ.message, aJ.duration)
		end)
		aw:Clean(au.heartbeatConn)
	end
	local function cleanup()
		au.autoMinigameActive = false
		stopAllAnimations()
		cleanupESP()
		au.notifQueue = {}
	end
	aw = v.Categories.Kits:CreateModule{
		Name = 'AutoFisher',
		Tooltip = 'Auto minigame, loot ESP, blacklist, and spy for the Fisherman kit',
		Function = function(aJ)
			if aJ then
				if aF.Enabled then
					setupESP()
				end
				if ax.Enabled then
					setupAutoMinigame()
				end
				if aB.Enabled then
					setupFishermanSpy()
				end
				startNotificationQueue()
			else
				cleanup()
			end
		end
	}
	ax = aw:CreateToggle{
		Name = 'Auto Minigame',
		Default = false,
		Tooltip = 'Automatically complete the fishing minigame',
		Function = function(aJ)
			updateUIVisibility()
			if aw.Enabled and aJ then
				setupAutoMinigame()
			end
		end
	}
	ay = aw:CreateSlider{
		Name = 'Complete Delay',
		Min = 0,
		Max = 5,
		Default = 1,
		Decimal = 10,
		Suffix = 's',
		Visible = false,
		Tooltip = 'Delay before auto-completing (looks more legit)'
	}
	aH = aw:CreateToggle{
		Name = 'Randomize Timing',
		Default = false,
		Visible = false,
		Tooltip = 'Use random delay between min and max instead of fixed delay',
		Function = function(aJ)
			updateUIVisibility()
		end
	}
	aI = aw:CreateTwoSlider{
		Name = 'Random Delay Range',
		Min = 0.1,
		Max = 5,
		DefaultMin = 0.5,
		DefaultMax = 2,
		Decimal = 10,
		Visible = false,
		Tooltip = 'Minimum and maximum delay for random timing'
	}
	az = aw:CreateToggle{
		Name = 'Pull Animation',
		Default = true,
		Visible = false,
		Tooltip = 'Play rod-pulling animation during delay (requires delay > 0)'
	}
	aA = aw:CreateToggle{
		Name = 'Success Animation',
		Default = true,
		Visible = false,
		Tooltip = 'Play catch-success animation on completion'
	}
	aD = aw:CreateToggle{
		Name = 'Blacklist',
		Default = false,
		Tooltip = 'Auto-jump and skip auto-complete for blacklisted fish',
		Function = function(aJ)
			updateUIVisibility()
		end
	}
	aE = aw:CreateTextList{
		Name = 'Blacklist Fish',
		Default = av.defaultBlacklist,
		Visible = false
	}
	aF = aw:CreateToggle{
		Name = 'Fisherman ESP',
		Default = false,
		Tooltip = 'Shows what fish you are catching and what loot you will receive',
		Function = function(aJ)
			updateUIVisibility()
			if aw.Enabled then
				if aJ then
					setupESP()
				else
					cleanupESP()
				end
			end
		end
	}
	aG = aw:CreateToggle{
		Name = 'Notify Loot',
		Default = true,
		Visible = false,
		Tooltip = 'Show a notification with the fish name and loot details'
	}
	aB = aw:CreateToggle{
		Name = 'Fish Spy',
		Default = false,
		Tooltip = 'Get notified when other players catch fish',
		Function = function(aJ)
			updateUIVisibility()
			if aw.Enabled and aJ then
				setupFishermanSpy()
			end
		end
	}
	aC = aw:CreateToggle{
		Name = 'Ignore Teammates',
		Default = true,
		Visible = false,
		Tooltip = "Don't notify for teammates catching fish"
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA
	local function canUseAbility(aB)
		return O.AbilityController:canUseAbility(aB)
	end
	local function useAbility(aB)
		O.AbilityController:useAbility(aB)
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoRamil',
		Function = function(aB)
			if aB then
				task.spawn(function()
					repeat
						if not B.isAlive then
							task.wait(0.1)
							continue
						end
						local aC, aD = B.AllPosition{
							Range = aw.Value,
							Wallcheck = at.Walls.Enabled,
							Part = 'RootPart',
							Players = at.Players.Enabled,
							NPCs = at.NPCs.Enabled,
							Limit = az.Value,
							Sort = aa[aA.Value]
						}, B.character
						local aE = aD.RootPart
						if aC and aC[1] and aC[1].RootPart then
							local aF = aC[1]
							pcall(function()
								vapeTargetInfo.Targets.AutoRamil = {
									Humanoid = {
										Health = (aF.Character:GetAttribute'Health' or aF.Humanoid.Health) + (getShieldAttribute and getShieldAttribute(aF.Character) or 0),
										MaxHealth = aF.Character:GetAttribute'MaxHealth' or aF.Humanoid.MaxHealth
									},
									Player = aF.Player
								}
							end)
						else
							vapeTargetInfo.Targets.AutoRamil = nil
						end
						if au.Enabled and aC and aC[1] and aC[1].RootPart then
							local aF = aC[1]
							local aG, aH = aF.RootPart.Position - aE.Position, aE.CFrame.LookVector * Vector3.new(1, 0, 1)
							local aI = math.acos(aH:Dot((aG * Vector3.new(1, 0, 1)).Unit))
							if aI <= (math.rad(ay.Value) / 2) then
								if canUseAbility'airbender_tornado' then
									O.GameAnimationUtil:playAnimation(t, O.AnimationType.AIRBENDER_CAST)
									useAbility'airbender_tornado'
								end
							end
						end
						if av.Enabled then
							local aF = B.AllPosition{
								Range = ax.Value,
								Wallcheck = at.Walls.Enabled,
								Part = 'RootPart',
								Players = at.Players.Enabled,
								NPCs = at.NPCs.Enabled,
								Limit = az.Value,
								Sort = aa[aA.Value]
							}
							if aF and aF[1] and aF[1].RootPart then
								local aG = aF[1]
								local aH, aI = aG.RootPart.Position - aE.Position, aE.CFrame.LookVector * Vector3.new(1, 0, 1)
								local aJ = math.acos(aI:Dot((aH * Vector3.new(1, 0, 1)).Unit))
								if aJ <= (math.rad(ay.Value) / 2) then
									if canUseAbility'airbender_moving_tornado' then
										O.GameAnimationUtil:playAnimation(t, O.AnimationType.AIRBENDER_CHARGING)
										useAbility'airbender_moving_tornado'
									end
								end
							end
						end
						task.wait(0.05)
					until not ar.Enabled
				end)
			else
				vapeTargetInfo.Targets.AutoRamil = nil
			end
		end,
		Tooltip = 'Automatically uses Ramil tornadoes on enemies'
	}
	at = ar:CreateTargets{
		Players = true,
		NPCs = false,
		Walls = true
	}
	aA = ar:CreateDropdown{
		Name = 'Sort Method',
		List = {
			'Distance',
			'Health',
			'Threat',
			'Damage',
			'Kit',
			'Angle'
		},
		Default = 'Distance',
		Tooltip = 'How to prioritize targets'
	}
	au = ar:CreateToggle{
		Name = 'Auto Tornado',
		Default = true,
		Tooltip = 'Automatically use stationary tornado',
		Function = function(aB)
			if aw and aw.Object then
				aw.Object.Visible = aB
			end
		end
	}
	aw = ar:CreateSlider{
		Name = 'Tornado Range',
		Min = 1,
		Max = 30,
		Default = 18,
		Visible = true,
		Suffix = function(aB)
			return aB == 1 and ' stud' or ' studs'
		end,
		Tooltip = 'Range for stationary tornado'
	}
	av = ar:CreateToggle{
		Name = 'Auto Moving Tornado',
		Default = false,
		Tooltip = 'Automatically use moving tornado',
		Function = function(aB)
			if ax and ax.Object then
				ax.Object.Visible = aB
			end
		end
	}
	ax = ar:CreateSlider{
		Name = 'Moving Range',
		Min = 1,
		Max = 35,
		Default = 20,
		Visible = false,
		Suffix = function(aB)
			return aB == 1 and ' stud' or ' studs'
		end,
		Tooltip = 'Range for moving tornado'
	}
	ay = ar:CreateSlider{
		Name = 'FOV Angle',
		Min = 0,
		Max = 360,
		Default = 180,
		Suffix = '\u{b0}',
		Tooltip = 'Field of view angle for targeting'
	}
	az = ar:CreateSlider{
		Name = 'Max Targets',
		Min = 1,
		Max = 5,
		Default = 2,
		Tooltip = 'Maximum number of targets to check'
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF = false, false, false, 0, false
	local function isHoldingOwlOrb()
		if not B.isAlive then
			return false
		end
		local aG = L.inventory
		if aG and aG.inventory and aG.inventory.hand then
			local aH = aG.inventory.hand
			if aH and aH.itemType == 'owl_orb' then
				return true
			end
		end
		return false
	end
	local function getMountedPlayer()
		local aG = t:GetAttribute'OwlTarget'
		if aG then
			return e:GetPlayerByUserId(aG)
		end
		return nil
	end
	local function mountBirdToPlayer(aG)
		if not aG or not aG.Character then
			return false
		end
		if aC.Enabled and not isHoldingOwlOrb() then
			return false
		end
		local aH = false
		pcall(function()
			local aI = O.Client:Get(P.SummonOwl).instance:InvokeServer(aG)
			if aI then
				task.wait(0.05)
				pcall(function()
					O.Client:Get(P.UseAbility).instance:FireServer'SUMMON_OWL'
				end)
				aF = aG
				aH = true
			end
		end)
		return aH
	end
	local function demountOwl()
		pcall(function()
			O.Client:Get(P.UseAbility).instance:FireServer'DEACTIVE_OWL'
			task.wait(0.05)
			O.Client:Get(P.RemoveOwl).instance:FireServer()
		end)
		aF = nil
	end
	local function healTarget()
		if not aE then
			return
		end
		pcall(function()
			O.Client:Get(P.OwlActionAbilities):SendToServer{
				target = aE,
				ability = 'owl_heal'
			}
			task.wait(0.022)
			O.Client:Get(P.UseAbility).instance:FireServer'OWL_HEAL'
		end)
	end
	local function isFalling(aG)
		if not aG or not aG.Character or not aG.Character.PrimaryPart then
			return false
		end
		local aH = aG.Character.PrimaryPart.AssemblyLinearVelocity.Y
		return aH < - 20
	end
	local aG = RaycastParams.new()
	aG.FilterType = Enum.RaycastFilterType.Blacklist
	aG.RespectCanCollide = true
	local function isAboveVoid(aH)
		if not aH or not aH.Character or not aH.Character.PrimaryPart then
			return false
		end
		local aI, aJ = aH.Character.PrimaryPart.Position, Vector3.new(0, - 1E3, 0)
		aG.FilterDescendantsInstances = {
			aH.Character,
			s
		}
		local aK = workspace:Raycast(aI, aJ, aG)
		if not aK then
			return true
		end
		return aK.Distance > 200
	end
	local function activateFly()
		if not aE then
			return
		end
		pcall(function()
			O.Client:Get(P.OwlActionAbilities):SendToServer{
				target = aE,
				ability = 'owl_lift'
			}
			task.wait(0.022)
			O.Client:Get(P.UseAbility).instance:FireServer'OWL_LIFT'
			aw = true
			task.spawn(function()
				task.wait(85)
				aw = false
			end)
		end)
	end
	ax = v.Categories.Kits:CreateModule{
		Name = 'AutoWhisper',
		Function = function(aH)
			ar = aH
			at = aH
			au = aH
			if aH then
				task.spawn(function()
					while ar do
						if aC.Enabled and not isHoldingOwlOrb() then
							task.wait(0.2)
							continue
						end
						local aI = e:FindFirstChild(ay.Value)
						if aI then
							aE = aI
							local aJ = getMountedPlayer()
							if aJ ~= aI then
								if aJ and aJ ~= aI then
									demountOwl()
									task.wait(0.3)
								end
								if not aJ or aJ ~= aI then
									local aK = mountBirdToPlayer(aI)
									if not aK then
										task.wait(0.5)
									else
										task.wait(1)
									end
								end
							else
								task.wait(0.5)
							end
						else
							task.wait(0.5)
						end
					end
				end)
				if az.Enabled then
					task.spawn(function()
						while at and az.Enabled do
							if aE and aF == aE then
								local aI, aJ = getPlayerHealth(aE)
								local aK = (aI / aJ) * 100
								if aK < aA.Value and aK < 90 then
									healTarget()
									task.wait(8.5)
								end
							end
							task.wait(0.5)
						end
					end)
				end
				if aB.Enabled then
					task.spawn(function()
						while au and aB.Enabled do
							if aE and aF == aE and not aw then
								if isFalling(aE) and isAboveVoid(aE) then
									av = av + 0.1
									if av >= 0.5 then
										activateFly()
										av = 0
									end
								else
									av = 0
								end
							else
								av = 0
							end
							task.wait(0.1)
						end
					end)
				end
				ax:Clean(e.PlayerAdded:Connect(function()
					task.wait(0.5)
					local aI = getTeammateNames()
					if ay then
						ay:Change(aI)
						if # aI > 0 then
							if not ay.Value or ay.Value == '' or not table.find(aI, ay.Value) then
								ay:SetValue(aI[1])
							end
						end
					end
				end))
				ax:Clean(e.PlayerRemoving:Connect(function(aI)
					task.wait(0.5)
					local aJ = getTeammateNames()
					if ay then
						ay:Change(aJ)
						if # aJ > 0 then
							if not ay.Value or ay.Value == '' or not table.find(aJ, ay.Value) then
								ay:SetValue(aJ[1])
							end
						end
					end
					if aE == aI then
						aE = nil
						aF = nil
					end
				end))
				ax:Clean(t:GetAttributeChangedSignal'Team':Connect(function()
					task.wait(0.5)
					local aI = getTeammateNames()
					if ay then
						ay:Change(aI)
						if # aI > 0 then
							if not ay.Value or ay.Value == '' or not table.find(aI, ay.Value) then
								ay:SetValue(aI[1])
							end
						end
					end
					aE = nil
					aF = nil
					aw = false
				end))
			else
				ar = false
				at = false
				au = false
				aE = nil
				aF = nil
				aw = false
				av = 0
			end
		end,
		Tooltip = 'Automatically mount bird to teammate, heal them, and save from void'
	}
	ay = ax:CreateDropdown{
		Name = 'Mount Target',
		List = {},
		Function = function(aH)
			if aH then
				local aI = e:FindFirstChild(aH)
				if aI then
					aE = aI
				end
			end
		end,
		Tooltip = 'Select teammate to mount owl to'
	}
	aD = ax:CreateButton{
		Name = 'Refresh Teammates',
		Function = function()
			task.spawn(function()
				local aH = getTeammateNames()
				if ay then
					pcall(function()
						ay:Change(aH)
						if # aH > 0 then
							if not ay.Value or ay.Value == '' or not table.find(aH, ay.Value) then
								ay:SetValue(aH[1])
							else
								ay:SetValue(ay.Value)
							end
						end
					end)
				end
				notif('Auto Whisper', string.format('Refreshed teammate list (%d teammates)', # aH), 2)
			end)
		end,
		Tooltip = 'Manually refresh the teammate list'
	}
	aC = ax:CreateToggle{
		Name = 'Limit to Owl Orb',
		Default = true,
		Function = function(aH)
		end,
		Tooltip = 'Only mount owl when holding owl_orb item'
	}
	aB = ax:CreateToggle{
		Name = 'Auto Fly',
		Default = true,
		Function = function(aH)
			if ax.Enabled then
				if aH then
					au = true
					aw = false
					av = 0
					task.spawn(function()
						while au and aB.Enabled do
							if aE and aF == aE and not aw then
								if isFalling(aE) and isAboveVoid(aE) then
									av = av + 0.1
									if av >= 0.5 then
										activateFly()
										av = 0
									end
								else
									av = 0
								end
							else
								av = 0
							end
							task.wait(0.1)
						end
					end)
				else
					au = false
					aw = false
					av = 0
				end
			end
		end,
		Tooltip = 'Automatically activate lift when target is falling into void'
	}
	az = ax:CreateToggle{
		Name = 'Auto Heal',
		Default = true,
		Function = function(aH)
			if aA and aA.Object then
				aA.Object.Visible = aH
			end
			if ax.Enabled then
				if aH then
					at = true
					task.spawn(function()
						while at and az.Enabled do
							if aE and aF == aE then
								local aI, aJ = getPlayerHealth(aE)
								local aK = (aI / aJ) * 100
								if aK < aA.Value and aK < 90 then
									healTarget()
									task.wait(8.5)
								end
							end
							task.wait(0.5)
						end
					end)
				else
					at = false
				end
			end
		end,
		Tooltip = 'Automatically heal target when health drops below threshold'
	}
	aA = ax:CreateSlider{
		Name = 'Heal Threshold',
		Min = 1,
		Max = 100,
		Default = 50,
		Suffix = '%',
		Tooltip = "Heal when target's health drops below this percentage (stops at 90%)"
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD = (Instance.new'Folder')
	ar.Parent = v.gui
	local aE, aF, aG, aH, aI = {}, 0, {}, 1, false
	local function sendNotification(aJ)
		notif('Eldertree ESP', string.format('%d orbs spawned', aJ), 3)
	end
	local function processSpawnQueue()
		if # aG > 0 then
			local aJ = tick()
			if aJ - aF >= aH then
				sendNotification(# aG)
				aF = aJ
				aG = {}
			else
				task.delay(aH - (aJ - aF), function()
					if # aG > 0 then
						sendNotification(# aG)
						aG = {}
					end
				end)
			end
		end
	end
	local function isHoldingSword()
		if not L.hand or not L.hand.tool then
			return false
		end
		local aJ = O.ItemMeta[L.hand.tool.Name]
		return aJ and aJ.sword
	end
	local function getProperImage()
		return O.getIcon({
			itemType = 'natures_essence_1'
		}, true)
	end
	local function Added(aJ)
		if aE[aJ] then
			return
		end
		local aK = Instance.new'BillboardGui'
		aK.Parent = ar
		aK.Name = 'treeOrb'
		aK.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aK.Size = UDim2.fromOffset(36, 36)
		aK.AlwaysOnTop = true
		aK.ClipsDescendants = false
		aK.Adornee = aJ
		local aL = addBlur(aK)
		aL.Visible = aB.Enabled
		local aM = Instance.new'ImageLabel'
		aM.Size = UDim2.fromOffset(36, 36)
		aM.Position = UDim2.fromScale(0.5, 0.5)
		aM.AnchorPoint = Vector2.new(0.5, 0.5)
		aM.BackgroundColor3 = Color3.fromHSV(aC.Hue, aC.Sat, aC.Value)
		aM.BackgroundTransparency = 1 - (aB.Enabled and aC.Opacity or 0)
		aM.BorderSizePixel = 0
		aM.Image = getProperImage()
		aM.Parent = aK
		local aN = Instance.new'UICorner'
		aN.CornerRadius = UDim.new(0, 4)
		aN.Parent = aM
		aE[aJ] = aK
		if aA.Enabled then
			table.insert(aG, {
				item = 'orb',
				time = tick()
			})
			processSpawnQueue()
		end
	end
	local function Removed(aJ)
		if aE[aJ] then
			aE[aJ]:Destroy()
			aE[aJ] = nil
		end
	end
	local function setupESP()
		for aJ, aK in l:GetTagged'treeOrb' do
			if aK:IsA'Model' and aK.PrimaryPart then
				Added(aK.PrimaryPart)
			end
		end
		at:Clean(l:GetInstanceAddedSignal'treeOrb':Connect(function(aJ)
			if aJ:IsA'Model' and aJ.PrimaryPart then
				task.wait(0.1)
				Added(aJ.PrimaryPart)
			end
		end))
		at:Clean(l:GetInstanceRemovedSignal'treeOrb':Connect(function(aJ)
			if aJ.PrimaryPart then
				Removed(aJ.PrimaryPart)
			end
		end))
		at:Clean(g.RenderStepped:Connect(function()
			if not az.Enabled then
				return
			end
			for aJ, aK in pairs(aE) do
				if not aJ or not aJ.Parent then
					Removed(aJ)
					continue
				end
				local aL = true
				if aD.Enabled and isHoldingSword() then
					aL = false
				end
				aK.Enabled = aL
			end
		end))
	end
	local function collectOrb(aJ)
		if not aJ or not aJ.Parent then
			return false
		end
		local aK = aJ:GetAttribute'TreeOrbSecret'
		if not aK then
			return false
		end
		if B.isAlive then
			O.GameAnimationUtil:playAnimation(t, O.AnimationType.PUNCH)
			O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
			O.SoundManager:playSound(O.SoundList.CROP_HARVEST)
		end
		local aL = O.Client:Get(P.ConsumeTreeOrb):CallServer{
			treeOrbSecret = aK
		}
		if aL then
			aJ:Destroy()
			return true
		end
		return false
	end
	local function startCollection()
		aI = true
		task.spawn(function()
			while aI and at.Enabled and au.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aJ, aK, aL = B.character.RootPart.Position, ay.Value, false
				for aM, aN in l:GetTagged'treeOrb' do
					if not aI or not at.Enabled or not au.Enabled then
						break
					end
					if aN:IsA'Model' and aN.PrimaryPart then
						local aO = aN.PrimaryPart.Position
						local aP = (aJ - aO).Magnitude
						if aP <= aK then
							aL = true
							if aw.Enabled and ax.Value > 0 then
								task.wait(ax.Value)
							end
							if collectOrb(aN) then
								task.wait(0.1)
							end
						end
					end
				end
				if not aL then
					task.wait(0.2)
				else
					task.wait(0.1)
				end
			end
			aI = false
		end)
	end
	at = v.Categories.Kits:CreateModule{
		Name = 'AutoEldertree',
		Function = function(aJ)
			if aJ then
				if az.Enabled then
					setupESP()
				end
				if au.Enabled then
					startCollection()
				end
			else
				aI = false
				ar:ClearAllChildren()
				table.clear(aE)
				table.clear(aG)
				aF = 0
			end
		end,
		Tooltip = 'automatically collects tree orbs and esp'
	}
	au = at:CreateToggle{
		Name = 'Auto Collect',
		Default = true,
		Tooltip = 'automatically collect tree orbs',
		Function = function(aJ)
			if av and av.Object then
				av.Object.Visible = aJ
			end
			if aw and aw.Object then
				aw.Object.Visible = aJ
			end
			if ax and ax.Object then
				ax.Object.Visible = (aJ and aw.Enabled)
			end
			if ay and ay.Object then
				ay.Object.Visible = aJ
			end
			if not aJ then
				if ax and ax.Object then
					ax.Object.Visible = false
				end
			else
				if aw and aw.Enabled then
					if ax and ax.Object then
						ax.Object.Visible = true
					end
				end
			end
			if aJ and at.Enabled then
				startCollection()
			else
				aI = false
			end
		end
	}
	av = at:CreateToggle{
		Name = 'Animation',
		Default = true,
		Tooltip = 'play collection animation and sound'
	}
	aw = at:CreateToggle{
		Name = 'Collection Delay',
		Default = false,
		Tooltip = 'add delay before collecting orbs',
		Function = function(aJ)
			if ax and ax.Object then
				ax.Object.Visible = aJ
			end
		end
	}
	ax = at:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'delay in seconds before collecting'
	}
	ay = at:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 10,
		Default = 10,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'control distance you want to collect orbs'
	}
	az = at:CreateToggle{
		Name = 'Eldertree ESP',
		Default = false,
		Tooltip = 'shows tree orb locations',
		Function = function(aJ)
			if aA and aA.Object then
				aA.Object.Visible = aJ
			end
			if aB and aB.Object then
				aB.Object.Visible = aJ
			end
			if aC and aC.Object then
				aC.Object.Visible = aJ
			end
			if aD and aD.Object then
				aD.Object.Visible = aJ
			end
			if not aJ then
				if aC and aC.Object then
					aC.Object.Visible = false
				end
			else
				if aB and aB.Enabled then
					if aC and aC.Object then
						aC.Object.Visible = true
					end
				end
			end
			if at.Enabled then
				if aJ then
					setupESP()
				else
					ar:ClearAllChildren()
					table.clear(aE)
				end
			end
		end
	}
	aA = at:CreateToggle{
		Name = 'Notify',
		Default = false,
		Tooltip = 'get notifications when orbs spawn'
	}
	aB = at:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aJ)
			if aC and aC.Object then
				aC.Object.Visible = aJ
			end
			for aK, aL in aE do
				if aL and aL:FindFirstChild'ImageLabel' then
					aL.ImageLabel.BackgroundTransparency = 1 - (aJ and aC.Opacity or 0)
					if aL:FindFirstChild'Blur' then
						aL.Blur.Visible = aJ
					end
				end
			end
		end
	}
	aC = at:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(aJ, aK, aL, aM)
			for aN, aO in aE do
				if aO and aO:FindFirstChild'ImageLabel' then
					aO.ImageLabel.BackgroundColor3 = Color3.fromHSV(aJ, aK, aL)
					aO.ImageLabel.BackgroundTransparency = 1 - aM
				end
			end
		end,
		Darker = true
	}
	aD = at:CreateToggle{
		Name = 'Sword Check',
		Default = false,
		Tooltip = 'only show esp when holding a sword'
	}
	task.defer(function()
		if ax and ax.Object then
			ax.Object.Visible = false
		end
		if aA and aA.Object then
			aA.Object.Visible = false
		end
		if aB and aB.Object then
			aB.Object.Visible = false
		end
		if aC and aC.Object then
			aC.Object.Visible = false
		end
		if aD and aD.Object then
			aD.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB = (Instance.new'Folder')
	ar.Parent = v.gui
	local aC, aD, aE, aF, aG, aH, aI = {}, {}, 0.5, 0, {}, 1, false
	local function sendNotification(aJ)
		notif('Star ESP', string.format('%d stars spawned', aJ), 3)
	end
	local function processSpawnQueue()
		if # aG > 0 then
			local aJ = tick()
			if aJ - aF >= aH then
				sendNotification(# aG)
				aF = aJ
				aG = {}
			else
				task.delay(aH - (aJ - aF), function()
					if # aG > 0 then
						sendNotification(# aG)
						aG = {}
					end
				end)
			end
		end
	end
	local function isHoldingSword()
		if not L.hand or not L.hand.tool then
			return false
		end
		local aJ = O.ItemMeta[L.hand.tool.Name]
		return aJ and aJ.sword
	end
	local function getProperImage(aJ)
		local aK = aJ.Parent
		if aK and aK:IsA'Model' then
			local aL = aK.Name
			if aL == 'CritStar' then
				return O.getIcon({
					itemType = 'crit_star'
				}, true)
			elseif aL == 'VitalityStar' then
				return O.getIcon({
					itemType = 'vitality_star'
				}, true)
			elseif aL:find'vitality' or aL:lower():find'vitality' then
				return O.getIcon({
					itemType = 'vitality_star'
				}, true)
			elseif aL:find'crit' or aL:lower():find'crit' then
				return O.getIcon({
					itemType = 'crit_star'
				}, true)
			end
		end
		return O.getIcon({
			itemType = 'crit_star'
		}, true)
	end
	local function Added(aJ)
		if aC[aJ] then
			return
		end
		local aK = Instance.new'BillboardGui'
		aK.Parent = ar
		aK.Name = 'stars'
		aK.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aK.Size = UDim2.fromOffset(36, 36)
		aK.AlwaysOnTop = true
		aK.ClipsDescendants = false
		aK.Adornee = aJ
		local aL = addBlur(aK)
		aL.Visible = az.Enabled
		local aM = Instance.new'ImageLabel'
		aM.Size = UDim2.fromOffset(36, 36)
		aM.Position = UDim2.fromScale(0.5, 0.5)
		aM.AnchorPoint = Vector2.new(0.5, 0.5)
		aM.BackgroundColor3 = Color3.fromHSV(aA.Hue, aA.Sat, aA.Value)
		aM.BackgroundTransparency = 1 - (az.Enabled and aA.Opacity or 0)
		aM.BorderSizePixel = 0
		aM.Image = getProperImage(aJ)
		aM.Parent = aK
		local aN = Instance.new'UICorner'
		aN.CornerRadius = UDim.new(0, 4)
		aN.Parent = aM
		aC[aJ] = aK
		if ay.Enabled then
			table.insert(aG, {
				item = 'star',
				time = tick()
			})
			processSpawnQueue()
		end
	end
	local function Removed(aJ)
		if aC[aJ] then
			aC[aJ]:Destroy()
			aC[aJ] = nil
		end
		aD[aJ] = nil
	end
	local function setupESP()
		for aJ, aK in l:GetTagged'stars' do
			if aK:IsA'Model' and aK.PrimaryPart then
				Added(aK.PrimaryPart)
			end
		end
		at:Clean(l:GetInstanceAddedSignal'stars':Connect(function(aJ)
			if aJ:IsA'Model' and aJ.PrimaryPart then
				task.wait(0.1)
				Added(aJ.PrimaryPart)
			end
		end))
		at:Clean(l:GetInstanceRemovedSignal'stars':Connect(function(aJ)
			if aJ.PrimaryPart then
				Removed(aJ.PrimaryPart)
			end
		end))
		at:Clean(g.RenderStepped:Connect(function()
			if not ax.Enabled then
				return
			end
			for aJ, aK in pairs(aC) do
				if not aJ or not aJ.Parent then
					Removed(aJ)
					continue
				end
				local aL = true
				if aB.Enabled and isHoldingSword() then
					aL = false
				end
				aK.Enabled = aL
			end
		end))
	end
	local function collectStar(aJ)
		if not aJ or not aJ.Parent then
			return
		end
		if av.Enabled and B.isAlive then
			O.GameAnimationUtil:playAnimation(t, O.AnimationType.PUNCH)
			O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
		end
		O.StarCollectorController:collectEntity(t, aJ, aJ.Name)
	end
	local function startCollection()
		aI = true
		task.spawn(function()
			while aI and at.Enabled and au.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aJ, aK, aL = B.character.RootPart.Position, aw.Value, false
				for aM, aN in l:GetTagged'stars' do
					if not aI or not at.Enabled or not au.Enabled then
						break
					end
					if aN:IsA'Model' and aN.PrimaryPart then
						local aO = aN.PrimaryPart.Position
						local aP = (aJ - aO).Magnitude
						if aP <= aK then
							local aQ = aD[aN]
							if aQ and tick() - aQ < aE then
								continue
							end
							aD[aN] = tick()
							collectStar(aN)
							aL = true
							break
						end
					end
				end
				task.wait(aL and 0.1 or 0.2)
			end
			aI = false
		end)
	end
	at = v.Categories.Kits:CreateModule{
		Name = 'AutoStar',
		Function = function(aJ)
			if aJ then
				if ax.Enabled then
					setupESP()
				end
				if au.Enabled then
					startCollection()
				end
			else
				aI = false
				ar:ClearAllChildren()
				table.clear(aC)
				table.clear(aG)
				table.clear(aD)
				aF = 0
			end
		end,
		Tooltip = 'automatically collects stars and esp'
	}
	au = at:CreateToggle{
		Name = 'Auto Collect',
		Default = true,
		Tooltip = 'automatically collect stars',
		Function = function(aJ)
			if av and av.Object then
				av.Object.Visible = aJ
			end
			if aw and aw.Object then
				aw.Object.Visible = aJ
			end
			if aJ and at.Enabled then
				startCollection()
			else
				aI = false
			end
		end
	}
	av = at:CreateToggle{
		Name = 'Animation',
		Default = true,
		Tooltip = 'play collection animation and sound'
	}
	aw = at:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 18,
		Default = 10,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'control distance you want to collect stars'
	}
	ax = at:CreateToggle{
		Name = 'Star ESP',
		Default = false,
		Tooltip = 'shows star locations',
		Function = function(aJ)
			if ay and ay.Object then
				ay.Object.Visible = aJ
			end
			if az and az.Object then
				az.Object.Visible = aJ
			end
			if aA and aA.Object then
				aA.Object.Visible = aJ
			end
			if aB and aB.Object then
				aB.Object.Visible = aJ
			end
			if at.Enabled then
				if aJ then
					setupESP()
				else
					ar:ClearAllChildren()
					table.clear(aC)
				end
			end
		end
	}
	ay = at:CreateToggle{
		Name = 'Notify',
		Default = false,
		Tooltip = 'get notifications when stars spawn'
	}
	az = at:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aJ)
			if aA and aA.Object then
				aA.Object.Visible = aJ
			end
			for aK, aL in aC do
				if aL and aL:FindFirstChild'ImageLabel' then
					aL.ImageLabel.BackgroundTransparency = 1 - (aJ and aA.Opacity or 0)
					if aL:FindFirstChild'Blur' then
						aL.Blur.Visible = aJ
					end
				end
			end
		end
	}
	aA = at:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(aJ, aK, aL, aM)
			for aN, aO in aC do
				if aO and aO:FindFirstChild'ImageLabel' then
					aO.ImageLabel.BackgroundColor3 = Color3.fromHSV(aJ, aK, aL)
					aO.ImageLabel.BackgroundTransparency = 1 - aM
				end
			end
		end,
		Darker = true
	}
	aB = at:CreateToggle{
		Name = 'Sword Check',
		Default = false,
		Tooltip = 'only show esp when holding a sword'
	}
	task.defer(function()
		local aJ = ax and ax.Enabled
		if ay and ay.Object then
			ay.Object.Visible = aJ
		end
		if az and az.Object then
			az.Object.Visible = aJ
		end
		if aA and aA.Object then
			aA.Object.Visible = aJ
		end
		if aB and aB.Object then
			aB.Object.Visible = aJ
		end
	end)
end)
a(function()
	local ar, at, au, av, aw, ax, ay = false, 0, 1
	local function getItem(az)
		if not B.isAlive then
			return false
		end
		local aA = L.inventory
		if aA and aA.inventory and aA.inventory.hand then
			local aB = aA.inventory.hand
			if aB and aB.itemType == az then
				return true
			end
		end
		return false
	end
	local function getLowestHealthTeammate()
		if not B.isAlive then
			return nil
		end
		local az, aA, aB, aC = B.character.RootPart.Position, ay.Value, (math.huge)
		for aD, aE in B.List do
			if aE.Player and aE.Player ~= t and aE.Player:GetAttribute'Team' == t:GetAttribute'Team' then
				local aF = (az - aE.RootPart.Position).Magnitude
				if aF <= aA and aE.Health < aB and aE.Health < aE.MaxHealth then
					aB = aE.Health
					aC = aE
				end
			end
		end
		return aC
	end
	local function shouldSelfHeal()
		if not B.isAlive then
			return false
		end
		local az, aA = t.Character:GetAttribute'Health' or 0, t.Character:GetAttribute'MaxHealth' or 100
		return az < aA
	end
	local function performHeal(az)
		local aA = tick()
		if aA - at < au then
			return false
		end
		if not getItem'guitar' then
			return false
		end
		O.Client:Get(P.GuitarHeal):SendToServer{
			healTarget = az
		}
		at = aA
		return true
	end
	local function startHealing()
		ar = true
		task.spawn(function()
			while ar and av.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				if not getItem'guitar' then
					task.wait(0.2)
					continue
				end
				local az = false
				if aw.Enabled and shouldSelfHeal() then
					if performHeal(t.Character) then
						az = true
					end
				end
				if not az and ax.Enabled then
					local aA = getLowestHealthTeammate()
					if aA then
						if performHeal(aA.Character) then
							az = true
						end
					end
				end
				task.wait(0.1)
			end
			ar = false
		end)
	end
	av = v.Categories.Kits:CreateModule{
		Name = 'AutoMelody',
		Function = function(az)
			if az then
				at = 0
				startHealing()
			else
				ar = false
				at = 0
			end
		end,
		Tooltip = 'Automatically heals yourself and teammates with guitar'
	}
	aw = av:CreateToggle{
		Name = 'Self Heal',
		Default = true,
		Tooltip = 'Automatically heal yourself when damaged'
	}
	ax = av:CreateToggle{
		Name = 'Teammate Heal',
		Default = true,
		Tooltip = 'Automatically heal teammates when damaged',
		Function = function(az)
			if ay and ay.Object then
				ay.Object.Visible = az
			end
		end
	}
	ay = av:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 51,
		Default = 30,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'Maximum distance to heal teammates'
	}
end)
a(function()
	local ar, at, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE = nil, nil, nil, nil, nil, nil, nil, nil, false, 0, 0, {}, (cloneRaycast())
	local function trackDamage(aF, aG)
		local aH = aF.Player and aF.Player.UserId or tostring(aF)
		if not aD[aH] then
			aD[aH] = 0
		end
		aD[aH] = aD[aH] + (aG or 1)
	end
	local function isHoldingWizardStaff()
		if not L.hand or not L.hand.tool then
			return false
		end
		local aF = L.hand.tooltype or L.hand.tool.Name
		return aF and (aF:find'wizard_staff' or aF:find'zeno')
	end
	local function useAbility(aF, aG)
		local aH = pcall(function()
			O.Client:Get(P.UseAbility).instance:FireServer(aF, {
				target = aG
			})
		end)
		if aH then
			aB = tick()
		end
		return aH
	end
	local function performShockwave()
		if not ax.Enabled then
			return false
		end
		if not B.isAlive then
			return false
		end
		if not isHoldingWizardStaff() then
			return false
		end
		local aF = tick()
		if (aF - aC) < 1 then
			return false
		end
		local aG, aH, aI = B.character.RootPart.Position, ay.Value, 0
		for aJ, aK in B.List do
			if aK.RootPart then
				local aL = false
				if au.Players.Enabled and aK.Player and aK.Player ~= t then
					aL = isEnemy(aK)
				elseif au.NPCs.Enabled and aK.NPC then
					aL = isEnemy(aK)
				end
				if aL then
					local aM = (aK.RootPart.Position - aG).Magnitude
					if aM <= aH then
						aI = aI + 1
					end
				end
			end
		end
		if aI > 0 then
			local aJ = pcall(function()
				game:GetService'ReplicatedStorage':WaitForChild'events-@easy-games/game-core:shared/game-core-networking@getEvents.Events':WaitForChild'useAbility':FireServer('SHOCKWAVE', {
					target = Vector3.zero
				})
			end)
			if aJ then
				aC = aF
				return true
			end
		end
		return false
	end
	local function performLightningAbility()
		if not B.isAlive then
			return false
		end
		if not isHoldingWizardStaff() then
			return false
		end
		local aF, aG, aH = nil, B.character.RootPart.Position, (az.Value)
		local aI = B.AllPosition{
			Range = aH,
			Part = 'RootPart',
			Players = au.Players.Enabled,
			NPCs = au.NPCs.Enabled,
			Wallcheck = au.Walls.Enabled,
			Limit = 1,
			Sort = aa[SortMethod.Value]
		}
		aF = aI and aI[1]
		if not aF or not aF.RootPart then
			return false
		end
		if not isEnemy(aF) then
			return false
		end
		local aJ, aK = aF.RootPart.Position, false
		if aw.Enabled then
			if O.AbilityController:canUseAbility'LIGHTNING_STORM' then
				trackDamage(aF, 4)
				useAbility('LIGHTNING_STORM', aJ)
				aK = true
			end
		end
		if av.Enabled then
			if O.AbilityController:canUseAbility'LIGHTNING_STRIKE' then
				trackDamage(aF, 1)
				useAbility('LIGHTNING_STRIKE', aJ)
				aK = true
			end
		end
		return aK
	end
	local function startAbilityLoop()
		aA = true
		task.spawn(function()
			while aA and ar.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aF = performShockwave()
				if not aF then
					performLightningAbility()
				end
				task.wait(0.01)
			end
			aA = false
		end)
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoZeno',
		Function = function(aF)
			if aF then
				aB = 0
				aC = 0
				aD = {}
				startAbilityLoop()
			else
				aA = false
				aB = 0
				aC = 0
				aD = {}
			end
		end,
		Tooltip = 'Automatically uses Zeno wizard abilities on ENEMIES only'
	}
	au = ar:CreateTargets{
		Players = true,
		NPCs = false,
		Walls = true
	}
	SortMethod = ar:CreateDropdown{
		Name = 'Sort Method',
		List = {
			'Distance',
			'Damage',
			'Threat',
			'Kit',
			'Health',
			'Angle',
			'Cursor',
			'Forest'
		},
		Default = 'Distance',
		Tooltip = 'How to prioritize targets'
	}
	av = ar:CreateToggle{
		Name = 'Lightning Strike',
		Default = true,
		Tooltip = 'Use Lightning Strike ability'
	}
	aw = ar:CreateToggle{
		Name = 'Lightning Storm',
		Default = true,
		Tooltip = 'Use Lightning Storm ability (higher priority)'
	}
	ax = ar:CreateToggle{
		Name = 'Auto Shockwave',
		Default = false,
		Tooltip = 'Automatically use shockwave when enemies are nearby',
		Function = function(aF)
			if ay and ay.Object then
				ay.Object.Visible = aF
			end
		end
	}
	ay = ar:CreateSlider{
		Name = 'Shockwave Range',
		Min = 1,
		Max = 12,
		Default = 8,
		Suffix = ' studs',
		Visible = false,
		Tooltip = 'Range to activate shockwave'
	}
	az = ar:CreateSlider{
		Name = 'Ability Range',
		Min = 1,
		Max = 50,
		Default = 30,
		Suffix = ' studs',
		Tooltip = 'Max range for lightning ability'
	}
end)
a(function()
	local ar
	DiamondToggle = nil
	EmeraldToggle = nil
	TeamGenToggle = nil
	ShowOwnTeamGen = nil
	ShowEnemyTeamGen = nil
	local au, av, aw, ax = nil, l, {}, (Instance.new'Folder')
	ax.Parent = v.gui
	local ay = Instance.new'Folder'
	ay.Parent = v.gui
	local az, aA, aB = {
		[1] = {
			name = 'Blue',
			color = Color3.fromRGB(85, 150, 255)
		},
		[2] = {
			name = 'Orange',
			color = Color3.fromRGB(255, 150, 50)
		},
		[3] = {
			name = 'Pink',
			color = Color3.fromRGB(255, 100, 200)
		},
		[4] = {
			name = 'Yellow',
			color = Color3.fromRGB(255, 255, 50)
		}
	}, {
		diamond = {
			keywords = {
				'diamond'
			},
			color = Color3.fromRGB(85, 200, 255),
			icon = 'diamond',
			displayName = 'Diamond',
			isTeamGen = false
		},
		emerald = {
			keywords = {
				'emerald'
			},
			color = Color3.fromRGB(0, 255, 100),
			icon = 'emerald',
			displayName = 'Emerald',
			isTeamGen = false
		}
	}, Instance.new'ScreenGui'
	aB.Name = 'GeneratorCompactUI'
	aB.Parent = v.gui
	aB.Enabled = false
	aB.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	aB.DisplayOrder = 10
	aB.ResetOnSpawn = false
	local aC = Instance.new'Frame'
	aC.Name = 'MainFrame'
	aC.Parent = aB
	aC.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	aC.BackgroundTransparency = 0.3
	aC.BorderSizePixel = 0
	aC.Position = UDim2.new(1, - 130, 0.5, - 50)
	aC.Size = UDim2.new(0, 120, 0, 100)
	aC.AnchorPoint = Vector2.new(0, 0.5)
	local aD = Instance.new'UICorner'
	aD.CornerRadius = UDim.new(0, 8)
	aD.Parent = aC
	local aE = Instance.new'TextLabel'
	aE.Name = 'Title'
	aE.Parent = aC
	aE.BackgroundTransparency = 1
	aE.Size = UDim2.new(1, 0, 0, 25)
	aE.Position = UDim2.new(0, 0, 0, 5)
	aE.Text = 'GEN ESP'
	aE.TextColor3 = Color3.fromRGB(255, 255, 255)
	aE.TextSize = 14
	aE.Font = Enum.Font.GothamBold
	aE.TextStrokeTransparency = 0.5
	aE.TextStrokeColor3 = Color3.new(0, 0, 0)
	local aF = Instance.new'Frame'
	aF.Name = 'DiamondFrame'
	aF.Parent = aC
	aF.BackgroundTransparency = 1
	aF.Size = UDim2.new(1, - 20, 0, 25)
	aF.Position = UDim2.new(0, 10, 0, 35)
	local aG = Instance.new'ImageLabel'
	aG.Name = 'DiamondIcon'
	aG.Parent = aF
	aG.BackgroundTransparency = 1
	aG.Size = UDim2.new(0, 18, 0, 18)
	aG.Position = UDim2.new(0, 0, 0.5, - 9)
	aG.Image = O.getIcon({
		itemType = 'diamond'
	}, true)
	local aH = Instance.new'TextLabel'
	aH.Name = 'DiamondTimer'
	aH.Parent = aF
	aH.BackgroundTransparency = 1
	aH.Size = UDim2.new(1, - 25, 1, 0)
	aH.Position = UDim2.new(0, 25, 0, 0)
	aH.Text = '00'
	aH.TextColor3 = Color3.fromRGB(85, 200, 255)
	aH.TextSize = 18
	aH.Font = Enum.Font.GothamBold
	aH.TextXAlignment = Enum.TextXAlignment.Left
	local aI = Instance.new'Frame'
	aI.Name = 'EmeraldFrame'
	aI.Parent = aC
	aI.BackgroundTransparency = 1
	aI.Size = UDim2.new(1, - 20, 0, 25)
	aI.Position = UDim2.new(0, 10, 0, 65)
	local aJ = Instance.new'ImageLabel'
	aJ.Name = 'EmeraldIcon'
	aJ.Parent = aI
	aJ.BackgroundTransparency = 1
	aJ.Size = UDim2.new(0, 18, 0, 18)
	aJ.Position = UDim2.new(0, 0, 0.5, - 9)
	aJ.Image = O.getIcon({
		itemType = 'emerald'
	}, true)
	local aK = Instance.new'TextLabel'
	aK.Name = 'EmeraldTimer'
	aK.Parent = aI
	aK.BackgroundTransparency = 1
	aK.Size = UDim2.new(1, - 25, 1, 0)
	aK.Position = UDim2.new(0, 25, 0, 0)
	aK.Text = '00'
	aK.TextColor3 = Color3.fromRGB(0, 255, 100)
	aK.TextSize = 18
	aK.Font = Enum.Font.GothamBold
	aK.TextXAlignment = Enum.TextXAlignment.Left
	local aL, aM = {}, {}
	local function getMyTeamId()
		local aN = t:GetAttribute'Team'
		if aN == nil then
			return nil
		end
		return tonumber(aN)
	end
	local function getGeneratorTeamId(aN)
		local aO = string.match(aN, '^(%d+)_generator')
		if aO then
			return tonumber(aO)
		end
		return nil
	end
	local function isTeamGenerator(aN)
		return string.match(aN, '^%d+_generator') ~= nil
	end
	local function getGeneratorType(aN)
		local aO = string.lower(aN)
		if isTeamGenerator(aN) then
			return 'teamgen', {
				color = Color3.fromRGB(200, 200, 200),
				icon = 'iron',
				displayName = 'Team Gen',
				isTeamGen = true
			}
		end
		for aP, aQ in pairs(aA) do
			for aR, aS in ipairs(aQ.keywords) do
				if aO:find(aS) then
					return aP, aQ
				end
			end
		end
		return nil, nil
	end
	local function isGeneratorEnabled(aN, aO)
		if aN == 'diamond' then
			return DiamondToggle.Enabled
		elseif aN == 'emerald' then
			return EmeraldToggle.Enabled
		elseif aN == 'teamgen' then
			if not TeamGenToggle.Enabled then
				return false
			end
			local aP = getMyTeamId()
			if not aP or not aO then
				return TeamGenToggle.Enabled
			end
			if aO == aP then
				return ShowOwnTeamGen.Enabled
			else
				return ShowEnemyTeamGen.Enabled
			end
		end
		return false
	end
	local function getProperIcon(aN)
		local aO = O.getIcon({
			itemType = aN
		}, true)
		if not aO or aO == '' then
			return nil
		end
		return aO
	end
	local function getTierText(aN)
		if not aN then
			return nil
		end
		if aN.Name ~= 'GeneratorAdornee' then
			return nil
		end
		local aO = aN:FindFirstChild'RoactTree'
		if not aO then
			return nil
		end
		local aP = aO:FindFirstChild'TeamOreGeneratorApp'
		if not aP then
			return nil
		end
		local aQ = aP:FindFirstChild'GlobalOreGenerator'
		if aQ then
			for aR, aS in pairs(aQ:GetDescendants()) do
				if aS:IsA'TextLabel' then
					local aT = aS.Text
					if aT:find'Tier' or aT:match'^[IVX]+$' or aT == '0' then
						return aS
					end
				end
			end
		end
		local aR = aP:FindFirstChild'TeamGenMain'
		if aR then
			for aS, aT in pairs(aR:GetDescendants()) do
				if aT:IsA'TextLabel' then
					local aU = aT.Text
					if aU:find'Tier' or aU:match'^[IVX]+$' or aU == '0' then
						return aT
					end
				end
			end
		end
		return nil
	end
	local function extractTierLevel(aN)
		if not aN or aN == '' then
			return '0'
		end
		if aN == '0' then
			return '0'
		end
		local aO = aN:match'Tier%s+([IVX]+)'
		if aO then
			return aO
		end
		if aN:match'^[IVX]+$' then
			return aN
		end
		local aP = aN:match'Tier%s+(%d+)'
		if aP then
			local aQ = tonumber(aP)
			if aQ == 0 then
				return '0'
			elseif aQ == 1 then
				return 'I'
			elseif aQ == 2 then
				return 'II'
			elseif aQ == 3 then
				return 'III'
			end
		end
		return '0'
	end
	local function getCountdownText(aN)
		if not aN then
			return nil
		end
		if aN.Name ~= 'GeneratorAdornee' then
			return nil
		end
		local aO = aN:FindFirstChild'RoactTree'
		if not aO then
			return nil
		end
		local aP = aO:FindFirstChild'TeamOreGeneratorApp'
		if not aP then
			return nil
		end
		local aQ = aP:FindFirstChild'GlobalOreGenerator'
		if not aQ then
			return nil
		end
		local aR = aQ:FindFirstChild'Countdown'
		if not aR then
			return nil
		end
		local aS = aR:FindFirstChild'Text'
		if not aS then
			if aR:IsA'TextLabel' then
				return aR
			end
			return nil
		end
		return aS
	end
	local function extractSecondsFromText(aN)
		if not aN or aN == '' then
			return 0
		end
		local aO = aN:match'%[(%d+)%]'
		if aO then
			return tonumber(aO) or 0
		end
		local aP = aN:match'(%d+)'
		if aP then
			return tonumber(aP) or 0
		end
		return 0
	end
	local function getResourceCount(aN, aO)
		local aP = 0
		for aQ, aR in pairs(av:GetTagged'ItemDrop') do
			if aR:FindFirstChild'Handle' then
				local aS = aR.Name:lower()
				if aS:find(aO) then
					local aT = (aR.Handle.Position - aN).Magnitude
					if aT <= 10 then
						local aU = aR:GetAttribute'Amount' or 1
						aP = aP + aU
					end
				end
			end
		end
		return aP
	end
	local function updateCompactUI()
		if not ar.Enabled or au.Value ~= 'Compact' then
			aB.Enabled = false
			return
		end
		aB.Enabled = true
		local aN, aO = math.huge, math.huge
		for aP, aQ in pairs(aw) do
			if aQ and not aQ.isTeamGen and aP and aP.Parent then
				local aR = getCountdownText(aP)
				if aR and aR.Text then
					local aS = extractSecondsFromText(aR.Text)
					if aQ.genType == 'diamond' and aS > 0 and aS < aN then
						aN = aS
					elseif aQ.genType == 'emerald' and aS > 0 and aS < aO then
						aO = aS
					end
				end
			end
		end
		aL[1] = aN ~= math.huge and aN or 0
		aM[1] = aO ~= math.huge and aO or 0
		if aN == math.huge then
			aH.Text = '00'
		else
			aH.Text = string.format('%02d', aN)
			if aN <= 5 then
				aH.TextColor3 = Color3.fromRGB(255, 50, 50)
			elseif aN <= 10 then
				aH.TextColor3 = Color3.fromRGB(255, 165, 0)
			else
				aH.TextColor3 = Color3.fromRGB(85, 200, 255)
			end
		end
		if aO == math.huge then
			aK.Text = '00'
		else
			aK.Text = string.format('%02d', aO)
			if aO <= 5 then
				aK.TextColor3 = Color3.fromRGB(255, 50, 50)
			elseif aO <= 10 then
				aK.TextColor3 = Color3.fromRGB(255, 165, 0)
			else
				aK.TextColor3 = Color3.fromRGB(0, 255, 100)
			end
		end
	end
	local function clearAllESP()
		ax:ClearAllChildren()
		table.clear(aw)
		aB.Enabled = false
	end
	local function createESP(aN, aO, aP, aQ, aR)
		if not isGeneratorEnabled(aO, aR) then
			return
		end
		if aw[aN] then
			return
		end
		if au.Value == 'Compact' then
			aw[aN] = {
				genType = aO,
				position = aQ,
				teamId = aR,
				isTeamGen = aP.isTeamGen
			}
			return
		end
		local aS, aT = (aP.color)
		if aP.isTeamGen and aR and az[aR] then
			aS = az[aR].color
			aT = az[aR].name
		end
		local aU = Instance.new'BillboardGui'
		aU.Parent = ax
		aU.Name = 'generator-esp-' .. aO
		aU.AlwaysOnTop = true
		aU.ClipsDescendants = false
		aU.Adornee = aN
		if aP.isTeamGen then
			aU.Size = UDim2.fromOffset(180, 55)
			aU.StudsOffsetWorldSpace = Vector3.new(0, 5, 0)
		else
			aU.Size = UDim2.fromOffset(80, 30)
			aU.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
		end
		local aV = addBlur(aU)
		aV.Visible = true
		if aP.isTeamGen and aT then
			local aW = Instance.new'Frame'
			aW.Name = 'TeamDot'
			aW.Parent = aU
			aW.Size = UDim2.fromOffset(8, 8)
			aW.Position = UDim2.new(0, 10, 0, 5)
			aW.BackgroundColor3 = aS
			aW.BorderSizePixel = 0
			local aX = Instance.new'UICorner'
			aX.CornerRadius = UDim.new(1, 0)
			aX.Parent = aW
			local aY = Instance.new'TextLabel'
			aY.Name = 'TeamLabel'
			aY.Parent = aU
			aY.BackgroundTransparency = 1
			aY.Size = UDim2.new(1, 0, 0, 18)
			aY.Position = UDim2.new(0, 0, 0, 0)
			aY.Text = aT
			aY.TextColor3 = aS
			aY.TextSize = 13
			aY.Font = Enum.Font.GothamBold
			aY.TextStrokeTransparency = 0.4
			aY.TextStrokeColor3 = Color3.new(0, 0, 0)
			aY.TextXAlignment = Enum.TextXAlignment.Center
		end
		local aW = Instance.new'Frame'
		aW.Size = aP.isTeamGen and UDim2.new(1, 0, 0, 35) or UDim2.fromScale(1, 1)
		aW.Position = aP.isTeamGen and UDim2.new(0, 0, 0, 20) or UDim2.new(0, 0, 0, 0)
		aW.BackgroundColor3 = Color3.new(0, 0, 0)
		aW.BackgroundTransparency = 0.3
		aW.BorderSizePixel = 0
		aW.Parent = aU
		if aP.isTeamGen and aR and az[aR] then
			local aX = Instance.new'Frame'
			aX.Name = 'TeamStripe'
			aX.Parent = aW
			aX.Size = UDim2.new(0, 3, 1, 0)
			aX.Position = UDim2.new(0, 0, 0, 0)
			aX.BackgroundColor3 = aS
			aX.BorderSizePixel = 0
			local aY = Instance.new'UICorner'
			aY.CornerRadius = UDim.new(0, 3)
			aY.Parent = aX
		end
		local aX = Instance.new'UICorner'
		aX.CornerRadius = UDim.new(0, 6)
		aX.Parent = aW
		if aP.isTeamGen then
			local aY = Instance.new'TextLabel'
			aY.Name = 'Tier'
			aY.Size = UDim2.new(0, 25, 1, 0)
			aY.Position = UDim2.new(0, 8, 0, 0)
			aY.BackgroundTransparency = 1
			aY.Text = '0'
			aY.TextColor3 = Color3.fromRGB(255, 255, 100)
			aY.TextSize = 16
			aY.Font = Enum.Font.GothamBold
			aY.TextStrokeTransparency = 0.5
			aY.TextStrokeColor3 = Color3.new(0, 0, 0)
			aY.Parent = aW
			local aZ, a_ = {
				{
					name = 'iron',
					color = Color3.fromRGB(200, 200, 200),
					icon = 'iron',
					xOffset = 35
				},
				{
					name = 'diamond',
					color = Color3.fromRGB(85, 200, 255),
					icon = 'diamond',
					xOffset = 85
				},
				{
					name = 'emerald',
					color = Color3.fromRGB(0, 255, 100),
					icon = 'emerald',
					xOffset = 135
				}
			}, {}
			for a0, a1 in ipairs(aZ) do
				local a2 = getProperIcon(a1.icon)
				if a2 then
					local a3 = Instance.new'ImageLabel'
					a3.Size = UDim2.fromOffset(18, 18)
					a3.Position = UDim2.new(0, a1.xOffset, 0.5, 0)
					a3.AnchorPoint = Vector2.new(0, 0.5)
					a3.BackgroundTransparency = 1
					a3.Image = a2
					a3.Parent = aW
				end
				local a3 = Instance.new'TextLabel'
				a3.Name = a1.name .. '_count'
				a3.Size = UDim2.new(0, 25, 1, 0)
				a3.Position = UDim2.new(0, a1.xOffset + 20, 0, 0)
				a3.BackgroundTransparency = 1
				a3.Text = '0'
				a3.TextColor3 = a1.color
				a3.TextSize = 16
				a3.Font = Enum.Font.GothamBold
				a3.TextStrokeTransparency = 0.5
				a3.TextStrokeColor3 = Color3.new(0, 0, 0)
				a3.TextXAlignment = Enum.TextXAlignment.Left
				a3.Parent = aW
				a_[a1.name] = a3
			end
			aw[aN] = {
				billboard = aU,
				tierLabel = aY,
				ironLabel = a_.iron,
				diamondLabel = a_.diamond,
				emeraldLabel = a_.emerald,
				genType = aO,
				position = aQ,
				teamId = aR,
				isTeamGen = true
			}
		else
			local aY = getProperIcon(aP.icon)
			if aY then
				local aZ = Instance.new'ImageLabel'
				aZ.Size = UDim2.fromOffset(20, 20)
				aZ.Position = UDim2.new(0, 5, 0.5, 0)
				aZ.AnchorPoint = Vector2.new(0, 0.5)
				aZ.BackgroundTransparency = 1
				aZ.Image = aY
				aZ.Parent = aW
			end
			local aZ = Instance.new'TextLabel'
			aZ.Name = 'Timer'
			aZ.Size = UDim2.new(0, 30, 1, 0)
			aZ.Position = UDim2.new(0.5, 0, 0, 0)
			aZ.AnchorPoint = Vector2.new(0.5, 0)
			aZ.BackgroundTransparency = 1
			aZ.Text = '00'
			aZ.TextColor3 = aS
			aZ.TextSize = 18
			aZ.Font = Enum.Font.GothamBold
			aZ.TextStrokeTransparency = 0.5
			aZ.TextStrokeColor3 = Color3.new(0, 0, 0)
			aZ.Parent = aW
			local a_ = Instance.new'TextLabel'
			a_.Name = 'Amount'
			a_.Size = UDim2.new(0, 20, 1, 0)
			a_.Position = UDim2.new(1, - 20, 0, 0)
			a_.BackgroundTransparency = 1
			a_.Text = '0'
			a_.TextColor3 = Color3.fromRGB(255, 255, 255)
			a_.TextSize = 16
			a_.Font = Enum.Font.GothamBold
			a_.TextStrokeTransparency = 0.5
			a_.TextStrokeColor3 = Color3.new(0, 0, 0)
			a_.Parent = aW
			aw[aN] = {
				billboard = aU,
				timerLabel = aZ,
				amountLabel = a_,
				genType = aO,
				position = aQ,
				teamId = aR,
				isTeamGen = false
			}
		end
	end
	local function updateESP(aN)
		local aO = aw[aN]
		if not aO then
			return
		end
		if au.Value == 'Compact' then
			return
		end
		if aO.isTeamGen then
			if aO.tierLabel then
				local aP = getTierText(aN)
				if aP and aP.Text then
					aO.tierLabel.Text = extractTierLevel(aP.Text)
				else
					aO.tierLabel.Text = '0'
				end
			end
			if aO.ironLabel then
				aO.ironLabel.Text = tostring(getResourceCount(aO.position, 'iron'))
			end
			if aO.diamondLabel then
				aO.diamondLabel.Text = tostring(getResourceCount(aO.position, 'diamond'))
			end
			if aO.emeraldLabel then
				aO.emeraldLabel.Text = tostring(getResourceCount(aO.position, 'emerald'))
			end
		else
			local aP = getCountdownText(aN)
			if aP and aP.Text then
				local aQ = extractSecondsFromText(aP.Text)
				if aO.timerLabel then
					aO.timerLabel.Text = string.format('%02d', aQ)
					if aQ <= 5 then
						aO.timerLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
					elseif aQ <= 10 then
						aO.timerLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
					else
						aO.timerLabel.TextColor3 = aA[aO.genType].color
					end
				end
			else
				if aO.timerLabel then
					aO.timerLabel.Text = '00'
					aO.timerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
				end
			end
			if aO.amountLabel then
				aO.amountLabel.Text = tostring(getResourceCount(aO.position, aO.genType))
			end
		end
	end
	local function processGeneratorAdornee(aN)
		if aN.Name ~= 'GeneratorAdornee' then
			return
		end
		local aO, aP = pcall(function()
			return aN:GetAttribute'Id'
		end)
		if not aO then
			return
		end
		if aP == nil then
			return
		end
		if type(aP) ~= 'string' then
			return
		end
		if aP == '' then
			return
		end
		local aQ, aR, aS = aN:GetPivot().Position, getGeneratorType(aP)
		if not aR or not aS then
			return
		end
		local aT = getGeneratorTeamId(aP)
		if isGeneratorEnabled(aR, aT) then
			createESP(aN, aR, aS, aQ, aT)
		end
	end
	local function findAllGenerators()
		for aN, aO in pairs(workspace:GetDescendants()) do
			pcall(processGeneratorAdornee, aO)
		end
	end
	local function refreshESP()
		clearAllESP()
		if ar.Enabled then
			findAllGenerators()
		end
	end
	local aN = 0
	ar = v.Categories.Render:CreateModule{
		Name = 'GeneratorESP',
		Function = function(aO)
			if aO then
				findAllGenerators()
				ar:Clean(workspace.DescendantAdded:Connect(function(aP)
					if not ar.Enabled then
						return
					end
					task.wait(0.2)
					pcall(processGeneratorAdornee, aP)
				end))
				ar:Clean(g.Heartbeat:Connect(function(aP)
					if not ar.Enabled then
						return
					end
					aN = aN + aP
					if aN < 0.2 then
						return
					end
					aN = 0
					for aQ, aR in pairs(aw) do
						if aQ and aQ.Parent then
							updateESP(aQ)
						else
							if aR.billboard then
								aR.billboard:Destroy()
							end
							aw[aQ] = nil
						end
					end
					updateCompactUI()
				end))
				ar:Clean(workspace.DescendantRemoving:Connect(function(aP)
					if not ar.Enabled then
						return
					end
					if aw[aP] then
						if aw[aP].billboard then
							aw[aP].billboard:Destroy()
						end
						aw[aP] = nil
					end
				end))
			else
				clearAllESP()
			end
		end,
		Tooltip = 'ESP for generators showing timer and item counts'
	}
	au = ar:CreateDropdown{
		Name = 'UI Style',
		List = {
			'Original',
			'Compact'
		},
		Default = 'Original',
		Function = function()
			refreshESP()
		end,
		Tooltip = 'Choose between original billboard ESP or compact side UI'
	}
	DiamondToggle = ar:CreateToggle{
		Name = 'Diamond',
		Function = function()
			refreshESP()
		end,
		Default = true
	}
	EmeraldToggle = ar:CreateToggle{
		Name = 'Emerald',
		Function = function()
			refreshESP()
		end,
		Default = true
	}
	TeamGenToggle = ar:CreateToggle{
		Name = 'Team Generators',
		Function = function(aO)
			if ShowOwnTeamGen then
				ShowOwnTeamGen.Object.Visible = aO
			end
			if ShowEnemyTeamGen then
				ShowEnemyTeamGen.Object.Visible = aO
			end
			refreshESP()
		end,
		Default = true
	}
	ShowOwnTeamGen = ar:CreateToggle{
		Name = 'Show Own Team',
		Function = function()
			refreshESP()
		end,
		Default = false,
		Visible = true
	}
	ShowEnemyTeamGen = ar:CreateToggle{
		Name = 'Show Enemy Teams',
		Function = function()
			refreshESP()
		end,
		Default = true,
		Visible = true
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az = (Instance.new'Folder')
	ar.Parent = v.gui
	local aA, aB, aC, aD, aE = 0, 0, false
	_G.gingerLock = _G.gingerLock or false
	local function getPickaxeSlot()
		for aF, aG in L.inventory.hotbar do
			if aG.item and O.ItemMeta[aG.item.itemType] then
				local aH = O.ItemMeta[aG.item.itemType]
				if aH.breakBlock then
					return aF - 1
				end
			end
		end
		return nil
	end
	local function getGumdropSlot()
		for aF, aG in L.inventory.hotbar do
			if aG.item and aG.item.itemType == 'gumdrop_bounce_pad' then
				return aF - 1
			end
		end
		return nil
	end
	local function getPredictedPosition()
		if not (t.Character and t.Character.PrimaryPart) then
			return nil
		end
		local aF = t.Character.PrimaryPart
		local aG = aF.AssemblyLinearVelocity
		local aH = Vector3.new(aG.X, 0, aG.Z)
		local aI = aH.Magnitude
		if aI < 1 then
			return aF.Position
		end
		local aJ = math.clamp(aI / 40, 0.15, 0.35)
		return aF.Position + (aH * aJ)
	end
	local function tryPlaceGumdrop()
		if not ay.Enabled or _G.gingerLock then
			return
		end
		if not (t.Character and t.Character.PrimaryPart) then
			return
		end
		local aF = isFirstPerson()
		if az.Value == 'First Person' and not aF then
			return
		end
		if az.Value == 'Third Person' and aF then
			return
		end
		local aG = t.Character.PrimaryPart.AssemblyLinearVelocity.Y
		if aG >= - 5 then
			return
		end
		local aH = getGumdropSlot()
		if not aH then
			return
		end
		local aI = t.Character.PrimaryPart
		local aJ = getPredictedPosition() or aI.Position
		local aK, aL = (aJ - Vector3.new(0, 3, 0))
		for aM = 1, 16 do
			local aN = aK - Vector3.new(0, 3 * (aM - 1), 0)
			local aO, aP = getPlacedBlock(roundPos(aN))
			if aO then
				aL = aP * 3
				break
			end
		end
		if not aL then
			return
		end
		local aM = aI.Position.Y - aL.Y
		if aM < 9 or aM > 18 then
			return
		end
		local aN = aL + Vector3.new(0, 3, 0)
		if aE and (aE - aN).Magnitude < 1 then
			return
		end
		if getPlacedBlock(aN) then
			return
		end
		_G.gingerLock = true
		if hotbarSwitch(aH) then
			task.wait(0.03)
			local aO = pcall(function()
				O.placeBlock(aN, 'gumdrop_bounce_pad', false)
			end)
			if aO then
				aB = tick()
				aC = true
				aE = aN
				task.wait(0.03)
				local aP = getPickaxeSlot()
				if aP then
					hotbarSwitch(aP)
					task.wait(0.08)
					local aQ = getPlacedBlock(aN)
					if aQ and aQ.Name == 'gumdrop_bounce_pad' then
						task.spawn(O.breakBlock, aQ, false, nil, true)
						aA = tick()
					end
				end
			end
		end
		_G.gingerLock = false
	end
	au = v.Categories.Kits:CreateModule{
		Name = 'AutoGinger',
		Function = function(aF)
			if aF then
				local aG = O.LaunchPadController.attemptLaunch
				O.LaunchPadController.attemptLaunch = function(...)
					local aH, aI, aJ = {
						aG(...)
					}, ...
					if aJ:GetAttribute'PlacedByUserId' == t.UserId and (aJ.Position - B.character.RootPart.Position).Magnitude < 30 then
						if av.Enabled and not isHoldingPickaxe() then
							return unpack(aH)
						end
						local aK = isFirstPerson()
						local aL = not ay.Enabled or (az.Value ~= 'First Person' or aK) and (az.Value ~= 'Third Person' or not aK)
						local aM = ay.Enabled and not isHoldingPickaxe() and aL and not _G.gingerLock
						if aM then
							local aN = getPickaxeSlot()
							if aN then
								_G.gingerLock = true
								task.spawn(function()
									if hotbarSwitch(aN) then
										task.wait(0.03)
										task.spawn(O.breakBlock, aJ, false, nil, true)
										task.spawn(O.breakBlock, aJ, false, nil, true)
										aA = tick()
										aC = false
									end
									_G.gingerLock = false
								end)
							end
						else
							local aN, aO = tick(), true
							if not ay.Enabled and aw.Enabled and not aC then
								if (aN - aA) < ax.Value then
									aO = false
								end
							end
							if aO then
								task.spawn(O.breakBlock, aJ, false, nil, true)
								task.spawn(O.breakBlock, aJ, false, nil, true)
								aA = aN
								aC = false
							end
						end
						local aN = true
						if ay.Enabled then
							local aO = isFirstPerson()
							if az.Value == 'First Person' and not aO then
								aN = false
							elseif az.Value == 'Third Person' and aO then
								aN = false
							end
						end
						if isHoldingPickaxe() then
							local aO, aP = tick(), true
							if not ay.Enabled and aw.Enabled and not aC then
								if (aO - aA) < ax.Value then
									aP = false
								end
							end
							if aP then
								task.spawn(O.breakBlock, aJ, false, nil, true)
								task.spawn(O.breakBlock, aJ, false, nil, true)
								aA = aO
								aC = false
							end
						elseif ay.Enabled and aN and not _G.gingerLock then
							local aO = getPickaxeSlot()
							if aO then
								_G.gingerLock = true
								task.spawn(function()
									if hotbarSwitch(aO) then
										task.wait(0.03)
										task.spawn(O.breakBlock, aJ, false, nil, true)
										task.spawn(O.breakBlock, aJ, false, nil, true)
										aA = tick()
										aC = false
									end
									_G.gingerLock = false
								end)
							end
						end
					end
					return unpack(aH)
				end
				if ay.Enabled then
					if aD then
						aD:Disconnect()
						aD = nil
					end
					aD = g.RenderStepped:Connect(function()
						if not _G.gingerLock and B.isAlive and tick() - aB > 0.15 then
							tryPlaceGumdrop()
						end
					end)
				end
				au:Clean(function()
					O.LaunchPadController.attemptLaunch = aG
					if aD then
						aD:Disconnect()
						aD = nil
					end
				end)
			else
				aA = 0
				aB = 0
				aC = false
				aE = nil
				_G.gingerLock = false
				if aD then
					aD:Disconnect()
					aD = nil
				end
			end
		end,
		Tooltip = 'Advanced gumdrop loop with movement prediction'
	}
	av = au:CreateToggle{
		Name = 'Limit to Pickaxe',
		Default = true,
		Tooltip = 'only breaks gumdrop when holding a pickaxe'
	}
	aw = au:CreateToggle{
		Name = 'Break Delay',
		Default = false,
		Function = function(aF)
			if ax and ax.Object then
				ax.Object.Visible = aF and not ay.Enabled
			end
		end,
		Tooltip = 'Add delay before breaking gumdrops'
	}
	ax = au:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Visible = false,
		Tooltip = 'Delay in seconds before breaking'
	}
	ay = au:CreateToggle{
		Name = 'Auto-Switch',
		Default = false,
		Function = function(aF)
			if az and az.Object then
				az.Object.Visible = aF
			end
			if aw and aw.Object then
				aw.Object.Visible = not aF
			end
			if ax and ax.Object then
				ax.Object.Visible = (not aF) and aw.Enabled
			end
			if av and av.Object then
				av.Object.Visible = not aF
			end
			if aD then
				aD:Disconnect()
				aD = nil
			end
			if aF and au.Enabled then
				aD = g.RenderStepped:Connect(function()
					if not _G.gingerLock and B.isAlive and tick() - aB > 0.15 then
						tryPlaceGumdrop()
					end
				end)
			end
		end,
		Tooltip = 'Auto-switch, break, and place with smart movement prediction'
	}
	az = au:CreateDropdown{
		Name = 'Camera Mode',
		List = {
			'Both',
			'First Person',
			'Third Person'
		},
		Default = 'Both',
		Visible = false,
		Tooltip = 'Which camera mode to work in'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aM, aN, aO, aP, aQ, aR, aS, aT = 10, {}, {}, false, false, (Instance.new'Folder')
	ay.Parent = v.gui
	local aU = Instance.new'Folder'
	aU.Parent = v.gui
	local aV, aW, aX, aY, aZ = {}, {}, 0, {}, 1
	local function sendNotification(a_)
		notif('Bee ESP', string.format('%d bees spawned', a_), 3)
	end
	local function processSpawnQueue()
		if # aY > 0 then
			local a_ = tick()
			if a_ - aX >= aZ then
				sendNotification(# aY)
				aX = a_
				aY = {}
			else
				task.delay(aZ - (a_ - aX), function()
					if # aY > 0 then
						sendNotification(# aY)
						aY = {}
					end
				end)
			end
		end
	end
	local function getBeeIcon()
		return O.getIcon({
			itemType = 'bee'
		}, true)
	end
	local function AddedBee(a_)
		if aV[a_] then
			return
		end
		local a0 = a_.Parent
		if a0 then
			if a0.Name:find'TamedBee' or a0:FindFirstChild'TamedBee' then
				return
			end
			if a0:GetAttribute'IsTamed' or a0:GetAttribute'Tamed' then
				return
			end
			for a1, a2 in pairs(l:GetTags(a0)) do
				if a2:lower():find'tamed' then
					return
				end
			end
		end
		local a1 = Instance.new'BillboardGui'
		a1.Parent = ay
		a1.Name = 'bee'
		a1.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		a1.Size = UDim2.fromOffset(36, 36)
		a1.AlwaysOnTop = true
		a1.ClipsDescendants = false
		a1.Adornee = a_
		local a2 = addBlur(a1)
		a2.Visible = aI.Enabled
		local a3 = Instance.new'ImageLabel'
		a3.Size = UDim2.fromOffset(36, 36)
		a3.Position = UDim2.fromScale(0.5, 0.5)
		a3.AnchorPoint = Vector2.new(0.5, 0.5)
		a3.BackgroundColor3 = Color3.fromHSV(aJ.Hue, aJ.Sat, aJ.Value)
		a3.BackgroundTransparency = 1 - (aI.Enabled and aJ.Opacity or 0)
		a3.BorderSizePixel = 0
		a3.Image = getBeeIcon()
		a3.Parent = a1
		local a4 = Instance.new'UICorner'
		a4.CornerRadius = UDim.new(0, 4)
		a4.Parent = a3
		aV[a_] = a1
		if aH.Enabled then
			table.insert(aY, {
				item = 'bee',
				time = tick()
			})
			processSpawnQueue()
		end
	end
	local function RemovedBee(a_)
		if aV[a_] then
			aV[a_]:Destroy()
			aV[a_] = nil
		end
	end
	local function isMyBeehive(a_)
		if not a_ then
			return false
		end
		local a0 = a_:GetAttribute'PlacedByUserId'
		return a0 and a0 == t.UserId
	end
	local function getBeehiveOwnerName(a_)
		if not a_ then
			return 'Unknown'
		end
		local a0 = a_:GetAttribute'PlacedByUserId'
		if not a0 then
			return 'Unknown'
		end
		local a1 = game.Players:GetPlayerByUserId(a0)
		if a1 then
			return a1.Name
		end
		return 'Player'
	end
	local function AddedBeehive(a_)
		local a0 = isMyBeehive(a_)
		if not a0 and not (aM and aM.Enabled) then
			return
		end
		if aW[a_] then
			return
		end
		local a1 = a_:GetAttribute'Level' or 0
		local a2 = a1 >= ar and a0
		if a2 and a0 then
			au[a_] = true
		end
		local a3 = a0 and nil or getBeehiveOwnerName(a_)
		local a4, a5 = a3 ~= nil, Instance.new'BillboardGui'
		a5.Parent = aU
		a5.Name = 'beehive-esp'
		a5.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
		a5.Size = a2 and UDim2.fromOffset(90, 40) or (a4 and UDim2.fromOffset(120, 40) or UDim2.fromOffset(80, 30))
		a5.AlwaysOnTop = true
		a5.ClipsDescendants = false
		a5.Adornee = a_
		local a6 = addBlur(a5)
		a6.Visible = aN.Enabled
		local a7 = Instance.new'Frame'
		a7.Size = UDim2.fromScale(1, 1)
		a7.BackgroundColor3 = a2 and Color3.fromRGB(255, 50, 50) or Color3.fromHSV(aO.Hue, aO.Sat, aO.Value)
		a7.BackgroundTransparency = 1 - (aN.Enabled and (a2 and 0.5 or aO.Opacity) or 0)
		a7.BorderSizePixel = 0
		a7.Parent = a5
		local a8 = Instance.new'UICorner'
		a8.CornerRadius = UDim.new(0, 6)
		a8.Parent = a7
		if a4 then
			local a9 = Instance.new'TextLabel'
			a9.Name = 'OwnerName'
			a9.Size = UDim2.new(1, 0, 0.4, 0)
			a9.Position = UDim2.new(0, 0, 0, - 20)
			a9.BackgroundTransparency = 1
			a9.Text = a3
			a9.TextColor3 = Color3.fromRGB(255, 255, 255)
			a9.TextSize = 12
			a9.Font = Enum.Font.GothamBold
			a9.TextStrokeTransparency = 0.5
			a9.TextStrokeColor3 = Color3.new(0, 0, 0)
			a9.Parent = a5
		end
		local a9 = Instance.new'TextLabel'
		a9.Size = UDim2.fromOffset(20, 20)
		a9.Position = UDim2.new(0, 5, 0.5, 0)
		a9.AnchorPoint = Vector2.new(0, 0.5)
		a9.BackgroundTransparency = 1
		a9.Text = a0 and '\u{1f3e0}' or '\u{1f3d8}\u{fe0f}'
		a9.TextSize = 16
		a9.Parent = a7
		local ba = Instance.new'ImageLabel'
		ba.Size = UDim2.fromOffset(18, 18)
		ba.Position = UDim2.new(0.5, - 5, 0.5, 0)
		ba.AnchorPoint = Vector2.new(0, 0.5)
		ba.BackgroundTransparency = 1
		ba.Image = getBeeIcon()
		ba.Parent = a7
		local bb = Instance.new'TextLabel'
		bb.Name = 'Level'
		bb.Size = UDim2.new(0, 25, 1, 0)
		bb.Position = UDim2.new(1, - 30, 0, 0)
		bb.BackgroundTransparency = 1
		bb.Text = tostring(a1)
		bb.TextColor3 = a2 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 255, 255)
		bb.TextSize = 16
		bb.Font = Enum.Font.GothamBold
		bb.TextStrokeTransparency = 0.5
		bb.TextStrokeColor3 = Color3.new(0, 0, 0)
		bb.Parent = a7
		if a2 and a0 then
			local bc = Instance.new'TextLabel'
			bc.Name = 'MaxText'
			bc.Size = UDim2.new(1, 0, 0.4, 0)
			bc.Position = UDim2.new(0, 0, 0, a4 and - 40 or - 20)
			bc.BackgroundTransparency = 1
			bc.Text = 'MAX'
			bc.TextColor3 = Color3.fromRGB(255, 50, 50)
			bc.TextSize = 12
			bc.Font = Enum.Font.GothamBold
			bc.TextStrokeTransparency = 0.5
			bc.TextStrokeColor3 = Color3.new(0, 0, 0)
			bc.Parent = a5
		end
		aW[a_] = {
			billboard = a5,
			levelLabel = bb,
			beehive = a_,
			isMaxed = a2,
			isOwn = a0
		}
		local function updateLevel()
			local bc = a_:GetAttribute'Level' or 0
			local bd = bc >= ar and a0
			if bd and a0 then
				au[a_] = true
				if not av[a_] then
					notif('Bee Keeper', 'Beehive is full (MAX)', 3)
					av[a_] = true
				end
				if aW[a_] and aW[a_].billboard then
					local be = aW[a_].billboard:FindFirstChild'MaxText'
					if not be then
						be = Instance.new'TextLabel'
						be.Name = 'MaxText'
						be.Size = UDim2.new(1, 0, 0.4, 0)
						be.Position = UDim2.new(0, 0, 0, a4 and - 40 or - 20)
						be.BackgroundTransparency = 1
						be.Text = 'MAX'
						be.TextColor3 = Color3.fromRGB(255, 50, 50)
						be.TextSize = 12
						be.Font = Enum.Font.GothamBold
						be.TextStrokeTransparency = 0.5
						be.TextStrokeColor3 = Color3.new(0, 0, 0)
						be.Parent = aW[a_].billboard
					end
					local bf = aW[a_].billboard:FindFirstChild'Frame'
					if bf then
						bf.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
						bf.BackgroundTransparency = 1 - (aN.Enabled and 0.5 or 0)
					end
				end
			else
				if a0 then
					au[a_] = nil
					av[a_] = nil
				end
				if aW[a_] and aW[a_].billboard then
					local be = aW[a_].billboard:FindFirstChild'MaxText'
					if be then
						be:Destroy()
					end
					local bf = aW[a_].billboard:FindFirstChild'Frame'
					if bf then
						bf.BackgroundColor3 = Color3.fromHSV(aO.Hue, aO.Sat, aO.Value)
						bf.BackgroundTransparency = 1 - (aN.Enabled and aO.Opacity or 0)
					end
				end
			end
			if aW[a_] and aW[a_].levelLabel then
				aW[a_].levelLabel.Text = tostring(bc)
			end
			if aW[a_] then
				aW[a_].isMaxed = bd
			end
		end
		updateLevel()
		if a0 then
			az:Clean(a_:GetAttributeChangedSignal'Level':Connect(updateLevel))
		else
			az:Clean(a_:GetAttributeChangedSignal'Level':Connect(function()
				local bc = a_:GetAttribute'Level' or 0
				if aW[a_] and aW[a_].levelLabel then
					aW[a_].levelLabel.Text = tostring(bc)
				end
			end))
		end
	end
	local function RemovedBeehive(a_)
		if aW[a_] then
			aW[a_].billboard:Destroy()
			aW[a_] = nil
		end
	end
	local function setupBeesESP()
		for a_, a0 in l:GetTagged'bee' do
			if a0:IsA'Model' and a0.PrimaryPart then
				if not a0.Name:find'TamedBee' and not a0:FindFirstChild'TamedBee' then
					AddedBee(a0.PrimaryPart)
				end
			end
		end
		az:Clean(l:GetInstanceAddedSignal'bee':Connect(function(a_)
			if a_:IsA'Model' and a_.PrimaryPart then
				task.wait(0.1)
				if not a_.Name:find'TamedBee' and not a_:FindFirstChild'TamedBee' then
					AddedBee(a_.PrimaryPart)
				end
			end
		end))
		az:Clean(l:GetInstanceRemovedSignal'bee':Connect(function(a_)
			if a_.PrimaryPart then
				RemovedBee(a_.PrimaryPart)
			end
		end))
	end
	local function setupBeehiveESP()
		for a_, a0 in l:GetTagged'beehive' do
			AddedBeehive(a0)
		end
		az:Clean(l:GetInstanceAddedSignal'beehive':Connect(function(a_)
			task.wait(0.1)
			AddedBeehive(a_)
		end))
		az:Clean(l:GetInstanceRemovedSignal'beehive':Connect(function(a_)
			RemovedBeehive(a_)
		end))
	end
	local function isHoldingBeeNet()
		if not L.hand or not L.hand.tool then
			return false
		end
		return L.hand.tool.Name == 'bee_net' or L.hand.tool.Name == 'bee-net'
	end
	local function startCollection()
		aw = true
		task.spawn(function()
			while aw and az.Enabled and aA.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				if aB.Enabled and not isHoldingBeeNet() then
					task.wait(0.5)
					continue
				end
				local a_, a0, a1 = B.character.RootPart.Position, aE.Value, false
				for a2, a3 in l:GetTagged'bee' do
					if not aw or not az.Enabled or not aA.Enabled then
						break
					end
					if aB.Enabled and not isHoldingBeeNet() then
						break
					end
					if a3:IsA'Model' and a3.PrimaryPart then
						local a4 = a3.PrimaryPart.Position
						local a5 = (a_ - a4).Magnitude
						if a5 <= a0 then
							a1 = true
							if aC.Enabled and aD.Value > 0 then
								task.wait(aD.Value)
							end
							if aB.Enabled and not isHoldingBeeNet() then
								break
							end
							local a6 = a3:GetAttribute'BeeId'
							if a6 then
								O.Client:Get(P.BeePickup):SendToServer{
									beeId = a6
								}
								task.wait(0.1)
							end
						end
					end
				end
				if not a1 then
					task.wait(0.2)
				else
					task.wait(0.1)
				end
			end
			aw = false
		end)
	end
	local function startDeposit()
		ax = true
		task.spawn(function()
			while ax and az.Enabled and aP.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local a_ = L.hand and L.hand.tool
				if not a_ or a_.Name ~= 'bee' then
					task.wait(0.1)
					continue
				end
				local a0, a1, a2, a3 = B.character.RootPart.Position, aS.Value, false, {}
				for a4, a5 in l:GetTagged'beehive' do
					if isMyBeehive(a5) and not au[a5] then
						local a6 = a5.Position
						local a7 = (a0 - a6).Magnitude
						if a7 <= a1 then
							table.insert(a3, {
								beehive = a5,
								distance = a7
							})
						end
					end
				end
				table.sort(a3, function(a4, a5)
					return a4.distance < a5.distance
				end)
				for a4, a5 in ipairs(a3) do
					if not ax or not az.Enabled or not aP.Enabled then
						break
					end
					local a6 = a5.beehive
					if au[a6] then
						continue
					end
					local a7 = a6:FindFirstChildOfClass'ProximityPrompt'
					if a7 and a7.Enabled then
						if aQ.Enabled and aR.Value > 0 then
							local a8 = a7.HoldDuration
							a7.HoldDuration = aR.Value
							if fireproximityprompt then
								fireproximityprompt(a7)
							else
								a7:InputHoldBegin()
								task.wait(aR.Value)
								a7:InputHoldEnd()
							end
							task.wait(aR.Value + 0.1)
							a7.HoldDuration = a8
						else
							if fireproximityprompt then
								fireproximityprompt(a7)
							else
								a7:InputHoldBegin()
								a7:InputHoldEnd()
							end
							task.wait(0.1)
						end
						a2 = true
						break
					end
				end
				if not a2 and # a3 > 0 then
					local a4 = true
					for a5, a6 in ipairs(a3) do
						if not au[a6.beehive] then
							a4 = false
							break
						end
					end
					if a4 then
						notif('Bee Keeper', 'All nearby beehives are full', 3)
					end
				end
				task.wait(a2 and 0.3 or 0.2)
			end
			ax = false
		end)
	end
	az = v.Categories.Kits:CreateModule{
		Name = 'AutoBeekeeper',
		Function = function(a_)
			if a_ then
				if aF.Enabled then
					if aG.Enabled then
						setupBeesESP()
					end
					if aK.Enabled then
						setupBeehiveESP()
					end
				end
				if aA.Enabled then
					startCollection()
				end
				if aP.Enabled then
					startDeposit()
				end
				az:Clean(g.RenderStepped:Connect(function()
					if not aF.Enabled then
						return
					end
					for a0, a1 in pairs(aV) do
						if not a0 or not a0.Parent then
							RemovedBee(a0)
							continue
						end
						local a2 = true
						if aT.Enabled and not isHoldingBeeNet() then
							a2 = false
						end
						a1.Enabled = a2
					end
					for a0, a1 in pairs(aW) do
						if not a0 or not a0.Parent then
							RemovedBeehive(a0)
							continue
						end
						local a2 = true
						if aT.Enabled and not isHoldingBeeNet() then
							a2 = false
						end
						if a1.billboard then
							a1.billboard.Enabled = a2
						end
					end
				end))
			else
				aw = false
				ax = false
				ay:ClearAllChildren()
				aU:ClearAllChildren()
				table.clear(aV)
				table.clear(aW)
				table.clear(aY)
				aX = 0
			end
		end,
		Tooltip = 'Automatically collects bees and manages beehives'
	}
	aA = az:CreateToggle{
		Name = 'Auto Collect',
		Default = true,
		Tooltip = 'Automatically collect bees',
		Function = function(a_)
			if aB and aB.Object then
				aB.Object.Visible = a_
			end
			if aC and aC.Object then
				aC.Object.Visible = a_
			end
			if aD and aD.Object then
				aD.Object.Visible = (a_ and aC.Enabled)
			end
			if aE and aE.Object then
				aE.Object.Visible = a_
			end
			if a_ and az.Enabled then
				startCollection()
			else
				aw = false
			end
		end
	}
	aB = az:CreateToggle{
		Name = 'Limit to Net',
		Default = false,
		Tooltip = 'Only collect bees when holding bee net'
	}
	aC = az:CreateToggle{
		Name = 'Collection Delay',
		Default = false,
		Tooltip = 'Add delay before collecting bees',
		Function = function(a_)
			if aD and aD.Object then
				aD.Object.Visible = a_
			end
		end
	}
	aD = az:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay in seconds before collecting'
	}
	aE = az:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 30,
		Default = 18,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'Control distance you want to collect bees'
	}
	aF = az:CreateToggle{
		Name = 'ESP',
		Default = true,
		Tooltip = 'ESP for bees and beehives',
		Function = function(a_)
			if aG and aG.Object then
				aG.Object.Visible = a_
			end
			if aK and aK.Object then
				aK.Object.Visible = a_
			end
			if aT and aT.Object then
				aT.Object.Visible = a_
			end
			if not a_ then
				if aH and aH.Object then
					aH.Object.Visible = false
				end
				if aI and aI.Object then
					aI.Object.Visible = false
				end
				if aJ and aJ.Object then
					aJ.Object.Visible = false
				end
				if aM and aM.Object then
					aM.Object.Visible = false
				end
				if aN and aN.Object then
					aN.Object.Visible = false
				end
				if aO and aO.Object then
					aO.Object.Visible = false
				end
			else
				if aG and aG.Enabled then
					if aH and aH.Object then
						aH.Object.Visible = true
					end
					if aI and aI.Object then
						aI.Object.Visible = true
					end
					if aJ and aJ.Object then
						aJ.Object.Visible = aI.Enabled
					end
				end
				if aK and aK.Enabled then
					if aM and aM.Object then
						aM.Object.Visible = true
					end
					if aN and aN.Object then
						aN.Object.Visible = true
					end
					if aO and aO.Object then
						aO.Object.Visible = aN.Enabled
					end
				end
			end
			if az.Enabled then
				if a_ then
					if aG.Enabled then
						setupBeesESP()
					end
					if aK.Enabled then
						setupBeehiveESP()
					end
				else
					ay:ClearAllChildren()
					aU:ClearAllChildren()
					table.clear(aV)
					table.clear(aW)
				end
			end
		end
	}
	aT = az:CreateToggle{
		Name = 'Limit to Net',
		Default = false,
		Tooltip = 'Only show ESP when holding bee net'
	}
	aG = az:CreateToggle{
		Name = 'Bees',
		Default = false,
		Tooltip = 'Show bee locations',
		Function = function(a_)
			if aH and aH.Object then
				aH.Object.Visible = a_
			end
			if aI and aI.Object then
				aI.Object.Visible = a_
			end
			if aJ and aJ.Object then
				aJ.Object.Visible = a_
			end
			if az.Enabled and aF.Enabled then
				if a_ then
					setupBeesESP()
				else
					ay:ClearAllChildren()
					table.clear(aV)
				end
			end
		end
	}
	aH = az:CreateToggle{
		Name = 'Notify',
		Default = false,
		Tooltip = 'Get notifications when bees spawn'
	}
	aI = az:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(a_)
			if aJ and aJ.Object then
				aJ.Object.Visible = a_
			end
			for a0, a1 in aV do
				if a1 and a1:FindFirstChild'ImageLabel' then
					a1.ImageLabel.BackgroundTransparency = 1 - (a_ and aJ.Opacity or 0)
					if a1:FindFirstChild'Blur' then
						a1.Blur.Visible = a_
					end
				end
			end
		end
	}
	aJ = az:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(a_, a0, a1, a2)
			for a3, a4 in aV do
				if a4 and a4:FindFirstChild'ImageLabel' then
					a4.ImageLabel.BackgroundColor3 = Color3.fromHSV(a_, a0, a1)
					a4.ImageLabel.BackgroundTransparency = 1 - a2
				end
			end
		end,
		Darker = true
	}
	aK = az:CreateToggle{
		Name = 'Beehives',
		Default = false,
		Tooltip = 'Show your beehive locations with bee count',
		Function = function(a_)
			if aM and aM.Object then
				aM.Object.Visible = a_
			end
			if aN and aN.Object then
				aN.Object.Visible = a_
			end
			if aO and aO.Object then
				aO.Object.Visible = a_
			end
			if az.Enabled and aF.Enabled then
				if a_ then
					setupBeehiveESP()
				else
					aU:ClearAllChildren()
					table.clear(aW)
				end
			end
		end
	}
	aM = az:CreateToggle{
		Name = 'Show Others',
		Default = false,
		Tooltip = "Show other players' beehives with their usernames",
		Function = function(a_)
			if az.Enabled and aF.Enabled and aK.Enabled then
				aU:ClearAllChildren()
				table.clear(aW)
				setupBeehiveESP()
			end
		end
	}
	aN = az:CreateToggle{
		Name = 'Beehive Background',
		Default = true,
		Function = function(a_)
			if aO and aO.Object then
				aO.Object.Visible = a_
			end
			for a0, a1 in aW do
				if a1 and a1.billboard then
					local a2 = a1.billboard:FindFirstChild'Frame'
					if a2 then
						if a1.isMaxed and a1.isOwn then
							a2.BackgroundTransparency = 1 - (a_ and 0.5 or 0)
						else
							a2.BackgroundTransparency = 1 - (a_ and aO.Opacity or 0)
						end
					end
					if a1.billboard:FindFirstChild'Blur' then
						a1.billboard.Blur.Visible = a_
					end
				end
			end
		end
	}
	aO = az:CreateColorSlider{
		Name = 'Beehive Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(a_, a0, a1, a2)
			for a3, a4 in aW do
				if a4 and a4.billboard then
					local a5 = a4.billboard:FindFirstChild'Frame'
					if a5 and not (a4.isMaxed and a4.isOwn) then
						a5.BackgroundColor3 = Color3.fromHSV(a_, a0, a1)
						a5.BackgroundTransparency = 1 - a2
					end
				end
			end
		end,
		Darker = true
	}
	aP = az:CreateToggle{
		Name = 'Auto Deposit',
		Default = false,
		Tooltip = 'Automatically deposit bees into your beehives',
		Function = function(a_)
			if aQ and aQ.Object then
				aQ.Object.Visible = a_
			end
			if aR and aR.Object then
				aR.Object.Visible = (a_ and aQ.Enabled)
			end
			if aS and aS.Object then
				aS.Object.Visible = a_
			end
			if not a_ then
				if aR and aR.Object then
					aR.Object.Visible = false
				end
			end
			if a_ and az.Enabled then
				startDeposit()
			else
				ax = false
			end
		end
	}
	aQ = az:CreateToggle{
		Name = 'Deposit Delay',
		Default = false,
		Tooltip = 'Add delay before depositing bees',
		Function = function(a_)
			if aR and aR.Object then
				aR.Object.Visible = a_
			end
		end
	}
	aR = az:CreateSlider{
		Name = 'Deposit Delay',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay in seconds before depositing'
	}
	aS = az:CreateSlider{
		Name = 'Deposit Range',
		Min = 1,
		Max = 15,
		Default = 10,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'Range to deposit bees into beehives'
	}
	task.defer(function()
		if aD and aD.Object then
			aD.Object.Visible = aC.Enabled
		end
		if not aF.Enabled or not aG.Enabled then
			if aH and aH.Object then
				aH.Object.Visible = false
			end
			if aI and aI.Object then
				aI.Object.Visible = false
			end
			if aJ and aJ.Object then
				aJ.Object.Visible = false
			end
		else
			if aJ and aJ.Object then
				aJ.Object.Visible = aI.Enabled
			end
		end
		if not aF.Enabled or not aK.Enabled then
			if aM and aM.Object then
				aM.Object.Visible = false
			end
			if aN and aN.Object then
				aN.Object.Visible = false
			end
			if aO and aO.Object then
				aO.Object.Visible = false
			end
		else
			if aO and aO.Object then
				aO.Object.Visible = aN.Enabled
			end
		end
		if aP and not aP.Enabled then
			if aQ and aQ.Object then
				aQ.Object.Visible = false
			end
			if aR and aR.Object then
				aR.Object.Visible = false
			end
			if aS and aS.Object then
				aS.Object.Visible = false
			end
		end
		if aR and aR.Object then
			aR.Object.Visible = (aP.Enabled and aQ.Enabled)
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB = (Instance.new'Folder')
	ar.Parent = v.gui
	local aC, aD, aE, aF = {}, 0, {}, 1
	local function kitCollection(aG, aH, aI, aJ)
		repeat
			if B.isAlive then
				local aK, aM = type(aG) == 'table' and aG or collection(aG, au), B.character.RootPart.Position
				for aN, aO in aK do
					if not au.Enabled then
						break
					end
					local aP = not aO:IsA'Model' and aO or aO.PrimaryPart
					if aP and (aP.Position - aM).Magnitude <= aI then
						pcall(aH, aO)
						task.wait(0.05)
					end
				end
			end
			task.wait(0.1)
		until not au.Enabled
	end
	local function sendNotification(aG)
		notif('Crop ESP', string.format('%d crops spawned', aG), 3)
	end
	local function processSpawnQueue()
		if # aE > 0 then
			local aG = tick()
			if aG - aD >= aF then
				sendNotification(# aE)
				aD = aG
				aE = {}
			else
				task.delay(aF - (aG - aD), function()
					if # aE > 0 then
						sendNotification(# aE)
						aE = {}
					end
				end)
			end
		end
	end
	local function getProperImage(aG)
		if aG.Name == 'carrot' then
			return O.getIcon({
				itemType = 'carrot_seeds'
			}, true)
		elseif aG.Name == 'melon' then
			return O.getIcon({
				itemType = 'melon_seeds'
			}, true)
		elseif aG.Name == 'pumpkin' then
			return O.getIcon({
				itemType = 'pumpkin_seeds'
			}, true)
		end
		return O.getIcon({
			itemType = 'carrot_seeds'
		}, true)
	end
	local function Added(aG)
		if aC[aG] then
			return
		end
		local aH = Instance.new'BillboardGui'
		aH.Parent = ar
		aH.Name = 'crop'
		aH.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aH.Size = UDim2.fromOffset(36, 36)
		aH.AlwaysOnTop = true
		aH.ClipsDescendants = false
		aH.Adornee = aG
		local aI = addBlur(aH)
		aI.Visible = aA.Enabled
		local aJ = Instance.new'ImageLabel'
		aJ.Size = UDim2.fromOffset(36, 36)
		aJ.Position = UDim2.fromScale(0.5, 0.5)
		aJ.AnchorPoint = Vector2.new(0.5, 0.5)
		aJ.BackgroundColor3 = Color3.fromHSV(aB.Hue, aB.Sat, aB.Value)
		aJ.BackgroundTransparency = 1 - (aA.Enabled and aB.Opacity or 0)
		aJ.BorderSizePixel = 0
		aJ.Image = getProperImage(aG)
		aJ.Parent = aH
		local aK = Instance.new'UICorner'
		aK.CornerRadius = UDim.new(0, 4)
		aK.Parent = aJ
		aC[aG] = aH
		if az.Enabled then
			table.insert(aE, {
				item = 'crop',
				time = tick()
			})
			processSpawnQueue()
		end
	end
	local function Removed(aG)
		if aC[aG] then
			aC[aG]:Destroy()
			aC[aG] = nil
		end
	end
	local function findExistingCrops()
		for aG, aH in pairs(workspace:GetDescendants()) do
			if aH:IsA'BasePart' and (aH.Name == 'carrot' or aH.Name == 'melon' or aH.Name == 'pumpkin') then
				if aH.Parent == workspace or aH.Parent.Parent == workspace then
					task.wait(0.1)
					Added(aH)
				end
			end
		end
	end
	local function setupESP()
		findExistingCrops()
		au:Clean(workspace.DescendantAdded:Connect(function(aG)
			if aG:IsA'BasePart' and (aG.Name == 'carrot' or aG.Name == 'melon' or aG.Name == 'pumpkin') then
				if aG.Parent == workspace or aG.Parent.Parent == workspace then
					task.wait(0.1)
					Added(aG)
				end
			end
		end))
		au:Clean(workspace.DescendantRemoving:Connect(function(aG)
			if aG:IsA'BasePart' and aC[aG] then
				Removed(aG)
			end
		end))
	end
	au = v.Categories.Kits:CreateModule{
		Name = 'AutoFarmer',
		Function = function(aG)
			if aG then
				if ay.Enabled then
					setupESP()
				end
				if av.Enabled then
					task.spawn(function()
						kitCollection('HarvestableCrop', function(aH)
							O.Client:Get(P.Harvest):CallServer{
								position = O.BlockController:getBlockPosition(aH.Position)
							}
							if aw.Enabled then
								O.GameAnimationUtil:playAnimation(t.Character, O.AnimationType.PUNCH)
								O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
								if t.Character:GetAttribute'CropKitSkin' == O.BedwarsKitSkin.FARMER_CLETUS_VALENTINE then
									O.SoundManager:playSound(O.SoundList.VALETINE_CROP_HARVEST)
								else
									O.SoundManager:playSound(O.SoundList.CROP_HARVEST)
								end
							end
						end, ax.Value, false)
					end)
				end
			else
				ar:ClearAllChildren()
				table.clear(aC)
				table.clear(aE)
				aD = 0
			end
		end,
		Tooltip = 'Automatically collects crops with Farmer Cletus'
	}
	av = au:CreateToggle{
		Name = 'Auto Collect',
		Default = true,
		Tooltip = 'Automatically collect crops',
		Function = function(aG)
			if aw and aw.Object then
				aw.Object.Visible = aG
			end
			if ax and ax.Object then
				ax.Object.Visible = aG
			end
			if aG and au.Enabled then
				task.spawn(function()
					kitCollection('HarvestableCrop', function(aH)
						O.Client:Get(P.Harvest):CallServer{
							position = O.BlockController:getBlockPosition(aH.Position)
						}
						if aw.Enabled then
							O.GameAnimationUtil:playAnimation(t.Character, O.AnimationType.PUNCH)
							O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
							if t.Character:GetAttribute'CropKitSkin' == O.BedwarsKitSkin.FARMER_CLETUS_VALENTINE then
								O.SoundManager:playSound(O.SoundList.VALETINE_CROP_HARVEST)
							else
								O.SoundManager:playSound(O.SoundList.CROP_HARVEST)
							end
						end
					end, ax.Value, false)
				end)
			end
		end
	}
	aw = au:CreateToggle{
		Name = 'Animation',
		Default = true,
		Tooltip = 'Play animation and sound when collecting'
	}
	ax = au:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 10,
		Default = 10,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'Control distance to collect crops'
	}
	ay = au:CreateToggle{
		Name = 'Crop ESP',
		Default = false,
		Tooltip = 'Shows your crop locations',
		Function = function(aG)
			if az and az.Object then
				az.Object.Visible = aG
			end
			if aA and aA.Object then
				aA.Object.Visible = aG
			end
			if aB and aB.Object then
				aB.Object.Visible = aG
			end
			if not aG then
				if aB and aB.Object then
					aB.Object.Visible = false
				end
			else
				if aA and aA.Enabled then
					if aB and aB.Object then
						aB.Object.Visible = true
					end
				end
			end
			if au.Enabled then
				if aG then
					setupESP()
				else
					ar:ClearAllChildren()
					table.clear(aC)
				end
			end
		end
	}
	az = au:CreateToggle{
		Name = 'Notify',
		Default = false,
		Tooltip = 'Get notifications when crops spawn'
	}
	aA = au:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aG)
			if aB and aB.Object then
				aB.Object.Visible = aG
			end
			for aH, aI in aC do
				if aI and aI:FindFirstChild'ImageLabel' then
					aI.ImageLabel.BackgroundTransparency = 1 - (aG and aB.Opacity or 0)
					if aI:FindFirstChild'Blur' then
						aI.Blur.Visible = aG
					end
				end
			end
		end
	}
	aB = au:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(aG, aH, aI, aJ)
			for aK, aM in aC do
				if aM and aM:FindFirstChild'ImageLabel' then
					aM.ImageLabel.BackgroundColor3 = Color3.fromHSV(aG, aH, aI)
					aM.ImageLabel.BackgroundTransparency = 1 - aJ
				end
			end
		end,
		Darker = true
	}
	task.defer(function()
		if aw and aw.Object then
			aw.Object.Visible = true
		end
		if ax and ax.Object then
			ax.Object.Visible = true
		end
		if az and az.Object then
			az.Object.Visible = false
		end
		if aA and aA.Object then
			aA.Object.Visible = false
		end
		if aB and aB.Object then
			aB.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC = 0, 0, 1.5, 3
	ax = v.Categories.Kits:CreateModule{
		Name = 'AutoLian',
		Function = function(aD)
			if aD then
				task.spawn(function()
					repeat
						if B.isAlive then
							local aE, aF, aG = t:GetAttribute'SwordCount' or 0, ay.Value, tick()
							if aF == 'Dragon Sword' then
								if aE >= 1 and aG - ar > av then
									local aH = B.EntityPosition{
										Range = az.Value,
										Part = 'RootPart',
										Players = aC.Players.Enabled,
										NPCs = aC.NPCs.Enabled,
										Wallcheck = aC.Walls.Enabled,
										Sort = aa.Distance
									}
									if aH and aH.RootPart and (aH.RootPart.Position - B.character.RootPart.Position).Magnitude <= az.Value then
										if O.AbilityController:canUseAbility'dragon_sword' then
											O.AbilityController:useAbility'dragon_sword'
											ar = aG
											task.wait(0.5)
										end
									end
								end
							elseif aF == 'DragonSwordUlt' then
								if aE >= 3 and aG - au > aw then
									local aH, aI = 0, B.character.RootPart.Position
									for aJ, aK in B.List do
										if aK.Targetable and (aK.RootPart.Position - aI).Magnitude <= aA.Value then
											local aM = true
											if aK.NPC and not aC.NPCs.Enabled then
												aM = false
											end
											if not aK.NPC and not aC.Players.Enabled then
												aM = false
											end
											if aC.Walls.Enabled and not aK.Targetable then
												aM = false
											end
											if aM then
												aH = aH + 1
											end
										end
									end
									if aH >= aB.Value then
										pcall(function()
											O.Client:Get(P.UseAbility).instance:FireServer'DRAGON_SWORD_ULT'
										end)
										au = aG
										task.wait(2)
									end
								end
							end
						end
						task.wait(0.1)
					until not ax.Enabled
				end)
			end
		end,
		Tooltip = 'Auto use Dragon Sword abilities'
	}
	aC = ax:CreateTargets{
		Players = true,
		NPCs = true,
		Walls = true
	}
	ay = ax:CreateDropdown{
		Name = 'Ability Mode',
		List = {
			'Dragon Sword',
			'DragonSwordUlt'
		},
		Default = 'Dragon Sword',
		Function = function(aD)
			if az and az.Object then
				az.Object.Visible = (aD == 'Dragon Sword')
			end
			if aA and aA.Object then
				aA.Object.Visible = (aD == 'DragonSwordUlt')
			end
			if aB and aB.Object then
				aB.Object.Visible = (aD == 'DragonSwordUlt')
			end
		end
	}
	az = ax:CreateSlider{
		Name = 'Ability Range',
		Min = 10,
		Max = 20,
		Default = 20,
		Suffix = ' studs',
		Tooltip = 'Range to use dragon sword ability',
		Visible = (ay.Value == 'Dragon Sword')
	}
	aA = ax:CreateSlider{
		Name = 'Ult Range',
		Min = 10,
		Max = 20,
		Default = 20,
		Suffix = ' studs',
		Tooltip = 'Range to check for enemies before ulting',
		Visible = (ay.Value == 'DragonSwordUlt')
	}
	aB = ax:CreateSlider{
		Name = 'Enemies Needed',
		Min = 1,
		Max = 4,
		Default = 2,
		Tooltip = 'Number of enemies nearby required to ult',
		Visible = (ay.Value == 'DragonSwordUlt')
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC = false, 0, 0
	local function enableEmpower()
		if not ar and O.AbilityController:canUseAbility'enable_life_force_attack' then
			O.AbilityController:useAbility'enable_life_force_attack'
			ar = true
		end
	end
	local function disableEmpower()
		if ar and O.AbilityController:canUseAbility'disable_life_force_attack' then
			O.AbilityController:useAbility'disable_life_force_attack'
			ar = false
		end
	end
	local function tryConsumeLifeForce()
		if not B.isAlive then
			return
		end
		local aD = workspace:GetServerTimeNow()
		if (aD - av) < aC.Value then
			return
		end
		local aE, aF, aG = t.Character:GetAttribute'Health' or 100, t.Character:GetAttribute'MaxHealth' or 100, t:GetAttribute'LifeForce' or 0
		local aH = aE / aF
		if aH < (aA.Value / 100) and aG >= aB.Value and aE < aF then
			if O.AbilityController:canUseAbility'consume_life_foce' then
				O.AbilityController:useAbility'consume_life_foce'
				av = aD
			end
		end
	end
	aw = v.Categories.Kits:CreateModule{
		Name = 'AutoNazar',
		Function = function(aD)
			if aD then
				aw:Clean(b.EntityDamageEvent.Event:Connect(function(aE)
					if not B.isAlive or not ax.Enabled then
						return
					end
					local aF, aG = e:GetPlayerFromCharacter(aE.fromEntity), e:GetPlayerFromCharacter(aE.entityInstance)
					if aF == t and aG and aG ~= t then
						au = workspace:GetServerTimeNow()
						enableEmpower()
					end
				end))
				aw:Clean(b.EntityDeathEvent.Event:Connect(function(aE)
					if not B.isAlive or not ax.Enabled then
						return
					end
					local aF, aG = e:GetPlayerFromCharacter(aE.fromEntity), e:GetPlayerFromCharacter(aE.entityInstance)
					if aF == t and aG and aG ~= t then
						disableEmpower()
					end
				end))
				task.spawn(function()
					repeat
						if B.isAlive then
							local aE = workspace:GetServerTimeNow()
							if ax.Enabled and ar and (aE - au) >= ay.Value then
								disableEmpower()
							end
							if az.Enabled then
								tryConsumeLifeForce()
							end
						else
							if ar then
								disableEmpower()
							end
						end
						task.wait(0.1)
					until not aw.Enabled
				end)
			else
				if ar then
					disableEmpower()
				end
				ar = false
				au = 0
				av = 0
			end
		end,
		Tooltip = 'Automatically manages Nazar abilities'
	}
	ax = aw:CreateToggle{
		Name = 'Auto Empower',
		Default = true,
		Tooltip = 'Auto enable/disable empowered attacks on hit/kill',
		Function = function(aD)
			if ay and ay.Object then
				ay.Object.Visible = aD
			end
		end
	}
	ay = aw:CreateSlider{
		Name = 'Empower Timeout',
		Min = 1,
		Max = 10,
		Default = 3,
		Suffix = 's',
		Tooltip = 'Disable empower after this many seconds without hitting',
		Visible = false
	}
	az = aw:CreateToggle{
		Name = 'Auto Consume',
		Default = true,
		Tooltip = 'Auto consume life force to heal when low HP',
		Function = function(aD)
			if aA and aA.Object then
				aA.Object.Visible = aD
			end
			if aB and aB.Object then
				aB.Object.Visible = aD
			end
			if aC and aC.Object then
				aC.Object.Visible = aD
			end
		end
	}
	aA = aw:CreateSlider{
		Name = 'Heal Threshold',
		Min = 10,
		Max = 100,
		Default = 55,
		Suffix = '%',
		Tooltip = 'Consume life force when HP is below this %',
		Visible = false
	}
	aB = aw:CreateSlider{
		Name = 'Min Life Force',
		Min = 1,
		Max = 100,
		Default = 25,
		Tooltip = 'Minimum life force required to heal',
		Visible = false
	}
	aC = aw:CreateSlider{
		Name = 'Consume Cooldown',
		Min = 0,
		Max = 10,
		Default = 3,
		Suffix = 's',
		Tooltip = 'Cooldown between consuming life force',
		Visible = false
	}
end)
a(function()
	local ar, au, av, aw = {
		Enabled = false
	}, 16, 0.2, 0.05
	ar = v.Categories.Blatant:CreateModule{
		Name = 'GodMode',
		Function = function(ax)
			if ax then
				task.spawn(function()
					while ar.Enabled do
						local ay = t.Character and t.Character:FindFirstChild'HumanoidRootPart'
						if ay then
							local az, aA = ay.Position, false
							for aB, aC in next, e:GetPlayers() do
								if aC ~= t and aC.Team ~= t.Team then
									local aD = aC.Character
									local aE, aF = aD and aD:FindFirstChild'HumanoidRootPart', aD and aD:FindFirstChild'Humanoid'
									if aE and aF and aF.Health > 0 then
										local aG = (ay.Position - aE.Position).Magnitude
										if aG <= au.Value then
											aA = true
											break
										end
									end
								end
							end
							if aA then
								ay.CFrame = CFrame.new(az + Vector3.new(0, - 230, 0))
								task.wait(av.Value)
								if ar.Enabled and t.Character and t.Character:FindFirstChild'HumanoidRootPart' then
									t.Character.HumanoidRootPart.CFrame = CFrame.new(az)
								end
							end
						end
						task.wait(aw.Value)
					end
				end)
			end
		end,
		Tooltip = 'Prevents you from dying'
	}
	au = ar:CreateSlider{
		Name = 'Range',
		Min = 0,
		Max = 50,
		Default = 15,
		Visible = true,
		Function = function(ax)
			au.Value = ax
		end
	}
	av = ar:CreateSlider{
		Name = 'Time Up',
		Min = 0,
		Max = 1,
		Default = 0.2,
		Visible = true,
		Function = function(ax)
			av.Value = ax
		end
	}
	aw = ar:CreateSlider{
		Name = 'Time Down',
		Min = 0,
		Max = 1,
		Default = 0.05,
		Visible = true,
		Function = function(ax)
			aw.Value = ax
		end
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az = {}, {}, (Instance.new'Folder')
	av.Parent = v.gui
	local aA, aB, aC, aD, aE, aF = false, 0, {}, e
	local aG, aH, aI = aD.LocalPlayer, g, game:GetService'Workspace'
	local function isMyDrill(aJ)
		if not aJ then
			return false
		end
		local aK = aJ:GetAttribute'PlacedByUserId'
		return aK and aK == aG.UserId
	end
	local function isTeammate(aJ)
		if not ay.Enabled then
			return false
		end
		local aK = aJ:GetAttribute'PlacedByUserId'
		if aK then
			local aM = aD:GetPlayerByUserId(aK)
			if aM and aM.Team == aG.Team then
				return true
			end
		end
		return false
	end
	local function getDrillInfo(aJ)
		local aK, aM, aN, aO = aJ:GetAttribute'ItemType', aJ:GetAttribute'Health' or 0, aJ:GetAttribute'MaxHealth' or 750, 0
		if aK then
			aO = aJ:GetAttribute(aK) or 0
		end
		return aK, aO, aM, aN
	end
	local function getProperIcon(aJ)
		if not aJ then
			return nil
		end
		if not O or not O.getIcon then
			return 'rbxasset://textures/ui/GuiImagePlaceholder.png'
		end
		local aK, aM = pcall(function()
			return O.getIcon({
				itemType = aJ
			}, true)
		end)
		if not aK or not aM or aM == '' then
			return 'rbxasset://textures/ui/GuiImagePlaceholder.png'
		end
		return aM
	end
	local function createESP(aJ)
		if isTeammate(aJ) then
			return
		end
		if au[aJ] then
			return
		end
		local aK = aJ:FindFirstChild'Head'
		if not aK then
			return
		end
		local aM = Instance.new'BillboardGui'
		aM.Parent = av
		aM.Name = 'drill-esp'
		aM.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aM.Size = UDim2.fromOffset(110, 26)
		aM.AlwaysOnTop = true
		aM.ClipsDescendants = false
		aM.Adornee = aK
		local aN = addBlur(aM)
		aN.Visible = az.Enabled
		local aO = Instance.new'Frame'
		aO.Size = UDim2.fromScale(1, 1)
		aO.BackgroundColor3 = Color3.fromHSV(ar.Hue, ar.Sat, ar.Value)
		aO.BackgroundTransparency = 1 - (az.Enabled and ar.Opacity or 0.3)
		aO.BorderSizePixel = 0
		aO.Parent = aM
		local aP = Instance.new'UICorner'
		aP.CornerRadius = UDim.new(0, 6)
		aP.Parent = aO
		local aQ = getProperIcon'drill'
		if aQ then
			local aR = Instance.new'ImageLabel'
			aR.Name = 'DrillIcon'
			aR.Size = UDim2.fromOffset(18, 18)
			aR.Position = UDim2.new(0, 4, 0.5, 0)
			aR.AnchorPoint = Vector2.new(0, 0.5)
			aR.BackgroundTransparency = 1
			aR.Image = aQ
			aR.Parent = aO
		end
		local aR = Instance.new'TextLabel'
		aR.Name = 'Health'
		aR.Size = UDim2.new(0, 32, 1, 0)
		aR.Position = UDim2.new(0, 25, 0, 0)
		aR.BackgroundTransparency = 1
		aR.Text = '750'
		aR.TextColor3 = Color3.fromRGB(255, 255, 255)
		aR.TextSize = 12
		aR.Font = Enum.Font.GothamBold
		aR.TextStrokeTransparency = 0.5
		aR.TextStrokeColor3 = Color3.new(0, 0, 0)
		aR.TextXAlignment = Enum.TextXAlignment.Left
		aR.Parent = aO
		local aS = Instance.new'ImageLabel'
		aS.Name = 'ResourceIcon'
		aS.Size = UDim2.fromOffset(16, 16)
		aS.Position = UDim2.new(0, 62, 0.5, 0)
		aS.AnchorPoint = Vector2.new(0, 0.5)
		aS.BackgroundTransparency = 1
		aS.Image = ''
		aS.Parent = aO
		local aT = Instance.new'TextLabel'
		aT.Name = 'Amount'
		aT.Size = UDim2.new(0, 28, 1, 0)
		aT.Position = UDim2.new(1, - 30, 0, 0)
		aT.BackgroundTransparency = 1
		aT.Text = '0'
		aT.TextColor3 = Color3.fromRGB(255, 255, 255)
		aT.TextSize = 12
		aT.Font = Enum.Font.GothamBold
		aT.TextStrokeTransparency = 0.5
		aT.TextStrokeColor3 = Color3.new(0, 0, 0)
		aT.TextXAlignment = Enum.TextXAlignment.Left
		aT.Parent = aO
		au[aJ] = {
			billboard = aM,
			frame = aO,
			healthLabel = aR,
			resourceImage = aS,
			amountLabel = aT
		}
	end
	local function updateESP(aJ)
		local aK = au[aJ]
		if not aK then
			return
		end
		local aM, aN, aO, aP = getDrillInfo(aJ)
		if aK.healthLabel then
			aK.healthLabel.Text = tostring(math.floor(aO))
			local aQ = aO / aP
			if aQ > 0.6 then
				aK.healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			elseif aQ > 0.3 then
				aK.healthLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
			else
				aK.healthLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
			end
		end
		if aM then
			if aK.resourceImage then
				local aQ = getProperIcon(aM)
				if aQ then
					aK.resourceImage.Image = aQ
				end
			end
			if aK.amountLabel then
				aK.amountLabel.Text = tostring(math.floor(aN))
			end
		else
			if aK.resourceImage then
				aK.resourceImage.Image = ''
			end
			if aK.amountLabel then
				aK.amountLabel.Text = '0'
			end
		end
	end
	local function findAllDrills()
		local aJ = aI:FindFirstChild'Drill'
		if aJ and aJ:IsA'Model' then
			if not isTeammate(aJ) then
				createESP(aJ)
			end
		end
		for aK, aM in pairs(aI:GetDescendants()) do
			if aM:IsA'Model' and aM.Name == 'Drill' and aM ~= aJ then
				if not isTeammate(aM) then
					createESP(aM)
				end
			end
		end
	end
	local function refreshESP()
		av:ClearAllChildren()
		table.clear(au)
		if ax.Enabled then
			findAllDrills()
		end
	end
	local function setupESPConnections()
		for aJ, aK in pairs(aC) do
			if aK and aK.Disconnect then
				aK:Disconnect()
			end
		end
		table.clear(aC)
		table.insert(aC, aI.DescendantAdded:Connect(function(aJ)
			if not ax.Enabled then
				return
			end
			if aJ:IsA'Model' and aJ.Name == 'Drill' then
				task.wait(0.1)
				if not isTeammate(aJ) then
					createESP(aJ)
				end
			end
		end))
		table.insert(aC, aI.DescendantRemoving:Connect(function(aJ)
			if aJ:IsA'Model' and aJ.Name == 'Drill' and au[aJ] then
				if au[aJ].billboard then
					au[aJ].billboard:Destroy()
				end
				au[aJ] = nil
			end
		end))
		local aJ = 0
		table.insert(aC, aH.Heartbeat:Connect(function()
			if not ax.Enabled then
				return
			end
			local aK = tick()
			if aK - aJ < 0.1 then
				return
			end
			aJ = aK
			for aM, aN in pairs(au) do
				if aM and aM.Parent then
					updateESP(aM)
				else
					if aN.billboard then
						aN.billboard:Destroy()
					end
					au[aM] = nil
				end
			end
		end))
	end
	local function disconnectESP()
		for aJ, aK in pairs(aC) do
			if aK and aK.Disconnect then
				aK:Disconnect()
			end
		end
		table.clear(aC)
	end
	local function getAttackData()
		if not B.isAlive then
			return false
		end
		local aJ = L.hand
		if not aJ or not aJ.tool then
			return false
		end
		if aJ.tool.Name ~= 'drill_controller' and aJ.itemType ~= 'drill_controller' then
			return false
		end
		return true
	end
	local function getEnemiesNearDrill(aJ)
		local aK, aM = {}, aJ:FindFirstChild'Head'
		if not aM then
			return aK
		end
		for aN, aO in aD:GetPlayers() do
			if aO ~= aG and aO.Team ~= aG.Team then
				local aP = aO.Character
				if aP then
					local aQ, aR = aP:FindFirstChild'Humanoid', aP:FindFirstChild'HumanoidRootPart' or aP:FindFirstChild'RootPart'
					if aQ and aQ.Health > 0 and aR then
						local aS = (aM.Position - aR.Position).Magnitude
						if aS <= aF.Value then
							table.insert(aK, {
								player = aO,
								character = aP,
								position = aR.Position,
								distance = aS
							})
						end
					end
				end
			end
		end
		return aK
	end
	local function startAutoAttack()
		aA = true
		task.spawn(function()
			while aA and aw.Enabled and aE.Enabled do
				if not B.isAlive then
					task.wait(0.1)
					continue
				end
				local aJ = getAttackData()
				if not aJ then
					task.wait(0.1)
					continue
				end
				if (tick() - aB) < 0.3 then
					task.wait(0.05)
					continue
				end
				local aK, aM = false, aI:FindFirstChild'Drill'
				if aM and aM:IsA'Model' and isMyDrill(aM) then
					local aN = getEnemiesNearDrill(aM)
					if # aN > 0 then
						table.sort(aN, function(aO, aP)
							return aO.distance < aP.distance
						end)
						local aO = aN[1]
						pcall(function()
							O.Client:Get(P.DrillAttack):FireServer{
								targetPosition = aO.position
							}
						end)
						aB = tick()
						aK = true
					end
				end
				for aN, aO in pairs(aI:GetDescendants()) do
					if aK then
						break
					end
					if aO:IsA'Model' and aO.Name == 'Drill' and isMyDrill(aO) then
						local aP = getEnemiesNearDrill(aO)
						if # aP > 0 then
							table.sort(aP, function(aQ, aR)
								return aQ.distance < aR.distance
							end)
							local aQ = aP[1]
							pcall(function()
								O.Client:Get(P.DrillAttack).instance:FireServer{
									targetPosition = aQ.position
								}
							end)
							aB = tick()
							aK = true
							break
						end
					end
				end
				if not aK then
					task.wait(0.1)
				else
					task.wait(0.3)
				end
			end
			aA = false
		end)
	end
	aw = v.Categories.Kits:CreateModule{
		Name = 'AutoDrill',
		Function = function(aJ)
			if aJ then
				if aE.Enabled then
					startAutoAttack()
				end
			else
				aA = false
				disconnectESP()
				av:ClearAllChildren()
				table.clear(au)
			end
		end,
		Tooltip = 'Drill utilities: ESP and auto attack'
	}
	ax = aw:CreateToggle{
		Name = 'Drill ESP',
		Default = false,
		Tooltip = 'ESP for drills showing health and resources',
		Function = function(aJ)
			if ay.Object then
				ay.Object.Visible = aJ
			end
			if az.Object then
				az.Object.Visible = aJ
			end
			if ar.Object then
				ar.Object.Visible = aJ
			end
			if aJ then
				setupESPConnections()
				findAllDrills()
			else
				disconnectESP()
				av:ClearAllChildren()
				table.clear(au)
			end
		end
	}
	ay = aw:CreateToggle{
		Name = 'Team Check',
		Default = true,
		Tooltip = 'Hide teammate drills',
		Function = function(aJ)
			if ax.Enabled then
				refreshESP()
			end
		end
	}
	ay.Object.Visible = false
	az = aw:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aJ)
			if ar.Object then
				ar.Object.Visible = aJ
			end
			for aK, aM in pairs(au) do
				if aM.frame then
					aM.frame.BackgroundTransparency = 1 - (aJ and ar.Opacity or 0.3)
					if aM.billboard and aM.billboard.Blur then
						aM.billboard.Blur.Visible = aJ
					end
				end
			end
		end
	}
	az.Object.Visible = false
	ar = aw:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.3,
		Function = function(aJ, aK, aM, aN)
			ar.Hue = aJ
			ar.Sat = aK
			ar.Value = aM
			ar.Opacity = aN
			for aO, aP in pairs(au) do
				if aP.frame then
					aP.frame.BackgroundColor3 = Color3.fromHSV(aJ, aK, aM)
					aP.frame.BackgroundTransparency = 1 - aN
				end
			end
		end,
		Darker = true
	}
	ar.Object.Visible = false
	aE = aw:CreateToggle{
		Name = 'Auto Attack',
		Default = false,
		Tooltip = 'Auto attack enemies near drills',
		Function = function(aJ)
			if aF.Object then
				aF.Object.Visible = aJ
			end
			if aJ and aw.Enabled then
				startAutoAttack()
			else
				aA = false
			end
		end
	}
	aF = aw:CreateSlider{
		Name = 'Attack Range',
		Min = 10,
		Max = 20,
		Default = 20,
		Suffix = ' studs',
		Tooltip = 'Range to attack from drill'
	}
	aF.Object.Visible = false
end)
a(function()
	local ar, au = {}
	au = v.Categories.Legit:CreateModule{
		Name = 'DisableStreamer',
		Function = function(av)
			if av then
				for aw, ax in e:GetPlayers() do
					if ax == t then
						continue
					end
					ar[ax] = ax:GetAttribute'Disguised' or true
					ax:SetAttribute('Disguised', false)
				end
			else
				for aw, ax in e:GetPlayers() do
					if ax == t then
						continue
					end
					if ar[ax] then
						local ay = ar[ax] or true
						ax:SetAttribute('Disguised', ay)
						ar[ax] = nil
					end
				end
			end
		end,
		Tooltip = 'Disable people streamer mode'
	}
end)
a(function()
	y = v.Categories.Utility:CreateModule{
		Name = 'TrapDisabler',
		Tooltip = 'Disables Snap Traps'
	}
end)
a(function()
	local ar
	ar = v.Categories.Utility:CreateModule{
		Name = 'RavenTP',
		Function = function(au)
			if au then
				ar:Toggle()
				local av = B.EntityMouse{
					Range = 1000,
					Players = true,
					Part = 'RootPart'
				}
				if getItem'raven' and av then
					O.Client:Get(P.SpawnRaven):CallServerAsync():andThen(function(aw)
						if aw then
							local ax = aw:FindFirstChild'Root' or aw:FindFirstChildWhichIsA'BasePart'
							if ax then
								local ay = Instance.new'BodyForce'
								ay.Force = Vector3.new(0, ax.AssemblyMass * workspace.Gravity, 0)
								ay.Parent = ax
								if av then
									task.spawn(function()
										for az = 1, 20 do
											if av.RootPart and ax then
												ax.CFrame = CFrame.lookAlong(av.RootPart.Position, s.CFrame.LookVector)
											end
											task.wait(0.05)
										end
									end)
									task.wait(0.3)
									O.RavenController:detonateRaven()
								end
							end
						end
					end)
				end
			end
		end,
		Tooltip = 'Spawns and teleports a raven to a player\nnear your mouse.'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI = false, {
		HEALING = 0,
		VOID = 1,
		STICKY = 2,
		FROSTY = 3
	}
	local aJ = {
		[au.HEALING] = 'Blessed Slime',
		[au.VOID] = 'Void Slime',
		[au.STICKY] = 'Sticky Slime',
		[au.FROSTY] = 'Frosty Slime'
	}
	local function getMySlimes()
		local aK = {}
		for aM, aN in l:GetTagged'SlimeData' do
			if aN:WaitForChild('Tamer', 0.1) and aN.Tamer.Value == t.UserId then
				local aO, aP = aN:GetAttribute'SlimeType', aN:GetAttribute'Id'
				if aO ~= nil and aP ~= nil then
					if not aK[aO] then
						aK[aO] = {}
					end
					table.insert(aK[aO], {
						data = aN,
						id = aP,
						type = aO
					})
				end
			end
		end
		return aK
	end
	local function getSlimeCurrentTarget(aK)
		if not aK or not aK:FindFirstChild'Following' then
			return nil
		end
		local aM = aK.Following.Value
		if aM == 0 or aM ~= aM or not aM then
			return nil
		end
		return e:GetPlayerByUserId(aM)
	end
	local function moveSlimeToPlayer(aK, aM)
		if not aM then
			return false
		end
		pcall(function()
			O.Client:Get(P.UseAbility).instance:FireServer'SLIME_DIRECT'
			task.wait(0.05)
			O.Client:Get(P.RequestMoveSlime).instance:InvokeServer{
				slimeId = aK,
				targetPlayerUserId = aM.UserId
			}
		end)
		return true
	end
	local function retractSlimeToSelf(aK)
		pcall(function()
			O.Client:Get(P.UseAbility).instance:FireServer'SLIME_DIRECT'
			task.wait(0.05)
			O.Client:Get(P.RequestMoveSlime).instance:InvokeServer{
				slimeId = aK,
				targetPlayerUserId = t.UserId
			}
		end)
	end
	local function manageSlimeType(aK, aM)
		local aN, aO = aM.Value, getMySlimes()
		local aP = aO[aK]
		if not aP or # aP == 0 then
			return
		end
		if aN == 'None' or aN == '' then
			for aQ, aR in ipairs(aP) do
				local aS = getSlimeCurrentTarget(aR.data)
				if aS and aS ~= t then
					retractSlimeToSelf(aR.id)
					task.wait(0.15)
				end
			end
			return
		end
		local aQ = e:FindFirstChild(aN)
		if not aQ then
			return
		end
		if not aQ.Character or not aQ.Character:FindFirstChild'HumanoidRootPart' then
			return
		end
		for aR, aS in ipairs(aP) do
			local aT = getSlimeCurrentTarget(aS.data)
			if aT ~= aQ then
				moveSlimeToPlayer(aS.id, aQ)
				task.wait(0.15)
			end
		end
	end
	local function startSlimeManagement()
		if aI then
			task.cancel(aI)
			aI = nil
		end
		ar = true
		aI = task.spawn(function()
			while ar and av.Enabled do
				if aw.Enabled then
					manageSlimeType(au.HEALING, ax)
				end
				if az.Enabled then
					manageSlimeType(au.VOID, aA)
				end
				if aC.Enabled then
					manageSlimeType(au.STICKY, aD)
				end
				if aF.Enabled then
					manageSlimeType(au.FROSTY, aG)
				end
				task.wait(1.5)
			end
			aI = nil
		end)
	end
	local function stopSlimeManagement()
		ar = false
		if aI then
			task.cancel(aI)
			aI = nil
		end
	end
	av = v.Categories.Kits:CreateModule{
		Name = 'AutoNoelle',
		Function = function(aK)
			ar = aK
			if aK then
				startSlimeManagement()
				av:Clean(e.PlayerAdded:Connect(function()
					task.wait(0.5)
					local aM = getTeammateNames()
					if ax then
						ax:Change(aM)
					end
					if aA then
						aA:Change(aM)
					end
					if aD then
						aD:Change(aM)
					end
					if aG then
						aG:Change(aM)
					end
				end))
				av:Clean(e.PlayerRemoving:Connect(function()
					task.wait(0.5)
					local aM = getTeammateNames()
					if ax then
						ax:Change(aM)
					end
					if aA then
						aA:Change(aM)
					end
					if aD then
						aD:Change(aM)
					end
					if aG then
						aG:Change(aM)
					end
				end))
				av:Clean(t:GetAttributeChangedSignal'Team':Connect(function()
					task.wait(1)
					local aM = getTeammateNames()
					if ax then
						ax:Change(aM)
					end
					if aA then
						aA:Change(aM)
					end
					if aD then
						aD:Change(aM)
					end
					if aG then
						aG:Change(aM)
					end
				end))
			else
				stopSlimeManagement()
			end
		end,
		Tooltip = 'Automatically manages slimes to follow specific teammates'
	}
	aw = av:CreateToggle{
		Name = 'Heal Slime',
		Default = false,
		Tooltip = 'Assign heal slime to teammate',
		Function = function(aK)
			if ax and ax.Object then
				ax.Object.Visible = aK
			end
			if ay and ay.Object then
				ay.Object.Visible = aK
			end
			if aK and av.Enabled then
				startSlimeManagement()
			end
		end
	}
	local function teammateListWithNone()
		local aK = {
			'None'
		}
		for aM, aN in ipairs(getTeammateNames()) do
			table.insert(aK, aN)
		end
		return aK
	end
	ax = av:CreateDropdown{
		Name = 'Heal Target',
		List = teammateListWithNone(),
		Function = function(aK)
		end,
		Tooltip = 'Select teammate for heal slime'
	}
	ay = av:CreateButton{
		Name = 'Refresh Heal List',
		Function = function()
			task.spawn(function()
				local aK = getTeammateNames()
				if ax then
					pcall(function()
						ax:Change(aK)
						if # aK > 0 then
							if not ax.Value or ax.Value == '' or not table.find(aK, ax.Value) then
								ax:SetValue(aK[1])
							else
								ax:SetValue(ax.Value)
							end
						end
					end)
				end
				notif('Auto Noelle', string.format('Refreshed heal list (%d teammates)', # aK - 1), 2)
			end)
		end,
		Tooltip = 'Manually refresh heal teammate list'
	}
	az = av:CreateToggle{
		Name = 'Damage Slime',
		Default = false,
		Tooltip = 'Assign Damage slime to teammate',
		Function = function(aK)
			if aA and aA.Object then
				aA.Object.Visible = aK
			end
			if aB and aB.Object then
				aB.Object.Visible = aK
			end
			if aK and av.Enabled then
				startSlimeManagement()
			end
		end
	}
	aA = av:CreateDropdown{
		Name = 'Damage Target',
		List = getTeammateNames(),
		Function = function(aK)
		end,
		Tooltip = 'Select teammate for Damage slime'
	}
	aB = av:CreateButton{
		Name = 'Refresh Damage List',
		Function = function()
			task.spawn(function()
				local aK = getTeammateNames()
				if aA then
					pcall(function()
						aA:Change(aK)
						if # aK > 0 then
							if not aA.Value or aA.Value == '' or not table.find(aK, aA.Value) then
								aA:SetValue(aK[1])
							else
								aA:SetValue(aA.Value)
							end
						end
					end)
				end
				notif('Auto Noelle', string.format('Refreshed Damage list (%d teammates)', # aK - 1), 2)
			end)
		end,
		Tooltip = 'Manually refresh Damage teammate list'
	}
	aC = av:CreateToggle{
		Name = 'Cycle Slime',
		Default = false,
		Tooltip = 'Assign cycle slime to teammate',
		Function = function(aK)
			if aD and aD.Object then
				aD.Object.Visible = aK
			end
			if aE and aE.Object then
				aE.Object.Visible = aK
			end
			if aK and av.Enabled then
				startSlimeManagement()
			end
		end
	}
	aD = av:CreateDropdown{
		Name = 'Cycle Target',
		List = getTeammateNames(),
		Function = function(aK)
		end,
		Tooltip = 'Select teammate for cycle slime'
	}
	aE = av:CreateButton{
		Name = 'Refresh Cycle List',
		Function = function()
			task.spawn(function()
				local aK = getTeammateNames()
				if aD then
					pcall(function()
						aD:Change(aK)
						if # aK > 0 then
							if not aD.Value or aD.Value == '' or not table.find(aK, aD.Value) then
								aD:SetValue(aK[1])
							else
								aD:SetValue(aD.Value)
							end
						end
					end)
				end
				notif('Auto Noelle', string.format('Refreshed Cycle list (%d teammates)', # aK - 1), 2)
			end)
		end,
		Tooltip = 'Manually refresh Cycle teammate list'
	}
	aF = av:CreateToggle{
		Name = 'Slow Slime',
		Default = false,
		Tooltip = 'Assign Slow slime to teammate',
		Function = function(aK)
			if aG and aG.Object then
				aG.Object.Visible = aK
			end
			if aH and aH.Object then
				aH.Object.Visible = aK
			end
			if aK and av.Enabled then
				startSlimeManagement()
			end
		end
	}
	aG = av:CreateDropdown{
		Name = 'Slow Target',
		List = getTeammateNames(),
		Function = function(aK)
		end,
		Tooltip = 'Select teammate for slow slime'
	}
	aH = av:CreateButton{
		Name = 'Refresh Slow List',
		Function = function()
			task.spawn(function()
				local aK = getTeammateNames()
				if aG then
					pcall(function()
						aG:Change(aK)
						if # aK > 0 then
							if not aG.Value or aG.Value == '' or not table.find(aK, aG.Value) then
								aG:SetValue(aK[1])
							else
								aG:SetValue(aG.Value)
							end
						end
					end)
				end
				notif('Auto Noelle', string.format('Refreshed slow list (%d teammates)', # aK - 1), 2)
			end)
		end,
		Tooltip = 'Manually refresh slow teammate list'
	}
	task.defer(function()
		if ax and ax.Object then
			ax.Object.Visible = false
		end
		if ay and ay.Object then
			ay.Object.Visible = false
		end
		if aA and aA.Object then
			aA.Object.Visible = false
		end
		if aB and aB.Object then
			aB.Object.Visible = false
		end
		if aD and aD.Object then
			aD.Object.Visible = false
		end
		if aE and aE.Object then
			aE.Object.Visible = false
		end
		if aG and aG.Object then
			aG.Object.Visible = false
		end
		if aH and aH.Object then
			aH.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA = false, {}
	local function getKaliyahTargets()
		local aB = {}
		if not B.isAlive then
			return aB
		end
		local aC, aD = B.character.RootPart.Position, ax.Value
		for aE, aF in l:GetTagged'KaliyahPunchInteraction' do
			if aF:IsA'Model' and aF.PrimaryPart then
				local aG = (aC - aF.PrimaryPart.Position).Magnitude
				if aG <= aD then
					table.insert(aB, aF)
				end
			end
		end
		return aB
	end
	local function punchTarget(aB)
		local aC = aB:GetAttribute'Id' or tostring(aB)
		if au[aC] then
			return false
		end
		au[aC] = true
		local aD = t.Character
		if not aD or not aD.PrimaryPart then
			au[aC] = nil
			return false
		end
		pcall(function()
			O.DragonSlayerController:deleteEmblem(aB)
		end)
		local aE = aD:GetPrimaryPartCFrame().Position
		local aF = aB:GetPrimaryPartCFrame().Position * Vector3.new(1, 0, 1) + Vector3.new(0, aE.Y, 0)
		local aG = CFrame.new(aE, aF)
		aD:PivotTo(aG)
		pcall(function()
			O.DragonSlayerController:playPunchAnimation(aG - aG.Position)
		end)
		local aH = pcall(function()
			O.Client:Get(P.RequestDragonPunch):SendToServer{
				target = aB
			}
		end)
		task.delay(3, function()
			au[aC] = nil
		end)
		return aH
	end
	local function startAutoPunch()
		if ar then
			return
		end
		ar = true
		task.spawn(function()
			while av.Enabled and aw.Enabled and ar do
				if not B.isAlive then
					task.wait(0.5)
					continue
				end
				local aB, aC = getKaliyahTargets(), false
				for aD, aE in aB do
					if not av.Enabled or not aw.Enabled or not ar then
						break
					end
					if ay.Enabled and az.Value > 0 then
						task.wait(az.Value)
					end
					if punchTarget(aE) then
						aC = true
						task.wait(0.2)
					end
				end
				task.wait(aC and 0.5 or 0.3)
			end
			ar = false
		end)
	end
	local function stopAutoPunch()
		ar = false
		table.clear(au)
	end
	local aB
	local function hookNoSlow()
		if not O.DragonSlayerController then
			return
		end
		aB = O.DragonSlayerController.playPunchAnimation
		O.DragonSlayerController.playPunchAnimation = function(aC, aD)
			if aA.Enabled then
				local aE, aF, aG, aH, aI, aJ = debug.getupvalue(aB, 1), debug.getupvalue(aB, 2), debug.getupvalue(aB, 3), debug.getupvalue(aB, 4), debug.getupvalue(aB, 5), debug.getupvalue(aB, 6)
				local aK, aM = aE.new(), aF:playAnimation(aG.LocalPlayer, aH.DRAGON_SLAYER_PUNCH)
				aK:GiveTask(function()
					local aN = aM
					if aN ~= nil then
						aN:Stop()
					end
				end)
				aK:GiveTask(aJ.Heartbeat:Connect(function()
					local aN = aG.LocalPlayer.Character
					local aO = aN
					if aO ~= nil then
						aO = aO.PrimaryPart
					end
					if not aO then
						aK:DoCleaning()
						return nil
					end
					aN:PivotTo(CFrame.new(aN:GetPrimaryPartCFrame().Position) * aD)
				end))
				task.delay(0.46, function()
					aK:DoCleaning()
				end)
				return aK
			else
				return aB(aC, aD)
			end
		end
	end
	local function unhookNoSlow()
		if aB and O.DragonSlayerController then
			O.DragonSlayerController.playPunchAnimation = aB
		end
	end
	av = v.Categories.Kits:CreateModule{
		Name = 'AutoKaliyah',
		Function = function(aC)
			if aC then
				if aw.Enabled then
					startAutoPunch()
				end
				if aA.Enabled then
					hookNoSlow()
				end
			else
				stopAutoPunch()
				unhookNoSlow()
			end
		end,
		Tooltip = 'Dragon Slayer kit features - AutoPunch and NoSlow'
	}
	aw = av:CreateToggle{
		Name = 'Auto Punch',
		Default = false,
		Tooltip = 'Automatically punch dragon emblems',
		Function = function(aC)
			if ax and ax.Object then
				ax.Object.Visible = aC
			end
			if ay and ay.Object then
				ay.Object.Visible = aC
			end
			if az and az.Object then
				az.Object.Visible = (aC and ay.Enabled)
			end
			if not aC then
				if az and az.Object then
					az.Object.Visible = false
				end
			else
				if ay and ay.Enabled then
					if az and az.Object then
						az.Object.Visible = true
					end
				end
			end
			if av.Enabled then
				if aC then
					startAutoPunch()
				else
					stopAutoPunch()
				end
			end
		end
	}
	ax = av:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 100,
		Default = 18,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'Distance to auto punch emblems'
	}
	ay = av:CreateToggle{
		Name = 'Punch Delay',
		Default = false,
		Tooltip = 'Add delay before punching',
		Function = function(aC)
			if az and az.Object then
				az.Object.Visible = aC
			end
		end
	}
	az = av:CreateSlider{
		Name = 'Delay',
		Min = 1,
		Max = 3,
		Default = 1,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay in seconds before punching'
	}
	aA = av:CreateToggle{
		Name = 'No Slow',
		Default = false,
		Tooltip = 'Remove movement lock when punching',
		Function = function(aC)
			if av.Enabled then
				if aC then
					hookNoSlow()
				else
					unhookNoSlow()
				end
			end
		end
	}
	task.defer(function()
		if ax and ax.Object then
			ax.Object.Visible = false
		end
		if ay and ay.Object then
			ay.Object.Visible = false
		end
		if az and az.Object then
			az.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG = (Instance.new'Folder')
	ar.Parent = v.gui
	local aH, aI, aJ, aK, aM, aN, aO, aP = nil, nil, {}, 0, {}, 1, false, false
	local function sendNotification(aQ)
		notif('Spirit ESP', string.format('%d spirit orbs spawned', aQ), 3)
	end
	local function processSpawnQueue()
		if # aM > 0 then
			local aQ = tick()
			if aQ - aK >= aN then
				sendNotification(# aM)
				aK = aQ
				aM = {}
			else
				task.delay(aN - (aQ - aK), function()
					if # aM > 0 then
						sendNotification(# aM)
						aM = {}
					end
				end)
			end
		end
	end
	local function getProperImage()
		return O.getIcon({
			itemType = 'spirit'
		}, true)
	end
	local function Added(aQ)
		if aJ[aQ] then
			return
		end
		local aR = Instance.new'BillboardGui'
		aR.Parent = ar
		aR.Name = 'spirit-energy'
		aR.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aR.Size = UDim2.fromOffset(36, 36)
		aR.AlwaysOnTop = true
		aR.ClipsDescendants = false
		aR.Adornee = aQ
		local aS = addBlur(aR)
		aS.Visible = aD.Enabled
		local aT = Instance.new'ImageLabel'
		aT.Size = UDim2.fromOffset(36, 36)
		aT.Position = UDim2.fromScale(0.5, 0.5)
		aT.AnchorPoint = Vector2.new(0.5, 0.5)
		aT.BackgroundColor3 = Color3.fromHSV(aE.Hue, aE.Sat, aE.Value)
		aT.BackgroundTransparency = 1 - (aD.Enabled and aE.Opacity or 0)
		aT.BorderSizePixel = 0
		aT.Image = getProperImage()
		aT.Parent = aR
		local aU = Instance.new'UICorner'
		aU.CornerRadius = UDim.new(0, 4)
		aU.Parent = aT
		aJ[aQ] = aR
		if aC.Enabled then
			table.insert(aM, {
				item = 'spirit',
				time = tick()
			})
			processSpawnQueue()
		end
	end
	local function Removed(aQ)
		if aJ[aQ] then
			aJ[aQ]:Destroy()
			aJ[aQ] = nil
		end
	end
	local function setupESP()
		for aQ, aR in workspace:GetChildren() do
			if aR.Name == 'SpiritGardenerEnergy' and aR:IsA'Model' and aR.PrimaryPart then
				Added(aR.PrimaryPart)
			end
		end
		au:Clean(workspace.ChildAdded:Connect(function(aQ)
			if aQ.Name == 'SpiritGardenerEnergy' and aQ:IsA'Model' then
				task.wait(0.1)
				if aQ.PrimaryPart then
					Added(aQ.PrimaryPart)
				end
			end
		end))
		au:Clean(workspace.ChildRemoved:Connect(function(aQ)
			if aQ.Name == 'SpiritGardenerEnergy' and aQ.PrimaryPart then
				Removed(aQ.PrimaryPart)
			end
		end))
		au:Clean(g.RenderStepped:Connect(function()
			if not aB.Enabled then
				return
			end
			for aQ, aR in pairs(aJ) do
				if not aQ or not aQ.Parent then
					Removed(aQ)
					continue
				end
				local aS = true
				if aS and aF.Enabled and B.isAlive then
					local aT = (B.character.RootPart.Position - aQ.Position).Magnitude
					if aT < aG.ValueMin or aT > aG.ValueMax then
						aS = false
					end
				end
				aR.Enabled = aS
			end
		end))
	end
	local function getNearbyFlowers()
		local aQ = {}
		if not B.isAlive then
			return aQ
		end
		local aR, aS = B.character.RootPart.Position, ay.Value
		for aT, aU in l:GetTagged'SpiritGardenerFlower' do
			if aU:IsA'Model' and aU.PrimaryPart then
				if aU:GetAttribute'PlacedByUserId' == t.UserId then
					local aV = not aU:GetAttribute'HasFullyGrown'
					if aV then
						local aW = (aR - aU.PrimaryPart.Position).Magnitude
						if aW <= aS then
							table.insert(aQ, aU)
						end
					end
				end
			end
		end
		return aQ
	end
	local function useWaterAbility()
		local aQ = pcall(function()
			game:GetService'ReplicatedStorage':WaitForChild'events-@easy-games/game-core:shared/game-core-networking@getEvents.Events':WaitForChild'useAbility':FireServer'spirit_gardener_water'
		end)
		return aQ
	end
	local function startAutoWater()
		if aO then
			return
		end
		aO = true
		task.spawn(function()
			while au.Enabled and ax.Enabled and aO do
				if not B.isAlive then
					task.wait(0.5)
					continue
				end
				local aQ = getNearbyFlowers()
				if # aQ > 0 then
					if useWaterAbility() then
						task.wait(0.6)
					else
						task.wait(0.3)
					end
				else
					task.wait(0.5)
				end
			end
			aO = false
		end)
	end
	local function stopAutoWater()
		aO = false
	end
	local function hookAutoCollect()
		if not O.SpiritGardenerSeedController then
			return
		end
		aI = O.SpiritGardenerSeedController.checkForPickup
		O.SpiritGardenerSeedController.checkForPickup = function(aQ)
			if not az.Enabled then
				return aI(aQ)
			end
			local aR, aS, aT = e, l, game:GetService'Workspace'
			local aU = aR.LocalPlayer.Character
			if not aU or not aU.PrimaryPart then
				return nil
			end
			local aV, aW, aX = aU.PrimaryPart.Position, aA.Value, aQ:validCollectableEntityTypes()
			for aY, aZ in aX do
				local a_ = aS:GetTagged(aZ)
				for a0, a1 in a_ do
					local a2 = a1:GetAttribute'SpawnTime'
					if a2 and (aT:GetServerTimeNow() - a2) >= 1 then
						local a3 = a1:GetPivot().Position
						local a4 = (aV - a3).Magnitude
						if a4 <= aW then
							aQ:collectEntity(aR.LocalPlayer, a1, aZ)
						end
					end
				end
			end
		end
	end
	local function unhookAutoCollect()
		if aI and O.SpiritGardenerSeedController then
			O.SpiritGardenerSeedController.checkForPickup = aI
		end
	end
	local function startAutoCollect()
		if aP then
			return
		end
		aP = true
		hookAutoCollect()
		if O.SpiritGardenerSeedController then
			pcall(function()
				O.SpiritGardenerSeedController:listenToPickup()
			end)
		end
	end
	local function stopAutoCollect()
		aP = false
		unhookAutoCollect()
	end
	local function hookNoSlow()
		if not O.SpiritGardenerController then
			return
		end
		aH = O.SpiritGardenerController.disableActionsOnCharge
		O.SpiritGardenerController.disableActionsOnCharge = function(aQ, aR, aS)
			if not av.Enabled then
				return aH(aQ, aR, aS)
			end
			if aw.Enabled then
				local aT = aS == t.Character
				if not aT then
					return aH(aQ, aR, aS)
				end
			end
			if aS == t.Character then
				local aT = O.KnitClient
				aT.Controllers.SwordController:toggleSwordSwing(true)
				aT.Controllers.BlockPlacementController:disableBlockPlacer()
				local aU = debug.getupvalue(aH, 3)
				local aV, aW = aU.BeginProjectileTargeting:connect(function(aV)
					aV:setCancelled(true)
					return nil
				end), aT.Controllers.JumpHeightController:getJumpModifier():addModifier{
					jumpHeightMultiplier = 0
				}
				aR:GiveTask(function()
					aT.Controllers.SwordController:toggleSwordSwing(false)
					aT.Controllers.BlockPlacementController:enableBlockPlacer()
					aV:Destroy()
					aW.Destroy()
				end)
			end
		end
	end
	local function unhookNoSlow()
		if aH and O.SpiritGardenerController then
			O.SpiritGardenerController.disableActionsOnCharge = aH
		end
	end
	au = v.Categories.Kits:CreateModule{
		Name = 'AutoGrove',
		Function = function(aQ)
			if aQ then
				if aB.Enabled then
					setupESP()
				end
				if av.Enabled then
					hookNoSlow()
				end
				if ax.Enabled then
					startAutoWater()
				end
				if az.Enabled then
					startAutoCollect()
				end
			else
				stopAutoWater()
				stopAutoCollect()
				unhookNoSlow()
				ar:ClearAllChildren()
				table.clear(aJ)
				table.clear(aM)
				aK = 0
			end
		end,
		Tooltip = 'Spirit Gardener kit features - NoSlow, Auto Water, Auto Collect, and Spirit ESP'
	}
	av = au:CreateToggle{
		Name = 'No Slow',
		Default = false,
		Tooltip = 'Remove movement lock when using water ability',
		Function = function(aQ)
			if aw and aw.Object then
				aw.Object.Visible = aQ
			end
			if au.Enabled then
				if aQ then
					hookNoSlow()
				else
					unhookNoSlow()
				end
			end
		end
	}
	aw = au:CreateToggle{
		Name = 'Only On Ability Use',
		Default = false,
		Tooltip = 'NoSlow only works when you manually use the ability'
	}
	ax = au:CreateToggle{
		Name = 'Auto Water',
		Default = false,
		Tooltip = 'Automatically water nearby flowers that need energy',
		Function = function(aQ)
			if ay and ay.Object then
				ay.Object.Visible = aQ
			end
			if au.Enabled then
				if aQ then
					startAutoWater()
				else
					stopAutoWater()
				end
			end
		end
	}
	ay = au:CreateSlider{
		Name = 'Water Range',
		Min = 1,
		Max = 30,
		Default = 20,
		Decimal = 1,
		Suffix = ' studs',
		Tooltip = 'Distance to auto water flowers'
	}
	az = au:CreateToggle{
		Name = 'Auto Collect',
		Default = false,
		Tooltip = 'Automatically collect spirit energy orbs from extended range',
		Function = function(aQ)
			if aA and aA.Object then
				aA.Object.Visible = aQ
			end
			if au.Enabled then
				if aQ then
					startAutoCollect()
				else
					stopAutoCollect()
				end
			end
		end
	}
	aA = au:CreateSlider{
		Name = 'Collect Range',
		Min = 5,
		Max = 12,
		Default = 12,
		Decimal = 10,
		Suffix = ' studs',
		Tooltip = 'Distance to auto collect spirit orbs (default: 5.5)'
	}
	aB = au:CreateToggle{
		Name = 'Spirit ESP',
		Default = false,
		Tooltip = 'Shows spirit energy orb locations',
		Function = function(aQ)
			if aC and aC.Object then
				aC.Object.Visible = aQ
			end
			if aD and aD.Object then
				aD.Object.Visible = aQ
			end
			if aE and aE.Object then
				aE.Object.Visible = aQ
			end
			if aF and aF.Object then
				aF.Object.Visible = aQ
			end
			if aG and aG.Object then
				aG.Object.Visible = (aQ and aF.Enabled)
			end
			if not aQ then
				if aE and aE.Object then
					aE.Object.Visible = false
				end
				if aG and aG.Object then
					aG.Object.Visible = false
				end
			else
				if aD and aD.Enabled then
					if aE and aE.Object then
						aE.Object.Visible = true
					end
				end
				if aF and aF.Enabled then
					if aG and aG.Object then
						aG.Object.Visible = true
					end
				end
			end
			if au.Enabled then
				if aQ then
					setupESP()
				else
					ar:ClearAllChildren()
					table.clear(aJ)
				end
			end
		end
	}
	aC = au:CreateToggle{
		Name = 'Notify',
		Default = false,
		Tooltip = 'Get notifications when spirit orbs spawn'
	}
	aD = au:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aQ)
			if aE and aE.Object then
				aE.Object.Visible = aQ
			end
			for aR, aS in aJ do
				if aS and aS:FindFirstChild'ImageLabel' then
					local aT = aS:FindFirstChild'BlurEffect'
					if aT then
						aT.Visible = aQ
					end
					aS.ImageLabel.BackgroundTransparency = 1 - (aQ and aE.Opacity or 0)
				end
			end
		end
	}
	aE = au:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0.5,
		DefaultOpacity = 0.5,
		Function = function(aQ, aR, aS, aT)
			for aU, aV in aJ do
				if aV and aV:FindFirstChild'ImageLabel' then
					aV.ImageLabel.BackgroundColor3 = Color3.fromHSV(aQ, aR, aS)
					aV.ImageLabel.BackgroundTransparency = 1 - aT
				end
			end
		end,
		Darker = true
	}
	aF = au:CreateToggle{
		Name = 'Distance Check',
		Default = false,
		Tooltip = 'Only show spirit orbs within distance range',
		Function = function(aQ)
			if aG and aG.Object then
				aG.Object.Visible = aQ
			end
		end
	}
	aG = au:CreateTwoSlider{
		Name = 'Spirit Distance',
		Min = 0,
		Max = 256,
		DefaultMin = 0,
		DefaultMax = 64,
		Darker = true,
		Tooltip = 'Distance range for showing spirit orbs'
	}
	task.defer(function()
		if aC and aC.Object then
			aC.Object.Visible = false
		end
		if aD and aD.Object then
			aD.Object.Visible = false
		end
		if aE and aE.Object then
			aE.Object.Visible = false
		end
		if aF and aF.Object then
			aF.Object.Visible = false
		end
		if aG and aG.Object then
			aG.Object.Visible = false
		end
		if ay and ay.Object then
			ay.Object.Visible = false
		end
		if aA and aA.Object then
			aA.Object.Visible = false
		end
		if aw and aw.Object then
			aw.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE = nil, nil, nil, nil, nil, nil, nil, false, 'idle', {}, l, e
	local aF, aG, aH, aI, aJ = aE.LocalPlayer, {
		['Emerald > Diamond > Gold'] = {
			'emerald',
			'diamond',
			'iron'
		},
		['Diamond > Emerald > Gold'] = {
			'diamond',
			'emerald',
			'iron'
		},
		['Gold > Diamond > Emerald'] = {
			'iron',
			'diamond',
			'emerald'
		}
	}, 0
	local function getMyDrone()
		for aK, aM in aD:GetTagged'Drone' do
			if aM:GetAttribute'PlayerUserId' == aF.UserId then
				return aM
			end
		end
		return nil
	end
	local function getDroneItemCount(aK)
		if not aK then
			return 0
		end
		return aK:GetAttribute'HeldItemAmount' or 0
	end
	local function getOwnBed()
		local aK = aF:GetAttribute'Team'
		if not aK then
			return nil
		end
		for aM, aN in ipairs(aD:GetTagged'bed') do
			if aN:GetAttribute('Team' .. aK .. 'NoBreak') then
				return aN
			end
		end
		return nil
	end
	local function getDropPosition()
		if av.Value == 'My Bed' then
			local aK = getOwnBed()
			if aK then
				return aK:GetPivot().Position
			end
		end
		if aF.Character and aF.Character:FindFirstChild'HumanoidRootPart' then
			return aF.Character.HumanoidRootPart.Position
		end
		return nil
	end
	local function isRecentlyDropped(aK)
		if not aI then
			return false
		end
		if tick() - aH > 5 then
			return false
		end
		return (aK - aI).Magnitude < 25
	end
	local function findNearestLoot(aK, aM)
		local aN, aO = (math.huge)
		for aP, aQ in workspace:GetDescendants() do
			if aQ.Name == 'GeneratorAdornee' then
				local aR = aQ:GetAttribute'Id'
				if aR and aR:lower():find(aK:lower()) then
					local aS = aQ:GetPivot().Position
					for aT, aU in aD:GetTagged'ItemDrop' do
						if aU:FindFirstChild'Handle' then
							if aU.Name:lower():find(aK:lower()) then
								local aV = aU.Handle.Position
								if (aV - aS).Magnitude <= 12 then
									if not isRecentlyDropped(aV) then
										local aW = (aV - aM).Magnitude
										if aW < aN and aW < 150 then
											aO = aV
											aN = aW
										end
									end
								end
							end
						end
					end
				end
			end
		end
		return aO
	end
	local function smoothMove(aK, aM, aN)
		if not aK or not aK.PrimaryPart then
			return false
		end
		if not aM then
			return false
		end
		local aO = aK.PrimaryPart.Position
		local aP = (aM - aO).Magnitude
		if aP < 2 then
			return true
		end
		local aQ, aR, aS = (aM - aO).Unit, math.clamp(aP * (aN or 1.5), 18, ax.Value), CFrame.lookAt(aO, aM)
		aK.PrimaryPart.CFrame = aK.PrimaryPart.CFrame:Lerp(aS, 0.05)
		aK.PrimaryPart.AssemblyLinearVelocity = aQ * aR
		aK.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
		return false
	end
	local function executeState()
		local aK = getMyDrone()
		if not aK or not aK.PrimaryPart then
			return
		end
		if aB == 'collecting' then
			if not az then
				aB = 'searching'
				return
			end
			if smoothMove(aK, az, 1.8) then
				task.wait(0.4)
				aB = 'searching'
				az = nil
			end
		elseif aB == 'delivering' then
			local aM = getDropPosition()
			if not aM then
				aB = 'searching'
				return
			end
			local aN = aM + Vector3.new(0, aw.Value, 0)
			if smoothMove(aK, aN, 1.5) then
				task.wait(0.3)
				local aO = aM + Vector3.new(math.random(- 3, 3), 1, math.random(- 3, 3))
				pcall(function()
					O.Client:Get(P.DropDroneItem).instance:FireServer{
						position = aO,
						direction = Vector3.new(0, - 1, 0)
					}
				end)
				aI = aM
				aH = tick()
				local aP = (aK.PrimaryPart.Position - aM).Unit
				aK.PrimaryPart.AssemblyLinearVelocity = aP * 35 + Vector3.new(0, 12, 0)
				task.wait(1)
				aB = 'searching'
				az = nil
			end
		elseif aB == 'searching' then
			if tick() - aH < 1.5 then
				task.wait(0.5)
				return
			end
			if getDroneItemCount(aK) >= ay.Value then
				aB = 'delivering'
				return
			end
			local aM, aN = aG[au.Value], false
			for aO, aP in ipairs(aM) do
				if getDroneItemCount(aK) >= ay.Value then
					aB = 'delivering'
					return
				end
				local aQ = findNearestLoot(aP, aK.PrimaryPart.Position)
				if aQ then
					az = aQ + Vector3.new(0, 2, 0)
					aB = 'collecting'
					aN = true
					break
				end
			end
			if not aN then
				aB = 'idle'
			end
		elseif aB == 'idle' then
			aK.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 1.5, 0)
			aK.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
			task.wait(1)
			aB = 'searching'
		end
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoDrone',
		Function = function(aK)
			if aK then
				aA = true
				aB = 'searching'
				az = nil
				aH = 0
				aI = nil
				aC = {}
				aJ = g.Heartbeat:Connect(function()
					if not ar.Enabled then
						return
					end
					pcall(executeState)
				end)
			else
				aA = false
				aB = 'idle'
				az = nil
				if aJ then
					aJ:Disconnect()
					aJ = nil
				end
				local aM = getMyDrone()
				if aM and aM.PrimaryPart then
					aM.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
					aM.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
				end
			end
		end,
		Tooltip = 'Automatically collects loot and brings it to you'
	}
	au = ar:CreateDropdown{
		Name = 'Collect Order',
		List = {
			'Emerald > Diamond > Gold',
			'Diamond > Emerald > Gold',
			'Gold > Diamond > Emerald'
		},
		Default = 'Emerald > Diamond > Gold',
		Tooltip = 'Which resource the drone prioritizes picking up first'
	}
	av = ar:CreateDropdown{
		Name = 'Drop Off At',
		List = {
			'Me',
			'My Bed'
		},
		Default = 'Me',
		Tooltip = 'Where the drone delivers collected items'
	}
	aw = ar:CreateSlider{
		Name = 'Flight Height',
		Default = 7,
		Min = 4,
		Max = 12,
		Tooltip = 'How high the drone flies above its target'
	}
	ax = ar:CreateSlider{
		Name = 'Flight Speed',
		Default = 28,
		Min = 18,
		Max = 45,
		Tooltip = 'Higher = faster drone movement'
	}
	ay = ar:CreateSlider{
		Name = 'Items Before Drop',
		Default = 3,
		Min = 1,
		Max = 10,
		Tooltip = 'How many items to pick up before flying back to drop them off'
	}
end)
a(function()
	local ar, au
	repeat
		ar, au = pcall(function()
			return debug.getupvalue(require(t.PlayerScripts.TS.knit).setup, 9)
		end)
		if ar then
			break
		end
		task.wait()
	until ar
	if not debug.getupvalue(au.Start, 1) then
		repeat
			task.wait()
		until debug.getupvalue(au.Start, 1)
	end
	local av = game:GetService'Players'
	shared.PERMISSION_CONTROLLER_HASANYPERMISSIONS_REVERT = shared.PERMISSION_CONTROLLER_HASANYPERMISSIONS_REVERT or au.Controllers.PermissionController.hasAnyPermissions
	shared.MATCH_CONTROLLER_GETPLAYERPARTY_REVERT = shared.MATCH_CONTROLLER_GETPLAYERPARTY_REVERT or au.Controllers.MatchController.getPlayerParty
	local aw = {
		playerConnections = {},
		Enabled = false,
		Friends = {},
		parties = {},
		teamMap = {},
		display = {},
		isRefreshing = false,
		cacheDirty = true,
		disable_disguises = false,
		disguises = {},
		teamData = {}
	}
	aw.controller = au.Controllers.PermissionController
	aw.match_controller = au.Controllers.MatchController
	function aw.getPartyById(ax, ay)
		if not ay then
			return
		end
		ay = tostring(ay)
		if ax.display[ay] then
			return ax.display[ay]
		end
		for az, aA in pairs(ax.parties) do
			if aA.displayId == tostring(ay) then
				ax.display[ay] = aA
				return aA
			end
		end
	end
	function aw.refreshDisplayCache(ax)
		for ay, az in pairs(av:GetPlayers()) do
			local aA = tostring(az.UserId)
			local aB = ax.teamMap[aA]
			if aB ~= nil then
				ax:getPartyById(aB)
			end
			task.wait()
		end
	end
	function aw.refreshDisplayCacheAsync(ax)
		task.spawn(ax.refreshDisplayCache, ax)
	end
	function aw.getPlayerTeamData(ax, ay)
		if ax.teamData[ay] then
			return ax.teamData[ay]
		end
		ax.teamData[ay] = {}
		local az, aA = {}, ay.Team
		if not aA then
			return az
		end
		local aB = tostring(ay.UserId)
		ax.Friends[aB] = ax.Friends[aB] or {}
		for aC, aD in pairs(av:GetPlayers()) do
			if aD == ay then
				continue
			end
			local aE = tostring(aD.UserId)
			local aF = ax.Friends[aB][aE]
			if aF == nil then
				local aG, aH = pcall(function()
					return ay:IsFriendsWith(aD.UserId)
				end)
				aF = aG and aH or false
				if aG then
					ax.Friends = ax.Friends or {}
					ax.Friends[aB] = ax.Friends[aB] or {}
					ax.Friends[aB][aE] = aF
					ax.Friends[aE] = ax.Friends[aE] or {}
					ax.Friends[aE][aB] = aF
				end
			end
			if aF and aD.Team == aA then
				table.insert(az, aE)
			end
		end
		ax.teamData[ay] = az
		return az
	end
	function aw.refreshPlayerTeamData(ax)
		for ay, az in pairs(av:GetPlayers()) do
			ax:getPlayerTeamData(az)
			task.wait()
		end
	end
	function aw.refreshPlayerTeamDataAsync(ax)
		task.spawn(ax.refreshPlayerTeamData, ax)
	end
	function aw.refreshTeamMap(ax)
		local ay = {}
		for az, aA in pairs(av:GetPlayers()) do
			local aB = ax:getPlayerTeamData(aA)
			if aB and # aB > 0 then
				ay[aA] = aB
			end
		end
		local az = {}
		for aA, aB in pairs(ay) do
			local aC, aD = tostring(aA.UserId), {}
			for aE, aF in pairs(aB) do
				local aG = tostring(aF)
				if aG == aC then
				else
					table.insert(aD, aG)
				end
			end
			if # aD > 0 then
				az[aA] = aD
			end
		end
		ax.parties = {}
		ax.teamMap = {}
		local aA = 0
		for aB, aC in pairs(az) do
			local aD = tostring(aB.UserId)
			if not ax.teamMap[aD] then
				ax.teamMap[aD] = aA
				table.insert(ax.parties, {
					displayId = tostring(aA),
					members = aC
				})
				aA = aA + 1
				for aE, aF in pairs(aC) do
					ax.teamMap[aF] = aA - 1
				end
			end
		end
		ax.cacheDirty = false
		ax.isRefreshing = false
	end
	function aw.refreshTeamMapAsync(ax)
		if ax.isRefreshing then
			return
		end
		ax.isRefreshing = true
		task.spawn(function()
			ax:refreshTeamMap()
		end)
	end
	function aw.getPlayerParty(ax, ay)
		if not ay or not ay:IsA'Player' then
			return nil
		end
		local az = tostring(ay.UserId)
		if ax.cacheDirty or not next(ax.teamMap) then
			ax:refreshTeamMapAsync()
		end
		local aA = ax.teamMap[az]
		if aA ~= nil then
			return ax:getPartyById(aA)
		end
		return nil
	end
	aw.mockGetPlayerParty = function(ax, ay)
		local az = ax.parties
		if az ~= nil and # az > 0 then
			return shared.MATCH_CONTROLLER_GETPLAYERPARTY_REVERT(ax, ay)
		end
		return aw:getPlayerParty(ay)
	end
	function aw.toggleDisableDisguises(ax)
		if not ax.Enabled then
			return
		end
		if ax.disable_disguises then
			for ay, az in pairs(av:GetPlayers()) do
				if az == av.LocalPlayer then
					continue
				end
				if tostring(az:GetAttribute'Disguised') == 'true' then
					az:SetAttribute('Disguised', false)
					InfoNotification('Remove Disguises', 'Disabled streamer mode for ' .. tostring(az.Name) .. '!', 3)
					table.insert(ax.disguises, az)
				end
			end
		else
			for ay, az in pairs(ax.disguises) do
				if tostring(az:GetAttribute'Disguised') ~= 'true' then
					az:SetAttribute('Disguised', true)
					InfoNotification('Remove Disguises', 'Re - enabled Streamer mode for ' .. tostring(az.Name) .. '!', 2)
				end
			end
			table.clear(ax.disguises)
		end
	end
	function aw.refreshCore(ax)
		ax:refreshTeamMapAsync()
		ax:refreshDisplayCacheAsync()
		ax:refreshPlayerTeamDataAsync()
		ax:toggleDisableDisguises()
	end
	function aw.refreshCoreAsync(ax)
		task.spawn(ax.refreshCore, ax)
	end
	function aw.init(ax)
		ax.Enabled = true
		ax.controller.hasAnyPermissions = function(ay)
			return true
		end
		ax.match_controller.getPlayerParty = ax.mockGetPlayerParty
		ax.playerConnections = {
			added = av.PlayerAdded:Connect(function(ay)
				ax.cacheDirty = true
				ax:refreshCoreAsync()
				ay:GetPropertyChangedSignal'Team':Connect(function()
					ax.cacheDirty = true
					ax:refreshCoreAsync()
				end)
			end),
			removed = av.PlayerRemoving:Connect(function(ay)
				local az = tostring(ay.UserId)
				ax.Friends[az] = nil
				for aA, aB in pairs(ax.Friends) do
					aB[az] = nil
				end
				ax.cacheDirty = true
				ax:refreshCoreAsync()
			end)
		}
		ax:refreshCore()
	end
	function aw.disable(ax)
		ax.Enabled = false
		ax.controller.hasAnyPermissions = shared.PERMISSION_CONTROLLER_HASANYPERMISSIONS_REVERT
		ax.match_controller.getPlayerParty = shared.MATCH_CONTROLLER_GETPLAYERPARTY_REVERT
		if ax.playerConnections then
			for ay, az in pairs(ax.playerConnections) do
				pcall(function()
					az:Disconnect()
				end)
			end
			table.clear(ax.playerConnections)
		end
		ax.parties = {}
		ax.teamMap = {}
		ax.Friends = {}
		ax.display = {}
		ax.teamData = {}
		ax.cacheDirty = true
		ax:toggleDisableDisguises()
	end
	shared.ACMODVIEWENABLED = false
	aw.moduleInstance = v.Categories.World:CreateModule{
		Name = 'AC MOD View',
		Tags = {
			'new',
			'op'
		},
		Function = function(ax)
			shared.ACMODVIEWENABLED = ax
			if ax then
				aw:init()
			else
				aw:disable()
			end
		end
	}
	aw.disableDisguisesToggle = aw.moduleInstance:CreateToggle{
		Name = 'Remove Disguises',
		Function = function(ax)
			aw.disable_disguises = ax
			aw:toggleDisableDisguises()
		end,
		Default = true
	}
end)
a(function()
	local ar, au, av = {}
	local function modifyPlayerName(aw)
		if aw:IsA'TextLabel' and aw.Name == 'PlayerName' then
			if aw.Text:find(t.Name) or aw.Text:find(t.DisplayName) then
				if not ar[aw] then
					ar[aw] = aw.Text
				end
				aw.Text = 'Me'
			end
		end
		if aw:IsA'TextLabel' and aw.Name == 'EntityName' then
			if aw.Text:find(t.Name) or aw.Text:find(t.DisplayName) then
				if not ar[aw] then
					ar[aw] = aw.Text
				end
				aw.Text = 'Me'
			end
		end
		if aw:IsA'TextLabel' and aw.Name == 'DisplayName' then
			if aw.Text:find(t.Name) or aw.Text:find(t.DisplayName) then
				if not ar[aw] then
					ar[aw] = aw.Text
				end
				aw.Text = 'Me'
			end
		end
	end
	local function restorePlayerName(aw)
		if ar[aw] then
			aw.Text = ar[aw]
			ar[aw] = nil
		end
	end
	local function processGui(aw)
		for ax, ay in aw:GetDescendants() do
			modifyPlayerName(ay)
		end
	end
	local function modifyNametag(aw)
		if not aw then
			return
		end
		local ax = aw:FindFirstChild'Head'
		if not ax then
			return
		end
		local ay = ax:FindFirstChild'Nametag'
		if not ay then
			return
		end
		local az = ay:FindFirstChild'DisplayNameContainer'
		if not az then
			return
		end
		local aA = az:FindFirstChild'DisplayName'
		if aA and aA:IsA'TextLabel' then
			modifyPlayerName(aA)
		end
	end
	local function restoreNametag(aw)
		if not aw then
			return
		end
		local ax = aw:FindFirstChild'Head'
		if not ax then
			return
		end
		local ay = ax:FindFirstChild'Nametag'
		if not ay then
			return
		end
		local az = ay:FindFirstChild'DisplayNameContainer'
		if not az then
			return
		end
		local aA = az:FindFirstChild'DisplayName'
		if aA and aA:IsA'TextLabel' then
			restorePlayerName(aA)
		end
	end
	au = v.Categories.Render:CreateModule{
		Name = 'IncognitoCE',
		Function = function(aw)
			if aw then
				local ax = t.PlayerGui:FindFirstChild'TabListScreenGui'
				if ax then
					processGui(ax)
					au:Clean(ax.DescendantAdded:Connect(function(ay)
						modifyPlayerName(ay)
					end))
				end
				local ay = t.PlayerGui:FindFirstChild'KillFeedGui'
				if ay then
					processGui(ay)
					au:Clean(ay.DescendantAdded:Connect(function(az)
						modifyPlayerName(az)
					end))
				end
				au:Clean(t.PlayerGui.ChildAdded:Connect(function(az)
					if az.Name == 'TabListScreenGui' then
						processGui(az)
						au:Clean(az.DescendantAdded:Connect(function(aA)
							modifyPlayerName(aA)
						end))
					elseif az.Name == 'KillFeedGui' then
						processGui(az)
						au:Clean(az.DescendantAdded:Connect(function(aA)
							modifyPlayerName(aA)
						end))
					end
				end))
				if t.Character then
					modifyNametag(t.Character)
				end
				au:Clean(t.CharacterAdded:Connect(function(az)
					task.wait(0.5)
					if au.Enabled then
						modifyNametag(az)
					end
				end))
				local az = 0
				av = g.RenderStepped:Connect(function()
					if au.Enabled and t.Character then
						az = az + 1
						if az % 30 == 0 then
							pcall(function()
								modifyNametag(t.Character)
							end)
						end
					end
				end)
			else
				if av then
					av:Disconnect()
					av = nil
				end
				local ax = t.PlayerGui:FindFirstChild'TabListScreenGui'
				if ax then
					for ay, az in ax:GetDescendants() do
						restorePlayerName(az)
					end
				end
				local ay = t.PlayerGui:FindFirstChild'KillFeedGui'
				if ay then
					for az, aA in ay:GetDescendants() do
						restorePlayerName(aA)
					end
				end
				if t.Character then
					restoreNametag(t.Character)
				end
				table.clear(ar)
			end
		end,
		Tooltip = 'Hides your name as much as possible  in TabList, KillFeed, and Nametag'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, {}, g, e
	local aI, aJ = aH.LocalPlayer, Instance.new'Folder'
	aJ.Parent = v.gui
	local aK, aM, aN = {}, {}, {}
	local function kitCollection(aO, aP, aQ, aR)
		repeat
			if B.isAlive then
				local aS, aT = type(aO) == 'table' and aO or collection(aO, ar), B.character.RootPart.Position
				for aU, aV in aS do
					if not ar.Enabled then
						break
					end
					local aW = not aV:IsA'Model' and aV or aV.PrimaryPart
					if aW and (aW.Position - aT).Magnitude <= aQ then
						local aX, aY = pcall(aP, aV)
						if not aX then
							warn('lucia deposit error:', aY)
						end
						if aw.Enabled then
							task.wait(ax.Value)
						else
							task.wait(0.05)
						end
					end
				end
			end
			task.wait(0.1)
		until not ar.Enabled
	end
	local function isTeammateESP(aO)
		if not aA.Enabled then
			return false
		end
		local aP = aO:GetAttribute'PlacedByUserId' or aO:GetAttribute'PlacerId'
		if not aP then
			local aQ = aO.Parent
			if aQ then
				aP = aQ:GetAttribute'PlacedByUserId' or aQ:GetAttribute'PlacerId'
			end
		end
		if aP then
			if aP == aI.UserId then
				return true
			end
			local aQ = aH:GetPlayerByUserId(aP)
			if aQ and aQ.Team == aI.Team then
				return true
			end
		end
		return false
	end
	local function isTeammateSpy(aO)
		if not aD.Enabled then
			return false
		end
		local aP = aO:GetAttribute'PlacedByUserId' or aO:GetAttribute'PlacerId'
		if not aP then
			local aQ = aO.Parent
			if aQ then
				aP = aQ:GetAttribute'PlacedByUserId' or aQ:GetAttribute'PlacerId'
			end
		end
		if aP then
			if aP == aI.UserId then
				return true
			end
			local aQ = aH:GetPlayerByUserId(aP)
			if aQ and aQ.Team == aI.Team then
				return true
			end
		end
		return false
	end
	local function getCandyAmount(aO)
		local aP = aO:GetAttribute'Coin'
		return aP or 0
	end
	local function getProperIcon(aO)
		local aP = O.getIcon({
			itemType = aO
		}, true)
		if not aP or aP == '' then
			return nil
		end
		return aP
	end
	local function Added(aO)
		if isTeammateESP(aO) then
			return
		end
		if aK[aO] then
			return
		end
		local aP = Instance.new'BillboardGui'
		aP.Parent = aJ
		aP.Name = 'pinata'
		aP.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
		aP.Size = UDim2.fromOffset(az.Enabled and 80 or 36, 36)
		aP.AlwaysOnTop = true
		aP.ClipsDescendants = false
		aP.Adornee = aO
		local aQ = addBlur(aP)
		aQ.Visible = aB.Enabled
		local aR = Instance.new'Frame'
		aR.Size = UDim2.fromScale(1, 1)
		aR.BackgroundColor3 = Color3.fromHSV(aF.Hue, aF.Sat, aF.Value)
		aR.BackgroundTransparency = 1 - (aB.Enabled and aF.Opacity or 0)
		aR.BorderSizePixel = 0
		aR.Parent = aP
		local aS = Instance.new'UICorner'
		aS.CornerRadius = UDim.new(0, 4)
		aS.Parent = aR
		local aT = getProperIcon'pinata'
		if aT then
			local aU = Instance.new'ImageLabel'
			aU.Name = 'PinataIcon'
			aU.Size = UDim2.fromOffset(36, 36)
			aU.Position = UDim2.new(0, 0, 0.5, 0)
			aU.AnchorPoint = Vector2.new(0, 0.5)
			aU.BackgroundTransparency = 1
			aU.Image = aT
			aU.Parent = aR
		end
		local aU, aV
		if az.Enabled then
			aU = Instance.new'TextLabel'
			aU.Name = 'CandyAmount'
			aU.Size = UDim2.fromOffset(25, 20)
			aU.Position = UDim2.new(0, 40, 0.5, 0)
			aU.AnchorPoint = Vector2.new(0, 0.5)
			aU.BackgroundTransparency = 1
			aU.Text = tostring(getCandyAmount(aO))
			aU.TextColor3 = Color3.fromRGB(255, 255, 255)
			aU.TextSize = 16
			aU.Font = Enum.Font.GothamBold
			aU.TextStrokeTransparency = 0.5
			aU.TextStrokeColor3 = Color3.new(0, 0, 0)
			aU.Parent = aR
			local aW = getProperIcon'candy'
			if aW then
				aV = Instance.new'ImageLabel'
				aV.Name = 'CandyIcon'
				aV.Size = UDim2.fromOffset(18, 18)
				aV.Position = UDim2.new(0, 65, 0.5, 0)
				aV.AnchorPoint = Vector2.new(0, 0.5)
				aV.BackgroundTransparency = 1
				aV.Image = aW
				aV.Parent = aR
			end
		end
		aK[aO] = {
			billboard = aP,
			frame = aR,
			candyAmount = aU,
			candyIcon = aV
		}
	end
	local function Removed(aO)
		if aK[aO] then
			aK[aO].billboard:Destroy()
			aK[aO] = nil
		end
	end
	local function updateCandyDisplay(aO)
		local aP = aK[aO]
		if not aP then
			return
		end
		if az.Enabled then
			if not aP.candyAmount then
				aP.candyAmount = Instance.new'TextLabel'
				aP.candyAmount.Name = 'CandyAmount'
				aP.candyAmount.Size = UDim2.fromOffset(25, 20)
				aP.candyAmount.Position = UDim2.new(0, 40, 0.5, 0)
				aP.candyAmount.AnchorPoint = Vector2.new(0, 0.5)
				aP.candyAmount.BackgroundTransparency = 1
				aP.candyAmount.TextColor3 = Color3.fromRGB(255, 255, 255)
				aP.candyAmount.TextSize = 16
				aP.candyAmount.Font = Enum.Font.GothamBold
				aP.candyAmount.TextStrokeTransparency = 0.5
				aP.candyAmount.TextStrokeColor3 = Color3.new(0, 0, 0)
				aP.candyAmount.Parent = aP.frame
				local aQ = getProperIcon'candy'
				if aQ and not aP.candyIcon then
					aP.candyIcon = Instance.new'ImageLabel'
					aP.candyIcon.Name = 'CandyIcon'
					aP.candyIcon.Size = UDim2.fromOffset(18, 18)
					aP.candyIcon.Position = UDim2.new(0, 65, 0.5, 0)
					aP.candyIcon.AnchorPoint = Vector2.new(0, 0.5)
					aP.candyIcon.BackgroundTransparency = 1
					aP.candyIcon.Image = aQ
					aP.candyIcon.Parent = aP.frame
				end
				aP.billboard.Size = UDim2.fromOffset(80, 36)
			end
			if aP.candyAmount then
				aP.candyAmount.Text = tostring(getCandyAmount(aO))
			end
		else
			if aP.candyAmount then
				aP.candyAmount:Destroy()
				aP.candyAmount = nil
			end
			if aP.candyIcon then
				aP.candyIcon:Destroy()
				aP.candyIcon = nil
			end
			aP.billboard.Size = UDim2.fromOffset(36, 36)
		end
	end
	local function findExistingPinatas()
		for aO, aP in pairs(workspace:GetDescendants()) do
			if aP:IsA'BasePart' and aP.Name == 'pinata' then
				if not aK[aP] and not isTeammateESP(aP) then
					Added(aP)
				end
			end
		end
	end
	local function refreshESP()
		aJ:ClearAllChildren()
		table.clear(aK)
		findExistingPinatas()
	end
	local function getPlayerName(aO)
		if aE.Enabled then
			return aO.DisplayName ~= '' and aO.DisplayName or aO.Name
		else
			return aO.Name
		end
	end
	local function getTeamName(aO)
		if aO.Team then
			return aO.Team.Name
		end
		return 'Unknown'
	end
	local function setupLuciaSpy()
		local aO = require(game:GetService'ReplicatedStorage'.TS.games.bedwars.kit.kits['piggy-bank']['piggy-bank-util']).PiggyBankUtil
		for aP, aQ in pairs(workspace:GetDescendants()) do
			if aQ:IsA'BasePart' and aQ.Name == 'pinata' then
				if not isTeammateSpy(aQ) then
					local aR = aQ:GetAttribute'PlacedByUserId' or aQ:GetAttribute'PlacerId'
					if aR then
						local aS, aT = aH:GetPlayerByUserId(aR), getCandyAmount(aQ)
						aN[aQ] = {
							player = aS,
							lastCandy = aT,
							exists = true,
							placedTime = tick()
						}
					end
				end
			end
		end
		ar:Clean(workspace.DescendantAdded:Connect(function(aP)
			if not aC.Enabled then
				return
			end
			if aP:IsA'BasePart' and aP.Name == 'pinata' then
				task.wait(0.2)
				if not isTeammateSpy(aP) then
					local aQ = aP:GetAttribute'PlacedByUserId' or aP:GetAttribute'PlacerId'
					if aQ then
						local aR, aS = aH:GetPlayerByUserId(aQ), getCandyAmount(aP)
						aN[aP] = {
							player = aR,
							lastCandy = aS,
							exists = true,
							placedTime = tick()
						}
					end
				end
			end
		end))
		ar:Clean(O.Client:Get'PiggyBankPop':Connect(function(aP)
			if not aC.Enabled then
				return
			end
			local aQ = aP.awardedPlayer
			if not aQ then
				return
			end
			if aD.Enabled then
				if aQ == aI or (aQ.Team and aQ.Team == aI.Team) then
					return
				end
			end
			local aR, aS, aT, aU = aO:getRewardsFromCoins(aP.coins), 0, 0, 0
			for aV, aW in ipairs(aR) do
				if aW.itemType == 'iron' then
					aS = aS + (aW.amount or 0)
				elseif aW.itemType == 'diamond' then
					aT = aT + (aW.amount or 0)
				elseif aW.itemType == 'emerald' then
					aU = aU + (aW.amount or 0)
				end
			end
			local aV, aW, aX = getPlayerName(aQ), getTeamName(aQ), string.format('%d irons, %d diamonds, %d emeralds', aS, aT, aU)
			v:CreateNotification('Lucia Spy', string.format('%s (%s) opened their pinata and got %s', aV, aW, aX), 8)
			for aY, aZ in pairs(aN) do
				if aZ.player and aZ.player.UserId == aQ.UserId then
					aN[aY] = nil
				end
			end
		end))
		local aP = 0
		ar:Clean(aG.Heartbeat:Connect(function()
			if not aC.Enabled then
				return
			end
			aP = aP + 1
			if aP % 6 ~= 0 then
				return
			end
			local aQ = {}
			for aR, aS in pairs(aN) do
				if aR and aR.Parent then
					local aT = getCandyAmount(aR)
					if aT ~= aS.lastCandy then
						local aU = aT - aS.lastCandy
						if aU > 0 and aS.player then
							local aV, aW = getPlayerName(aS.player), getTeamName(aS.player)
							v:CreateNotification('Lucia Spy', string.format('%s (%s) has just deposited %d candy and now has %d candy', aV, aW, aU, aT), 5)
						end
						aS.lastCandy = aT
					end
				else
					if aS.exists and aS.player then
						local aT = tick() - (aS.placedTime or tick())
						if aT > 2 then
							local aU, aV = getPlayerName(aS.player), getTeamName(aS.player)
							v:CreateNotification('Lucia Spy', string.format('%s (%s) has just broken their pinata with %d candy', aU, aV, aS.lastCandy), 5)
						end
					end
					table.insert(aQ, aR)
				end
			end
			for aR, aS in ipairs(aQ) do
				aN[aS] = nil
			end
		end))
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoLucia',
		Function = function(aO)
			if aO then
				if ay.Enabled then
					findExistingPinatas()
					ar:Clean(workspace.DescendantAdded:Connect(function(aP)
						if ar.Enabled and aP:IsA'BasePart' and aP.Name == 'pinata' then
							task.wait(0.1)
							if not isTeammateESP(aP) then
								Added(aP)
							end
						end
					end))
					ar:Clean(workspace.DescendantRemoving:Connect(function(aP)
						if aP:IsA'BasePart' and aP.Name == 'pinata' and aK[aP] then
							Removed(aP)
						end
					end))
					local aP = 0
					ar:Clean(aG.Heartbeat:Connect(function()
						if not ar.Enabled or not ay.Enabled then
							return
						end
						aP = aP + 1
						if aP % 6 ~= 0 then
							return
						end
						for aQ, aR in pairs(aK) do
							if aQ and aQ.Parent then
								updateCandyDisplay(aQ)
							else
								if aR.billboard then
									aR.billboard:Destroy()
								end
								aK[aQ] = nil
							end
						end
					end))
				end
				if au.Enabled then
					task.spawn(function()
						local aP = av.Value
						kitCollection(aI.Name .. ':pinata', function(aQ)
							if getItem'candy' then
								O.Client:Get(P.DepositCoins):CallServer(aQ)
							end
						end, aP, true)
					end)
				end
				if aC.Enabled then
					setupLuciaSpy()
				end
			else
				aJ:ClearAllChildren()
				table.clear(aK)
				table.clear(aM)
				table.clear(aN)
			end
		end,
		Tooltip = 'Lucia (Pinata) Kit Module'
	}
	au = ar:CreateToggle{
		Name = 'Auto Deposit',
		Default = false,
		Tooltip = 'Automatically deposit candies into your pinata',
		Function = function(aO)
			if av and av.Object then
				av.Object.Visible = aO
			end
			if aw and aw.Object then
				aw.Object.Visible = aO
			end
			if ax and ax.Object then
				ax.Object.Visible = (aO and aw.Enabled)
			end
			if not aO then
				if ax and ax.Object then
					ax.Object.Visible = false
				end
			else
				if aw and aw.Enabled then
					if ax and ax.Object then
						ax.Object.Visible = true
					end
				end
			end
		end
	}
	av = ar:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 18,
		Default = 8,
		Suffix = ' studs',
		Visible = false
	}
	aw = ar:CreateToggle{
		Name = 'Delay',
		Default = false,
		Visible = false,
		Function = function(aO)
			if ax and ax.Object then
				ax.Object.Visible = aO
			end
		end
	}
	ax = ar:CreateSlider{
		Name = 'Delay Amount',
		Min = 0,
		Max = 2,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Visible = false
	}
	ay = ar:CreateToggle{
		Name = 'Pinata ESP',
		Tooltip = 'Shows pinata locations',
		Function = function(aO)
			if az and az.Object then
				az.Object.Visible = aO
			end
			if aA and aA.Object then
				aA.Object.Visible = aO
			end
			if aB and aB.Object then
				aB.Object.Visible = aO
			end
			if aF and aF.Object then
				aF.Object.Visible = aO
			end
			if not aO then
				if aF and aF.Object then
					aF.Object.Visible = false
				end
			else
				if aB and aB.Enabled then
					if aF and aF.Object then
						aF.Object.Visible = true
					end
				end
			end
			if ar.Enabled then
				if aO then
					findExistingPinatas()
				else
					aJ:ClearAllChildren()
					table.clear(aK)
				end
			end
		end
	}
	az = ar:CreateToggle{
		Name = 'Candy ESP',
		Visible = false,
		Tooltip = 'Shows candy amount in pinatas',
		Function = function(aO)
			for aP in pairs(aK) do
				updateCandyDisplay(aP)
			end
		end
	}
	aA = ar:CreateToggle{
		Name = 'Ignore Teammates',
		Visible = false,
		Tooltip = 'Hide ESP for teammates',
		Function = function(aO)
			if ar.Enabled and ay.Enabled then
				refreshESP()
			end
		end
	}
	aB = ar:CreateToggle{
		Name = 'Background',
		Visible = false,
		Function = function(aO)
			if aF and aF.Object then
				aF.Object.Visible = aO
			end
			for aP, aQ in pairs(aK) do
				if aQ.frame then
					aQ.frame.BackgroundTransparency = 1 - (aO and aF.Opacity or 0)
					if aQ.billboard.Blur then
						aQ.billboard.Blur.Visible = aO
					end
				end
			end
		end
	}
	aF = ar:CreateColorSlider{
		Name = 'Background Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Visible = false,
		Function = function(aO, aP, aQ, aR)
			aF.Hue = aO
			aF.Sat = aP
			aF.Value = aQ
			aF.Opacity = aR
			for aS, aT in pairs(aK) do
				if aT.frame then
					aT.frame.BackgroundColor3 = Color3.fromHSV(aO, aP, aQ)
					aT.frame.BackgroundTransparency = 1 - aR
				end
			end
		end,
		Darker = true
	}
	aC = ar:CreateToggle{
		Name = 'Lucia Spy',
		Default = false,
		Tooltip = 'Notifies when players deposit, break, or open pinatas',
		Function = function(aO)
			if aD and aD.Object then
				aD.Object.Visible = aO
			end
			if aE and aE.Object then
				aE.Object.Visible = aO
			end
			if ar.Enabled and aO then
				setupLuciaSpy()
			else
				table.clear(aN)
			end
		end
	}
	aD = ar:CreateToggle{
		Name = 'Ignore Teammates',
		Default = true,
		Visible = false
	}
	aE = ar:CreateToggle{
		Name = 'Display Name',
		Default = false,
		Visible = false,
		Tooltip = 'Show display names instead of usernames'
	}
	task.defer(function()
		if av and av.Object then
			av.Object.Visible = false
		end
		if aw and aw.Object then
			aw.Object.Visible = false
		end
		if ax and ax.Object then
			ax.Object.Visible = false
		end
		if az and az.Object then
			az.Object.Visible = false
		end
		if aA and aA.Object then
			aA.Object.Visible = false
		end
		if aB and aB.Object then
			aB.Object.Visible = false
		end
		if aF and aF.Object then
			aF.Object.Visible = false
		end
		if aD and aD.Object then
			aD.Object.Visible = false
		end
		if aE and aE.Object then
			aE.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax
	local function getRemote()
		if not au then
			au = O.Client:Get(P.UpgradeFrostyHammer).instance
		end
		return au
	end
	local function hasFrostyHammer()
		if not L or not L.inventory then
			return false
		end
		local ay, az = pcall(function()
			return L.inventory.inventory.items
		end)
		if not ay or not az then
			return false
		end
		for aA, aB in pairs(az) do
			if aB and aB.itemType == 'frosty_hammer' then
				return true
			end
		end
		return false
	end
	local function doUpgrade(ay)
		local az = getRemote()
		if not az then
			return nil
		end
		local aA, aB = pcall(function()
			return az:InvokeServer(ay)
		end)
		if aA then
			return aB
		end
		return nil
	end
	local function getCurrentLevels()
		local ay = doUpgrade'shield'
		if type(ay) == 'table' then
			return {
				shield = ay.shield or 0,
				speed = ay.speed or 0,
				strength = ay.strength or 0
			}
		end
		return nil
	end
	local ay, az = {
		['Shield First'] = {
			'Shield',
			'Shield',
			'Shield',
			'Speed',
			'Speed',
			'Speed',
			'Strength',
			'Strength',
			'Strength'
		},
		['Speed First'] = {
			'Speed',
			'Speed',
			'Speed',
			'Shield',
			'Shield',
			'Shield',
			'Strength',
			'Strength',
			'Strength'
		},
		['Strength First'] = {
			'Strength',
			'Strength',
			'Strength',
			'Shield',
			'Shield',
			'Shield',
			'Speed',
			'Speed',
			'Speed'
		},
		['Balanced (1 each)'] = {
			'Shield',
			'Speed',
			'Strength'
		}
	}, {
		Shield = 'shield',
		Speed = 'speed',
		Strength = 'strength'
	}
	local function runUpgradeLoop()
		if not hasFrostyHammer() then
			notif('AutoAdetunde', 'No Frosty Hammer in inventory!', 3)
			if ar.Enabled then
				ar:Toggle()
			end
			return
		end
		local aA = av and av.Value or 'Balanced (1 each)'
		local aB, aC, aD = ay[aA], aw and aw.Value or 0.15, getCurrentLevels()
		if not aD then
			notif('AutoAdetunde', 'Failed to read upgrade levels!', 3)
			if ar.Enabled then
				ar:Toggle()
			end
			return
		end
		repeat
			for aE, aF in ipairs(aB) do
				if not ar.Enabled then
					break
				end
				local aG = az[aF]
				local aH = aD[aG] or 0
				if aH >= 3 then
					continue
				end
				local aI = doUpgrade(aG)
				if type(aI) == 'table' then
					aD.shield = aI.shield or aD.shield
					aD.speed = aI.speed or aD.speed
					aD.strength = aI.strength or aD.strength
				else
					task.wait(0.5)
				end
				task.wait(aC)
			end
			local aE = (aD.shield or 0) >= 3 and (aD.speed or 0) >= 3 and (aD.strength or 0) >= 3
			if aE then
				notif('AutoAdetunde', ('Done! Shield %d/3 | Speed %d/3 | Strength %d/3'):format(aD.shield, aD.speed, aD.strength), 6)
				ar:Toggle()
				return
			end
			task.wait(0.2)
		until not ar.Enabled
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoAdetunde',
		Function = function(aA)
			if aA then
				if ax then
					task.cancel(ax)
					ax = nil
				end
				ax = task.spawn(runUpgradeLoop)
			else
				if ax then
					task.cancel(ax)
					ax = nil
				end
			end
		end,
		Tooltip = 'Auto upgrades your Frosty Hammer \u{2014} just toggle on and go!'
	}
	av = ar:CreateDropdown{
		Name = 'Upgrade Order',
		List = {
			'Shield First',
			'Speed First',
			'Strength First',
			'Balanced (1 each)'
		},
		Default = 'Balanced (1 each)',
		Tooltip = 'Which stat to focus on first',
		Function = function()
		end
	}
	aw = ar:CreateSlider{
		Name = 'Speed',
		Min = 0.05,
		Max = 1,
		Default = 0.15,
		Decimal = 100,
		Suffix = 's',
		Tooltip = 'Lower = faster upgrades. 0.05s is nearly instant, 1s is slow'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay = nil, nil, nil, nil, nil, {
		FLAMETHROWER = 'flamethrower'
	}
	local function getRemote()
		if not au then
			au = O.Client:Get(P.UpgradeFlamethrower).instance
		end
		return au
	end
	local function hasFlamethrower()
		if L and L.inventory and L.inventory.inventory then
			local az, aA = pcall(function()
				return L.inventory.inventory.items
			end)
			if az and aA then
				for aB, aC in pairs(aA) do
					if aC and aC.itemType == ay.FLAMETHROWER then
						return true
					end
				end
			end
		end
		local az, aA = pcall(require, game:GetService'ReplicatedStorage':WaitForChild'TS':WaitForChild'inventory':WaitForChild'inventory-util')
		if az and aA and aA.getToolFromInventory then
			local aB = e
			local aC = aA.getToolFromInventory(aB.LocalPlayer, ay.FLAMETHROWER)
			return aC ~= nil
		end
		return false
	end
	local function getCurrentLevels()
		if L and L.inventory and L.inventory.inventory then
			local az, aA = pcall(function()
				return L.inventory.inventory.items
			end)
			if az and aA then
				for aB, aC in pairs(aA) do
					if aC and aC.itemType == ay.FLAMETHROWER and aC.tool then
						local aD = aC.tool
						return {
							range = aD:GetAttribute'range' or 0,
							heat = aD:GetAttribute'heat' or 0,
							power = aD:GetAttribute'power' or 0
						}
					end
				end
			end
		end
		local az, aA = pcall(require, game:GetService'ReplicatedStorage':WaitForChild'TS':WaitForChild'inventory':WaitForChild'inventory-util')
		if az and aA and aA.getToolFromInventory then
			local aB = e
			local aC = aA.getToolFromInventory(aB.LocalPlayer, ay.FLAMETHROWER)
			if aC then
				return {
					range = aC:GetAttribute'range' or 0,
					heat = aC:GetAttribute'heat' or 0,
					power = aC:GetAttribute'power' or 0
				}
			end
		end
		return nil
	end
	local function doUpgrade(az)
		local aA = getRemote()
		if not aA then
			return nil
		end
		local aB, aC = pcall(function()
			return aA:InvokeServer(az)
		end)
		if aB and type(aC) == 'table' then
			return aC
		end
		return nil
	end
	local az, aA = {
		Range = 'range',
		Heat = 'heat',
		Power = 'power'
	}, {
		['Range First'] = {
			'Range',
			'Range',
			'Range',
			'Heat',
			'Heat',
			'Heat',
			'Power',
			'Power',
			'Power'
		},
		['Heat First'] = {
			'Heat',
			'Heat',
			'Heat',
			'Range',
			'Range',
			'Range',
			'Power',
			'Power',
			'Power'
		},
		['Power First'] = {
			'Power',
			'Power',
			'Power',
			'Range',
			'Range',
			'Range',
			'Heat',
			'Heat',
			'Heat'
		},
		['Balanced (1 each)'] = {
			'Range',
			'Heat',
			'Power'
		}
	}
	local function runUpgradeLoop()
		if not hasFlamethrower() then
			notif('AutoPyro', 'no flamethrower in inventory', 3)
			if ar.Enabled then
				ar:Toggle()
			end
			return
		end
		local aB = av and av.Value or 'Range \u{2192} Heat \u{2192} Power'
		local aC, aD, aE, aF = aA[aB] or {
			'Range',
			'Heat',
			'Power'
		}, {
			Range = 3,
			Heat = 3,
			Power = 3
		}, aw and aw.Value or 0.15, getCurrentLevels()
		if not aF then
			notif('AutoPyro', 'Failed to read upgrade levels!', 3)
			if ar.Enabled then
				ar:Toggle()
			end
			return
		end
		local aG = {}
		for aH, aI in pairs(aD) do
			if aI > 0 then
				table.insert(aG, aH)
			end
		end
		if # aG == 0 then
			notif('AutoPyro', 'All step counts are zero \u{2013} nothing to upgrade!', 3)
			if ar.Enabled then
				ar:Toggle()
			end
			return
		end
		repeat
			for aH, aI in ipairs(aC) do
				if not ar.Enabled then
					break
				end
				local aJ = aD[aI]
				if aJ == 0 then
					continue
				end
				local aK = az[aI]
				local aM, aN = aF[aK] or 0, 3
				local aO = aN - aM
				if aO <= 0 then
					continue
				end
				local aP = math.min(aJ, aO)
				for aQ = 1, aP do
					if not ar.Enabled then
						break
					end
					local aR = doUpgrade(aK)
					if type(aR) == 'table' then
						aF.range = aR.range or aF.range
						aF.heat = aR.heat or aF.heat
						aF.power = aR.power or aF.power
					else
						task.wait(0.5)
						break
					end
					task.wait(aE)
				end
			end
			local aH = true
			for aI, aJ in ipairs(aG) do
				local aK = az[aJ]
				if (aF[aK] or 0) < 3 then
					aH = false
					break
				end
			end
			if aH then
				local aI, aJ, aK = aF.range or 0, aF.heat or 0, aF.power or 0
				notif('AutoPyro', ('Done Range %d/3 | Heat %d/3 | Power %d/3'):format(aI, aJ, aK), 6)
				ar:Toggle()
				return
			end
		until not ar.Enabled
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoPyro',
		Function = function(aB)
			if aB then
				if ax then
					task.cancel(ax)
					ax = nil
				end
				ax = task.spawn(runUpgradeLoop)
			else
				if ax then
					task.cancel(ax)
					ax = nil
				end
			end
		end,
		Tooltip = 'Auto upgrades Flamethrower with simple priority & step control'
	}
	av = ar:CreateDropdown{
		Name = 'Upgrade Order',
		List = {
			'Range First',
			'Heat First',
			'Power First',
			'Balanced (1 each)'
		},
		Default = 'Range First',
		Tooltip = 'Which stat to max out first',
		Function = function()
		end
	}
	aw = ar:CreateSlider{
		Name = 'Speed',
		Min = 0.05,
		Max = 1,
		Default = 0.15,
		Decimal = 100,
		Suffix = 's',
		Tooltip = 'Lower = faster upgrades (0.05s is instant, 1s is slow)'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aM, aN, aO, aP, aQ, aR, aS = false, false, false, false, 30
	pcall(function()
		local aT, aU = require(game:GetService'ReplicatedStorage':WaitForChild'rbxts_include':WaitForChild'RuntimeLib'), game:GetService'ReplicatedStorage':WaitForChild'TS':WaitForChild'status-effect'
		aR = aT.import(script, aU, 'status-effect-util').StatusEffectUtil
		aS = aT.import(script, aU, 'status-effect-type').StatusEffectType
		local aV = aT.import(script, game:GetService'ReplicatedStorage':WaitForChild'TS':WaitForChild'kit':WaitForChild'oasis':WaitForChild'oasis-constants')
		if aV and aV.OasisBalance then
			ax = aV.OasisBalance.MaxBuffStacks or 30
		end
	end)
	local function getBuffStacks(aT)
		if aT and aT.Character then
			local aU = aT.Character:GetAttribute'StatusEffect_oasis_buff_charge_stacks'
			if aU and aU > 0 then
				return aU
			end
		end
		if aR and aS and aT and aT.Character then
			local aU, aV = pcall(function()
				return aR:getStacks(aT.Character, aS.OASIS_BUFF_CHARGE)
			end)
			if aU and aV then
				return aV
			end
		end
		if aT and aT.Character then
			local aU = aT.Character:GetAttribute'OasisBuffStacks' or 0
			return aU
		end
		return 0
	end
	local function getRemote()
		if aN then
			return aN
		end
		pcall(function()
			aN = game:GetService'ReplicatedStorage':WaitForChild'rbxts_include':WaitForChild'node_modules':WaitForChild'@rbxts':WaitForChild'net':WaitForChild'out':WaitForChild'_NetManaged':WaitForChild'AttemptFireOasisProjectiles'
		end)
		return aN
	end
	local function fireProjectile(aT, aU)
		if not aT or not aT.Character then
			return false
		end
		local aV = getRemote()
		if not aV then
			return false
		end
		local aW = pcall(function()
			O.Client:Get(P.AttemptFireOasisProjectiles).instance:InvokeServer(aT.UserId, aU)
		end)
		return aW
	end
	local function useHealVeil()
		if O.AbilityController and O.AbilityController:canUseAbility'oasis_heal_veil' then
			O.AbilityController:useAbility'oasis_heal_veil'
			return true
		end
		return false
	end
	local function updateProjectilesUI()
		local aT = aD.Enabled
		if aE and aE.Object then
			aE.Object.Visible = aT
			if aF and aF.Object then
				aF.Object.Visible = aT and aE.Enabled
			end
			if aG and aG.Object then
				aG.Object.Visible = aT and aE.Enabled
			end
			if aH and aH.Object then
				aH.Object.Visible = aT and aE.Enabled
				if aI and aI.Object then
					aI.Object.Visible = aT and aE.Enabled and aH.Enabled
				end
			end
		end
		if aJ and aJ.Object then
			aJ.Object.Visible = aT
			if aK and aK.Object then
				aK.Object.Visible = aT and aJ.Enabled
			end
			if aM and aM.Object then
				aM.Object.Visible = aT and aJ.Enabled
			end
		end
	end
	ay = v.Categories.Kits:CreateModule{
		Name = 'AutoNahila',
		Function = function(aT)
			ar = aT
			if aT then
				if az.Enabled then
					au = true
					aQ = task.spawn(function()
						while au and az.Enabled do
							if B.isAlive then
								local aU, aV = getTeammates(), false
								for aW, aX in ipairs(aU) do
									if aX.Character and aX.Character.PrimaryPart then
										local aY = (aX.Character.PrimaryPart.Position - B.character.RootPart.Position).Magnitude
										if aY <= aA.Value then
											local aZ = getPlayerHealthPercent(aX)
											if aZ < aB.Value then
												aV = true
												break
											end
										end
									end
								end
								if aV then
									useHealVeil()
									task.wait(aC.Value)
								else
									task.wait(0.5)
								end
							else
								task.wait(0.5)
							end
						end
						au = false
					end)
				end
				if aD.Enabled and aE.Enabled then
					av = true
					aO = task.spawn(function()
						while av and aD.Enabled and aE.Enabled do
							if B.isAlive then
								local aU = getNearestTeammateInRange(aF.Value, function(aU)
									if aH.Enabled then
										return getPlayerHealthPercent(aU) < aI.Value
									end
									return true
								end)
								if aU then
									fireProjectile(aU, 0)
								end
							end
							task.wait(aG.Value)
						end
						av = false
					end)
				end
				if aD.Enabled and aJ.Enabled then
					aw = true
					aP = task.spawn(function()
						while aw and aD.Enabled and aJ.Enabled do
							if B.isAlive then
								local aU = getNearestTeammateInRange(aK.Value, function(aU)
									local aV = getBuffStacks(aU)
									return aV < ax
								end)
								if aU then
									fireProjectile(aU, 1)
								end
							end
							task.wait(aM.Value)
						end
						aw = false
					end)
				end
				updateProjectilesUI()
				ay:Clean(function()
					au = false
					av = false
					aw = false
					if aQ then
						task.cancel(aQ)
					end
					if aO then
						task.cancel(aO)
					end
					if aP then
						task.cancel(aP)
					end
				end)
			else
				au = false
				av = false
				aw = false
				if aQ then
					task.cancel(aQ)
				end
				if aO then
					task.cancel(aO)
				end
				if aP then
					task.cancel(aP)
				end
			end
		end,
		Tooltip = 'Automatically use Oasis abilities: Heal Veil and projectiles (Heal/Buff).'
	}
	az = ay:CreateToggle{
		Name = 'Auto Heal (Oasis)',
		Default = false,
		Function = function(aT)
			if aA and aA.Object then
				aA.Object.Visible = aT
			end
			if aB and aB.Object then
				aB.Object.Visible = aT
			end
			if aC and aC.Object then
				aC.Object.Visible = aT
			end
			if ay.Enabled then
				if aT then
					au = true
					aQ = task.spawn(function()
						while au and az.Enabled do
							if B.isAlive then
								local aU, aV = getTeammates(), false
								for aW, aX in ipairs(aU) do
									if aX.Character and aX.Character.PrimaryPart then
										local aY = (aX.Character.PrimaryPart.Position - B.character.RootPart.Position).Magnitude
										if aY <= aA.Value then
											local aZ = getPlayerHealthPercent(aX)
											if aZ < aB.Value then
												aV = true
												break
											end
										end
									end
								end
								if aV then
									useHealVeil()
									task.wait(aC.Value)
								else
									task.wait(0.5)
								end
							else
								task.wait(0.5)
							end
						end
						au = false
					end)
				else
					au = false
					if aQ then
						task.cancel(aQ)
					end
				end
			end
		end,
		Tooltip = 'Automatically use Oasis Heal Veil when teammates are low.'
	}
	aA = ay:CreateSlider{
		Name = 'Heal Veil Range',
		Min = 1,
		Max = 30,
		Default = 15,
		Suffix = ' studs',
		Tooltip = 'Range to check for teammates needing heal.',
		Visible = false
	}
	aB = ay:CreateSlider{
		Name = 'Heal Threshold',
		Min = 1,
		Max = 100,
		Default = 50,
		Suffix = '%',
		Tooltip = "Use Heal Veil when any teammate's HP is below this.",
		Visible = false
	}
	aC = ay:CreateSlider{
		Name = 'Heal Cooldown',
		Min = 5,
		Max = 60,
		Default = 30,
		Suffix = 's',
		Tooltip = 'Time between Heal Veil uses.',
		Visible = false
	}
	aD = ay:CreateToggle{
		Name = 'Shoot Projectiles',
		Default = false,
		Function = function(aT)
			updateProjectilesUI()
			if ay.Enabled then
				if aT then
					if aE.Enabled then
						av = true
						aO = task.spawn(function()
							while av and aD.Enabled and aE.Enabled do
								if B.isAlive then
									local aU = getNearestTeammateInRange(aF.Value, function(aU)
										if aH.Enabled then
											return getPlayerHealthPercent(aU) < aI.Value
										end
										return true
									end)
									if aU then
										fireProjectile(aU, 0)
									end
								end
								task.wait(aG.Value)
							end
							av = false
						end)
					end
					if aJ.Enabled then
						aw = true
						aP = task.spawn(function()
							while aw and aD.Enabled and aJ.Enabled do
								if B.isAlive then
									local aU = getNearestTeammateInRange(aK.Value, function(aU)
										local aV = getBuffStacks(aU)
										return aV < ax
									end)
									if aU then
										fireProjectile(aU, 1)
									end
								end
								task.wait(aM.Value)
							end
							aw = false
						end)
					end
				else
					av = false
					aw = false
					if aO then
						task.cancel(aO)
					end
					if aP then
						task.cancel(aP)
					end
				end
			end
		end,
		Tooltip = 'Enable projectile shooting.'
	}
	aE = ay:CreateToggle{
		Name = 'Heal',
		Default = true,
		Function = function(aT)
			updateProjectilesUI()
			if ay.Enabled and aD.Enabled then
				if aT and not av then
					av = true
					aO = task.spawn(function()
						while av and aD.Enabled and aE.Enabled do
							if B.isAlive then
								local aU = getNearestTeammateInRange(aF.Value, function(aU)
									if aH.Enabled then
										return getPlayerHealthPercent(aU) < aI.Value
									end
									return true
								end)
								if aU then
									fireProjectile(aU, 0)
								end
							end
							task.wait(aG.Value)
						end
						av = false
					end)
				elseif not aT and av then
					av = false
					if aO then
						task.cancel(aO)
					end
				end
			end
		end,
		Tooltip = 'Shoot healing projectiles.',
		Visible = false
	}
	aF = ay:CreateSlider{
		Name = 'Heal Range',
		Min = 1,
		Max = 30,
		Default = 20,
		Suffix = ' studs',
		Tooltip = 'Max distance to target for healing.',
		Visible = false
	}
	aG = ay:CreateSlider{
		Name = 'Heal Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.4,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay between heal shots.',
		Visible = false
	}
	aH = ay:CreateToggle{
		Name = 'HP Threshold',
		Default = true,
		Function = function(aT)
			updateProjectilesUI()
		end,
		Tooltip = 'Only shoot heal if teammate HP below threshold.',
		Visible = false
	}
	aI = ay:CreateSlider{
		Name = 'Heal HP %',
		Min = 1,
		Max = 100,
		Default = 70,
		Suffix = '%',
		Tooltip = 'Shoot heal when teammate HP below this.',
		Visible = false
	}
	aJ = ay:CreateToggle{
		Name = 'Buff',
		Default = true,
		Function = function(aT)
			updateProjectilesUI()
			if ay.Enabled and aD.Enabled then
				if aT and not aw then
					aw = true
					aP = task.spawn(function()
						while aw and aD.Enabled and aJ.Enabled do
							if B.isAlive then
								local aU = getNearestTeammateInRange(aK.Value, function(aU)
									local aV = getBuffStacks(aU)
									return aV < ax
								end)
								if aU then
									fireProjectile(aU, 1)
								end
							end
							task.wait(aM.Value)
						end
						aw = false
					end)
				elseif not aT and aw then
					aw = false
					if aP then
						task.cancel(aP)
					end
				end
			end
		end,
		Tooltip = 'Shoot buff projectiles (stops at max stacks).',
		Visible = false
	}
	aK = ay:CreateSlider{
		Name = 'Buff Range',
		Min = 1,
		Max = 30,
		Default = 20,
		Suffix = ' studs',
		Tooltip = 'Max distance to target for buff.',
		Visible = false
	}
	aM = ay:CreateSlider{
		Name = 'Buff Delay',
		Min = 0.1,
		Max = 2,
		Default = 0.4,
		Decimal = 10,
		Suffix = 's',
		Tooltip = 'Delay between buff shots.',
		Visible = false
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI = {
		fire = 'damage_banner',
		defense = 'defense_banner',
		heal = 'heal_banner'
	}, {
		fire = 0,
		defense = 0,
		heal = 0
	}, false
	local function getBannerSlot(aJ)
		for aK, aM in L.inventory.hotbar do
			if aM.item and aM.item.itemType and aM.item.itemType:find(aJ) then
				return aK - 1, aM.item
			end
		end
		return nil, nil
	end
	local function isBannerPlaced(aJ)
		local aK = B.isAlive and B.character.RootPart
		if not aK then
			return false
		end
		local aM, aN = aK.Position, l:GetTagged(aJ)
		for aO, aP in ipairs(aN) do
			if aP:IsA'BasePart' then
				local aQ = aP:GetAttribute'PlacedByUserId'
				local aR = (aQ == nil) or (aQ == t.UserId)
				if aR and (aP.Position - aM).Magnitude < 80 then
					return true
				end
			end
		end
		return false
	end
	local function placeBanner(aJ)
		if not B.isAlive or av then
			return false
		end
		local aK = B.character.RootPart
		if not aK then
			return false
		end
		local aM, aN = ar[aJ], aJ == 'fire' and 'damage' or aJ
		local aO, aP = getBannerSlot(aN)
		if ax.Enabled and not aP then
			return false
		end
		if not aO then
			return false
		end
		local aQ = roundPos(aK.Position)
		if getPlacedBlock(aQ) then
			return false
		end
		av = true
		local aR = L.inventory.hotbarSlot
		if aI.Enabled then
			if hotbarSwitch(aO) then
				task.wait(0.03)
				local aS = pcall(function()
					O.placeBlock(aQ, aM, false)
				end)
				if aS then
					au[aJ] = tick()
				end
				task.wait(0.03)
				hotbarSwitch(aR)
			end
		else
			local aS = pcall(function()
				O.placeBlock(aQ, aM, false)
			end)
			if aS then
				au[aJ] = tick()
			end
		end
		av = false
		return true
	end
	local function enemyInRange(aJ)
		if not B.isAlive then
			return false
		end
		local aK = B.character.RootPart
		if not aK then
			return false
		end
		for aM, aN in B.List do
			if aN.Targetable then
				if aN.Player and ay.Players.Enabled then
					if (aN.RootPart.Position - aK.Position).Magnitude <= aJ then
						return true
					end
				end
				if aN.NPC and ay.NPCs.Enabled then
					if (aN.RootPart.Position - aK.Position).Magnitude <= aJ then
						return true
					end
				end
			end
		end
		return false
	end
	local function getHP()
		if not B.isAlive then
			return 0, 100
		end
		local aJ, aK = t.Character:GetAttribute'Health' or 0, t.Character:GetAttribute'MaxHealth' or 100
		return aJ, aK
	end
	local function tick_update()
		if not B.isAlive or av then
			return
		end
		local aJ = tick()
		if aF.Enabled then
			local aK = getHP()
			local aM = aK <= aG.Value
			local aN = aM or (au.heal > 0 and aK < aG.Value * 1.5)
			if aM then
				if (aJ - au.heal) >= aH.Value then
					if not isBannerPlaced(ar.heal) then
						task.spawn(placeBanner, 'heal')
						return
					end
				end
			end
		end
		if az.Enabled then
			if (aJ - au.fire) >= aB.Value then
				if enemyInRange(aA.Value) then
					if not isBannerPlaced(ar.fire) then
						task.spawn(placeBanner, 'fire')
					end
				end
			end
		end
		if aC.Enabled then
			if (aJ - au.defense) >= aE.Value then
				if enemyInRange(aD.Value) then
					if not isBannerPlaced(ar.defense) then
						task.spawn(placeBanner, 'defense')
					end
				end
			end
		end
	end
	aw = v.Categories.Kits:CreateModule{
		Name = 'AutoConqueror',
		Tooltip = 'Automatically places banners for the Conqueror kit',
		Function = function(aJ)
			if aJ then
				av = false
				aw:Clean(g.Heartbeat:Connect(function()
					pcall(tick_update)
				end))
			else
				av = false
				au = {
					fire = 0,
					defense = 0,
					heal = 0
				}
			end
		end
	}
	ay = aw:CreateTargets{
		Players = true,
		NPCs = true,
		Function = function()
		end
	}
	ax = aw:CreateToggle{
		Name = 'Limit To Banners',
		Default = true,
		Tooltip = 'Only place a banner if you actually have it in your hotbar'
	}
	az = aw:CreateToggle{
		Name = 'Fire Banner',
		Default = false,
		Tooltip = 'Place a damage banner when an enemy is within range',
		Function = function(aJ)
			if aA and aA.Object then
				aA.Object.Visible = aJ
			end
			if aB and aB.Object then
				aB.Object.Visible = aJ
			end
		end
	}
	aA = aw:CreateSlider{
		Name = 'Fire Range',
		Min = 5,
		Max = 50,
		Default = 20,
		Decimal = 1,
		Suffix = 'st',
		Visible = false,
		Tooltip = 'Enemy must be within this range to trigger fire banner'
	}
	aB = aw:CreateSlider{
		Name = 'Fire Delay',
		Min = 0.5,
		Max = 30,
		Default = 5,
		Decimal = 1,
		Suffix = 's',
		Visible = false,
		Tooltip = 'Seconds to wait before placing fire banner again'
	}
	aC = aw:CreateToggle{
		Name = 'Defense Banner',
		Default = false,
		Tooltip = 'Place a defense banner when an enemy is within range',
		Function = function(aJ)
			if aD and aD.Object then
				aD.Object.Visible = aJ
			end
			if aE and aE.Object then
				aE.Object.Visible = aJ
			end
		end
	}
	aD = aw:CreateSlider{
		Name = 'Defense Range',
		Min = 5,
		Max = 50,
		Default = 20,
		Decimal = 1,
		Suffix = 'st',
		Visible = false,
		Tooltip = 'Enemy must be within this range to trigger defense banner'
	}
	aE = aw:CreateSlider{
		Name = 'Defense Delay',
		Min = 0.5,
		Max = 30,
		Default = 5,
		Decimal = 1,
		Suffix = 's',
		Visible = false,
		Tooltip = 'Seconds to wait before placing defense banner again'
	}
	aF = aw:CreateToggle{
		Name = 'Heal Banner',
		Default = false,
		Tooltip = 'Place a heal banner when your HP drops to or below the threshold',
		Function = function(aJ)
			if aG and aG.Object then
				aG.Object.Visible = aJ
			end
			if aH and aH.Object then
				aH.Object.Visible = aJ
			end
		end
	}
	aG = aw:CreateSlider{
		Name = 'Heal Threshold',
		Min = 1,
		Max = 100,
		Default = 60,
		Decimal = 1,
		Suffix = 'hp',
		Visible = false,
		Tooltip = 'Place heal banner when HP is at or below this value'
	}
	aH = aw:CreateSlider{
		Name = 'Heal Delay',
		Min = 0.5,
		Max = 30,
		Default = 8,
		Decimal = 1,
		Suffix = 's',
		Visible = false,
		Tooltip = 'Seconds to wait before placing heal banner again'
	}
	aI = aw:CreateToggle{
		Name = 'Auto Switch',
		Default = false,
		Tooltip = 'Instantly switch to banner, place it, then switch back to your weapon'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay
	local function isAboveVoid(az)
		local aA = RaycastParams.new()
		aA.FilterType = Enum.RaycastFilterType.Exclude
		aA.FilterDescendantsInstances = {
			B.character
		}
		local aB = workspace:Raycast(az, Vector3.new(0, - 500, 0), aA)
		return aB == nil
	end
	local function hasLineOfSight(az, aA, aB)
		local aC = RaycastParams.new()
		aC.FilterType = Enum.RaycastFilterType.Exclude
		aC.FilterDescendantsInstances = {
			B.character,
			aB
		}
		local aD = aA - az
		local aE = workspace:Raycast(az, aD, aC)
		return aE == nil
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoHannah',
		Tooltip = 'auto execute players',
		Function = function(az)
			if az then
				task.spawn(function()
					local aA = collection('HannahExecuteInteraction', ar)
					while ar.Enabled do
						task.wait(0.1)
						if not B.isAlive then
							continue
						end
						local aB = not ay.Enabled and B.EntityPosition{
							Range = aw.Value,
							Part = 'RootPart',
							Wallcheck = au.Walls.Enabled,
							Players = au.Players.Enabled,
							NPCs = au.NPCs.Enabled,
							Limit = 1,
							Sort = aa[av.Value]
						} or L.KillauraTarget
						if not aB or not aB.RootPart then
							continue
						end
						if ax.Enabled and isAboveVoid(aB.RootPart.Position) then
							continue
						end
						if not au.Walls.Enabled then
							local aC = B.character.RootPart
							if not hasLineOfSight(aC.Position, aB.RootPart.Position, aB) then
								continue
							end
						end
						local aC = B.character.RootPart.Position
						for aD, aE in aA do
							if not ar.Enabled then
								break
							end
							local aF = not aE:IsA'Model' and aE or aE.PrimaryPart
							if aF and (aF.Position - aC).Magnitude <= aw.Value then
								local aG = O.Client:Get(P.HannahPromptTrigger).instance:InvokeServer{
									user = t,
									victimEntity = aE
								}
								if aG then
									local aH = aE:FindFirstChild'Hannah Execution Icon'
									if aH then
										aH:Destroy()
									end
								end
							end
						end
					end
				end)
			end
		end
	}
	au = ar:CreateTargets{
		Players = true,
		Walls = false,
		NPCs = false
	}
	local az = {
		'Damage',
		'Distance'
	}
	for aA in aa do
		if not table.find(az, aA) then
			table.insert(az, aA)
		end
	end
	av = ar:CreateDropdown{
		Name = 'Sort',
		List = az
	}
	aw = ar:CreateSlider{
		Name = 'Distance',
		Min = 0,
		Max = 16,
		Default = 12,
		Suffix = 'studs'
	}
	ax = ar:CreateToggle{
		Name = 'Void',
		Tooltip = 'Will not execute a player if they are falling in the void',
		Default = true
	}
	ay = ar:CreateToggle{
		Name = 'Use KA Target',
		Default = false
	}
end)
a(function()
	local ar, au, av, aw, ax
	local function hasLineOfSight(ay, az, aA)
		local aB = RaycastParams.new()
		aB.FilterType = Enum.RaycastFilterType.Exclude
		aB.FilterDescendantsInstances = {
			B.character,
			aA
		}
		local aC = az - ay
		local aD = workspace:Raycast(ay, aC, aB)
		return aD == nil
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoNyx',
		Tooltip = 'pop abiltiy',
		Function = function(ay)
			if ay then
				repeat
					if not B.isAlive then
						task.wait(0.1)
						continue
					end
					if aw.Enabled then
						local az = t.Character and t.Character:FindFirstChild'Humanoid'
						if not az or (az.Health / az.MaxHealth) * 100 > ax.Value then
							task.wait(0.1)
							continue
						end
					end
					if O.AbilityController:canUseAbility'midnight' then
						local az = B.EntityPosition{
							Range = 30,
							Part = 'RootPart',
							Players = au.Players.Enabled,
							NPCs = au.NPCs.Enabled,
							Wallcheck = au.Walls.Enabled,
							Sort = aa.Distance
						}
						if az then
							if not au.Walls.Enabled then
								if not hasLineOfSight(B.character.RootPart.Position, az.RootPart.Position, az) then
									task.wait(0.1)
									continue
								end
							end
							task.wait(av.Value)
							O.AbilityController:useAbility'midnight'
							task.wait(0.5)
						end
					end
					task.wait(0.1)
				until not ar.Enabled
			end
		end
	}
	au = ar:CreateTargets{
		Players = true,
		Walls = false,
		NPCs = false
	}
	av = ar:CreateSlider{
		Name = 'Pop Delay',
		Min = 0,
		Max = 2,
		Default = 0,
		Suffix = 's',
		Decimal = 10
	}
	aw = ar:CreateToggle{
		Name = 'Health Activation',
		Tooltip = 'Only pop ability when health is at or below threshold',
		Default = false,
		Function = function()
			task.defer(function()
				if ax and ax.Object then
					ax.Object.Visible = aw.Enabled
				end
			end)
		end
	}
	ax = ar:CreateSlider{
		Name = 'Health %',
		Min = 1,
		Max = 99,
		Default = 20,
		Suffix = '%',
		Tooltip = 'Pop ability when health drops to or below this %'
	}
	task.defer(function()
		if ax and ax.Object then
			ax.Object.Visible = false
		end
	end)
end)
a(function()
	local ar, au, av, aw
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoWarden',
		Tooltip = 'Automatically collects souls',
		Function = function(ax)
			if ax then
				repeat
					if not B.isAlive then
						task.wait(0.1)
						continue
					end
					local ay, az = B.character.RootPart.Position, math.tan(math.rad(aw.Value / 2))
					for aA, aB in collection('jailor_soul', ar) do
						if not ar.Enabled then
							break
						end
						local aC = not aB:IsA'Model' and aB or aB.PrimaryPart
						if not aC then
							continue
						end
						local aD = (aC.Position - ay).Magnitude
						if aD > au.Value then
							continue
						end
						local aE = workspace.CurrentCamera
						local aF, aG = aE:WorldToViewportPoint(aC.Position)
						if aG then
							local aH, aI = aE.ViewportSize.X / 2, aE.ViewportSize.Y / 2
							local aJ, aK = (aF.X - aH) / aE.ViewportSize.X, (aF.Y - aI) / aE.ViewportSize.Y
							local aM = math.sqrt(aJ * aJ + aK * aK)
							if aM > az then
								continue
							end
						else
							continue
						end
						task.wait(av.Value)
						pcall(function()
							O.JailorController:collectEntity(t, aB, 'JailorSoul')
						end)
						task.wait(0.05)
					end
					task.wait(0.1)
				until not ar.Enabled
			end
		end
	}
	au = ar:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 50,
		Default = 20
	}
	av = ar:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0,
		Decimal = 10
	}
	aw = ar:CreateSlider{
		Name = 'FOV',
		Min = 1,
		Max = 360,
		Default = 360
	}
end)
a(function()
	local ar, au, av = {
		fish_iron = 'Iron Fish',
		fish_diamond = 'Diamond Fish',
		fish_emerald = 'Emerald Fish',
		fish_special = 'Special Fish',
		fish_gold = 'Gold Fish'
	}
	au = v.Categories.Kits:CreateModule{
		Name = 'FishermanSpy',
		Tooltip = 'notifys whenever a fisher has caught something',
		Function = function(aw)
			if aw then
				O.Client:WaitFor(P.FishCaught):andThen(function(ax)
					au:Clean(ax:Connect(function(ay)
						local az, aA = ay.catchingPlayer.Character, ay.dropData.fishModel
						local aB = az.Name
						local aC, aD = aB:sub(1, 1):upper() .. aB:sub(2) or 'NIL', ar[tostring(aA)] or 'NIL Fish'
						if av.Enabled then
							local aE, aF = t.Team, e:GetPlayerFromCharacter(az)
							if aF.Team == aE then
							else
								notif('FishermanSpy', "-481123266", 8)
							end
						else
							notif('FishermanSpy', "-481123266", 8)
						end
					end))
				end)
			end
		end
	}
	av = au:CreateToggle{
		Name = 'Ignore Teammates',
		Default = true
	}
end)
a(function()
	local ar, au, av, aw = c or function(ar)
		return ar
	end
	local ax, ay, az = ar(game:GetService'CollectionService'), ar(game:GetService'RunService'), ar(game:GetService'Players')
	local aA, aB = az.LocalPlayer, shared.vape
	local aC, aD = aB.Libraries.getcustomasset, Instance.new'Folder'
	aD.Parent = aB.gui
	local aE = {}
	local function addBlur(aF)
		local aG = Instance.new'ImageLabel'
		aG.Name = 'Blur'
		aG.Size = UDim2.new(1, 89, 1, 52)
		aG.Position = UDim2.fromOffset(- 48, - 31)
		aG.BackgroundTransparency = 1
		aG.Image = aC'newvape/assets/new/blur.png'
		aG.ScaleType = Enum.ScaleType.Slice
		aG.SliceCenter = Rect.new(52, 31, 261, 502)
		aG.Parent = aF
		return aG
	end
	local function isMyBeehive(aF)
		if not aF then
			return false
		end
		local aG = aF:GetAttribute'PlacedByUserId'
		return aG and aG == aA.UserId
	end
	local function getBeehiveOwnerName(aF)
		if not aF then
			return 'Unknown'
		end
		local aG = aF:GetAttribute'PlacedByUserId'
		if not aG then
			return 'Unknown'
		end
		local aH = az:GetPlayerByUserId(aG)
		if aH then
			return aH.Name
		end
		return 'Player'
	end
	local function AddedBeehive(aF)
		if isMyBeehive(aF) then
			return
		end
		if aE[aF] then
			return
		end
		local aG, aH, aI = aF:GetAttribute'Level' or 0, getBeehiveOwnerName(aF), Instance.new'BillboardGui'
		aI.Parent = aD
		aI.Name = 'beehive-spy'
		aI.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
		aI.Size = UDim2.fromOffset(120, 40)
		aI.AlwaysOnTop = true
		aI.ClipsDescendants = false
		aI.Adornee = aF
		local aJ = addBlur(aI)
		aJ.Visible = av and av.Enabled or true
		local aK, aM, aN, aO = 0, 0, 1, 0.5
		if aw then
			aK, aM, aN, aO = aw.Hue, aw.Sat, aw.Value, aw.Opacity
		end
		local aP = Instance.new'Frame'
		aP.Size = UDim2.fromScale(1, 1)
		aP.BackgroundColor3 = Color3.fromHSV(aK, aM, aN)
		aP.BackgroundTransparency = 1 - ((av and av.Enabled or true) and aO or 0)
		aP.BorderSizePixel = 0
		aP.Parent = aI
		local aQ = Instance.new'UICorner'
		aQ.CornerRadius = UDim.new(0, 6)
		aQ.Parent = aP
		local aR = Instance.new'TextLabel'
		aR.Name = 'OwnerName'
		aR.Size = UDim2.new(1, 0, 0.4, 0)
		aR.Position = UDim2.new(0, 0, 0, - 20)
		aR.BackgroundTransparency = 1
		aR.Text = aH
		aR.TextColor3 = Color3.fromRGB(255, 255, 255)
		aR.TextSize = 12
		aR.Font = Enum.Font.GothamBold
		aR.TextStrokeTransparency = 0.5
		aR.TextStrokeColor3 = Color3.new(0, 0, 0)
		aR.Parent = aI
		local aS = Instance.new'TextLabel'
		aS.Size = UDim2.fromOffset(20, 20)
		aS.Position = UDim2.new(0, 5, 0.5, 0)
		aS.AnchorPoint = Vector2.new(0, 0.5)
		aS.BackgroundTransparency = 1
		aS.Text = '\u{1f3d8}\u{fe0f}'
		aS.TextSize = 16
		aS.Parent = aP
		local aT = Instance.new'TextLabel'
		aT.Name = 'Level'
		aT.Size = UDim2.new(0, 25, 1, 0)
		aT.Position = UDim2.new(1, - 30, 0, 0)
		aT.BackgroundTransparency = 1
		aT.Text = tostring(aG)
		aT.TextColor3 = Color3.fromRGB(255, 255, 255)
		aT.TextSize = 16
		aT.Font = Enum.Font.GothamBold
		aT.TextStrokeTransparency = 0.5
		aT.TextStrokeColor3 = Color3.new(0, 0, 0)
		aT.Parent = aP
		aE[aF] = {
			billboard = aI,
			levelLabel = aT,
			frame = aP
		}
		au:Clean(aF:GetAttributeChangedSignal'Level':Connect(function()
			local aU = aE[aF]
			if aU and aU.levelLabel then
				aU.levelLabel.Text = tostring(aF:GetAttribute'Level' or 0)
			end
		end))
	end
	local function RemovedBeehive(aF)
		if aE[aF] then
			aE[aF].billboard:Destroy()
			aE[aF] = nil
		end
	end
	local function setupBeehiveSpy()
		for aF, aG in ax:GetTagged'beehive' do
			AddedBeehive(aG)
		end
		au:Clean(ax:GetInstanceAddedSignal'beehive':Connect(function(aF)
			task.wait(0.1)
			AddedBeehive(aF)
		end))
		au:Clean(ax:GetInstanceRemovedSignal'beehive':Connect(function(aF)
			RemovedBeehive(aF)
		end))
	end
	au = aB.Categories.Kits:CreateModule{
		Name = 'BeehiveSpy',
		Tooltip = "Shows enemy/other players' beehives with owner name and level (ignores your own)",
		Function = function(aF)
			if aF then
				setupBeehiveSpy()
			else
				aD:ClearAllChildren()
				table.clear(aE)
			end
		end
	}
	av = au:CreateToggle{
		Name = 'Background',
		Default = true,
		Function = function(aF)
			if aw and aw.Object then
				aw.Object.Visible = aF
			end
			for aG, aH in aE do
				if aH and aH.billboard then
					local aI, aJ = aH.billboard:FindFirstChild'Frame', aH.billboard:FindFirstChild'Blur'
					if aI then
						local aK = aw and aw.Opacity or 0.5
						aI.BackgroundTransparency = 1 - (aF and aK or 0)
					end
					if aJ then
						aJ.Visible = aF
					end
				end
			end
		end
	}
	aw = au:CreateColorSlider{
		Name = 'Color',
		DefaultValue = 0,
		DefaultOpacity = 0.5,
		Function = function(aF, aG, aH, aI)
			for aJ, aK in aE do
				if aK and aK.frame then
					aK.frame.BackgroundColor3 = Color3.fromHSV(aF, aG, aH)
					aK.frame.BackgroundTransparency = 1 - (av.Enabled and aI or 0)
				end
			end
		end,
		Darker = true
	}
	task.defer(function()
		if aw and aw.Object then
			aw.Object.Visible = av and av.Enabled or true
		end
	end)
end)
a(function()
	local ar, au, av, aw, ax = game:GetService'RunService', (game:GetService'Players')
	local ay, az, aA, aB = au.LocalPlayer, shared.vape, shared.bedwars or getgenv().bedwars, {}
	local function getPlayerName(aC)
		if ax and ax.Enabled then
			return aC.DisplayName ~= '' and aC.DisplayName or aC.Name
		end
		return aC.Name
	end
	local function getTeamName(aC)
		if aC.Team then
			return aC.Team.Name
		end
		return 'Unknown'
	end
	local function getCandyAmount(aC)
		return aC:GetAttribute'Coin' or 0
	end
	local function isTeammateSpy(aC)
		if not aw or not aw.Enabled then
			return false
		end
		local aD = aC:GetAttribute'PlacedByUserId' or aC:GetAttribute'PlacerId'
		if not aD then
			local aE = aC.Parent
			if aE then
				aD = aE:GetAttribute'PlacedByUserId' or aE:GetAttribute'PlacerId'
			end
		end
		if aD then
			if aD == ay.UserId then
				return true
			end
			local aE = au:GetPlayerByUserId(aD)
			if aE and aE.Team == ay.Team then
				return true
			end
		end
		return false
	end
	local function setupLuciaSpy()
		local aC = require(game:GetService'ReplicatedStorage'.TS.games.bedwars.kit.kits['piggy-bank']['piggy-bank-util']).PiggyBankUtil
		for aD, aE in pairs(workspace:GetDescendants()) do
			if aE:IsA'BasePart' and aE.Name == 'pinata' then
				if not isTeammateSpy(aE) then
					local aF = aE:GetAttribute'PlacedByUserId' or aE:GetAttribute'PlacerId'
					if aF then
						local aG, aH = au:GetPlayerByUserId(aF), getCandyAmount(aE)
						aB[aE] = {
							player = aG,
							lastCandy = aH,
							exists = true,
							placedTime = tick()
						}
					end
				end
			end
		end
		av:Clean(workspace.DescendantAdded:Connect(function(aD)
			if not av.Enabled then
				return
			end
			if aD:IsA'BasePart' and aD.Name == 'pinata' then
				task.wait(0.2)
				if not isTeammateSpy(aD) then
					local aE = aD:GetAttribute'PlacedByUserId' or aD:GetAttribute'PlacerId'
					if aE then
						local aF = au:GetPlayerByUserId(aE)
						aB[aD] = {
							player = aF,
							lastCandy = getCandyAmount(aD),
							exists = true,
							placedTime = tick()
						}
					end
				end
			end
		end))
		av:Clean(aA.Client:Get'PiggyBankPop':Connect(function(aD)
			if not av.Enabled then
				return
			end
			local aE = aD.awardedPlayer
			if not aE then
				return
			end
			if aw and aw.Enabled then
				if aE == ay or (aE.Team and aE.Team == ay.Team) then
					return
				end
			end
			local aF, aG, aH, aI = aC:getRewardsFromCoins(aD.coins), 0, 0, 0
			for aJ, aK in ipairs(aF) do
				if aK.itemType == 'iron' then
					aG = aG + (aK.amount or 0)
				elseif aK.itemType == 'diamond' then
					aH = aH + (aK.amount or 0)
				elseif aK.itemType == 'emerald' then
					aI = aI + (aK.amount or 0)
				end
			end
			local aJ, aK, aM = getPlayerName(aE), getTeamName(aE), string.format('%d irons, %d diamonds, %d emeralds', aG, aH, aI)
			az:CreateNotification('Lucia Spy', string.format('%s (%s) opened their pinata and got %s', aJ, aK, aM), 8)
			for aN, aO in pairs(aB) do
				if aO.player and aO.player.UserId == aE.UserId then
					aB[aN] = nil
				end
			end
		end))
		local aD = 0
		av:Clean(ar.Heartbeat:Connect(function()
			if not av.Enabled then
				return
			end
			aD = aD + 1
			if aD % 6 ~= 0 then
				return
			end
			local aE = {}
			for aF, aG in pairs(aB) do
				if aF and aF.Parent then
					local aH = getCandyAmount(aF)
					if aH ~= aG.lastCandy then
						local aI = aH - aG.lastCandy
						if aI > 0 and aG.player then
							local aJ, aK = getPlayerName(aG.player), getTeamName(aG.player)
							az:CreateNotification('Lucia Spy', string.format('%s (%s) deposited %d candy (now %d)', aJ, aK, aI, aH), 5)
						end
						aG.lastCandy = aH
					end
				else
					if aG.exists and aG.player then
						local aH = tick() - (aG.placedTime or tick())
						if aH > 2 then
							local aI, aJ = getPlayerName(aG.player), getTeamName(aG.player)
							az:CreateNotification('Lucia Spy', string.format('%s (%s) broke their pinata (had %d candy)', aI, aJ, aG.lastCandy), 5)
						end
					end
					table.insert(aE, aF)
				end
			end
			for aF, aG in ipairs(aE) do
				aB[aG] = nil
			end
		end))
	end
	av = az.Categories.Kits:CreateModule{
		Name = 'LuciaSpy',
		Tooltip = 'Notifies when players deposit, break, or open pinatas',
		Function = function(aC)
			if aC then
				setupLuciaSpy()
			else
				table.clear(aB)
			end
		end
	}
	aw = av:CreateToggle{
		Name = 'Ignore Teammates',
		Default = true,
		Tooltip = "Don't notify for teammates"
	}
	ax = av:CreateToggle{
		Name = 'Display Name',
		Default = false,
		Tooltip = 'Show display names instead of usernames'
	}
end)
a(function()
	local ar, au, av = e, g
	local aw, ax, ay, az = ar.LocalPlayer, game.ReplicatedStorage, 'Victorious Lyla', 'Nightmare'
	local aA, aB = pcall(function()
		return require(ax.TS.item['item-type']).ItemType
	end)
	if not aA then
		aB = {}
	end
	local aC, aD = pcall(function()
		return require(ax.TS.games.bedwars['item-skin']['item-skin-types']).ItemSkinType
	end)
	if not aC then
		aD = {}
	end
	local aE
	pcall(function()
		local aF = require(ax.rbxts_include.node_modules['@easy-games'].knit.src).KnitClient
		aE = aF.Controllers.KitSkinController
	end)
	local aF, aG, aH, aI, aJ, aK, aM, aN, aO, aP, aQ, aR, aS, aT, aU, aV, aW, aX, aY, aZ, a_, a0, a1, a2, a3, a4, a5, a6, a7 = CFrame.Angles(0, math.rad(- 90), 0), CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(- 360), 0), CFrame.new(0, 0, 0) * CFrame.Angles(0, - 190, math.rad(- 180)), CFrame.new(0, 0, 0) * CFrame.Angles(0, - 52, math.rad(90)), CFrame.new(0, 0, 0) * CFrame.Angles(0, - 190, math.rad(- 180)), CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(180), 0), CFrame.new(0.4, 0, 0) * CFrame.Angles(0, math.rad(360), 0), CFrame.new(0, 0, - 0.4) * CFrame.Angles(0, math.rad(90), 0), CFrame.new(0, 0, - 0.1) * CFrame.Angles(0, math.rad(110), 0), CFrame.Angles(0, math.rad(90), 0), CFrame.Angles(0, math.rad(90), 0), CFrame.new(0, - 1.7, 0) * CFrame.Angles(0, math.rad(- 180), 0), CFrame.new(0, - 1.2, 0) * CFrame.Angles(0, math.rad(0), 0), CFrame.Angles(0, math.rad(- 20), 0), CFrame.new(0, - 1.7, 0) * CFrame.Angles(0, math.rad(- 180), 0), CFrame.new(0, - 1.9, 0) * CFrame.Angles(0, math.rad(360), 0), CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(- 4), math.rad(0)), CFrame.new(- 0.2, - 0.9, 0) * CFrame.Angles(0, math.rad(- 180), 0), CFrame.new(0, - 1.4, - 0.15) * CFrame.Angles(0, math.rad(180), 0), CFrame.new(0, 0.5, 0.05) * CFrame.Angles(0, math.rad(180), 0), CFrame.new(0, 0, 0) * CFrame.Angles(30, - 30, 183.56), CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)), CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(0), 0), CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(178), math.rad(0)), 0.34, CFrame.new(0, - 1, 0), 'cannon', {
		['Victorious Cannon'] = {
			Gold = 'cannon_gold_victorious',
			Platinum = 'cannon_platinum_victorious',
			Diamond = 'cannon_diamond_victorious',
			Emerald = 'cannon_emerald_victorious',
			Nightmare = 'cannon_nightmare_victorious'
		},
		['Ghost Cannon'] = {
			Default = 'cannon_ghost'
		},
		['Deep Sea Cannon'] = {
			DeepSea = 'cannon_deepsea'
		}
	}, {
		CANNON = {
			Gold = 'CANNON_FIRE_VICTORIOUS_NIGHTMARE',
			Platinum = 'CANNON_FIRE_VICTORIOUS_NIGHTMARE',
			Diamond = 'CANNON_FIRE_VICTORIOUS_DIAMOND',
			Emerald = 'CANNON_FIRE_VICTORIOUS_EMERALD',
			Nightmare = 'CANNON_FIRE_VICTORIOUS_NIGHTMARE',
			DeepSea = 'DEEPSEA_CANNON_LAUNCH',
			Default = 'CANNON_FIRE'
		},
		LYLA = {
			FrostQueen = {
				Angry = 'FROSTQUEEN_LYLA_ANGRYBEES',
				Plant = {
					'FROSTQUEEN_LYLA_FLOWERPLANT_1',
					'FROSTQUEEN_LYLA_FLOWERPLANT_2',
					'FROSTQUEEN_LYLA_FLOWERPLANT_3'
				},
				Bloom = 'FROSTQUEEN_LYLA_FLOWERBLOOM'
			},
			Gold = {
				Angry = 'VICTORIOUS_LYLA_GOLD_ANGRYBEES',
				Plant = {
					'VICTORIOUS_LYLA_GOLD_FLOWERPLANT'
				},
				Bloom = 'VICTORIOUS_LYLA_GOLD_FLOWERBLOOM'
			},
			Platinum = {
				Angry = 'VICTORIOUS_LYLA_PLATINUM_ANGRYBEES',
				Plant = {
					'VICTORIOUS_LYLA_PLATINUM_FLOWERPLANT'
				},
				Bloom = 'VICTORIOUS_LYLA_PLATINUM_FLOWERBLOOM'
			},
			Diamond = {
				Angry = 'VICTORIOUS_LYLA_DIAMOND_ANGRYBEES',
				Plant = {
					'VICTORIOUS_LYLA_DIAMOND_FLOWERPLANT'
				},
				Bloom = 'VICTORIOUS_LYLA_DIAMOND_FLOWERBLOOM'
			},
			Emerald = {
				Angry = 'VICTORIOUS_LYLA_EMERALD_ANGRYBEES',
				Plant = {
					'VICTORIOUS_LYLA_EMERALD_FLOWERPLANT'
				},
				Bloom = 'VICTORIOUS_LYLA_EMERALD_FLOWERBLOOM'
			},
			Nightmare = {
				Angry = 'VICTORIOUS_LYLA_NIGHTMARE_ANGRYBEES',
				Plant = {
					'VICTORIOUS_LYLA_NIGHTMARE_FLOWERPLANT'
				},
				Bloom = 'VICTORIOUS_LYLA_NIGHTMARE_FLOWERBLOOM'
			},
			Default = {
				Angry = 'ANGRY_BEE',
				Plant = {
					'FLOWER_PLANT'
				},
				Bloom = 'FLOWER_BLOOM'
			}
		},
		ARCHER = {},
		ZENO = {},
		YUZI = {},
		TRITTON = {}
	}
	local a8, a9, ba = {nightmare_victorious_flower_bow = a_,emerald_victorious_flower_bow = a_,diamond_victorious_flower_bow = a_,platinum_victorious_flower_bow = a_,gold_victorious_flower_bow = a_,nightmare_victorious_flower_crossbow = a0,emerald_victorious_flower_crossbow = a0,diamond_victorious_flower_crossbow = a0,platinum_victorious_flower_crossbow = a0,gold_victorious_flower_crossbow = a0,nightmare_victorious_flower_headhunter = a1,emerald_victorious_flower_headhunter = a1,diamond_victorious_flower_headhunter = a1,platinum_victorious_flower_headhunter = a1,gold_victorious_flower_headhunter = a1,tactical_headhunter_victorious_nightmare = aK,tactical_headhunter_victorious_emerald = aK,tactical_headhunter_victorious_diamond = aK,tactical_headhunter_victorious_platinum = aK,tactical_headhunter_victorious_gold = aK,flower_bow_frost_queen = aF,tactical_crossbow_lunar_dragon = aH,life_bow_mummy = aT,flower_headhunter_frost_queen = aM,flower_crossbow_frost_queen = a2,wood_sword_darkvalentine = aR,stone_sword_darkvalentine = aR,iron_sword_darkvalentine = aR,diamond_sword_darkvalentine = aR,emerald_sword_darkvalentine = aR,wood_sword_heartbeam = aS,stone_sword_heartbeam = aS,iron_sword_heartbeam = aS,diamond_sword_heartbeam = aS,emerald_sword_heartbeam = aS,wood_bow_victorious_nightmare = aI,wood_bow_victorious_emerald = aI,wood_bow_victorious_diamond = aI,wood_bow_victorious_platinum = aI,wood_bow_victorious_gold = aI,tactical_crossbow_victorious_nightmare = aJ,tactical_crossbow_victorious_emerald = aJ,tactical_crossbow_victorious_diamond = aJ,tactical_crossbow_victorious_platinum = aJ,tactical_crossbow_victorious_gold = aJ,life_crossbow_mummy = aG,life_headhunter_mummy = aM,victorious_gold_triton = aZ,victorious_platinum_triton = aZ,victorious_diamond_triton = aZ,victorious_emerald_triton = aZ,victorious_nightmare_triton = aZ,demon_triton = aY,lasso_mummy = aP,lasso_wrangler_reindeer_lassy = aP,lasso_lifeguard = aP,wood_axe_darkvalentine = aN,stone_axe_darkvalentine = aN,iron_axe_darkvalentine = aN,diamond_axe_darkvalentine = aN,wood_axe_valentine = aN,stone_axe_valentine = aN,iron_axe_valentine = aN,diamond_axe_valentine = aN,wood_pickaxe_darkvalentine = aO,stone_pickaxe_darkvalentine = aO,iron_pickaxe_darkvalentine = aO,diamond_pickaxe_darkvalentine = aO,wood_pickaxe_valentine = aO,stone_pickaxe_valentine = aO,iron_pickaxe_valentine = aO,diamond_pickaxe_valentine = aO,gold_victorious_wizard_staff = aQ,gold_victorious_wizard_staff_2 = aQ,gold_victorious_wizard_staff_3 = aQ,platinum_victorious_wizard_staff = aQ,platinum_victorious_wizard_staff_2 = aQ,platinum_victorious_wizard_staff_3 = aQ,diamond_victorious_wizard_staff = aQ,diamond_victorious_wizard_staff_2 = aQ,diamond_victorious_wizard_staff_3 = aQ,emerald_victorious_wizard_staff = aQ,emerald_victorious_wizard_staff_2 = aQ,emerald_victorious_wizard_staff_3 = aQ,nightmare_victorious_wizard_staff = aQ,nightmare_victorious_wizard_staff_2 = aQ,nightmare_victorious_wizard_staff_3 = aQ,wood_dao_victorious = aV,stone_dao_victorious = aV,iron_dao_victorious = aV,diamond_dao_victorious = aV,emerald_dao_victorious = aV,wood_dao_cursed = aW,stone_dao_cursed = aW,iron_dao_cursed = aW,diamond_dao_cursed = aW,emerald_dao_cursed = aW,wood_dao_tiger = aU,stone_dao_tiger = aU,iron_dao_tiger = aU,diamond_dao_tiger = aU,emerald_dao_tiger = aU,wood_dao_snow_rabbit = aX,stone_dao_snow_rabbit = aX,iron_dao_snow_rabbit = aX,diamond_dao_snow_rabbit = aX,emerald_dao_snow_rabbit = aX}, {
		['Victorious Lyla'] = {
			Gold = 'gold_victorious_lyla',
			Platinum = 'platinum_victorious_lyla',
			Diamond = 'diamond_victorious_lyla',
			Emerald = 'emerald_victorious_lyla',
			Nightmare = 'nightmare_victorious_lyla'
		},
		['Frost Queen Lyla'] = {
			Default = 'flower_bee_frost_queen'
		},
		['Victorious Archer'] = {
			Gold = 'archer_victorious_gold',
			Platinum = 'archer_victorious_platinum',
			Diamond = 'archer_victorious_diamond',
			Emerald = 'archer_victorious_emerald',
			Nightmare = 'archer_victorious_nightmare'
		},
		['Lunar Dragon Archer'] = {
			Default = 'archer_lunar_dragon'
		},
		['Victorious Yuzi'] = {
			Default = 'yuzi_victorious'
		},
		['Hexed Yuzi'] = {
			Default = 'dasher_cursed'
		},
		['Tiger Yuzi'] = {
			Default = 'dasher_tiger'
		},
		['Snow Rabbit Yuzi'] = {
			Default = 'dasher_snow_rabbit'
		},
		['Victorious Zeno'] = {
			Gold = 'gold_victorious_wizard',
			Platinum = 'platinum_victorious_wizard',
			Diamond = 'diamond_victorious_wizard',
			Emerald = 'emerald_victorious_wizard',
			Nightmare = 'nightmare_victorious_wizard'
		},
		['Victorious Triton'] = {
			Gold = 'victorious_gold_triton',
			Platinum = 'victorious_platinum_triton',
			Diamond = 'victorious_diamond_triton',
			Emerald = 'victorious_emerald_triton',
			Nightmare = 'victorious_nightmare_triton'
		},
		['Demon Triton'] = {
			Default = 'demon_triton'
		},
		['Mummy Life Bow'] = {
			Default = 'mummy_nazar'
		},
		['Mummy Lasso'] = {
			Default = 'cowgirl_mummy'
		},
		['Victorious Cannon'] = {
			Gold = 'gold_victorious_davey',
			Platinum = 'platinum_victorious_davey',
			Diamond = 'diamond_victorious_davey',
			Emerald = 'emerald_victorious_davey',
			Nightmare = 'nightmare_victorious_davey'
		},
		['Ghost Cannon'] = {
			Default = 'davey_ghost'
		},
		['Deep Sea Cannon'] = {
			Default = 'davey_deepsea'
		}
	}, {
		['Balloon Swords'] = function()
			return {
				{
					aB.WOOD_SWORD,
					aD.BALLOON_WOOD_SWORD
				},
				{
					aB.STONE_SWORD,
					aD.BALLOON_STONE_SWORD
				},
				{
					aB.IRON_SWORD,
					aD.BALLOON_IRON_SWORD
				},
				{
					aB.DIAMOND_SWORD,
					aD.BALLOON_DIAMOND_SWORD
				},
				{
					aB.EMERALD_SWORD,
					aD.BALLOON_EMERALD_SWORD
				}
			}
		end,
		['Banana Swords'] = function()
			return {
				{
					aB.WOOD_SWORD,
					aD.BANANA_WOOD_SWORD
				},
				{
					aB.STONE_SWORD,
					aD.BANANA_STONE_SWORD
				},
				{
					aB.IRON_SWORD,
					aD.BANANA_IRON_SWORD
				},
				{
					aB.DIAMOND_SWORD,
					aD.BANANA_DIAMOND_SWORD
				},
				{
					aB.EMERALD_SWORD,
					aD.BANANA_EMERALD_SWORD
				}
			}
		end,
		['Valentine Swords'] = function()
			return {
				{
					aB.WOOD_SWORD,
					aD.VALENTINE_WOOD_SWORD
				},
				{
					aB.STONE_SWORD,
					aD.VALENTINE_STONE_SWORD
				},
				{
					aB.IRON_SWORD,
					aD.VALENTINE_IRON_SWORD
				},
				{
					aB.DIAMOND_SWORD,
					aD.VALENTINE_DIAMOND_SWORD
				},
				{
					aB.EMERALD_SWORD,
					aD.VALENTINE_EMERALD_SWORD
				}
			}
		end,
		['Darkheart Swords'] = function()
			return {
				{
					aB.WOOD_SWORD,
					aD.DARKVALENTINE_WOOD_SWORD
				},
				{
					aB.STONE_SWORD,
					aD.DARKVALENTINE_STONE_SWORD
				},
				{
					aB.IRON_SWORD,
					aD.DARKVALENTINE_IRON_SWORD
				},
				{
					aB.DIAMOND_SWORD,
					aD.DARKVALENTINE_DIAMOND_SWORD
				},
				{
					aB.EMERALD_SWORD,
					aD.DARKVALENTINE_EMERALD_SWORD
				}
			}
		end,
		['Heartbeam Swords'] = function()
			return {
				{
					aB.WOOD_SWORD,
					aD.HEARTBEAM_WOOD_SWORD
				},
				{
					aB.STONE_SWORD,
					aD.HEARTBEAM_STONE_SWORD
				},
				{
					aB.IRON_SWORD,
					aD.HEARTBEAM_IRON_SWORD
				},
				{
					aB.DIAMOND_SWORD,
					aD.HEARTBEAM_DIAMOND_SWORD
				},
				{
					aB.EMERALD_SWORD,
					aD.HEARTBEAM_EMERALD_SWORD
				}
			}
		end,
		['Valentine Pickaxes'] = function()
			return {
				{
					aB.WOOD_PICKAXE,
					aD.VALENTINE_WOOD_PICKAXE
				},
				{
					aB.STONE_PICKAXE,
					aD.VALENTINE_STONE_PICKAXE
				},
				{
					aB.IRON_PICKAXE,
					aD.VALENTINE_IRON_PICKAXE
				},
				{
					aB.DIAMOND_PICKAXE,
					aD.VALENTINE_DIAMOND_PICKAXE
				}
			}
		end,
		['Darkheart Pickaxes'] = function()
			return {
				{
					aB.WOOD_PICKAXE,
					aD.DARKVALENTINE_WOOD_PICKAXE
				},
				{
					aB.STONE_PICKAXE,
					aD.DARKVALENTINE_STONE_PICKAXE
				},
				{
					aB.IRON_PICKAXE,
					aD.DARKVALENTINE_IRON_PICKAXE
				},
				{
					aB.DIAMOND_PICKAXE,
					aD.DARKVALENTINE_DIAMOND_PICKAXE
				}
			}
		end,
		['Valentine Axes'] = function()
			return {
				{
					aB.WOOD_AXE,
					aD.VALENTINE_WOOD_AXE
				},
				{
					aB.STONE_AXE,
					aD.VALENTINE_STONE_AXE
				},
				{
					aB.IRON_AXE,
					aD.VALENTINE_IRON_AXE
				},
				{
					aB.DIAMOND_AXE,
					aD.VALENTINE_DIAMOND_AXE
				}
			}
		end,
		['Darkheart Axes'] = function()
			return {
				{
					aB.WOOD_AXE,
					aD.DARKVALENTINE_WOOD_AXE
				},
				{
					aB.STONE_AXE,
					aD.DARKVALENTINE_STONE_AXE
				},
				{
					aB.IRON_AXE,
					aD.DARKVALENTINE_IRON_AXE
				},
				{
					aB.DIAMOND_AXE,
					aD.DARKVALENTINE_DIAMOND_AXE
				}
			}
		end,
		['Mummy Life Bow'] = function()
			return {
				{
					aB.LIFE_BOW,
					aD.LIFE_BOW_MUMMY
				},
				{
					aB.LIFE_CROSSBOW,
					aD.LIFE_CROSSBOW_MUMMY
				},
				{
					aB.LIFE_HEADHUNTER,
					aD.LIFE_HEADHUNTER_MUMMY
				}
			}
		end,
		['Mummy Lasso'] = function()
			return {
				{
					aB.LASSO,
					aD.LASSO_MUMMY
				}
			}
		end
	}
	local function yuziDaoMap(bb)
		return {
			wood_dao = 'wood_dao_' .. bb,
			stone_dao = 'stone_dao_' .. bb,
			iron_dao = 'iron_dao_' .. bb,
			diamond_dao = 'diamond_dao_' .. bb,
			emerald_dao = 'emerald_dao_' .. bb
		}
	end
	local bb, bc = {
		['Victorious Lyla'] = function(bb)
			local bc = bb:lower()
			return {
				flower_bow = bc .. '_victorious_flower_bow',
				flower_crossbow = bc .. '_victorious_flower_crossbow',
				flower_headhunter = bc .. '_victorious_flower_headhunter'
			}
		end,
		['Frost Queen Lyla'] = function()
			return {
				flower_bow = 'flower_bow_frost_queen',
				flower_crossbow = 'flower_crossbow_frost_queen',
				flower_headhunter = 'flower_headhunter_frost_queen'
			}
		end,
		['Victorious Archer'] = function(bb)
			local bc = bb:lower()
			return {
				wood_bow = 'wood_bow_victorious_' .. bc,
				tactical_crossbow = 'tactical_crossbow_victorious_' .. bc,
				tactical_headhunter = 'tactical_headhunter_victorious_' .. bc
			}
		end,
		['Lunar Dragon Archer'] = function()
			return {
				wood_bow = 'wood_bow_lunar_dragon',
				tactical_crossbow = 'tactical_crossbow_lunar_dragon',
				tactical_headhunter = 'tactical_headhunter_lunar_dragon'
			}
		end,
		['Victorious Triton'] = function(bb)
			return {
				harpoon = 'victorious_' .. bb:lower() .. '_triton'
			}
		end,
		['Demon Triton'] = function()
			return {
				harpoon = 'demon_triton'
			}
		end,
		['Victorious Yuzi'] = function()
			return yuziDaoMap'victorious'
		end,
		['Hexed Yuzi'] = function()
			return yuziDaoMap'cursed'
		end,
		['Tiger Yuzi'] = function()
			return yuziDaoMap'tiger'
		end,
		['Snow Rabbit Yuzi'] = function()
			return yuziDaoMap'snow_rabbit'
		end,
		['Victorious Zeno'] = function(bb)
			local bc = bb:lower()
			return {
				wizard_staff = bc .. '_victorious_wizard_staff',
				wizard_staff_2 = bc .. '_victorious_wizard_staff_2',
				wizard_staff_3 = bc .. '_victorious_wizard_staff_3'
			}
		end,
		['Balloon Swords'] = function()
			return {
				wood_sword = 'balloon_wood_sword',
				stone_sword = 'balloon_stone_sword',
				iron_sword = 'balloon_iron_sword',
				diamond_sword = 'balloon_diamond_sword',
				emerald_sword = 'balloon_emerald_sword'
			}
		end,
		['Banana Swords'] = function()
			return {
				wood_sword = 'banana_wood_sword',
				stone_sword = 'banana_stone_sword',
				iron_sword = 'banana_iron_sword',
				diamond_sword = 'banana_diamond_sword',
				emerald_sword = 'banana_emerald_sword'
			}
		end,
		['Valentine Swords'] = function()
			return {
				wood_sword = 'wood_sword_valentine',
				stone_sword = 'stone_sword_valentine',
				iron_sword = 'iron_sword_valentine',
				diamond_sword = 'diamond_sword_valentine',
				emerald_sword = 'emerald_sword_valentine'
			}
		end,
		['Darkheart Swords'] = function()
			return {
				wood_sword = 'wood_sword_darkvalentine',
				stone_sword = 'stone_sword_darkvalentine',
				iron_sword = 'iron_sword_darkvalentine',
				diamond_sword = 'diamond_sword_darkvalentine',
				emerald_sword = 'emerald_sword_darkvalentine'
			}
		end,
		['Heartbeam Swords'] = function()
			return {
				wood_sword = 'wood_sword_heartbeam',
				stone_sword = 'stone_sword_heartbeam',
				iron_sword = 'iron_sword_heartbeam',
				diamond_sword = 'diamond_sword_heartbeam',
				emerald_sword = 'emerald_sword_heartbeam'
			}
		end,
		['Valentine Pickaxes'] = function()
			return {
				wood_pickaxe = 'wood_pickaxe_valentine',
				stone_pickaxe = 'stone_pickaxe_valentine',
				iron_pickaxe = 'iron_pickaxe_valentine',
				diamond_pickaxe = 'diamond_pickaxe_valentine'
			}
		end,
		['Darkheart Pickaxes'] = function()
			return {
				wood_pickaxe = 'wood_pickaxe_darkvalentine',
				stone_pickaxe = 'stone_pickaxe_darkvalentine',
				iron_pickaxe = 'iron_pickaxe_darkvalentine',
				diamond_pickaxe = 'diamond_pickaxe_darkvalentine'
			}
		end,
		['Valentine Axes'] = function()
			return {
				wood_axe = 'wood_axe_valentine',
				stone_axe = 'stone_axe_valentine',
				iron_axe = 'iron_axe_valentine',
				diamond_axe = 'diamond_axe_valentine'
			}
		end,
		['Darkheart Axes'] = function()
			return {
				wood_axe = 'wood_axe_darkvalentine',
				stone_axe = 'stone_axe_darkvalentine',
				iron_axe = 'iron_axe_darkvalentine',
				diamond_axe = 'diamond_axe_darkvalentine'
			}
		end,
		['Mummy Lasso'] = function()
			return {
				lasso = 'lasso_mummy'
			}
		end,
		['Mummy Life Bow'] = function()
			return {
				life_bow = 'life_bow_mummy',
				life_crossbow = 'life_crossbow_mummy',
				life_headhunter = 'life_headhunter_mummy'
			}
		end
	}, {
		['Victorious Lyla'] = true,
		['Victorious Archer'] = true,
		['Victorious Zeno'] = true,
		['Victorious Triton'] = true,
		['Victorious Cannon'] = true
	}
	local function normalizeName(bd)
		return bd:lower():gsub('[_%s%-]', '')
	end
	local function isCannonSkin()
		return a6[ay] ~= nil
	end
	local function getCurrentCannonSkinName()
		local bd = a6[ay]
		if not bd then
			return nil
		end
		return bd[az] or bd.Default
	end
	local function getCannonSkinSource(bd)
		local be = ax:FindFirstChild'Assets'
		if not be then
			return nil
		end
		local bf = be:FindFirstChild'Blocks'
		if not bf then
			return nil
		end
		return bf:FindFirstChild(bd)
	end
	local function getCurrentMappings()
		local bd = bb[ay]
		if not bd then
			return {}
		end
		return bd(az) or {}
	end
	local function getKitSkinValue()
		local bd = a9[ay]
		if not bd then
			return nil
		end
		return bd[az] or bd.Default
	end
	local function getStoreSkins()
		local bd = ba[ay]
		if not bd then
			return {}
		end
		return bd() or {}
	end
	local bd, be, bf, bg, bh, bi, bj, bk, bl, bm, bn = setmetatable({}, {
		__mode = 'k'
	}), {}, setmetatable({}, {
		__mode = 'k'
	}), {}, setmetatable({}, {
		__mode = 'k'
	}), {}, {}, false
	local function firstBasePart(bo)
		for bp, bq in ipairs(bo:GetDescendants()) do
			if bq:IsA'BasePart' then
				return bq
			end
		end
	end
	local function makeInvisible(bo)
		for bp, bq in ipairs(bo:GetDescendants()) do
			if bq:IsA'BasePart' then
				bq.LocalTransparencyModifier = 1
				bq.Transparency = 1
			elseif bq:IsA'Decal' or bq:IsA'Texture' then
				bq.Transparency = 1
			end
		end
	end
	local function restoreVisibility(bo)
		for bp, bq in ipairs(bo:GetDescendants()) do
			if bq:IsA'BasePart' then
				bq.LocalTransparencyModifier = 0
				bq.Transparency = 0
			elseif bq:IsA'Decal' or bq:IsA'Texture' then
				bq.Transparency = 0
			end
		end
	end
	local function setNoCollide(bo)
		for bp, bq in ipairs(bo:GetDescendants()) do
			if bq:IsA'BasePart' then
				bq.CanCollide = false
				bq.CanTouch = false
				bq.CanQuery = false
				bq.Massless = true
				bq.Anchored = false
			end
		end
	end
	local function weldAllTo(bo, bp)
		for bq, br in ipairs(bp:GetDescendants()) do
			if br:IsA'BasePart' and br ~= bo then
				local bs = Instance.new'WeldConstraint'
				bs.Part0 = bo
				bs.Part1 = br
				bs.Parent = bo
			end
		end
	end
	local function startInvisibilityEnforcer(bo)
		if bf[bo] then
			pcall(function()
				bf[bo]:Disconnect()
			end)
			bf[bo] = nil
		end
		local bp
		bp = au.RenderStepped:Connect(function()
			if not bo or not bo.Parent then
				bp:Disconnect()
				bf[bo] = nil
				return
			end
			local bq = bo:FindFirstChild'LOCAL_ITEM_RESKIN'
			for br, bs in ipairs(bo:GetDescendants()) do
				if bq and bs:IsDescendantOf(bq) then
					continue
				end
				if bs:IsA'BasePart' then
					bs.LocalTransparencyModifier = 1
					bs.Transparency = 1
				elseif bs:IsA'Decal' or bs:IsA'Texture' then
					bs.Transparency = 1
				end
			end
		end)
		bf[bo] = bp
		table.insert(be, bp)
	end
	local function attachReskin(bo, bp)
		if not bo or bd[bo] then
			return
		end
		bd[bo] = true
		local bq = bo:FindFirstChild'Handle'
		if not (bq and bq:IsA'BasePart') then
			bq = firstBasePart(bo)
		end
		if not bq then
			bd[bo] = nil
			return
		end
		local br = ax:FindFirstChild'Items'
		if not br then
			bd[bo] = nil
			return
		end
		local bs = br:FindFirstChild(bp)
		if not bs then
			bd[bo] = nil
			return
		end
		makeInvisible(bo)
		local bt = bs:Clone()
		bt.Name = 'LOCAL_ITEM_RESKIN'
		for bu, bv in ipairs(bt:GetDescendants()) do
			if bv:IsA'Script' or bv:IsA'LocalScript' or bv:IsA'ModuleScript' then
				pcall(bv.Destroy, bv)
			end
		end
		setNoCollide(bt)
		bt.Parent = bo
		local bu = bt:FindFirstChild'Handle'
		if not (bu and bu:IsA'BasePart') then
			if bt:IsA'Model' then
				if not bt.PrimaryPart then
					local bv = firstBasePart(bt)
					if bv then
						pcall(function()
							bt.PrimaryPart = bv
						end)
					end
				end
				bu = bt.PrimaryPart
			end
			bu = bu or firstBasePart(bt)
		end
		if not bu then
			bt:Destroy()
			restoreVisibility(bo)
			bd[bo] = nil
			return
		end
		pcall(function()
			bu.CFrame = bq.CFrame
		end)
		weldAllTo(bu, bt)
		local bv = Instance.new'Weld'
		bv.Part0 = bq
		bv.Part1 = bu
		bv.C0 = a8[bp] or CFrame.identity
		bv.C1 = CFrame.identity
		bv.Parent = bu
		startInvisibilityEnforcer(bo)
	end
	local function weldAllToPrimary(bo)
		local bp = bo.PrimaryPart
		if not bp then
			return
		end
		for bq, br in ipairs(bo:GetDescendants()) do
			if br:IsA'BasePart' and br ~= bp then
				local bs = Instance.new'WeldConstraint'
				bs.Part0 = bp
				bs.Part1 = br
				bs.Parent = bp
			end
		end
	end
	local function attachCannonReskin(bo, bp, bq)
		if not bo or bh[bo] then
			return
		end
		bh[bo] = true
		local br = bo:FindFirstChild'Handle'
		if not (br and br:IsA'BasePart') then
			br = firstBasePart(bo)
		end
		if not br then
			bh[bo] = nil
			return
		end
		local bs = getCurrentCannonSkinName()
		if not bs then
			bh[bo] = nil
			return
		end
		local bt = getCannonSkinSource(bs)
		if not bt then
			bh[bo] = nil
			return
		end
		makeInvisible(bo)
		local bu = bt:Clone()
		bu.Name = 'LOCAL_CANNON_RESKIN'
		for bv, bw in ipairs(bu:GetDescendants()) do
			if bw:IsA'Script' or bw:IsA'LocalScript' or bw:IsA'ModuleScript' then
				pcall(bw.Destroy, bw)
			end
		end
		if not bu:IsA'Model' then
			setNoCollide(bu)
			bu.Parent = bo
			return
		end
		if not bu.PrimaryPart then
			local bv = firstBasePart(bu)
			if bv then
				pcall(function()
					bu.PrimaryPart = bv
				end)
			end
		end
		if not bu.PrimaryPart then
			bu:Destroy()
			bh[bo] = nil
			return
		end
		if bq and bq ~= 1 then
			pcall(function()
				bu:ScaleTo(bq)
			end)
		end
		setNoCollide(bu)
		bu.Parent = bo
		local bv = bp or CFrame.identity
		pcall(function()
			bu:PivotTo(br.CFrame * bv)
		end)
		weldAllToPrimary(bu)
		local bw = Instance.new'WeldConstraint'
		bw.Part0 = br
		bw.Part1 = bu.PrimaryPart
		bw.Parent = bu.PrimaryPart
	end
	local function hookCannonThirdPerson(bo)
		local function onChildAdded(bp)
			if not (bp:IsA'Tool' and bp.Name == a5) then
				return
			end
			task.wait()
			local bq = bp:FindFirstChild'Handle' or firstBasePart(bp)
			if not bq then
				return
			end
			local br = bp:FindFirstChild'LOCAL_CANNON_RESKIN'
			if br then
				br:Destroy()
				bh[bp] = nil
			end
			attachCannonReskin(bp, CFrame.identity, a3)
			local bs, bt = (time())
			bt = au.RenderStepped:Connect(function()
				if not bp.Parent then
					bt:Disconnect()
					return
				end
				makeInvisible(bp)
				if time() - bs > 3 then
					bt:Disconnect()
				end
			end)
			table.insert(bj, bt)
		end
		for bp, bq in ipairs(bo:GetChildren()) do
			onChildAdded(bq)
		end
		local bp = bo.ChildAdded:Connect(onChildAdded)
		table.insert(bi, bp)
	end
	local function hookCannonViewmodel()
		local bo = workspace.CurrentCamera
		if not bo then
			return
		end
		local function hookVM(bp)
			for bq, br in ipairs(bp:GetChildren()) do
				if br.Name == a5 then
					attachCannonReskin(br, CFrame.identity, a3)
				end
			end
			local bq = bp.ChildAdded:Connect(function(bq)
				if bq.Name == a5 then
					task.wait()
					attachCannonReskin(bq, CFrame.identity, a3)
				end
			end)
			table.insert(bi, bq)
		end
		local bp = bo:FindFirstChild'Viewmodel'
		if bp then
			hookVM(bp)
		end
		local bq = bo.ChildAdded:Connect(function(bq)
			if bq.Name == 'Viewmodel' then
				task.wait()
				hookVM(bq)
			end
		end)
		table.insert(bi, bq)
	end
	local function hookCannonContainer(bo)
		if not bo then
			return
		end
		for bp, bq in ipairs(bo:GetChildren()) do
			if bq.Name == a5 then
				attachCannonReskin(bq, CFrame.identity, a3)
			end
		end
		local bp = bo.ChildAdded:Connect(function(bp)
			if bp.Name == a5 then
				task.wait()
				attachCannonReskin(bp, CFrame.identity, a3)
			end
		end)
		table.insert(bi, bp)
	end
	local function hookCannonBlocksFolder(bo)
		for bp, bq in ipairs(bo:GetChildren()) do
			if bq.Name == a5 then
				attachCannonReskin(bq, a4, 1)
			end
		end
		local bp = bo.ChildAdded:Connect(function(bp)
			if bp.Name == a5 then
				task.wait()
				attachCannonReskin(bp, a4, 1)
			end
		end)
		table.insert(bi, bp)
	end
	local function hookAllWorldCannons()
		local bo = workspace:FindFirstChild'Map'
		if not bo then
			return
		end
		local bp = bo:FindFirstChild'Worlds'
		if not bp then
			return
		end
		for bq, br in ipairs(bp:GetChildren()) do
			local bs = br:FindFirstChild'Blocks'
			if bs then
				hookCannonBlocksFolder(bs)
			end
		end
		local bq = bp.ChildAdded:Connect(function(bq)
			task.wait()
			local br = bq:FindFirstChild'Blocks'
			if br then
				hookCannonBlocksFolder(br)
			end
		end)
		table.insert(bi, bq)
	end
	local function hookCannonSounds()
		if bk then
			return
		end
		if not (O and O.CannonHandController) then
			return
		end
		bk = true
		bm = O.CannonHandController.fireCannon
		bn = O.CannonHandController.launchSelf
		local function replaceSound()
			for bo, bp in ipairs(workspace.SoundPool:GetChildren()) do
				if bp:IsA'Sound' and bp.SoundId == 'rbxassetid://7121064180' then
					bp:Destroy()
				end
			end
			local bo = a7.CANNON[az] or a7.CANNON.Default
			if O.SoundManager and O.SoundList and O.SoundList[bo] then
				O.SoundManager:playSound(O.SoundList[bo])
			end
		end
		O.CannonHandController.fireCannon = function(...)
			replaceSound()
			return bm(...)
		end
		O.CannonHandController.launchSelf = function(...)
			replaceSound()
			return bn(...)
		end
	end
	local function unhookCannonSounds()
		if bk and O and O.CannonHandController then
			if bm then
				O.CannonHandController.fireCannon = bm
			end
			if bn then
				O.CannonHandController.launchSelf = bn
			end
		end
		bm = nil
		bn = nil
		bk = false
	end
	local function cleanupCannons()
		for bo, bp in pairs(bi) do
			pcall(function()
				bp:Disconnect()
			end)
		end
		for bo, bp in pairs(bj) do
			pcall(function()
				bp:Disconnect()
			end)
		end
		table.clear(bi)
		table.clear(bj)
		for bo in pairs(bh) do
			if bo and bo.Parent then
				local bp = bo:FindFirstChild'LOCAL_CANNON_RESKIN'
				if bp then
					bp:Destroy()
				end
				restoreVisibility(bo)
			end
		end
		table.clear(bh)
		local bo = workspace:FindFirstChild'Map'
		if bo then
			local bp = bo:FindFirstChild'Worlds'
			if bp then
				for bq, br in ipairs(bp:GetChildren()) do
					local bs = br:FindFirstChild'Blocks'
					if bs then
						for bt, bu in ipairs(bs:GetChildren()) do
							if bu.Name == a5 then
								local bv = bu:FindFirstChild'LOCAL_CANNON_RESKIN'
								if bv then
									bv:Destroy()
								end
								restoreVisibility(bu)
							end
						end
					end
				end
			end
		end
		unhookCannonSounds()
	end
	local function applyKitSkinHook()
		if not aE then
			return
		end
		local bo = getKitSkinValue()
		if not bo then
			return
		end
		if not bl then
			bl = aE.getKitSkin
		end
		aE.getKitSkin = function(bp, bq)
			if bq == aw.Character then
				return bo
			end
			return bl(bp, bq)
		end
	end
	local function removeKitSkinHook()
		if aE and bl then
			aE.getKitSkin = bl
			bl = nil
		end
	end
	local function applyStoreSkins()
		if not (O and O.Store) then
			return
		end
		local bo = getStoreSkins()
		bg = {}
		local bp = O.Store:getState()
		for bq, br in ipairs(bo) do
			if br[1] and br[2] then
				local bs = bp.Locker and bp.Locker.selectedItemSkins and bp.Locker.selectedItemSkins[br[1] ]
				table.insert(bg, {
					br[1],
					bs
				})
				pcall(function()
					O.Store:dispatch{
						type = 'LockerSetItemSkin',
						itemType = br[1],
						itemSkin = br[2]
					}
				end)
			end
		end
	end
	local function clearStoreSkins()
		if not (O and O.Store) then
			return
		end
		for bo, bp in ipairs(bg) do
			pcall(function()
				O.Store:dispatch{
					type = 'LockerSetItemSkin',
					itemType = bp[1],
					itemSkin = bp[2]
				}
			end)
		end
		bg = {}
	end
	local function tryApply(bo)
		if isCannonSkin() then
			return
		end
		local bp = getCurrentMappings()
		local bq = bp[bo.Name:lower()]
		if not bq then
			local br = normalizeName(bo.Name)
			for bs, bt in pairs(bp) do
				if normalizeName(bs) == br then
					bq = bt
					break
				end
			end
		end
		if not bq then
			return
		end
		task.wait()
		if bo.Parent then
			attachReskin(bo, bq)
		end
	end
	local function hookViewmodel()
		local bo = workspace.CurrentCamera
		if not bo then
			return
		end
		local function hookVM(bp)
			for bq, br in ipairs(bp:GetChildren()) do
				tryApply(br)
			end
			table.insert(be, bp.ChildAdded:Connect(tryApply))
		end
		local bp = bo:FindFirstChild'Viewmodel'
		if bp then
			hookVM(bp)
		end
		table.insert(be, bo.ChildAdded:Connect(function(bq)
			if bq.Name == 'Viewmodel' then
				task.wait()
				hookVM(bq)
			end
		end))
	end
	local function hookContainer(bo)
		if not bo then
			return
		end
		for bp, bq in ipairs(bo:GetChildren()) do
			tryApply(bq)
		end
		table.insert(be, bo.ChildAdded:Connect(tryApply))
	end
	local function cleanupDeadTagged()
		for bo in pairs(bd) do
			if not bo or not bo.Parent then
				bd[bo] = nil
			end
		end
		for bo in pairs(bf) do
			if not bo or not bo.Parent then
				pcall(function()
					bf[bo]:Disconnect()
				end)
				bf[bo] = nil
			end
		end
	end
	local function onCharacterAdded(bo)
		task.wait(0.2)
		cleanupDeadTagged()
		applyKitSkinHook()
		if isCannonSkin() then
			hookCannonContainer(aw.Backpack)
			hookCannonContainer(bo)
			hookCannonThirdPerson(bo)
		else
			hookContainer(aw.Backpack)
			hookContainer(bo)
		end
	end
	local function cleanup()
		for bo, bp in pairs(bf) do
			pcall(function()
				bp:Disconnect()
			end)
		end
		table.clear(bf)
		for bo, bp in pairs(be) do
			pcall(function()
				bp:Disconnect()
			end)
		end
		table.clear(be)
		for bo in pairs(bd) do
			if bo and bo.Parent then
				local bp = bo:FindFirstChild'LOCAL_ITEM_RESKIN'
				if bp then
					bp:Destroy()
				end
				restoreVisibility(bo)
			end
		end
		table.clear(bd)
		removeKitSkinHook()
		clearStoreSkins()
		cleanupCannons()
	end
	local bo = {}
	for bp in pairs(bb) do
		table.insert(bo, bp)
	end
	for bp in pairs(a6) do
		table.insert(bo, bp)
	end
	table.sort(bo)
	local bp
	av = v.Categories.Render:CreateModule{
		Name = 'SkinChanger',
		Function = function(bq)
			if bq then
				if isCannonSkin() then
					hookCannonViewmodel()
					hookAllWorldCannons()
					hookCannonSounds()
					applyKitSkinHook()
					if aw.Character then
						hookCannonContainer(aw.Backpack)
						hookCannonContainer(aw.Character)
						hookCannonThirdPerson(aw.Character)
					end
				else
					hookViewmodel()
					applyKitSkinHook()
					applyStoreSkins()
					if aw.Character then
						onCharacterAdded(aw.Character)
					end
				end
				table.insert(be, aw.CharacterAdded:Connect(onCharacterAdded))
			else
				cleanup()
			end
		end,
		Tooltip = 'Client-sided item skin changer'
	}
	av:CreateDropdown{
		Name = 'Item Skin',
		List = bo,
		Default = ay,
		Function = function(bq)
			ay = bq
			if bp and bp.Object then
				bp.Object.Visible = bc[bq] == true
			end
			if av.Enabled then
				av:Toggle()
				av:Toggle()
			end
		end
	}
	bp = av:CreateDropdown{
		Name = 'Skin Type',
		List = {
			'Gold',
			'Platinum',
			'Diamond',
			'Emerald',
			'Nightmare',
			'Default'
		},
		Default = az,
		Function = function(bq)
			az = bq
			if av.Enabled then
				av:Toggle()
				av:Toggle()
			end
		end
	}
	task.defer(function()
		if bp and bp.Object then
			bp.Object.Visible = bc[ay] == true
		end
		if bp and bp.Set then
			bp:Set(az)
		end
	end)
end)
a(function()
	local ar, au, av, aw = {}, 2
	local function getTeammates()
		local ax, ay, az = {}, {}, t.Team
		for aA, aB in e:GetPlayers() do
			if aB ~= t then
				if aB.Team == az then
					table.insert(ax, aB)
				else
					table.insert(ay, aB)
				end
			end
		end
		return ax, ay
	end
	local function honorPlayers()
		if # ar >= au then
			return
		end
		local ax, ay = getTeammates()
		if # ax > 0 and # ar < au then
			local az = ax[math.random(1, # ax)]
			if not ar[az.UserId] then
				task.wait(aw.Value)
				O.HonorController:honorPlayer(az.UserId)
				ar[az.UserId] = true
			end
		end
		if # ay > 0 and # ar < au then
			local az = ay[math.random(1, # ay)]
			if not ar[az.UserId] then
				task.wait(aw.Value)
				O.HonorController:honorPlayer(az.UserId)
				ar[az.UserId] = true
			end
		end
	end
	av = v.Categories.Minigames:CreateModule{
		Name = 'AutoHonor',
		Function = function(ax)
			if ax then
				av:Clean(b.EntityDeathEvent.Event:Connect(function(ay)
					if ay.finalKill and ay.entityInstance == t.Character and isEveryoneDead() and L.matchState ~= 2 then
						honorPlayers()
					end
				end))
				av:Clean(b.MatchEndEvent.Event:Connect(function(...)
					honorPlayers()
				end))
			else
				table.clear(ar)
			end
		end
	}
	aw = av:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 1,
		Decimal = 100,
		Default = 0.05
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA = game.ReplicatedStorage, 2
	local function getBF()
		if az then
			return az
		end
		pcall(function()
			az = require(ar.TS.balance['balance-file']).BalanceFile
		end)
		return az
	end
	local function getCtrl()
		local aB
		pcall(function()
			aB = require(ar.rbxts_include.node_modules['@easy-games'].knit.src).KnitClient.Controllers.ElektraController
		end)
		return aB
	end
	local function apply()
		local aB = getBF()
		if aB and aB.ELEKTRA then
			if not aw then
				aw = aB.ELEKTRA.ELECTRIC_DASH_DEPTH_GOAL
				ax = aB.ELEKTRA.ELECTRIC_DASH_COOLDOWN
				ay = aB.ELEKTRA.ELECTRIC_DASH_DURATION
			end
			aB.ELEKTRA.ELECTRIC_DASH_DEPTH_GOAL = aw + (au * 4)
			aB.ELEKTRA.ELECTRIC_DASH_COOLDOWN = 0
			aB.ELEKTRA.ELECTRIC_DASH_DURATION = 0
		end
		aA = game:GetService'RunService'.Heartbeat:Connect(function()
			local aC = getCtrl()
			if aC then
				aC.dashReadyTime = - 1
				aC.lastDash = - math.huge
			end
		end)
	end
	local function revert()
		if aA then
			aA:Disconnect()
			aA = nil
		end
		local aB = getBF()
		if aB and aB.ELEKTRA and aw then
			aB.ELEKTRA.ELECTRIC_DASH_DEPTH_GOAL = aw
			aB.ELEKTRA.ELECTRIC_DASH_COOLDOWN = ax
			aB.ELEKTRA.ELECTRIC_DASH_DURATION = ay
		end
		aw = nil
		ax = nil
		ay = nil
	end
	av = v.Categories.Kits:CreateModule{
		Name = 'ElektraExtender',
		Function = function(aB)
			if aB then
				apply()
			else
				revert()
			end
		end,
		Tooltip = 'Extends Elektra dash + removes client cooldown'
	}
	av:CreateSlider{
		Name = 'Extra Blocks',
		Min = 1,
		Max = 3,
		Default = 2,
		Decimal = 1,
		Function = function(aB)
			au = math.floor(aB)
			if av.Enabled then
				local aC = getBF()
				if aC and aC.ELEKTRA and aw then
					aC.ELEKTRA.ELECTRIC_DASH_DEPTH_GOAL = aw + (au * 4)
				end
			end
		end
	}
end)
a(function()
	local ar, au, av, aw, ax, ay = nil, nil, nil, nil, game.ReplicatedStorage, 0
	local function getCooldownId()
		if av then
			return av
		end
		pcall(function()
			av = require(ax.TS.cooldown['cooldown-id']).CooldownId
		end)
		return av
	end
	local function getCooldownCtrl()
		if au then
			return au
		end
		pcall(function()
			au = require(ax.rbxts_include.node_modules['@flamework'].core.out).Flamework.resolveDependency'@easy-games/game-core:client/controllers/cooldown/cooldown-controller@CooldownController'
		end)
		if not au then
			pcall(function()
				au = require(ax.rbxts_include.node_modules['@easy-games'].knit.src).KnitClient.Controllers.CooldownController
			end)
		end
		return au
	end
	local function apply()
		local az, aA = getCooldownCtrl(), getCooldownId()
		if not az or not aA then
			return
		end
		ar = az.isOnCooldown
		local aB, aC = - math.huge, 0
		az.isOnCooldown = function(aD, aE)
			if aE == aA.VOID_AXE then
				if ay <= 0 then
					return false
				end
				local aF = tick()
				if aF < aC then
					return false
				end
				if not ar(aD, aE) then
					aB = - math.huge
				end
				if (aF - aB) >= ay then
					aB = aF
					aC = aF + 0.15
					return false
				end
				return true
			end
			return ar(aD, aE)
		end
	end
	local function revert()
		local az = getCooldownCtrl()
		if az and ar then
			az.isOnCooldown = ar
			ar = nil
		end
	end
	aw = v.Categories.Kits:CreateModule{
		Name = 'RegentCooldown',
		Function = function(az)
			if az then
				apply()
			else
				revert()
			end
		end,
		Tooltip = 'Custom cooldown for Void Regent axe'
	}
	aw:CreateSlider{
		Name = 'Cooldown',
		Min = 0,
		Max = 7,
		Default = 0,
		Decimal = 1,
		Suffix = function(az)
			return az == 1 and 'second' or 'seconds'
		end,
		Function = function(az)
			ay = az
		end
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA = game.ReplicatedStorage, 0, - math.huge, 0
	local function getCooldownId()
		if az then
			return az
		end
		pcall(function()
			az = require(ar.TS.cooldown['cooldown-id']).CooldownId
		end)
		return az
	end
	local function getCooldownCtrl()
		if ay then
			return ay
		end
		pcall(function()
			ay = require(ar.rbxts_include.node_modules['@flamework'].core.out).Flamework.resolveDependency'@easy-games/game-core:client/controllers/cooldown/cooldown-controller@CooldownController'
		end)
		return ay
	end
	local function apply()
		local aB, aC = getCooldownCtrl(), getCooldownId()
		if not aB or not aC then
			return
		end
		ax = aB.isOnCooldown
		aB.isOnCooldown = function(aD, aE)
			if aE == aC.JADE_HAMMER then
				if au <= 0 then
					return false
				end
				local aF = tick()
				if aF < aw then
					return false
				end
				if not ax(aD, aE) then
					av = - math.huge
				end
				if (aF - av) >= au then
					av = aF
					aw = aF + 0.15
					return false
				end
				return true
			end
			return ax(aD, aE)
		end
	end
	local function revert()
		local aB = getCooldownCtrl()
		if aB and ax then
			aB.isOnCooldown = ax
			ax = nil
		end
	end
	aA = v.Categories.Kits:CreateModule{
		Name = 'JadeCooldown',
		Function = function(aB)
			if aB then
				apply()
			else
				revert()
			end
		end,
		Tooltip = 'Custom cooldown for Jade Hammer'
	}
	aA:CreateSlider{
		Name = 'Cooldown',
		Min = 0,
		Max = 7,
		Default = 0,
		Decimal = 1,
		Suffix = function(aB)
			return aB == 1 and 'second' or 'seconds'
		end,
		Function = function(aB)
			au = aB
		end
	}
end)
a(function()
	local ar, au, av, aw, ax = Enum.KeyCode.Q, true
	local function PerformDash()
		if not au then
			return
		end
		if not B.isAlive then
			return
		end
		local ay = L.hand.tool
		if not ay or not (ay.Name:find'dao' or ay.Name:find'yuzi') then
			return
		end
		local az = t.Character
		if not (az and az.PrimaryPart) then
			return
		end
		au = false
		task.spawn(function()
			local aA = az.Humanoid.JumpHeight
			pcall(function()
				az:SetAttribute('CanDash', 0)
			end)
			local aB, aC = s.CFrame.LookVector, az.PrimaryPart.Position
			pcall(function()
				local aD = game:GetService'ReplicatedStorage':FindFirstChild'rbxts_include'
				if aD then
					aD = aD:FindFirstChild'node_modules'
				end
				if aD then
					aD = aD:FindFirstChild'@rbxts'
				end
				if aD then
					aD = aD:FindFirstChild'net'
				end
				if aD then
					aD = aD:FindFirstChild'out'
				end
				if aD then
					aD = aD:FindFirstChild'_NetManaged'
				end
				if aD then
					aD = aD:FindFirstChild'SwordSwingMiss'
				end
				if aD then
					aD:FireServer{
						weapon = ay,
						chargeRatio = 0
					}
				end
			end)
			task.wait(0.05)
			if O.AbilityController:canUseAbility'dash' then
				O.AbilityController:useAbility('dash', nil, {
					direction = aB,
					origin = aC,
					weapon = ay.Name
				})
				pcall(function()
					O.GameAnimationUtil:playAnimation(t, O.AnimationType.DAO_DASH)
				end)
				pcall(function()
					local aD = az.HumanoidRootPart
					local aE = aD.AssemblyMass or 5
					aD:ApplyImpulse(aB.Unit * Vector3.new(1, 0, 1) * aE * aw.Value)
					az.Humanoid.JumpHeight = ax.Value
					az.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end)
				task.delay(0.5, function()
					if az and az.Humanoid then
						pcall(function()
							az.Humanoid.JumpHeight = aA
							if O.JumpHeightController then
								O.JumpHeightController:setJumpHeight(game:GetService'StarterPlayer'.CharacterJumpHeight)
							end
						end)
					end
				end)
			end
			task.wait(0.3)
			au = true
		end)
	end
	av = v.Categories.Kits:CreateModule{
		Name = 'YuziDasher',
		Function = function(ay)
			if ay then
				av:Clean(h.InputBegan:Connect(function(az, aA)
					if aA then
						return
					end
					if az.UserInputType == Enum.UserInputType.Keyboard and az.KeyCode == ar then
						PerformDash()
					end
				end))
			else
				au = true
			end
		end,
		Tooltip = 'Yuzi Dasher with custom keybind'
	}
	local ay = {
		'Q',
		'E',
		'R',
		'F',
		'G',
		'X',
		'Z',
		'V',
		'B',
		'LeftAlt',
		'LeftControl',
		'LeftShift',
		'RightAlt',
		'RightControl',
		'RightShift',
		'Space',
		'CapsLock',
		'Tab'
	}
	av:CreateDropdown{
		Name = 'Keybind',
		List = ay,
		Default = 'Q',
		Function = function(az)
			ar = Enum.KeyCode[az]
		end
	}
	aw = av:CreateSlider{
		Name = 'Impulse Multiplier',
		Min = 10,
		Max = 500,
		Default = 100,
		Tooltip = 'Controls dash speed'
	}
	ax = av:CreateSlider{
		Name = 'Jump Height',
		Min = 0,
		Max = 50,
		Default = 10,
		Tooltip = 'Controls jump height during dash'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay
	local function fixPosition(az)
		return O.BlockController:getBlockPosition(az) * 3
	end
	local function countSurroundingBlocks(az)
		local aA = 0
		for aB, aC in Enum.NormalId:GetEnumItems() do
			if aC == Enum.NormalId.Top or aC == Enum.NormalId.Bottom then
				continue
			end
			local aD = fixPosition(az + Vector3.fromNormalId(aC) * 2)
			if getPlacedBlock(aD) then
				aA += 1
			end
		end
		return aA
	end
	local function isInVoid(az)
		for aA = 1, 10 do
			local aB = fixPosition(az - Vector3.new(0, aA * 3, 0))
			if getPlacedBlock(aB) then
				return false
			end
		end
		return true
	end
	local function getSmartSuffocationBlocks(az)
		local aA, aB, aC = az.RootPart.Position, az.Head.Position, {}
		local aD, aE = countSurroundingBlocks(aA), isInVoid(aA)
		if aD >= 1 and aD <= 2 then
			for aF, aG in Enum.NormalId:GetEnumItems() do
				if aG == Enum.NormalId.Top or aG == Enum.NormalId.Bottom then
					continue
				end
				local aH = fixPosition(aA + Vector3.fromNormalId(aG) * 2)
				if not getPlacedBlock(aH) then
					table.insert(aC, aH)
				end
			end
			table.insert(aC, fixPosition(aB))
			table.insert(aC, fixPosition(aA - Vector3.new(0, 3, 0)))
		elseif aE then
			table.insert(aC, fixPosition(aA - Vector3.new(0, 3, 0)))
			table.insert(aC, fixPosition(aB + Vector3.new(0, 3, 0)))
			for aF, aG in Enum.NormalId:GetEnumItems() do
				if aG == Enum.NormalId.Top or aG == Enum.NormalId.Bottom then
					continue
				end
				local aH = fixPosition(aA + Vector3.fromNormalId(aG) * 2)
				table.insert(aC, aH)
			end
			table.insert(aC, fixPosition(aB))
		elseif aD == 3 then
			for aF, aG in Enum.NormalId:GetEnumItems() do
				if aG == Enum.NormalId.Top or aG == Enum.NormalId.Bottom then
					continue
				end
				local aH = fixPosition(aA + Vector3.fromNormalId(aG) * 2)
				if not getPlacedBlock(aH) then
					table.insert(aC, aH)
				end
			end
			table.insert(aC, fixPosition(aB))
			table.insert(aC, fixPosition(aA - Vector3.new(0, 3, 0)))
		elseif aD >= 4 then
			table.insert(aC, fixPosition(aB))
			table.insert(aC, fixPosition(aA - Vector3.new(0, 3, 0)))
		else
			table.insert(aC, fixPosition(aA - Vector3.new(0, 3, 0)))
			for aF, aG in Enum.NormalId:GetEnumItems() do
				if aG == Enum.NormalId.Top or aG == Enum.NormalId.Bottom then
					continue
				end
				local aH = fixPosition(aA + Vector3.fromNormalId(aG) * 2)
				table.insert(aC, aH)
			end
			table.insert(aC, fixPosition(aB))
		end
		return aC
	end
	local function getBasicSuffocationBlocks(az)
		local aA = {}
		for aB, aC in Enum.NormalId:GetEnumItems() do
			aC = Vector3.fromNormalId(aC)
			if aC.Y ~= 0 then
				continue
			end
			aC = fixPosition(az.RootPart.Position + aC * 2)
			if not getPlacedBlock(aC) then
				table.insert(aA, aC)
			end
		end
		if # aA < 3 then
			table.insert(aA, fixPosition(az.Head.Position))
			table.insert(aA, fixPosition(az.RootPart.Position - Vector3.new(0, 1, 0)))
		end
		return aA
	end
	ar = v.Categories.World:CreateModule{
		Name = 'AutoSuffocate',
		Function = function(az)
			if az then
				repeat
					if ay.Enabled and not h:IsMouseButtonPressed(0) then
						task.wait(0.05)
						continue
					end
					local aA = L.hand.toolType == 'block' and L.hand.tool.Name or not av.Enabled and getWool()
					if aA then
						local aB = B.AllPosition{
							Part = 'RootPart',
							Range = au.Value,
							Players = true
						}
						for aC, aD in aB do
							local aE = ax.Enabled and getSmartSuffocationBlocks(aD) or getBasicSuffocationBlocks(aD)
							if aw.Enabled then
								for aF, aG in aE do
									if not getPlacedBlock(aG) then
										task.spawn(O.placeBlock, aG, aA)
									end
								end
							else
								for aF, aG in aE do
									if not getPlacedBlock(aG) then
										task.spawn(O.placeBlock, aG, aA)
										break
									end
								end
							end
						end
					end
					task.wait(aw.Enabled and 0.05 or 0.09)
				until not ar.Enabled
			end
		end,
		Tooltip = 'Places blocks on nearby confined entities'
	}
	au = ar:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 20,
		Default = 20,
		Function = function()
		end,
		Suffix = function(az)
			return az == 1 and 'stud' or 'studs'
		end
	}
	ax = ar:CreateToggle{
		Name = 'Smart Mode',
		Default = true,
		Tooltip = 'Detects scenarios: walls, void, corners, open areas'
	}
	av = ar:CreateToggle{
		Name = 'Limit to Items',
		Default = true,
		Function = function()
		end
	}
	aw = ar:CreateToggle{
		Name = 'Instant Suffocate',
		Function = function()
		end,
		Tooltip = 'Instantly places all suffocation blocks instead of one at a time'
	}
	ay = ar:CreateToggle{
		Name = 'Require Mouse Down',
		Default = false,
		Function = function()
		end,
		Tooltip = 'Requires left mouse button to be held down to activate'
	}
end)
a(function()
	local ar, au
	ar = v.Categories.Kits:CreateModule{
		Name = 'MartinSpeed',
		Function = function(av)
			if av then
				local aw = O.ClientSyncEvents
				if not aw or not aw.SwordSwing then
					warn'[AEROV4] martinspeed: swordswing event not found'
					return
				end
				local ax, ay = pcall(function()
					return aw.SwordSwing:setPriority(1):connect(function(ax)
						if not ax then
							return
						end
						if ax.attackSpeed then
							ax.attackSpeed = ax.attackSpeed - 0.05
						end
						if ax.config then
							ax.config.respectAttackSpeedOverride = false
						else
							ax.config = {
								respectAttackSpeedOverride = false
							}
						end
					end)
				end)
				if ax and ay then
					au = ay
				else
					warn'[AEROV4] martinspeed: failed to hook swordswing'
				end
			else
				if au then
					pcall(function()
						au:Disconnect()
					end)
					au = nil
				end
			end
		end,
		Tooltip = 'Removes Martin/Cactus swing restriction \u{2014} swing like a normal kit'
	}
end)
a(function()
	local ar, au
	local function getSkaterController()
		local av, aw = pcall(function()
			return O.Knit.Controllers.GlacialSkaterController
		end)
		if av and aw then
			return aw
		end
		av, aw = pcall(function()
			return O.KnitClient.Controllers.GlacialSkaterController
		end)
		if av and aw then
			return aw
		end
		return nil
	end
	ar = v.Categories.Kits:CreateModule{
		Name = 'InfKrystal',
		Function = function(av)
			if av then
				au = g.Heartbeat:Connect(function()
					if not B.isAlive then
						return
					end
					local aw = getSkaterController()
					if not aw then
						return
					end
					aw:updateMomentum(100, 'newValue')
				end)
			else
				if au then
					au:Disconnect()
					au = nil
				end
				local aw = getSkaterController()
				if aw then
					pcall(function()
						aw:updateMomentum(0, 'newValue')
					end)
				end
			end
		end,
		Tooltip = 'infinfinf'
	}
end)
a(function()
	local ar, au
	ar = v.Categories.World:CreateModule{
		Name = 'AntiDizzy',
		Tooltip = 'no dizzy movement from mushrooms and toads',
		Function = function(av)
			if av then
				au = O.ForestEnvironmentCollectibleEntityController.canPickupEntity
				O.ForestEnvironmentCollectibleEntityController.canPickupEntity = function(aw, ax)
					if aw and ax then
						local ay = ax:GetAttribute'MushroomType'
						if not ay then
							return au(aw, ax)
						end
						if ay == 'Dizzy' then
							return false
						else
							return true
						end
					else
						return au(aw, ax)
					end
				end
				g:BindToRenderStep('antidizzy_kill', Enum.RenderPriority.Character.Value + 2, function()
					g:UnbindFromRenderStep'dizzy-status'
				end)
			else
				if au then
					O.ForestEnvironmentCollectibleEntityController.canPickupEntity = au
					au = nil
				end
				g:UnbindFromRenderStep'antidizzy_kill'
			end
		end
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az = (c(game:GetService'VirtualInputManager'))
	au = v.Categories.World:CreateModule{
		Name = 'AutoMushroom',
		Tooltip = 'automatically collects mushrooms with for you.',
		Function = function(aA)
			if aA then
				local aB = collection('forest_environment_plant', au)
				repeat
					for aC, aD in aB do
						local aE, aF = aD:GetAttribute'MushroomType' or 'Heal', (aD.PrimaryPart.Position - B.character.RootPart.Position).Magnitude
						if table.find(ay.ListEnabled, aE) then
							task.wait(0.1)
							continue
						end
						local aG = B.character and B.character:FindFirstChildOfClass'Humanoid'
						if aE == 'Heal' and aG and aG.Health >= aG.MaxHealth then
							task.wait(0.1)
							continue
						end
						if aF <= av.Value then
							if aw.Enabled then
								local aH = aD:FindFirstAncestorWhichIsA'ProximityPrompt'
								local aI = aH.KeyboardKeyCode
								ar:SendKeyEvent(true, aI, false, game)
								task.wait(aH.HoldDuration + math.random())
								ar:SendKeyEvent(false, aI, false, game)
							else
								if az.Enabled then
									O.GameAnimationUtil:playAnimation(t, O.AnimationType.PUNCH)
									O.ViewmodelController:playAnimation(O.AnimationType.FP_USE_ITEM)
									O.SoundManager:playSound(O.SoundList.CROP_HARVEST)
								end
								O.Client:Get'CollectCollectableEntity':SendToServer{
									id = aD:GetAttribute'Id',
									collectableName = aD.Name
								}
							end
						end
					end
					task.wait(math.max(ax.Value, 0.08))
				until not au.Enabled
			end
		end
	}
	ay = au:CreateTextList{
		Name = 'Blacklist',
		Default = {
			'Dizzy'
		}
	}
	av = au:CreateSlider{
		Name = 'Distance',
		Min = 0,
		Max = 12,
		Default = 8,
		Suffix = function(aA)
			if aA == 1 then
				return 'stud'
			end
			return 'studs'
		end
	}
	ax = au:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0.1,
		Decimal = 10
	}
	aw = au:CreateToggle{
		Name = 'Streamer Mode'
	}
	az = au:CreateToggle{
		Name = 'Animations',
		Default = true
	}
end)
a(function()
	local ar, au, av, aw, ax
	ar = v.Categories.Kits:CreateModule{
		Name = 'AutoMartin',
		Tooltip = 'Automatically fires cactus ability at nearby targets',
		Function = function(ay)
			if ay then
				repeat
					if not B.isAlive then
						task.wait(0.1)
						continue
					end
					if O.AbilityController:canUseAbility'cactus_fire' then
						local az = B.EntityPosition{
							Range = av.Value,
							Part = 'RootPart',
							Players = au.Players.Enabled,
							NPCs = au.NPCs.Enabled,
							Wallcheck = au.Walls.Enabled,
							Sort = aa.Distance
						}
						if az then
							local aA, aB = B.character.RootPart.Position, (s.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
							local aC = (az.RootPart.Position - aA) * Vector3.new(1, 0, 1)
							local aD = math.acos(math.clamp(aB:Dot(aC.Unit), - 1, 1))
							if aD > (math.rad(ax.Value) / 2) then
								task.wait(0.1)
								continue
							end
							task.wait(aw.Value)
							O.AbilityController:useAbility'cactus_fire'
							task.wait(0.5)
						end
					end
					task.wait(0.1)
				until not ar.Enabled
			end
		end
	}
	au = ar:CreateTargets{
		Players = true,
		Walls = false,
		NPCs = false
	}
	av = ar:CreateSlider{
		Name = 'Range',
		Min = 1,
		Max = 20,
		Default = 18,
		Suffix = function(ay)
			return ay == 1 and 'stud' or 'studs'
		end
	}
	ax = ar:CreateSlider{
		Name = 'Max Angle',
		Min = 1,
		Max = 360,
		Default = 360
	}
	aw = ar:CreateSlider{
		Name = 'Delay',
		Min = 0,
		Max = 2,
		Default = 0,
		Suffix = 's',
		Decimal = 10
	}
end)
a(function()
	local ar, au, av, aw, ax, ay = {}, {}, {}, {
		clay_white = Color3.fromRGB(255, 255, 255),
		wool_white = Color3.fromRGB(255, 255, 255),
		wool_red = Color3.fromRGB(255, 50, 50),
		wool_green = Color3.fromRGB(50, 255, 50),
		grass = Color3.fromRGB(50, 255, 50),
		moss_block = Color3.fromRGB(50, 255, 50),
		wool_blue = Color3.fromRGB(50, 100, 255),
		wool_yellow = Color3.fromRGB(255, 255, 50),
		wool_orange = Color3.fromRGB(255, 150, 50),
		clay_orange = Color3.fromRGB(255, 150, 50),
		wool_purple = Color3.fromRGB(180, 50, 255),
		clay_light_brown = Color3.fromRGB(200, 170, 120),
		wool_pink = Color3.fromRGB(255, 100, 200),
		wool_black = Color3.fromRGB(50, 50, 50),
		wool_cyan = Color3.fromRGB(50, 255, 255),
		wool_magenta = Color3.fromRGB(255, 50, 150),
		wool_lime = Color3.fromRGB(150, 255, 50),
		wool_brown = Color3.fromRGB(150, 75, 0),
		wood_plank_spruce = Color3.fromRGB(222, 184, 135),
		wool_light_blue = Color3.fromRGB(100, 200, 255),
		wool_gray = Color3.fromRGB(150, 150, 150),
		clay = Color3.fromRGB(220, 180, 140),
		wood = Color3.fromRGB(180, 140, 100),
		stone = Color3.fromRGB(150, 150, 150),
		andesite = Color3.fromRGB(150, 150, 150),
		cobblestone = Color3.fromRGB(150, 150, 150),
		obsidian = Color3.fromRGB(50, 30, 80),
		bedrock = Color3.fromRGB(80, 80, 80),
		tnt = Color3.fromRGB(255, 50, 50),
		sandstone = Color3.fromRGB(220, 200, 150),
		sand = Color3.fromRGB(220, 200, 150),
		wool = Color3.fromRGB(200, 200, 200),
		bed = Color3.fromRGB(200, 50, 50),
		concrete = Color3.fromRGB(180, 180, 180)
	}, {}
	local function getBlockColor(az)
		if ax[az] then
			return ax[az]
		end
		if aw[az] then
			ax[az] = aw[az]
			return aw[az]
		end
		local aA = az:lower()
		if aw[aA] then
			ax[az] = aw[aA]
			return aw[aA]
		end
		if aA:find('wool', 1, true) then
			for aB, aC in pairs(aw) do
				if aB:find('wool', 1, true) and aA:find(aB, 1, true) then
					ax[az] = aC
					return aC
				end
			end
			ax[az] = aw.wool
			return aw.wool
		end
		for aB, aC in pairs(aw) do
			if aA:find(aB, 1, true) then
				ax[az] = aC
				return aC
			end
		end
		local aB = Color3.fromRGB(150, 150, 150)
		ax[az] = aB
		return aB
	end
	local function cleanupDeadReferences()
		for az, aA in pairs(ar) do
			if not az or not az.Parent then
				ar[az] = nil
				av[az] = nil
			end
		end
	end
	local function simplifyBlock(az)
		if not az or not az.Parent or av[az] then
			return
		end
		if not ar[az] then
			ar[az] = {
				Material = az.Material,
				Color = az.Color,
				TextureID = az:IsA'MeshPart' and az.TextureID or nil,
				Textures = {}
			}
			for aA, aB in az:GetChildren() do
				if aB:IsA'Texture' or aB:IsA'Decal' then
					table.insert(ar[az].Textures, {
						Class = aB.ClassName,
						Texture = aB.Texture,
						StudsPerTileU = aB.StudsPerTileU,
						StudsPerTileV = aB.StudsPerTileV,
						Face = aB.Face,
						Transparency = aB.Transparency,
						Color3 = aB:IsA'Decal' and aB.Color3 or nil
					})
				end
			end
		end
		az.Material = Enum.Material.SmoothPlastic
		az.Color = getBlockColor(az.Name)
		for aA, aB in az:GetChildren() do
			if aB:IsA'Texture' or aB:IsA'Decal' then
				aB:Destroy()
			end
		end
		if az:IsA'MeshPart' and az.TextureID ~= '' then
			az.TextureID = ''
		end
		av[az] = true
	end
	local function restoreBlock(az)
		if not az or not az.Parent then
			ar[az] = nil
			av[az] = nil
			return
		end
		local aA = ar[az]
		if not aA then
			return
		end
		az.Material = aA.Material or Enum.Material.Plastic
		az.Color = aA.Color or Color3.fromRGB(255, 255, 255)
		if aA.TextureID and az:IsA'MeshPart' then
			az.TextureID = aA.TextureID
		end
		for aB, aC in aA.Textures do
			local aD
			if aC.Class == 'Texture' then
				aD = Instance.new'Texture'
				aD.StudsPerTileU = aC.StudsPerTileU or 1
				aD.StudsPerTileV = aC.StudsPerTileV or 1
			else
				aD = Instance.new'Decal'
				aD.Color3 = aC.Color3 or Color3.fromRGB(255, 255, 255)
			end
			aD.Texture = aC.Texture or ''
			aD.Face = aC.Face or Enum.NormalId.Front
			aD.Transparency = aC.Transparency or 0
			aD.Parent = az
		end
		ar[az] = nil
		av[az] = nil
	end
	local function isTargetBlock(az)
		if not az:IsA'BasePart' then
			return false
		end
		local aA = az.Name
		if aw[aA] then
			return true
		end
		local aB = aA:lower()
		return aB:find('wool', 1, true) or aB:find('clay', 1, true) or aB:find('wood', 1, true) or aB:find('stone', 1, true) or aB:find('glass', 1, true) or aB:find('plank', 1, true) or aB:find('bed', 1, true) or aB:find('obsidian', 1, true) or aB:find('sand', 1, true) or aB:find('end', 1, true) or aB:find('tnt', 1, true) or aB:find('barrier', 1, true) or aB:find('magic', 1, true) or aB:find('concrete', 1, true) or aB:find('_block', 1, true) or az:IsA'Seat'
	end
	local function processExistingBlocks(az)
		local aA = workspace:GetDescendants()
		task.spawn(function()
			for aB, aC in aA do
				if isTargetBlock(aC) then
					if az then
						simplifyBlock(aC)
					else
						restoreBlock(aC)
					end
				end
			end
			if not az then
				cleanupDeadReferences()
			end
		end)
	end
	local function setupBlockMonitor(az)
		for aA, aB in au do
			aB:Disconnect()
		end
		table.clear(au)
		if not az then
			return
		end
		local aA = workspace.DescendantAdded:Connect(function(aA)
			if isTargetBlock(aA) then
				simplifyBlock(aA)
			end
		end)
		table.insert(au, aA)
		local aB = 0
		local aC = g.Heartbeat:Connect(function()
			local aC = tick()
			if aC - aB >= 5 then
				aB = aC
				cleanupDeadReferences()
			end
		end)
		table.insert(au, aC)
	end
	ay = v.Categories.BoostFPS:CreateModule{
		Name = 'PotatoMode',
		Function = function(az)
			if az then
				processExistingBlocks(true)
				setupBlockMonitor(true)
			else
				processExistingBlocks(false)
				for aA, aB in au do
					aB:Disconnect()
				end
				table.clear(au)
				table.clear(ax)
				cleanupDeadReferences()
			end
		end,
		Tooltip = 'Removes block textures but keeps colors'
	}
end)
a(function()
	local ar, au, av, aw = {
		DFIntDebugDefaultTargetWorldStepsPerFrame = nil,
		DFIntMaxMissedWorldStepsRemembered = nil,
		DFIntWorldStepsOffsetAdjustRate = nil,
		DFIntDebugSendDistInSteps = nil,
		DFIntWorldStepMax = nil,
		DFIntWarpFactor = nil
	}
	local function captureDefaults()
		for ax, ay in pairs(ar) do
			local az, aA = pcall(function()
				return getfflag(ax)
			end)
			if az then
				ar[ax] = aA
			end
		end
	end
	captureDefaults()
	local function restoreFFlags()
		for ax, ay in pairs(ar) do
			if ay then
				pcall(function()
					setfflag(ax, ay)
				end)
			end
		end
	end
	local function applyFFlags(ax, ay)
		ay = math.max(ay, 1)
		local az = ax
		if az <= 1 then
			az = 1.5
		end
		local aA = - 2147483648
		local aB = aA * (az / 1000)
		local aC, aD = aB * - 1, tostring(aB)
		local aE = tostring(aC)
		pcall(function()
			setfflag('DFIntDebugDefaultTargetWorldStepsPerFrame', aD)
		end)
		pcall(function()
			setfflag('DFIntMaxMissedWorldStepsRemembered', aD)
		end)
		pcall(function()
			setfflag('DFIntWorldStepsOffsetAdjustRate', aE)
		end)
		pcall(function()
			setfflag('DFIntDebugSendDistInSteps', aD)
		end)
		pcall(function()
			setfflag('DFIntWorldStepMax', aD)
		end)
		pcall(function()
			setfflag('DFIntWarpFactor', aE)
		end)
	end
	au = v.Categories.Blatant:CreateModule{
		Name = 'FrameBuffer',
		Function = function(ax)
			if ax then
				repeat
					applyFFlags(av.Value, aw.Value)
					task.wait(1 / math.max(aw.Value, 1))
				until not au.Enabled
				restoreFFlags()
			end
		end
	}
	av = au:CreateSlider{
		Name = 'Latency',
		Min = 0,
		Max = 1000,
		Default = 250,
		Suffix = 'ms'
	}
	aw = au:CreateSlider{
		Name = 'Rate',
		Min = 1,
		Max = 360,
		Default = 60,
		Suffix = 'hz'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay = {}, {}, {
		['rbxassetid://4947108314'] = true,
		['rbxassetid://10218627926'] = true,
		['rbxassetid://10218629442'] = true,
		['rbxassetid://10214626638'] = true,
		['rbxassetid://8089691925'] = true
	}
	local function isSwordAnimation(az)
		local aA = string.lower(tostring(az))
		for aB, aC in pairs(av) do
			if string.find(aA, string.lower(aB)) then
				return true
			end
		end
		return false
	end
	local function setAnimationChoppiness(az, aA)
		if not az then
			return
		end
		local aB = az:FindFirstChildOfClass'Humanoid'
		if not aB then
			return
		end
		local aC = aB:FindFirstChildOfClass'Animator'
		if not aC then
			return
		end
		local aD = aC:GetPlayingAnimationTracks()
		for aE, aF in pairs(aD) do
			if aF.Animation and isSwordAnimation(aF.Animation.AnimationId) then
				if not ar[aF] then
					ar[aF] = aF.Speed or 1
				end
				if aA == 'Choppy' then
					pcall(function()
						aF:AdjustSpeed(2)
					end)
				elseif aA == 'Very Choppy' then
					pcall(function()
						aF:AdjustSpeed(3)
					end)
				elseif aA == 'No Animation' then
					pcall(function()
						aF:Stop()
					end)
				else
					pcall(function()
						aF:AdjustSpeed(ar[aF] or 1)
					end)
				end
				au[aF] = true
			end
		end
	end
	local function applyToAllPlayers(az)
		for aA, aB in pairs(game.Players:GetPlayers()) do
			if aB ~= t or ay.Enabled then
				if aB.Character then
					setAnimationChoppiness(aB.Character, az)
				end
			end
		end
	end
	local function restoreAllAnimations()
		for az, aA in pairs(au) do
			if az then
				pcall(function()
					local aB = ar[az] or 1
					az:AdjustSpeed(aB)
				end)
			end
		end
		ar = {}
		au = {}
	end
	aw = v.Categories.Render:CreateModule{
		Name = 'AnimChopper',
		Function = function(az)
			if az then
				applyToAllPlayers(ax.Value)
				local aA = 0
				aw:Clean(g.Heartbeat:Connect(function()
					if aw.Enabled then
						aA = aA + 1
						if aA % 20 == 0 then
							applyToAllPlayers(ax.Value)
						end
					end
				end))
				aw:Clean(game.Players.PlayerAdded:Connect(function(aB)
					if aw.Enabled and (aB ~= t or ay.Enabled) then
						aB.CharacterAdded:Connect(function(aC)
							task.wait(0.5)
							if aw.Enabled then
								setAnimationChoppiness(aC, ax.Value)
							end
						end)
					end
				end))
				for aB, aC in pairs(game.Players:GetPlayers()) do
					if (aC ~= t or ay.Enabled) and aC.Character then
						aw:Clean(aC.CharacterAdded:Connect(function(aD)
							task.wait(0.5)
							if aw.Enabled then
								setAnimationChoppiness(aD, ax.Value)
							end
						end))
					end
				end
			else
				restoreAllAnimations()
			end
		end,
		Tooltip = 'Makes sword swing animations choppy (for you and others)'
	}
	ax = aw:CreateDropdown{
		Name = 'Mode',
		List = {
			'Choppy',
			'Very Choppy',
			'No Animation'
		},
		Default = 'Choppy',
		Tooltip = 'Choppy: 2x speed\nVery Choppy: 3x speed\nNo Animation: Disables sword animations',
		Function = function(az)
			if aw.Enabled then
				restoreAllAnimations()
				applyToAllPlayers(az)
			end
		end
	}
	ay = aw:CreateToggle{
		Name = 'Test On Self',
		Default = true,
		Tooltip = 'Apply choppy sword animations to yourself (for testing)',
		Function = function(az)
			if aw.Enabled then
				if az then
					if t.Character then
						setAnimationChoppiness(t.Character, ax.Value)
					end
				else
					if t.Character then
						setAnimationChoppiness(t.Character, 'Normal')
					end
				end
			end
		end
	}
end)
a(function()
	local ar, au, av
	ar = v.Categories.Kits:CreateModule{
		Name = 'Davey Extender',
		Function = function(aw)
			if aw then
				av = debug.getconstant(O.CannonHandController.launchSelf, 15)
				debug.setconstant(O.CannonHandController.launchSelf, 15, au.Value)
			else
				if av then
					debug.setconstant(O.CannonHandController.launchSelf, 15, av)
					av = nil
				end
			end
		end
	}
	au = ar:CreateSlider{
		Name = 'Mutipler',
		Min = 0,
		Max = 4,
		Default = 0.5,
		Decimal = 10,
		Function = function(aw)
			if av then
				debug.setconstant(O.CannonHandController.launchSelf, 15, aw)
			else
				av = debug.getconstant(O.CannonHandController.launchSelf, 15)
				debug.setconstant(O.CannonHandController.launchSelf, 15, au.Value)
			end
		end
	}
end)
a(function()
	local ar, au, av, aw
	ar = v.Categories.Kits:CreateModule{
		Name = 'InfiniteSigird',
		Tooltip = 'may be buggy',
		Function = function(ax)
			if ax then
				au = O.AbilityController.addProgress
				av = O.AbilityController.getProgress
				aw = O.AbilityController.setProgress
				O.AbilityController.addProgress = function(ay, az, aA)
					if az == 'elk_mounted' then
						ay:setProgress(az, math.huge - 2)
					else
						return au(ay, az, aA)
					end
				end
				O.AbilityController.getProgress = function(ay, az)
					if az == 'elk_mounted' then
						return math.huge
					else
						return av(ay, az)
					end
				end
				O.AbilityController.setProgress = function(ay, az, aA)
					if az == 'elk_mounted' then
						aA = math.huge
						return aw(ay, math.huge, aA)
					else
						return aw(ay, az, aA)
					end
				end
			else
				O.AbilityController.addProgress = au
				O.AbilityController.getProgress = av
				O.AbilityController.setProgress = aw
				au = nil
				av = nil
				aw = nil
			end
		end
	}
end)
a(function()
	local ar, au, av = {
		Value = 500
	}
	au = v.Categories.Render:CreateModule{
		Name = 'ZoomUncapper',
		Function = function(aw)
			if aw then
				av = t.CameraMaxZoomDistance
				t.CameraMaxZoomDistance = ar.Value
			else
				if av then
					t.CameraMaxZoomDistance = av
				end
			end
		end,
		Tooltip = 'Uncaps camera zoom distance'
	}
	ar = au:CreateSlider{
		Name = 'Zoom Distance',
		Min = 20,
		Max = 600,
		Default = 100,
		Function = function(aw)
			if au.Enabled then
				t.CameraMaxZoomDistance = aw
			end
		end
	}
end)
a(function()
	local ar
	local function ensureAttribute()
		local au = game:GetService'Workspace'
		if au:GetAttribute'RbxLegacyAnimationBlending' == nil then
			au:SetAttribute('RbxLegacyAnimationBlending', false)
		end
	end
	local function setLegacyAnimation(au)
		local av = game:GetService'Workspace'
		ensureAttribute()
		av:SetAttribute('RbxLegacyAnimationBlending', au)
	end
	ar = v.Categories.Render:CreateModule{
		Name = 'LegacyAnimation',
		Function = function(au)
			if au then
				ensureAttribute()
				setLegacyAnimation(true)
			else
				setLegacyAnimation(false)
			end
		end,
		Tooltip = 'Enables Roblox legacy animation blending'
	}
end)
a(function()
	local ar, au, av, aw
	ar = v.Categories.Kits:CreateModule{
		Name = 'InfiniteMilo',
		Tooltip = 'infinfinf!!',
		Function = function(ax)
			if ax then
				au = O.AbilityController.addProgress
				av = O.AbilityController.getProgress
				aw = O.AbilityController.setProgress
				O.AbilityController.addProgress = function(ay, az, aA)
					if az == 'MIMIC_BLOCK_HIDDEN' then
						ay:setProgress(az, math.huge - 2)
					else
						return au(ay, az, aA)
					end
				end
				O.AbilityController.getProgress = function(ay, az)
					if az == 'MIMIC_BLOCK_HIDDEN' then
						return math.huge
					else
						return av(ay, az)
					end
				end
				O.AbilityController.setProgress = function(ay, az, aA)
					if az == 'MIMIC_BLOCK_HIDDEN' then
						aA = math.huge
						return aw(ay, math.huge, aA)
					else
						return aw(ay, az, aA)
					end
				end
			else
				O.AbilityController.addProgress = au
				O.AbilityController.getProgress = av
				O.AbilityController.setProgress = aw
				au = nil
				av = nil
				aw = nil
			end
		end
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK = {
		AutoStomp = nil,
		AutoKick = nil,
		NoSlow = nil,
		NoSlowOld1 = nil,
		NoSlowOld2 = nil,
		AutoKickOld1 = nil
	}
	local function Kickfunc(aM, aN)
		if not ar.AutoKickOld1 then
			ar.AutoKickOld1 = O.Client.Get
		end
		O.Client.Get = function(aO, aP)
			local aQ = ar.AutoKickOld1(aO, aP)
			if aP == 'TryBlockKick' then
				return {
					instance = aQ.instance,
					SendToServer = function(aR, aS, ...)
						local aT
						if aC.Enabled then
							local aU, aV = (aE and aE.Value or 100) / 100, (aD and aD.Value or 100) / 100
							aT = Vector3.new(aM.X * aV, aM.Y * aU, aM.Z)
						else
							aT = aM
						end
						aS.direction = aT
						aS.originPosition = aN
						return aQ:SendToServer(aS, ...)
					end
				}
			end
			return aQ
		end
	end
	au = v.Categories.Kits:CreateModule{
		Name = 'AutoTerra',
		Function = function(aM)
			if aM then
				if ar.AutoStomp then
					task.cancel(ar.AutoStomp)
				end
				if ar.AutoKick then
					task.cancel(ar.AutoKick)
				end
				if ar.NoSlow then
					task.cancel(ar.NoSlow)
				end
				ar.NoSlow = task.spawn(function()
					if aw.Enabled then
						ar.NoSlowOld1 = debug.getconstant(O.BlockKickerKitController.onAbilityUsed, 38)
						debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 38, 1)
					end
					if ax.Enabled then
						ar.NoSlowOld2 = debug.getconstant(O.BlockKickerKitController.onAbilityUsed, 18)
						debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 18, 0)
					end
				end)
				ar.AutoStomp = task.spawn(function()
					repeat
						if B.isAlive then
							local aN = 0
							if t.Character then
								aN = t.Character:GetAttribute'BlockKickerKit_BlockCount' or t:GetAttribute'BlockKickerKit_BlockCount' or 0
							else
								aN = t:GetAttribute'BlockKickerKit_BlockCount' or 0
							end
							if aN <= az.Value and O.AbilityController:canUseAbility'BLOCK_STOMP' then
								O.AbilityController:useAbility'BLOCK_STOMP'
								task.wait(0.8)
							end
						end
						task.wait(0.1)
					until not au.Enabled
				end)
				ar.AutoKick = task.spawn(function()
					local aN, aO, aP, aQ = false, 0
					if not ar.AutoKickOld1 then
						ar.AutoKickOld1 = O.Client.Get
					end
					repeat
						if aI.Enabled then
							local aR, aS, aT = false, (aQ.Player and aJ.Players.Enabled) or (aQ.NPC and aJ.NPCs.Enabled), aQ.RootPart and (aQ.RootPart.Position - B.character.RootPart.Position).Magnitude
							local aU, aV, aW = aT and aT <= aB.Value, (aQ.RootPart.Position - B.character.RootPart.Position), B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
							local aX = aV * Vector3.new(1, 0, 1)
							if aX.Magnitude > 0.001 then
								local aY = math.acos(math.clamp(aW:Dot(aX.Unit), - 1, 1))
								if aY < (math.rad(aF.Value) / 2) then
									aR = true
								else
									aR = false
								end
							else
								aR = false
							end
							if aS and aU and aR then
								aN = true
								aP = aQ
							else
								aN = false
								aP = aQ
							end
						end
						if not aP then
							aP = B.AllPosition{
								Range = aB.Value,
								Wallcheck = aJ.Walls.Enabled,
								Part = 'RootPart',
								Players = aJ.Players.Enabled,
								NPCs = aJ.NPCs.Enabled,
								Limit = aK.Value,
								Sort = aa[Sort.Value]
							}
						end
						if not aP then
							task.wait(0.8)
							continue
						end
						local aR, aS = (aP.RootPart.Position - B.character.RootPart.Position).Magnitude, B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
						local aT = aR * Vector3.new(1, 0, 1)
						if aT.Magnitude > 0.001 then
							local aU = math.acos(math.clamp(aS:Dot(aT.Unit), - 1, 1))
							if aU < (math.rad(aF.Value) / 2) then
								aN = true
							else
								aN = false
							end
						else
							aN = false
						end
						if aN and aP then
							if t.Character then
								aO = t.Character:GetAttribute'BlockKickerKit_BlockCount' or t:GetAttribute'BlockKickerKit_BlockCount' or 0
							else
								aO = t:GetAttribute'BlockKickerKit_BlockCount' or 0
							end
							if aO >= 1 and O.AbilityController:canUseAbility'BLOCK_KICK' then
								local aU, aV = (aP.RootPart.Position - B.character.RootPart.Position).Unit, B.character.RootPart.Position
								Kickfunc(CFrame.lookAt(aV, aU), aV)
								O.AbilityController:useAbility'BLOCK_KICK'
							end
						end
						task.wait(aG.Value)
					until not au.Enabled
				end)
			else
				if ar.AutoStomp then
					task.cancel(ar.AutoStomp)
				end
				if ar.AutoKick then
					task.cancel(ar.AutoKick)
				end
				if ar.NoSlow then
					task.cancel(ar.NoSlow)
				end
				if ar.NoSlowOld1 then
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 38, ar.NoSlowOld1)
				end
				if ar.NoSlowOld2 then
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 18, ar.NoSlowOld2)
				end
				if ar.AutoKickOld1 then
					O.Client.Get = ar.AutoKickOld1
				end
				ar.AutoKickOld1 = nil
				ar.NoSlowOld2 = nil
				ar.NoSlowOld1 = nil
				ar.NoSlow = nil
				ar.AutoKick = nil
				ar.AutoStomp = nil
			end
		end
	}
	ay = au:CreateToggle{
		Name = 'AutoStomp',
		Tooltip = 'enables the auto-stomp feature',
		Default = true,
		Function = function(aM)
			if az and az.Object then
				az.Object.Visible = aM
			end
			if aM then
				if ar.AutoStomp then
					task.cancel(ar.AutoStomp)
				end
				ar.AutoStomp = task.spawn(function()
					repeat
						if B.isAlive then
							local aN = 0
							if t.Character then
								aN = t.Character:GetAttribute'BlockKickerKit_BlockCount' or t:GetAttribute'BlockKickerKit_BlockCount' or 0
							else
								aN = t:GetAttribute'BlockKickerKit_BlockCount' or 0
							end
							if aN <= az.Value and O.AbilityController:canUseAbility'BLOCK_STOMP' then
								O.AbilityController:useAbility'BLOCK_STOMP'
								task.wait(0.8)
							end
						end
						task.wait(0.1)
					until not aM
				end)
			else
				if ar.AutoStomp then
					task.cancel(ar.AutoStomp)
				end
			end
		end
	}
	az = au:CreateSlider{
		Name = 'Block Thershold',
		Tooltip = 'how much blocks it will stomp again',
		Min = 0,
		Max = 5,
		Default = 2,
		Darker = true,
		Visible = ay.Enabled
	}
	av = au:CreateToggle{
		Name = 'NoSlow',
		Tooltip = 'enables the no-slow feature',
		Default = false,
		Function = function(aM)
			if aw and aw.Enabled then
				aw.Enabled = aM
			end
			if ax and ax.Enabled then
				ax.Enabled = aM
			end
			if aM then
				if ar.NoSlow then
					task.cancel(ar.NoSlow)
				end
				ar.NoSlow = task.spawn(function()
					if aw.Enabled then
						ar.NoSlowOld1 = debug.getconstant(O.BlockKickerKitController.onAbilityUsed, 38)
						debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 38, 1)
					end
					if ax.Enabled then
						ar.NoSlowOld2 = debug.getconstant(O.BlockKickerKitController.onAbilityUsed, 18)
						debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 18, 0)
					end
				end)
			else
				if ar.NoSlow then
					task.cancel(ar.NoSlow)
				end
			end
		end
	}
	ax = au:CreateToggle{
		Name = 'NoSlow Stomp',
		Tooltip = 'enables the no-slow feature for stomping',
		Default = false,
		Function = function(aM)
			if aM then
				if ar.NoSlowOld2 then
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 18, 0)
				else
					ar.NoSlowOld2 = debug.getconstant(O.BlockKickerKitController.onAbilityUsed, 18)
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 18, 0)
				end
			else
				if ar.NoSlowOld2 then
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 18, ar.NoSlowOld2)
				end
				ar.NoSlowOld2 = nil
			end
		end
	}
	aw = au:CreateToggle{
		Name = 'NoSlow Kick',
		Tooltip = 'enables the no-slow feature for kicking blocks',
		Default = true,
		Function = function(aM)
			if aM then
				if ar.NoSlowOld1 then
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 38, 0)
				else
					ar.NoSlowOld1 = debug.getconstant(O.BlockKickerKitController.onAbilityUsed, 38)
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 38, 1)
				end
			else
				if ar.NoSlowOld1 then
					debug.setconstant(O.BlockKickerKitController.onAbilityUsed, 38, ar.NoSlowOld1)
				end
				ar.NoSlowOld1 = nil
			end
		end
	}
	aA = au:CreateToggle{
		Name = 'AutoKick',
		Tooltip = 'enables the auto-kick feature',
		Default = false,
		Function = function(aM)
			if aB and aB.Object then
				aB.Object.Visible = aM
			end
			if aC and aC.Object then
				aC.Object.Visible = aM
			end
			if aC and aC.Object then
				aC.Object.Visible = aM
			end
			if aF and aF.Object then
				aF.Object.Visible = aM
			end
			if aG and aG.Object then
				aG.Object.Visible = aM
			end
			if aH and aH.Object then
				aH.Object.Visible = aM
			end
			if aI and aI.Object then
				aI.Object.Visible = aM
			end
			if aJ and aJ.Object then
				aJ.Object.Visible = aM
			end
			if aM then
				if ar.AutoKick then
					task.cancel(ar.AutoKick)
				end
				ar.AutoKick = task.spawn(function()
					local aN, aO, aP, aQ = false, 0
					if not ar.AutoKickOld1 then
						ar.AutoKickOld1 = O.Client.Get
					end
					repeat
						if aI.Enabled then
							local aR, aS, aT = false, (aQ.Player and aJ.Players.Enabled) or (aQ.NPC and aJ.NPCs.Enabled), aQ.RootPart and (aQ.RootPart.Position - B.character.RootPart.Position).Magnitude
							local aU, aV, aW = aT and aT <= aB.Value, (aQ.RootPart.Position - B.character.RootPart.Position), B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
							local aX = aV * Vector3.new(1, 0, 1)
							if aX.Magnitude > 0.001 then
								local aY = math.acos(math.clamp(aW:Dot(aX.Unit), - 1, 1))
								if aY < (math.rad(aF.Value) / 2) then
									aR = true
								else
									aR = false
								end
							else
								aR = false
							end
							if aS and aU and aR then
								aN = true
								aP = aQ
							else
								aN = false
								aP = aQ
							end
						end
						if not aP then
							aP = B.AllPosition{
								Range = aB.Value,
								Wallcheck = aJ.Walls.Enabled,
								Part = 'RootPart',
								Players = aJ.Players.Enabled,
								NPCs = aJ.NPCs.Enabled,
								Limit = aK.Value,
								Sort = aa[Sort.Value]
							}
						end
						if not aP then
							task.wait(0.8)
							continue
						end
						local aR, aS = (aP.RootPart.Position - B.character.RootPart.Position).Magnitude, B.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
						local aT = aR * Vector3.new(1, 0, 1)
						if aT.Magnitude > 0.001 then
							local aU = math.acos(math.clamp(aS:Dot(aT.Unit), - 1, 1))
							if aU < (math.rad(aF.Value) / 2) then
								aN = true
							else
								aN = false
							end
						else
							aN = false
						end
						if aN and aP then
							if t.Character then
								aO = t.Character:GetAttribute'BlockKickerKit_BlockCount' or t:GetAttribute'BlockKickerKit_BlockCount' or 0
							else
								aO = t:GetAttribute'BlockKickerKit_BlockCount' or 0
							end
							if aO >= 1 and O.AbilityController:canUseAbility'BLOCK_KICK' then
								local aU, aV = (aP.RootPart.Position - B.character.RootPart.Position).Unit, B.character.RootPart.Position
								Kickfunc(CFrame.lookAt(aV, aU), aV)
								O.AbilityController:useAbility'BLOCK_KICK'
							end
						end
						task.wait(aG.Value)
					until not aM
				end)
			else
				if ar.AutoKick then
					task.cancel(ar.AutoKick)
				end
			end
		end
	}
	aJ = au:CreateTargets{
		Players = true,
		NPCs = true,
		Darker = true,
		Visible = aA.Enabled
	}
	aB = au:CreateSlider{
		Name = 'Kick Range',
		Min = 0,
		Max = 32,
		Default = 16,
		Suffix = 'studs',
		Darker = true,
		Visible = aA.Enabled
	}
	aC = au:CreateToggle{
		Name = 'Custom Predicitions',
		Default = false,
		Visible = aA.Enabled,
		Function = function(aM)
			if aD and aD.Object then
				aD.Object.Visible = aM
			end
			if aE and aE.Object then
				aE.Object.Visible = aM
			end
		end
	}
	aE = au:CreateSlider{
		Name = 'Horizontal Multiplier',
		Min = 0,
		Max = 200,
		Default = 100,
		Suffix = '%',
		Darker = true,
		Visible = aC.Enabled,
		Tooltip = 'Adjust horizontal prediction strength (0% = none, 100% = normal, 200% = double)'
	}
	aD = au:CreateSlider{
		Name = 'Vertical Multiplier',
		Min = 0,
		Max = 200,
		Default = 100,
		Suffix = '%',
		Darker = true,
		Visible = aC.Enabled,
		Tooltip = 'Adjust vertical prediction strength (0% = none, 100% = normal, 200% = double)'
	}
	aK = au:CreateSlider{
		Name = 'Max Targets',
		Min = 1,
		Max = 10,
		Default = 1,
		Darker = true,
		Visible = aA.Enabled
	}
	Sort = au:CreateDropdown{
		Name = 'Sort Method',
		List = {
			'Distance',
			'Damage',
			'Threat',
			'Kit',
			'Health',
			'Cursor',
			'Forest'
		},
		Default = 'Distance',
		Tooltip = 'Prioritize targets when multiple are in range',
		Darker = true,
		Visible = aA.Enabled
	}
	aF = au:CreateSlider{
		Name = 'Angle',
		Min = 0,
		Max = 360,
		Default = 360,
		Darker = true,
		Visible = aA.Enabled
	}
	aG = au:CreateSlider{
		Name = 'Kick Delay',
		Min = 0,
		Max = 5,
		Default = 0.5,
		Decimal = 10,
		Suffix = 's',
		Darker = true,
		Visible = aA.Enabled
	}
	aI = au:CreateToggle{
		Name = 'use Killaura Target',
		Default = false,
		Darker = true,
		Visible = aA.Enabled
	}
end)
a(function()
	local ar, au = {
		fish_iron = 'Iron Fish',
		fish_diamond = 'Diamond Fish',
		fish_emerald = 'Emerald Fish',
		fish_special = 'Special Fish',
		fish_gold = 'Gold Fish'
	}
	au = v.Categories.Utility:CreateModule{
		Name = 'FishermanESP',
		Tooltip = 'shows what fish you are catching before the minigame starts',
		Function = function(av)
			if av then
				local aw = O.Client:WaitFor(P.FishFound):expect()
				au:Clean(aw:Connect(function(ax)
					local ay = ax.dropData
					local az = ay.drops and ay.drops[1]
					if ay and ay.fishModel then
						local aA, aB, aC = tostring(ay.fishModel) or 'fish_iron', tostring(az.itemType) or 'nil', tostring(az.amount) or '0'
						notif('FishermanESP', "3005655808", 12)
					end
				end))
			end
		end
	}
end)
a(function()
	local ar, au, av, aw, ax
	local function getWorldFolder()
		local ay = workspace:WaitForChild('Map', math.huge)
		local az = ay:WaitForChild('Worlds', math.huge)
		if not az then
			return nil
		end
		return az:GetChildren()[1]
	end
	ar = v.Categories.Utility:CreateModule{
		Name = 'DaveyAim',
		Function = function(ay)
			if not ay then
				return
			end
			ar:Toggle(false)
			local az = getWorldFolder()
			if not az then
				return
			end
			local aA = az:WaitForChild'Blocks'
			if aA then
				for aB, aC in aA:GetChildren() do
					if aC.Name == 'cannon' then
						local aD = aC
						local aE = (aD.Position - B.character.RootPart.Position).Magnitude
						if aE <= au.Value then
							if aw.Value == 'Mouse' then
								local aF
								aF = c(t:GetMouse())
								local aG = s:ScreenPointToRay(aF.X, aF.Y)
								aF = aG.Direction
								local aH = 0
								if ax.Value == 'Fast' then
									aH = 0.1
								elseif ax.Value == 'Normal' then
									aH = 0.4
								elseif ax.Value == 'Slow' then
									aH = 1
								else
									aH = 0.35
								end
								task.wait(aH)
								O.Client:Get(P.CannonAim):SendToServer{
									cannonBlockPos = O.BlockController:getBlockPosition(aD.Position),
									lookVector = aF
								}
								if av.Enabled then
									task.wait(math.random() * math.random() * Random.new():NextNumber() + aH)
									local aI = O.Client:Get(P.CannonLaunch):CallServer{
										cannonBlockPos = O.BlockController:getBlockPosition(aD.Position)
									}
									if aI then
										local aJ = t.Character.PrimaryPart.AssemblyMass
										t.Character.PrimaryPart:ApplyImpulse(aD:GetAttribute'LookVector' * (aJ == nil and 0 or aJ) * 200)
										local aK = getPickaxeSlot()
										if hotbarSwitch(aK) or L.hand.tool.Name:lower():find'pickaxe' then
											O.breakBlock(aD)
											O.breakBlock(aD)
											if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
												humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
											end
										end
									end
								end
							else
								local aF = 0
								if ax.Value == 'Fast' then
									aF = 0.1
								elseif ax.Value == 'Normal' then
									aF = 0.4
								elseif ax.Value == 'Slow' then
									aF = 1
								else
									aF = 0.35
								end
								task.wait(aF)
								O.Client:Get(P.CannonAim):SendToServer{
									cannonBlockPos = O.BlockController:getBlockPosition(aD.Position),
									lookVector = s.CFrame.LookVector
								}
								if av.Enabled then
									task.wait(math.random() * math.random() * Random.new():NextNumber() + aF)
									local aG = O.Client:Get(P.CannonLaunch):CallServer{
										cannonBlockPos = O.BlockController:getBlockPosition(aD.Position)
									}
									if aG then
										local aH = t.Character.PrimaryPart.AssemblyMass
										t.Character.PrimaryPart:ApplyImpulse(aD:GetAttribute'LookVector' * (aH == nil and 0 or aH) * 200)
										local aI = getPickaxeSlot()
										if hotbarSwitch(aI) or L.hand.tool.Name:lower():find'pickaxe' then
											O.breakBlock(aD)
											O.breakBlock(aD)
											if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
												humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
											end
										end
									end
								end
							end
						end
					end
				end
			else
				return
			end
		end
	}
	au = ar:CreateSlider{
		Name = 'Search Range',
		Min = 0,
		Max = 16,
		Default = 12,
		Visible = true
	}
	if h.TouchEnabled then
		list = {
			'Camera'
		}
	else
		list = {
			'Camera',
			'Mouse'
		}
	end
	aw = ar:CreateDropdown{
		Name = 'Aim Types',
		List = list,
		Default = 'Camera',
		Visible = true
	}
	ax = ar:CreateDropdown{
		Name = 'Aim Modes',
		List = {
			'Fast',
			'Normal',
			'Slow'
		},
		Default = 'Normal',
		Visible = true
	}
	av = ar:CreateToggle{
		Name = 'Auto Launch',
		Default = false
	}
end)
a(function()
	local ar, au, av, aw
	ar = v.Categories.Combat:CreateModule{
		Name = 'AutoRelease',
		Tooltip = 'Automatically release ur projectile soruce when at a certain charging percentage',
		Function = function(ax)
			if ax then
				aw = O.ProjectileController.calculateImportantLaunchValues
				O.ProjectileController.calculateImportantLaunchValues = function(ay, az, aA, aB, aC)
					local aD = az.drawDurationSeconds
					if not L.hand.tool.Name:find'bow' then
						aD = aD + math.random()
					end
					local aE = au.Value / 100 * 0.58
					if aD >= aE then
						task.spawn(function()
							task.wait(av.Value)
							mouse1click()
						end)
					end
					return aw(ay, az, aA, aB, aC)
				end
			else
				O.ProjectileController.calculateImportantLaunchValues = aw
			end
		end
	}
	au = ar:CreateSlider{
		Name = 'Percent',
		Min = 0,
		Max = 100,
		Default = 100,
		Suffix = '%'
	}
	av = ar:CreateSlider{
		Name = 'Delay Release',
		Min = 0,
		Max = 2,
		Default = 0.1,
		Suffix = 's',
		Decimal = 10
	}
end)
a(function()
	local ar, au, av, aw, ax, ay, az, aA, aB, aC, aD, aE = 0.158, 0.0045, 0.395, 0.4, 0.2, 0.4
	local function getWorldFolder()
		local aF = workspace:WaitForChild('Map', math.huge)
		local aG = aF:WaitForChild('Worlds', math.huge)
		if not aG then
			return nil
		end
		return aG:GetChildren()[1]
	end
	local function setCannonSpeeds(aF, aG, aH, aI)
		for aJ, aK in ipairs(aF:GetChildren()) do
			if aK:IsA'BasePart' and aK.Name == 'cannon' then
				local aM, aN, aO = aK:FindFirstChild'AimPrompt', aK:FindFirstChild'FirePrompt', aK:FindFirstChild'LaunchSelfPrompt'
				if aM and aN and aO then
					aM.HoldDuration = aG
					aN.HoldDuration = aH
					aO.HoldDuration = aI
				end
			end
		end
	end
	local function getPickaxeSlot()
		for aF, aG in pairs(L.inventory.hotbar) do
			if aG.item and O.ItemMeta[aG.item.itemType] then
				local aH = O.ItemMeta[aG.item.itemType]
				if aH.breakBlock then
					return aF - 1
				end
			end
		end
		return nil
	end
	BetterDavey = v.Categories.Kits:CreateModule{
		Name = 'BetterDavey',
		Tooltip = 'makes u look better with davey makes u play like me(i main davey everyday kush)',
		Function = function(aF)
			local aG = getWorldFolder()
			if not aG then
				return
			end
			local aH = aG:WaitForChild'Blocks'
			if aF then
				setCannonSpeeds(aH, ar, au, av)
				BetterDavey:Clean(aH.ChildAdded:Connect(function(aI)
					if aI:IsA'BasePart' and aI.Name == 'cannon' and BetterDavey.Enabled then
						local aJ, aK, aM = aI:WaitForChild'AimPrompt', aI:WaitForChild'FirePrompt', aI:WaitForChild'LaunchSelfPrompt'
						aJ.HoldDuration = ar
						aK.HoldDuration = au
						aM.HoldDuration = av
						BetterDavey:Clean(aM.Triggered:Connect(function(aN)
							local aO = B.character.Humanoid
							if not aO then
								return
							end
							if A.Enabled and ah.Enabled then
								ah:Toggle(false)
								task.wait(0.025)
								A:Toggle(false)
							elseif A.Enabled then
								A:Toggle(false)
							elseif ah.Enabled then
								ah:Toggle(false)
							end
							if aE.Enabled then
								local aP = getPickaxeSlot()
								if hotbarSwitch(aP) or L.hand.tool.Name:lower():find'pickaxe' then
									task.spawn(O.breakBlock, aI, false, nil, true)
									task.spawn(O.breakBlock, aI, false, nil, true)
								end
							else
								task.spawn(O.breakBlock, aI, false, nil, true)
								task.spawn(O.breakBlock, aI, false, nil, true)
							end
							if aD.Enabled then
								if aO:GetState() ~= Enum.HumanoidStateType.Jumping then
									aO:ChangeState(Enum.HumanoidStateType.Jumping)
								end
							end
						end))
					end
				end))
				for aI, aJ in aH:GetChildren() do
					if aJ:IsA'BasePart' and aJ.Name == 'cannon' and BetterDavey.Enabled then
						local aK, aM, aN = aJ:WaitForChild'AimPrompt', aJ:WaitForChild'FirePrompt', aJ:WaitForChild'LaunchSelfPrompt'
						aK.HoldDuration = ar
						aM.HoldDuration = au
						aN.HoldDuration = av
						BetterDavey:Clean(aN.Triggered:Connect(function(aO)
							local aP = B.character.Humanoid
							if not aP then
								return
							end
							if A.Enabled and ah.Enabled then
								ah:Toggle(false)
								task.wait(0.025)
								A:Toggle(false)
							elseif A.Enabled then
								A:Toggle(false)
							elseif ah.Enabled then
								ah:Toggle(false)
							end
							if aE.Enabled then
								local aQ = getPickaxeSlot()
								if hotbarSwitch(aQ) or L.hand.tool.Name:lower():find'pickaxe' then
									task.spawn(O.breakBlock, aJ, false, nil, true)
									task.spawn(O.breakBlock, aJ, false, nil, true)
								end
							else
								task.spawn(O.breakBlock, aJ, false, nil, true)
								task.spawn(O.breakBlock, aJ, false, nil, true)
							end
							if aD.Enabled then
								if aP:GetState() ~= Enum.HumanoidStateType.Jumping then
									aP:ChangeState(Enum.HumanoidStateType.Jumping)
								end
							end
						end))
					end
				end
			else
				setCannonSpeeds(aH, aw, ax, ay)
			end
		end
	}
	aD = BetterDavey:CreateToggle{
		Name = 'Auto-Jump',
		Default = true,
		Visible = true
	}
	aE = BetterDavey:CreateToggle{
		Name = 'Auto-Switch',
		Default = false,
		Visible = true
	}
	az = BetterDavey:CreateSlider{
		Name = 'Aim',
		Visible = false,
		Min = 0,
		Max = 1,
		Default = ar,
		Decimal = 10,
		Function = function(aF)
			ar = aF
			local aG = getWorldFolder()
			if not aG then
				return
			end
			local aH = aG:WaitForChild'Blocks'
			setCannonSpeeds(aH, ar, au, av)
		end
	}
	aA = BetterDavey:CreateSlider{
		Name = 'Tnt',
		Visible = false,
		Min = 0,
		Max = 1,
		Default = au,
		Decimal = 10,
		Function = function(aF)
			au = aF
			local aG = getWorldFolder()
			if not aG then
				return
			end
			local aH = aG:WaitForChild'Blocks'
			setCannonSpeeds(aH, ar, au, av)
		end
	}
	aB = BetterDavey:CreateSlider{
		Name = 'Launch Self',
		Visible = false,
		Min = 0,
		Max = 1,
		Default = av,
		Decimal = 10,
		Function = function(aF)
			av = aF
			local aG = getWorldFolder()
			if not aG then
				return
			end
			local aH = aG:WaitForChild'Blocks'
			setCannonSpeeds(aH, ar, au, av)
		end
	}
	aC = BetterDavey:CreateToggle{
		Name = 'Customize',
		Default = false,
		Visible = true,
		Function = function(aF)
			az.Object.Visible = aF
			aA.Object.Visible = aF
			aB.Object.Visible = aF
			if not aF then
				ar = 0.158
				au = 0.0045
				av = 0.395
			end
		end
	}
end)
a(function()
	local ar
	ar = v.Categories.Exploits:CreateModule{
		Name = 'AntiMagma',
		Tooltip = 'allows you not to be instantly killed by magma',
		Function = function(au)
			if au then
				repeat
					for av, aw in workspace:GetDescendants() do
						if aw:IsA'BasePart' then
							if string.find(string.lower(aw.Name), 'magma') then
								for ax, ay in aw:GetDescendants() do
									if ay:IsA'TouchTransmitter' then
										ay:Destory()
									end
								end
							end
						end
					end
					task.wait(0.05)
				until not ar.Enabled
			end
		end
	}
end)
a(function()
	v.Categories.Render:CreateModule{
		Name = 'Ambience 2',
		Function = function(ar)
			local au = game:GetService'Lighting'
			if ar then
				local av = Instance.new'Sky'
				av.Name = 'Ambience2_Sky'
				local aw = 'rbxassetid://121826915456627'
				av.SkyboxBk = aw
				av.SkyboxDn = aw
				av.SkyboxFt = aw
				av.SkyboxLf = aw
				av.SkyboxRt = aw
				av.SkyboxUp = aw
				av.Parent = au
			else
				local av = au:FindFirstChild'Ambience2_Sky'
				if av then
					av:Destroy()
				end
			end
		end,
		Tooltip = 'Ambience 2'
	}
end)
a(function()
	local ar, au, av, aw, ax, ay = 50, tick(), (RaycastParams.new())
	av.RespectCanCollide = true
	aw = v.Categories.Blatant:CreateModule{
		Name = 'InfiniteJump2.0',
		Tooltip = 'Infinite jump + TP Down',
		Function = function(az)
			if az then
				au = tick()
				ay = nil
				aw:Clean(h.InputBegan:Connect(function(aA, aB)
					if aB then
						return
					end
					if aA.UserInputType == Enum.UserInputType.Keyboard and aA.KeyCode == Enum.KeyCode.Space then
						while h:IsKeyDown(Enum.KeyCode.Space) and aw.Enabled do
							if B.isAlive and t.Character and t.Character.PrimaryPart then
								local aC = t.Character.PrimaryPart
								aC.Velocity = Vector3.new(aC.Velocity.X, ar, aC.Velocity.Z)
							end
							task.wait()
						end
					end
				end))
				if h.TouchEnabled then
					local aA, aB = false, t.PlayerGui:WaitForChild'TouchGui':WaitForChild'TouchControlFrame':WaitForChild'JumpButton'
					aw:Clean(aB.MouseButton1Down:Connect(function()
						aA = true
					end))
					aw:Clean(aB.MouseButton1Up:Connect(function()
						aA = false
					end))
					aw:Clean(g.RenderStepped:Connect(function()
						if aA and B.isAlive and aw.Enabled then
							local aC = t.Character.PrimaryPart
							aC.Velocity = Vector3.new(aC.Velocity.X, ar, aC.Velocity.Z)
						end
					end))
				end
				aw:Clean(g.PreSimulation:Connect(function()
					if B.isAlive and t.Character and t.Character.PrimaryPart then
						local aA = t.Character.PrimaryPart
						av.FilterDescendantsInstances = {
							t.Character,
							s,
							z
						}
						av.CollisionGroup = aA.CollisionGroup
						if ax.Enabled then
							local aB = (tick() - B.character.AirTime)
							if aB > 2 then
								if not ay then
									local aC = workspace:Raycast(aA.Position, Vector3.new(0, - 1E3, 0), av)
									if aC then
										ay = aA.Position.Y
										au = tick() + 0.11
										aA.CFrame = CFrame.lookAlong(Vector3.new(aA.Position.X, aC.Position.Y + B.character.HipHeight, aA.Position.Z), aA.CFrame.LookVector)
									end
								end
							end
							if ay then
								if au < tick() then
									local aC = Vector3.new(aA.Position.X, ay, aA.Position.Z)
									aA.CFrame = CFrame.lookAlong(aC, aA.CFrame.LookVector)
									ay = nil
								end
							end
						end
					end
				end))
			end
		end
	}
	ax = aw:CreateToggle{
		Name = 'TP Down',
		Default = true
	}
end)
a(function()
	local ar, au, av, aw, ax = 0
	local function getGroundHit()
		local ay = f and f:FindFirstChild'rbxts_include'
		if ay then
			ay = ay:FindFirstChild'node_modules'
			if ay then
				ay = ay:FindFirstChild'@rbxts'
				if ay then
					ay = ay:FindFirstChild'net'
					if ay then
						ay = ay:FindFirstChild'out'
						if ay then
							ay = ay:FindFirstChild'_NetManaged'
							if ay then
								return ay:FindFirstChild'GroundHit'
							end
						end
					end
				end
			end
		end
		return nil
	end
	task.spawn(function()
		while not av do
			av = getGroundHit()
			if av then
				av = c(av)
			end
			task.wait(0.5)
		end
	end)
	local function Platform(ay)
		if ax then
			ax:Destroy()
		end
		local az = Instance.new'Part'
		az.Size = Vector3.new(6, 0.5, 6)
		az.Position = ay
		az.Anchored = true
		az.CanCollide = true
		az.Transparency = 1
		az.CanQuery = false
		az.Material = Enum.Material.SmoothPlastic
		az.Name = 'sigma'
		az.Parent = workspace
		return az
	end
	au = v.Categories.Blatant:CreateModule{
		Name = 'NoFall',
		Function = function(ay)
			if ay then
				ar = 0
				aw = nil
				if ax then
					ax:Destroy()
					ax = nil
				end
				au:Clean(g.PreSimulation:Connect(function()
					if not B.isAlive then
						ar = 0
						aw = nil
						return
					end
					local az, aA = B.character.RootPart, B.character.Humanoid
					if not az or not aA then
						return
					end
					local aB, aC, aD = tick(), aA.FloorMaterial ~= Enum.Material.Air, az.Position.Y
					if ar > aB then
						az.Velocity = Vector3.zero
						az.AssemblyLinearVelocity = Vector3.zero
						if aA:GetState() == Enum.HumanoidStateType.Jumping then
							aA:ChangeState(Enum.HumanoidStateType.Landed)
						end
						return
					elseif ar ~= 0 and ar <= aB then
						ar = 0
						if ax then
							ax:Destroy()
							ax = nil
						end
						if az then
							az.Velocity = Vector3.zero
							az.AssemblyLinearVelocity = Vector3.zero
						end
					end
					if aC then
						aw = nil
						return
					end
					if aw == nil then
						aw = aD
					else
						if aD > aw then
							aw = aD
						else
							local aE = aw - aD
							if aE > 20 then
								ar = aB + 0.1
								local aF = aD - 2
								local aG = Vector3.new(az.Position.X, aF, az.Position.Z)
								ax = Platform(aG)
								local aH = aF + (ax.Size.Y / 2) + 0.5
								az.CFrame = CFrame.new(az.Position.X, aH, az.Position.Z)
								if av then
									av:FireServer(ax, Vector3.zero, workspace:GetServerTimeNow())
								end
								az.Velocity = Vector3.zero
								az.AssemblyLinearVelocity = Vector3.zero
							end
						end
					end
				end))
				au:Clean(g.Heartbeat:Connect(function()
					if ar > tick() and B.isAlive then
						local az = B.character.RootPart
						if az then
							az.Velocity = Vector3.zero
							az.AssemblyLinearVelocity = Vector3.zero
						end
					end
				end))
			else
				ar = 0
				aw = nil
				if ax then
					ax:Destroy()
					ax = nil
				end
			end
		end,
		ExtraText = function()
			return 'Freeze'
		end,
		Tooltip = 'Prevents fall damage.'
	}
end)
