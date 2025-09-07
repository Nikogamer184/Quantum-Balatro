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
        dictionary={
            b_qfuse = "FUSE",
            k_quantum_quantum = "Quantum",
        },
        labels={
            k_quantum_quantum = "Quantum",
        }
    }
}
