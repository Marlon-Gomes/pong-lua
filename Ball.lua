--[[
    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: Ball.lua
    A Ball Class.

    Author: Marlon de Oliveira Gomes
    mgomes.math@gmail.com
]]

-- Importing modules
local Class = require 'class'
local constants = require 'constants'

-- Class declaration
local Ball = Class{}
--[[
    Ball is an independent game asset.
    -- TODO: Modify the above description once a collision logic is introduced.
    ===
    Attributes:
    width - an int;
    height - an int;
    x - an int, horizontal position;
    y - an int, vertical position;
    dx - an int, the ball's horizontal velocity;
    dy - an int, the ball's vertical velocity.
    ===
    Private methods:
    setVelocity - a helper function that randomly assigns a velocity vector to
        the ball.
    ===
    Public methods:
    init - the constructor;
    update - updates the ball's position based on its velocity and time elapsed.
    reset - resets the ball's original position and randomly assigns a new
        velocity.
    render - renders the ball to the screen
]]

local function setVelocity ()
    --[[
        Helper function to initialize the ball's velocity
        ===
        Parameters:
        None
        ===
        Returns:
        dx - an int, horitontal velocity
        dy - an int, vertical velocity
        ===
        Usage:
        vx, vy = setVelocity()
    ]]
    --[[
        Draw horizontal velocity.
        Use Lua's ternary operator syntax to simulate a coin flip: draw a
        random integer between 1 and 2; if the former, move to the right; else
        move to the left.
    ]]
    dx = math.random(2) == 1 and 100 or -100
    dy = math.random(-50, 50)
    return dx, dy
end

function Ball:init()
    --[[
        Constructor method.
        ===
        Parameters:
        None
        ===
        Returns:
        self - an instance of class Ball.
        ===
        Usage:
        ball = Ball()
    ]]
    -- Ball characteristics
    self.width = constants.BALL_WIDTH
    self.height = constants.BALL_HEIGHT
    -- Ball positions
    self.x = constants.VIRTUAL_WIDTH / 2 - 2
    self.y = constants.VIRTUAL_HEIGHT / 2 + 2
    -- Initialize ball velocity
    self.dx, self.dy = setVelocity()
end

function Ball:reset()
    --[[
        Reset the ball to a given position; randomly assign it a new velocity.
        ===
        Parameters:
        x: the ball's new horizontal position after reset
        y: the ball's new vertical position after reset
        ===
        Returns:
        nil
    ]]
    -- Ball positions
    self.x = constants.VIRTUAL_WIDTH / 2 - 2
    self.y = constants.VIRTUAL_HEIGHT / 2 -2
    -- Initialize ball velocity
    self.dx, self.dy = setVelocity()
end

function Ball:update(dt)
    --[[
        Updates the ball position according to its velocity. Using 'dt' so
        that it is frame-rate independent.
        ===
        Parameters:
        dt: a time interval
        ===
        Returns:
        nil
    ]]
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    --[[
        Renders the ball to the screen using the LÖVE graphics library
        ===
        Parameters:
        None
        ===
        Returns:
        nil
    ]]
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Ball
