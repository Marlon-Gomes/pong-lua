--[[
    Copyright © 2022 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/Player.lua
    Class Player, a first-class game entity that control and is observed by
    other assets.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]
-- External libraries
local Class = require 'external/class'
-- Source
local constants = require 'src/constants'
local Paddle = require 'src/Paddle'

-- Class declaration
local Player = Class{}
--[[
    A a first-class game entity that control and is observed by other assets.
    ===
    Attributes:
    playerNumber - an int; identifies the player to assets who observe it.
    paddle - an instance of the Paddle class; controlled by the player.
    score - an int; observed by the scoreboard.
    ===
    Public methods:
    init - the constructor;
    reset - resets the player's paddle and score.
]]

function Player:init(playerNumber)
    --[[
        Constructor
        ===
        Parameters:
        playerNumber - an int, the player's identifier.
        ===
        Returns
        self - an instance of class Player
    ]]
    -- Who am I?
    self.playerNumber = playerNumber
    -- Associate a paddle to the player
    self.paddle = Paddle(self.playerNumber)
    -- Initialize player's score
    self.score = 0
end

--TODO: add a function to update the player's score

function Player:reset()
    --[[
        Resets the player score. Resets the player's paddle.
        ===
        Parameters:
        None
        ===
        Returns
        nil
    ]]
    self.score = 0
    self.paddle:reset()
end

return Player
