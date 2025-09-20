Quantum = {}

assert(SMODS.load_file("src/cardPreviewStuff.lua"))()
assert(SMODS.load_file("src/joker_use.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()

SMODS.Atlas({
	key = "placeholders",
	path = "placeholders.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "music",
	path = "music_jokers.png",
	px = 71,
	py = 95,
})

SMODS.Challenge{
    loc_txt = "Joker Testing",
    key = 'testing',
    jokers = {
--        {id = 'j_gabr_ultblue', edition = "negative"},
--        {id = 'j_gabr_ultbrain'},
--        {id = 'j_gabr_ultjoker'},
--        {id = 'j_gabr_ultstencil'},
--        {id = 'j_gabr_ultgolden'},
--        {id = 'j_gabr_ultthrowback'},
--        {id = 'j_gabr_ultinvisible'},
        {id = 'j_quantum_rewind'},
		{id = 'j_quantum_pause'},
		{id = 'j_quantum_fastf'},
    },
	consumeables = {
		{id ='c_tower'},
		{id ='c_tower'}
	}
}

SMODS.Challenge{
    loc_txt = "Priceless Gem",
    key = 'pricegem',
    jokers = {
		{id = 'j_quantum_rolling_rock', eternal = true},

    },
	rules = {
		custom = {
			{id = 'no_reward'},
			{id = 'no_extra_hand_money'},
			{id = 'no_interest'},
			{id = 'discard_cost', value = 1}
		},
		modifiers = {
                {id = 'dollars', value = 8}
		}
	},
	restrictions = {
            banned_cards = {
                {id = 'v_clearance_sale'},
                {id = 'v_liquidation'},
				{id = 'v_reroll_surplus'},
                {id = 'v_reroll_glut'},
				{id = 'v_paint_brush'},
                {id = 'v_palette'},
            },
			banned_tags = {
                {id = 'tag_economy'},
                {id = 'tag_skip'},
				{id = 'tag_investment'},
				{id = 'tag_coupon'},
            },
	},
	deck = {
            cards = {
				{s='D',r='K',e='m_stone',g='Red'},{s='C',r='K',e='m_stone',g='Red'},{s='H',r='K',e='m_stone',g='Red'},{s='S',r='K',e='m_stone',g='Red'},
				{s='D',r='2',e='m_stone',g='Blue'},{s='C',r='2',e='m_stone',g='Blue'},{s='H',r='2',e='m_stone',g='Blue'},{s='S',r='2',e='m_stone',g='Blue'},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',},{s='C',r='2',e='m_stone',},{s='H',r='2',e='m_stone',},{s='S',r='2',e='m_stone',},
				{s='D',r='2',e='m_stone',g='Gold'},{s='C',r='2',e='m_stone',g='Gold'},{s='H',r='2',e='m_stone',g='Gold'},{s='S',r='2',e='m_stone',g='Gold'},
				{s='D',r='2',e='m_stone',g='Purple'},{s='C',r='2',e='m_stone',g='Purple'},{s='H',r='2',e='m_stone',g='Purple'},{s='S',r='2',e='m_stone',g='Purple'},
			},
            type = 'Challenge Deck'
        },
}

SMODS.Rarity({key = "quantum", badge_colour=HEX("800080")})

-- stolen from https://github.com/TheOneGoofAli/TOGAPackBalatro/blob/879e2c6d1489a3882f1ecbafc025ffc6ca88ec6e/togastuff.lua#L875

function ReverseTable(t)
	local rt = {}
	for i = #t, 1, -1 do
		rt[#rt+1] = t[i]
	end
	rt[#rt+1] = t[1]
	return rt
end

Quantum.processCards = function(context, input)
local output = input or context.cardarea and context.cardarea.cards or nil
	if not output then
		if context.cardarea == G.play then output = context.full_hand
		elseif context.cardarea == G.hand then output = G.hand.cards
		elseif context.cardarea == 'unscored' then output = context.full_hand end
	end

	if not output then return end

	if (G.GAME.modifiers.rewind and G.GAME.modifiers.rewind ~= 0) then output = ReverseTable(output) end

	return output
end

Quantum.processArea = function(t)
	t = t or {}

	local output = t

	if (G.GAME.modifiers.rewind and G.GAME.modifiers.rewind ~= 0) then
		local table = {}
		for i = #t, 1, -1 do
			table[#table+1] = output[i]
		end
		table[#table+1] = output[1]
		output = table
	end

	if (G.GAME.modifiers.fastf and G.GAME.modifiers.fastf ~= 0) then
		local table = {}
		for i = 1, #t, 2 do
			table[#table+1] = output[i]
			table[#table+1] = output[i]
		end
		output = table
	end

	if G.GAME.modifiers.joker_pause then
		output = {}
	end

	if G.GAME.modifiers.mediaplayer then
		local actiontable = {}

		for i = 1, #t do
			actiontable[#actiontable+1] = output[i]
			actiontable[#actiontable+1] = output[i]
		end

		output = actiontable
	end

	print(G.GAME.modifiers.rewind)
		print(G.GAME.modifiers.joker_pause)
		print(G.GAME.modifiers.fastf)

	return output
end
--[[
SMODS.Sound({
	key = 'music_darkWorld',
	path = 'mus_darkworldBalala.ogg',
    pitch = 1,
    sync = false,
    select_music_track = function()
        return (G.GAME and G.GAME.n_darkworld) and 1e5 or false
    end,
})
]]

SMODS.Joker {
	key = 'rewind',
	config = {},
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue+1] = Quantum.DescriptionDummies["qdd_quantum_music_fusion"]
		return { vars = {} }
	end,
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'music',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 20,
    unlocked = true,
    discovered = true,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.rewind = (G.GAME.modifiers.rewind or 0 ) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.modifiers.rewind = (G.GAME.modifiers.rewind or 0 ) - 1
	end,
}

SMODS.Joker {
	key = 'pause',
	config = {},
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue+1] = Quantum.DescriptionDummies["qdd_quantum_music_fusion"]
		return { vars = {} }
	end,
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'music',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 1 },
	-- Cost of card in shop.
	cost = 20,
    unlocked = true,
    discovered = true,
	quantum_can_use = function(self, card)
        --print(G.STATE)
        return true --and (G.STATE == G.STATES.SHOP or G.STATE == 999)
    end,
    quantum_use = function(self, card)
	if (G.GAME.modifiers.joker_pause) then
		card.children.center:set_sprite_pos({x=0, y=1})
		G.GAME.modifiers.joker_pause = false
	else
		card.children.center:set_sprite_pos({x=1, y=0})
		G.GAME.modifiers.joker_pause = true
	end

	juice_card(card)

	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.modifiers.joker_pause = false
	end,
	calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and G.GAME.modifiers.joker_pause then
                return {
                    card = card,
                    x_mult = #G.jokers.cards,
                }
            end
	end,
	set_sprites = function(self, card, front)
		if (G.GAME.modifiers.joker_pause) then
			card.children.center:set_sprite_pos({x=1, y=0})
		end
	end
}

SMODS.Joker {
	key = 'fastf',
	config = {},
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue+1] = Quantum.DescriptionDummies["qdd_quantum_music_fusion"]
		return { vars = {} }
	end,
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'music',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 1 },
	-- Cost of card in shop.
	cost = 20,
    unlocked = true,
    discovered = true,
	add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.fastf = (G.GAME.modifiers.fastf or 0 ) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.modifiers.fastf = (G.GAME.modifiers.fastf or 0 ) - 1
	end,
}

SMODS.Joker {
	key = 'mediaplayer',
	config = {},
	rarity = "quantum_quantum",
	-- Which atlas key to pull from.
	atlas = 'placeholders',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 1 },
	-- Cost of card in shop.
	cost = 20,
    unlocked = true,
    discovered = true,
	add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.mediaplayer = true
    end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.modifiers.mediaplayer = false
	end,
	calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
                return {
                    card = card,
                    x_mult = 1 + (#G.jokers.cards * 0.4),
                }
            end
	end,
}

SMODS.Joker {
	key = 'rolling_rock',
	config = {extra = {start_chips = to_big(50), chips = to_big(50), increase = 1.25, value_changed = false}},
	rarity = 3,
	atlas = 'placeholders',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 1 },
	unlocked = true,
    discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = {card.ability.extra.start_chips, card.ability.extra.increase, card.ability.extra.chips} }
    end,
	calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
			local scored_chips = card.ability.extra.chips
			card.ability.extra.chips = card.ability.extra.chips ^ card.ability.extra.increase
			card.ability.extra.value_changed = true
			return {
                    card = card,
                    chips = scored_chips
                }
		end

		if context.after and card.ability.extra.value_changed then
			card.ability.extra.value_changed = false
		G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
					func = function()
						card_eval_status_text(card, "jokers", nil, nil, nil, {
							message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
							colour = G.C.CHIPS,
						})
						return true
					end,
				}))
		end

		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint_card
			and not context.retrigger_joker
		then
		card.ability.extra.chips = card.ability.extra.start_chips
		return {
				message = localize('k_reset'),
				colour = G.C.FILTER,
			}
		end
	end
}
assert(SMODS.load_file("src/timerJoker.lua"))()
