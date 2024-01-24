--[[
    @title
        Hub launcher

    @author
        TheNoobJoker

    @description
        Lets u choose from a hub when launching an FC2 solution.
--]]
local modules = require("modules")
local json = require("json")


local hubLauncher = {

    auto_update = true,

    auto_open= true,
}



function hubLauncher.on_loaded()

    local target_directory = fantasy.fmt("{}/constellation4/resources/hubLauncher.html", modules.file:current_directory())

        target_directory = modules.file:fix_separators(target_directory)

    if hubLauncher.auto_update then


        modules.http:to_file("https://raw.githubusercontent.com/TheNullJoker/FantasyCat/main/hubselector/hubLauncher.html", target_directory)

        fantasy.log("hubLauncher.html downloaded to {}", target_directory)

    end

    if hubLauncher.auto_open then
        modules.http:open(target_directory)
    end

end

function hubLauncher.on_http_request( data )
    if data["script"] ~= "hubLauncher.lua" or data["path"] ~= "/luar" then return end



    local activeScripts = modules.scripts:get_loaded(false)

    -- Initialize flags as false.
    local scriptFlags = {
        ShatteredDreams = false,
        CatsUniverse = false,
        LucidTerm = false
    }

    -- Extract active scriptIDs.
    for _, script in pairs(activeScripts) do
        --fantasy.log(script.name)
        if script.name == "shattered_dreams.lua" then
            --fantasy.log("shattered_dreams.lua is enabled")
            ShatteredDreamsIsEnabled = true
         elseif script.name == "cats_universe.lua" then
            --fantasy.log("catus_universe.lua is enabled")
         CatsUniverseIsEnabled = true
         elseif script.name == "lucid_term.lua" then
            --fantasy.log("lucid_term.lua is enabled")
             LucidTermIsEnabled = true
         end

    end

    if CatsUniverseIsEnabled then
        fantasy.session:api("toggleScriptStatus&id=150")

    elseif LucidTermIsEnabled then
        fantasy.session:api("toggleScriptStatus&id=242")

    elseif ShatteredDreamsIsEnabled then
        fantasy.session:api("toggleScriptStatus&id=159")
    end

    local function toggleScriptStatus(scriptID)
        fantasy.session:api("toggleScriptStatus&id=" .. scriptID)
    end

    local buttons = {
        shatteredDreamsButton = 159,
        catsUniverseButton = 150,
        lucidTermButton = 242
    }

    local button = data["params"]["button"]
    local selectedButton = buttons[button]

    if selectedButton then
        toggleScriptStatus(selectedButton)
        fantasy.log("{}", button .. " Enabled")
        modules.scripts:reset( true )
    end

end

return hubLauncher
