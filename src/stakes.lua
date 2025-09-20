SMODS.Stake {
    key = "nightmare",
    pos = { x = 0, y = 0 },
    applied_stakes = { "red" },
    modifiers = function()
        G.GAME.modifiers.quantum_nightmare = true
        G.GAME.modifiers.scaling = 10
    end,
}
