--[[
    Project: Pong Remake

    -- Main Program --

    Author: Marlon de Oliveira Gomes
    mgomes.math@gmail.com
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    Initializer
]]
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
        }
    )
end

--[[
    Draw to the screen.
]]
function love.draw()
    love.graphics.printf(
        'Hello, Pong!',             -- Welcome text
        0,                          -- Starting X
        WINDOW_HEIGHT / 2 - 6,      -- Starting Y
        WINDOW_WIDTH,               -- Number of pixels to center within
        'center'                    -- alignment mode
    )
end
