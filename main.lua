require "keys"
require "debugoverlay"
require "mathlib"
require "load_shaders"

function love.load()
    dimensions = {}
    dimensions.x, dimensions.y = love.graphics.getDimensions()
    scale = {}
    scale.x = 2
    scale.y = 2
    offset = {}
    offset.x = 0
    offset.y = 0
    mouse = {}
    mouse.x, mouse.y = love.mouse.getX(), love.mouse.getY()
    value = 1
    iterations = 10000
    fractaltype = 0
    petals = 0
    rainbowssss = 0
    storeFrame = love.graphics.newCanvas(dimensions.x, dimensions.y)
    iterationsMap = love.graphics.newCanvas(dimensions.x, dimensions.y)

    load_shaders()

    shader.mandelbrot:send("rainbowssss", rainbowssss)

end

function love.update(dt)
    deltatime = dt
    runtime = runtime and runtime + deltatime or 0
    dimensions.x, dimensions.y = love.graphics.getDimensions()
    mouse.x, mouse.y = love.mouse.getX(), love.mouse.getY()
    if  runtime%0.05+dt > 0.05 then
        iterations = iterations > 0 and iterations + animate or 1
        --love.graphics.captureScreenshot("Mandlebrot_" .. runtime .. ".png")
    end
    shader.mandelbrot:send("dimensions", {dimensions.x, dimensions.y})
    shader.mandelbrot:send("scale", {scale.x, scale.y})
    shader.mandelbrot:send("offset", {offset.x, offset.y})
    shader.mandelbrot:send("mousecoords", {( mouse.x/dimensions.x - 0.5)*scale.x*2 - offset.x, ( mouse.y/dimensions.x - 0.5*(dimensions.y/dimensions.x) )*scale.y*2*-1 + offset.y * (dimensions.y/dimensions.x)} )
    shader.mandelbrot:send("iterations", iterations)
    shader.mandelbrot:send("type", fractaltype)
    shader.mandelbrot:send("petals", petals)
    shader.mandelbrot:send("iterationsMap", iterationsMap)

    shader.iterationCheck:send("dimensions", {dimensions.x, dimensions.y})

    keyIsDown()

    if runtime%1 + dt > 1 then
        load_shaders()
    end
end

function love.draw()
    if storeFrame:getWidth() ~= dimensions.x or storeFrame:getHeight() ~= dimensions.y then
        storeFrame = love.graphics.newCanvas(dimensions.x, dimensions.y)
        iterationsMap = love.graphics.newCanvas(dimensions.x, dimensions.y)
    end
    storeFrame:renderTo(function()
        love.graphics.setShader(shader.mandelbrot)
        love.graphics.rectangle("fill", 0, 0, dimensions.x, dimensions.y)
        love.graphics.setShader()
    end)

    iterationsMap:renderTo(function()
        love.graphics.setShader(shader.iterationCheck)
        love.graphics.draw(storeFrame, 0, 0)
        love.graphics.setShader()
    end)

    love.graphics.draw(storeFrame, 0, 0, 0, 1, 1)

    if showdebug then
        debugoverlay()
    end
end
