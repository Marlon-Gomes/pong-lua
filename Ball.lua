--[[
    Copyright © 2022 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: Ball.lua
    A Ball Class.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
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

local function setVelocity (servingPlayer)
    --[[
        Helper function to initialize the ball's velocity. Favors the serving
        player's direction if a servingPlayer is provided. Otherwise serves to
        a random side.
        ===
        Parameters:
        servingPlayer(optional)
        ===
        Returns:
        dx - an int, horitontal velocity
        dy - an int, vertical velocity
        ===
        Usage:
        dx, dy = setVelocity()
    ]]
    --[[
        Draw horizontal velocity.
        Use Lua's ternary operator syntax to simulate a coin flip: draw a
        random integer between 1 and 2; if the former, move to the right; else
        move to the left.
    ]]
    servingPlayer = servingPlayer or 0
    if servingPlayer == 0 then
        dx = math.random(2) == 1 and 100 or -100
    elseif servingPlayer == 1 then
        dx = 100
    elseif servingPlayer == 2 then
        dx = -100
    end
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

function Ball:reset(servingPlayer)
    --[[
        Reset the ball to the center of the screen. If a servingPlayer is
        provided, serves in the direction favorable to this player. Otherwise,
        assigns a random initial velocity.

        ===
        Parameters:
        servingPlayer - an int; an optional identifier to the serving player.
        ===
        Returns:
        nil
    ]]
    servingPlayer = servingPlayer or 0
    -- Ball positions
    self.x = constants.VIRTUAL_WIDTH / 2 - 2
    self.y = constants.VIRTUAL_HEIGHT / 2 - 2
    -- Initialize ball velocity
    self.dx, self.dy = setVelocity(servingPlayer)
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

function Ball:collidesWithPaddle(paddle)
    --[[
        Detects if the ball has collided with a paddle.
        ===
        Parameters:
        paddle - an instance of the Paddle class.
        ===
        Returns:
        bool
        ===
        Usage:
        bool = Ball:collides(paddle)
    ]]
    -- Check if the left edge of one is farther to the right than the right edge
    --  of the other
    if (
        self.x > paddle.x + paddle.width or
        paddle.x > self.x + self.width
    ) then
        return false
    -- Check if the bottom edge of one is higher the the top edge of the other
    elseif (
        self.y > paddle.y + paddle.height or
        paddle.y > self.y + self.height
    ) then
        return false
    else
        constants.PADDLE_HIT:play()
        return true
    end
end

function Ball:bounceOffPaddle(paddle)
    --[[
        Handles the ball's bounce off a paddle, assuming a collision took place.
        ===
        Parameters:
        paddle - an instance of the Paddle class.
        ===
        Returns:
        nil
        ===
        Usage:
        Ball:boundceOffPaddle(paddle)
    ]]
    -- Move the ball off the paddle; direction depends on paddle's side.
    if self.dx < 0 then -- ball collided with left paddle
        self.x = paddle.x + paddle.width
    else -- ball collided with the right paddle
        self.x = paddle.x - ball.width
    end
    -- reflect horizontal velocity
    -- change vertical velocity randomly, (keeping direction)
    --[[
        TODO: implement better physics that takes into account the paddle's
        velocity.
    ]]
    self.dx = - 1.03 * self.dx -- constant horizontal boost
    -- the ternary operator returns 1 if self.dy < 0, and 0 if self.dy >= 0;
    self.dy = ((-1)^(self.dy < 0 and 1 or 0)) * math.random(10, 150)
end


function Ball:handleCollisions(paddle1, paddle2)
    --[[
        Check if the ball has collided with the edges of the screen or one of
        the paddles. If so, reflect the ball accordingly.
        ===
        Parameters:
        -- paddle1 - an instance of the Paddle class; controlled by player 1.
        -- paddle2 - an instance of the Paddle calss; controlled by player 2.
        ===
        Returns:
        nil
        ===
        Usage:
        Ball:handleCollisions(paddle1, paddle2)
    ]]
    -- Check for collisions with the top and bottom edges.
    if self.y <= 0 then
        -- reset the ball's position to the top edge
        self.y = 0
        self.dy = -self.dy
        -- play sound
        constants.WALL_HIT:play()
    elseif self.y >= constants.VIRTUAL_HEIGHT - 4 then
        --reset the ball's postion to the bottom edge
        self.y = constants.VIRTUAL_HEIGHT - 4
        self.dy = -self.dy
        -- play sound
        constants.WALL_HIT:play()
    -- Now check for collisions with the paddles
    elseif self:collidesWithPaddle(paddle1) then
        self:bounceOffPaddle(paddle1)
    elseif self:collidesWithPaddle(paddle2) then
        self:bounceOffPaddle(paddle2)
    end
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
