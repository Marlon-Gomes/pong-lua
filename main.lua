--[[
    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: main.lua
    The Main Program

    Author: Marlon de Oliveira Gomes
    mgomes.math@gmail.com
]]

--[[
    Low-res appearance: push (https://github.com/Ulydev/push) is a library
    that allows us to draw the game at a virtual resolution.
]]
local push = require 'push'

local constants = require 'constants'

--[[
    Importing classes
]]
local Ball = require 'Ball'
local Paddle = require 'Paddle'
local Player = require 'Player'
local Scoreboard = require 'Scoreboard'
--[[
    Initializer
]]
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    love.graphics.setDefaultFilter('nearest','nearest')
    -- set the title of our application window
    love.window.setTitle('Pong')
    -- set a random seed based on UNIX timestamp
    math.randomseed(os.time())
    -- Declare fonts
    smallFont = love.graphics.newFont(
        'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 8)
    largeFont = love.graphics.newFont(
            'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 16)
    -- Set font for the welcome screen
    love.graphics.setFont(smallFont)
    -- initialize virtualization
    push:setupScreen(
        constants.VIRTUAL_WIDTH,
        constants.VIRTUAL_HEIGHT,
        constants.WINDOW_WIDTH,
        constants.WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = false,
            vsync = true
        }
    )
    -- Initialize the game's assets
    -- Ball
    ball = Ball()
    -- Players (each with their own paddle and score).
    player1 = Player(1)
    player2 = Player(2)
    -- Scoreboard
    scoreboard = Scoreboard()
    --[[
        Initialize the game state into 'start' mode
    ]]
    gameState = 'start'
end

function love.update(dt)
    if gameState == 'serve' then
        ball:reset(servingPlayer)
    elseif gameState == 'play' then
        --[[
            Check if ball has collided with either the top or bottom edges or
            one of the paddles. If so, handle the collision.
        ]]
        ball:handleCollisions(player1.paddle, player2.paddle)
        --[[
            Check if the ball has gone out of bounds. If so, increment score
            and reset the ball.
        ]]
        if ball.x < 0 then
                player2.score = player2.score + 1
                servingPlayer = 2
                if player2.score == 11 then
                    winningPlayer = 2
                    gameState = 'done'
                else
                    gameState = 'serve'
                end
        elseif ball.x > constants.VIRTUAL_WIDTH then
                player1.score = player1.score + 1
                servingPlayer = 1
                if player1.score == 11 then
                    winningPlayer = 1
                    gameState = 'done'
                else
                    gameState = 'serve'
                end
        end
        -- Player 1 movement
        player1.paddle:update(dt)
        -- Player 2 movement
        player2.paddle:update(dt)
        -- Ball movement
        ball:update(dt)
    end
end
--[[
    Game state handling
]]
function love.keypressed(key)
    if key == 'escape' then -- Terminate the application
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then -- Initialize game
            gameState = 'play'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            -- Return to start screen
            gameState = 'start'
            -- Reset game assets
            -- Player scores
            player1:reset()
            player2:reset()
            -- Ball positions
            ball:reset()
            servingPlayer = nil
            winningPlayer = nil
        else -- Return to start screen
            gameState = 'start'
            -- Reset game assets
            -- Player scores
            player1:reset()
            player2:reset()
            -- Ball positions
            ball:reset()
            servingPlayer = nil
            winningPlayer = nil
        end
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
    -- Draw regardless of game game state
    --[[
        Add rectangles for paddles and ball
    ]]
    -- left side
    player1.paddle:render()
    -- right side
    player2.paddle:render()
    -- Draw "Hello, Pong!" if game is in start mode
    if gameState == 'start' then
        love.graphics.printf(
            'Hello, Pong!',                   -- Welcome text
            0,                                -- Starting X
            constants.VIRTUAL_HEIGHT / 2 - 6, -- Starting Y
            constants.VIRTUAL_WIDTH,          -- # of pixels to center within
            'center'                          -- alignment mode
        )
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf(
            'Player ' .. tostring(servingPlayer) .. "'s serve!",
            0, 10, constants.VIRTUAL_WIDTH, 'center'
        )
        love.graphics.printf(
            'Press Enter to serve!', 0, 20, constants.VIRTUAL_WIDTH, 'center'
        )
    -- Draw game score board and ball only if game is in play mode
    elseif gameState == 'play' then
        -- Draw scoreboard
        scoreboard:render(player1.score, player2.score)
        -- Draw ball
        ball:render()
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf(
            "Player " .. tostring(winningPlayer) .. " wins!",
            0, 10, constants.VIRTUAL_WIDTH, 'center'
        )
        love.graphics.setFont(smallFont)
        love.graphics.printf(
            'Press enter to restart!',
            0, 30, constants.VIRTUAL_WIDTH, 'center'
        )
    end
    -- new function just to demonstrate how to see FPS in LÖVE2D
    displayFPS()
    -- end rendering at virtual resolution
    push:apply('end')
end

-- Renders the current FPS.
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
