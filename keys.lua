
dimensions = {}
dimensions.x, dimensions.y = love.graphics.getDimensions()
newscale = {}
fullscreen = false
animate = 0.0
fractaltype = 0
highresDimensions = {x = 4480, y = 1080}
highresMultiplier = 2
iterationsMultiplier = 5
highresOutput = love.graphics.newCanvas(dimensions.x * highresMultiplier, dimensions.y * highresMultiplier, {msaa = 16})
dimensions.x, dimensions.y = love.graphics.getDimensions()

function love.keypressed(key, u)
    if key=="escape" then
        if fullscreen then
            fullscreen = nil
            love.window.setFullscreen(false)
        else
            love.event.quit(0)
        end
    elseif key=="f11" then
        fullscreen = not fullscreen and true or false
        love.window.setFullscreen(fullscreen)
    elseif key == "f2" then
        if  love.keyboard.isDown("lalt") then
            highresOutput = love.graphics.newCanvas(highresDimensions.x * highresMultiplier, highresDimensions.y * highresMultiplier, {msaa = 4})
            highresOutput:renderTo(function()
                love.graphics.setShader(shader.mandelbrot)
                shader.mandelbrot:send("dimensions", {highresDimensions.x * highresMultiplier, highresDimensions.y * highresMultiplier})
                shader.mandelbrot:send("iterations", iterations * iterationsMultiplier)
                love.graphics.rectangle("fill", 0, 0, highresDimensions.x * highresMultiplier, highresDimensions.y * highresMultiplier)
                love.graphics.setShader()
            end)
            highresOutput:newImageData():encode("png", "HighresMandlebrot" .. os.time() .. ".png")
            highresOutput:release()
            shader.mandelbrot:send("dimensions", {dimensions.x, dimensions.y})
            shader.mandelbrot:send("iterations", iterations )
        else
            love.graphics.captureScreenshot("Mandlebrot" .. os.time() .. ".png")
        end
    elseif key == "f3" then
        showdebug = showdebug == nil and true or nil
    elseif key == "f4" then
        debug.debug()
    elseif key == "a" then
        if love.keyboard.isDown("lalt") then
            animate = (animate == 0 or animate == 1) and -1 or 0
        else
            animate = animate == 0 and 1 or 0
        end
    elseif key == "t" then
        fractaltype = fractaltype < 1 and fractaltype + 1 or 0
    elseif key == "p" then
        petals = petals < 2 and petals + 1 or 0
    end
    --love.graphics.captureScreenshot("Mandlebrot_" .. os.time() .. ".png")
end

function keyIsDown()
    if love.keyboard.isDown("=") then
        rainbowssss = (rainbowssss - 0.2 * deltatime) % 1
        shader.mandelbrot:send("rainbowssss", rainbowssss)
    elseif love.keyboard.isDown("-") then
        rainbowssss = (rainbowssss + 0.2 * deltatime) % 1
        shader.mandelbrot:send("rainbowssss", rainbowssss)
    end
end

function love.wheelmoved(x, y)
    newscale.x, newscale.y  = math.max( scale.x - ( scale.x*0.2 )*sign( y ), 0 ), math.max( scale.y - ( scale.y*0.2 )*sign( y ), 0 )
    scale.x, scale.y = newscale.x, newscale.y
    iterations = iterations + x
    value = value + x
end

function love.mousemoved(x, y, dx, dy)
    if love.mouse.isDown(1) then
        offset.x, offset.y = offset.x + dx/dimensions.x*scale.x*2, offset.y + dy/dimensions.y*scale.y*2
    end
end
