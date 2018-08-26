z = {}
c = {}
c.x, c.y = 0, 0
mousetrans = {}

function debugoverlay()

    escapeValue = {}
    mousetrans.x, mousetrans.y = ( mouse.x/dimensions.x - 0.5)*scale.x*2 - offset.x, ( mouse.y/dimensions.x - 0.5*(dimensions.y/dimensions.x) )*scale.y*2*-1 + offset.y * (dimensions.y/dimensions.x)
    if fractaltype == 0  then
        z.x, z.y = 0, 0
        if love.keyboard.isDown("lctrl") then
            c.x, c.y = mousetrans.x, mousetrans.y
        end
    end
    for i = 1, iterations do
        z.x, z.y = z.x * z.x + -z.y * z.y + c.x, z.x * z.y + z.x * z.y + c.y
        escapeValue[i * 2 - 1], escapeValue[i * 2] = ( (z.x + offset.x)/2/scale.x + 0.5) * dimensions.x,
        ( (z.y - offset.y *(dimensions.y/dimensions.x) ) * -1/2/scale.y/(dimensions.y/dimensions.x) + 0.5)*dimensions.x
    end

    if iterations > 1 then
        love.graphics.line(escapeValue)
    end

    fps = fps and (runtime%0.1+deltatime > 0.1 and round(1/deltatime, 2) or fps) or 0

    local debugTbl = {fps, {dimensions.x, dimensions.y}, {round(scale.x, 4), round(scale.y, 4) },
    {offset.x, offset.y}, iterations, {mouse.x, mouse.y}, {round(z.x, 4), round(z.y, 4)},
    {round(c.x, 4), round(c.y, 4)}, rainbowssss}
    local output

    love.graphics.setColor(1, 1, 1, 1)

    output = ""
    for i, v in pairs(debugTbl) do
        if type(v) ~= "table" then
            output = output .. tostring(v) .. "\n"
        else
            for j, u in pairs(v) do
                output = output .. tostring(u) .. " "
            end
            output = output .. "\n"
        end
    end

    love.graphics.print(output, 0, 0)

end
