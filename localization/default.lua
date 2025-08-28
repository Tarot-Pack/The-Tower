return {
    descriptions = {
        Back={
            b_tower_shimmered={
                name="Shimmered Deck",
                text={
                    "Start run with an {C:attention}#1#{}",
					"{C:tower_transmuted}Bottomless Shimmer Bucket{}",
					"and a fully {C:tower_transmuted}Shimmered{} deck,",
					"cards are randomly {C:tower_transmuted}Shimmered"
                },
            },
            b_tower_curated={
                name="Curated Deck",
                text={
                    "Start run with an {C:attention}#1#{}",
					"{C:dark_edition}negative{} {C:attention}#2#{}",
					"Only {C:attention}10{} random jokers {C:inactive}(or less){} of",
					"each rarity are allowed to spawn"
                },
            },
		},
        Sleeve={
            sleeve_tower_shimmered={
                name="Shimmered Sleeve",
                text={
                    "Start run with an {C:attention}#1#{}",
					"{C:tower_transmuted}Bottomless Shimmer Bucket{}",
					"and a fully {C:tower_transmuted}Shimmered{} deck,",
					"cards are randomly {C:tower_transmuted}Shimmered"
                },
            },
		},
		Fortune = {
			fortune_tower_jack_secondary = {
				name = "The Jack's Fortune",
				text =  {
					"All {C:attention}print{} jokers retrigger any",
					"joker they target #1# more time"
				}
			},
			fortune_tower_jack = {
				name = "The Jack",
				text = {
					{
						"All {C:attention}print{} jokers retrigger any",
						"joker they target #1# more time"
					},
					{
						"All {C:attention}print{} jokers have",
						"a {C:green}#2# in #3#{} chance to appear in each shop slot"
					}
				}
			},
			fortune_tower_egg_secondary = {
				name = "The Eggs's Fortune",
				text = {
					"All {C:attention}Egg{} jokers double scaling when scaled",
					"{C:inactive}(ex: +3, +6, +12, +24)"
				}
			},
			fortune_tower_egg = {
				name = "The Egg",
				text = {
					{
						"All {C:attention}Egg{} jokers double scaling when scaled",
						"{C:inactive}(ex: +3, +6, +12, +24)"
					},
					{
						"All {C:attention}Egg{} jokers have",
						"a {C:green}#1# in #2#{} chance to appear in each shop slot"
					}
				}
			},
			fortune_tower_lucky_secondary = {
				name = "The Lucky's Fortune",
				text = {
					"{X:green,C:white} X#1# {} Numerator, increase by {C:green}#2#{} for",
					"every {C:green}succeeded{} probability roll" -- X1, increase by 0.1
				}
			},
			fortune_tower_lucky = {
				name = "The Lucky",
				text = {
					{
						"{X:green,C:white} X#1# {} Numerator, increase by {C:green}#2#{} for",
						"every {C:green}succeeded{} probability roll" -- X1, increase by 0.1
					},
					{
						"All {C:attention}chance{} jokers have",
						"a {C:green}#3# in #4#{} chance to appear in each shop slot"
					}
				}
			},
			fortune_tower_holy_secondary = {
				name = "The Holy's Fortune",
				text = {
					"All {C:attention}Ascended Consumables{} give {C:attention}double{} the effect"
				}
			},
			fortune_tower_holy = {
				name = "The Holy",
				text = {
					{
						"All {C:attention}Ascended Consumables{} give {C:attention}double{} the effect"
					},
					{
						"All {C:attention}Ascended Consumables{} have",
						"a {C:green}#3# in #4#{} chance to appear in each shop slot"
					}
				}
			},
		},
		["Description Cards"] = {
			desc_tower_unbounded_pointer = {
				name = "Unbounded Pointer",
				text = {
					"Create a card",
					"of {C:cry_code}your choice",
					"{C:tower_apollyon,E:1}No restrictions apply{}",
					"{C:inactive}Multiuse: ({C:cry_code}1e300{C:inactive} remaining)"
				},
			},
			desc_tower_empowered = {
				name = "Empower",
				text = {
					"Increase gameset by 1 and",
					"boost values by {X:dark_edition,C:white,E:1} ^2"
				}
			},
			desc_tower_banned_card = {
				name = "Banned",
				text = {
					"This card is {C:red}Banned{} and",
					"cannot appear normally"
				}
			}
		},
		["Content Set"] = {
			set_tower_misc = {
				name = "Misc. Items",
				text = {
					"Items that belong in no other catagory",
				},
			},
			set_tower_blinds = {
				name = "Blinds",
				text = {
					"{C:attention}Boss Blinds{} added",
					"by The Tower",
				},
			},
			set_tower_slime = {
				name = "Slime Jokers",
				text = {
					"{C:attention}Jokers{} referencing {C:attention}Terraria Slimes{}",
				},
			},
			set_tower_terraria = {
				name = "Terraria Jokers",
				text = {
					"{C:attention}Jokers{} referencing {C:attention}Terraria{}",
				},
			},
			set_tower_apollyon = {
				name = "Apollyon Jokers",
				text = {
					"Powerful Jokers with",
					"{C:tower_apollyon,E:1}Apollyon{} rarity"
				},
			},
			set_tower_transmuted = {
				name = "Transmuted Cards",
				text = {
					"Cards related to/created through",
					"the {C:tower_transmuted}Shimmer{}"
				},
			},
		},
		Other = {
            tower_mult_rank={
                text={
                    " {V:1}#1#{C:light_black} of #2# ",
                },
            },
			p_tower_slime_1 = {
				name = "Slime Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Slime Joker#<s>2#{}",
				},
			},
			p_tower_slime_2 = {
				name = "Slime Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Slime Joker#<s>2#{}",
				},
			},
			p_tower_slime_3 = {
				name = "Slime Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Slime Joker#<s>2#{}",
				},
			},

			p_tower_pikaboy10_1 = {
				name = "Pikaboy Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Object#<s>2# by Pikaboy{}",
				},
			},			
			p_tower_pikaboy10_2 = {
				name = "Pikaboy Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Object#<s>2# by Pikaboy{}",
				},
			},
			p_tower_pikaboy10_3 = {
				name = "Pikaboy Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Object#<s>2# by Pikaboy{}",
				},
			},

			p_tower_terra_1 = {
				name = "Terra Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Terraria Joker#<s>2#{}",
				},
			},			
			p_tower_terra_2 = {
				name = "Terra Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Terraria Joker#<s>2#{}",
				},
			},
			p_tower_terra_3 = {
				name = "Terra Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Terraria Joker#<s>2#{}",
				},
			},

			tower_card_mult={
                text={
                    "{C:mult}+#1#{} mult",
                },
            },

			tower_sleeping_blessing = {
				name = "Sleeping Blessing",
				text = {
					"When you reach 0 hands, you gain two hands", -- dont variable this bc passing ability with variable is annoying
					"and pass this ability to the joker to the right",
					"{C:inactive}(If there is no joker to the right, the ability will be lost)",
					"{S:1.1,C:red,E:2}self destructs{}"
				}
			},
			tower_empowered = {
				name = "Empowered",
				text = {					
					"Empowered by #1# level#<s>1#"
				}
			},
			tower_bound = { 
				name = "Bound",
				text = {
					"Hand {C:attention}cannot play{} when it contains this card"
				},
			},
			tower_fuckyou = { 
				name = "Fuck You",
				text = {
					"Fuck You"
				},
			},
			tower_virus = { 
				name = "Infected",
				text = {
					"{C:cry_code}Delete this.{}"
				},
			},
			tower_notrigger = { 
				name = "Dud",
				text = {
					"Card cannot trigger"
				},
			},
			tower_food = { 
				name = "Edible",
				text = {
					"All values decrease",
					"by 25% on round end"
				},
			},
		},
		Book = {
			book_tower_no_book = {
				name = "No Book",
				text = {
					"Does not apply {C:attention}Book{} effects",
				},
			},
			book_tower_base = {
				name = "The Hero and the Tower",
				text = {
					"Adds {C:attention}Spectral Blinds{} and {C:attention}Code Blinds{} and makes",
					"{C:attention}Spectral Blinds{} happen every {C:attention}16 Antes{}",
					"The final blinds happen {C:attention}every Ante{}",
					"The {C:attention}Winning Ante{} is {C:attention}32{}",
				},
			},
			book_tower_planet = {
				name = "The Galatic War",
				text = {
					"Adds {C:attention}Planet Blinds{} to",
					"the third blind pool",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_tarot = {
				name = "The Call of the Depths",
				text = {
					"Adds {C:attention}Tarot Blinds{}",
					"every {C:attention}8 Antes{}",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_sixtyfour = {
				name = "The Million Steps",
				text = {
					"{C:attention}Winning Ante{} is {C:attention}64{}",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_immortal = {
				name = "The Needle and the Egg",
				text = {
					"{C:attention}Blinds{} cannot be {C:attention}disabled{} or {C:attention}skipped{}",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_alltarot = {
				name = "The Rotten of the Depths",
				text = {
					"{C:attention}Tarot and Spectral Blinds{} happen",
					"{C:attention}every Ante{}",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_scaling = {
				name = "The Soul-Bound Hero",
				text = {
					"{C:attention}Ante Scaling{} scales with",
					"{C:attention}best score{} this run",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_famine = {
				name = "Fate's Harsh Grasp",
				text = {
					"{C:attention}Consumables{} no longer exist",
					'{s:0.8}Applies all previous Books'
				},
			},
			book_tower_nojokers = {
				name = "The Roaring",
				text = {
					"{C:attention}Jokers{} no longer exist",
					'{s:0.8}Applies all previous Books'
				},
			},
		},
		Edition = {
			e_tower_truenegative = {
				name = "True Negative",
				text = {
					"Inverts all values",
					"on this card"
				},
			},
		},
		Enhanced = {
            m_tower_crystal={
                name="Crystal Card",
                text={
                    "{C:chips}+#1#{} Chips",
                    "no rank or suit",
                    "{C:green}#2# in #3#{} chance to",
                    "uncrystalize card",
                },
            },
            m_tower_blank ={
                name="Blank Card",
                text={
                    "This card cannot effect scoring"
                },
            },
		},
		Blind = {
			bl_tower_blank = {
				name = "The Blank",
				text = {
					"{C:inactive}Does nothing?",
				},
			},

            bl_tower_pluto = {
				name = "Perisanne Pluto",
				text = {
					"Hand type may only be",
                    "High Card"
				},
			},
            bl_tower_mercury = {
				name = "Murdery Mercury",
				text = {
					"Hand type may only be",
                    "Pair"
				},
			},
            bl_tower_uranus = {
				name = "Urine Uranus",
				text = {
					"Hand type may only be",
                    "Two Pair"
				},
			},
            bl_tower_venus = {
				name = "Veiny Venus",
				text = {
					"Hand type may only be",
                    "Three of a Kind"
				},
			},
            bl_tower_saturn = {
				name = "Silver Saturn",
				text = {
					"Hand type may only be",
                    "Straight"
				},
			},
            bl_tower_jupiter = {
				name = "Jade Jupiter",
				text = {
					"Hand type may only be",
                    "Flush"
				},
			},
            bl_tower_earth = {
				name = "Elderberry Earth",
				text = {
					"Hand type may only be",
                    "Full House"
				},
			},
            bl_tower_mars = {
				name = "Marigold Mars",
				text = {
					"Hand type may only be",
                    "Four of a Kind"
				},
			},
            bl_tower_neptune = {
				name = "Nikau Neptune",
				text = {
					"Hand type may only be",
                    "Straight Flush"
				},
			},
            bl_tower_planet_x = {
				name = "Planet X",
				text = {
					"Hand type may only be",
                    "Five of a Kind"
				},
			},
            bl_tower_asteroid_belt = {
				name = "Asteroid Belt",
				text = {
					"Hand type may only be",
                    "Bulwark"
				},
			},
            bl_tower_void = {
				name = "Void",
				text = {
					"Hand type may only be",
                    Cryptid_config.family_mode and "Cluster" or "Clusterfuck",
				},
			},
            bl_tower_phobos_diemos = {
				name = "Phobos & Diemos",
				text = {
					"Hand type may only be",
                    "Ultimate Pair"
				},
			},
            bl_tower_universe = {
				name = Cryptid_config.family_mode and "Universe" or "The Universe In Its Fucking Entirety",
				text = {
					"Hand type may only be",
                    Cryptid_config.family_mode and "The Entire Deck" or "The Entire Fucking Deck"
				},
			},
            bl_tower_nibiru = {
				name = "Nibiru",
				text = {
					"Hand type may only be",
                    "None"
				},
			},
            bl_tower_neutronstar = {
				name = "Neutron Star",
				text = {
					"Base mult is a",
					"random hands level"
				},
			},
            bl_tower_planetlua = {
				name = "Planet.lua",
				text = {
					"Levels all hands",
					"down before hand played"
				},
			},
            bl_tower_sol = {
				name = "Sol",
				text = {
					"Played hand must be",
					"Ascended"
				},
			},
            bl_tower_ruutu = {
				name = "Ruutu",
				text = {
					"Must meet the required score and play",
					"High Card, Pair and Two Pair"
				},
			},
            bl_tower_risti = {
				name = "Risti",
				text = {
					"Must meet the required score and play",
					"Three of a Kind, Straight and Flush"
				},
			},
            bl_tower_hertta = {
				name = "Hertta",
				text = {
					"Must meet the required score and play",
					"Full House, Four of a Kind and Straight Flush"
				},
			},
            bl_tower_pata = {
				name = "Pata",
				text = {
					"Must meet the required score and play",
					"Five of a Kind, Flush House and Flush Five"
				},
			},
            bl_tower_kaikki = {
				name = "Kaikki",
				text = {
					"Must meet the required score and play",
					Cryptid_config.family_mode and "Bulwark, Cluster and The Entire Deck"
						or "Bulwark, Clusterfuck and The Entire Fucking Deck",
				},
			},
            bl_tower_voxel = {
				name = "Voxel",
				text = {
					"Must meet the required score and play",
					"#1#, #2#, and #3#"
				},
			},
            bl_tower_ceres = {
				name = "Capri Ceres",
				text = {
					"Hand type may only be",
                    "Flush House"
				},
			},
            bl_tower_eris = {
				name = "Electric Eris",
				text = {
					"Hand type may only be",
                    "Flush Five"
				},
			},

			bl_tower_fool = {
				name = "The Fool",
				text = {
					"Round ends when all hands are used",
					"Must score at least 80%",
					"Instant loss if",
					"100% has been scored"
				},
			},
			bl_tower_tower = {
				name = "The Tower",
				text = {
					"Played cards are {C:attention}Crystalized{} and",
					"discarded cards are turned to {C:attention}Stone{}"
				},
			},
			bl_tower_wheel = {
				name = "Wheel of Fortune",
				text = {
					"#1# in #2# chance for played hand to score"
				},
			},
			bl_tower_lovers = {
				name = "The Lovers",
				text = {
					"Played hands must contain",
					"every suit"
				},
			},
			bl_tower_sun = {
				name = "The Sun",
				text = {
					"Played hand must",
					"contain only Hearts"
				},
			},
			bl_tower_world = {
				name = "The World",
				text = {
					"Played hand must",
					"contain only Spades"
				},
			},
			bl_tower_moon = {
				name = "The Moon",
				text = {
					"Played hand must",
					"contain only Clubs"
				},
			},
			bl_tower_star = {
				name = "The Star",
				text = {
					"Played hand must",
					"contain only Diamonds"
				},
			},
			bl_tower_hermit = {
				name = "The Hermit",
				text = {
					"Divide chips by 2 for",
					"each remaining hand",
					"and divide mult by 2 for",
					"each remaining discard"
				},
			},
			bl_tower_temperance = {
				name = "The Temperance",
				text = {
					"Mult and chips are divided",
					"by total joker sell value"
				},
			},
			bl_tower_emperor = {
				name = "The Emperor",
				text = {
					"This blind copies the effects of",
					"Two random Tarot blinds"
				},
			},
			bl_tower_high_priestess = {
				name = "The High Priestess",
				text = {
					"Can only play two random",
					"hand types"
				},
			},
			bl_tower_magician = {
				name = "Magician",
				text = {
					"#1# in #2# chance to set money to 0", -- 1 in 15
					"#3# in #4# chance to set mult to 0" -- 1 in 5
				},
			},
			bl_tower_hierophant = {
				name = "Hierophant",
				text = {
					"Mult is stuck at 1"
				},
			},
			bl_tower_empress = {
				name = "Empress",
				text = {
					"Chips is stuck at 1"
				},
			},
			bl_tower_justice = {
				name = "Justice",
				text = {
					"All cards break after hand played"
				},
			},
			bl_tower_chariot = {
				name = "The Chariot",
				text = {
					"All played cards are debuffed"
				},
			},
			bl_tower_devil = {
				name = "The Devil",
				text = {
					"Chips is capped at money"
				},
			},
			bl_tower_strength = {
				name = "Strength",
				text = {
					"All played and held cards decrease in rank",
					"one to three times before hand played"
				},
			},
			bl_tower_hangedman = {
				name = "Hanged Man",
				text = {
					"All discarded cards are destroyed"
				},
			},
			bl_tower_judgement = { -- tbi
				name = "Judgement",
				text = {
					"Chooses one joker and all",
					"other jokers are debuffed"
				},
			},
			bl_tower_death = {
				name = "Death",
				text = {
					"Turns all other cards in played hand",
					"into the negated version of the right-most card"
				},
			},
			bl_tower_eclipse = {
				name = "The Eclipse",
				text = {
					"Playing cards cannot be triggered"
				},
			},
			bl_tower_seraph = {
				name = "The Seraph",
				text = {
					"Play #1# cards, increase by 1 each hand",
					"and chips are capped at #2#"
				},
			},
			bl_tower_instability = {
				name = "The Instability",
				text = {
					"Played hand must",
					"contain only Abstract"
				},
			},
			bl_tower_blessing = {
				name = "The Blessing",
				text = {
					"Becomes a random Tarot or Spectral"
				},
			},
			bl_tower_automaton = {
				name = "The Automaton",
				text = {
					"Applies the effects of three",
					"different Code blinds"
				},
			},

			bl_tower_crash = {
				name = "Crash",
				text = {
					"Don't."
				},
			},
			bl_tower_keygen = {
				name = "Keygen",
				text = {
					"Adds Perishable and Banana",
					"stickers to one joker"
				},
			},
			bl_tower_payload = {
				name = "Payload",
				text = {
					"Halves money",
					"every hand"
				},
			},
			bl_tower_exploit = {
				name = "Exploit",
				text = {
					"All hands count as your worst hand type"
				},
			},
			bl_tower_malware = {
				name = "Malware",
				text = {
					""
				},
			},
			bl_tower_nperror = {
				name = "NPE-Error",
				text = {
					"Must play the same",
					"Ranks and Suits each hand"
				},
			},
			bl_tower_rework = {
				name = "Rework",
				text = {
					"Downgrade all editions",
					"in played hand"
				},
			},
			bl_tower_merge = {
				name = "Merge",
				text = {
					"Has the effect of the",
					"next two blinds"
				},
			},
			bl_tower_commit = {
				name = "Commit",
				text = {
					"Replace one joker with one",
					"of the same rarity before",
					"each hand played"
				},
			},
			bl_tower_machinecode = {
				name = "Machine Code",
				text = {
					""
				},
			},
			bl_tower_spaghetti = {
				name = "Spaghetti",
				text = {
					"Applies a Edible sticker",
					"to one joker"
				},
			},
			bl_tower_seed = {
				name = "Seed",
				text = {
					"All probabilities are",
					"set to zero",
				},
			},
			bl_tower_patch = {
				name = "Patch",
				text = {
					"All jokers, playing cards, and",
					"consumables are either flipped or debuffed",
				},
			},
			bl_tower_hook = {
				name = "Hook",
				text = {
					"Only one card in",
					"played hand can trigger",
				},
			},
			bl_tower_oboe = {
				name = "Off by one",
				text = {
					"All card ranks change by",
					"plus or minus before hand play",
				},
			},
			bl_tower_assemble = {
				name = "Assemble",
				text = {
					"Subtract base Mult from the",
					"played hand equal to how",
					"many Jokers are owned",
				},
			},
			bl_tower_inst = {
				name = "Instantiate",
				text = {
					"All cards drawn after",
					"first draw are debuffed",
				},
			},
			bl_tower_revert = {
				name = "Revert",
				text = {
					"#1# in #2# chance to set game",
					"state to start of this Ante",
				},
			},
			bl_tower_crfunction = {
				name = "Function",
				text = {
					"Copies the effects of the last",
					"three consumable blinds played",
				},
			},
			bl_tower_run = {
				name = "Run",
				text = {
					"Sends you to shop and allows",
					"you to go into debt one time",
					"Must spend all money"
				},
			},
			bl_tower_class = {
				name = "Class",
				text = {
					"Remove enhancements from all",
					"played cards"
				},
			},
			bl_tower_global = {
				name = "Global",
				text = {
					"Creates Global Blanks",
					"that fill your hand",
				},
			},
			bl_tower_variable = {
				name = "Variable",
				text = {
					"All played cards turn into a",
					"random rank before hand played",
				},
			},
			bl_tower_divide = {
				name = "Divide",
				text = {
					"Halve all joker values",
				},
			},
			bl_tower_multiply = {
				name = "Multiply",
				text = {
					"Double required score after",
					"every hand played",
				},
			},
			bl_tower_delete = {
				name = "Delete",
				text = {
					"Banish and Destroy one random joker",
					"it will no longer appear normally this run",
				},
			},
			bl_tower_alttab = {
				name = "Alt+Tab",
				text = {
					"#1# in #2# chance to create 1e10",
					"copies of missed skip tag",
				},
			},
			bl_tower_ctrl_v = {
				name = "Control+V",
				text = {
					"Copies the last played blind",
				},
			},
			bl_tower_reboot = {
				name = "Reboot",
				text = {
					"#1# in #2# chance to",
					"restart Blind every hand",
				},
			},
			bl_tower_semicolon = {
				name = "Semicolon",
				text = {
					"Ends blind"
				},
			},
			bl_tower_declare = {
				name = "Declare",
				text = {
					"All ranks in played hand are #1#"
				},
			},
			bl_tower_log = {
				name = "Log",
				text = {
					"First 10 cards drawn are",
					"the only cards that can be drawn"
				},
			},
			bl_tower_quantify = {
				name = "Quantify",
				text = {
					"All of your jokers are sent",
					"to your deck"
				},
			},

			bl_tower_soul = {
				name = "The Soul",
				text = {
					"All cards are debuffed",
					"if they aren't legendary"
				},
			},
			bl_tower_wraith = {
				name = "The Wraith",
				text = {
					"Chips cannot exceed the",
					"current money and money",
					"is set to zero when a rare",
					"joker is triggered"
				},
			},
			bl_tower_blueprint = {
				name = "The Blindprint",
				text = {
					"Copies the blind in this",
					"slot from the next ante",
					"including required score"
				},
			},
			bl_tower_incantation = {
				name = "The Incantation",
				text = {
					"Before playing hand, destroys",
					"all other cards in deck",
				},
			},
			bl_tower_ankh = {
				name = "The Ankh",
				text = {
					"Selects a random joker and",
					"transforms all others into",
					"specific jokers"
				},
			},
			bl_tower_blackhole = {
				name = "The Blackhole",
				text = {
					"Hands are set to amount",
					"of hand types,",
					"You cannot repeat hands,",
					"and all hands are worth one point"
				},
			},
			bl_tower_ectoplasm = {
				name = "The Ectoplasm",
				text = {
					"Permanently divide hand size by 2",
					"for each non-negative joker",
					"Zero handsize loses"
				}
			},
			bl_tower_sigil = {
				name = "The Sigil",
				text = {
					"Played hand must contain a specific",
					"suit which changes every hand"
				}
			},
			bl_tower_familiar = {
				name = "The Familiar",
				text = {
					"Deck cannot contain any Face cards"
				}
			},
			bl_tower_grim = {
				name = "The Grim",
				text = {
					"You can only select Aces"
				}
			},
			bl_tower_talisman = {
				name = "The Talisman",
				text = {
					"Final score is capped at money"
				}
			},
			bl_tower_aura = {
				name = "The Aura",
				text = {
					"Played hand can only contain #1# cards"
				}
			},
			bl_tower_ouija = {
				name = "The Ouija",
				text = {
					"Played hand can only contain",
					"cards with the #1# rank"
				}
			},
			bl_tower_immolate = {
				name = "Immolate",
				text = {
					"Negates money when blind is entered",
					"and sells jokers until you have no",
					"debt or run out of jokers"
				}
			},
			bl_tower_dejavu = {
				name = "Deja Vu",
				text = {
					"Played hand can only",
					"contain cards with the #1#"
				}
			},
			bl_tower_hex = {
				name = "The Hex",
				text = {
					"Destroys all non-polychrome jokers"
				}
			},
			bl_tower_trance = {
				name = "The Trance",
				text = {
					"Final score is capped to one-fourth",
					"of blind size, only #1# is",
					"allowed to play"
				}
			},
			bl_tower_medium = {
				name = "The Medium",
				text = {
					"Give all but one card in deck",
					"the Bound sticker, hands cannot",
					"play with cards that have the Bound sticker"
				}
			},
			bl_tower_cryptid = {
				name = "The Cryptid",
				text = {
					"Blind base is high score this run"
				}
			},
			bl_tower_summoning = {
				name = "The Summoning",
				text = {
					"All jokers are replaced with",
					"1 round Perishable Canvas"
				}
			},
			bl_tower_typhoon = {
				name = "The Typhoon",
				text = {
					"Played poker hands base mult and base chips,",
					"are set to 0 and cap score at played poker",
					"hands old mult and chips",
				}
			},
			bl_tower_meld = {
				name = "The Meld",
				text = {
					"Fuse all un-fused jokers (if possible)",
					"and set all values of both sides of",
					"every joker to zero"
				}
			},
			bl_tower_gateway = {
				name = "The Gateway",
				text = {
					"Destroy all non-Exotic cards"
				}
			},
			bl_tower_lock = {
				name = "The Lock",
				text = {
					"Makes all jokers #1# and Edible"
				}
			},
			bl_tower_vacuum = {
				name = "The Vacuum",
				text = {
					"Destroy all played or held cards, jokers",
					"and consumables with a modification",
					"before hand played"
				}
			},
			bl_tower_hammerspace = {
				name = "The Hammerspace",
				text = {
					"Face random consumable blinds",
					"for #1# antes",
					"ante number cannot change"
				}
			},
			bl_tower_trade = {
				name = "The Trade",
				text = {
					"Unredeem and invert",
					"all owned vouchers"
				}
			},
			bl_tower_replica = {
				name = "The Replica",
				text = {
					"Turn all drawn cards into blanks"
				}
			},
			bl_tower_analog = {
				name = "The Analog",
				text = {
					"Selects one joker and every other",
					"joker is destroyed with two cursed",
					"jokers being made for each destroyed joker"
				}
			},
			bl_tower_ritual = {
				name = "The Ritual",
				text = {
					"All playing cards, jokers",
					"and consumables become true-negative"
				}
			},
			bl_tower_adversary = {
				name = "The Adversary",
				text = {
					"All jokers are negated and #1#",
					"All future jokers have a 50%",
					"chance of being true-negative"
				}
			},
			bl_tower_chambered = {
				name = "The Chambered",
				text = {
					"Blind has to be beaten 3 times"
				}
			},
			bl_tower_conduit = {
				name = "The Conduit",
				text = {
					"Chooses a random present edition in",
					"your jokers, including base and all",
					"current and future jokers of that edition",
					"become true-negative"
				}
			},
			bl_tower_source = {
				name = "The Source",
				text = {
					"Copies the effect of one Code",
					"blind for every card in your deck"
				}
			},
			bl_tower_pointer = {
				name = "The Pointer",
				text = {
					"Score requirement is set to 1 when",
					"#1#",
					"is triggered" -- blind requirement is initally infinity
				}
			},
			bl_tower_white_hole = {
				name = "White Hole",
				text = {
					"Blind base is the total of all of",
					"your hand mult times the total of",
					"all of your hand chips squared",
					"All of your hand mult and chips are set to 0"
				}
			},
        },
		Joker = {
			j_tower_blank = {
				name = "Blank",
				text = {
					"Does nothing?"
				}
			},
			j_tower_coinflip = {
				name = "Coinflip",
				text = {
					"After a {C:attention}Joker{} is triggered, there",
					"is a {C:green}#1# in #2#{} chance of swapping {C:chips}Chips{}",
					"and {C:mult}Mult{} scoring for that {C:attention}Joker{}"
				}
			},
			j_tower_ying_yang = {
				name = "Ying-Yang",
				text = {
					"After a {C:attention}Joker{} is triggered, the {C:chips}Chips{}",
					"and {C:mult}Mult{} scoring for that {C:attention}Joker{} is swapped"
				}
			},
			j_tower_catalytic_meltdown = {
				name = "Catalytic Meltdown",
				text = {
					"{C:attention}Use{} this on a {C:attention}Joker{} to swap its {C:chips}Chips{} and {C:mult}Mult{} scoring"
				}
			},
			j_tower_99_percent = {
				name = "99% OF GAMBLERS QUIT BEFORE THEY WIN!!!!!",
				text = {
					"{C:tower_apollyon,E:1}Instantly win all blinds{}",
					"{C:green}1 in 20{} chance to {C:cry_cursed,E:10}instantly lose{} instead",
					"{C:inactive}(This joker is immutable)", -- ruins the point
					"{C:cry_cursed,E:2}Your addiction is inescapeable." -- evil town evil town
				}
			},
			j_tower_die_of_fate = {
				name = "Die of Fate",
				text = {
					"{C:green}12010873 in 88888888{} chance to do nothing",
					"{C:green}17593235 in 88888888{} chance for {X:mult,C:white} X#1# {} Mult", -- 2
					"{C:green}17457012 in 88888888{} chance for {X:chips,C:white} X#2# {} Chips", -- 2
					"{C:green}17047819 in 88888888{} chance for {X:mult,C:white} X#3# {} Mult", -- 0.5
					"{C:green}16989919 in 88888888{} chance for {X:chips,C:white} X#4# {} Chips", -- 0.5
					"{C:green}3941256 in 88888888{} chance for {X:mult,C:white} X#5# {} Mult", -- 4
					"{C:green}3758989 in 88888888{} chance for {X:chips,C:white} X#6# {} Chips", -- 4
					"{C:green}88888 in 88888888{} chance for {X:dark_edition,C:white} ^#7# {} Chips and Mult", -- 4
					"{C:green}888 in 88888888{} chance for {X:dark_edition,C:white} ^^#8# {} Chips and Mult", -- 4
					"{C:green}8 in 88888888{} chance for {X:dark_edition,C:white} #9# {} Chips and Mult", -- {88888888}8
					"{C:green}1 in 88888888{} chance to create an {C:tower_apollyon,E:1}Unbounded pointer{}",
					"All probabilities are mutually exclusive and immutable."
				}
			},
			j_tower_die_of_fate_nocry = {
				name = "Die of Fate",
				text = {
					"{C:green}12010873 in 88888888{} chance to do nothing",
					"{C:green}17593235 in 88888888{} chance for {X:mult,C:white} X#1# {} Mult", -- 2
					"{C:green}17457012 in 88888888{} chance for {X:chips,C:white} X#2# {} Chips", -- 2
					"{C:green}17047819 in 88888888{} chance for {X:mult,C:white} X#3# {} Mult", -- 0.5
					"{C:green}16989919 in 88888888{} chance for {X:chips,C:white} X#4# {} Chips", -- 0.5
					"{C:green}3941256 in 88888888{} chance for {X:mult,C:white} X#5# {} Mult", -- 4
					"{C:green}3758989 in 88888888{} chance for {X:chips,C:white} X#6# {} Chips", -- 4
					"{C:green}88888 in 88888888{} chance for {X:dark_edition,C:white} ^#7# {} Chips and Mult", -- 4
					"{C:green}888 in 88888888{} chance for {X:dark_edition,C:white} ^^#8# {} Chips and Mult", -- 4
					"{C:green}8 in 88888888{} chance for {X:dark_edition,C:white} #9# {} Chips and Mult", -- {88888888}8
					"{C:green}1 in 88888888{} chance to create an {C:tower_apollyon,E:1}Aether Monolith{}",
					"All probabilities are mutually exclusive and immutable."
				}
			},
			j_tower_die_of_fate_tf = {
				name = "Die of Fate",
				text = {
					"{C:green}12010873 in 88888888{} chance to do nothing",
					"{C:green}17593235 in 88888888{} chance for {X:mult,C:white} X#1# {} Mult", -- 2
					"{C:green}17457012 in 88888888{} chance for {X:chips,C:white} X#2# {} Chips", -- 2
					"{C:green}17047819 in 88888888{} chance for {X:mult,C:white} X#3# {} Mult", -- 0.5
					"{C:green}16989919 in 88888888{} chance for {X:chips,C:white} X#4# {} Chips", -- 0.5
					"{C:green}3941256 in 88888888{} chance for {X:mult,C:white} X#5# {} Mult", -- 4
					"{C:green}3758989 in 88888888{} chance for {X:chips,C:white} X#6# {} Chips", -- 4
					"{C:green}88888 in 88888888{} chance for {X:dark_edition,C:white} ^#7# {} Chips and Mult", -- 4
					"{C:green}888 in 88888888{} chance for {X:dark_edition,C:white} ^^#8# {} Chips and Mult", -- 4
					"{C:green}8 in 88888888{} chance for {X:dark_edition,C:white} #9# {} Chips and Mult", -- {88888888}8
					"{C:green}1 in 88888888{} chance to create {C:legendary,E:1}The Soul{}",
					"All probabilities are mutually exclusive and immutable."
				}
			},
			j_tower_die_of_chaos = {
				name = "Die of Chaos",
				text = {
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^^^^#1# {} Chips or Mult", -- ^^^^1.2
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^^^#2# {} Chips or Mult", -- ^^^1.15
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^^#3# {} Chips or Mult", -- ^^1.1
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^#4# {} Chips or Mult", -- ^1.1
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} X#5# {} Chips or Mult", -- X1.1
					"{C:green}2020202 in 22222222{} chance for {C:dark_edition}+#6#{} Chips or Mult", -- +1
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} X#7# {} Chips or Mult", -- X0.9
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^#8# {} Chips or Mult", -- ^0.9
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^^#9# {} Chips or Mult", -- ^^0.9
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^^^#10# {} Chips or Mult", -- ^^^0.85
					"{C:green}2020202 in 22222222{} chance for {X:dark_edition,C:white} ^^^^#11# {} Chips or Mult", -- ^^^^0.8
					"All probabilities are mutually exclusive and immutable."
				}
			},
			j_tower_die_of_will = {
				name = "Die of Will",
				text = {
					"When you are about to {X:attention,C:white} die {}, there is a",
					"{C:green}1154173 in 11111111{} chance to prevent Death if required score is at least {C:attention}90%{}",
					"{C:green}1123492 in 11111111{} chance to prevent Death if required score is at least {C:attention}80%{}",
					"{C:green}1103785 in 11111111{} chance to prevent Death if required score is at least {C:attention}70%{}",
					"{C:green}1155436 in 11111111{} chance to prevent Death if required score is at least {C:attention}60%{}",
					"{C:green}1123536 in 11111111{} chance to prevent Death if required score is at least {C:attention}50%{}",
					"{C:green}1130573 in 11111111{} chance to prevent Death if required score is at least {C:attention}40%{}",
					"{C:green}1114211 in 11111111{} chance to prevent Death if required score is at least {C:attention}30%{}",
					"{C:green}1114525 in 11111111{} chance to prevent Death if required score is at least {C:attention}20%{}",
					"{C:green}1111461 in 11111111{} chance to prevent Death if required score is at least {C:attention}10%{}",
					"{C:green}1031570 in 11111111{} chance to prevent Death if required score is at least {C:attention}0%{}",
					"All probabilities are mutually exclusive.",
					"This joker is immutable."
				}
			},
			j_tower_die_of_echoes = {
				name = "Die of Echoes",
				text = {
					"{C:green}12121212 in 44444444{} chance to not scale",
					"{C:green}8080808 in 44444444{} chance to scale by {X:mult,C:white} X#1# {}",
					"{C:green}5050505 in 44444444{} chance to scale by {X:mult,C:white} X#2# {}", 
					"{C:green}2020202 in 44444444{} chance to scale by {X:mult,C:white} X#3# {}",
					"{C:green}1010101 in 44444444{} chance to scale by {X:mult,C:white} X#4# {}",
					"{C:green}1010101 in 44444444{} chance to scale by {X:mult,C:white} X#5# {}",
					"{C:green}2020202 in 44444444{} chance to scale by {X:mult,C:white} X#6# {}",
					"{C:green}5050505 in 44444444{} chance to scale by {X:mult,C:white} X#7# {}",
					"{C:green}8080808 in 44444444{} chance to scale by {X:mult,C:white} X#8# {}",

					"{C:inactive}(Currently {C:mult}+#9#{C:inactive} Mult)",

					"All probabilities are mutually exclusive and immutable."
				}
			},
			j_tower_forgotten_die = {
				name = "The Forgotten Die", -- does not show up in collection
				text = {
					"All {C:green}probabilities{} are fixed to either {C:green}Succeed{} or {C:red}Fail{}"
				}
			},
			j_tower_snake_eyes = {
				name = "Snake Eyes",
				text = {
					"{C:red}Halves{} all probabilities",
					"and {C:attention}Doubles{} all changes to {C:chips}Chips{} and {C:mult}Mult"
				}
			},
			j_tower_fair_odds = {
				name = "Fair Odds",
				text = {
					"All cards are considered {C:attention}Aces",
					"All suits count as all suits",
					"All rarities have an equal chance of appearing",
					"All consumables of a set have an",
					"equal chance of appearing",
					"All odds are {C:green}1 in 2",
					"{C:inactive}(This joker is immutable)"
				}
			},
			j_tower_king_slime = {
				name = "King Slime",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#{} for each {C:attention}King{} in deck",
					"Additonally gives {X:mult,C:white} X#2# {} Mult for each",
					"{C:attention}King{} in deck if next to {C:attention}Queen Slime{}",
				},
			},
			j_tower_queen_slime = {
				name = "Queen Slime",
				text = {
					"{C:mult}+#1#{} Mult{} for each {C:attention}Queen{} in deck",
					"Additonally gives {X:chips,C:white} X#2# {} Chips for each",
					"{C:attention}Queen{} in deck if next to {C:attention}King Slime{}",
				},
			},
			j_tower_eye_of_cthulhu = {
				name = "Eye of Cthulhu",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#{} on 1st Blind of an ante",
					"{C:mult}+#2#{} Mult{} on 2nd Blind of an ante",
					"{X:mult,C:white} X#3# {} Mult of 3rd Blind of an ante",
				},
			},
			j_tower_green_slime = {
				name = "Green Slime",
				text = {
					"{C:chips}+#1#{} Chips{}",
					"{C:mult}+#2#{} Mult{}",
					"{C:money}+#3#${}",
				},
			},
			j_tower_red_slime = {
				name = "Red Slime",
				text = {
					"{C:mult}+#1#{} Mult{}"
				},
			},
			j_tower_blue_slime = {
				name = "Blue Slime",
				text = {
					"{C:chips}+#1#{} Chips{}"
				},
			},
			j_tower_purple_slime = {
				name = "Purple Slime",
				text = {
					"{C:chips}+#1#{} Chips{}",
					"{C:mult}+#2#{} Mult{}",
				},
			},
			j_tower_yellow_slime = {
				name = "Yellow Slime",
				text = {
					"{C:money}+#1#${}"
				},
			},
			j_tower_pinky = {
				name = "Pinky",
				text = {
					"{X:dark_edition,C:white} #2# {} Chips",
					"{X:dark_edition,C:white} #3# {} Mult",
					"Increase operator by",
					"one for each {C:attention}Slime{}",
					"{C:inactive}(Currently #1# Slimes)"
				},
			},
			j_tower_spiked_slime = {
				name = "Spiked Slime",
				text = {
					"{C:attention}Destroy{} all scored cards and add ",
					"{X:chips,C:white} X#1# {} Chips for each destroyed card",
					"{C:inactive}(Currently {X:chips,C:white} X#2# {C:inactive} Chips)"
				},
			},
			j_tower_dungeon_slime = {
				name = "Dungeon Slime",
				text = {
					"Sell to apply {C:attention}Gold Seal{}, {C:attention}Gold{} and",
					"{C:attention}Golden{} to all jokers, cards and consumables"
				},
			},
			j_tower_black_slime = {
				name = "Black Slime",
				text = {
					"Blind score is {C:attention}hidden{} and",
					"{C:attention}reduced{} by {C:attention}10%{} at beginning of round",
					"{C:inactive}(This joker is immutable)" -- 10% cannot be changed for... obvious reasons
				},
			},
			j_tower_shimmer_slime = {
				name = "Shimmer Slime",
				text = {
					"Permanently increase",
					"{C:attention}Polychrome{} by {X:mult,C:white} X#1# {} compounding",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
				},
			},
			j_tower_golden_slime = {
				name = "Golden Slime",
				text = {
					"{C:attention}Gold Seal{}, {C:attention}Gold{} and {C:attention}Golden{} gives {X:dark_edition,C:white} ^#1# {} dollars"
				},
			},
			j_tower_astrageldon = {
				name = "Astrageldon",
				text = {
					"Apply {C:dark_edition}Astral{} to all played cards and create an",
					"{C:cry_exotic}Astrum Aureus{} for every {C:attention}#1#{} {C:inactive}[#2#]{} cards turned {C:dark_edition}Astral"
				},
			},
			j_tower_astrum_aureus = {
				name = "Astrum Aureus",
				text = {
					"{C:attention}Scored cards{} give {X:dark_edition,C:white} ^#1# {} Mult"
				},
			},
			j_tower_shimmer_bucket = {
				name = "Bottomless Shimmer Bucket",
				text = {
					"{C:attention}Use{} this card on ???",
					"{C:inactive}(Max uses: Infinity)"
				},
			},
			j_tower_cyanprint = {
				name = 'Cyanprint',
                text = {
                    "Double values of",
                    "{C:attention}Joker{} to the right",
                },
			},
			j_tower_limeprint = {
				name = 'Limeprint',
                text = {
                    "Destroys {C:attention}Joker{} to the left",
					"and retriggers {C:attention}Joker{} to the right",
					"#1# time#<s>1#", -- 2
                },
			},
			j_tower_yellowprint = {
				name = 'Yellowprint',
                text = {
                    "When a new round begins, divide the",
					"{C:attention}Joker{} to the right into {C:attention}#1# pieces{}", -- 3
					"with values split between the copies",
                },
			},
			j_tower_springprint = {
				name = 'Springprint',
                text = {
                    "When a new round begins the",
                    "{C:attention}Joker{} to the right",
					"changes to one of the same rarity"
                },
			},
			j_tower_pinkprint = {
				name = 'Pinkprint',
                text = {
                    "Every other round, retrigger",
					"{C:attention}Joker{} to the right #1# time#<s>1#,",
					"otherwise debuff it",
                },
			},
			j_tower_print = {
				name = 'print',
                text = {
                    "Retrigger the {C:attention}Joker",
					"to the right {C:attention}#1# time#<s>1#",
					"for every empty {C:attention}Joker slot",
					"including print",
					"{C:inactive}(Currently #2# retrigger#<s>2#)",
                },
			},
			j_tower_blue = {
				name = 'Blue',
                text = {
                    "{C:tower_apollyon,E:1,S:10}Copy{}",
                },
			},
			j_tower_greenprint = {
				name = 'Greenprint',
                text = {
                    "{X:mult,C:white} X#1# {} Mult", -- (starting at) X1
					"Gains {X:mult,C:white} X#2# {} Mult for",
					"every time joker to the right has",
					"triggered this round", -- 0.05
                },
			},
			j_tower_goldprint = {
				name = 'Goldprint',
                text = {
                    "Gives {C:money}$#1#{} for every joker to the right", -- 1
					"{C:inactive}(Currently {C:money}$#2#{C:inactive})" -- total
                },
			},
			j_tower_redprint = {
				name = 'Redprint',
                text = {
                    "Destroys {C:attention}Joker{} to the left",
					"and copies {C:attention}Joker{} to the right",
					"{C:inactive}(If there is no joker to the left,",
					"{C:inactive}will instead destroy joker to the right)",
                },
			},
			j_tower_orangeprint = {
				name = 'Orangeprint',
                text = {
                    "Copies {C:attention}Jokers{} 1-5, excluding Orangeprint", -- would misprinting this even makes sense
					"{C:inactive}(Changes when triggered)"
                },
			},
			j_tower_purpleprint = {
				name = 'Purpleprint',
                text = {
                    "When you reach 0 hands, you gain two hands", -- dont variable this bc passing ability with variable is annoying
					"and pass this ability to the joker to the right",
					"{C:inactive}(If there is no joker to the right, the ability will be lost)",
					"{S:1.1,C:red,E:2}self destructs{}"
                },
			},
			j_tower_blackprint = {
				name = 'Blackprint',
                text = {
                    "Will retrigger the joker to the right #1# times",
					"{C:red}Permanently{} becomes stronger when destroyed",
					"{S:1.1,C:red,E:2}self destructs{}"
                },
			},
			j_tower_cosmic_alignment = {
				name = "Cosmic Alignment",
				text = {
					"Played hand always contains the",
					"handtype {C:attention}above{} and {C:attention}below{} in the {C:attention}handlist"
				},
			},
			j_tower_astral_projection = {
				name = "Astral Projection",
				text = {
					"{C:tower_apollyon,E:1}Empower{} all Jokers",
					"#1# time#<s>1# when round begins"
				}
			},

			j_tower_tanpaku = {
				name = "Tanpaku",
				text = {
					"When a {C:attention}Consumable{} is used, create {C:attention}#1#{} copies",
					"of {C:attention}all modified or created cards{} and {C:attention}one{} copy of the",
					"{C:attention}Consumable{}, then increase copies of cards by {C:attention}#2#{}" -- 1 copies increase by 1
				},
			},
			j_tower_tanjun = {
				name = "Tanjun",
				text = {
					"{X:dark_edition,C:white} ^#1# {} Chips for every #2# time#<s>2# scored cards are triggered" -- ^2 every 2
				},
			},
			j_tower_mi = {
				name = "Mi",
				text = {
					"{X:dark_edition,C:white} #1# {} Chips, multiply by highest value on the rightmost",
					"Joker and increase operator by #2# at end of round" -- x1 by 1
				},
			},
			j_tower_jufuku = {
				name = "Jufuku",
				text = {
					"{C:attention}Double{} all values",
					"of all scored {C:attention}Jokers",
					"and {C:attention}Playing Cards"
				},
			},
		},
		tower_transmuted = {
			c_tower_aether_monolith = {
				name = "Aether Monolith",
				text = {
					"Create an {C:tower_apollyon,E:1}Apollyon{} Joker",
				},
			},
		},
		Spectral = {
			c_tower_shimmer_bottle = {
				name = "Shimmer Bottle",
				text = {
					"Select #1# ??? to use"
				}
			},
			c_tower_unbounded_pointer = {
				name = "POINTER://",
				text = {
					"Create a card",
					"of {C:cry_code}your choice",
					"{C:tower_apollyon,E:1}No restrictions apply{}"
				},
			},
		},
		Omen = {
			c_tower_madness_core = {
				name = "Madness",
				text = {
					"{C:tower_apollyon,E:1}Empower{} a selected joker #1# time#<s>1#"
				}
			},
		}
    },
	misc = {        
		ranks_plural={
			["tower_0"] = '0s',
			["tower_1"] = "1s",
            ["10"]="10s",
            ["2"]="2s",
            ["3"]="3s",
            ["4"]="4s",
            ["5"]="5s",
            ["6"]="6s",
            ["7"]="7s",
            ["8"]="8s",
            ["9"]="9s",
            Ace="Aces",
            Jack="Jacks",
            King="Kings",
            Queen="Queens",
        },
		labels = {
			k_tower_apollyon = "Apollyon",
			k_tower_transmuted = "Transmuted",
			k_tower_inverted = "Chips & Mult Swapped",
			b_tower_transmuted = "Transmuted",

			tower_truenegative = "True Negative",
			tower_bound = "Bound",
			tower_sleeping_blessing = "Sleeping Blessing",
			tower_empowered = "Empowered",
			tower_notrigger = "Dud",
			tower_fuckyou = Cryptid_config.family_mode and "Your Sins" or "Fuck You",
			tower_virus = "Infected",
			tower_food = "Edible",
			tower_transmuted = "Transmuted",
		},
		dictionary = {
			b_tower_minigame = "Minigames",
			k_tower_apollyon = "Apollyon",
			k_tower_transmuted = "Transmuted",
			k_tower_inverted = "Chips & Mult Swapped",
			b_tower_transmuted = "Transmuted",

			tower_astrageldon_astraled = "Astraled",
			tower_astrageldon_astrum_aureused = "Astrum'd",

            k_book = "Book",
            k_books = "Books",
            gald_books = "Select Book",
            gald_random_book = "Random Book",
			tower_debuff_sun = "Must only contain Hearts",
			tower_debuff_moon = "Must only contain Clubs",
			tower_debuff_world = "Must only contain Spades",
			tower_debuff_star = "Must only contain Diamonds",
			tower_debuff_lovers = "Must contain all Suits",
			tower_debuff_lovers_missing = "Missing ",
			tower_debuff_instability = "Must only contain Abstract", -- trolling
			tower_debuff_blackhole = "Cannot play already played hand",
			tower_debuff_unknown = "???",
			tower_debuff_hangedman = "Hand must have at least three cards",
			tower_debuff_bound_card = "Hand cannot contain Bound cards",
			tower_debuff_bound_joker = "Must not have any Bound jokers",
			tower_debuff_bound_consumable = "Must not have any Bound consumables",
			tower_debuff_emperor = "Copies two random Tarots",
			tower_debuff_automaton = "Copies three random Code Blinds",
			tower_debuff_merge = "Copies the effects of the next two blinds",
			tower_debuff_cryfunction = "Copies the effects of the last three consumable blinds played",

			tower_inverted = "Swapped!",

			tower_skip_book = "Skip book selection",
			tower_show_banned = "Show when cards are Banned",
			tower_main_menu = "Main menu card",

			ranks = {
				tower_0 = '0',
				tower_1 = '1',
				cry_abstract = "Abstract" -- a bit of trolling
			},

			b_tower_book = "Book",
            k_tower_book="Book",
			k_tower_transmuted_cards = "Transmuted Cards",
			b_tower_transmuted_cards = "Transmuted Cards",


			tower_edition = "(random edition)",
			tower_rank = "(random rank)",
			tower_seal = "(random seal)",
			tower_handtype = "(random hand type)",
			tower_seraph_place = "(0.25x blind size)",
			tower_pointer_place = "(random card in the collection)",
			tower_hammerspace_place = '(current ante)',

			tower_hand_nil = "ERROR",

			k_tower_slime_pool = "Slime Pack",
			k_tower_pikaboy10_pack = "Pikaboy Pack",
			k_tower_jamirror_pack = "Jamirror Pack",
			k_tower_cylink_pack = "Cylink Pack",
			k_tower_terra_pool = "Terra Pack",

			k_tower_transmuted_ex = { 
				"Transmuted cards are cards created by the Shimmer.",
				"They cannot be obtained through other means."
			},
			tower_die_of_fate_pointer = "Nat 88888888: Unbounded Pointer",
			tower_die_of_fate_aether = "Nat 88888888: Aether Monolith",
			tower_die_of_fate_soul = "Nat 88888888: The Soul"
		},
		v_dictionary = {
			tower_empowered_level = "Empowered #1#",
			tower_planted = "Planted!",
			tower_stonks = "Stonks!",
			tower_bounce = 'Bounce!',
			tower_boring_bounce = 'Bounce',
			tower_big_bounce = 'Big Bounce!',
			tower_hidden_bounce = 'Hidden Bounce!',
			tower_virtue_boing = 'Boing!',
			tower_money_bounce = "Money Bounce!",
		},
		poker_hands = {
			tower_nil = "ERROR",
		},
		poker_hand_descriptions = {
			tower_nil = {""},
		},
        ranks={
			tower_Joker = "Joker"
		},
		suits_plural = {
			cry_abstract = "Abstract", -- a bit of trolling
			tower_Joker = "Jokers",
		},
		suits_singular = {
			cry_abstract = "Abstract", -- a bit of trolling
			tower_Joker = "Joker",
		},
		challenge_names = {
			c_tower_true_negative = "Negative Nancy"
		},
		v_text = {
			ch_c_tower_true_negative = { "All Jokers, playing cards and Consumables are"},
			ch_c_tower_true_negativel2 = { "{C:negative}True Negative{}, values given by them are negated" }
		},
		achievement_names = {
			ach_tower_clusterfuck_you = Cryptid_config.family_mode and "Cluster of Your Sins"
				or "Clusterfuck You",
			ach_tower_true_positive = "True-Positive",
			ach_tower_rock_and_rock = "Between a Rock and a Rock",
			ach_tower_sus_victory = "Victory?",
			ach_tower_flush_zero = "Flush Zero",
			ach_tower_darker_than_dark = "Darker than Dark",
			ach_tower_old_days = "Old Days",
			ach_tower_victory = "Victory",
			ach_tower_will_of_iron = "Will of Iron",
			ach_tower_antivirus = "Antivirus",
			ach_tower_imaginary = "Imaginary",
		},
		achievement_descriptions = {
			ach_tower_clusterfuck_you = Cryptid_config.family_mode and 'Add the Your Sins sticker to a card which already has Your Sins'
				or "Add the Fuck You sticker to a card which already has Fuck You",
			ach_tower_true_positive = "Make a True-Negative card True-Negative",
			ach_tower_rock_and_rock = "Have the Tower turn all of your cards into Stone in a single discard",
			ach_tower_sus_victory = "Beat (the blind called) the Tower",
			ach_tower_flush_zero = "Make a Flush Five with all zeros",
			ach_tower_darker_than_dark = "Make a Light card True-Negative",
			ach_tower_old_days = "Reach Ante 8",
			ach_tower_victory = "Beat The Egg and the Baron or Greater",
			ach_tower_will_of_iron = "Beat The Eye of God",
			ach_tower_antivirus = "Prevent Malware from infecting your cards by having no cards",
			ach_tower_imaginary = "Index out of bounds",
		},
	}
}