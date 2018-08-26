local shaderList = { {"mandelbrotShader.frag", "mandelbrot"}, {"iterationCheck.frag", "iterationCheck"} }
local lastModified = {}
local fileInfo = {}
shader = {}

function load_shaders()
    for i = 1, #shaderList do
        fileInfo = love.filesystem.getInfo(shaderList[i][1])
        if fileInfo.modtime ~= lastModified[i] then
            local loadedShader = love.filesystem.read(shaderList[i][1])
            shader[shaderList[i][2]] = love.graphics.newShader(loadedShader)
            lastModified[i] = fileInfo.modtime
        end
    end
end
