AddonCategory = AddonCategory or {}
local AddonCategory = AddonCategory

--======================================================================================================================
--Base addon categories
--======================================================================================================================
local baseCategoriesSorted = {}
baseCategoriesSorted = {
    { key = "UserInterface",    name="User Interface" },
    { key = "Trackers",         name="Trackers" },
    { key = "Combat",           name="Combat" },
    { key = "PvE",              name="PvE" },
    { key = "PvP",              name="PvP" },
    { key = "Util",             name="Util" },
    { key = "Craft",            name="Craft" },
    { key = "Housing",          name="Housing" },
    { key = "Map",              name="Map" },
    { key = "Class",            name="Class" },
}
AddonCategory.baseCategoriesSorted = baseCategoriesSorted

--Add the base categories as string key
local baseCategories = {}
for _, vData in ipairs(AddonCategory.baseCategoriesSorted) do
    baseCategories[vData.key] = vData.name
end
AddonCategory.baseCategories = baseCategories


--======================================================================================================================
--Base addon categories - Assigned AddOns by name
--======================================================================================================================
local addOnsAssignedToBaseCategories = {}
-->Add new entries here to the relevant subtables of the table addOnsAssignedToBaseCategories.
-->The AddOn's name (same as the txt manifestfilename!) must be the value of the new table entry

--=User Interface=-
addOnsAssignedToBaseCategories[baseCategories.UserInterface] = {
    "AlignGrid"                    ,
    "AUI"                          ,
    "Azurah"                       ,
    "BanditsUserInterface"         ,
    "CombatMetronome"              ,
    "CombatReticle"                ,
    "DarkUI"                       ,
    "FancyActionBar"               ,
    "FancyActionBar+"              ,
    "GridList"                     ,
    "HarvensExtendedStats"         ,
    "JoGroup"                      ,
    "LuiExtended"                  ,
    "IIfA"                         ,
    "pChat"                        ,
    "PerfectPixel"                 ,
    "SlightlyImprovedExperienceBar",
}

--=Trackers=-
addOnsAssignedToBaseCategories[baseCategories.Trackers] = {
    "AiMs-Synergy-Tracker",
    "Acuity",
    "ArchdruidTracker",
    "BuffTheGroup",
    "BSCs-AdvancedSynergy",
    "Cooldowns",
    "DebuffMe",
    "ExoYsProcSetTimer",
    "GCDBar",
    "GroupBuffs",
    "greyskull",
    "HyperTankingTools",
    "HyperTools",
    "LightAttackHelper",
    "LightAttackHelperBlackwood",
    "MayIBash",
    "MKTracker",
    "Olorime",
    "PleaseJustDebuff",
    "PurgeTracker",
    "RaidBuffs",
    "RoaringOpportunist",
    "Siroria",
    "SpaulderTracker",
    "Srendarr",
    "StaggerTracker",
    "Synergy",
    "Thrassian",
    "TouchOfZen",
    "Untaunted",
}

--=Combat=-
addOnsAssignedToBaseCategories[baseCategories.Combat] = {
    "AT_Finisher",
    "CombatMetrics",
    "DeathReport",
    "DRCPA",
    "DressingRoom",
    "HideGroup",
    "HideGroupNecro",
    "ImprovedDeathRecap",
    "NoInnerLight",
    "PenTest",
    "PerfectWeave",
    "PotionReminder",
    "ProvisionsTeamFormation",
    "RipFilter",
    "RGBAOE",
    "Stunning",
    "SynergyToggle",
    "TheShining",
    "WeaveDelays",
    "WizardsWardrobe",
}

--=PvE=-
addOnsAssignedToBaseCategories[baseCategories.PvE] = {
    "AsylumNotifier",
    "AsylumOlorime",
    "AsylumPriorityTarget",
    "AsylumTracker",
    "BearNecessities",
    "BRHelper",
    "CombatAlerts",
    "CRHelper",
    "CrutchAlerts",
    "DungeonTimer",
    "DungeonTracker",
    "ExoYsRockgroover",
    "HodorReflexes",
    "HowToCloudrest",
    "HowToKyne",
    "HowToKynesAegis",
    "HowToSunspire",
    "OdySupportIcons",
    "PlayerRoleIcon",
    "QcellDreadsailReefHelper",
    "QcellRockgroveHelper",
    "Raidificator",
    "RaidNotifier",
    "RalaIsMyEGirl",
    "Samurai",
    "Speedrun",
    "TWPHoF",
    "TWPKA",
    "ZMajaShadeTimer",
}

--=PvP=-
addOnsAssignedToBaseCategories[baseCategories.PvP] = {
    "APMeter",
    "AutoReleaseInBG",
    "BetterScoreboard",
    "ICTheNextBoss",
    "KillCounter",
    "PvDoor",
    "PvpMeter",
    "RdKGroupTool",
}

--=Utililties=-
addOnsAssignedToBaseCategories[baseCategories.Util] = {
    "AccountSettings",
    "AddonCategory",
    "AddonSelector",
    "AdvancedFilters",
    "AFewSettings",
    "ArkadiusTradeTools",
    "ArkadiusTradeToolsExports",
    "ArkadiusTradeToolsPurchases",
    "ArkadiusTradeToolsSales",
    "ArkadiusTradeToolsStatistics",
    "AutoCategory",
    "AutoInvite",
    "AutoRecruit",
    "AwesomeGuildStore",
    "BugCatcher",
    "CarryHelper",
    "ChatTabSelector",
    "Constellations",
    "DescendantsSupportSetTracker",
    "DungeonChampions",
    "Dustman",
    "DynamicCP",
    "displayleads",
    "Emacs",
    "FCOItemSaver",
    "GroupManager",
    "GuildInvite",
    "HarvensImprovedSkillsWindow",
    "HistoricalAchievementCredit",
    "HowLong",
    "ImprovedItemSetCollection",
    "ItemBrowser",
    "jovAST",
    "LibVotansAddonList",
    "LazyHorseFeed",
    "LFGAutoAccept",
    "LootDrop",
    "LootLog",
    "Lumberjack",
    "MasterMerchant",
    "MonsterSetShoulderCollector",
    "MXPV",
    "Overview",
    "PersonalAssistant",
    "PersonalAssistantBanking",
    "PersonalAssistantIntegration",
    "PersonalAssistantJunk",
    "PersonalAssistantLoot",
    "PersonalAssistantRepair",
    "PithkaAchievementTracker",
    "PlayedAll",
    "Postmaster",
    "PXInfoPanel",
    "Recharge",
    "SavedVariablesManager",
    "SetMeUp",
    "ShoppingList",
    "SuperStar",
    "SuppressErrorMessage",
    "TamrielTradeCentre",
    "TBagCounter",
    "TextureIt",
    "TitleFlex",
    "USPF",
    "VotansAdaptiveSettings",
    "VotansKeybinder",
    "VotanSearchBox",
    "WorldEventsTracker",
    "XLGearBanker",
}

--=Crafting=-
addOnsAssignedToBaseCategories[baseCategories.Craft] = {
    "AIResearchGrid",
    "AutoResearch",
    "CraftedPotions",
    "CraftStoreFixedAndImproved",
    "DailyAlchemy",
    "DailyProvisioning",
    "DolgubonsLazySetCrafter",
    "DolgubonsLazyWritCreator",
    "MassDeconstructor",
    "MasterRecipeList",
    "MasterWritInventoryMarker",
    "NoResearchDupes",
    "PotionMaker",
    "ResearchAssistant",
    "ResearchCraft",
    "TinydogsCraftingCalculator",
    "TraitBuddy",
    "VotansImprovedMulticraft",
    "WritWorthy",
}

--=Housing=-
addOnsAssignedToBaseCategories[baseCategories.Housing] = {
    "DecoTrack",
    "EssentialHousingCommunity",
    "EssentialHousingTools",
    "FurnitureCatalogue",
    "FurnitureCatalogue_DevUtility",
    "FurnitureCatalogue_Export",
    "FurniturePreview",
    "GuildHallList",
    "HousingHub",
    "MagicCarpet",
    "PortToFriendsHouse",
    "TargetDummyTools",
}

--=Map=-
addOnsAssignedToBaseCategories[baseCategories.Map] = {
    "BeamMeUp",
    "ChestMaster9000",
    "CircularMinimap",
    "Destinations",
    "HarvestMap",
    "HarvestMapAD",
    "HarvestMapDC",
    "HarvestMapDLC",
    "HarvestMapEP",
    "HarvestMapNF",
    "LoreBooks",
    "LostTreasure",
    "MapPins",
    "MiniMap",
    "QuestMap",
    "VotansFisherman",
    "VotansFishermanExport",
    "VotansFishFillet",
    "VotansMiniMap",
    "RareFishTracker",
    "SkyShards",
}

--=Class=-
addOnsAssignedToBaseCategories[baseCategories.Class] = {
    "BoundArmamentsCounter",
    "CrystalFragmentsProc",
    "GrimFocusCounter",
    "HowToBeam",
    "OnlyCastCrystalFragmentsProc",
    "ShowBlast",
}

AddonCategory.addOnsAssignedToBaseCategories = addOnsAssignedToBaseCategories



--======================================================================================================================
--The default SavedVariables
--======================================================================================================================
AddonCategory.defaultSV = {
    --LAM options
    allowDeleteBaseCategories = false,

    --Categories saved data
    listCategory = {},          --the addon categories which have been manually created or taken from default SavedVariables

    --AddOns saved data
    addon2Category = {},        --the saved addon names and their assigned category

    --AddonManager saved data
    sectionsOpen = {},          --the currently opened categories at the AddonManager
}

function AddonCategory.BuildDefaultSavedVars()
    --Build the default SavedVariables base addon categories and the assigned addon names per base category

    --Only fill in the "defaults" if they are empty in the SavedVariables!
    local currentSV = AddonCategoryVariables["Default"][GetDisplayName()]["$AccountWide"]
    if currentSV ~= nil then
        local currentSVListCategory = currentSV.listCategory
        --local currentSVAddon2Category = currentSV.addon2Category

        --Default: Categories
        ---No custom categories have been assigned yet (first run of the addon or after reset e.g.)
        ---If the current SV's listCategory table contains any entries those either are the default categories already,
        ---or the user changed them. We do not want to overwrite them and add default categories and/or addons anymore!
        if ZO_IsTableEmpty(currentSVListCategory) then
            --Loop the base categories
            for k, vData in ipairs(AddonCategory.baseCategoriesSorted) do
                local addOnBaseCategoryName = vData.name
                if addOnBaseCategoryName ~= nil and addOnBaseCategoryName ~= "" then
                    --Set the default SV's category = currently looped category
                    -->Prepare table for LAMOrderListBoxWidget compatibility (needs a subtable per entry with keys uniqueKey, text and value)
                    AddonCategory.defaultSV.listCategory[k] = {uniqueKey=k, text=addOnBaseCategoryName, value=k}

                    --Default: AddOns assigned to categories
                    ---If the addon category was not added to the defaults yet then add the categories' default addons to
                    ---the default SVs now, so that the AddonManager shows them below that category
                    local addOnsAssignedToThatBaseCategory = addOnsAssignedToBaseCategories[addOnBaseCategoryName]
                    if addOnsAssignedToThatBaseCategory ~= nil then
                        for _, addOnName in ipairs(addOnsAssignedToThatBaseCategory) do
                            AddonCategory.defaultSV.addon2Category[addOnName] = addOnBaseCategoryName
                        end
                    end
                end
            end
        end
    end
end
