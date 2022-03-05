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
    Initiali zer
]]
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling
    love.graphics.setDefaultFilter('nearest','nearest')
    -- set a random seed based on UNIX timestamp
    math.randomseed(os.time())
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
    --[[
        Ball variables
    ]]
    -- Initialize ball position
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 + 2
    -- Initialize ball velocity
    --[[
        Use Lua's ternary operator syntax to simulate a coin flip: draw a
        random integer between 1 and 2; if the former, move to the right; else
        move to the left.
    ]]
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)
    --[[
        Initialize the game state into 'start' mode
    ]]
    gameState = 'start'
end

function love.update(dt)
    --[[
        Paddle movements. Recall the reverse y-axis orientation.
        Use math.max to prevent paddle to go over the top edge of the screen.
        Use math.min to prevent paddle to go under the bottom edge of the screen
         (take the height of the paddle into account).
    ]]
    -- Player 1 movement
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end
    -- Player 2 movement
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end
    --[[
        Ball movement
    ]]
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
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
        else -- Return to start screen
            gameState = 'start'
            -- TODO: this is repetitive; fix it.
            -- Reinitialize ball and paddle positions
            -- Player paddle Y positions
            player1Y = 30
            player2Y = VIRTUAL_HEIGHT - 50
            -- Ball positions
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 + 2
            -- Initialize ball velocity
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50)
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
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    -- right side
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
    -- Draw "Hello, Pong!" if game is in start mode
    if gameState == 'start' then
        love.graphics.printf(
            'Hello, Pong!',             -- Welcome text
            0,                          -- Starting X
            VIRTUAL_HEIGHT / 2 - 6,      -- Starting Y
            VIRTUAL_WIDTH,               -- Number of pixels to center within
            'center'                    -- alignment mode
        )
    end
    -- Draw game score board and ball only if game is in play mode
    if gameState == 'play' then
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
        -- ball
        love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    end
    -- end rendering at virtual resolution
    push:apply('end')
end
