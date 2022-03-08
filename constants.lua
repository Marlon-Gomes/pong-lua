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
-- Fonts
SMALLFONT = love.graphics.newFont(
    'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 8),
LARGEFONT = love.graphics.newFont(
        'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 16),
SCOREFONT = love.graphics.newFont(
    'fonts/atari-classic-font/AtariClassicChunky-PxXP.ttf', 32),
--- Sounds
PADDLE_HIT = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
SCORE = love.audio.newSource('sounds/score.wav', 'static'),
VICTORY = love.audio.newSource('sounds/victory.mp3', 'static'),
WALL_HIT = love.audio.newSource('sounds/wall_hit.wav', 'static')
}
return constants
