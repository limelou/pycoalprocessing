if mods.pyindustry then
    require "prototypes/updates/pyindustry-updates"
end

require "prototypes/updates/base-updates"
require "prototypes/updates/entity-updates"
require "prototypes/technologies/stacking-belts"
require "prototypes/item-sounds"

ITEM("automation-science-pack", "tool"):set("icon", "__pycoalprocessinggraphics__/graphics/icons/science-pack-1.png")
ITEM("automation-science-pack", "tool"):set("icon_size", 64)

ITEM("logistic-science-pack", "tool"):set("icon", "__pycoalprocessinggraphics__/graphics/icons/science-pack-2.png")
ITEM("logistic-science-pack", "tool"):set("icon_size", 64)

ITEM("chemical-science-pack", "tool"):set("icon", "__pycoalprocessinggraphics__/graphics/icons/science-pack-3.png")
ITEM("chemical-science-pack", "tool"):set("icon_size", 64)

ITEM("lab"):set("icon", "__pycoalprocessinggraphics__/graphics/icons/lab-mk01.png")
ITEM("lab"):set("icon_size", 64)

ITEM("electric-engine-unit"):set("icon", "__pycoalprocessinggraphics__/graphics/icons/electric-engine-unit.png")
ITEM("electric-engine-unit"):set("icon_size", 64)

RECIPE("small-electric-pole"):replace_result("small-electric-pole", {type = "item", name = "small-electric-pole", amount = 1})

RECIPE("medium-electric-pole"):add_ingredient {type = "item", name = "niobium-plate", amount = 1}:replace_ingredient("copper-plate", {type = "item", name = "copper-cable", amount = 5}):replace_ingredient("iron-stick", {type = "item", name = "nbfe-alloy", amount = 2}):remove_ingredient("steel-plate")

RECIPE("big-electric-pole"):remove_ingredient("steel-plate"):remove_ingredient("copper-plate"):add_ingredient {type = "item", name = "niobium-plate", amount = 2}:add_ingredient {type = "item", name = "copper-cable", amount = 15}:replace_ingredient("iron-stick", {type = "item", name = "steel-plate", amount = 6})

RECIPE("chemical-plant"):remove_unlock("oil-processing"):set_fields {hidden = true}
ENTITY("chemical-plant"):set_fields {hidden = true}
ITEM("chemical-plant"):set_fields {hidden = true}

RECIPE("pump"):remove_unlock("fluid-handling"):add_unlock("engine")

require "prototypes/recipes/fuel-canister-recipes"

--remove base game oil processing stuff
require "prototypes/updates/base-oil"

--add handcrafting to player character
for _, player_type in pairs {"character", "god-controller"} do
    for _, player in pairs(data.raw[player_type]) do
        player.crafting_categories = player.crafting_categories or {}
        table.insert(player.crafting_categories, "handcrafting")
        player.crafting_categories = table.dedupe(player.crafting_categories)
    end
end

data.raw["item-subgroup"]["science-pack"].group = "production"
data.raw["item-subgroup"]["science-pack"].order = "y"

--gather recipes for module changes
local recipes_list =
{
    "active-carbon",
    "air-pollution",
    "alien-sample01",
    "anthraquinone",
    "aromatics-to-lubricant",
    "aromatics-to-plastic",
    "aromatics-to-rubber",
    "aromatics",
    "aromatics2",
    "aromaticsolefin",
    "ash-separation",
    "bio-sample01",
    "bonemeal",
    "boron-trioxide",
    "cladded-core",
    "cladding",
    "co2-organics",
    "co2",
    "coal-briquette",
    "coal-fawogae",
    "coal-gas-from-coke",
    "coal-gas-from-wood",
    "coal-gas",
    "coaldust-ash",
    "coarse-classification",
    "coke-coal",
    "combustion-mixture2",
    "combustion-olefin",
    "concrete-richclay",
    "copper-coating",
    "creosote-to-aromatics",
    "creosote",
    "crushed-copper",
    "crushed-iron",
    "crushing-copper",
    "crushing-iron",
    "diborane",
    "dirty-reaction",
    "drill-head",
    "equipment-chassi",
    "eva-ree-dust",
    "explosive-glycerol",
    "extract-coarse",
    "extract-gravel",
    "extract-richdust",
    "extract-sand",
    "extract-stone",
    "extract-sulfur",
    "fawogae-substrate",
    "fawogae",
    "fuelrod-mk01",
    "glycerol-syngas",
    "ground-sample01",
    "heavy-oil_from_coal-gas",
    "heavy-oleo",
    "heavyoil-to-coal-gas",
    "iron-oxide",
    "kevlar-coating",
    "kevlar",
    "lab-instrument",
    "light-oil_from_syngas",
    "lightoil-to-syngas",
    "lime",
    "lithium-peroxide",
    "log-organics",
    "log-wood",
    "log1",
    "log2",
    "log3",
    "log4",
    "log5",
    "log6",
    "making-chromium",
    "mukmoux-fat",
    "nas-battery",
    "nbfe-coating",
    "nexelit-cartridge",
    "nichrome",
    "niobium-complex",
    "niobium-concentrate",
    "niobium-dust",
    "niobium-ore",
    "niobium-oxide",
    "niobium-powder",
    "olefin-petgas",
    "olefin",
    "oleo-gasification",
    "oleo-heavy",
    "oleo-methanol",
    "oleo-solidfuel",
    "oleochemicals-crude-oil",
    "oleochemicals-distilation",
    "oleochemicals",
    "optical-fiber",
    "organic-solvent",
    "organics-from-wood",
    "organics-processing",
    "petgas-from-refsyngas",
    "petgas-methanol",
    "petgas-to-refsyngas",
    "ppd",
    "ralesia-seeds",
    "ralesia",
    "raw-borax",
    "ref-to-light-oil",
    "refolefin",
    "refsyngas-from-meth-canister",
    "refsyngas-from-meth",
    "rich-clay",
    "rich-re",
    "richdust-separation",
    "sand-brick",
    "sand-classification",
    "saturated-nexelit-cartridge-regen",
    "slacked-lime",
    "soil-separation",
    "soil",
    "stone-distilation",
    "sulfur-crudeoil",
    "sulfur-heavyoil",
    "sulfur-lightoil",
    "sulfur-petgas",
    "sulfuric-petgas",
    "tailings-borax-niobium",
    "tailings-classification",
    "tailings-copper-iron",
    "tailings-dust",
    "tailings-separation",
    "tpa",
    "wood-to-coal",
    "zinc-chloride",
}

table.insert(recipes_list, "niobium-plate")

--adding to module limitation list
py.allow_productivity(recipes_list)

RECIPE("beacon")
    :add_ingredient {type = "item", name = "sc-engine", amount = 2}
    :add_ingredient {type = "item", name = "magnetic-ring", amount = 10}
    :add_ingredient {type = "item", name = "intelligent-unit", amount = 1}
    :add_ingredient {type = "item", name = "parametric-oscilator", amount = 1}
    :add_ingredient {type = "item", name = "biopolymer", amount = 10}
    :add_ingredient {type = "item", name = "super-alloy", amount = 10}:remove_ingredient {"steel-plate"}
    :add_ingredient {type = "item", name = "tower-mk04", amount = 1}
    :add_ingredient {type = "item", name = "processing-unit", amount = 5}:remove_ingredient {"electronic-circuit"}:remove_ingredient {"advanced-circuit"}
    :add_ingredient {type = "item", name = "metastable-quasicrystal", amount = 1}
    :add_ingredient {type = "fluid", name = "r4", amount = 100}
if mods.pyalternativeenergy then data.raw.recipe.beacon.category = "crafting-with-fluid" end

RECIPE("beacon-mk01")
    :add_ingredient {type = "item", name = "self-assembly-monolayer", amount = 1}
    :add_ingredient {type = "item", name = "mechanical-parts-02", amount = 1}
    :add_ingredient {type = "item", name = "eva", amount = 10}
    :add_ingredient {type = "item", name = "stainless-steel", amount = 10}:remove_ingredient {"steel-plate"}
    :add_ingredient {type = "item", name = "tower-mk02", amount = 1}

if register_cache_file ~= nil then
    register_cache_file({"pycoalprocessing"}, "__pycoalprocessing__/cached-configs/pycoalprocessing.lua")
end

if mods["dependency-graph-lib"] then
    data.raw.item["copper-plate"].autotech_startup = true
end
