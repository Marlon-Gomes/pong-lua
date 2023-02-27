--[[
    Copyright © 2022 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: main.lua
    The Main Program

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]

-- External libraries
local push = require 'external/push'

-- Importing source
local constants = require 'src/constants'
local Ball = require 'src/Ball'
local Paddle = require 'src/Paddle'
local Player = require 'src/Player'
local Scoreboard = require 'src/Scoreboard'
local StateMachine = require 'src/StateMachine'
local TitleScreenState = require 'src/states/TitleScreenState'
local ServeState = require 'src/states/ServeState'
local PlayState = require 'src/states/PlayState'
local PauseState = require 'src/states/PauseState'
local EndGameState = require 'src/states/EndGameState'

-- Initializer
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    love.graphics.setDefaultFilter('nearest','nearest')
    -- set the title of our application window
    love.window.setTitle('Pong')
    -- set a random seed based on UNIX timestamp
    math.randomseed(os.time())
    -- Declare fonts
    -- Set font for the welcome screen
    love.graphics.setFont(constants.SMALLFONT)
    -- initialize virtualization
    push:setupScreen(
        constants.VIRTUAL_WIDTH,
        constants.VIRTUAL_HEIGHT,
        constants.WINDOW_WIDTH,
        constants.WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = true,
            vsync = true
        }
    )
    -- Initialize the game's global elements: ball, players, and scoreboard.
    gBall = Ball()
    gPlayer1 = Player(1)
    gPlayer2 = Player(2)
    gScoreboard = Scoreboard()
    -- Initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        ['pause'] = function() return PauseState() end,
        ['end'] = function() return EndGameState() end
    }
    gStateMachine:change('title')
    -- A table to keep track of keys pressed
    love.keyboard.keysPressed = {}
end

-- Enable resizing via push
function love.resize(w, h)
    push:resize(w,h)
end

function love.update(dt)
    gStateMachine:update(dt)
    -- Reset the keysPressed table
    love.keyboard.keysPressed = {}
end

--[[
    Game state handling
]]
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then -- Terminate the application
        love.event.quit()
    end
end

--[[
    Check for single key press
]]
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
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
    -- Paddles are drawn regardless of game game state
    gPlayer1.paddle:render()
    gPlayer2.paddle:render()
    -- Render other elements depending on state
    gStateMachine:render()
    -- new function just to demonstrate how to see FPS in LÖVE2D
    displayFPS()
    -- end rendering at virtual resolution
    push:apply('end')
end

-- Renders the current FPS.
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(constants.SMALLFONT)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
