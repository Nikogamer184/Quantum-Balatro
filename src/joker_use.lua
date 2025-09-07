local fuse_jokers = {j_quantum_rewind = true, j_quantum_pause = true, j_quantum_fastf = true}

local alias__G_UIDEF_use_and_sell_buttons = G.UIDEF.use_and_sell_buttons;
function G.UIDEF.use_and_sell_buttons(card)
	local ret = alias__G_UIDEF_use_and_sell_buttons(card)
	
	if card.config.center.key and card.area and card.area.config.type == 'joker' then
		if G.jokers and fuse_jokers[card.config.center.key] and can_fuse_joker(card)[1] then
			local nodes_todo = {n=G.UIT.R, config={align = 'cl'}, nodes={
				{n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.DARK_EDITION, one_press = false, button = 'quantum_fuse_joker', func = 'quantum_can_fuse_joker'}, nodes={
					{n=G.UIT.B, config = {w=0.1,h=0.6}},
					{n=G.UIT.T, config={text = localize('b_qfuse'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
				}}
			}}
			table.insert(ret.nodes[1].nodes, 1, nodes_todo)
		end
	end

	if G.jokers and card.config.center.quantum_can_use and card.config.center.quantum_use and type(card.config.center.quantum_can_use) == 'function' and type(card.config.center.quantum_use) == 'function' then
			local nodes_todo = {n=G.UIT.R, config={align = 'cl'}, nodes={
				{n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = false, button = 'quantum_use_joker', func = 'quantum_can_use_joker'}, nodes={
					{n=G.UIT.B, config = {w=0.1,h=0.6}},
					{n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
				}}
			}}
			table.insert(ret.nodes[1].nodes, nodes_todo)
		end
	
	return ret
end

G.FUNCS.quantum_can_use_joker = function(e)
    local joker =  e.config.ref_table
	if joker.config.center.quantum_can_use and joker:can_sell_card() and joker.config.center:quantum_can_use(joker) then
		e.config.colour = G.C.RED
		e.config.button = 'quantum_use_joker'
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.quantum_use_joker = function(e)
    local joker =  e.config.ref_table
    if joker and joker.config.center.quantum_use and joker.config.center:quantum_can_use(joker) then
        joker.config.center:quantum_use(joker)
    end
end

function can_fuse_joker(card)
local key = card.config.center.key
if key == "j_quantum_rewind" or key == "j_quantum_pause" or key == "j_quantum_fastf" then
	local jokers = {{false, false, false}, {nil, nil, nil}}
	if (G.jokers and G.jokers.cards) then
            for i = 1, #G.jokers.cards do
                if (G.jokers.cards[i].config.center.key == "j_quantum_rewind" and not jokers[1][1] ) then
					jokers[1][1] = true
					jokers[2][1] = G.jokers.cards[i]
				end
                if (G.jokers.cards[i].config.center.key == "j_quantum_pause" and not jokers[1][2]) then
					jokers[1][2] = true
					jokers[2][2] = G.jokers.cards[i]
				end
                if (G.jokers.cards[i].config.center.key == "j_quantum_fastf" and not jokers[1][3]) then
					jokers[1][3] = true
					jokers[2][3] = G.jokers.cards[i]
				end
            end
        end
	if (jokers[1][1] and jokers[1][2] and jokers[1][3]) then
		return {true, jokers[2]}
	else
		return {false, nil}
	end
end
end

G.FUNCS.quantum_can_fuse_joker = function(e)
    local joker =  e.config.ref_table
	if can_fuse_joker(joker)[1] and joker:can_sell_card() then
		e.config.colour = G.C.DARK_EDITION
		e.config.button = 'quantum_fuse_joker'
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.quantum_fuse_joker = function(e)
    local joker =  e.config.ref_table
    local can_fuse_result = can_fuse_joker(joker)
    if joker and can_fuse_result[1] then

		for i=1, #can_fuse_result[2] do
			can_fuse_result[2][i]:start_dissolve()
		end

		local key = joker.config.center.key

		if key == "j_quantum_rewind" or key == "j_quantum_pause" or key == "j_quantum_fastf" then
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_quantum_mediaplayer")
            card:add_to_deck()
            G.jokers:emplace(card)
		end
	end
end
