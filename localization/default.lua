return {
    descriptions = {
        Joker = {
            -- this should be the full key of your object, including any prefixes
            j_quantum_rewind = {
                name = 'Rewind',
                text = {
                    'Jokers trigger in {C:attention}reverse order{}',
                    'and loop {C:attention}once{}'
                }
            },
            j_quantum_fastf = {
                name = 'Fast Forward',
                text = {
                    'Only {C:attention}every other{} joker',
                    'triggers, but they trigger {C:attention}twice{}'
                }
            },
            j_quantum_pause = {
                name = 'Pause',
                text = {
                    '{C:red}Use{} to {C:attention}toggle{} effect:',
                    'Jokers {C:attention}no longer{} trigger',
                    "and cards give {X:mult,C:white}X1{} mult",
                    "per {C:attention}Joker{}"
                }
            },
            j_quantum_mediaplayer = {
                name = 'Media Player',
                text = {
                    'Jokers trigger {C:attention}twice{}',
                    'and loop {C:attention}once{}',
                    "Cards give {X:mult,C:white}X0.4{} mult",
                    "per {C:attention}Joker{}"
                }
            },
            j_quantum_rolling_rock = {
                name = 'Rolling Rock',
                text = {
                    '{C:attention}Stone Cards{} give {C:chips}#1#{} extra chips',
                    'Increases by {X:attention,C:white}^#2#{} per',
                    "{C:attention}Stone Card{} scored",
                    "{C:attention}Resets{} at {C:attention}end{} of {C:attention}Blind{}",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
                }
            },
            j_quantum_warTimer = {
                name = 'WAR Timer',
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    '{C:attention}Destroyed{} when time runs out',
                }
            }
        },
        Stake = {
			stake_quantum_nightmare = {
				name = "Nightmare Stake",
				text = {
					"{C:red}Good Luck{}"
				},
			}
        },
        QuantumDescriptionDummy={
            qdd_quantum_music_fusion={
                name="Fusion",
                text={
                },
            }
        }
    },
    misc={
        v_dictionary={
            quantum_fusion_count = "#1#/#2#"
        },
        v_text={
            ch_c_quantum_war={
                "WAR Timer {C:red}kills{} you when time runs out",
            },
        },
        dictionary={
            b_qfuse = "FUSE",
            k_quantum_quantum = "Quantum",
        },
        labels={
            k_quantum_quantum = "Quantum",
        }
    }
}
