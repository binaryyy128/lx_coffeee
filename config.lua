Config = {}

Config.Locale = 'de'

Config.EventKey = 'llsAof___sss'

Config.Locales = {
    ['de'] = {
        ['menu_title'] = "Kaffemaschiene",
        ['menu_subtitle'] = "Mache einen Kaffee",
        ['runButton'] = "%s ausgeben.",
        ['runButton_hint'] = "Drücke um den Kaffee kochen zu lassen.",
        ['msg_brewing'] = "%s wird ausgegeben.",
        ['msg_ingredients_missing'] = "Es fehlt noch eine oder mehrere Zutaten.",
        ['msg_addIngredrients'] = "Füge Zutaten hinzu",
        ['msg_addedIngredient'] = "Du hast %s hinzugefügt",
        ['msg_not_enough_ingredient'] = "Du hast nicht genügend %s.",
        ['msg_ingredient_already_added'] = "Du hast %s schon hinzugefügt.",
        ['translation_ingredients'] = "Zutaten",
        ['translation_adding'] = "hinzufügen..."
    }
}

Config.Locations = {
    {coords = vector3(146.6336, -1060.2444, 22.9602)}
}

Config.Coffees = {
    {
        name = "Espresso", 
        hint = "Ein kleiner Energieschub.", 
        itemName = "espresso",
        dispenseTime = 15000, --in ms
        ingredients = {
            {label = "Kaffeebohnen", item = "kaffeebohnen", c = 2}, 
            {label = "Wasser", item = "water", c = 1}
        }
    },
    {
        name = "Cappuccino", 
        hint = "Ein Café der angenehm zu trinken ist.", 
        itemName = "cappucino",
        dispenseTime = 15000, --in ms
        ingredients = {
            {label = "Milch", item = "milk", c = 2}, 
            {label = "Zucker", item = "sugar", c = 1},
            {label = "Kaffeebohnen", item = "kaffeebohnen", c = 2},
            {label = "Wasser", item = "water", c = 1}
        }
    },
    {
        name = "Latte Macchiato", 
        hint = "Ein Café mit wunderbarem Milchschaum.", 
        itemName = "lattemacchiato",
        dispenseTime = 15000, --in ms
        ingredients = {
            {label = "Milch", item = "milk", c = 1}, 
            {label = "Zucker", item = "sugar", c = 1},
            {label = "Kaffeebohnen", item = "kaffeebohnen", c = 1},
            {label = "Wasser", item = "water", c = 1}
        }
    },
    {
        name = "Kakao", 
        hint = "Der Café der keiner ist.", 
        itemName = "kakaodrink",
        dispenseTime = 15000, --in ms
        ingredients = {
            {label = "Kakaopulver", item = "kakaopulver", c = 1}, 
            {label = "Milch", item = "milk", c = 2},
            {label = "Zucker", item = "sugar", c = 1}
        }
    }
}