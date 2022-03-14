--[[
    Copyright © 2022 Marlon de Oliveira Gomes.
    MIT License
    
    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: Scoreboard.lua
    Class Scoreboard, used to keep the game's score.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]
-- Importing modules
local Class = require 'Class'
local constants = require 'constants'

-- Class declaration
local Scoreboard = Class{}
--[[
    Scoreboard is a game asset that observes the players to display their
    scores to the screen.
    ===
    Attributes:
    font - a love graphics font;
    p1x - an int; the horizontal position of player 1's score.
    p2x - an int; the horizontal position of player 2's score.
    y - an int; the vertical position of players' scores.
    ===
    Public methods:
    init - the constructor;
    render - renders the paddle to the screen
]]

function Scoreboard:init()
    --[[
        Constructor
        ===
        Parameters:
        nil
        ===
        Returns:
        self - an instance of class Scoreboard.
        ===
        Usage:
        scoreboard = Scoreboard()
    ]]
    -- General attributes
    self.font = constants.SCOREFONT
    -- Horizontal positions of player 1 and player 2 scores
    self.p1x = constants.VIRTUAL_WIDTH / 2 - 54
    self.p2x = constants.VIRTUAL_WIDTH / 2 + 22
    -- Vertical position (applies to both players)
    self.y = constants.VIRTUAL_HEIGHT / 15
end

function Scoreboard:render(p1Score, p2Score)
    --[[
        Render the players' scores to the screen
        ===
        Parameters:
        p1Score - an int
        p2Score - an int
        ===
        Returns:
        nil
        ===
        Usage:
        Scoreboard:render(p1score, p2score)
    ]]
    love.graphics.setFont(self.font)
    love.graphics.print(tostring(p1Score), self.p1x, self.y)
    love.graphics.print(tostring(p2Score), self.p2x, self.y)
end

return Scoreboard
