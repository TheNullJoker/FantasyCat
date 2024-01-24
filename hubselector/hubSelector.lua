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

    auto_update = false,

    auto_open= true,
}



function hubLauncher.on_loaded()

    local target_directory = fantasy.fmt("{}/constellation4/resources/hubSelector.html", modules.file:current_directory())

        target_directory = modules.file:fix_separators(target_directory)

    if hubLauncher.auto_update then
        

        modules.http:to_file("https://raw.githubusercontent.com/TheNullJoker/FantasyCat/main/hubselector/hubselector.html", target_directory)

        fantasy.log("hubSelector.html downloaded to {}", target_directory)
      
    end

    if hubLauncher.auto_open then
        modules.http:open(target_directory)
    end

end

function hubLauncher.on_http_request( data )
    if data["script"] ~= "HubLauncer.lua" then return end

    if data["path"] ~= "/luar" then return end

    local activeScripts = json.decode(modules.session:api("getMember&scripts"))

    local scriptIds = {}

    -- Extract active scriptIDs.
    for _, script in pairs(activeScripts.scripts) do
        table.insert(ScriptIds, script.id)
    end

    -- Initialize flags as false.
    local ShatteredDreamsIsEnabled = false
    local CatsUniverseIsEnabled = false
    local LucidTermIsEnabled = false

    -- Check if any hub is already enabled.
    for _, targetId in pairs(hubLauncher.scriptIds) do
        if id == "159" then
           ShatteredDreamsIsEnabled = true
        elseif id == "150" then
        CatsUniverseIsEnabled = true
        elseif id == "242" then
            LucidTermIsEnabled = true
        end
    end

    if data["params"]["button"] == "shatteredDreamsButton" then
        if CatsUniverseIsEnabled then
            modules.session:api("toggleScriptStatus&id=150")

        elseif LucidTermIsEnabled then
            modules.session:api("toggleScriptStatus&id=242")
        
        elseif not ShatteredDreamsIsEnabled then
            modules.session:api("toggleScriptStatus&id=159")
        end
        fantasy.log({}, "shaterredDreams Enabled")
        fantasy.scripts:reset( true )

    elseif data["params"]["button"] == "catsUniverseButton" then
        if SchatteredDreamsIsEnabled then 
            modules.session:api("toggleScriptStatus&id=159")  

        elseif LucidTermIsEnabled then
            modules.session:api("toggleScriptStatus&id=242")

        elseif not CatsUniverseIsEnabled then
            modules.session:api("toggleScriptStatus&id=150")
        end
        fantasy.log({}, "CatsUniverse Enabled")
        fantasy.scripts:reset( true )

    elseif data["params"]["button"] == "lucidTermButton" then 
        if SchatteredDreamsIsEnabled then 
            modules.session:api("toggleScriptStatus&id=159")

        elseif CatsUniverseIsEnabled then
            modules.session:api("toggleScriptStatus&id=150")
            
        elseif not LucidTermIsEnabled then
            modules.session:api("toggleScriptStatus&id=242")

        end
        fantasy.log({}, "LucidTerm enabled")
        fantasy.scripts:reset( true )
    end
end

return hubLauncher
