-- Litteraly all from https://github.com/Aikoyori/Balatro-Aikoyoris-Shenanigans and partially broken de to importing, functions do not work
Quantum.DescriptionDummies = {}

Quantum.DescriptionDummy = SMODS.Center:extend{
    set = 'QuantumDescriptionDummy',
    obj_buffer = {},
    obj_table = Quantum.DescriptionDummies,
    class_prefix = 'qdd',
    required_params = {
        'key',
    },
    pre_inject_class = function(self)
        G.P_CENTER_POOLS[self.set] = {}
    end,
    inject = function(self)
        SMODS.Center.inject(self)
    end,
    get_obj = function(self, key)
        if key == nil then
            return nil
        end
        return self.obj_table[key]
    end
}

local cardHoverHook = Card.hover
function Card:hover()
    Quantum.current_hover_card = self
    local ret = cardHoverHook(self)
    return ret
end

Quantum.card_area_preview = function(cardArea, desc_nodes, config)
    if not config then config = {} end
    local height = config.h or 1.25
    local width = config.w or 1
    local original_card = config.original_card or Quantum.current_hover_card or nil
    local speed_mul = config.speed or G.SETTINGS.GAMESPEED
    local card_limit = config.card_limit or #config.cards or 1
    local override = config.override or false
    local cards = config.cards or {}
    local padding = config.padding or 0.07
    local func_after = config.func_after or nil
    local init_delay = config.init_delay or 1
    local func_list = config.func_list or nil
    local func_delay = config.func_delay or 0.2
    local margin_left = config.ml or 0.2
    local margin_top = config.mt or 0
    local alignment = config.alignment or "cm"
    local scale = config.scale or 1
    local type = config.type or "title"
    local box_height = config.box_height or 0
    local highlight_limit = config.highlight_limit or 0
    if override or not cardArea then
        cardArea = CardArea(
            G.ROOM.T.x + margin_left * G.ROOM.T.w, G.ROOM.T.h + margin_top
            , width * G.CARD_W, height * G.CARD_H,
            {card_limit = card_limit, type = type, highlight_limit = highlight_limit, collection = true,temporary = true}
        )
        for i, card in ipairs(cards) do
            card.T.w = card.T.w * scale
            card.T.h = card.T.h * scale
            card.VT.h = card.T.h
            card.VT.h = card.T.h
            local area = cardArea
            if(card.config.center) then
                -- this properly sets the sprite size <3
                card:set_sprites(card.config.center)
            end
            area:emplace(card)
        end
    end
    local uiEX = {
        n = G.UIT.R,
        config = { align = alignment , padding = padding, no_fill = true, minh = box_height },
        nodes = {
            {n = G.UIT.O, config = { object = cardArea }}
        }
    }
    if cardArea then
        if desc_nodes then
            desc_nodes[#desc_nodes+1] = {
                uiEX
            }
        end
    end
    if func_after or func_list then
        --G.E_MANAGER:clear_queue("quantum_desc")
    end
    if func_after then
        G.E_MANAGER:add_event(Event{
            delay = init_delay * speed_mul,
            blockable = false,
            trigger = "after",
            func = function ()
                func_after(cardArea)
                return true
            end
        },"quantum_desc")
    end

    if func_list then
        for i, k in ipairs(func_list) do
            G.E_MANAGER:add_event(Event{
                delay = func_delay * i * speed_mul,
                blockable = false,
                trigger = "after",
                func = function ()
                    k(cardArea)
                    return true
                end
            },"quantum_desc")
        end
    end
    return uiEX
end


Quantum.DescriptionDummy{
    key = "music_fusion",
    generate_ui = function(self, info_queue, cardd, desc_nodes, specific_vars, full_UI_table)
        local doesntHaveJoker = {true, true, true}
        if (G.jokers and G.jokers.cards) then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i].config.center.key == "j_quantum_rewind") then doesntHaveJoker[1] = false end
                if (G.jokers.cards[i].config.center.key == "j_quantum_pause") then doesntHaveJoker[2] = false end
                if (G.jokers.cards[i].config.center.key == "j_quantum_fastf") then doesntHaveJoker[3] = false end
            end
        end
        local cards = {}
        local card = Card(-1000,-1000, G.CARD_W, G.CARD_H, SMODS.set_create_card_front, G.P_CENTERS["j_quantum_rewind"])
        if (doesntHaveJoker[1]) then
            card.debuff = true
        end
        table.insert(cards,card)
        local card = Card(-1000,-1000, G.CARD_W, G.CARD_H, SMODS.set_create_card_front, G.P_CENTERS["j_quantum_pause"])
        if (doesntHaveJoker[2]) then
            card.debuff = true
        end
        table.insert(cards,card)
        local card = Card(-1000,-1000, G.CARD_W, G.CARD_H, SMODS.set_create_card_front, G.P_CENTERS["j_quantum_fastf"])
        if (doesntHaveJoker[3]) then
            card.debuff = true
        end
        table.insert(cards,card)
        local displaycount = 0
        for i = 1, 3 do
            if (not doesntHaveJoker[i]) then
                displaycount = displaycount + 1
            end
        end

        desc_nodes[#desc_nodes+1] = {
        {
            n = G.UIT.R,
            nodes = {
                { n = G.UIT.T, config = { text = displaycount.."/3", colour = G.C.UI.TEXT_INACTIVE, scale = 0.55 }},
            }
        }
    }
        SMODS.Joker.super.generate_ui(self, info_queue, cardd, desc_nodes, specific_vars, full_UI_table)
        Quantum.card_area_preview(G.music_fusion_cards,desc_nodes,{
            override = true,
            cards = cards,
            w = 2,
            h = 0.6,
            ml = 0,
            scale = 0.5,
        })
    end,
}
