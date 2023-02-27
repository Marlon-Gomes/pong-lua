--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/states/BaseState.lua
    Class BaseState, a base class for game states.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]

-- Importing modules
local Class = require 'external/class'
-- Class declaration
local BaseState = Class{}
--[[
    BaseState is a base class that models each of the game's states.
    ===
    Attributes:
    nil
    ===
    Public methods:
    init - The constructor
    enter - Defines transition into the state
    exit - Defines transition out of the state
    render - Defines how to render dynamic elements of the game in the state
    update - Defines how dynamic elements are updated in the state
]]

function BaseState:init() end

function BaseState:enter() end

function BaseState:exit() end

function BaseState:render() end

function BaseState:update(dt)
    --[[
        Defines how dynamic elements are updated in the state
        ===
        Parameters:
        dt - an int; the number of frames elapsed.
        ===
        Returns:
        nil
    ]]
end

return BaseState