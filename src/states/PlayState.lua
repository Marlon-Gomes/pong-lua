--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/states/PlayState.lua
    Class PlayState, modeling the active state of the game.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]
-- Importing modules
local constants = require 'src/constants'
local Class = require 'external/class'
local BaseState = require 'src/states/BaseState'
-- Class declaration
local PlayState = Class{__includes = BaseState}
--[[
    PlayState models the game's behavior during a play round.
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

function PlayState:render()
    --[[
        Renders scoreboard and ball
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
    ]]
    gScoreboard:render(gPlayer1.score, gPlayer2.score)
    gBall:render()
end

function PlayState:update(dt)
    --[[
        Handle collisions, handle scoring, update paddles and ball, and monitor
        for pauses.
        ===
        Parameters:
        dt - an int; the number of frames elapsed.
        ===
        Returns:
        nil
    ]]
    gBall:handleCollisions(gPlayer1.paddle, gPlayer2.paddle)
    -- Check if any player scored
    if gBall.x < 0 then 
        PlayState:handleScoring(gPlayer2)
    elseif gBall.x >= constants.VIRTUAL_WIDTH then
        PlayState:handleScoring(gPlayer1)
    end
    -- If we reach this line, no player scored. Update paddles and ball.
    gPlayer1.paddle:update(dt)
    gPlayer2.paddle:update(dt)
    gBall:update(dt)
    -- Pause the game if space is pressed
    if love.keyboard.wasPressed('space') then gStateMachine:change('pause') end
end

function PlayState:handleScoring(player)
    --[[
        Increments a player's score. Handles state transitions into serve or
        end state depending on player's score.
        ===
        Parameters:
        player - an instance of Player class; the scoring player.
        ===
        Returns:
        nil
    ]]
    player.score = player.score + 1
    if player.score == 11 then
        constants.VICTORY:play()
        gStateMachine:change('end', { winningPlayer = player.playerNumber} )
    else 
        constants.SCORE:play()
        gStateMachine:change('serve', { servingPlayer = player.playerNumber} )
    end
end

return PlayState