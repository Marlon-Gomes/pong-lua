--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/states/EndGameState.lua
    Class EndGameState, a terminal state for the game.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]

-- Importing modules
local constants = require 'src/constants'
local Class = require 'external/class'
local BaseState = require 'src/states/BaseState'
-- Class declaration
local EndGameState = Class{__includes = BaseState}
--[[
    EndGameState is a class modeling the game's end state.
    ===
    Attributes:
    nil
    ===
    Public methods:
    init - The constructor, inherited from BaseState
    enter - Defines transition into the state
    exit - Defines transition out of the state
    render - Defines how to render dynamic elements of the game in the state
    update - Defines how dynamic elements are updated in the state
]]
    function EndGameState:enter(params)
    --[[
        Sets the winning player upon entering the state.
        ===
        Parameters:
        params - a table; contains winningPlayer, an int between 1 and 2
        representing the player who won.
        ===
        Returns:
        nil
    ]]
        self.winningPlayer = params['winningPlayer']
    end

    function EndGameState:exit()
    --[[
        Reset game assets on exit.
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
    ]]
        gPlayer1:reset()
        gPlayer2:reset()
        gBall:reset()
    end

    function EndGameState:render()
    --[[
        Render winning message.
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
    ]]
        love.graphics.setFont(constants.LARGEFONT)
        love.graphics.printf(
            "Player " .. tostring(self.winningPlayer) .. " wins!",
            0, 10, constants.VIRTUAL_WIDTH, 'center'
        )
        love.graphics.setFont(constants.SMALLFONT)
        love.graphics.printf(
            'Press enter to restart!',
            0, 30, constants.VIRTUAL_WIDTH, 'center'
        )
    end

    function EndGameState:update(dt)
        --[[
            Monitors keypresses and returns to the title state if enter or 
            return is pressed.
            ===
            Parameters:
            dt - an int; the number of frames elapsed.
            ===
            Returns:
            nil
        ]]
        if (
            love.keyboard.wasPressed('enter') or 
            love.keyboard.wasPressed('return')
        ) then
            -- Return to title screen
            gStateMachine:change('title')
        end
    end

return EndGameState