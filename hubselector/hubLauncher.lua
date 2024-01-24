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
    if data["script"] ~= "hubLauncher.lua" then return end

    if data["path"] ~= "/luar" then return end

    local activeScripts = modules.scripts:get_loaded(false)

    -- Initialize flags as false.
    local ShatteredDreamsIsEnabled = false
    local CatsUniverseIsEnabled = false
    local LucidTermIsEnabled = false

    -- Extract active scriptIDs.
    for _, script in pairs(activeScripts) do
        
        if script.id == "159" then
            ShatteredDreamsIsEnabled = true
         elseif script.id == "150" then
         CatsUniverseIsEnabled = true
         elseif script.id == "242" then
             LucidTermIsEnabled = true
         end
        
    end

    if ShatteredDreamsIsEnabled or CatsUniverseIsEnabled or LucidTermIsEnabled then
        fantasy.log("A hub is enabled")
    else fantasy.log("no hub is enabled")
    end

    if data["params"]["button"] == "shatteredDreamsButton" then
        if CatsUniverseIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=150")

        elseif LucidTermIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=242")
        
        elseif not ShatteredDreamsIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=159")
        end
        fantasy.log("{}", "shaterredDreams Enabled")
        fantasy.scripts:reset( true )

    elseif data["params"]["button"] == "catsUniverseButton" then
        if ShatteredDreamsIsEnabled then 
            fantasy.session:api("toggleScriptStatus&id=159")  

        elseif LucidTermIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=242")

        elseif not CatsUniverseIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=150")
        end
        fantasy.log("{}", "CatsUniverse Enabled")
        fantasy.scripts:reset( true )

    elseif data["params"]["button"] == "lucidTermButton" then 
        if ShatteredDreamsIsEnabled then 
            fantasy.session:api("toggleScriptStatus&id=159")

        elseif CatsUniverseIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=150")
            
        elseif not LucidTermIsEnabled then
            fantasy.session:api("toggleScriptStatus&id=242")

        end
        fantasy.log("{}", "LucidTerm enabled")
        fantasy.scripts:reset( true )
    end
end

return hubLauncher
