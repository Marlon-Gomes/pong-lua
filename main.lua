--[[
    Project: Pong Remake

    -- Main Program --

    Author: Marlon de Oliveira Gomes
    mgomes.math@gmail.com
]]

--[[
    Importing libraries
]]

--[[
    Low-res appearance: push (https://github.com/Ulydev/push) is a library
    that allows us to draw the game at a virtual resolution.
]]
push = require 'push'

--[[
    Game settings
]]
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
    Initializer
]]
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    love.graphics.setDefaultFilter('nearest','nearest')
    -- set font
    smallFont = love.graphics.newFont(
        'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 8)
    love.graphics.setFont(smallFont)
    -- initialize virtualization
    push:setupScreen(
        VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = false,
            vsync = true
        }
    )
end

--[[
    Keyboard handling: terminate the application.
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    Draw to the screen.
]]
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')
    --[[
        clear the screen; since LÖVE2D 11.0, color components are measured
        between 0 and 1
    --]]
    love.graphics.clear(40/255, 45/255, 52/255, 1)
    -- using virtual width and virtual height
    love.graphics.printf(
        'Hello, Pong!',             -- Welcome text
        0,                          -- Starting X
        VIRTUAL_HEIGHT / 2 - 6,      -- Starting Y
        VIRTUAL_WIDTH,               -- Number of pixels to center within
        'center'                    -- alignment mode
    )
    --[[
        Add rectangles for paddles and ball
    ]]
    -- left side
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    -- right side
    love.graphics.rectangle(
        'fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20
    )
    -- ball
    love.graphics.rectangle(
        'fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 + 20, 4, 4
    )
    -- end rendering at virtual resolution
    push:apply('end')
end
