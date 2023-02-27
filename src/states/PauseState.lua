--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/states/PauseState.lua
    Class PauseState, a pause state for the game.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]

-- Importing modules
local constants = require 'src/constants'
local Class = require 'external/class'
local BaseState = require 'src/states/BaseState'
-- Class declaration
local PauseState = Class{__includes = BaseState}
--[[
    PauseState models the game's behavior during a pause.
    ===
    Attributes:
    nil
    ===
    Public methods:
    init - The constructor, inherited from BaseState
    enter - Defines transition into the state, inherited from BaseState
    exit - Defines transition out of the state, inherited from BaseState
    render - Defines how to render dynamic elements of the game in the state
    update - Defines how dynamic elements are updated in the state
]]

function PauseState:render()
    --[[
        Render scoreboard and pause message
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
    ]]
    gScoreboard:render(gPlayer1.score, gPlayer2.score)
    love.graphics.setFont(constants.LARGEFONT)
    love.graphics.printf("Paused",0, 70, constants.VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(constants.SMALLFONT)
    love.graphics.printf(
        'Press enter to resume', 0, 90, constants.VIRTUAL_WIDTH, 'center'
    )
end

function PauseState:update(dt)
    --[[
        Monitor keypresses and resume the game if space if pressed.
        ===
        Parameters:
        dt - an int; the number of frames elapsed.
        ===
        Returns:
        nil
    ]]
    if love.keyboard.wasPressed('space') then gStateMachine:change('play') end
end

return PauseState