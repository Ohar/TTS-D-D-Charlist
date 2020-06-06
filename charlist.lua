--[[    Character Sheet Template    by: MrStump
Customization Scripted_Sheet_DnD5e_PTv1_6 by: Nymeros
Global refactoring anf new features: Ohar

You can set up your own character sheet if you follow these steps.

Step 1) Change the character sheet image
    -Right click on the character sheet, click Custom
    -Replace the image URL with one for your character sheet
    -Click import, make sure your sheet loads
    -SAVE THE GAME (the table setup)
    -LOAD FROM THAT SAVE YOU JUST MADE

Step 2) Edit script to fit your character sheet
    -Below you will see some general options, and then the big data table
    -The data table is what determines how many of which buttons are made
        -Checkboxes
        -Counters
        -Textboxes
    -By default, there are 3 of each. You can add more or remove entries
    -If you intend to add/remove, be sure only to add/remove ENTRIES
        -This is what an entry looks like:
            {
                pos   = {-0.977,0.1,-0.589},
                size  = 800,
                state = false
            },
        -Deleting the whole thing would remove that specific item on the sheet
        -Copy and pasting it after another entry would create another
    -Each entry type has unique data points (pos, size, state, etc)
        -Do not try to add in your own data points or remove them individually
        -There is a summary of what each point does at the top of its category

Step 3) Save and check script changes
    -Hit Save & Apply in the script window to save your code
    -You can edit your code as needed and Save+Apply as often as needed
    -When you are finished, make disableSave = false below then Save+apply
        -This enables saving, so your sheet will remember whats on it.

Bonus) Finding/Editing Positions for elements
    I have included a tool to get positions for buttons in {x,y,z} form
    Place it where you want the center of your element to be
    Then copy the table from the notes (lower right of screen)
        You can highlight it and CTRL+C
    Paste it into the data table where needed (pos=)
    If you want to manually tweek the values:
        {0,0,0} is the center of the character sheet
        {1,0,0} is right, {-1,0,0} is left
        {0,0,-1} is up, {0,0,1} is down
        0.1 for Y is the height off of the page.
            If it was 0, it would be down inside the model of the sheet

Begin editing below:    ]]

--Set this to true while editing and false when you have finished
disableSave = false
--Remember to set this to false once you are done making changes
--Then, after you save & apply it, save your game too

--Color information for button text (r,g,b, values of 0-1)
buttonFontColor = {0,0,0}
--Color information for button background
buttonColor = {1,1,1}
--Change scale of button (Avoid changing if possible)
buttonScale = {0.1,0.1,0.1}

CHECKBOX_CHAR_FULL = string.char(10008)
CHECKBOX_CHAR_EMPTY = ''

LVL_BY_EXP = {
    {
        min = 0,
        max = 299,
        lvl = 1,
        proficiency = 2,
    },
    {
        min = 300,
        max = 899,
        lvl = 2,
        proficiency = 2,
    },
    {
        min = 900,
        max = 2699,
        lvl = 3,
        proficiency = 2,
    },
    {
        min = 2700,
        max = 6499,
        lvl = 4,
        proficiency = 2,
    },
    {
        min = 6500,
        max = 13999,
        lvl = 5,
        proficiency = 3,
    },
    {
        min = 14000,
        max = 22999,
        lvl = 6,
        proficiency = 3,
    },
    {
        min = 23000,
        max = 33999,
        lvl = 7,
        proficiency = 3,
    },
    {
        min = 34000,
        max = 47999,
        lvl = 8,
        proficiency = 3,
    },
    {
        min = 48000,
        max = 63999,
        lvl = 9,
        proficiency = 4,
    },
    {
        min = 64000,
        max = 84999,
        lvl = 10,
        proficiency = 4,
    },
    {
        min = 85000,
        max = 99999,
        lvl = 11,
        proficiency = 4,
    },
    {
        min = 100000,
        max = 119999,
        lvl = 12,
        proficiency = 4,
    },
    {
        min = 120000,
        max = 139999,
        lvl = 13,
        proficiency = 5,
    },
    {
        min = 140000,
        max = 164999,
        lvl = 14,
        proficiency = 5,
    },
    {
        min = 165000,
        max = 194999,
        lvl = 15,
        proficiency = 5,
    },
    {
        min = 195000,
        max = 224999,
        lvl = 16,
        proficiency = 5,
    },
    {
        min = 225000,
        max = 264999,
        lvl = 17,
        proficiency = 6,
    },
    {
        min = 265000,
        max = 304999,
        lvl = 18,
        proficiency = 6,
    },
    {
        min = 305000,
        max = 354999,
        lvl = 19,
        proficiency = 6,
    },
    {
        min = 355000,
        max = 355000,
        lvl = 20,
        proficiency = 6,
    },
}

EXP_MIN = LVL_BY_EXP[1].min
EXP_MAX = LVL_BY_EXP[#LVL_BY_EXP].max

local SKILL_ACROBATICS_ID = "Acrobatics"
local SKILL_ANIMAL_HANDLING_ID = "Animal_Handling"
local SKILL_ARCANA_ID = "Arcana"
local SKILL_ATHLETICS_ID = "Athletics"
local SKILL_CHA_SAVETHROW_ID = "CHA_savethrow"
local SKILL_CON_SAVETHROW_ID = "CON_savethrow"
local SKILL_DECEPTION_ID = "Deception"
local SKILL_DEX_SAVETHROW_ID = "DEX_savethrow"
local SKILL_HISTORY_ID = "History"
local SKILL_INSIGHT_ID = "Insight"
local SKILL_INT_SAVETHROW_ID = "INT_savethrow"
local SKILL_INTIMIDATION_ID = "Intimidation"
local SKILL_INVESTIGATION_ID = "Investigation"
local SKILL_MEDICINE_ID = "Medicine"
local SKILL_NATURE_ID = "Nature"
local SKILL_PERCEPTION_ID = "Perception"
local SKILL_PERFORMANCE_ID = "Performance"
local SKILL_PERSUASION_ID = "Persuasion"
local SKILL_RELIGION_ID = "Religion"
local SKILL_SLEIGHT_OF_HAND_ID = "Sleight_of_hand"
local SKILL_STEALTH_ID = "Stealth"
local SKILL_STR_SAVETHROW_ID = "STR_savethrow"
local SKILL_SURVIVAL_ID = "Survival"
local SKILL_WIT_SAVETHROW_ID = "WIT_savethrow"

local PARAM_CHA_ID = "CHA"
local PARAM_CON_ID = "CON"
local PARAM_DEX_ID = "DEX"
local PARAM_INT_ID = "INT"
local PARAM_STR_ID = "STR"
local PARAM_WIT_ID = "WIT"

local skillIdList = {
    SKILL_ACROBATICS_ID,
    SKILL_ANIMAL_HANDLING_ID,
    SKILL_ARCANA_ID,
    SKILL_ATHLETICS_ID,
    SKILL_CHA_SAVETHROW_ID,
    SKILL_CON_SAVETHROW_ID,
    SKILL_DECEPTION_ID,
    SKILL_DEX_SAVETHROW_ID,
    SKILL_HISTORY_ID,
    SKILL_INSIGHT_ID,
    SKILL_INT_SAVETHROW_ID,
    SKILL_INTIMIDATION_ID,
    SKILL_INVESTIGATION_ID,
    SKILL_MEDICINE_ID,
    SKILL_NATURE_ID,
    SKILL_PERCEPTION_ID,
    SKILL_PERFORMANCE_ID,
    SKILL_PERSUASION_ID,
    SKILL_RELIGION_ID,
    SKILL_SLEIGHT_OF_HAND_ID,
    SKILL_STEALTH_ID,
    SKILL_STR_SAVETHROW_ID,
    SKILL_SURVIVAL_ID,
    SKILL_WIT_SAVETHROW_ID,
}

local paramIdList = {
    PARAM_CHA_ID,
    PARAM_CON_ID,
    PARAM_DEX_ID,
    PARAM_INT_ID,
    PARAM_STR_ID,
    PARAM_WIT_ID,
}

local skillIdListByParamId = {
    [PARAM_CHA_ID] = {
        SKILL_CHA_SAVETHROW_ID,
        SKILL_DECEPTION_ID,
        SKILL_PERFORMANCE_ID,
        SKILL_PERSUASION_ID,
        SKILL_INTIMIDATION_ID,
    },
    [PARAM_CON_ID] = {
        SKILL_CON_SAVETHROW_ID,
    },
    [PARAM_DEX_ID] = {
        SKILL_DEX_SAVETHROW_ID,
        SKILL_ACROBATICS_ID,
        SKILL_SLEIGHT_OF_HAND_ID,
        SKILL_STEALTH_ID,
    },
    [PARAM_INT_ID] = {
        SKILL_INT_SAVETHROW_ID,
        SKILL_ARCANA_ID,
        SKILL_HISTORY_ID,
        SKILL_INVESTIGATION_ID,
        SKILL_NATURE_ID,
        SKILL_RELIGION_ID,
    },
    [PARAM_STR_ID] = {
        SKILL_STR_SAVETHROW_ID,
        SKILL_ATHLETICS_ID,
    },
    [PARAM_WIT_ID] = {
        SKILL_WIT_SAVETHROW_ID,
        SKILL_ANIMAL_HANDLING_ID,
        SKILL_INSIGHT_ID,
        SKILL_MEDICINE_ID,
        SKILL_PERCEPTION_ID,
        SKILL_SURVIVAL_ID,
    },
}

local paramIdBySkillId = {
    [SKILL_ACROBATICS_ID] = PARAM_DEX_ID,
    [SKILL_ANIMAL_HANDLING_ID] = PARAM_WIT_ID,
    [SKILL_ARCANA_ID] = PARAM_INT_ID,
    [SKILL_ATHLETICS_ID] = PARAM_STR_ID,
    [SKILL_CHA_SAVETHROW_ID] = PARAM_CHA_ID,
    [SKILL_CON_SAVETHROW_ID] = PARAM_CON_ID,
    [SKILL_DECEPTION_ID] = PARAM_CHA_ID,
    [SKILL_DEX_SAVETHROW_ID] = PARAM_DEX_ID,
    [SKILL_HISTORY_ID] = PARAM_INT_ID,
    [SKILL_INSIGHT_ID] = PARAM_WIT_ID,
    [SKILL_INT_SAVETHROW_ID] = PARAM_INT_ID,
    [SKILL_INTIMIDATION_ID] = PARAM_CHA_ID,
    [SKILL_INVESTIGATION_ID] = PARAM_INT_ID,
    [SKILL_MEDICINE_ID] = PARAM_WIT_ID,
    [SKILL_NATURE_ID] = PARAM_INT_ID,
    [SKILL_PERCEPTION_ID] = PARAM_WIT_ID,
    [SKILL_PERFORMANCE_ID] = PARAM_CHA_ID,
    [SKILL_PERSUASION_ID] = PARAM_CHA_ID,
    [SKILL_RELIGION_ID] = PARAM_INT_ID,
    [SKILL_SLEIGHT_OF_HAND_ID] = PARAM_DEX_ID,
    [SKILL_STEALTH_ID] = PARAM_DEX_ID,
    [SKILL_STR_SAVETHROW_ID] = PARAM_STR_ID,
    [SKILL_SURVIVAL_ID] = PARAM_WIT_ID,
    [SKILL_WIT_SAVETHROW_ID] = PARAM_WIT_ID,
}

local TEXTBOX_NAME_ID = "textbox_Name"
local TEXTBOX_CLASS_LEVEL_ID = "textbox_Class_Level"
local TEXTBOX_BACKGROUND_ID = "textbox_Background"
local TEXTBOX_PLAYERS_NAME_ID = "textbox_Players_name"
local TEXTBOX_RACE_ID = "textbox_Race"
local TEXTBOX_ALIGMENT_ID = "textbox_Aligment"
local TEXTBOX_XP_ID = "textbox_XP"
local TEXTBOX_DELETED_PROFICIENCY_ID = "textbox_DELETED_Proficiency"
local TEXTBOX_AGE_ID = "textbox_Age"
local TEXTBOX_AC_ID = "textbox_AC"
local TEXTBOX_HP_MAX_ID = "textbox_HP_max"
local TEXTBOX_HP_TEMPORARY_ID = "textbox_HP_temporary"
local TEXTBOX_HIT_DICES_ID = "textbox_Hit_Dices"
local TEXTBOX_INITIATIVE_ID = "textbox_Initiative"
local TEXTBOX_SPEED_ID = "textbox_Speed"
local TEXTBOX_VISION_ID = "textbox_Vision"
local TEXTBOX_CURRENT_HIT_POINTS_ID = "textbox_Current_Hit_Points"
local TEXTBOX_WEAPON_NAME_1_ID = "textbox_Weapon_Name_1"
local TEXTBOX_WEAPON_NAME_2_ID = "textbox_Weapon_Name_2"
local TEXTBOX_WEAPON_NAME_3_ID = "textbox_Weapon_Name_3"
local TEXTBOX_WEAPON_NAME_4_ID = "textbox_Weapon_Name_4"
local TEXTBOX_WEAPON_NAME_5_ID = "textbox_Weapon_Name_5"
local TEXTBOX_WEAPON_NAME_6_ID = "textbox_Weapon_Name_6"
local TEXTBOX_WEAPON_NAME_7_ID = "textbox_Weapon_Name_7"
local TEXTBOX_DAMAGE_1_ID = "textbox_Damage_1"
local TEXTBOX_DAMAGE_2_ID = "textbox_Damage_2"
local TEXTBOX_DAMAGE_3_ID = "textbox_Damage_3"
local TEXTBOX_DAMAGE_4_ID = "textbox_Damage_4"
local TEXTBOX_DAMAGE_5_ID = "textbox_Damage_5"
local TEXTBOX_DAMAGE_6_ID = "textbox_Damage_6"
local TEXTBOX_DAMAGE_7_ID = "textbox_Damage_7"
local TEXTBOX_DAMAGE_TYPE_1_ID = "textbox_Damage_Type_1"
local TEXTBOX_DAMAGE_TYPE_2_ID = "textbox_Damage_Type_2"
local TEXTBOX_DAMAGE_TYPE_3_ID = "textbox_Damage_Type_3"
local TEXTBOX_DAMAGE_TYPE_4_ID = "textbox_Damage_Type_4"
local TEXTBOX_DAMAGE_TYPE_5_ID = "textbox_Damage_Type_5"
local TEXTBOX_DAMAGE_TYPE_6_ID = "textbox_Damage_Type_6"
local TEXTBOX_DAMAGE_TYPE_7_ID = "textbox_Damage_Type_7"
local TEXTBOX_RANGE_1_ID = "textbox_Range_1"
local TEXTBOX_RANGE_2_ID = "textbox_Range_2"
local TEXTBOX_RANGE_3_ID = "textbox_Range_3"
local TEXTBOX_RANGE_4_ID = "textbox_Range_4"
local TEXTBOX_RANGE_5_ID = "textbox_Range_5"
local TEXTBOX_RANGE_6_ID = "textbox_Range_6"
local TEXTBOX_RANGE_7_ID = "textbox_Range_7"
local TEXTBOX_NOTES_1_ID = "textbox_Notes_1"
local TEXTBOX_NOTES_2_ID = "textbox_Notes_2"
local TEXTBOX_NOTES_3_ID = "textbox_Notes_3"
local TEXTBOX_NOTES_4_ID = "textbox_Notes_4"
local TEXTBOX_NOTES_5_ID = "textbox_Notes_5"
local TEXTBOX_NOTES_6_ID = "textbox_Notes_6"
local TEXTBOX_NOTES_7_ID = "textbox_Notes_7"
local TEXTBOX_COPPER_COINS_ID = "textbox_Copper_coins"
local TEXTBOX_SILVER_COINS_ID = "textbox_Silver_coins"
local TEXTBOX_ELECTRUM_COINS_ID = "textbox_Electrum_coins"
local TEXTBOX_GOLD_COINS_ID = "textbox_Gold_coins"
local TEXTBOX_PLATINUM_COINS_ID = "textbox_Platinum_coins"
local TEXTBOX_EQUIPMENT_1_ID = "textbox_Equipment_1"
local TEXTBOX_EQUIPMENT_2_ID = "textbox_Equipment_2"
local TEXTBOX_CLASS_RACE_CHARACTERISTICS_ID = "textbox_Class_Race_Characteristics"
local TEXTBOX_HEIGHT_ID = "textbox_Height"
local TEXTBOX_WEIGHT_ID = "textbox_Weight"
local TEXTBOX_PROFICIENCY_3_ID = "textbox_Proficiency_3"
local TEXTBOX_REMOVED_JUMP_DISTANCE_ID = "textbox_REMOVED_Jump_Distance"
local TEXTBOX_REMOVED_JUMP_HEIGHT_ID = "textbox_REMOVED_Jump_Height"
local TEXTBOX_REMOVED_WEIGHT_ID = "textbox_REMOVED_Weight"
local TEXTBOX_REMOVED_RAISE_LIFT_PULL_ID = "textbox_REMOVED_Raise_Lift_Pull"
local TEXTBOX_SKILL_STR_SAVETHROW_ID = "textbox_"..SKILL_STR_SAVETHROW_ID
local TEXTBOX_SKILL_ATHLETICS_ID = "textbox_"..SKILL_ATHLETICS_ID
local TEXTBOX_SKILL_DEX_SAVETHROW_ID = "textbox_"..SKILL_DEX_SAVETHROW_ID
local TEXTBOX_SKILL_ACROBATICS_ID = "textbox_"..SKILL_ACROBATICS_ID
local TEXTBOX_SKILL_STEALTH_ID = "textbox_"..SKILL_STEALTH_ID
local TEXTBOX_SKILL_SLEIGHT_OF_HAND_ID = "textbox_"..SKILL_SLEIGHT_OF_HAND_ID
local TEXTBOX_SKILL_CON_SAVETHROW_ID = "textbox_"..SKILL_CON_SAVETHROW_ID
local TEXTBOX_SKILL_INT_SAVETHROW_ID = "textbox_"..SKILL_INT_SAVETHROW_ID
local TEXTBOX_SKILL_ARCANA_ID = "textbox_"..SKILL_ARCANA_ID
local TEXTBOX_SKILL_HISTORY_ID = "textbox_"..SKILL_HISTORY_ID
local TEXTBOX_SKILL_INVESTIGATION_ID = "textbox_"..SKILL_INVESTIGATION_ID
local TEXTBOX_SKILL_NATURE_ID = "textbox_"..SKILL_NATURE_ID
local TEXTBOX_SKILL_RELIGION_ID = "textbox_"..SKILL_RELIGION_ID
local TEXTBOX_SKILL_WIT_SAVETHROW_ID = "textbox_"..SKILL_WIT_SAVETHROW_ID
local TEXTBOX_SKILL_ANIMAL_HANDLING_ID = "textbox_"..SKILL_ANIMAL_HANDLING_ID
local TEXTBOX_SKILL_INSIGHT_ID = "textbox_"..SKILL_INSIGHT_ID
local TEXTBOX_SKILL_MEDICINE_ID = "textbox_"..SKILL_MEDICINE_ID
local TEXTBOX_SKILL_PERCEPTION_ID = "textbox_"..SKILL_PERCEPTION_ID
local TEXTBOX_SKILL_SURVIVAL_ID = "textbox_"..SKILL_SURVIVAL_ID
local TEXTBOX_SKILL_CHA_SAVETHROW_ID = "textbox_"..SKILL_CHA_SAVETHROW_ID
local TEXTBOX_SKILL_PERFORMANCE_ID = "textbox_"..SKILL_PERFORMANCE_ID
local TEXTBOX_SKILL_DECEPTION_ID = "textbox_"..SKILL_DECEPTION_ID
local TEXTBOX_SKILL_INTIMIDATION_ID = "textbox_"..SKILL_INTIMIDATION_ID
local TEXTBOX_SKILL_PERSUASION_ID = "textbox_"..SKILL_PERSUASION_ID

local CHECKBOX_SKILL_STR_SAVETHROW_ID = "checkbox_"..SKILL_STR_SAVETHROW_ID
local CHECKBOX_SKILL_ATHLETICS_ID = "checkbox_"..SKILL_ATHLETICS_ID
local CHECKBOX_SKILL_DEX_SAVETHROW_ID = "checkbox_"..SKILL_DEX_SAVETHROW_ID
local CHECKBOX_SKILL_ACROBATICS_ID = "checkbox_"..SKILL_ACROBATICS_ID
local CHECKBOX_SKILL_STEALTH_ID = "checkbox_"..SKILL_STEALTH_ID
local CHECKBOX_SKILL_SLEIGHT_OF_HAND_ID = "checkbox_"..SKILL_SLEIGHT_OF_HAND_ID
local CHECKBOX_SKILL_CON_SAVETHROW_ID = "checkbox_"..SKILL_CON_SAVETHROW_ID
local CHECKBOX_SKILL_INT_SAVETHROW_ID = "checkbox_"..SKILL_INT_SAVETHROW_ID
local CHECKBOX_SKILL_ARCANA_ID = "checkbox_"..SKILL_ARCANA_ID
local CHECKBOX_SKILL_HISTORY_ID = "checkbox_"..SKILL_HISTORY_ID
local CHECKBOX_SKILL_INVESTIGATION_ID = "checkbox_"..SKILL_INVESTIGATION_ID
local CHECKBOX_SKILL_NATURE_ID = "checkbox_"..SKILL_NATURE_ID
local CHECKBOX_SKILL_RELIGION_ID = "checkbox_"..SKILL_RELIGION_ID
local CHECKBOX_SKILL_WIT_SAVETHROW_ID = "checkbox_"..SKILL_WIT_SAVETHROW_ID
local CHECKBOX_SKILL_ANIMAL_HANDLING_ID = "checkbox_"..SKILL_ANIMAL_HANDLING_ID
local CHECKBOX_SKILL_INSIGHT_ID = "checkbox_"..SKILL_INSIGHT_ID
local CHECKBOX_SKILL_MEDICINE_ID = "checkbox_"..SKILL_MEDICINE_ID
local CHECKBOX_SKILL_PERCEPTION_ID = "checkbox_"..SKILL_PERCEPTION_ID
local CHECKBOX_SKILL_SURVIVAL_ID = "checkbox_"..SKILL_SURVIVAL_ID
local CHECKBOX_SKILL_CHA_SAVETHROW_ID = "checkbox_"..SKILL_CHA_SAVETHROW_ID
local CHECKBOX_SKILL_PERFORMANCE_ID = "checkbox_"..SKILL_PERFORMANCE_ID
local CHECKBOX_SKILL_DECEPTION_ID = "checkbox_"..SKILL_DECEPTION_ID
local CHECKBOX_SKILL_INTIMIDATION_ID = "checkbox_"..SKILL_INTIMIDATION_ID
local CHECKBOX_SKILL_PERSUASION_ID = "checkbox_"..SKILL_PERSUASION_ID
local CHECKBOX_LIGHT_ARMOR_ID = "checkbox_Light_Armor"
local CHECKBOX_MEDIUM_ARMOR_ID = "checkbox_Medium_Armor"
local CHECKBOX_HEAVY_ARMOR_ID = "checkbox_Heavy_Armor"
local CHECKBOX_SHIELD_ID = "checkbox_Shield"
local CHECKBOX_SIMPLE_WEAPONS_ID = "checkbox_Simple_Weapons"
local CHECKBOX_MARTIAL_WEAPONS_ID = "checkbox_Martial_Weapons"
local CHECKBOX_DEATH_SAVETHROW_SUCCESS_1_ID = "checkbox_Death_savethrow_success_1"
local CHECKBOX_DEATH_SAVETHROW_SUCCESS_2_ID = "checkbox_Death_savethrow_success_2"
local CHECKBOX_DEATH_SAVETHROW_SUCCESS_3_ID = "checkbox_Death_savethrow_success_3"
local CHECKBOX_DEATH_SAVETHROW_FAIL_1_ID = "checkbox_Death_savethrow_fail_1"
local CHECKBOX_DEATH_SAVETHROW_FAIL_2_ID = "checkbox_Death_savethrow_fail_2"
local CHECKBOX_DEATH_SAVETHROW_FAIL_3_ID = "checkbox_Death_savethrow_fail_3"

local COUNTER_PARAM_STR_ID = "counter_"..PARAM_STR_ID
local COUNTER_PARAM_DEX_ID = "counter_"..PARAM_DEX_ID
local COUNTER_PARAM_CON_ID = "counter_"..PARAM_CON_ID
local COUNTER_PARAM_INT_ID = "counter_"..PARAM_INT_ID
local COUNTER_PARAM_WIT_ID = "counter_"..PARAM_WIT_ID
local COUNTER_PARAM_CHA_ID = "counter_"..PARAM_CHA_ID

local DISPLAY_PARAM_STR_ID = "display_"..PARAM_STR_ID
local DISPLAY_PARAM_DEX_ID = "display_"..PARAM_DEX_ID
local DISPLAY_PARAM_CON_ID = "display_"..PARAM_CON_ID
local DISPLAY_PARAM_INT_ID = "display_"..PARAM_INT_ID
local DISPLAY_PARAM_WIT_ID = "display_"..PARAM_WIT_ID
local DISPLAY_PARAM_CHA_ID = "display_"..PARAM_CHA_ID
local DISPLAY_SKILL_STR_SAVETHROW_ID = "display_"..SKILL_STR_SAVETHROW_ID
local DISPLAY_SKILL_ATHLETICS_ID = "display_"..SKILL_ATHLETICS_ID
local DISPLAY_SKILL_DEX_SAVETHROW_ID = "display_"..SKILL_DEX_SAVETHROW_ID
local DISPLAY_SKILL_ACROBATICS_ID = "display_"..SKILL_ACROBATICS_ID
local DISPLAY_SKILL_STEALTH_ID = "display_"..SKILL_STEALTH_ID
local DISPLAY_SKILL_SLEIGHT_OF_HAND_ID = "display_"..SKILL_SLEIGHT_OF_HAND_ID
local DISPLAY_SKILL_CON_SAVETHROW_ID = "display_"..SKILL_CON_SAVETHROW_ID
local DISPLAY_SKILL_INT_SAVETHROW_ID = "display_"..SKILL_INT_SAVETHROW_ID
local DISPLAY_SKILL_ARCANA_ID = "display_"..SKILL_ARCANA_ID
local DISPLAY_SKILL_HISTORY_ID = "display_"..SKILL_HISTORY_ID
local DISPLAY_SKILL_INVESTIGATION_ID = "display_"..SKILL_INVESTIGATION_ID
local DISPLAY_SKILL_NATURE_ID = "display_"..SKILL_NATURE_ID
local DISPLAY_SKILL_RELIGION_ID = "display_"..SKILL_RELIGION_ID
local DISPLAY_SKILL_WIT_SAVETHROW_ID = "display_"..SKILL_WIT_SAVETHROW_ID
local DISPLAY_SKILL_ANIMAL_HANDLING_ID = "display_"..SKILL_ANIMAL_HANDLING_ID
local DISPLAY_SKILL_INSIGHT_ID = "display_"..SKILL_INSIGHT_ID
local DISPLAY_SKILL_MEDICINE_ID = "display_"..SKILL_MEDICINE_ID
local DISPLAY_SKILL_PERCEPTION_ID = "display_"..SKILL_PERCEPTION_ID
local DISPLAY_SKILL_SURVIVAL_ID = "display_"..SKILL_SURVIVAL_ID
local DISPLAY_SKILL_CHA_SAVETHROW_ID = "display_"..SKILL_CHA_SAVETHROW_ID
local DISPLAY_SKILL_PERFORMANCE_ID = "display_"..SKILL_PERFORMANCE_ID
local DISPLAY_SKILL_DECEPTION_ID = "display_"..SKILL_DECEPTION_ID
local DISPLAY_SKILL_INTIMIDATION_ID = "display_"..SKILL_INTIMIDATION_ID
local DISPLAY_SKILL_PERSUASION_ID = "display_"..SKILL_PERSUASION_ID
local DISPLAY_PASSIVE_PERCEPTION_ID = "display_Passive_Perception"
local DISPLAY_WEIGHT_CAPACITY_ID = "display_Weight_Capacity"
local DISPLAY_RAISE_LIFT_AND_PULL_ID = "display_Raise_Lift_and_Pull"
local DISPLAY_JUMP_HEIGHT_ID = "display_Jump_Height"
local DISPLAY_JUMP_DISTANCE_ID = "display_Jump_Distance"
local DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID = "display_Jump_Height_with_Hands"
local DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID = "display_Jump_Height_no_running"
local DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID = "display_Jump_Distance_no_running"
local DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID = "display_Jump_Height_with_Hands_no_running"
local DISPLAY_LEVEL_ID = "display_Level"
local DISPLAY_NEXT_LVL_ID = "display_next_LVL"
local DISPLAY_PROFICIENCY_ID = "display_Proficiency"
local DISPLAY_HIT_DICES_LEFT_ID = "display_Hit_Dices_Left"

local textboxLabelCollection = {
    [TEXTBOX_NAME_ID] = "Имя персонажа",
    [TEXTBOX_CLASS_LEVEL_ID] = "Класс",
    [TEXTBOX_BACKGROUND_ID] = "Предыстория",
    [TEXTBOX_PLAYERS_NAME_ID] = "Имя игрока",
    [TEXTBOX_RACE_ID] = "Раса",
    [TEXTBOX_ALIGMENT_ID] = "Мировоззрение",
    [TEXTBOX_XP_ID] = "Опыт",
    [TEXTBOX_DELETED_PROFICIENCY_ID] = "",
    [TEXTBOX_AGE_ID] = "Возраст",
    [TEXTBOX_AC_ID] = "KД",
    [TEXTBOX_HP_MAX_ID] = "",
    [TEXTBOX_HP_TEMPORARY_ID] = "",
    [TEXTBOX_HIT_DICES_ID] = "",
    [TEXTBOX_INITIATIVE_ID] = "+0",
    [TEXTBOX_SPEED_ID] = "",
    [TEXTBOX_VISION_ID] = "обычное",
    [TEXTBOX_CURRENT_HIT_POINTS_ID] = "",
    [TEXTBOX_WEAPON_NAME_1_ID] = "",
    [TEXTBOX_WEAPON_NAME_2_ID] = "",
    [TEXTBOX_WEAPON_NAME_3_ID] = "",
    [TEXTBOX_WEAPON_NAME_4_ID] = "",
    [TEXTBOX_WEAPON_NAME_5_ID] = "",
    [TEXTBOX_WEAPON_NAME_6_ID] = "",
    [TEXTBOX_WEAPON_NAME_7_ID] = "",
    [TEXTBOX_DAMAGE_1_ID] = "",
    [TEXTBOX_DAMAGE_2_ID] = "",
    [TEXTBOX_DAMAGE_3_ID] = "",
    [TEXTBOX_DAMAGE_4_ID] = "",
    [TEXTBOX_DAMAGE_5_ID] = "",
    [TEXTBOX_DAMAGE_6_ID] = "",
    [TEXTBOX_DAMAGE_7_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_1_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_2_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_3_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_4_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_5_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_6_ID] = "",
    [TEXTBOX_DAMAGE_TYPE_7_ID] = "",
    [TEXTBOX_RANGE_1_ID] = "",
    [TEXTBOX_RANGE_2_ID] = "",
    [TEXTBOX_RANGE_3_ID] = "",
    [TEXTBOX_RANGE_4_ID] = "",
    [TEXTBOX_RANGE_5_ID] = "",
    [TEXTBOX_RANGE_6_ID] = "",
    [TEXTBOX_RANGE_7_ID] = "",
    [TEXTBOX_NOTES_1_ID] = "",
    [TEXTBOX_NOTES_2_ID] = "",
    [TEXTBOX_NOTES_3_ID] = "",
    [TEXTBOX_NOTES_4_ID] = "",
    [TEXTBOX_NOTES_5_ID] = "",
    [TEXTBOX_NOTES_6_ID] = "",
    [TEXTBOX_NOTES_7_ID] = "",
    [TEXTBOX_COPPER_COINS_ID] = "0",
    [TEXTBOX_SILVER_COINS_ID] = "0",
    [TEXTBOX_ELECTRUM_COINS_ID] = "0",
    [TEXTBOX_GOLD_COINS_ID] = "0",
    [TEXTBOX_PLATINUM_COINS_ID] = "0",
    [TEXTBOX_EQUIPMENT_1_ID] = "",
    [TEXTBOX_EQUIPMENT_2_ID] = "",
    [TEXTBOX_CLASS_RACE_CHARACTERISTICS_ID] = "",
    [TEXTBOX_HEIGHT_ID] = "Рост",
    [TEXTBOX_WEIGHT_ID] = "Вес",
    [TEXTBOX_PROFICIENCY_3_ID] = "",
    [TEXTBOX_REMOVED_JUMP_DISTANCE_ID] = "",
    [TEXTBOX_REMOVED_JUMP_HEIGHT_ID] = "",
    [TEXTBOX_REMOVED_WEIGHT_ID] = "",
    [TEXTBOX_REMOVED_RAISE_LIFT_PULL_ID] = "",
    [TEXTBOX_SKILL_STR_SAVETHROW_ID] = "",
    [TEXTBOX_SKILL_ATHLETICS_ID] = "",
    [TEXTBOX_SKILL_DEX_SAVETHROW_ID] = "",
    [TEXTBOX_SKILL_ACROBATICS_ID] = "",
    [TEXTBOX_SKILL_STEALTH_ID] = "",
    [TEXTBOX_SKILL_SLEIGHT_OF_HAND_ID] = "",
    [TEXTBOX_SKILL_CON_SAVETHROW_ID] = "",
    [TEXTBOX_SKILL_INT_SAVETHROW_ID] = "",
    [TEXTBOX_SKILL_ARCANA_ID] = "",
    [TEXTBOX_SKILL_HISTORY_ID] = "",
    [TEXTBOX_SKILL_INVESTIGATION_ID] = "",
    [TEXTBOX_SKILL_NATURE_ID] = "",
    [TEXTBOX_SKILL_RELIGION_ID] = "",
    [TEXTBOX_SKILL_WIT_SAVETHROW_ID] = "",
    [TEXTBOX_SKILL_ANIMAL_HANDLING_ID] = "",
    [TEXTBOX_SKILL_INSIGHT_ID] = "",
    [TEXTBOX_SKILL_MEDICINE_ID] = "",
    [TEXTBOX_SKILL_PERCEPTION_ID] = "",
    [TEXTBOX_SKILL_SURVIVAL_ID] = "",
    [TEXTBOX_SKILL_CHA_SAVETHROW_ID] = "",
    [TEXTBOX_SKILL_PERFORMANCE_ID] = "",
    [TEXTBOX_SKILL_DECEPTION_ID] = "",
    [TEXTBOX_SKILL_INTIMIDATION_ID] = "",
    [TEXTBOX_SKILL_PERSUASION_ID] = "",
}

local btnIndexByElementIdTable = {}

--This is the button placement information
defaultButtonData = {
    --Add checkboxes
    checkbox = {
        --[[
        pos   = the position (pasted from the helper tool)
        size  = height/width/font_size for checkbox
        state = default starting value for checkbox (true=checked, false=not)
        ]]
        -- 1 checkbox STR savethrow
        [CHECKBOX_SKILL_STR_SAVETHROW_ID] = {
            skillId = SKILL_STR_SAVETHROW_ID,
            pos     = {-1.123,0.1,-1.155},
            size    = 150,
            state   = false
        },
        -- 2 checkbox Athletics
        [CHECKBOX_SKILL_ATHLETICS_ID] = {
            skillId = SKILL_ATHLETICS_ID,
            pos     = {-1.123,0.1,-1.10},
            size    = 150,
            state   = false
        },
        -- 3 checkbox DEX savethrow
        [CHECKBOX_SKILL_DEX_SAVETHROW_ID] = {
            skillId = SKILL_DEX_SAVETHROW_ID,
            pos     = {-1.123,0.1,-0.79},
            size    = 150,
            state   = false
        },
        -- 4 checkbox Acrobatics
        [CHECKBOX_SKILL_ACROBATICS_ID] = {
            skillId = SKILL_ACROBATICS_ID,
            pos     = {-1.123,0.1,-0.735},
            size    = 150,
            state   = false
        },
        -- 5 checkbox Stealth
        [CHECKBOX_SKILL_STEALTH_ID] = {
            skillId = SKILL_STEALTH_ID,
            pos     = {-1.123,0.1,-0.685},
            size    = 150,
            state   = false
        },
        -- 6 checkbox Sleight of hand
        [CHECKBOX_SKILL_SLEIGHT_OF_HAND_ID] = {
            skillId = SKILL_SLEIGHT_OF_HAND_ID,
            pos     = {-1.123,0.1,-0.630},
            size    = 150,
            state   = false
        },
        -- 7 checkbox CON savethrow
        [CHECKBOX_SKILL_CON_SAVETHROW_ID] = {
            skillId = SKILL_CON_SAVETHROW_ID,
            pos     = {-1.123,0.1,-0.428},
            size    = 150,
            state   = false
        },
        -- 8 checkbox INT savethrow
        [CHECKBOX_SKILL_INT_SAVETHROW_ID] = {
            skillId = SKILL_INT_SAVETHROW_ID,
            pos     = {-1.123,0.1,-0.070},
            size    = 150,
            state   = false
        },
        -- 9 checkbox Arcana
        [CHECKBOX_SKILL_ARCANA_ID] = {
            skillId = SKILL_ARCANA_ID,
            pos     = {-1.123,0.1,-0.015},
            size    = 150,
            state   = false
        },
        -- 10 checkbox History
        [CHECKBOX_SKILL_HISTORY_ID] = {
            skillId = SKILL_HISTORY_ID,
            pos     = {-1.123,0.1,0.040},
            size    = 150,
            state   = false
        },
        -- 11 checkbox Investigation
        [CHECKBOX_SKILL_INVESTIGATION_ID] = {
            skillId = SKILL_INVESTIGATION_ID,
            pos     = {-1.123,0.1,0.095},
            size    = 150,
            state   = false
        },
        -- 12 checkbox Nature
        [CHECKBOX_SKILL_NATURE_ID] = {
            skillId = SKILL_NATURE_ID,
            pos     = {-1.123,0.1,0.150},
            size    = 150,
            state   = false
        },
        -- 13 checkbox Religion
        [CHECKBOX_SKILL_RELIGION_ID] = {
            skillId = SKILL_RELIGION_ID,
            pos     = {-1.123,0.1,0.202},
            size    = 150,
            state   = false
        },
        -- 14 checkbox WIT savethrow
        [CHECKBOX_SKILL_WIT_SAVETHROW_ID] = {
            skillId = SKILL_WIT_SAVETHROW_ID,
            pos     = {-1.123,0.1,0.30},
            size    = 150,
            state   = false
        },
        -- 15 checkbox Animal Handling
        [CHECKBOX_SKILL_ANIMAL_HANDLING_ID] = {
            skillId = SKILL_ANIMAL_HANDLING_ID,
            pos     = {-1.123,0.1,0.355},
            size    = 150,
            state   = false
        },
        -- 16 checkbox Insight
        [CHECKBOX_SKILL_INSIGHT_ID] = {
            skillId = SKILL_INSIGHT_ID,
            pos     = {-1.123,0.1,0.410},
            size    = 150,
            state   = false
        },
        -- 17 checkbox Medicine
        [CHECKBOX_SKILL_MEDICINE_ID] = {
            skillId = SKILL_MEDICINE_ID,
            pos     = {-1.123,0.1,0.46},
            size    = 150,
            state   = false
        },
        -- 18 checkbox Perception
        [CHECKBOX_SKILL_PERCEPTION_ID] = {
            skillId = SKILL_PERCEPTION_ID,
            pos     = {-1.123,0.1,0.51},
            size    = 150,
            state   = false
        },
        -- 19 checkbox Survival
        [CHECKBOX_SKILL_SURVIVAL_ID] = {
            skillId = SKILL_SURVIVAL_ID,
            pos     = {-1.123,0.1,0.565},
            size    = 150,
            state   = false
        },
        -- 20 checkbox CHA savethrow
        [CHECKBOX_SKILL_CHA_SAVETHROW_ID] = {
            skillId = SKILL_CHA_SAVETHROW_ID,
            pos     = {-1.123,0.1,0.67},
            size    = 150,
            state   = false
        },
        -- 21 checkbox Performance
        [CHECKBOX_SKILL_PERFORMANCE_ID] = {
            skillId = SKILL_PERFORMANCE_ID,
            pos     = {-1.123,0.1,0.725},
            size    = 150,
            state   = false
        },
        -- 22 checkbox Deception
        [CHECKBOX_SKILL_DECEPTION_ID] = {
            skillId = SKILL_DECEPTION_ID,
            pos     = {-1.123,0.1,0.775},
            size    = 150,
            state   = false
        },
        -- 23 checkbox Intimidation
        [CHECKBOX_SKILL_INTIMIDATION_ID] = {
            skillId = SKILL_INTIMIDATION_ID,
            pos     = {-1.123,0.1,0.82},
            size    = 150,
            state   = false
        },
        -- 24 checkbox Persuasion
        [CHECKBOX_SKILL_PERSUASION_ID] = {
            skillId = SKILL_PERSUASION_ID,
            pos     = {-1.123,0.1,0.875},
            size    = 150,
            state   = false
        },
        -- 25 checkbox Light Armor
        [CHECKBOX_LIGHT_ARMOR_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.26},
            size    = 150,
            state   = false
        },
        -- 26 checkbox Medium Armor
        [CHECKBOX_MEDIUM_ARMOR_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.30},
            size    = 150,
            state   = false
        },
        -- 27 checkbox Heavy Armor
        [CHECKBOX_HEAVY_ARMOR_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.34},
            size    = 150,
            state   = false
        },
        -- 28 checkbox Shield
        [CHECKBOX_SHIELD_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.38},
            size    = 150,
            state   = false
        },
        -- 29 checkbox Simple Weapons
        [CHECKBOX_SIMPLE_WEAPONS_ID] = {
            skillId = nil,
            pos     = {-1.2,0.1,1.26},
            size    = 150,
            state   = false
        },
        -- 30 checkbox Martial Weapons
        [CHECKBOX_MARTIAL_WEAPONS_ID] = {
            skillId = nil,
            pos     = {-1.2,0.1,1.30},
            size    = 150,
            state   = false
        },
        -- 31 checkbox Death savethrow success 1
        [CHECKBOX_DEATH_SAVETHROW_SUCCESS_1_ID] = {
            skillId = nil,
            pos     = {0.825,0.1,-1.08},
            size    = 200,
            state   = false
        },
        -- 32 checkbox Death savethrow success 2
        [CHECKBOX_DEATH_SAVETHROW_SUCCESS_2_ID] = {
            skillId = nil,
            pos     = {0.895,0.1,-1.08},
            size    = 200,
            state   = false
        },
        -- 33 checkbox Death savethrow success 3
        [CHECKBOX_DEATH_SAVETHROW_SUCCESS_3_ID] = {
            skillId = nil,
            pos     = {0.96,0.1,-1.08},
            size    = 200,
            state   = false
        },
        -- 34 checkbox Death savethrow fail 1
        [CHECKBOX_DEATH_SAVETHROW_FAIL_1_ID] = {
            skillId = nil,
            pos     = {0.825,0.1,-1.015},
            size    = 200,
            state   = false
        },
        -- 35 checkbox Death savethrow fail 2
        [CHECKBOX_DEATH_SAVETHROW_FAIL_2_ID] = {
            skillId = nil,
            pos     = {0.895,0.1,-1.015},
            size    = 200,
            state   = false
        },
        -- 36 checkbox Death savethrow fail 3
        [CHECKBOX_DEATH_SAVETHROW_FAIL_3_ID] = {
            skillId = nil,
            pos     = {0.96,0.1,-1.015},
            size    = 200,
            state   = false
        },
        --End of checkboxes
    },
    --Add counters that have a + and - button
    counter = {
        --[[
        pos    = the position (pasted from the helper tool)
        size   = height/width/font_size for counter
        value  = default starting value for counter
        hideBG = if background of counter is hidden (true=hidden, false=not)
        ]]
        -- tableIndex Atributo {1 to 6} // 5 = Sabedoria
        -- buttonIndex Atributo {36 to 53} // 48 = Sabedoria

        -- 1 counter STR
        [COUNTER_PARAM_STR_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_STR_ID,
            btnSubId = "counter_btn_sub_"..PARAM_STR_ID,
            hideBG   = true,
            paramId  = PARAM_STR_ID,
            pos      = {-1.35,0.1,-1.025},
            size     = 450,
            value    = 10,
        },
        -- 2 counter DEX
        [COUNTER_PARAM_DEX_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_DEX_ID,
            btnSubId = "counter_btn_sub_"..PARAM_DEX_ID,
            hideBG   = true,
            paramId  = PARAM_DEX_ID,
            pos      = {-1.35,0.1,-0.662},
            size     = 450,
            value    = 10,
        },
        -- 3 counter CON
        [COUNTER_PARAM_CON_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_CON_ID,
            btnSubId = "counter_btn_sub_"..PARAM_CON_ID,
            hideBG   = true,
            paramId  = PARAM_CON_ID,
            pos      = {-1.35,0.1,-0.299},
            size     = 450,
            value    = 10,
        },
        -- 4 counter INT
        [COUNTER_PARAM_INT_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_INT_ID,
            btnSubId = "counter_btn_sub_"..PARAM_INT_ID,
            hideBG   = true,
            paramId  = PARAM_INT_ID,
            pos      = {-1.35,0.1,0.064},
            size     = 450,
            value    = 10,
        },
        -- 5 counter WIT
        [COUNTER_PARAM_WIT_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_WIT_ID,
            btnSubId = "counter_btn_sub_"..PARAM_WIT_ID,
            hideBG   = true,
            paramId  = PARAM_WIT_ID,
            pos      = {-1.35,0.1,0.427},
            size     = 450,
            value    = 10,
        },
        -- 6 counter CHA
        [COUNTER_PARAM_CHA_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_CHA_ID,
            btnSubId = "counter_btn_sub_"..PARAM_CHA_ID,
            hideBG   = true,
            paramId  = PARAM_CHA_ID,
            pos      = {-1.35,0.1,0.790},
            size     = 450,
            value    = 10,
        },

        --End of counters
    },
    --Add display
    display = {
        --[[
        pos    = the position (pasted from the helper tool)
        size   = height/width/font_size for counter
        value  = default starting value for counter
        hideBG = if background of counter is hidden (true=hidden, false=not)
        ]]
        -- TableIndex of buttonEdit of 1 to 31
        -- ButtonIndex Modificador Atributo {54 Até 60} // Perícia {61 to 84} // Passive Perception = 85
        -- 1 display STR
        [DISPLAY_PARAM_STR_ID] = {
            paramId = PARAM_STR_ID,
            pos     = {-1.35,0.1,-1.14},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        -- 2 display DEX
        [DISPLAY_PARAM_DEX_ID] = {
            paramId = PARAM_DEX_ID,
            pos     = {-1.35,0.1,-0.77},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        -- 3 display CON
        [DISPLAY_PARAM_CON_ID] = {
            paramId = PARAM_CON_ID,
            pos     = {-1.35,0.1,-0.41},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        -- 4 display INT
        [DISPLAY_PARAM_INT_ID] = {
            paramId = PARAM_INT_ID,
            pos     = {-1.35,0.1,-0.05},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        -- 5 display WIT
        [DISPLAY_PARAM_WIT_ID] = {
            paramId = PARAM_WIT_ID,
            pos     = {-1.35,0.1,0.31},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        -- 6 display CHA
        [DISPLAY_PARAM_CHA_ID] = {
            paramId = PARAM_CHA_ID,
            pos     = {-1.35,0.1,0.68},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        -- 7 display STR savethrow
        [DISPLAY_SKILL_STR_SAVETHROW_ID] = {
            skillId = SKILL_STR_SAVETHROW_ID,
            pos     = {-0.973,0.1,-1.16},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 8 display Atletics
        [DISPLAY_SKILL_ATHLETICS_ID] = {
            skillId = SKILL_ATHLETICS_ID,
            pos     = {-0.973,0.1,-1.11},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 9 display DEX savethrow
        [DISPLAY_SKILL_DEX_SAVETHROW_ID] = {
            skillId = SKILL_DEX_SAVETHROW_ID,
            pos     = {-0.973,0.1,-0.795},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 10 display Acrobatics
        [DISPLAY_SKILL_ACROBATICS_ID] = {
            skillId = SKILL_ACROBATICS_ID,
            pos     = {-0.973,0.1,-0.745},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 11 display Stealth
        [DISPLAY_SKILL_STEALTH_ID] = {
            skillId = SKILL_STEALTH_ID,
            pos     = {-0.973,0.1,-0.695},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 12 display Sleight of Hand
        [DISPLAY_SKILL_SLEIGHT_OF_HAND_ID] = {
            skillId = SKILL_SLEIGHT_OF_HAND_ID,
            pos     = {-0.973,0.1,-0.645},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 13 display CON savethrow
        [DISPLAY_SKILL_CON_SAVETHROW_ID] = {
            skillId = SKILL_CON_SAVETHROW_ID,
            pos     = {-0.973,0.1,-0.435},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 14 display INT savethrow
        [DISPLAY_SKILL_INT_SAVETHROW_ID] = {
            skillId = SKILL_INT_SAVETHROW_ID,
            pos     = {-0.973,0.1,-0.07},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 15 display Arcana
        [DISPLAY_SKILL_ARCANA_ID] = {
            skillId = SKILL_ARCANA_ID,
            pos     = {-0.973,0.1,-0.0215},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 16 display History
        [DISPLAY_SKILL_HISTORY_ID] = {
            skillId = SKILL_HISTORY_ID,
            pos     = {-0.973,0.1,0.031},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 17 display Investigation
        [DISPLAY_SKILL_INVESTIGATION_ID] = {
            skillId = SKILL_INVESTIGATION_ID,
            pos     = {-0.973,0.1,0.0825},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 18 display Nature
        [DISPLAY_SKILL_NATURE_ID] = {
            skillId = SKILL_NATURE_ID,
            pos     = {-0.973,0.1,0.135},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 19 display Religion
        [DISPLAY_SKILL_RELIGION_ID] = {
            skillId = SKILL_RELIGION_ID,
            pos     = {-0.973,0.1,0.185},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 20 display WIT savethrow
        [DISPLAY_SKILL_WIT_SAVETHROW_ID] = {
            skillId = SKILL_WIT_SAVETHROW_ID,
            pos     = {-0.973,0.1,0.295},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 21 display Animal Handling
        [DISPLAY_SKILL_ANIMAL_HANDLING_ID] = {
            skillId = SKILL_ANIMAL_HANDLING_ID,
            pos     = {-0.973,0.1,0.345},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 22 display Insight
        [DISPLAY_SKILL_INSIGHT_ID] = {
            skillId = SKILL_INSIGHT_ID,
            pos     = {-0.973,0.1,0.395},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 23 display Medicine
        [DISPLAY_SKILL_MEDICINE_ID] = {
            skillId = SKILL_MEDICINE_ID,
            pos     = {-0.973,0.1,0.445},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 24 display Perception
        [DISPLAY_SKILL_PERCEPTION_ID] = {
            skillId = SKILL_PERCEPTION_ID,
            pos     = {-0.973,0.1,0.495},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 25 display Survival
        [DISPLAY_SKILL_SURVIVAL_ID] = {
            skillId = SKILL_SURVIVAL_ID,
            pos     = {-0.973,0.1,0.55},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 26 display CHA savethrow
        [DISPLAY_SKILL_CHA_SAVETHROW_ID] = {
            skillId = SKILL_CHA_SAVETHROW_ID,
            pos     = {-0.973,0.1,0.66},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 27 display Performance
        [DISPLAY_SKILL_PERFORMANCE_ID] = {
            skillId = SKILL_PERFORMANCE_ID,
            pos     = {-0.973,0.1,0.708},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 28 display Deception
        [DISPLAY_SKILL_DECEPTION_ID] = {
            skillId = SKILL_DECEPTION_ID,
            pos     = {-0.973,0.1,0.76},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 29 display Intimidation
        [DISPLAY_SKILL_INTIMIDATION_ID] = {
            skillId = SKILL_INTIMIDATION_ID,
            pos     = {-0.973,0.1,0.813},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 30 display Persuasion
        [DISPLAY_SKILL_PERSUASION_ID] = {
            skillId = SKILL_PERSUASION_ID,
            pos     = {-0.973,0.1,0.863},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        -- 31 display Passive Perception ButtonIndex 84
        [DISPLAY_PASSIVE_PERCEPTION_ID] = {
            id     = DISPLAY_PASSIVE_PERCEPTION_ID,
            pos    = {-1.35,0.1,1.03},
            size   = 450,
            value  = 10,
            hideBG = true,
        },
        -- 32 display Weight Capacity
        [DISPLAY_WEIGHT_CAPACITY_ID] = {
            id     = DISPLAY_WEIGHT_CAPACITY_ID,
            pos    = {-0.225,0.1,2.085},
            size   = 450,
            value  = 150,
            hideBG = true,
        },
        -- 33 display Raise, Lift and Pull
        [DISPLAY_RAISE_LIFT_AND_PULL_ID] = {
            id     = DISPLAY_RAISE_LIFT_AND_PULL_ID,
            pos    = {0.225,0.1,2.085},
            size   = 450,
            value  = 300,
            hideBG = true,
        },
        -- 34 display Jump Height
        [DISPLAY_JUMP_HEIGHT_ID] = {
            id     = DISPLAY_JUMP_HEIGHT_ID,
            pos    = {0.05,0.1,1.76},
            size   = 350,
            value  = 3,
            hideBG = true,
        },
        -- 35 display Jump Distance
        [DISPLAY_JUMP_DISTANCE_ID] = {
            id     = DISPLAY_JUMP_DISTANCE_ID,
            pos    = {0.05,0.1,1.695},
            size   = 350,
            value  = 10,
            hideBG = true,
        },
        -- 36 display Jump Height with Hands
        [DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID] = {
            id     = DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID,
            pos    = {0.05,0.1,1.825},
            size   = 350,
            value  = 3,
            hideBG = true,
        },
        -- 37 display Jump Height — no running
        [DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID] = {
            id     = DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID,
            pos    = {0.34,0.1,1.76},
            size   = 350,
            value  = 1,
            hideBG = true,
        },
        -- 38 display Jump Distance — no running
        [DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID] = {
            id     = DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID,
            pos    = {0.34,0.1,1.695},
            size   = 350,
            value  = 5,
            hideBG = true,
        },
        -- 39 display Jump Height with Hands — no running
        [DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID] = {
            id     = DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID,
            pos     = {0.34,0.1,1.825},
            size   = 350,
            value  = 1,
            hideBG = true,
        },
        -- 40 Level
        [DISPLAY_LEVEL_ID] = {
            id     = DISPLAY_LEVEL_ID,
            pos    = {-1.35,0.1,-1.285},
            size   = 600,
            value  = 1,
            hideBG = true,
        },
        -- 41 Exp for next LVL
        [DISPLAY_NEXT_LVL_ID] = {
            id     = DISPLAY_NEXT_LVL_ID,
            pos    = {1.27,0.1,-1.835},
            size   = 300,
            value  = '/ 300',
            hideBG = true,
        },
        -- 42 Proficiency
        [DISPLAY_PROFICIENCY_ID] = {
            id     = DISPLAY_PROFICIENCY_ID,
            pos    = {-1.35,0.1,-1.45},
            size   = 650,
            value  = '+2',
            hideBG = true,
        },
        -- 43 Hit Dices Left
        [DISPLAY_HIT_DICES_LEFT_ID] = {
            id     = DISPLAY_HIT_DICES_LEFT_ID,
            pos    = {0.75,0.1,-1.38},
            size   = 450,
            value  = ' 1/ 1к',
            hideBG = true,
        },

        -- End of Display
    },
    --Add editable text boxes
    textbox = {
        --[[
        pos       = the position (pasted from the helper tool)
        rows      = how many lines of text you want for this box
        width     = how wide the text box is
        font_size = size of text. This and "rows" effect overall height
        value     = text entered into box. "" = nothing
        alignment = Number to indicate how you want text aligned
                    (1=Automatic, 2=Left, 3=Center, 4=Right, 5=Justified)
        ]]
        -- Index (i) Card  {1 to 67} // Proficiency = 8 // Expertise {68 to 91}

        -- 1 textbox Name
        [TEXTBOX_NAME_ID] = {
            pos       = {-0.825,0.1,-1.900},
            rows      = 1,
            width     = 5000,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        -- 2 textbox Class & Level
        [TEXTBOX_CLASS_LEVEL_ID] = {
            pos       = {0.075,0.1,-1.975},
            rows      = 1,
            width     = 2500,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        -- 3 textbox Background
        [TEXTBOX_BACKGROUND_ID] = {
            pos       = {0.612,0.1,-1.975},
            rows      = 1,
            width     = 2600,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        -- 4 textbox Player’s name
        [TEXTBOX_PLAYERS_NAME_ID] = {
            pos       = {1.14,0.1,-1.975},
            rows      = 1,
            width     = 2400,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        -- 5 textbox Race
        [TEXTBOX_RACE_ID] = {
            pos       = {0.075,0.1,-1.835},
            rows      = 1,
            width     = 2500,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        -- 6 textbox Aligment
        [TEXTBOX_ALIGMENT_ID] = {
            pos       = {0.612,0.1,-1.835},
            rows      = 1,
            width     = 2600,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        -- 7 textbox XP
        [TEXTBOX_XP_ID] = {
            pos       = {1.015,0.1,-1.835},
            rows      = 1,
            width     = 1200,
            font_size = 350,
            value     = "0",
            alignment = 3
        },
        -- 8 textbox DELETED — Proficiency
        [TEXTBOX_DELETED_PROFICIENCY_ID] = {
            pos       = {0,0,0},
            rows      = 0,
            width     = 0,
            font_size = 0,
            value     = "",
            alignment = 3
        },
        -- 9 textbox Age
        [TEXTBOX_AGE_ID] = {
            pos       = {-0.671,0.1,1.24},
            rows      = 1,
            width     = 1200,
            font_size = 300,
            value     = "0",
            alignment = 3
        },
        -- 10 textbox AC
        [TEXTBOX_AC_ID] = {
            pos       = {-0.265,0.1,-1.425},
            rows      = 1,
            width     = 750,
            font_size = 450,
            value     = "10",
            alignment = 3
        },
        -- 11 textbox HP max
        [TEXTBOX_HP_MAX_ID] = {
            pos       = {0.045,0.1,-1.425},
            rows      = 1,
            width     = 750,
            font_size = 450,
            value     = "0",
            alignment = 3
        },
        -- 12 textbox HP temporary
        [TEXTBOX_HP_TEMPORARY_ID] = {
            pos       = {0.355,0.1,-1.425},
            rows      = 1,
            width     = 750,
            font_size = 450,
            value     = "0",
            alignment = 3
        },
        -- 13 textbox Hit Dices
        [TEXTBOX_HIT_DICES_ID] = {
            pos       = {0.93,0.1,-1.38},
            rows      = 1,
            width     = 500,
            font_size = 450,
            value     = "",
            alignment = 1
        },
        -- 14 textbox Initiative
        [TEXTBOX_INITIATIVE_ID] = {
            pos       = {1.25,0.1,-1.45},
            rows      = 1,
            width     = 750,
            font_size = 450,
            value     = "",
            alignment = 3
        },
        -- 15 textbox Speed
        [TEXTBOX_SPEED_ID] = {
            pos       = {1.25,0.1,-1.225},
            rows      = 1,
            width     = 1000,
            font_size = 450,
            value     = "",
            alignment = 3
        },
        -- 16 textbox Vision
        [TEXTBOX_VISION_ID] = {
            pos       = {1.25,0.1,-1.0},
            rows      = 1,
            width     = 1500,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 17 textbox Current Hit Points
        [TEXTBOX_CURRENT_HIT_POINTS_ID] = {
            pos       = {0.035,0.1,-1.09},
            rows      = 1,
            width     = 3800,
            font_size = 750,
            value     = "",
            alignment = 3
        },
        -- 18 textbox Weapon Name1
        [TEXTBOX_WEAPON_NAME_1_ID] = {
            pos       = {-0.08,0.1,-0.71 },
            rows      = 1,
            width     = 3350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 19 textbox Weapon Name2
        [TEXTBOX_WEAPON_NAME_2_ID] = {
            pos       = {-0.08,0.1,-0.632},
            rows      = 1,
            width     = 3350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 20 textbox Weapon Name3
        [TEXTBOX_WEAPON_NAME_3_ID] = {
            pos       = {-0.08,0.1,-0.554},
            rows      = 1,
            width     = 3350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 21 textbox Weapon Name4
        [TEXTBOX_WEAPON_NAME_4_ID] = {
            pos       = {-0.08,0.1,-0.476},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        -- 22 textbox Weapon Name5
        [TEXTBOX_WEAPON_NAME_5_ID] = {
            pos       = {-0.08,0.1,-0.398},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        -- 23 textbox Weapon Name6
        [TEXTBOX_WEAPON_NAME_6_ID] = {
            pos       = {-0.08,0.1,-0.320},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        -- 24 textbox Weapon Name7
        [TEXTBOX_WEAPON_NAME_7_ID] = {
            pos       = {-0.08,0.1,-0.242},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        -- 25 textbox Damage 1
        [TEXTBOX_DAMAGE_1_ID] = {
            pos       = {0.38,0.1,-0.71},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 26 textbox Damage 2
        [TEXTBOX_DAMAGE_2_ID] = {
            pos       = {0.38,0.1,-0.632},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 27 textbox Damage3
        [TEXTBOX_DAMAGE_3_ID] = {
            pos       = {0.38,0.1,-0.554},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 28 textbox Damage4
        [TEXTBOX_DAMAGE_4_ID] = {
            pos       = {0.38,0.1,-0.476},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 29 textbox Damage5
        [TEXTBOX_DAMAGE_5_ID] = {
            pos       = {0.38,0.1,-0.398},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 30 textbox Damage6
        [TEXTBOX_DAMAGE_6_ID] = {
            pos       = {0.38,0.1,-0.320},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 31 textbox Damage7
        [TEXTBOX_DAMAGE_7_ID] = {
            pos       = {0.38,0.1,-0.242},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 32textbox Damage Type1
        [TEXTBOX_DAMAGE_TYPE_1_ID] = {
            pos       = {0.6375,0.1,-0.71},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 33textbox Damage Type2
        [TEXTBOX_DAMAGE_TYPE_2_ID] = {
            pos       = {0.6375,0.1,-0.632},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 34textbox Damage Type3
        [TEXTBOX_DAMAGE_TYPE_3_ID] = {
            pos       = {0.6375,0.1,-0.554},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 35textbox Damage Type4
        [TEXTBOX_DAMAGE_TYPE_4_ID] = {
            pos       = {0.6375,0.1,-0.476},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 36textbox Damage Type5
        [TEXTBOX_DAMAGE_TYPE_5_ID] = {
            pos       = {0.6375,0.1,-0.398},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 37textbox Damage Type6
        [TEXTBOX_DAMAGE_TYPE_6_ID] = {
            pos       = {0.6375,0.1,-0.320},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 38textbox Damage Type7
        [TEXTBOX_DAMAGE_TYPE_7_ID] = {
            pos       = {0.6375,0.1,-0.242},
            rows      = 1,
            width     = 1350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 39 textbox Range1
        [TEXTBOX_RANGE_1_ID] = {
            pos       = {0.9475,0.1,-0.71},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 40 textbox Range2
        [TEXTBOX_RANGE_2_ID] = {
            pos       = {0.9475,0.1,-0.632},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 41 textbox Range3
        [TEXTBOX_RANGE_3_ID] = {
            pos       = {0.9475,0.1,-0.554},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 42 textbox Range4
        [TEXTBOX_RANGE_4_ID] = {
            pos       = {0.9475,0.1,-0.476},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 43 textbox Range5
        [TEXTBOX_RANGE_5_ID] = {
            pos       = {0.9475,0.1,-0.398},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },

        -- 44 textbox Range6
        [TEXTBOX_RANGE_6_ID] = {
            pos       = {0.9475,0.1,-0.320},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 45 textbox Range7
        [TEXTBOX_RANGE_7_ID] = {
            pos       = {0.9475,0.1,-0.242},
            rows      = 1,
            width     = 1250,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 46 textbox Notes1
        [TEXTBOX_NOTES_1_ID] = {
            pos       = {1.29,0.1,-0.71},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },

        -- 47 textbox Notes2
        [TEXTBOX_NOTES_2_ID] = {
            pos       = {1.29,0.1,-0.632},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 48 textbox Notes3
        [TEXTBOX_NOTES_3_ID] = {
            pos       = {1.29,0.1,-0.554},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 49 textbox Notes4
        [TEXTBOX_NOTES_4_ID] = {
            pos       = {1.29,0.1,-0.476},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 50 textbox Notes5
        [TEXTBOX_NOTES_5_ID] = {
            pos       = {1.29,0.1,-0.398},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 51 textbox Notes6
        [TEXTBOX_NOTES_6_ID] = {
            pos       = {1.29,0.1,-0.320},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 52 textbox Notes7
        [TEXTBOX_NOTES_7_ID] = {
            pos       = {1.29,0.1,-0.242},
            rows      = 1,
            width     = 1700,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        -- 53 textbox Copper coins
        [TEXTBOX_COPPER_COINS_ID] = {
            pos       = {-0.35,0.1,0.04},
            rows      = 1,
            width     = 850,
            font_size = 280,
            value     = "",
            alignment = 3
        },
        -- 54 textbox Silver coins
        [TEXTBOX_SILVER_COINS_ID] = {
            pos       = {-0.35,0.1,0.18},
            rows      = 1,
            width     = 850,
            font_size = 280,
            value     = "",
            alignment = 3
        },
        -- 55 textbox Electrum coins
        [TEXTBOX_ELECTRUM_COINS_ID] = {
            pos       = {-0.35,0.1,0.315},
            rows      = 1,
            width     = 850,
            font_size = 280,
            value     = "",
            alignment = 3
        },
        -- 56 textbox Gold coins
        [TEXTBOX_GOLD_COINS_ID] = {
            pos       = {-0.35,0.1,0.455},
            rows      = 1,
            width     = 850,
            font_size = 280,
            value     = "",
            alignment = 3
        },
        -- 57 textbox Platinum coins
        [TEXTBOX_PLATINUM_COINS_ID] = {
            pos       = {-0.35,0.1,0.6},
            rows      = 1,
            width     = 850,
            font_size = 280,
            value     = "",
            alignment = 3
        },
        -- 58 textbox Equipment
        [TEXTBOX_EQUIPMENT_1_ID] = {
            pos       = {0.1335,0.1,0.31},
            rows      = 11,
            width     = 3300,
            font_size = 300,
            value     = "",
            alignment = 2
        },
        -- 59 textbox Equipment2
        [TEXTBOX_EQUIPMENT_2_ID] = {
            pos       = {0.015,0.1,1.1},
            rows      = 13,
            width     = 4425,
            font_size = 300,
            value     = "",
            alignment = 2
        },
        -- 60 textbox Class and Race Characteristics
        [TEXTBOX_CLASS_RACE_CHARACTERISTICS_ID] = {
            pos       = {1.01,0.1,1.02},
            rows      = 41,
            width     = 4550,
            font_size = 250,
            value     = "",
            alignment = 2
        },
        -- 61 textbox Height
        [TEXTBOX_HEIGHT_ID] = {
            pos       = {-0.671,0.1,1.315},
            rows      = 1,
            width     = 1200,
            font_size = 300,
            value     = "0",
            alignment = 3
        },
        -- 62 textbox Weight
        [TEXTBOX_WEIGHT_ID] = {
            pos       = {-0.671,0.1,1.39},
            rows      = 1,
            width     = 1200,
            font_size = 300,
            value     = "0",
            alignment = 3
        },

        -- 63 textbox Proficiency3
        [TEXTBOX_PROFICIENCY_3_ID] = {
            pos       = {-1,0.1,1.78},
            rows      = 10,
            width     = 4350,
            font_size = 300,
            value     = "",
            alignment = 2
        },
        -- 64 textbox -- REMOVED -- Jump Distance
        [TEXTBOX_REMOVED_JUMP_DISTANCE_ID] = {
            pos       = {0,0,0},
            rows      = 1,
            width     = 0,
            font_size = 0,
            value     = "",
            alignment = 3
        },
        -- 65 textbox -- REMOVED -- Jump Height
        [TEXTBOX_REMOVED_JUMP_HEIGHT_ID] = {
            pos       = {0,0,0},
            rows      = 1,
            width     = 0,
            font_size = 0,
            value     = "",
            alignment = 3
        },
        -- 66 textbox -- REMOVED -- Weight
        [TEXTBOX_REMOVED_WEIGHT_ID] = {
            pos       = {0,0,0},
            rows      = 1,
            width     = 0,
            font_size = 0,
            value     = "",
            alignment = 3
        },
        -- 67 textbox -- REMOVED -- Raise, Lift and Pull
        [TEXTBOX_REMOVED_RAISE_LIFT_PULL_ID] = {
            pos       = {0,0,0},
            rows      = 1,
            width     = 0,
            font_size = 0,
            value     = "",
            alignment = 3
        },
        -- 68 textbox STR savethrow
        [TEXTBOX_SKILL_STR_SAVETHROW_ID] = {
            skillId   = SKILL_STR_SAVETHROW_ID,
            pos       = {-1.055,0.1,-1.165},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 69 textbox Atletics
        [TEXTBOX_SKILL_ATHLETICS_ID] = {
            skillId   = SKILL_ATHLETICS_ID,
            pos       = {-1.055,0.1,-1.1105},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 70 textbox DEX savethrow
        [TEXTBOX_SKILL_DEX_SAVETHROW_ID] = {
            skillId   = SKILL_DEX_SAVETHROW_ID,
            pos       = {-1.055,0.1,-0.8},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 71 textbox Acrobatics
        [TEXTBOX_SKILL_ACROBATICS_ID] = {
            skillId   = SKILL_ACROBATICS_ID,
            pos       = {-1.055,0.1,-0.745},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 72 textbox Stealth
        [TEXTBOX_SKILL_STEALTH_ID] = {
            skillId   = SKILL_STEALTH_ID,
            pos       = {-1.055,0.1,-0.695},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 73 textbox Sleight of Hand
        [TEXTBOX_SKILL_SLEIGHT_OF_HAND_ID] = {
            skillId   = SKILL_SLEIGHT_OF_HAND_ID,
            pos       = {-1.055,0.1,-0.645},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 74 textbox CON savethrow
        [TEXTBOX_SKILL_CON_SAVETHROW_ID] = {
            skillId   = SKILL_CON_SAVETHROW_ID,
            pos       = {-1.055,0.1,-0.435},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 75 textbox INT savethrow
        [TEXTBOX_SKILL_INT_SAVETHROW_ID] = {
            skillId   = SKILL_INT_SAVETHROW_ID,
            pos       = {-1.055,0.1,-0.075},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 76 textbox Arcana
        [TEXTBOX_SKILL_ARCANA_ID] = {
            skillId   = SKILL_ARCANA_ID,
            pos       = {-1.055,0.1,-0.0215},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 77 textbox History
        [TEXTBOX_SKILL_HISTORY_ID] = {
            skillId   = SKILL_HISTORY_ID,
            pos       = {-1.055,0.1,0.031},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 78 textbox Investigation
        [TEXTBOX_SKILL_INVESTIGATION_ID] = {
            skillId   = SKILL_INVESTIGATION_ID,
            pos       = {-1.055,0.1,0.0825},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 97 textbox Nature
        [TEXTBOX_SKILL_NATURE_ID] = {
            skillId   = SKILL_NATURE_ID,
            pos       = {-1.055,0.1,0.135},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 80 textbox Religion
        [TEXTBOX_SKILL_RELIGION_ID] = {
            skillId   = SKILL_RELIGION_ID,
            pos       = {-1.055,0.1,0.185},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 81 textbox WIT savethrow
        [TEXTBOX_SKILL_WIT_SAVETHROW_ID] = {
            skillId   = SKILL_WIT_SAVETHROW_ID,
            pos       = {-1.055,0.1,0.29},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 82 textbox Animal Handling
        [TEXTBOX_SKILL_ANIMAL_HANDLING_ID] = {
            skillId   = SKILL_ANIMAL_HANDLING_ID,
            pos       = {-1.055,0.1,0.345},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 83 textbox Insight
        [TEXTBOX_SKILL_INSIGHT_ID] = {
            skillId   = SKILL_INSIGHT_ID,
            pos       = {-1.055,0.1,0.395},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 84 textbox Medicine
        [TEXTBOX_SKILL_MEDICINE_ID] = {
            skillId   = SKILL_MEDICINE_ID,
            pos       = {-1.055,0.1,0.445},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 85 textbox Perception -- variable ind = 85
        [TEXTBOX_SKILL_PERCEPTION_ID] = {
            skillId   = SKILL_PERCEPTION_ID,
            pos       = {-1.055,0.1,0.495},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 86 textbox Survival
        [TEXTBOX_SKILL_SURVIVAL_ID] = {
            skillId   = SKILL_SURVIVAL_ID,
            pos       = {-1.055,0.1,0.55},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 87 textbox CHA savethrow
        [TEXTBOX_SKILL_CHA_SAVETHROW_ID] = {
            skillId   = SKILL_CHA_SAVETHROW_ID,
            pos       = {-1.055,0.1,0.655},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 88 textbox Performance
        [TEXTBOX_SKILL_PERFORMANCE_ID] = {
            skillId   = SKILL_PERFORMANCE_ID,
            pos       = {-1.055,0.1,0.708},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 89 textbox Deception
        [TEXTBOX_SKILL_DECEPTION_ID] = {
            skillId   = SKILL_DECEPTION_ID,
            pos       = {-1.055,0.1,0.76},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 90 textbox Intimidation
        [TEXTBOX_SKILL_INTIMIDATION_ID] = {
            skillId   = SKILL_INTIMIDATION_ID,
            pos       = {-1.055,0.1,0.813},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },
        -- 91 textbox Persuasion
        [TEXTBOX_SKILL_PERSUASION_ID] = {
            skillId   = SKILL_PERSUASION_ID,
            pos       = {-1.055,0.1,0.863},
            rows      = 1,
            width     = 200,
            font_size = 200,
            value     = "0",
            alignment = 3
        },

        --End of textboxes
    },

    lvl = 1,
    lvlByExp = 1,
    lvlByExpProficiency = 2,
    hitDiceLeft = 1,
}

LVL_UPDATE_BTN = {
    function_owner = self,
    index          = #defaultButtonData.checkbox + #defaultButtonData.counter * 3 + #defaultButtonData.display,
}

lvlUpdateBtnConditionOFF = {
    click_function = "click_none",
    color          = buttonColor,
    font_color     = buttonFontColor,
    font_size      = 0,
    function_owner = LVL_UPDATE_BTN.function_owner,
    function_owner = self,
    height         = 0,
    index          = LVL_UPDATE_BTN.index,
    label          = '',
    position       = {0,0,0},
    scale          = {0,0,0},
    width          = 0,
}


--Lua beyond this point.



--Save function
function updateSave()
    saved_data = JSON.encode(ref_buttonData)

    if disableSave == true then
        saved_data = ""
    end

    self.script_state = saved_data
end

--Startup procedure
function onload(saved_data)
    if disableSave == true then
        saved_data = ""
    end

    if saved_data ~= "" then
        --local loaded_data = JSON.decode(saved_data)
        --ref_buttonData = loaded_data
         ref_buttonData = defaultButtonData
    else
        ref_buttonData = defaultButtonData
    end

    spawnedButtonCount = 0

    createCheckbox()
    createCounter()
    createTextbox()
    createDisplay()

    updateJumpAndWeight()
    createLvlUpdateBtn()
    createHitDiceCounters()

    lvlRefresh()
end

--Click functions for buttons

--Checks or unchecks the given box
function click_checkbox(checkboxId) --
    -- tableIndex 1 to 24 // 18 Perception
    -- buttonIndex 0 to 23

    local checkbox = ref_buttonData.checkbox[checkboxId]
    local skillId = checkbox.skillId

    if not (skillId == nil) then
        local paramId = paramIdBySkillId[skillId]

        atributo = ref_buttonData.display["display_"..paramId].value
    end

    -- Skill Point Total Value Calculation and Update - Proficiently Marked
    if checkbox.state == false then
        if not (skillId == nil) then
            local proficiency = ref_buttonData.display[DISPLAY_PROFICIENCY_ID].value
            local bonus = ref_buttonData.textbox["textbox_"..skillId].value
            tonumber(proficiency)
            tonumber(bonus)
            local newValue = atributo + bonus + proficiency
            ref_buttonData.display["display_"..skillId].value = newValue
            self.editButton({index = btnIndexByElementIdTable["display_"..skillId], label = newValue})
        end

        checkbox.state = true
        self.editButton({index = btnIndexByElementIdTable[checkboxId], label = CHECKBOX_CHAR_FULL})
        -- Total Skill Calculation - Uncheck
    else
        if not (skillId == nil) then
            local bonus = ref_buttonData.textbox["textbox_"..skillId].value
            tonumber(bonus)
            local newVal = atributo + bonus

            ref_buttonData.display["display_"..skillId].value = newVal
            self.editButton({index = btnIndexByElementIdTable["display_"..skillId], label = newVal})
        end

        checkbox.state = false
        self.editButton({index = btnIndexByElementIdTable[checkboxId], label = CHECKBOX_CHAR_EMPTY})
    end

    -- Passive Perception Update in CheckBox
    if checkboxId == "checkbox_"..SKILL_PERCEPTION_ID then
        local proficiency = ref_buttonData.display[DISPLAY_PROFICIENCY_ID].value
        local bonus = ref_buttonData.textbox[TEXTBOX_SKILL_PERCEPTION_ID].value
        tonumber(proficiency)
        tonumber(bonus)

        if checkbox.state == true then
            ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value = 10 + atributo + bonus + proficiency
        else
            ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value = 10 + atributo + bonus
        end

        self.editButton({
            index = btnIndexByElementIdTable[DISPLAY_PASSIVE_PERCEPTION_ID],
            label = ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value,
        })
    end

    updateSave()
end

--Applies value to given counter display
function click_counter(amount, counterId)
    local paramId = ref_buttonData.counter[counterId].paramId

    ref_buttonData.counter[counterId].value = ref_buttonData.counter[counterId].value + amount
    ref_buttonData.display["display_"..paramId].value = math.floor((ref_buttonData.counter[counterId].value - 10) / 2)

    -- Update Attribute
    self.editButton({
        index = btnIndexByElementIdTable["counter_"..paramId],
        label = ref_buttonData.counter[counterId].value,
    })

    -- Update Attribute Modifier
    self.editButton({
        index = btnIndexByElementIdTable["display_"..paramId],
        label = ref_buttonData.display["display_"..paramId].value,
    })

    -- Declaring the Variables attribute and proficiency
    local atributo = ref_buttonData.display["display_"..paramId].value

    local proficiency = ref_buttonData.display[DISPLAY_PROFICIENCY_ID].value

    tonumber(proficiency)

    -- Calculation and Update of Attribute Matching Skills

    for i, skillId in ipairs(skillIdListByParamId[paramId]) do
        -- Declaring Bonus Variable for Skill
        local bonus = ref_buttonData.textbox["textbox_"..skillId].value
        tonumber(bonus)

        -- Skill Update With and Without Proficiency
        if ref_buttonData.checkbox["checkbox_"..skillId].state == true then
            ref_buttonData.display["display_"..skillId].value = atributo + bonus + proficiency
            self.editButton({index = btnIndexByElementIdTable["display_"..skillId], label = atributo + bonus + proficiency})
        else
            ref_buttonData.display["display_"..skillId].value = atributo + bonus
            self.editButton({index = btnIndexByElementIdTable["display_"..skillId], label = atributo + bonus})
        end

        --Passive Perception Update
        if skillId == SKILL_PERCEPTION_ID then
            -- With or Without Perception Proficiency
            if ref_buttonData.checkbox["checkbox_"..SKILL_PERCEPTION_ID].state == true then
                ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value = 10 + atributo + bonus + proficiency
                self.editButton({
                    index = btnIndexByElementIdTable[DISPLAY_PASSIVE_PERCEPTION_ID],
                    label = ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value,
                })
            else
                ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value = 10 + atributo + bonus
                self.editButton({
                    index = btnIndexByElementIdTable[DISPLAY_PASSIVE_PERCEPTION_ID],
                    label = ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value,
                })
            end
        end
    end

    updateJumpAndWeight()

    --Updates saved value for given text box
    updateSave()
end

--Applies value to given textbox
function click_textbox(value, selected, textboxId)
    if selected == false then
        ref_buttonData.textbox[textboxId].value = value

        -- Declaring Proficiency Values
        updateSkillsByProficiency()

        -- Height Change — Jump Height with Hands update
        if textboxId == TEXTBOX_HEIGHT_ID then
            updateJumpAndWeight()
        end

        -- Exp Change — Level update
        if textboxId == TEXTBOX_XP_ID then
            updateLevelByExp()
        end

        updateSave()
    end
end

--Dud function for if you have a background on a counter
function click_none() end

-- Check Proficiency and update skills
function updateSkillsByProficiency()
    -- Declaring Proficiency Values
    proficiency = ref_buttonData.display[DISPLAY_PROFICIENCY_ID].value
    tonumber(proficiency)

    -- Proficiency Value Change Skills Update
    for skillId, paramId in pairs(paramIdBySkillId) do
        atributo = ref_buttonData.display["display_"..paramId].value

        -- Upgrading Skills Only as Proficiency
        local bonus = ref_buttonData.textbox["textbox_"..skillId].value
        tonumber(bonus)
        local nextValue = atributo + bonus
        if ref_buttonData.checkbox["checkbox_"..skillId].state == true then
            nextValue = atributo + bonus + proficiency
        end

        ref_buttonData.display["display_"..skillId].value = nextValue
        self.editButton({
            index = btnIndexByElementIdTable["display_"..skillId],
            label = nextValue,
        })

        -- Updating Passive Perception with Proficiency
        if skillId == SKILL_PERCEPTION_ID then
            ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value = 10 + nextValue
            self.editButton({
                index = btnIndexByElementIdTable[DISPLAY_PASSIVE_PERCEPTION_ID],
                label = ref_buttonData.display[DISPLAY_PASSIVE_PERCEPTION_ID].value,
            })
        end
    end
end

--Button creation

--Makes checkboxes
function updateJumpAndWeight()
    -- Update Weight Capacity
    weightCapacity = ref_buttonData.counter[COUNTER_PARAM_STR_ID].value * 15
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_WEIGHT_CAPACITY_ID],
        label = weightCapacity,
    })

    -- Update Raise, Lift and Pull
    raiseLiftPullCapacity = weightCapacity * 2
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_RAISE_LIFT_AND_PULL_ID],
        label = raiseLiftPullCapacity,
    })

    -- Update Jump Height
    jumpHeight = ref_buttonData.display[DISPLAY_PARAM_STR_ID].value + 3
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_ID],
        label = jumpHeight,
    })

    -- Update Jump Distance
    jumpDistance = ref_buttonData.counter[COUNTER_PARAM_STR_ID].value
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_DISTANCE_ID],
        label = jumpDistance,
    })

    -- Update Jump Height with Hands
    characterHeight = ref_buttonData.textbox[TEXTBOX_HEIGHT_ID].value
    if characterHeight == '' then
        characterHeight = 0
    end

    tonumber(characterHeight)
    characterOneAndHalfHeight = math.floor(characterHeight * 1.5)
    jumpHeightWithHands = jumpHeight + characterOneAndHalfHeight
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID],
        label = jumpHeightWithHands,
    })

    -- Update Jump Height — no running
    jumpHeightNoRunning = math.floor(jumpHeight / 2)
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID],
        el = jumpHeightNoRunning,
    })

    -- Update Jump Distance — no running
    jumpDistanceNoRunning = math.floor(jumpDistance / 2)
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID],
        label = jumpDistanceNoRunning,
    })

    -- Update Jump Height with Hands — no running
    jumpHeightWithHandsNoRunning = jumpHeightNoRunning + characterOneAndHalfHeight
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID],
        label = jumpHeightWithHandsNoRunning,
    })
end

-- Lvl update btn - Activate/Deactivate
function setLvlUpdateBtnCondition(doActivate)
    if doActivate then
        self.editButton({
            click_function = "onClickLvlUpdateBtn",
            color          = buttonColor,
            font_color     = buttonFontColor,
            font_size      = 350,
            function_owner = LVL_UPDATE_BTN.function_owner,
            height         = 500,
            index          = LVL_UPDATE_BTN.index,
            label          = 'Обновить уровень ('..ref_buttonData.lvlByExp..')',
            position       = {1.040,0.1,-1.655},
            scale          = buttonScale,
            width          = 4000,
        })
    else
        self.editButton(lvlUpdateBtnConditionOFF)
    end
end

-- Lvl update btn - Create
function createLvlUpdateBtn()
    createBtnAndSaveIndex("lvlUpdateBtn", lvlUpdateBtnConditionOFF)
end

-- Lvl refresh
function lvlRefresh()
    updateLevelByExp()
    onClickLvlUpdateBtn()
end

-- Lvl update btn - Click
function onClickLvlUpdateBtn()
    ref_buttonData.lvl = ref_buttonData.lvlByExp

    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_LEVEL_ID],
        label = ref_buttonData.lvlByExp,
        value = ref_buttonData.lvlByExp,
    })

    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_NEXT_LVL_ID],
        label = ref_buttonData.nextLvlExp,
        value = ref_buttonData.nextLvlExp,
    })

    ref_buttonData.display[DISPLAY_PROFICIENCY_ID].value = ref_buttonData.lvlByExpProficiency

    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_PROFICIENCY_ID],
        label = '+'..ref_buttonData.lvlByExpProficiency,
        value = ref_buttonData.lvlByExpProficiency,
    })

    updateSkillsByProficiency()
    setLvlUpdateBtnCondition(false)
    updateHitDiceText()
    updateSave()
end

--Update Level
function updateLevelByExp()
    local EXP_INPUT_EDIT_ID = 6

    exp = tonumber(ref_buttonData.textbox[TEXTBOX_XP_ID].value) or EXP_MIN

    -- Исправить значение опыта
    if (exp < EXP_MIN or exp > EXP_MAX) then
        if (exp < EXP_MIN) then exp = EXP_MIN end
        if (exp > EXP_MAX) then exp = EXP_MAX end

        -- Исправить значение опыта на инпуте
        ref_buttonData.textbox[TEXTBOX_XP_ID].value = exp
        Wait.time(
            function ()
                self.editInput({
                    index = EXP_INPUT_EDIT_ID, -- TODO: use input table like “btnIndexByElementIdTable”
                    value = exp,
                })
            end,
            0
        )
    end

    for i, data in ipairs(LVL_BY_EXP) do
        if ((data.min <= exp) and (exp <= data.max)) then
            ref_buttonData.lvlByExp = data.lvl
            ref_buttonData.lvlByExpProficiency = data.proficiency

            if (i == #LVL_BY_EXP) then
                ref_buttonData.nextLvlExp = '/ —'
            else
                ref_buttonData.nextLvlExp = '/ '..(data.max + 1)
            end

            if (ref_buttonData.lvlByExp ~= ref_buttonData.lvl) then
                setLvlUpdateBtnCondition(true)
            end
        end
    end
end

--Create Hit Dice + & - buttons
function createHitDiceCounters()
    local size = 350

    createBtnAndSaveIndex(
        "hitDiceIncrement",
        {
            click_function = "hitDiceIncrement",
            color          = buttonColor,
            font_color     = buttonFontColor,
            font_size      = size,
            function_owner = self,
            height         = size,
            label          = '+',
            position       = {0.68,0.1,-1.47},
            scale          = buttonScale,
            width          = size,
        }
    )
    createBtnAndSaveIndex(
        "hitDiceDecrement",
        {
            click_function = "hitDiceDecrement",
            color          = buttonColor,
            font_color     = buttonFontColor,
            font_size      = size,
            function_owner = self,
            height         = size,
            label          = '-',
            position       = {0.68,0.1,-1.29},
            scale          = buttonScale,
            width          = size,
        }
    )

    updateHitDiceText()
end

-- Increment Hit Dice Left
function hitDiceIncrement()
    changeHitDiceLeft(true)
end

-- Decrement Hit Dice Left
function hitDiceDecrement()
    changeHitDiceLeft(false)
end

--Сhange Hit Dice Left
function changeHitDiceLeft(addDice)
    local HIT_DICE_MIN = 0
    local HIT_DICE_MAX = ref_buttonData.lvl

    hitDiceLeft = tonumber(ref_buttonData.hitDiceLeft) or HIT_DICE_MIN

    nextHitDiceLeft = (addDice == true) and (hitDiceLeft + 1) or (hitDiceLeft - 1)

    -- Исправить количество костей хитов
    if (nextHitDiceLeft < HIT_DICE_MIN or nextHitDiceLeft > HIT_DICE_MAX) then
        if (nextHitDiceLeft < HIT_DICE_MIN) then nextHitDiceLeft = HIT_DICE_MIN end
        if (nextHitDiceLeft > HIT_DICE_MAX) then nextHitDiceLeft = HIT_DICE_MAX end
    end

    -- Исправить количество костей хитов
    ref_buttonData.hitDiceLeft = nextHitDiceLeft
    updateHitDiceText()
end

--Update Hit Dice Text
function updateHitDiceText()
    local hitDiceLeft = tonumber(ref_buttonData.hitDiceLeft)
    local hitDiceText = hitDiceLeft..'/'..ref_buttonData.lvl..'к'

    ref_buttonData.display[DISPLAY_HIT_DICES_LEFT_ID].value = hitDiceText
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_HIT_DICES_LEFT_ID],
        label = hitDiceText,
        value = hitDiceText,
    })
end

--Makes checkboxes
function createCheckbox()
    for checkboxId, data in pairs(ref_buttonData.checkbox) do
        --Sets up reference function
        local funcName = "checkbox"..checkboxId
        local func = function()
            click_checkbox(checkboxId)
        end

        self.setVar(funcName, func)

        --Sets up label
        local label = CHECKBOX_CHAR_EMPTY
        if data.state == true then
            label = CHECKBOX_CHAR_FULL
        end

        --Creates button and counts it
        createBtnAndSaveIndex(
            checkboxId,
            {
                click_function = funcName,
                color          = buttonColor,
                font_color     = buttonFontColor,
                font_size      = data.size,
                function_owner = self,
                height         = data.size,
                label          = label,
                position       = data.pos,
                scale          = buttonScale,
                width          = data.size,
            }
        )

        spawnedButtonCount = spawnedButtonCount + 1
    end
end
--Makes counters
function createCounter()
    for counterId, data in pairs(ref_buttonData.counter) do
        --Sets up display
        local displayNumber = spawnedButtonCount
        --Sets up label
        local label = data.value
        --Sets height/width for display
        local size = data.size
        if data.hideBG == true then
            size = 0
        end

        --Creates button and counts it
        createBtnAndSaveIndex(
            counterId,
            {
                click_function = "click_none",
                color          = buttonColor,
                font_color     = buttonFontColor,
                font_size      = data.size,
                function_owner = self,
                height         = size,
                label          = label,
                position       = data.pos,
                scale          = buttonScale,
                width          = size,
            }
        )

        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up add 1
        local funcName = data.btnAddId
        local func = function()
            click_counter(1, counterId)
        end

        self.setVar(funcName, func)
        --Sets up position
        local offsetDistance = (data.size / 2 + data.size / 4) * (buttonScale[1] * 0.002)
        local pos = {
            data.pos[1] + offsetDistance,
            data.pos[2],
            data.pos[3],
        }
        --Sets up size
        local size = data.size / 2

        --Creates button and counts it
        createBtnAndSaveIndex(
            data.btnAddId,
            {
                click_function = funcName,
                color          = buttonColor,
                font_color     = buttonFontColor,
                font_size      = size,
                function_owner = self,
                height         = size,
                label          = "+",
                position       = pos,
                scale          = buttonScale,
                width          = size,
            }
        )

        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up subtract 1
        local funcName = data.btnSubId
        local func = function()
            click_counter(-1, counterId)
        end

        self.setVar(funcName, func)

        --Set up position
        local pos = {
            data.pos[1] - offsetDistance,
            data.pos[2],
            data.pos[3],
        }

        --Creates button and counts it
        createBtnAndSaveIndex(
            data.btnSubId,
            {
                click_function = funcName,
                color          = buttonColor,
                font_color     = buttonFontColor,
                font_size      = size,
                function_owner = self,
                height         = size,
                label          = "−",
                position       = pos,
                scale          = buttonScale,
                width          = size,
            }
        )

        spawnedButtonCount = spawnedButtonCount + 1
    end
end

--Makes display
function createDisplay()
    for displayId, data in pairs(ref_buttonData.display) do
        -- Sets up label
        local label = data.value
        -- Sets height/width for display
        local size = data.size
        local tooltip = data.tooltip or ''

        if data.hideBG == true then
            size = 0
        end

        -- Create display button
        createBtnAndSaveIndex(
            displayId,
            {
                click_function = "click_none",
                color          = buttonColor,
                font_color     = buttonFontColor,
                font_size      = data.size,
                function_owner = self,
                height         = size,
                label          = label,
                position       = data.pos,
                scale          = buttonScale,
                tooltip        = tooltip,
                width          = size,
            }
        )
    end
end

--Makes textbox
function createTextbox()
    for textboxId, data in pairs(ref_buttonData.textbox) do
        --Sets up reference function
        local funcName = "textbox_"..textboxId
        local func = function(_, _, val, sel)
            click_textbox(val, sel, textboxId)
        end

        self.setVar(funcName, func)

        self.createInput({
            alignment      = data.alignment,
            color          = buttonColor,
            font_color     = buttonFontColor,
            font_size      = data.font_size,
            function_owner = self,
            height         = (data.font_size * data.rows) + 24,
            input_function = funcName,
            label          = textboxLabelCollection[textboxId],
            position       = data.pos,
            scale          = buttonScale,
            value          = data.value,
            width          = data.width,
        })
    end
end

function createBtnAndSaveIndex (btnId, params)
    self.createButton(params)
    local btnTable = self.getButtons()
    btnIndexByElementIdTable[btnId] = btnTable[#btnTable].index
end
