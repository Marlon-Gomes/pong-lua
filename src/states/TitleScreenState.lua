--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/states/TitleScreenState.lua
    Class TitleScreenState, a State used to greet the user.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]
-- Import modules
local constants = require 'src/constants'
local Class = require 'external/class'
local BaseState = require 'src/states/BaseState'
-- Declare local constants
local GAME_TITLE = "Pong!"
local USER_PROMPT = "Press Enter to Start"
-- Class declaration
local TitleScreenState = Class{__includes = BaseState}
--[[
    TitleScreenState is the game's initial state.
    ===
    Attributes:
    nil
    ===
    Public methods:
    init - the constructor, inherited from BaseState
    enter - change into the state, inherited from BaseState
    exit - change out of the state, inherited from BaseState
    render - renders the state
    update - updates the state
]]
    function TitleScreenState:exit()
        --[[
            Reset game assets (players and ball).
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

    function TitleScreenState:render()
        --[[
            Renders the welcome screen, displaying the game's title and 
            prompting the user to start the game.
            ===
            Parameters:
            nil
            ===
            Returns:
            nil
        ]]
        love.graphics.setFont(constants.LARGEFONT)
        love.graphics.printf(
            GAME_TITLE, 0, 64, constants.VIRTUAL_WIDTH, 'center'
        )
        love.graphics.setFont(constants.SMALLFONT)
        love.graphics.printf(
            USER_PROMPT, 0, 100, constants.VIRTUAL_WIDTH, 'center'
        )
    end

    function TitleScreenState:update(dt)
        --[[
            Updates the title screen, monitoring for user input to advance to 
            the next state (serve). Selects serving player at random.
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
            gStateMachine:change('serve', { servingPlayer = math.random(2)})
        end
    end

return TitleScreenState