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
-- paddle speed
PADDLE_SPEED = 200

--[[
    Initializer
]]
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    love.graphics.setDefaultFilter('nearest','nearest')
    -- Declare fonts
    smallFont = love.graphics.newFont(
        'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 8)
    scoreFont = love.graphics.newFont(
        'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 32)
    -- Set font for the welcome screen
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
    --[[
        Player variables
    ]]
    -- Initialize score variables
    player1Score = 0
    player2Score = 0
    -- Player paddle Y positions
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    --[[
        Paddle movements. Recall the reverse y-axis orientation.
    ]]
    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end --
    -- player 1 movement
    if love.keyboard.isDown('up') then
        player2Y = player2Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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
    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Hello, Pong!',             -- Welcome text
        0,                          -- Starting X
        VIRTUAL_HEIGHT / 2 - 6,      -- Starting Y
        VIRTUAL_WIDTH,               -- Number of pixels to center within
        'center'                    -- alignment mode
    )
    -- draw score
    love.graphics.setFont(scoreFont)
    love.graphics.print(
        tostring(player1Score),
        VIRTUAL_WIDTH / 2 - 54,
        VIRTUAL_HEIGHT / 15
    )
    love.graphics.print(
        tostring(player2Score),
        VIRTUAL_WIDTH / 2 + 22,
        VIRTUAL_HEIGHT / 15
    )
    --[[
        Add rectangles for paddles and ball
    ]]
    -- left side
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    -- right side
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
    -- ball
    love.graphics.rectangle(
        'fill', VIRTUAL_WIDTH / 2 - 2 , VIRTUAL_HEIGHT / 2 + 20, 4, 4
    )
    -- end rendering at virtual resolution
    push:apply('end')
end
