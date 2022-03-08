--[[
    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: constants.lua
    Program constants to be shared accross various files.

    Author: Marlon de Oliveira Gomes
    72144990+Marlon-Gomes@users.noreply.github.com
]]

local constants = {
-- General game settings
WINDOW_WIDTH = 1280,
WINDOW_HEIGHT = 720,
VIRTUAL_WIDTH = 432,
VIRTUAL_HEIGHT  = 243,
-- Ball settings
BALL_WIDTH = 4,
BALL_HEIGHT = 4,
-- Paddle settings
PADDLE_SPEED = 200,
PADDLE_WIDTH = 5,
PADDLE_HEIGHT = 20,
-- Scoreboard settings
SCOREFONT = love.graphics.newFont(
    'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 32)
}
return constants
