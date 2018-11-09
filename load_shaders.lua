local shaderList = love.filesystem.getDirectoryItems("shaders")
local lastModified = {}
local fileInfo = {}
shader = {}

local function errHandler(err)
    print("ERROR: " .. err)
end

function load_shaders()
    for i = 1, #shaderList do
        fileInfo = love.filesystem.getInfo("shaders/" .. shaderList[i])
        if fileInfo.modtime ~= lastModified[i] then
            local loadedShader = love.filesystem.read("shaders/" .. shaderList[i])
            if pcall(love.graphics.newShader, loadedShader) then
                shader[string.gsub( shaderList[i], ".frag", "")] = love.graphics.newShader(loadedShader)
            else
                print(xpcall(love.graphics.newShader, errHandler, loadedShader) )
            end
            lastModified[i] = fileInfo.modtime
        end
    end
end
