SMODS.Atlas({
	key = "quantum_timer",
	path = "timer_font.png",
	px = 30,
	py = 40,
})

SMODS.Sound({
        key = "timerTick",
        path = "warTimer.ogg",
    })

SMODS.Sound({
        key = "timerGain",
        path = "warTimerUp.ogg",
    })

SMODS.Joker {
	key = 'warTimer',
    name = "Quantum War Timer",
	config = {x_mult = 5, extra = {delta = 0.0, timeGain = 0, timerTens = 9, timerOnes = 9}},
	loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.x_mult} }
    end,
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'placeholders',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 0 },
	-- Cost of card in shop.
	cost = 20,
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	update = function(self, card, dt)
	card.ability.extra.delta = card.ability.extra.delta + dt
	if (card.ability.extra.timeGain ~= 0) then
	if  card.ability.extra.delta > 0.05 then
	card.ability.extra.timerOnes = card.ability.extra.timerOnes + 1
	card.ability.extra.delta = 0.0
	card.ability.extra.timeGain = card.ability.extra.timeGain - 1
	end
	elseif (card.ability.extra.delta > 5) then
		if (card.ability.extra.timerTens == 0 and card.ability.extra.timerOnes == 0) then
			if(G.GAME.modifiers.quantum_war) then
				if (card.ability.extra.delta > 10) then
				card.ability.extra.delta = -2147483647
				G.STATE = G.STATES.GAME_OVER
				G:save_settings()
                G.FILE_HANDLER.force = true
                G.STATE_COMPLETE = false
                end
			else
			card:start_dissolve()
			end
		else
        card.ability.extra.timerOnes = card.ability.extra.timerOnes - 1
        card.ability.extra.delta = 0.0
        play_sound('quantum_timerTick', 1, 0.5)
		end
    end
    if (card.ability.extra.timerOnes < 0) then
		card.ability.extra.timerOnes = 9
		card.ability.extra.timerTens = card.ability.extra.timerTens - 1
	elseif card.ability.extra.timerOnes > 9 then
		if card.ability.extra.timerTens == 9 then
			card.ability.extra.timerOnes = 9
		else
		card.ability.extra.timerOnes = 0
		card.ability.extra.timerTens = card.ability.extra.timerTens + 1
	end
	end
    end,
	calculate = function(self,card,context)
	if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint_card
			and not context.retrigger_joker
		then
		if (G.GAME.modifiers.quantum_war) then
			card.ability.extra.timeGain = 18
		else
			card.ability.extra.timeGain = 20
		end
		play_sound('quantum_timerGain', 1, 0.5)
		end
	end
}

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
	if _center and _center.name == "Quantum War Timer" then
		self.children.wtimer_spr1 = Sprite(
			self.T.x + self.T.w * 0.2,
			self.T.y + self.T.h * 0.2,
			self.T.w * 0.3,
			self.T.h * 0.3,
			G.ASSET_ATLAS["quantum_timer"],
			{ x = 0, y = 0 }
		)
	SMODS.draw_ignore_keys.wtimer_spr1 = true
		self.children.wtimer_spr1.states.hover.can = false
		self.children.wtimer_spr1.states.click.can = false

		self.children.wtimer_spr2 = Sprite(
			self.T.x + self.T.w * 0.5,
			self.T.y + self.T.h * 0.2,
			self.T.w * 0.3,
			self.T.h * 0.3,
			G.ASSET_ATLAS["quantum_timer"],
			{ x = 0, y = 0 }
		)
		self.children.wtimer_spr2.states.hover.can = false
		self.children.wtimer_spr2.states.click.can = false
		SMODS.draw_ignore_keys.wtimer_spr2 = true
	end
end

SMODS.DrawStep({
	key = "wtimer_spr2",
	order = 59,
	func = function(self)
		if self.ability.name == "Quantum War Timer" and (self.config.center.discovered or self.bypass_discovery_center) then
	self.children.wtimer_spr1:set_sprite_pos({x=0, y= self.ability.extra.timerTens})
	self.children.wtimer_spr2:set_sprite_pos({x=0, y= self.ability.extra.timerOnes})
			self.children.wtimer_spr2:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				0,
				0,
				1,
				0.5
			)

			self.children.wtimer_spr2.role.draw_major = self

			self.children.wtimer_spr1.role.draw_major = self
			self.children.wtimer_spr1:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				0,
				0,
				0.1,
				0.5
			)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.Challenge{
    loc_txt = "WAR",
    key = 'WAR',
	rules = {
		custom = {
			{id = 'quantum_war'},
		}
	},
    jokers = {
		{id = 'j_quantum_warTimer', eternal = true, pinned=true},
    },
	consumeables = {
		{id ='c_death'}
	}
}

SMODS.Sound({
	key = 'music_WAR',
	path = 'mu_war.ogg',
    pitch = 1,
    sync = false,
    select_music_track = function()
        return (G.GAME and G.GAME.modifiers.quantum_war)
    end,
})
