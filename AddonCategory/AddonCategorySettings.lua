AddonCategory = AddonCategory or {}
local AddonCategory = AddonCategory
local MAJOR = AddonCategory.name

local LAM2 = LibAddonMenu2
local LSM = LibScrollableMenu

local baseCategories = AddonCategory.baseCategories

local GetAddonCategories = AddonCategory.GetAddonCategories
local ChangeAddonCategoryName = AddonCategory.ChangeAddonCategoryName
local updateCurrentAddOnCategories = AddonCategory.updateCurrentAddOnCategories
local isAddOnCategory = AddonCategory.isAddOnCategory
local checkIfAddonsInCategory = AddonCategory.CheckIfAddonsInCategory

local addonsList = {}
local categoryList = {}
local categoryListIndex = {}

local excludedSavedVars = AddonCategory.excludedSavedVars


local function GetAddonsByList()
    local l_addonsList = {}
    for _, value in pairs(AddonCategory.listAddons) do
        table.insert(l_addonsList, value)
    end
    table.sort(l_addonsList, function (a, b) return string.lower(a) < string.lower(b) end)
    return l_addonsList
end

local function updateNeededTables()
    addonsList = GetAddonsByList()
    categoryList = GetAddonCategories(false)
    categoryListIndex = GetAddonCategories(true)
end

local function updateComboBoxChoices(lamDropdownControl)
    local choices, choicesValues
    if lamDropdownControl == AddonCategory_Addon_dropdown then
        choices = addonsList
    elseif lamDropdownControl == AddonCategory_Categories_dropdown then
        choices = categoryList
        choicesValues = categoryListIndex
    elseif lamDropdownControl == AddonCategory_CategoriesName_dropdown then
        choices = categoryList
        choicesValues = categoryListIndex
    end
    lamDropdownControl:UpdateChoices(choices, choicesValues, nil)
    local comboBox = lamDropdownControl.combobox.m_comboBox
    if comboBox == nil then return end
    comboBox:SetSelectedItemText("")
    comboBox.m_selectedItemData = nil
end

local function UpdateAllChoices()
    updateNeededTables()
    updateComboBoxChoices(AddonCategory_Addon_dropdown)
    updateComboBoxChoices(AddonCategory_Categories_dropdown)
    updateComboBoxChoices(AddonCategory_CategoriesName_dropdown)
    --CategoriesOrder_dropdown:UpdateChoices()
    --NewOrder_dropdown:UpdateChoices()
end

function AddonCategory.OpenLAMSettingsMenu()
    if AddonCategory.LAMsettingsPanel == nil then return end
    LAM2:OpenToPanel(AddonCategory.LAMsettingsPanel)
    UpdateAllChoices()
end

local function UpdateDisabledStateOfLinkCategoryButtons()
    AddonCategory_AddonNonAssigned_button:UpdateDisabled()
    AddonCategory_AddonLink_button:UpdateDisabled()
    AddonCategory_CategoryUnlink_button:UpdateDisabled()
end

local function addOnCategoriesAreBaseCategories()
--d("[AC]addOnCategoriesAreBaseCategories")
    local sV = AddonCategory.savedVariables
    local sv_listCategories = sV.listCategory
    local default_listCategories = AddonCategory.defaultSV.listCategory
    if ZO_IsTableEmpty(sv_listCategories) or sv_listCategories == default_listCategories then return true end

    local sameCounter = 0
    local numEntries = #sv_listCategories

    for idx, categoryData in ipairs(sv_listCategories) do
        local defaultListCategoryData = default_listCategories[idx]
        if ( defaultListCategoryData ~= nil and categoryData ~= nil and
                (( defaultListCategoryData == categoryData )
                        or ( categoryData.uniqueKey == defaultListCategoryData.uniqueKey and categoryData.value == defaultListCategoryData.value and categoryData.text == defaultListCategoryData.text ))
        ) then
            sameCounter = sameCounter + 1
--[[
        else
            if defaultListCategoryData ~= nil then
d(">>uniqueKey: " .. tostring(categoryData.uniqueKey).."/"..tostring(defaultListCategoryData.uniqueKey) .. ", text: " .. tostring(categoryData.text).."/"..tostring(defaultListCategoryData.text) ..", value: " .. tostring(categoryData.value).."/"..tostring(defaultListCategoryData.value))
            end
]]
        end
    end
--d(">sameCounter: " ..tostring(sameCounter) .. ", numEntries: " .. tostring(numEntries))
    return sameCounter == numEntries
end

local function resetToBaseAddOnCategories()
    if addOnCategoriesAreBaseCategories() then return end
    --local sV = AddonCategory.savedVariables

    updateCurrentAddOnCategories(false)

    --Detect all currently assigned addOns in the SavedVariables and remove those from any category
    --[[
    for possibleAddOnName, possibleAddOnCategoryName in pairs(sV) do
        if not excludedSavedVars[possibleAddOnName] and type(possibleAddOnName) == "string" and type(possibleAddOnCategoryName) == "string" and isAddOnCategory(possibleAddOnCategoryName, false) == true then
            AddonCategory.savedVariables.addon2Category[possibleAddOnName] = nil
        end
    end
    ]]
    AddonCategory.savedVariables.addon2Category = {}

    --Rebuild the default SV categories (delete the current categories table in SV first so the the rebuild works!)
    AddonCategory.savedVariables.listCategory = {}
    AddonCategory.BuildDefaultSavedVars() --> Will fill in AddonCategory.defaultSV.listCategory if AddonCategory.savedVariables.listCategory is empty

    --Refresh the base categories -> Overwrite sV.listCategory with a copy of AddonCategory.defaultSV.listCategory
    AddonCategory.savedVariables.listCategory = ZO_ShallowTableCopy(AddonCategory.defaultSV.listCategory)

    --Refresh the assigned addons at the categories and reset them to the AddonCategory.addOnsAssignedToBaseCategories entries
    --[[
    baseCategories = AddonCategory.baseCategories
    for baseCategory, addOnsAssignedToBaseCategory in pairs(AddonCategory.addOnsAssignedToBaseCategories) do
        for _, addOnName in ipairs(addOnsAssignedToBaseCategory) do
            local addOnBaseCategoryName = baseCategories[baseCategory]
            if addOnBaseCategoryName ~= nil and addOnBaseCategoryName ~= "" then
                AddonCategory.savedVariables.addon2Category[addOnName] = addOnBaseCategoryName
            end
        end
    end
    ]]
    --Copy over the default assigned addons and their categories
    AddonCategory.savedVariables.addon2Category = ZO_ShallowTableCopy(AddonCategory.defaultSV.addon2Category)

    UpdateAllChoices()
    UpdateDisabledStateOfLinkCategoryButtons()
    AddonCategory_Addon_dropdown:UpdateValue()
end

local firstOpenOfLAMPanel = true
function AddonCategory.CreateSettingsWindow()
	local panelData = {
		type = "panel",
		name = "AddonCategory",
		displayName = "AddonCategory",
		author = AddonCategory.author,
		version = AddonCategory.version,
		slashCommand = "/addoncategory",
		registerForRefresh = true,
		registerForDefaults = false,
	}
    local addonCategoryLAMPanelName = "AddonCategory_Settings"

	AddonCategory.LAMsettingsPanel = LAM2:RegisterAddonPanel(addonCategoryLAMPanelName, panelData)
    local sV = AddonCategory.savedVariables

    local addon, category, newCategory, categoryName, newCategoryName, categoryOrder, newOrder, categoryIndex, categoryToChangeIndex
    --Call once here to init the tables
    updateNeededTables()


	local optionsData = {
		{
			type = "header",
			name = "Base categories",
		},
        {
            type = "checkbox",
            name = "Allow deletion of base categories",
            tooltip = "Enable this so you can delete the default/base categories from this addon too. Else you'll get an error message if you want to delete one of the base categories of the addon.",
            getFunc = function() return sV.allowDeleteBaseCategories end,
            setFunc = function(newValue)
                sV.allowDeleteBaseCategories = newValue
            end,
            --disabled = function() return false end,
			width = "full",
        },
        {
            type = "button",
            name = "Reset to base categories",
            tooltip = "Reset all your addon categories to the base categories again and unlink the linked addons\n(except the already linked base category addons).",
            func = function()
                resetToBaseAddOnCategories()
            end,
            warning = "THIS WILL RESET YOUR AddOn CATEGORIES TO THE DEFAULTs!\nIT WILL UNLINK ALL AddOns FROM YOUR CATEGORIES TOO!",
            isDangerous = true,
            disabled = function() return addOnCategoriesAreBaseCategories() end,
			width = "full",
        },
		{
			type = "header",
			name = "Categories",
		},
        {
            type    = "orderlistbox",
            name    = "Categories - Add/Remove/Order",
            tooltip = "Add, remove and change the order of the addon categories",
            listEntries = AddonCategory.savedVariables.listCategory,
            getFunc = function() return AddonCategory.savedVariables.listCategory end,
            setFunc = function(orderedList)
                AddonCategory.savedVariables.listCategory = orderedList
            end,
            minHeight = 100,
            maxHeight = 300,
            width = "full",
            isExtraWide = true,
            showPosition = true,
            disabled = function() return false end,
            default = AddonCategory.defaultSV.listCategory,
            addEntryDialog = {
                title="Add new category",
                text="Enter new category name here",
                textType=TEXT_TYPE_ALL,
                --buttonTexture="/esoui/art/buttons/minus_up.dds",
                --maxInputCharacters=3,
                --specialCharacters={"a", "b", "c"},
                --defaultText = "Default text",
                --instructions = ZO_ValidNameInstructions:New(GetControl(self, "NameInstructions"), nil, { NAME_RULE_TOO_SHORT, NAME_RULE_CANNOT_START_WITH_SPACE, NAME_RULE_MUST_END_WITH_LETTER })
                validatesText = true,
                validator = function(text) return text ~= nil and text ~= "" end
            },
            showRemoveEntryButton = true,
            askBeforeRemoveEntry = function() return true end,
            removeEntryCheckFunction = function(orderListBox, selectedIndex, orderListBoxData)
                return AddonCategory.DeleteCategoryCheckFunction(selectedIndex, false)
            end,
            removeEntryCallbackFunction = function(orderListBox, selectedEntry, orderListBoxData)
                if selectedEntry == nil then return false end
                --local selectedEntryIndex = selectedEntry.uniqueKey
                local selectedEntryCategoryName = selectedEntry.text
                AddonCategory.savedVariables.sectionsOpen[selectedEntryCategoryName] = nil
                if AddonCategory.indexCategories then
                    AddonCategory.indexCategories[selectedEntryCategoryName] = nil
                end

                categoryIndex         = nil
                categoryToChangeIndex = nil
                categoryName          = nil
                newCategoryName       = nil

                UpdateAllChoices()
                UpdateDisabledStateOfLinkCategoryButtons()
            end,
            addEntryCallbackFunction = function(orderListBox, newEntry, orderListBoxData)
                if newEntry == nil then return false end

                categoryIndex         = nil
                categoryToChangeIndex = nil
                categoryName          = nil
                newCategoryName       = nil

                --local newEntryIndex = newEntry.uniqueKey
                UpdateAllChoices()
                UpdateDisabledStateOfLinkCategoryButtons()
            end,
            reference = "AddonCategory_Categories_OrderListBox",
        },


		{
			type = "header",
			name = "Link AddOns to Category",
		},

        {
            type = "dropdown",
            name = "List Categories",
            tooltip = "List of the categories of addons you have.",
            choices = categoryList,
            choicesValues = categoryListIndex,
            default = 1,
            getFunc = function() return categoryIndex end,
            setFunc = function(selectedIndex)
                categoryIndex = selectedIndex
                categoryToChangeIndex = nil
            end,
            scrollable = true,
            width = "half",
            reference = "AddonCategory_Categories_dropdown",
        },

        {
            type = "dropdown",
            name = "List Addons",
            tooltip = "List of all of your non-library addons.",
            choices = addonsList,
            default = function() return addonsList ~= nil and addonsList[1] or nil end,
            getFunc = function() return addon end,
            setFunc = function(selected)
                for _, name in ipairs(addonsList) do
                    if name == selected then
                        addon = name
                        return
                    end
                end
            end,
            scrollable = true,
            width = "half",
            reference = "AddonCategory_Addon_dropdown",
        },
        {
            type = "button",
            name = "Select non linked",
            tooltip = "Select first addon installed non linked to a category.",
            func = function()
                for _, v in ipairs(AddonCategory.listNonAssigned) do
                    addon = v
                    break
                end
                AddonCategory_Addon_dropdown:UpdateValue()
            end,
            disabled = function() return #AddonCategory.listNonAssigned <= 0 end,
			width = "half",
            reference = "AddonCategory_AddonNonAssigned_button",
        },
        {
            type = "button",
            name = "Link Between",
            tooltip = "Link the selected addon with the selected category.",
            func = function()
                if addon ~= nil and categoryIndex ~= nil then
                    local l_categoryName = sV.listCategory[categoryIndex] ~= nil and sV.listCategory[categoryIndex].text or nil

                    categoryIndex         = nil
                    categoryToChangeIndex = nil
                    categoryName          = nil
                    newCategoryName       = nil

                    if l_categoryName ~= nil then
                        AddonCategory.savedVariables.addon2Category[addon] = l_categoryName
                        d("Addon |cFFFFFF" .. addon .. "|r linked to |cFFFFFF" .. l_categoryName .. "|r category.")

                        for i, v in ipairs(AddonCategory.listNonAssigned) do
                            if v == addon then
                                table.remove(AddonCategory.listNonAssigned, i)
                                addon = nil
                                AddonCategory_Addon_dropdown:UpdateValue()
                                break
                            end
                        end
                        --AddonCategory_AddonNonAssigned_button:UpdateDisabled() --Should auto update disabled state due to panel registerForRefresh = true
                    end
                end
            end,
			width = "half",
            disabled = function() return addon == nil or categoryIndex == nil end,
            reference = "AddonCategory_AddonLink_button"
        },
        {
            type = "button",
            name = "Reset selections",
            tooltip = "Reset all selected dropdowns in this section",
            func = function()
                addon                 = nil
                categoryIndex         = nil
                categoryToChangeIndex = nil
                categoryName          = nil
                newCategoryName       = nil
                AddonCategory_Addon_dropdown:UpdateValue()
            end,
            disabled = function() return addon == nil and categoryIndex == nil end,
            reference = "AddonCategory_AddonLinkResetAll_button"
        },

		{
			type = "header",
			name = "Unlink Addons from Category",
		},
		{
			type = "description",
			text = "Select a category at the \'List Categories\' dropdown above. You can only unassign all AddOns in that category here!\nIf you want to unlink single AddOns from the categories please visit the AddOn Manager and use the context-menu buttons directly at the category headlines.",
		},
        {
            type = "button",
            name = "Unlink category",
            tooltip = "Unlink the selected category from all AddOns.",
            func = function()
                local l_categoryName = sV.listCategory[categoryIndex].text
                AddonCategory.ShowUnassignAddonCategoryDialog(categoryIndex, l_categoryName, function(selectedIndex)
                    addon                 = nil
                    categoryIndex         = nil
                    categoryToChangeIndex = nil
                    categoryName          = nil
                    newCategoryName       = nil

                    UpdateAllChoices()
                    AddonCategory_Categories_OrderListBox:UpdateValue()

                    if AddonCategory.indexCategories then AddonCategory.indexCategories[l_categoryName] = nil end
                    --AddonCategory._debugSV_OLD = ZO_ShallowTableCopy(AddonCategory.savedVariables.listCategory)
                    UpdateDisabledStateOfLinkCategoryButtons()
                end)
            end,
            disabled = function()
                if categoryIndex == nil then return true end
                local l_categoryName = sV.listCategory[categoryIndex].text
                if l_categoryName ~= nil and checkIfAddonsInCategory(l_categoryName, true) == false then return true end
                return false
            end,
			width = "half",
            reference = "AddonCategory_CategoryUnlink_button",
        },

		{
			type = "header",
			name = "Edit Categories",
		},
        {
            type = "dropdown",
			name = "Choose Category",
			tooltip = "Choose a category to edit it's name.",
            choices = categoryList,
            choicesValues = categoryListIndex,
			default = 1,
			getFunc = function() return categoryToChangeIndex end,
			setFunc = function(indexToChange)
                categoryToChangeIndex = indexToChange
                categoryName = sV.listCategory[categoryToChangeIndex].text

                categoryIndex = nil
			end,
            scrollable = true,
			width = "half",
            reference = "AddonCategory_CategoriesName_dropdown",
        },
        {
            type = "editbox",
            name = "Category New Name",
            tooltip = "Enter here the new category's name you want.",
            getFunc = function() return nil end,
            setFunc = function(newValue)
                newCategoryName = nil
                if newValue ~= nil and newValue ~= "" and categoryName ~= nil and categoryName ~= "" and newValue ~= categoryName then
                    newCategoryName = newValue
                end
            end,
            disabled = function() return categoryToChangeIndex == nil end,
			width = "half",
        },
        {
            type = "button",
            name = "Change Name",
            tooltip = "Change the name of the selected category to the new one.",
            func = function()
                if categoryToChangeIndex ~= nil and categoryName ~= nil and newCategoryName ~= nil then
                    ChangeAddonCategoryName(categoryToChangeIndex, categoryName, newCategoryName)

                    categoryName = nil
                    newCategoryName = nil
                    categoryToChangeIndex = nil

                    UpdateAllChoices()
                end
            end,
            disabled = function() return categoryToChangeIndex == nil or categoryName == nil or categoryName == "" or newCategoryName == nil or newCategoryName == "" end,
        },
    }

	LAM2:RegisterOptionControls(addonCategoryLAMPanelName, optionsData)

    local function openedPanel(panel)
        if panel ~= AddonCategory.LAMsettingsPanel then return end
        if firstOpenOfLAMPanel == true then
            firstOpenOfLAMPanel = false
            return
        end
        UpdateAllChoices()
    end
    CALLBACK_MANAGER:RegisterCallback("LAM-PanelOpened", openedPanel)
end