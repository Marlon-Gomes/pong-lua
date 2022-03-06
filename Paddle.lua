--[[
    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: Paddle.lua
    A Paddle Class.

    Author: Marlon de Oliveira Gomes
    mgomes.math@gmail.com
]]

-- Importing modules
local Class = require 'class'
local constants = require 'constants'

-- Local constants, used only in this file.
local PADDLE_MIN_Y = constants.VIRTUAL_HEIGHT - constants.PADDLE_HEIGHT
local PADDLE_CONTROLS = {
    {'w', 's'}, -- Player 1
    {'up', 'down'} -- Player 2
}
local PADDLE_STARTING_POSITION = {
    {10, 30}, -- Player 1
    {constants.VIRTUAL_WIDTH - 10, constants.VIRTUAL_HEIGHT - 50} -- Player 2
}

-- Class declaration
local Paddle = Class{}
--[[
    Paddle is a game asset associated to a controler, a instance of the Player
    class. The paddle's initial position and controls are determined by the
    player it serves.
    ===
    Attributes:
    width - an int;
    height - an int;
    paddleNumber - an int; identifies the player linked to the paddle.
    x - an int, horizontal position;
    y - an int, vertical position;
    upkey - a string, the key used to move the paddle up;
    downkey - a string, the key used to move the paddle down;
    dy - an int, the paddle's vertical velocity.
    ===
    Public methods:
    init - the constructor;
    update - updates the paddle's position based on user input and time elapsed.
    reset - resets the paddle to its original position
    render - renders the paddle to the screen
]]

function Paddle:init(playerNumber)
    --[[
        Constructor
        ===
        Parameters:
        playerNumber - An int, the identifier of the paddle's controller.
        ===
        Returns:
        self - an instance of class Paddle.
        ===
        Usage:
        paddle = Paddle(playerNumber)
    ]]
    -- Constant attributes
    self.width = constants.PADDLE_WIDTH
    self.height = constants.PADDLE_HEIGHT
    --[[
        Parametric attributes.
        Note the use of unpack, Lua 5.1 syntax, as opposed to table.unpack, the
        modern approach. Love2D 11 is based on Lua 5.1.
    ]]
    self.paddleNumber = playerNumber
    self.x, self.y = unpack(PADDLE_STARTING_POSITION[self.paddleNumber])
    self.upkey, self.downkey = unpack(PADDLE_CONTROLS[self.paddleNumber])
    -- Paddle's velocity (y-axis only); paddle initializes at rest.
    self.dy = 0
end

function Paddle:update(dt)
    --[[
        Paddle movement.
        ===
        Parameters:
        dt - a time delta.
        ===
        Returns:
        nil
        ===
        Usage:
        paddle:update(dt)
    ]]
    if love.keyboard.isDown(self.upkey) then
        -- Recall the reverse y-axis orientation.
        self.dy = - constants.PADDLE_SPEED
        -- Math.max prevents paddle from going over the screen's top edge.
        self.y = math.max(0, self.y + self.dy * dt)
    elseif love.keyboard.isDown(self.downkey) then
        self.dy = constants.PADDLE_SPEED
        -- Math.min prevents paddle from going under the screen's bottom edge.
        self.y = math.min(PADDLE_MIN_Y, self.y + self.dy * dt)
    end
end

function Paddle:reset()
    --[[
        Resets the paddle to its original position.
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
        ===
        Usage:
        paddle:reset()
    ]]
    self.x, self.y = unpack(PADDLE_STARTING_POSITION[self.paddleNumber])
end

function Paddle:render()
    --[[
        Renders the paddle to the screen.
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
        ===
        Usage:
        paddle:render()
    ]]
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle
