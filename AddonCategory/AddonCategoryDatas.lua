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
    allowDeleteBaseCategories = false,
    ["sectionsOpen"] = {},
}

--Build the default SavedVariables base addon categories and the assigned addon names per base category
for baseCategory, addOnsAssignedToBaseCategory in pairs(addOnsAssignedToBaseCategories) do
    for _, addOnName in ipairs(addOnsAssignedToBaseCategory) do
        local addOnBaseCategoryName = baseCategories[baseCategory]
        if addOnBaseCategoryName ~= nil and addOnBaseCategoryName ~= "" then
            AddonCategory.defaultSV[addOnName] = addOnBaseCategoryName
        end
    end
end

--LAMOrderListBoxWidget compatibility
AddonCategory.defaultSV.listCategory = {}
for k, vData in ipairs(AddonCategory.baseCategoriesSorted) do
    AddonCategory.defaultSV.listCategory[k] = {uniqueKey=k, text=vData.name, value=k}
end