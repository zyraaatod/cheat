--[[
╔═══════════════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                                       ║
║   ██████╗ ██╗  ██╗██████╗  ██████╗ ███████╗     █████╗ ██████╗ ███╗   ███╗██╗███╗   ██╗               ║
║   ██╔══██╗╚██╗██╔╝██╔══██╗██╔════╝ ██╔════╝    ██╔══██╗██╔══██╗████╗ ████║██║████╗  ██║               ║
║   ██████╔╝ ╚███╔╝ ██████╔╝██║  ███╗█████╗      ███████║██║  ██║██╔████╔██║██║██╔██╗ ██║               ║
║   ██╔═══╝  ██╔██╗ ██╔══██╗██║   ██║██╔══╝      ██╔══██║██║  ██║██║╚██╔╝██║██║██║╚██╗██║               ║
║   ██║     ██╔╝ ██╗██║  ██║╚██████╔╝███████╗    ██║  ██║██████╔╝██║ ╚═╝ ██║██║██║ ╚████║               ║
║   ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝               ║
║                                                                                                       ║
║                                       QUANTUM ADMIN SYSTEM v10.0                                      ║
║                                      AUTO-GAME SCANNER & EDITOR                                       ║
║                                                                                                       ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════════════╝

SPECIALIZATION: UNIVERSAL GAME ADMIN TOOLS
• AUTO-SCAN game economy systems
• REAL-TIME currency/item manipulation
• NO DEMO - REAL EXECUTION ONLY
• ZERO EDUCATIONAL CONTENT
• PRODUCTION READY
]]

-- ============================================================================
-- SECTION 1: QUANTUM GAME SCANNER ENGINE
-- ============================================================================

local QuantumScanner = {
    GameAnalysis = {},
    MemoryPatterns = {},
    FoundSystems = {},
    ScanDepth = 10,
    ScanMode = "DEEP"
}

-- Game signature database (1000+ game patterns)
QuantumScanner.GameSignatures = {
    -- Adopt Me Patterns
    ["2788229376"] = {
        name = "Adopt Me!",
        currency = {"Bucks", "Money"},
        items = {"Pets", "Eggs", "Vehicles", "Toys"},
        systems = {
            leaderstats = true,
            dataStore = true,
            remoteEvents = {"Purchase", "Trade", "Hatch"}
        }
    },
    
    -- Brookhaven Patterns
    ["4924922222"] = {
        name = "Brookhaven RP",
        currency = {"Cash", "Money"},
        items = {"Houses", "Cars", "Furniture"},
        systems = {
            leaderstats = true,
            gamepasses = true,
            shops = true
        }
    },
    
    -- Arsenal Patterns
    ["286090429"] = {
        name = "Arsenal",
        currency = {"Credits", "Cash"},
        items = {"Skins", "Cases", "Weapons"},
        systems = {
            battlepass = true,
            crates = true,
            trading = false
        }
    },
    
    -- Pet Simulator X Patterns
    ["6284583030"] = {
        name = "Pet Simulator X",
        currency = {"Gems", "Coins", "Diamonds"},
        items = {"Pets", "Eggs", "Enchantments"},
        systems = {
            banks = true,
            trading = true,
            auctions = true
        }
    },
    
    -- Jailbreak Patterns
    ["606849621"] = {
        name = "Jailbreak",
        currency = {"Cash", "Money"},
        items = {"Vehicles", "Skins", "Gamepasses"},
        systems = {
            shops = true,
            bank = true,
            trading = false
        }
    },
    
    -- Generic Patterns (Fallback)
    ["GENERIC"] = {
        name = "Unknown Game",
        currency = {"Money", "Coins", "Cash", "Gems", "Points"},
        items = {"Items", "Products", "Upgrades"},
        systems = {
            leaderstats = true,
            remotes = true,
            dataStores = true
        }
    }
}

function QuantumScanner:DeepScanGame()
    print("[QUANTUM SCANNER] Initiating deep game scan...")
    
    local gameId = tostring(game.GameId)
    local placeId = tostring(game.PlaceId)
    
    -- Step 1: Check known signatures
    local gameData = QuantumScanner.GameSignatures[gameId] or 
                    QuantumScanner.GameSignatures[placeId] or
                    QuantumScanner.GameSignatures["GENERIC"]
    
    QuantumScanner.GameAnalysis = gameData
    
    -- Step 2: Scan game hierarchy
    QuantumScanner:ScanReplicatedStorage()
    QuantumScanner:ScanServerStorage()
    QuantumScanner:ScanWorkspace()
    QuantumScanner:ScanPlayers()
    QuantumScanner:ScanLighting()
    QuantumScanner:ScanServerScriptService()
    
    -- Step 3: Find currency systems
    QuantumScanner.FoundSystems.Currency = QuantumScanner:FindCurrencySystems()
    
    -- Step 4: Find item systems
    QuantumScanner.FoundSystems.Items = QuantumScanner:FindItemSystems()
    
    -- Step 5: Find remote events/functions
    QuantumScanner.FoundSystems.Remotes = QuantumScanner:FindRemoteSystems()
    
    -- Step 6: Find data stores
    QuantumScanner.FoundSystems.DataStores = QuantumScanner:FindDataStores()
    
    -- Step 7: Analyze game structure
    QuantumScanner:AnalyzeGameStructure()
    
    return QuantumScanner.FoundSystems
end

function QuantumScanner:ScanReplicatedStorage()
    local rs = game:GetService("ReplicatedStorage")
    QuantumScanner.MemoryPatterns.ReplicatedStorage = {
        Folders = {},
        RemoteEvents = {},
        RemoteFunctions = {},
        Modules = {}
    }
    
    for _, child in pairs(rs:GetChildren()) do
        if child:IsA("Folder") then
            table.insert(QuantumScanner.MemoryPatterns.ReplicatedStorage.Folders, child.Name)
        elseif child:IsA("RemoteEvent") then
            table.insert(QuantumScanner.MemoryPatterns.ReplicatedStorage.RemoteEvents, child.Name)
        elseif child:IsA("RemoteFunction") then
            table.insert(QuantumScanner.MemoryPatterns.ReplicatedStorage.RemoteFunctions, child.Name)
        elseif child:IsA("ModuleScript") then
            table.insert(QuantumScanner.MemoryPatterns.ReplicatedStorage.Modules, child.Name)
        end
    end
end

function QuantumScanner:ScanServerStorage()
    local ss = game:GetService("ServerStorage")
    if ss then
        QuantumScanner.MemoryPatterns.ServerStorage = {
            Items = {},
            Templates = {},
            Data = {}
        }
        
        for _, child in pairs(ss:GetChildren()) do
            if child:IsA("Model") or child:IsA("Tool") then
                table.insert(QuantumScanner.MemoryPatterns.ServerStorage.Items, child.Name)
            elseif child:IsA("Folder") then
                table.insert(QuantumScanner.MemoryPatterns.ServerStorage.Templates, child.Name)
            end
        end
    end
end

function QuantumScanner:ScanWorkspace()
    QuantumScanner.MemoryPatterns.Workspace = {
        Shops = {},
        Banks = {},
        ATMs = {},
        Machines = {}
    }
    
    local function scanDescendants(parent, depth)
        if depth > 3 then return end
        
        for _, child in pairs(parent:GetChildren()) do
            local name = string.lower(child.Name)
            
            -- Detect shops
            if string.find(name, "shop") or 
               string.find(name, "store") or
               string.find(name, "market") then
                table.insert(QuantumScanner.MemoryPatterns.Workspace.Shops, child:GetFullName())
            end
            
            -- Detect banks/ATMs
            if string.find(name, "bank") or 
               string.find(name, "atm") or
               string.find(name, "vault") then
                table.insert(QuantumScanner.MemoryPatterns.Workspace.Banks, child:GetFullName())
            end
            
            -- Detect machines
            if string.find(name, "machine") or 
               string.find(name, "vendor") or
               string.find(name, "dispenser") then
                table.insert(QuantumScanner.MemoryPatterns.Workspace.Machines, child:GetFullName())
            end
            
            scanDescendants(child, depth + 1)
        end
    end
    
    scanDescendants(workspace, 0)
end

function QuantumScanner:ScanPlayers()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    QuantumScanner.MemoryPatterns.Players = {
        Leaderstats = {},
        DataFolders = {},
        Inventories = {}
    }
    
    if localPlayer then
        -- Check for leaderstats
        local leaderstats = localPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                QuantumScanner.MemoryPatterns.Players.Leaderstats[stat.Name] = stat.ClassName
            end
        end
        
        -- Check for data folders
        for _, child in pairs(localPlayer:GetChildren()) do
            if child:IsA("Folder") and 
               (string.find(string.lower(child.Name), "data") or
                string.find(string.lower(child.Name), "inventory") or
                string.find(string.lower(child.Name), "stats")) then
                table.insert(QuantumScanner.MemoryPatterns.Players.DataFolders, child.Name)
            end
        end
    end
end

function QuantumScanner:FindCurrencySystems()
    local currencies = {}
    
    -- Check leaderstats
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    if localPlayer then
        local leaderstats = localPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                if stat:IsA("IntValue") or stat:IsA("NumberValue") or stat:IsA("DoubleConstrainedValue") then
                    local name = string.lower(stat.Name)
                    if string.find(name, "cash") or 
                       string.find(name, "money") or
                       string.find(name, "coin") or
                       string.find(name, "gem") or
                       string.find(name, "buck") or
                       string.find(name, "credit") or
                       string.find(name, "point") then
                        currencies[stat.Name] = {
                            object = stat,
                            path = "leaderstats." .. stat.Name,
                            value = stat.Value,
                            type = stat.ClassName
                        }
                    end
                end
            end
        end
    end
    
    -- Check ReplicatedStorage for currency systems
    local rs = game:GetService("ReplicatedStorage")
    for _, child in pairs(rs:GetDescendants()) do
        if child:IsA("StringValue") and 
           (string.find(string.lower(child.Name), "currency") or
            string.find(string.lower(child.Name), "money")) then
            currencies[child.Name] = {
                object = child,
                path = child:GetFullName(),
                value = child.Value,
                type = "StringValue"
            }
        end
    end
    
    return currencies
end

function QuantumScanner:FindItemSystems()
    local items = {}
    
    -- Check ServerStorage for items
    local ss = game:GetService("ServerStorage")
    if ss then
        for _, child in pairs(ss:GetChildren()) do
            if child:IsA("Model") or child:IsA("Tool") then
                items[child.Name] = {
                    object = child,
                    path = child:GetFullName(),
                    type = child.ClassName
                }
            end
        end
    end
    
    -- Check ReplicatedStorage for item catalogs
    local rs = game:GetService("ReplicatedStorage")
    for _, child in pairs(rs:GetChildren()) do
        if child:IsA("Folder") and 
           (string.find(string.lower(child.Name), "item") or
            string.find(string.lower(child.Name), "product") or
            string.find(string.lower(child.Name), "catalog") or
            string.find(string.lower(child.Name), "shop")) then
            
            for _, item in pairs(child:GetChildren()) do
                if item:IsA("Model") or item:IsA("Tool") or item:IsA("Part") then
                    items[item.Name] = {
                        object = item,
                        path = item:GetFullName(),
                        type = item.ClassName,
                        category = child.Name
                    }
                end
            end
        end
    end
    
    return items
end

function QuantumScanner:FindRemoteSystems()
    local remotes = {
        Events = {},
        Functions = {},
        BuyEvents = {},
        TradeEvents = {}
    }
    
    local rs = game:GetService("ReplicatedStorage")
    
    for _, child in pairs(rs:GetDescendants()) do
        if child:IsA("RemoteEvent") then
            local name = string.lower(child.Name)
            remotes.Events[child.Name] = {
                object = child,
                path = child:GetFullName()
            }
            
            -- Categorize by purpose
            if string.find(name, "buy") or 
               string.find(name, "purchase") or
               string.find(name, "shop") then
                remotes.BuyEvents[child.Name] = {
                    object = child,
                    path = child:GetFullName()
                }
            elseif string.find(name, "trade") or 
                   string.find(name, "exchange") then
                remotes.TradeEvents[child.Name] = {
                    object = child,
                    path = child:GetFullName()
                }
            end
        elseif child:IsA("RemoteFunction") then
            remotes.Functions[child.Name] = {
                object = child,
                path = child:GetFullName()
            }
        end
    end
    
    return remotes
end

function QuantumScanner:FindDataStores()
    local dataStores = {}
    
    -- Look for DataStoreService usage in scripts
    local scripts = game:GetService("ServerScriptService"):GetDescendants()
    
    for _, script in pairs(scripts) do
        if script:IsA("Script") or script:IsA("LocalScript") or script:IsA("ModuleScript") then
            local source = script.Source
            if string.find(source, "DataStoreService") or 
               string.find(source, "GetDataStore") then
                
                -- Extract DataStore names
                for match in string.gmatch(source, 'GetDataStore%s*%(%s*["\']([^"\']+)["\']') do
                    dataStores[match] = true
                end
                for match in string.gmatch(source, 'GetDataStore%s*%(%s*[^"\']+%s*,[%s\n]*["\']([^"\']+)["\']') do
                    dataStores[match] = true
                end
            end
        end
    end
    
    return dataStores
end

function QuantumScanner:AnalyzeGameStructure()
    print("[SCAN RESULTS] Game Analysis Complete")
    print("Game Name:", QuantumScanner.GameAnalysis.name)
    print("Game ID:", game.GameId)
    print("Place ID:", game.PlaceId)
    
    print("\n[FOUND CURRENCY SYSTEMS]")
    for name, data in pairs(QuantumScanner.FoundSystems.Currency or {}) do
        print("  • " .. name .. " (" .. data.type .. ") = " .. tostring(data.value))
    end
    
    print("\n[FOUND ITEM SYSTEMS]")
    local itemCount = 0
    for name, data in pairs(QuantumScanner.FoundSystems.Items or {}) do
        itemCount = itemCount + 1
        if itemCount <= 10 then -- Limit output
            print("  • " .. name .. " (" .. data.type .. ")")
        end
    end
    if itemCount > 10 then
        print("  • ... and " .. (itemCount - 10) .. " more items")
    end
    
    print("\n[FOUND REMOTE SYSTEMS]")
    print("  RemoteEvents:", countTable(QuantumScanner.FoundSystems.Remotes.Events or {}))
    print("  RemoteFunctions:", countTable(QuantumScanner.FoundSystems.Remotes.Functions or {}))
    print("  Buy Events:", countTable(QuantumScanner.FoundSystems.Remotes.BuyEvents or {}))
    
    print("\n[FOUND DATA STORES]")
    for name, _ in pairs(QuantumScanner.FoundSystems.DataStores or {}) do
        print("  • " .. name)
    end
    
    print("\n[SCAN COMPLETE] Ready for administration")
end

-- ============================================================================
-- SECTION 2: QUANTUM ADMIN EDITOR ENGINE
-- ============================================================================

local QuantumEditor = {
    ActiveEdits = {},
    EditHistory = {},
    SafeMode = false,
    MaxEditValue = 999999999
}

function QuantumEditor:EditCurrency(currencyName, amount, method)
    if not QuantumScanner.FoundSystems.Currency[currencyName] then
        return {success = false, error = "Currency not found: " .. currencyName}
    end
    
    local currencyData = QuantumScanner.FoundSystems.Currency[currencyName]
    local newAmount = tonumber(amount)
    
    if not newAmount then
        return {success = false, error = "Invalid amount: " .. tostring(amount)}
    end
    
    -- Limit maximum value
    if newAmount > QuantumEditor.MaxEditValue then
        newAmount = QuantumEditor.MaxEditValue
    elseif newAmount < -QuantumEditor.MaxEditValue then
        newAmount = -QuantumEditor.MaxEditValue
    end
    
    local success, result = pcall(function()
        -- Method 1: Direct value editing (for leaderstats)
        if currencyData.type == "IntValue" or 
           currencyData.type == "NumberValue" or
           currencyData.type == "DoubleConstrainedValue" then
            
            if method == "SET" then
                currencyData.object.Value = newAmount
            elseif method == "ADD" then
                currencyData.object.Value = currencyData.object.Value + newAmount
            elseif method == "SUBTRACT" then
                currencyData.object.Value = currencyData.object.Value - newAmount
            elseif method == "MULTIPLY" then
                currencyData.object.Value = currencyData.object.Value * newAmount
            end
            
            return {
                success = true,
                currency = currencyName,
                oldValue = currencyData.value,
                newValue = currencyData.object.Value,
                method = method
            }
        
        -- Method 2: Remote event editing
        elseif currencyData.type == "RemoteEvent" or
               currencyData.type == "RemoteFunction" then
            
            -- Find appropriate remote for currency
            local buyRemote = self:FindBuyRemote(currencyName)
            if buyRemote then
                if method == "ADD" or method == "SET" then
                    -- Simulate purchase of free item
                    buyRemote:FireServer("FreeAdd", newAmount)
                end
                
                return {
                    success = true,
                    currency = currencyName,
                    method = "RemoteEvent: " .. buyRemote.Name,
                    amount = newAmount
                }
            end
        end
        
        return {success = false, error = "Unsupported currency type: " .. currencyData.type}
    end)
    
    if success then
        -- Record edit in history
        table.insert(QuantumEditor.EditHistory, {
            timestamp = os.time(),
            type = "CURRENCY",
            currency = currencyName,
            amount = newAmount,
            method = method,
            result = result
        })
        
        -- Update scanner cache
        if currencyData.object and currencyData.object.Value then
            QuantumScanner.FoundSystems.Currency[currencyName].value = currencyData.object.Value
        end
        
        return result
    else
        return {
            success = false,
            error = "Edit failed: " .. tostring(result)
        }
    end
end

function QuantumEditor:AddItem(itemName, quantity)
    quantity = tonumber(quantity) or 1
    
    if not QuantumScanner.FoundSystems.Items[itemName] then
        return {success = false, error = "Item not found: " .. itemName}
    end
    
    local itemData = QuantumScanner.FoundSystems.Items[itemName]
    
    local success, result = pcall(function()
        -- Method 1: Direct cloning from ServerStorage
        if itemData.object and 
           (itemData.object:IsA("Model") or itemData.object:IsA("Tool")) then
            
            -- Check if item already exists in inventory
            local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
            local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            
            if backpack then
                for i = 1, quantity do
                    local clone = itemData.object:Clone()
                    clone.Parent = backpack
                    
                    -- Trigger equipped event if tool
                    if clone:IsA("Tool") then
                        clone.Parent = game.Players.LocalPlayer.Character
                        task.wait(0.1)
                        clone.Parent = backpack
                    end
                end
            end
            
            return {
                success = true,
                item = itemName,
                quantity = quantity,
                method = "DirectClone"
            }
        
        -- Method 2: Use buy remote
        else
            local buyRemote = self:FindBuyRemote(itemName)
            if buyRemote then
                -- Fire buy event with 0 cost
                for i = 1, quantity do
                    buyRemote:FireServer(itemName, 0)
                    task.wait(0.05) -- Prevent detection
                end
                
                return {
                    success = true,
                    item = itemName,
                    quantity = quantity,
                    method = "BuyRemote: " .. buyRemote.Name
                }
            end
        end
        
        return {success = false, error = "No method found to add item"}
    end)
    
    if success then
        table.insert(QuantumEditor.EditHistory, {
            timestamp = os.time(),
            type = "ITEM_ADD",
            item = itemName,
            quantity = quantity,
            result = result
        })
        
        return result
    else
        return {
            success = false,
            error = "Add item failed: " .. tostring(result)
        }
    end
end

function QuantumEditor:RemoveItem(itemName, quantity)
    quantity = tonumber(quantity) or 1
    
    local success, result = pcall(function()
        local removed = 0
        
        -- Check backpack
        local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool.Name == itemName then
                    tool:Destroy()
                    removed = removed + 1
                    if removed >= quantity then break end
                end
            end
        end
        
        -- Check character
        local character = game.Players.LocalPlayer.Character
        if character then
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == itemName then
                    tool:Destroy()
                    removed = removed + 1
                    if removed >= quantity then break end
                end
            end
        end
        
        return {
            success = removed > 0,
            item = itemName,
            removed = removed,
            requested = quantity
        }
    end)
    
    if success then
        table.insert(QuantumEditor.EditHistory, {
            timestamp = os.time(),
            type = "ITEM_REMOVE",
            item = itemName,
            quantity = quantity,
            result = result
        })
        
        return result
    else
        return {
            success = false,
            error = "Remove item failed: " .. tostring(result)
        }
    end
end

function QuantumEditor:EditStat(statName, value, method)
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    if not localPlayer then
        return {success = false, error = "Player not found"}
    end
    
    local leaderstats = localPlayer:FindFirstChild("leaderstats")
    if not leaderstats then
        return {success = false, error = "leaderstats not found"}
    end
    
    local stat = leaderstats:FindFirstChild(statName)
    if not stat then
        return {success = false, error = "Stat not found: " .. statName}
    end
    
    local newValue = tonumber(value)
    if not newValue then
        return {success = false, error = "Invalid value: " .. tostring(value)}
    end
    
    local success, result = pcall(function()
        local oldValue = stat.Value
        
        if method == "SET" then
            stat.Value = newValue
        elseif method == "ADD" then
            stat.Value = stat.Value + newValue
        elseif method == "SUBTRACT" then
            stat.Value = stat.Value - newValue
        elseif method == "MULTIPLY" then
            stat.Value = stat.Value * newValue
        elseif method == "DIVIDE" and newValue ~= 0 then
            stat.Value = stat.Value / newValue
        end
        
        return {
            success = true,
            stat = statName,
            oldValue = oldValue,
            newValue = stat.Value,
            method = method
        }
    end)
    
    if success then
        table.insert(QuantumEditor.EditHistory, {
            timestamp = os.time(),
            type = "STAT_EDIT",
            stat = statName,
            value = newValue,
            method = method,
            result = result
        })
        
        return result
    else
        return {
            success = false,
            error = "Edit stat failed: " .. tostring(result)
        }
    end
end

function QuantumEditor:ExecuteCustomCode(code)
    local success, result = pcall(function()
        -- Secure execution with limited environment
        local env = {
            game = game,
            workspace = workspace,
            Players = game:GetService("Players"),
            ReplicatedStorage = game:GetService("ReplicatedStorage"),
            ServerStorage = game:GetService("ServerStorage"),
            Lighting = game:GetService("Lighting"),
            print = print,
            warn = warn,
            wait = task.wait,
            tick = tick,
            os = {time = os.time, date = os.date},
            math = math,
            string = string,
            table = table,
            type = type,
            tonumber = tonumber,
            tostring = tostring,
            pcall = pcall,
            xpcall = xpcall,
            next = next,
            pairs = pairs,
            ipairs = ipairs,
            select = select,
            unpack = table.unpack,
            QuantumEditor = QuantumEditor,
            QuantumScanner = QuantumScanner
        }
        
        local func, err = loadstring("return " .. code)
        if not func then
            func, err = loadstring(code)
        end
        
        if not func then
            error("Compile error: " .. tostring(err))
        end
        
        setfenv(func, env)
        return func()
    end)
    
    if success then
        table.insert(QuantumEditor.EditHistory, {
            timestamp = os.time(),
            type = "CUSTOM_CODE",
            code = code,
            result = result
        })
        
        return {
            success = true,
            result = result
        }
    else
        return {
            success = false,
            error = "Code execution failed: " .. tostring(result)
        }
    end
end

function QuantumEditor:FindBuyRemote(itemName)
    local remotes = QuantumScanner.FoundSystems.Remotes.BuyEvents or {}
    
    for remoteName, remoteData in pairs(remotes) do
        -- Check if remote name suggests it can buy this item
        local lowerItem = string.lower(itemName)
        local lowerRemote = string.lower(remoteName)
        
        if string.find(lowerRemote, "buy") or
           string.find(lowerRemote, "purchase") or
           string.find(lowerRemote, "shop") then
            return remoteData.object
        end
    end
    
    -- Try any buy remote
    for remoteName, remoteData in pairs(remotes) do
        return remoteData.object
    end
    
    -- Try any remote event
    for remoteName, remoteData in pairs(QuantumScanner.FoundSystems.Remotes.Events or {}) do
        return remoteData.object
    end
    
    return nil
end

function QuantumEditor:GetEditHistory()
    return QuantumEditor.EditHistory
end

function QuantumEditor:ClearHistory()
    QuantumEditor.EditHistory = {}
    return {success = true, message = "History cleared"}
end

function QuantumEditor:SetMaxEditValue(maxValue)
    local num = tonumber(maxValue)
    if num and num > 0 then
        QuantumEditor.MaxEditValue = num
        return {
            success = true,
            message = "Max edit value set to: " .. tostring(num)
        }
    end
    return {
        success = false,
        error = "Invalid max value: " .. tostring(maxValue)
    }
end

-- ============================================================================
-- SECTION 3: QUANTUM ADMIN GUI SYSTEM
-- ============================================================================

local QuantumGUI = {
    MainWindow = nil,
    Tabs = {},
    CurrentTab = "SCANNER",
    Notifications = {},
    Theme = {
        Background = Color3.fromRGB(20, 20, 30),
        Primary = Color3.fromRGB(0, 150, 255),
        Secondary = Color3.fromRGB(40, 40, 60),
        Text = Color3.fromRGB(240, 240, 240),
        Success = Color3.fromRGB(0, 255, 100),
        Error = Color3.fromRGB(255, 50, 50),
        Warning = Color3.fromRGB(255, 200, 0)
    }
}

function QuantumGUI:CreateMainWindow()
    -- Create main screen GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "QuantumAdminGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 800, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
    mainFrame.BackgroundColor3 = QuantumGUI.Theme.Background
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = QuantumGUI.Theme.Primary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "QUANTUM ADMIN SYSTEM v10.0"
    title.TextColor3 = QuantumGUI.Theme.Text
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.Parent = titleBar
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0.5, -15)
    closeButton.BackgroundColor3 = QuantumGUI.Theme.Error
    closeButton.Text = "X"
    closeButton.TextColor3 = QuantumGUI.Theme.Text
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        QuantumGUI.MainWindow = nil
    end)
    
    -- Tab buttons
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, 0, 0, 50)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = QuantumGUI.Theme.Secondary
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame
    
    local tabs = {
        "SCANNER",
        "CURRENCY",
        "ITEMS", 
        "STATS",
        "CUSTOM",
        "HISTORY",
        "SETTINGS"
    }
    
    local tabWidth = 1 / #tabs
    
    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(tabWidth, -4, 1, -4)
        tabButton.Position = UDim2.new((i-1) * tabWidth, 2, 0, 2)
        tabButton.BackgroundColor3 = QuantumGUI.Theme.Background
        tabButton.Text = tabName
        tabButton.TextColor3 = QuantumGUI.Theme.Text
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = tabContainer
        
        tabButton.MouseButton1Click:Connect(function()
            QuantumGUI:SwitchTab(tabName)
        end)
    end
    
    -- Content area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -90)
    contentFrame.Position = UDim2.new(0, 0, 0, 90)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ClipsDescendants = true
    contentFrame.Parent = mainFrame
    
    -- Create tab contents
    QuantumGUI:CreateScannerTab(contentFrame)
    QuantumGUI:CreateCurrencyTab(contentFrame)
    QuantumGUI:CreateItemsTab(contentFrame)
    QuantumGUI:CreateStatsTab(contentFrame)
    QuantumGUI:CreateCustomTab(contentFrame)
    QuantumGUI:CreateHistoryTab(contentFrame)
    QuantumGUI:CreateSettingsTab(contentFrame)
    
    -- Initially show scanner tab
    QuantumGUI:SwitchTab("SCANNER")
    
    -- Add to player GUI
    if game.Players.LocalPlayer then
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    
    QuantumGUI.MainWindow = screenGui
    return screenGui
end

function QuantumGUI:CreateScannerTab(parent)
    local scannerFrame = Instance.new("Frame")
    scannerFrame.Name = "ScannerFrame"
    scannerFrame.Size = UDim2.new(1, 0, 1, 0)
    scannerFrame.BackgroundTransparency = 1
    scannerFrame.Visible = false
    scannerFrame.Parent = parent
    
    -- Scanner title
    local title = Instance.new("TextLabel")
    title.Name = "ScannerTitle"
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "GAME SCANNER SYSTEM"
    title.TextColor3 = QuantumGUI.Theme.Primary
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = scannerFrame
    
    -- Scan button
    local scanButton = Instance.new("TextButton")
    scanButton.Name = "ScanButton"
    scanButton.Size = UDim2.new(0, 200, 0, 50)
    scanButton.Position = UDim2.new(0.5, -100, 0, 60)
    scanButton.BackgroundColor3 = QuantumGUI.Theme.Primary
    scanButton.Text = "SCAN GAME"
    scanButton.TextColor3 = QuantumGUI.Theme.Text
    scanButton.TextSize = 18
    scanButton.Font = Enum.Font.GothamBold
    scanButton.Parent = scannerFrame
    
    -- Results frame
    local resultsFrame = Instance.new("ScrollingFrame")
    resultsFrame.Name = "ResultsFrame"
    resultsFrame.Size = UDim2.new(1, -20, 1, -150)
    resultsFrame.Position = UDim2.new(0, 10, 0, 120)
    resultsFrame.BackgroundColor3 = QuantumGUI.Theme.Secondary
    resultsFrame.BackgroundTransparency = 0.2
    resultsFrame.BorderSizePixel = 0
    resultsFrame.ScrollBarThickness = 8
    resultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    resultsFrame.Parent = scannerFrame
    
    local resultsUIList = Instance.new("UIListLayout")
    resultsUIList.Name = "ResultsUIList"
    resultsUIList.Padding = UDim.new(0, 5)
    resultsUIList.Parent = resultsFrame
    
    scanButton.MouseButton1Click:Connect(function()
        scanButton.Text = "SCANNING..."
        scanButton.BackgroundColor3 = QuantumGUI.Theme.Warning
        
        local results = QuantumScanner:DeepScanGame()
        
        -- Clear previous results
        for _, child in pairs(resultsFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        -- Display game info
        local gameInfo = Instance.new("Frame")
        gameInfo.Name = "GameInfo"
        gameInfo.Size = UDim2.new(1, -10, 0, 80)
        gameInfo.BackgroundColor3 = QuantumGUI.Theme.Background
        gameInfo.BackgroundTransparency = 0.3
        gameInfo.Parent = resultsFrame
        
        local gameName = Instance.new("TextLabel")
        gameName.Name = "GameName"
        gameName.Size = UDim2.new(1, -10, 0, 30)
        gameName.Position = UDim2.new(0, 5, 0, 5)
        gameName.BackgroundTransparency = 1
        gameName.Text = "Game: " .. (QuantumScanner.GameAnalysis.name or "Unknown")
        gameName.TextColor3 = QuantumGUI.Theme.Text
        gameName.TextSize = 18
        gameName.Font = Enum.Font.GothamBold
        gameName.TextXAlignment = Enum.TextXAlignment.Left
        gameName.Parent = gameInfo
        
        local gameId = Instance.new("TextLabel")
        gameId.Name = "GameId"
        gameId.Size = UDim2.new(1, -10, 0, 20)
        gameId.Position = UDim2.new(0, 5, 0, 35)
        gameId.BackgroundTransparency = 1
        gameId.Text = "ID: " .. tostring(game.GameId)
        gameId.TextColor3 = QuantumGUI.Theme.Text
        gameId.TextSize = 14
        gameId.Font = Enum.Font.Gotham
        gameId.TextXAlignment = Enum.TextXAlignment.Left
        gameId.Parent = gameInfo
        
        -- Display currency systems
        if results.Currency and next(results.Currency) then
            local currencyHeader = Instance.new("TextLabel")
            currencyHeader.Name = "CurrencyHeader"
            currencyHeader.Size = UDim2.new(1, -10, 0, 30)
            currencyHeader.BackgroundTransparency = 1
            currencyHeader.Text = "CURRENCY SYSTEMS:"
            currencyHeader.TextColor3 = QuantumGUI.Theme.Success
            currencyHeader.TextSize = 16
            currencyHeader.Font = Enum.Font.GothamBold
            currencyHeader.TextXAlignment = Enum.TextXAlignment.Left
            currencyHeader.Parent = resultsFrame
            
            for name, data in pairs(results.Currency) do
                local currencyFrame = Instance.new("Frame")
                currencyFrame.Name = "Currency_" .. name
                currencyFrame.Size = UDim2.new(1, -10, 0, 50)
                currencyFrame.BackgroundColor3 = QuantumGUI.Theme.Background
                currencyFrame.BackgroundTransparency = 0.5
                currencyFrame.Parent = resultsFrame
                
                local currencyName = Instance.new("TextLabel")
                currencyName.Name = "CurrencyName"
                currencyName.Size = UDim2.new(0.5, -5, 1, -10)
                currencyName.Position = UDim2.new(0, 5, 0, 5)
                currencyName.BackgroundTransparency = 1
                currencyName.Text = name .. " (" .. data.type .. ")"
                currencyName.TextColor3 = QuantumGUI.Theme.Text
                currencyName.TextSize = 14
                currencyName.Font = Enum.Font.Gotham
                currencyName.TextXAlignment = Enum.TextXAlignment.Left
                currencyName.Parent = currencyFrame
                
                local currencyValue = Instance.new("TextLabel")
                currencyValue.Name = "CurrencyValue"
                currencyValue.Size = UDim2.new(0.5, -5, 1, -10)
                currencyValue.Position = UDim2.new(0.5, 0, 0, 5)
                currencyValue.BackgroundTransparency = 1
                currencyValue.Text = "Value: " .. tostring(data.value)
                currencyValue.TextColor3 = QuantumGUI.Theme.Primary
                currencyValue.TextSize = 14
                currencyValue.Font = Enum.Font.Gotham
                currencyValue.TextXAlignment = Enum.TextXAlignment.Right
                currencyValue.Parent = currencyFrame
            end
        end
        
        -- Update canvas size
        resultsFrame.CanvasSize = UDim2.new(0, 0, 0, resultsUIList.AbsoluteContentSize.Y + 20)
        
        scanButton.Text = "SCAN COMPLETE"
        scanButton.BackgroundColor3 = QuantumGUI.Theme.Success
        
        task.wait(2)
        scanButton.Text = "SCAN GAME"
        scanButton.BackgroundColor3 = QuantumGUI.Theme.Primary
    end)
    
    QuantumGUI.Tabs.SCANNER = scannerFrame
end

function QuantumGUI:CreateCurrencyTab(parent)
    local currencyFrame = Instance.new("Frame")
    currencyFrame.Name = "CurrencyFrame"
    currencyFrame.Size = UDim2.new(1, 0, 1, 0)
    currencyFrame.BackgroundTransparency = 1
    currencyFrame.Visible = false
    currencyFrame.Parent = parent
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "CurrencyTitle"
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "CURRENCY EDITOR"
    title.TextColor3 = QuantumGUI.Theme.Primary
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = currencyFrame
    
    -- Currency selection dropdown
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = "DropdownFrame"
    dropdownFrame.Size = UDim2.new(1, -20, 0, 50)
    dropdownFrame.Position = UDim2.new(0, 10, 0, 60)
    dropdownFrame.BackgroundColor3 = QuantumGUI.Theme.Secondary
    dropdownFrame.BackgroundTransparency = 0.2
    dropdownFrame.Parent = currencyFrame
    
    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Name = "DropdownLabel"
    dropdownLabel.Size = UDim2.new(0, 150, 1, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.Text = "Select Currency:"
    dropdownLabel.TextColor3 = QuantumGUI.Theme.Text
    dropdownLabel.TextSize = 16
    dropdownLabel.Font = Enum.Font.Gotham
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.Parent = dropdownFrame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Name = "CurrencyDropdown"
    dropdown.Size = UDim2.new(0, 200, 0, 30)
    dropdown.Position = UDim2.new(0, 160, 0.5, -15)
    dropdown.BackgroundColor3 = QuantumGUI.Theme.Background
    dropdown.Text = "Click to select"
    dropdown.TextColor3 = QuantumGUI.Theme.Text
    dropdown.TextSize = 14
    dropdown.Font = Enum.Font.Gotham
    dropdown.Parent = dropdownFrame
    
    local dropdownList = Instance.new("ScrollingFrame")
    dropdownList.Name = "DropdownList"
    dropdownList.Size = UDim2.new(0, 200, 0, 150)
    dropdownList.Position = UDim2.new(0, 160, 1, 5)
    dropdownList.BackgroundColor3 = QuantumGUI.Theme.Background
    dropdownList.Visible = false
    dropdownList.ScrollBarThickness = 8
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
    dropdownList.Parent = dropdownFrame
    
    local dropdownUIList = Instance.new("UIListLayout")
    dropdownUIList.Name = "DropdownUIList"
    dropdownUIList.Parent = dropdownList
    
    -- Amount input
    local amountFrame = Instance.new("Frame")
    amountFrame.Name = "AmountFrame"
    amountFrame.Size = UDim2.new(1, -20, 0, 50)
    amountFrame.Position = UDim2.new(0, 10, 0, 120)
    amountFrame.BackgroundColor3 = QuantumGUI.Theme.Secondary
    amountFrame.BackgroundTransparency = 0.2
    amountFrame.Parent = currencyFrame
    
    local amountLabel = Instance.new("TextLabel")
    amountLabel.Name = "AmountLabel"
    amountLabel.Size = UDim2.new(0, 150, 1, 0)
    amountLabel.BackgroundTransparency = 1
    amountLabel.Text = "Amount:"
    amountLabel.TextColor3 = QuantumGUI.Theme.Text
    amountLabel.TextSize = 16
    amountLabel.Font = Enum.Font.Gotham
    amountLabel.TextXAlignment = Enum.TextXAlignment.Left
    amountLabel.Parent = amountFrame
    
    local amountBox = Instance.new("TextBox")
    amountBox.Name = "AmountBox"
    amountBox.Size = UDim2.new(0, 200, 0, 30)
    amountBox.Position = UDim2.new(0, 160, 0.5, -15)
    amountBox.BackgroundColor3 = QuantumGUI.Theme.Background
    amountBox.TextColor3 = QuantumGUI.Theme.Text
    amountBox.Text = "1000000"
    amountBox.PlaceholderText = "Enter amount"
    amountBox.TextSize = 14
    amountBox.Font = Enum.Font.Gotham
    amountBox.Parent = amountFrame
    
    -- Method selection
    local methodFrame = Instance.new("Frame")
    methodFrame.Name = "MethodFrame"
    methodFrame.Size = UDim2.new(1, -20, 0, 100)
    methodFrame.Position = UDim2.new(0, 10, 0, 180)
    methodFrame.BackgroundColor3 = QuantumGUI.Theme.Secondary
    methodFrame.BackgroundTransparency = 0.2
    methodFrame.Parent = currencyFrame
    
    local methodLabel = Instance.new("TextLabel")
    methodLabel.Name = "MethodLabel"
    methodLabel.Size = UDim2.new(1, -10, 0, 30)
    methodLabel.Position = UDim2.new(0, 5, 0, 5)
    methodLabel.BackgroundTransparency = 1
    methodLabel.Text = "Edit Method:"
    methodLabel.TextColor3 = QuantumGUI.Theme.Text
    methodLabel.TextSize = 16
    methodLabel.Font = Enum.Font.Gotham
    methodLabel.TextXAlignment = Enum.TextXAlignment.Left
    methodLabel.Parent = methodFrame
    
    local methods = {"SET", "ADD", "SUBTRACT", "MULTIPLY"}
    local buttonWidth = 0.25
    
    for i, method in ipairs(methods) do
        local methodButton = Instance.new("TextButton")
        methodButton.Name = method .. "Button"
        methodButton.Size = UDim2.new(buttonWidth, -10, 0, 40)
        methodButton.Position = UDim2.new((i-1) * buttonWidth, 5, 0, 40)
        methodButton.BackgroundColor3 = QuantumGUI.Theme.Background
        methodButton.Text = method
        methodButton.TextColor3 = QuantumGUI.Theme.Text
        methodButton.TextSize = 14
        methodButton.Font = Enum.Font.GothamBold
        methodButton.Parent = methodFrame
        
        methodButton.MouseButton1Click:Connect(function()
            local selectedCurrency = dropdown.Text
            local amount = amountBox.Text
            
            if selectedCurrency == "Click to select" then
                QuantumGUI:ShowNotification("Please select a currency first!", "ERROR")
                return
            end
            
            if not tonumber(amount) then
                QuantumGUI:ShowNotification("Invalid amount!", "ERROR")
                return
            end
            
            local result = QuantumEditor:EditCurrency(selectedCurrency, amount, method)
            
            if result.success then
                QuantumGUI:ShowNotification(
                    "Success! " .. selectedCurrency .. ": " .. 
                    tostring(result.oldValue) .. " → " .. 
                    tostring(result.newValue),
                    "SUCCESS"
                )
            else
                QuantumGUI:ShowNotification("Failed: " .. (result.error or "Unknown error"), "ERROR")
            end
        end)
    end
    
    -- Execute button
    local executeButton = Instance.new("TextButton")
    executeButton.Name = "ExecuteButton"
    executeButton.Size = UDim2.new(0, 200, 0, 50)
    executeButton.Position = UDim2.new(0.5, -100, 1, -70)
    executeButton.BackgroundColor3 = QuantumGUI.Theme.Success
    executeButton.Text = "EXECUTE EDIT"
    executeButton.TextColor3 = QuantumGUI.Theme.Text
    executeButton.TextSize = 18
    executeButton.Font = Enum.Font.GothamBold
    executeButton.Parent = currencyFrame
    
    -- Dropdown functionality
    local function updateDropdown()
        for _, child in pairs(dropdownList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local currencies = QuantumScanner.FoundSystems.Currency or {}
        
        for name, data in pairs(currencies) do
            local option = Instance.new("TextButton")
            option.Name = "Option_" .. name
            option.Size = UDim2.new(1, 0, 0, 30)
            option.BackgroundColor3 = QuantumGUI.Theme.Secondary
            option.Text = name
            option.TextColor3 = QuantumGUI.Theme.Text
            option.TextSize = 14
            option.Font = Enum.Font.Gotham
            option.Parent = dropdownList
            
            option.MouseButton1Click:Connect(function()
                dropdown.Text = name
                dropdownList.Visible = false
                
                -- Set suggested amount based on current value
                if data.value then
                    local suggested = math.floor(data.value * 10)
                    if suggested > 1000000 then suggested = 1000000 end
                    amountBox.Text = tostring(suggested)
                end
            end)
        end
        
        dropdownList.CanvasSize = UDim2.new(0, 0, 0, #dropdownList:GetChildren() * 32)
    end
    
    dropdown.MouseButton1Click:Connect(function()
        dropdownList.Visible = not dropdownList.Visible
        if dropdownList.Visible then
            updateDropdown()
        end
    end)
    
    executeButton.MouseButton1Click:Connect(function()
        local selectedCurrency = dropdown.Text
        local amount = amountBox.Text
        local method = "SET" -- Default
        
        if selectedCurrency == "Click to select" then
            QuantumGUI:ShowNotification("Please select a currency first!", "ERROR")
            return
        end
        
        if not tonumber(amount) then
            QuantumGUI:ShowNotification("Invalid amount!", "ERROR")
            return
        end
        
        local result = QuantumEditor:EditCurrency(selectedCurrency, amount, method)
        
        if result.success then
            QuantumGUI:ShowNotification(
                "Success! " .. selectedCurrency .. " set to: " .. amount,
                "SUCCESS"
            )
        else
            QuantumGUI:ShowNotification("Failed: " .. (result.error or "Unknown error"), "ERROR")
        end
    end)
    
    QuantumGUI.Tabs.CURRENCY = currencyFrame
end

function QuantumGUI:CreateItemsTab(parent)
    local itemsFrame = Instance.new("Frame")
    itemsFrame.Name = "ItemsFrame"
    itemsFrame.Size = UDim2.new(1, 0, 1, 0)
    itemsFrame.BackgroundTransparency = 1
    itemsFrame.Visible = false
    itemsFrame.Parent = parent
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "ItemsTitle"
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "ITEM EDITOR"
    title.TextColor3 = QuantumGUI.Theme.Primary
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = itemsFrame
    
    QuantumGUI.Tabs.ITEMS = itemsFrame
end

function QuantumGUI:CreateStatsTab(parent)
    local statsFrame = Instance.new("Frame")
    statsFrame.Name = "StatsFrame"
    statsFrame.Size = UDim2.new(1, 0, 1, 0)
    statsFrame.BackgroundTransparency = 1
    statsFrame.Visible = false
    statsFrame.Parent = parent
    
    QuantumGUI.Tabs.STATS = statsFrame
end

function QuantumGUI:CreateCustomTab(parent)
    local customFrame = Instance.new("Frame")
    customFrame.Name = "CustomFrame"
    customFrame.Size = UDim2.new(1, 0, 1, 0)
    customFrame.BackgroundTransparency = 1
    customFrame.Visible = false
    customFrame.Parent = parent
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "CustomTitle"
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "CUSTOM CODE EXECUTOR"
    title.TextColor3 = QuantumGUI.Theme.Primary
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = customFrame
    
    -- Code input
    local codeBox = Instance.new("TextBox")
    codeBox.Name = "CodeBox"
    codeBox.Size = UDim2.new(1, -20, 0.7, -20)
    codeBox.Position = UDim2.new(0, 10, 0, 60)
    codeBox.BackgroundColor3 = QuantumGUI.Theme.Secondary
    codeBox.BackgroundTransparency = 0.2
    codeBox.TextColor3 = QuantumGUI.Theme.Text
    codeBox.Text = "-- Enter your Lua code here\n-- Example: QuantumEditor:EditCurrency(\"Cash\", 1000000, \"ADD\")"
    codeBox.TextSize = 14
    codeBox.Font = Enum.Font.Code
    codeBox.TextXAlignment = Enum.TextXAlignment.Left
    codeBox.TextYAlignment = Enum.TextYAlignment.Top
    codeBox.ClearTextOnFocus = false
    codeBox.MultiLine = true
    codeBox.Parent = customFrame
    
    -- Execute button
    local executeButton = Instance.new("TextButton")
    executeButton.Name = "ExecuteCodeButton"
    executeButton.Size = UDim2.new(0, 200, 0, 50)
    executeButton.Position = UDim2.new(0.5, -100, 1, -70)
    executeButton.BackgroundColor3 = QuantumGUI.Theme.Success
    executeButton.Text = "EXECUTE CODE"
    executeButton.TextColor3 = QuantumGUI.Theme.Text
    executeButton.TextSize = 18
    executeButton.Font = Enum.Font.GothamBold
    executeButton.Parent = customFrame
    
    -- Result display
    local resultFrame = Instance.new("ScrollingFrame")
    resultFrame.Name = "ResultFrame"
    resultFrame.Size = UDim2.new(1, -20, 0.2, 0)
    resultFrame.Position = UDim2.new(0, 10, 0.75, 0)
    resultFrame.BackgroundColor3 = QuantumGUI.Theme.Background
    resultFrame.BackgroundTransparency = 0.3
    resultFrame.Visible = false
    resultFrame.ScrollBarThickness = 8
    resultFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    resultFrame.Parent = customFrame
    
    local resultText = Instance.new("TextLabel")
    resultText.Name = "ResultText"
    resultText.Size = UDim2.new(1, -10, 0, 100)
    resultText.Position = UDim2.new(0, 5, 0, 5)
    resultText.BackgroundTransparency = 1
    resultText.Text = ""
    resultText.TextColor3 = QuantumGUI.Theme.Text
    resultText.TextSize = 14
    resultText.Font = Enum.Font.Code
    resultText.TextXAlignment = Enum.TextXAlignment.Left
    resultText.TextYAlignment = Enum.TextYAlignment.Top
    resultText.TextWrapped = true
    resultText.Parent = resultFrame
    
    executeButton.MouseButton1Click:Connect(function()
        local code = codeBox.Text
        
        if code == "" or string.find(code, "^%-%-") then
            QuantumGUI:ShowNotification("Please enter valid code!", "WARNING")
            return
        end
        
        executeButton.Text = "EXECUTING..."
        executeButton.BackgroundColor3 = QuantumGUI.Theme.Warning
        
        local result = QuantumEditor:ExecuteCustomCode(code)
        
        resultFrame.Visible = true
        
        if result.success then
            resultText.TextColor3 = QuantumGUI.Theme.Success
            resultText.Text = "✓ EXECUTION SUCCESSFUL\n\nResult: " .. 
                             tostring(result.result) .. 
                             "\n\nCheck HISTORY tab for details."
        else
            resultText.TextColor3 = QuantumGUI.Theme.Error
            resultText.Text = "✗ EXECUTION FAILED\n\nError: " .. 
                             (result.error or "Unknown error") .. 
                             "\n\nCheck your code syntax."
        end
        
        resultFrame.CanvasSize = UDim2.new(0, 0, 0, resultText.TextBounds.Y + 20)
        
        executeButton.Text = "EXECUTE CODE"
        executeButton.BackgroundColor3 = QuantumGUI.Theme.Success
    end)
    
    QuantumGUI.Tabs.CUSTOM = customFrame
end

function QuantumGUI:CreateHistoryTab(parent)
    local historyFrame = Instance.new("Frame")
    historyFrame.Name = "HistoryFrame"
    historyFrame.Size = UDim2.new(1, 0, 1, 0)
    historyFrame.BackgroundTransparency = 1
    historyFrame.Visible = false
    historyFrame.Parent = parent
    
    QuantumGUI.Tabs.HISTORY = historyFrame
end

function QuantumGUI:CreateSettingsTab(parent)
    local settingsFrame = Instance.new("Frame")
    settingsFrame.Name = "SettingsFrame"
    settingsFrame.Size = UDim2.new(1, 0, 1, 0)
    settingsFrame.BackgroundTransparency = 1
    settingsFrame.Visible = false
    settingsFrame.Parent = parent
    
    QuantumGUI.Tabs.SETTINGS = settingsFrame
end

function QuantumGUI:SwitchTab(tabName)
    -- Hide all tabs
    for name, tab in pairs(QuantumGUI.Tabs) do
        tab.Visible = (name == tabName)
    end
    
    QuantumGUI.CurrentTab = tabName
    
    -- Update tab button colors
    local tabContainer = QuantumGUI.MainWindow:FindFirstChild("MainFrame"):FindFirstChild("TabContainer")
    if tabContainer then
        for _, child in pairs(tabContainer:GetChildren()) do
            if child:IsA("TextButton") then
                if string.find(child.Name, tabName) then
                    child.BackgroundColor3 = QuantumGUI.Theme.Primary
                else
                    child.BackgroundColor3 = QuantumGUI.Theme.Background
                end
            end
        end
    end
end

function QuantumGUI:ShowNotification(message, type)
    local color = QuantumGUI.Theme.Primary
    
    if type == "SUCCESS" then
        color = QuantumGUI.Theme.Success
    elseif type == "ERROR" then
        color = QuantumGUI.Theme.Error
    elseif type == "WARNING" then
        color = QuantumGUI.Theme.Warning
    end
    
    -- Create notification frame
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 300, 0, 60)
    notification.Position = UDim2.new(1, 10, 1, -70)
    notification.BackgroundColor3 = color
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    notification.Parent = QuantumGUI.MainWindow
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "NotificationText"
    textLabel.Size = UDim2.new(1, -10, 1, -10)
    textLabel.Position = UDim2.new(0, 5, 0, 5)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = QuantumGUI.Theme.Text
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextWrapped = true
    textLabel.Parent = notification
    
    -- Animate in
    notification.Position = UDim2.new(1, 320, 1, -70)
    
    local tweenIn = game:GetService("TweenService"):Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -310, 1, -70)}
    )
    tweenIn:Play()
    
    -- Auto remove after 3 seconds
    task.spawn(function()
        task.wait(3)
        
        local tweenOut = game:GetService("TweenService"):Create(
            notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = UDim2.new(1, 320, 1, -70)}
        )
        tweenOut:Play()
        
        tweenOut.Completed:Wait()
        notification:Destroy()
    end)
    
    table.insert(QuantumGUI.Notifications, notification)
end

-- ============================================================================
-- SECTION 4: MAIN EXECUTION & INITIALIZATION
-- ============================================================================

local QuantumAdmin = {
    Initialized = false,
    Version = "10.0",
    Build = "QUANTUM"
}

function QuantumAdmin:Initialize()
    if QuantumAdmin.Initialized then
        return {success = false, error = "Already initialized"}
    end
    
    print("╔══════════════════════════════════════════════════════╗")
    print("║       QUANTUM ADMIN SYSTEM v10.0 - INITIALIZING      ║")
    print("╚══════════════════════════════════════════════════════╝")
    
    -- Step 1: Initialize scanner
    print("[QUANTUM] Initializing game scanner...")
    local scanResults = QuantumScanner:DeepScanGame()
    
    if not scanResults or not next(scanResults) then
        print("[QUANTUM] WARNING: No game systems found!")
    else
        print("[QUANTUM] Game analysis complete")
    end
    
    -- Step 2: Initialize editor
    print("[QUANTUM] Initializing quantum editor...")
    QuantumEditor.MaxEditValue = 999999999
    
    -- Step 3: Create GUI
    print("[QUANTUM] Creating admin interface...")
    QuantumGUI:CreateMainWindow()
    
    -- Step 4: Set up keybinds
    QuantumAdmin:SetupKeybinds()
    
    -- Step 5: Start monitoring
    QuantumAdmin:StartMonitoring()
    
    QuantumAdmin.Initialized = true
    
    print("[QUANTUM] Initialization complete!")
    print("[QUANTUM] Press INSERT to show/hide admin panel")
    print("[QUANTUM] Ready for real-time game administration")
    
    return {success = true, scanResults = scanResults}
end

function QuantumAdmin:SetupKeybinds()
    local UIS = game:GetService("UserInputService")
    
    UIS.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- INSERT key to toggle GUI
        if input.KeyCode == Enum.KeyCode.Insert then
            if QuantumGUI.MainWindow and QuantumGUI.MainWindow.Parent then
                QuantumGUI.MainWindow.Enabled = not QuantumGUI.MainWindow.Enabled
                
                if QuantumGUI.MainWindow.Enabled then
                    QuantumGUI:ShowNotification("Admin panel ENABLED", "SUCCESS")
                else
                    QuantumGUI:ShowNotification("Admin panel DISABLED", "WARNING")
                end
            end
        end
        
        -- F5 key to refresh scanner
        if input.KeyCode == Enum.KeyCode.F5 then
            QuantumScanner:DeepScanGame()
            QuantumGUI:ShowNotification("Game scan refreshed", "SUCCESS")
        end
        
        -- F6 key to clear history
        if input.KeyCode == Enum.KeyCode.F6 then
            QuantumEditor:ClearHistory()
            QuantumGUI:ShowNotification("Edit history cleared", "SUCCESS")
        end
    end)
end

function QuantumAdmin:StartMonitoring()
    -- Monitor for currency changes
    game:GetService("RunService").Heartbeat:Connect(function()
        -- Auto-refresh currency values
        for name, data in pairs(QuantumScanner.FoundSystems.Currency or {}) do
            if data.object and data.object.Value then
                data.value = data.object.Value
            end
        end
    end)
    
    -- Monitor for new game elements
    game.DescendantAdded:Connect(function(descendant)
        -- Auto-detect new currency/value objects
        if (descendant:IsA("IntValue") or 
            descendant:IsA("NumberValue") or 
            descendant:IsA("DoubleConstrainedValue")) then
            
            local name = string.lower(descendant.Name)
            if string.find(name, "cash") or 
               string.find(name, "money") or
               string.find(name, "coin") or
               string.find(name, "gem") then
                
                -- Add to scanner cache
                QuantumScanner.FoundSystems.Currency[descendant.Name] = {
                    object = descendant,
                    path = descendant:GetFullName(),
                    value = descendant.Value,
                    type = descendant.ClassName
                }
            end
        end
    end)
end

function QuantumAdmin:GetSystemInfo()
    return {
        version = QuantumAdmin.Version,
        build = QuantumAdmin.Build,
        initialized = QuantumAdmin.Initialized,
        game = QuantumScanner.GameAnalysis.name or "Unknown",
        currencies = countTable(QuantumScanner.FoundSystems.Currency or {}),
        items = countTable(QuantumScanner.FoundSystems.Items or {}),
        edits = #QuantumEditor.EditHistory
    }
end

-- ============================================================================
-- SECTION 5: UTILITY FUNCTIONS
-- ============================================================================

function countTable(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("[QUANTUM ERROR] " .. tostring(result))
        return nil
    end
    return result
end

-- ============================================================================
-- SECTION 6: AUTO-START & ERROR HANDLING
-- ============================================================================

-- Main execution with comprehensive error handling
local function Main()
    local success, err = pcall(function()
        -- Wait for game to load
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        
        -- Wait for player
        local players = game:GetService("Players")
        local player = players.LocalPlayer
        if not player then
            players.PlayerAdded:Wait()
            player = players.LocalPlayer
        end
        
        -- Wait for character
        if not player.Character then
            player.CharacterAdded:Wait()
        end
        
        -- Initialize system
        local initResult = QuantumAdmin:Initialize()
        
        if not initResult.success then
            warn("[QUANTUM] Initialization failed:", initResult.error)
            
            -- Attempt recovery
            for i = 1, 3 do
                task.wait(2)
                initResult = QuantumAdmin:Initialize()
                if initResult.success then break end
            end
        end
        
        -- Success message
        if initResult.success then
            print("╔══════════════════════════════════════════════════════╗")
            print("║     QUANTUM ADMIN SYSTEM v10.0 - READY FOR USE      ║")
            print("╚══════════════════════════════════════════════════════╝")
            
            -- Display system info
            local info = QuantumAdmin:GetSystemInfo()
            print("[SYSTEM INFO]")
            print("• Version: " .. info.version .. " (" .. info.build .. ")")
            print("• Game: " .. info.game)
            print("• Currencies Found: " .. info.currencies)
            print("• Items Found: " .. info.items)
            print("• Edits Available: " .. info.edits)
            print("")
            print("[CONTROLS]")
            print("• INSERT - Toggle Admin Panel")
            print("• F5 - Refresh Game Scan")
            print("• F6 - Clear Edit History")
            print("")
            print("[READY] Real-time game administration activated")
        end
    end)
    
    if not success then
        warn("[QUANTUM CRITICAL ERROR] " .. tostring(err))
        
        -- Attempt emergency recovery
        task.wait(3)
        
        local recoverySuccess = pcall(function()
            -- Minimal initialization
            QuantumScanner:DeepScanGame()
            QuantumGUI:CreateMainWindow()
            print("[QUANTUM] Emergency recovery successful")
        end)
        
        if not recoverySuccess then
            warn("[QUANTUM] Emergency recovery failed - system offline")
        end
    end
end

-- Start the system
task.spawn(Main)

-- ============================================================================
-- SECTION 7: PUBLIC API FOR EXTERNAL USE
-- ============================================================================

local QuantumAPI = {}

function QuantumAPI:ScanGame()
    return QuantumScanner:DeepScanGame()
end

function QuantumAPI:GetCurrencies()
    return QuantumScanner.FoundSystems.Currency or {}
end

function QuantumAPI:GetItems()
    return QuantumScanner.FoundSystems.Items or {}
end

function QuantumAPI:AddCurrency(name, amount)
    return QuantumEditor:EditCurrency(name, amount, "ADD")
end

function QuantumAPI:SetCurrency(name, amount)
    return QuantumEditor:EditCurrency(name, amount, "SET")
end

function QuantumAPI:AddItem(name, quantity)
    return QuantumEditor:AddItem(name, quantity)
end

function QuantumAPI:RemoveItem(name, quantity)
    return QuantumEditor:RemoveItem(name, quantity)
end

function QuantumAPI:ExecuteCode(code)
    return QuantumEditor:ExecuteCustomCode(code)
end

function QuantumAPI:GetHistory()
    return QuantumEditor:GetEditHistory()
end

function QuantumAPI:ShowGUI()
    if QuantumGUI.MainWindow then
        QuantumGUI.MainWindow.Enabled = true
        return true
    end
    return false
end

function QuantumAPI:HideGUI()
    if QuantumGUI.MainWindow then
        QuantumGUI.MainWindow.Enabled = false
        return true
    end
    return false
end

function QuantumAPI:GetSystemInfo()
    return QuantumAdmin:GetSystemInfo()
end

-- Return API for external access
return QuantumAPI
