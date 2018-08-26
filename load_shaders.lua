local shaderList = love.filesystem.getDirectoryItems("shaders")
local lastModified = {}
local fileInfo = {}
shader = {}

function load_shaders()
    for i = 1, #shaderList do
        fileInfo = love.filesystem.getInfo("shaders/" .. shaderList[i])
        if fileInfo.modtime ~= lastModified[i] then
            local loadedShader = love.filesystem.read("shaders/" .. shaderList[i])
            shader[string.gsub( shaderList[i], ".frag", "")] = love.graphics.newShader(loadedShader)
            lastModified[i] = fileInfo.modtime
        end
    end
end
