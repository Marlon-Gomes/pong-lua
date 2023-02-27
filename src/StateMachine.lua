--[[
    Copyright © 2022-2023 Marlon de Oliveira Gomes.
    MIT License

    Project: Pong-Lua
    A remake of the classic Atari game Pong in Lua.

    File: src/StateMachine.lua
    Class StateMachine used for game state management.

    Contact: 72144990+Marlon-Gomes@users.noreply.github.com
]]
-- Importing modules
local Class = require 'external/class'

-- Class declaration
local StateMachine = Class{}
--[[
    StateMachine manages the game's life cycle.
    ===
    Attributes:
    states - a table whose entries (strings) are the game's valid states (other
than the empty state).
    empty - a table of functions declaring functions common to all valid states.
    current - an instance of class state (a table), the game's current state
    ===
    Public methods:
    init - the constructor
    change - moves from one state to another
    update - updates the current state
    render - renders the current state
]]

function StateMachine:init(states)
    --[[
        Constructor
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
        ===
        Usage:
        -- prefix g indicates this should be a global variable
        gStateMachine = StateMachine()
    ]]
    -- Define an empty state template after which all states will be modeled
    self.empty = {
        init = function() end,
        enter = function() end,
        exit = function() end,
        render = function() end,
        update = function() end
    }
    -- Register user input
    self.states = states or {} -- if no state provided
    -- Set current state to empty
    self.current = self.empty
end

function StateMachine:change(stateName, params)
    --[[
        Move between states
        ===
        Parameters:
        stateName - an instance of a State class; the target state.
        params - a table; additional parameters passed to the target state.
        ===
        Returns:
        nil
    ]]
    -- Assert that target state exists
    assert(self.states[stateName])
    -- TODO: validate parameters
    -- TODO: add error handlers
    -- Call the destructor on the current state
    self.current:exit()
    -- Initialize target state
    self.current = self.states[stateName]()
    -- Construct new state according to parameters
    self.current:enter(params)
end

function StateMachine:update(dt)
    --[[
        Update the current state
        ===
        Parameters:
        dt - an int; the number of frames elapsed.
        ===
        Returns:
        nil
    ]]
    -- Relay to derived class's update method
    self.current:update(dt)
end

function StateMachine:render()
    --[[
        Render the current state
        ===
        Parameters:
        nil
        ===
        Returns:
        nil
    ]]
    -- Relay to derived class's render method
    self.current:render()
end

return StateMachine