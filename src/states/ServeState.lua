--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/states/ServeState.lua
    Class ServeState, an intermediary state between plays.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]
-- Importing modules
local constants = require 'src/constants'
local Class = require 'external/class'
local BaseState = require 'src/states/BaseState'
-- Class declaration
local ServeState = Class{__includes = BaseState}
--[[
    ServeState models the game's behavior prior to a play round.
    ===
    Attributes:
    servingPlayer - an int; (1) for Player 1, (2) for Player 2
    ===
    Public methods:
    init - The constructor, inherited from BaseState
    enter - Defines transition into the state
    exit - Defines transition out of the state, inherited from BaseState
    render - Defines how to render dynamic elements of the game in the state
    update - Defines how dynamic elements are updated in the state
]]

    function ServeState:enter(params)
        --[[
            Sets the serving player upon entering the state.
            ===
            Parameters:
            params - a table; contains servingPlayer, an int between 1 and 2
            representing the next player to serve.
            ===
            Returns:
            nil
        ]]
        self.servingPlayer = params['servingPlayer']
    end

    function ServeState:render()
    --[[
        Render's serve prompt.
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
    ]]
        love.graphics.setFont(constants.SMALLFONT)
        love.graphics.printf(
            'Player ' .. tostring(self.servingPlayer) .. "'s serve!",
            0, 10, constants.VIRTUAL_WIDTH, 'center'
        )
        love.graphics.printf(
            'Press Enter to serve!', 0, 20, constants.VIRTUAL_WIDTH, 'center'
        )
    end

    function ServeState:update(dt)
        --[[
            Reset the ball's position to the serving player. Monitor for player
            input, returning to the play state when prompted.
            ===
            Parameters:
            dt - an int; the number of frames elapsed.
            ===
            Returns:
            nil
        ]]
        -- 
        gBall:reset(self.servingPlayer)
        if (
            love.keyboard.wasPressed('enter') or 
            love.keyboard.wasPressed('return')
        ) then gStateMachine:change('play') end
    end

return ServeState