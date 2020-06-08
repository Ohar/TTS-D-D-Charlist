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

local TEXTBOX_SKILL_width = 280
local TEXTBOX_SKILL_fontSize = 220
local POUND_PER_KG = 0.454

local NET_MONET_TEXT = 'Нет монет                            ' -- Align text with spaces

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
local TEXTBOX_HIT_1_ID = "textbox_Hit_1"
local TEXTBOX_HIT_2_ID = "textbox_Hit_2"
local TEXTBOX_HIT_3_ID = "textbox_Hit_3"
local TEXTBOX_HIT_4_ID = "textbox_Hit_4"
local TEXTBOX_HIT_5_ID = "textbox_Hit_5"
local TEXTBOX_HIT_6_ID = "textbox_Hit_6"
local TEXTBOX_HIT_7_ID = "textbox_Hit_7"
local TEXTBOX_DAMAGE_DICE_COUNT_1_ID = "textbox_Damage_Dice_Count_Type_1"
local TEXTBOX_DAMAGE_DICE_COUNT_2_ID = "textbox_Damage_Dice_Count_Type_2"
local TEXTBOX_DAMAGE_DICE_COUNT_3_ID = "textbox_Damage_Dice_Count_Type_3"
local TEXTBOX_DAMAGE_DICE_COUNT_4_ID = "textbox_Damage_Dice_Count_Type_4"
local TEXTBOX_DAMAGE_DICE_COUNT_5_ID = "textbox_Damage_Dice_Count_Type_5"
local TEXTBOX_DAMAGE_DICE_COUNT_6_ID = "textbox_Damage_Dice_Count_Type_6"
local TEXTBOX_DAMAGE_DICE_COUNT_7_ID = "textbox_Damage_Dice_Count_Type_7"
local TEXTBOX_DAMAGE_DICE_TYPE_1_ID = "textbox_Damage_Dice_Type_1"
local TEXTBOX_DAMAGE_DICE_TYPE_2_ID = "textbox_Damage_Dice_Type_2"
local TEXTBOX_DAMAGE_DICE_TYPE_3_ID = "textbox_Damage_Dice_Type_3"
local TEXTBOX_DAMAGE_DICE_TYPE_4_ID = "textbox_Damage_Dice_Type_4"
local TEXTBOX_DAMAGE_DICE_TYPE_5_ID = "textbox_Damage_Dice_Type_5"
local TEXTBOX_DAMAGE_DICE_TYPE_6_ID = "textbox_Damage_Dice_Type_6"
local TEXTBOX_DAMAGE_DICE_TYPE_7_ID = "textbox_Damage_Dice_Type_7"
local TEXTBOX_DAMAGE_BONUS_1_ID = "textbox_Damage_Bonus_1"
local TEXTBOX_DAMAGE_BONUS_2_ID = "textbox_Damage_Bonus_2"
local TEXTBOX_DAMAGE_BONUS_3_ID = "textbox_Damage_Bonus_3"
local TEXTBOX_DAMAGE_BONUS_4_ID = "textbox_Damage_Bonus_4"
local TEXTBOX_DAMAGE_BONUS_5_ID = "textbox_Damage_Bonus_5"
local TEXTBOX_DAMAGE_BONUS_6_ID = "textbox_Damage_Bonus_6"
local TEXTBOX_DAMAGE_BONUS_7_ID = "textbox_Damage_Bonus_7"
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
local TEXTBOX_PROFICIENCY_OTHER_ID = "textbox_Proficiency_other"
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
local CHECKBOX_WEIGHT_CAPACITY_X_2 = "checkbox_WEIGHT_CAPACITY_X_2"

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
local DISPLAY_MONET_WEIGHT_ID = "display_MONET_WEIGHT_Left"

local ROLL_PARAM_STR_ID = "roll_param_str"
local ROLL_PARAM_DEX_ID = "roll_param_dex"
local ROLL_PARAM_CON_ID = "roll_param_con"
local ROLL_PARAM_INT_ID = "roll_param_int"
local ROLL_PARAM_WIT_ID = "roll_param_wit"
local ROLL_PARAM_CHA_ID = "roll_param_cha"
local ROLL_SKILL_STR_SAVETHROW_ID = "roll_skill_str_savethrow"
local ROLL_SKILL_ATHLETICS_ID = "roll_skill_athletics"
local ROLL_SKILL_DEX_SAVETHROW_ID = "roll_skill_dex_savethrow"
local ROLL_SKILL_ACROBATICS_ID = "roll_skill_acrobatics"
local ROLL_SKILL_STEALTH_ID = "roll_skill_stealth"
local ROLL_SKILL_SLEIGHT_OF_HAND_ID = "roll_skill_sleight_of_hand"
local ROLL_SKILL_CON_SAVETHROW_ID = "roll_skill_con_savethrow"
local ROLL_SKILL_INT_SAVETHROW_ID = "roll_skill_int_savethrow"
local ROLL_SKILL_ARCANA_ID = "roll_skill_arcana"
local ROLL_SKILL_HISTORY_ID = "roll_skill_history"
local ROLL_SKILL_INVESTIGATION_ID = "roll_skill_investigation"
local ROLL_SKILL_NATURE_ID = "roll_skill_nature"
local ROLL_SKILL_RELIGION_ID = "roll_skill_religion"
local ROLL_SKILL_WIT_SAVETHROW_ID = "roll_skill_wit_savethrow"
local ROLL_SKILL_ANIMAL_HANDLING_ID = "roll_skill_animal_handling"
local ROLL_SKILL_INSIGHT_ID = "roll_skill_insight"
local ROLL_SKILL_MEDICINE_ID = "roll_skill_medicine"
local ROLL_SKILL_PERCEPTION_ID = "roll_skill_perception"
local ROLL_SKILL_SURVIVAL_ID = "roll_skill_survival"
local ROLL_SKILL_CHA_SAVETHROW_ID = "roll_skill_cha_savethrow"
local ROLL_SKILL_PERFORMANCE_ID = "roll_skill_performance"
local ROLL_SKILL_DECEPTION_ID = "roll_skill_deception"
local ROLL_SKILL_INTIMIDATION_ID = "roll_skill_intimidation"
local ROLL_SKILL_PERSUASION_ID = "roll_skill_persuasion"

local rollLabelCollection = {
    [ROLL_PARAM_STR_ID] = "Сила",
    [ROLL_PARAM_DEX_ID] = "Ловкость",
    [ROLL_PARAM_CON_ID] = "Телосложение",
    [ROLL_PARAM_INT_ID] = "Интеллект",
    [ROLL_PARAM_WIT_ID] = "Мудрость",
    [ROLL_PARAM_CHA_ID] = "Харизма",
    [ROLL_SKILL_STR_SAVETHROW_ID] = "Испытание",
    [ROLL_SKILL_ATHLETICS_ID] = "Атлетика",
    [ROLL_SKILL_DEX_SAVETHROW_ID] = "Испытание",
    [ROLL_SKILL_ACROBATICS_ID] = "Акробатика",
    [ROLL_SKILL_STEALTH_ID] = "Скрытность",
    [ROLL_SKILL_SLEIGHT_OF_HAND_ID] = "Ловкость рук",
    [ROLL_SKILL_CON_SAVETHROW_ID] = "Испытание",
    [ROLL_SKILL_INT_SAVETHROW_ID] = "Испытание",
    [ROLL_SKILL_ARCANA_ID] = "Магия",
    [ROLL_SKILL_HISTORY_ID] = "История",
    [ROLL_SKILL_INVESTIGATION_ID] = "Анализ",
    [ROLL_SKILL_NATURE_ID] = "Природа",
    [ROLL_SKILL_RELIGION_ID] = "Религия",
    [ROLL_SKILL_WIT_SAVETHROW_ID] = "Испытание",
    [ROLL_SKILL_ANIMAL_HANDLING_ID] = "Обращение с животными",
    [ROLL_SKILL_INSIGHT_ID] = "Проницательность",
    [ROLL_SKILL_MEDICINE_ID] = "Медицина",
    [ROLL_SKILL_PERCEPTION_ID] = "Внимательность",
    [ROLL_SKILL_SURVIVAL_ID] = "Выживание",
    [ROLL_SKILL_CHA_SAVETHROW_ID] = "Испытание",
    [ROLL_SKILL_PERFORMANCE_ID] = "Выступление",
    [ROLL_SKILL_DECEPTION_ID] = "Обман",
    [ROLL_SKILL_INTIMIDATION_ID] = "Запугивание",
    [ROLL_SKILL_PERSUASION_ID] = "Убеждение",
}

local rollTextCollection = {
    [ROLL_PARAM_STR_ID] = "проверка [b]Силы[/b]",
    [ROLL_PARAM_DEX_ID] = "проверка [b]Ловкости[/b]",
    [ROLL_PARAM_CON_ID] = "проверка [b]Телосложения[/b]",
    [ROLL_PARAM_INT_ID] = "проверка [b]Интеллекта[/b]",
    [ROLL_PARAM_WIT_ID] = "проверка [b]Мудрости[/b]",
    [ROLL_PARAM_CHA_ID] = "проверка [b]Харизмы[/b]",
    [ROLL_SKILL_STR_SAVETHROW_ID] = "испытание [b]Силы[/b]",
    [ROLL_SKILL_ATHLETICS_ID] = "проверка [b]Атлетики[/b]",
    [ROLL_SKILL_DEX_SAVETHROW_ID] = "испытание [b]Ловкости[/b]",
    [ROLL_SKILL_ACROBATICS_ID] = "проверка [b]Акробатики[/b]",
    [ROLL_SKILL_STEALTH_ID] = "проверка [b]Скрытности[/b]",
    [ROLL_SKILL_SLEIGHT_OF_HAND_ID] = "проверка [b]Ловкости[/b] рук",
    [ROLL_SKILL_CON_SAVETHROW_ID] = "испытание [b]Телосложения[/b]",
    [ROLL_SKILL_INT_SAVETHROW_ID] = "испытание [b]Интеллекта[/b]",
    [ROLL_SKILL_ARCANA_ID] = "проверка [b]Магии[/b]",
    [ROLL_SKILL_HISTORY_ID] = "проверка [b]Истории[/b]",
    [ROLL_SKILL_INVESTIGATION_ID] = "проверка [b]Анализа[/b]",
    [ROLL_SKILL_NATURE_ID] = "проверка [b]Природы[/b]",
    [ROLL_SKILL_RELIGION_ID] = "проверка [b]Религии[/b]",
    [ROLL_SKILL_WIT_SAVETHROW_ID] = "испытание [b]Мудрости[/b]",
    [ROLL_SKILL_ANIMAL_HANDLING_ID] = "проверка [b]Обращения[/b] с животными",
    [ROLL_SKILL_INSIGHT_ID] = "проверка [b]Проницательности[/b]",
    [ROLL_SKILL_MEDICINE_ID] = "проверка [b]Медицины[/b]",
    [ROLL_SKILL_PERCEPTION_ID] = "проверка [b]Внимательности[/b]",
    [ROLL_SKILL_SURVIVAL_ID] = "проверка [b]Выживания[/b]",
    [ROLL_SKILL_CHA_SAVETHROW_ID] = "испытание [b]Харизмы[/b]",
    [ROLL_SKILL_PERFORMANCE_ID] = "проверка [b]Выступления[/b]",
    [ROLL_SKILL_DECEPTION_ID] = "проверка [b]Обмана[/b]",
    [ROLL_SKILL_INTIMIDATION_ID] = "проверка [b]Запугивания[/b]",
    [ROLL_SKILL_PERSUASION_ID] = "проверка [b]Убеждения[/b]",
}

local textboxLabelCollection = {
    [TEXTBOX_NAME_ID] = "Имя персонажа",
    [TEXTBOX_CLASS_LEVEL_ID] = "Класс",
    [TEXTBOX_BACKGROUND_ID] = "Предыстория",
    [TEXTBOX_PLAYERS_NAME_ID] = "Имя игрока",
    [TEXTBOX_RACE_ID] = "Раса",
    [TEXTBOX_ALIGMENT_ID] = "Мировоззрение",
    [TEXTBOX_XP_ID] = "Опыт",
    [TEXTBOX_AGE_ID] = "Возраст",
    [TEXTBOX_AC_ID] = "KД",
    [TEXTBOX_HP_MAX_ID] = "",
    [TEXTBOX_HP_TEMPORARY_ID] = "",
    [TEXTBOX_HIT_DICES_ID] = "",
    [TEXTBOX_INITIATIVE_ID] = "+0",
    [TEXTBOX_SPEED_ID] = "",
    [TEXTBOX_VISION_ID] = "обычное",
    [TEXTBOX_CURRENT_HIT_POINTS_ID] = "",
    [TEXTBOX_WEAPON_NAME_1_ID] = "Длинный меч",
    [TEXTBOX_WEAPON_NAME_2_ID] = "",
    [TEXTBOX_WEAPON_NAME_3_ID] = "",
    [TEXTBOX_WEAPON_NAME_4_ID] = "",
    [TEXTBOX_WEAPON_NAME_5_ID] = "",
    [TEXTBOX_WEAPON_NAME_6_ID] = "",
    [TEXTBOX_WEAPON_NAME_7_ID] = "",
    [TEXTBOX_HIT_1_ID] = "+0",
    [TEXTBOX_HIT_2_ID] = "",
    [TEXTBOX_HIT_3_ID] = "",
    [TEXTBOX_HIT_4_ID] = "",
    [TEXTBOX_HIT_5_ID] = "",
    [TEXTBOX_HIT_6_ID] = "",
    [TEXTBOX_HIT_7_ID] = "",
    [TEXTBOX_DAMAGE_DICE_COUNT_1_ID] = "1",
    [TEXTBOX_DAMAGE_DICE_COUNT_2_ID] = "",
    [TEXTBOX_DAMAGE_DICE_COUNT_3_ID] = "",
    [TEXTBOX_DAMAGE_DICE_COUNT_4_ID] = "",
    [TEXTBOX_DAMAGE_DICE_COUNT_5_ID] = "",
    [TEXTBOX_DAMAGE_DICE_COUNT_6_ID] = "",
    [TEXTBOX_DAMAGE_DICE_COUNT_7_ID] = "",
    [TEXTBOX_DAMAGE_DICE_TYPE_1_ID] = "8",
    [TEXTBOX_DAMAGE_DICE_TYPE_2_ID] = "",
    [TEXTBOX_DAMAGE_DICE_TYPE_3_ID] = "",
    [TEXTBOX_DAMAGE_DICE_TYPE_4_ID] = "",
    [TEXTBOX_DAMAGE_DICE_TYPE_5_ID] = "",
    [TEXTBOX_DAMAGE_DICE_TYPE_6_ID] = "",
    [TEXTBOX_DAMAGE_DICE_TYPE_7_ID] = "",
    [TEXTBOX_DAMAGE_BONUS_1_ID] = "+0",
    [TEXTBOX_DAMAGE_BONUS_2_ID] = "",
    [TEXTBOX_DAMAGE_BONUS_3_ID] = "",
    [TEXTBOX_DAMAGE_BONUS_4_ID] = "",
    [TEXTBOX_DAMAGE_BONUS_5_ID] = "",
    [TEXTBOX_DAMAGE_BONUS_6_ID] = "",
    [TEXTBOX_DAMAGE_BONUS_7_ID] = "",
    [TEXTBOX_NOTES_1_ID] = "рубящий",
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
    [TEXTBOX_PROFICIENCY_OTHER_ID] = "",
    [TEXTBOX_SKILL_STR_SAVETHROW_ID] = "0",
    [TEXTBOX_SKILL_ATHLETICS_ID] = "0",
    [TEXTBOX_SKILL_DEX_SAVETHROW_ID] = "0",
    [TEXTBOX_SKILL_ACROBATICS_ID] = "0",
    [TEXTBOX_SKILL_STEALTH_ID] = "0",
    [TEXTBOX_SKILL_SLEIGHT_OF_HAND_ID] = "0",
    [TEXTBOX_SKILL_CON_SAVETHROW_ID] = "0",
    [TEXTBOX_SKILL_INT_SAVETHROW_ID] = "0",
    [TEXTBOX_SKILL_ARCANA_ID] = "0",
    [TEXTBOX_SKILL_HISTORY_ID] = "0",
    [TEXTBOX_SKILL_INVESTIGATION_ID] = "0",
    [TEXTBOX_SKILL_NATURE_ID] = "0",
    [TEXTBOX_SKILL_RELIGION_ID] = "0",
    [TEXTBOX_SKILL_WIT_SAVETHROW_ID] = "0",
    [TEXTBOX_SKILL_ANIMAL_HANDLING_ID] = "0",
    [TEXTBOX_SKILL_INSIGHT_ID] = "0",
    [TEXTBOX_SKILL_MEDICINE_ID] = "0",
    [TEXTBOX_SKILL_PERCEPTION_ID] = "0",
    [TEXTBOX_SKILL_SURVIVAL_ID] = "0",
    [TEXTBOX_SKILL_CHA_SAVETHROW_ID] = "0",
    [TEXTBOX_SKILL_PERFORMANCE_ID] = "0",
    [TEXTBOX_SKILL_DECEPTION_ID] = "0",
    [TEXTBOX_SKILL_INTIMIDATION_ID] = "0",
    [TEXTBOX_SKILL_PERSUASION_ID] = "0",
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
        [CHECKBOX_SKILL_STR_SAVETHROW_ID] = {
            skillId = SKILL_STR_SAVETHROW_ID,
            pos     = {-1.123,0.1,-1.155},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_ATHLETICS_ID] = {
            skillId = SKILL_ATHLETICS_ID,
            pos     = {-1.123,0.1,-1.10},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_DEX_SAVETHROW_ID] = {
            skillId = SKILL_DEX_SAVETHROW_ID,
            pos     = {-1.123,0.1,-0.79},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_ACROBATICS_ID] = {
            skillId = SKILL_ACROBATICS_ID,
            pos     = {-1.123,0.1,-0.735},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_STEALTH_ID] = {
            skillId = SKILL_STEALTH_ID,
            pos     = {-1.123,0.1,-0.685},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_SLEIGHT_OF_HAND_ID] = {
            skillId = SKILL_SLEIGHT_OF_HAND_ID,
            pos     = {-1.123,0.1,-0.630},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_CON_SAVETHROW_ID] = {
            skillId = SKILL_CON_SAVETHROW_ID,
            pos     = {-1.123,0.1,-0.428},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_INT_SAVETHROW_ID] = {
            skillId = SKILL_INT_SAVETHROW_ID,
            pos     = {-1.123,0.1,-0.070},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_ARCANA_ID] = {
            skillId = SKILL_ARCANA_ID,
            pos     = {-1.123,0.1,-0.015},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_HISTORY_ID] = {
            skillId = SKILL_HISTORY_ID,
            pos     = {-1.123,0.1,0.040},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_INVESTIGATION_ID] = {
            skillId = SKILL_INVESTIGATION_ID,
            pos     = {-1.123,0.1,0.095},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_NATURE_ID] = {
            skillId = SKILL_NATURE_ID,
            pos     = {-1.123,0.1,0.150},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_RELIGION_ID] = {
            skillId = SKILL_RELIGION_ID,
            pos     = {-1.123,0.1,0.202},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_WIT_SAVETHROW_ID] = {
            skillId = SKILL_WIT_SAVETHROW_ID,
            pos     = {-1.123,0.1,0.30},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_ANIMAL_HANDLING_ID] = {
            skillId = SKILL_ANIMAL_HANDLING_ID,
            pos     = {-1.123,0.1,0.355},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_INSIGHT_ID] = {
            skillId = SKILL_INSIGHT_ID,
            pos     = {-1.123,0.1,0.410},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_MEDICINE_ID] = {
            skillId = SKILL_MEDICINE_ID,
            pos     = {-1.123,0.1,0.46},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_PERCEPTION_ID] = {
            skillId = SKILL_PERCEPTION_ID,
            pos     = {-1.123,0.1,0.51},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_SURVIVAL_ID] = {
            skillId = SKILL_SURVIVAL_ID,
            pos     = {-1.123,0.1,0.565},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_CHA_SAVETHROW_ID] = {
            skillId = SKILL_CHA_SAVETHROW_ID,
            pos     = {-1.123,0.1,0.67},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_PERFORMANCE_ID] = {
            skillId = SKILL_PERFORMANCE_ID,
            pos     = {-1.123,0.1,0.725},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_DECEPTION_ID] = {
            skillId = SKILL_DECEPTION_ID,
            pos     = {-1.123,0.1,0.775},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_INTIMIDATION_ID] = {
            skillId = SKILL_INTIMIDATION_ID,
            pos     = {-1.123,0.1,0.82},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SKILL_PERSUASION_ID] = {
            skillId = SKILL_PERSUASION_ID,
            pos     = {-1.123,0.1,0.875},
            size    = 150,
            state   = false
        },
        [CHECKBOX_LIGHT_ARMOR_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.26},
            size    = 150,
            state   = false
        },
        [CHECKBOX_MEDIUM_ARMOR_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.30},
            size    = 150,
            state   = false
        },
        [CHECKBOX_HEAVY_ARMOR_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.34},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SHIELD_ID] = {
            skillId = nil,
            pos     = {-1.430,0.1,1.38},
            size    = 150,
            state   = false
        },
        [CHECKBOX_SIMPLE_WEAPONS_ID] = {
            skillId = nil,
            pos     = {-1.2,0.1,1.26},
            size    = 150,
            state   = false
        },
        [CHECKBOX_MARTIAL_WEAPONS_ID] = {
            skillId = nil,
            pos     = {-1.2,0.1,1.30},
            size    = 150,
            state   = false
        },
        [CHECKBOX_DEATH_SAVETHROW_SUCCESS_1_ID] = {
            skillId = nil,
            pos     = {0.825,0.1,-1.08},
            size    = 200,
            state   = false
        },
        [CHECKBOX_DEATH_SAVETHROW_SUCCESS_2_ID] = {
            skillId = nil,
            pos     = {0.895,0.1,-1.08},
            size    = 200,
            state   = false
        },
        [CHECKBOX_DEATH_SAVETHROW_SUCCESS_3_ID] = {
            skillId = nil,
            pos     = {0.96,0.1,-1.08},
            size    = 200,
            state   = false
        },
        [CHECKBOX_DEATH_SAVETHROW_FAIL_1_ID] = {
            skillId = nil,
            pos     = {0.825,0.1,-1.015},
            size    = 200,
            state   = false
        },
        [CHECKBOX_DEATH_SAVETHROW_FAIL_2_ID] = {
            skillId = nil,
            pos     = {0.895,0.1,-1.015},
            size    = 200,
            state   = false
        },
        [CHECKBOX_DEATH_SAVETHROW_FAIL_3_ID] = {
            skillId = nil,
            pos     = {0.96,0.1,-1.015},
            size    = 200,
            state   = false
        },
        [CHECKBOX_WEIGHT_CAPACITY_X_2] = {
            skillId = nil,
            pos     = {0.392,0.1,1.937},
            size    = 150,
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

        [COUNTER_PARAM_STR_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_STR_ID,
            btnSubId = "counter_btn_sub_"..PARAM_STR_ID,
            hideBG   = true,
            paramId  = PARAM_STR_ID,
            pos      = {-1.35,0.1,-1.025},
            size     = 450,
            value    = 10,
        },
        [COUNTER_PARAM_DEX_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_DEX_ID,
            btnSubId = "counter_btn_sub_"..PARAM_DEX_ID,
            hideBG   = true,
            paramId  = PARAM_DEX_ID,
            pos      = {-1.35,0.1,-0.662},
            size     = 450,
            value    = 10,
        },
        [COUNTER_PARAM_CON_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_CON_ID,
            btnSubId = "counter_btn_sub_"..PARAM_CON_ID,
            hideBG   = true,
            paramId  = PARAM_CON_ID,
            pos      = {-1.35,0.1,-0.299},
            size     = 450,
            value    = 10,
        },
        [COUNTER_PARAM_INT_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_INT_ID,
            btnSubId = "counter_btn_sub_"..PARAM_INT_ID,
            hideBG   = true,
            paramId  = PARAM_INT_ID,
            pos      = {-1.35,0.1,0.064},
            size     = 450,
            value    = 10,
        },
        [COUNTER_PARAM_WIT_ID] = {
            btnAddId = "counter_btn_add_"..PARAM_WIT_ID,
            btnSubId = "counter_btn_sub_"..PARAM_WIT_ID,
            hideBG   = true,
            paramId  = PARAM_WIT_ID,
            pos      = {-1.35,0.1,0.427},
            size     = 450,
            value    = 10,
        },
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
        [DISPLAY_PARAM_STR_ID] = {
            paramId = PARAM_STR_ID,
            pos     = {-1.35,0.1,-1.14},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_PARAM_DEX_ID] = {
            paramId = PARAM_DEX_ID,
            pos     = {-1.35,0.1,-0.77},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_PARAM_CON_ID] = {
            paramId = PARAM_CON_ID,
            pos     = {-1.35,0.1,-0.41},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_PARAM_INT_ID] = {
            paramId = PARAM_INT_ID,
            pos     = {-1.35,0.1,-0.05},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_PARAM_WIT_ID] = {
            paramId = PARAM_WIT_ID,
            pos     = {-1.35,0.1,0.31},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_PARAM_CHA_ID] = {
            paramId = PARAM_CHA_ID,
            pos     = {-1.35,0.1,0.68},
            size    = 450,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_STR_SAVETHROW_ID] = {
            skillId = SKILL_STR_SAVETHROW_ID,
            pos     = {-0.973,0.1,-1.16},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_ATHLETICS_ID] = {
            skillId = SKILL_ATHLETICS_ID,
            pos     = {-0.973,0.1,-1.11},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_DEX_SAVETHROW_ID] = {
            skillId = SKILL_DEX_SAVETHROW_ID,
            pos     = {-0.973,0.1,-0.795},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_ACROBATICS_ID] = {
            skillId = SKILL_ACROBATICS_ID,
            pos     = {-0.973,0.1,-0.745},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_STEALTH_ID] = {
            skillId = SKILL_STEALTH_ID,
            pos     = {-0.973,0.1,-0.695},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_SLEIGHT_OF_HAND_ID] = {
            skillId = SKILL_SLEIGHT_OF_HAND_ID,
            pos     = {-0.973,0.1,-0.645},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_CON_SAVETHROW_ID] = {
            skillId = SKILL_CON_SAVETHROW_ID,
            pos     = {-0.973,0.1,-0.435},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_INT_SAVETHROW_ID] = {
            skillId = SKILL_INT_SAVETHROW_ID,
            pos     = {-0.973,0.1,-0.07},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_ARCANA_ID] = {
            skillId = SKILL_ARCANA_ID,
            pos     = {-0.973,0.1,-0.0215},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_HISTORY_ID] = {
            skillId = SKILL_HISTORY_ID,
            pos     = {-0.973,0.1,0.031},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_INVESTIGATION_ID] = {
            skillId = SKILL_INVESTIGATION_ID,
            pos     = {-0.973,0.1,0.0825},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_NATURE_ID] = {
            skillId = SKILL_NATURE_ID,
            pos     = {-0.973,0.1,0.135},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_RELIGION_ID] = {
            skillId = SKILL_RELIGION_ID,
            pos     = {-0.973,0.1,0.185},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_WIT_SAVETHROW_ID] = {
            skillId = SKILL_WIT_SAVETHROW_ID,
            pos     = {-0.973,0.1,0.295},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_ANIMAL_HANDLING_ID] = {
            skillId = SKILL_ANIMAL_HANDLING_ID,
            pos     = {-0.973,0.1,0.345},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_INSIGHT_ID] = {
            skillId = SKILL_INSIGHT_ID,
            pos     = {-0.973,0.1,0.395},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_MEDICINE_ID] = {
            skillId = SKILL_MEDICINE_ID,
            pos     = {-0.973,0.1,0.445},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_PERCEPTION_ID] = {
            skillId = SKILL_PERCEPTION_ID,
            pos     = {-0.973,0.1,0.495},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_SURVIVAL_ID] = {
            skillId = SKILL_SURVIVAL_ID,
            pos     = {-0.973,0.1,0.55},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_CHA_SAVETHROW_ID] = {
            skillId = SKILL_CHA_SAVETHROW_ID,
            pos     = {-0.973,0.1,0.66},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_PERFORMANCE_ID] = {
            skillId = SKILL_PERFORMANCE_ID,
            pos     = {-0.973,0.1,0.708},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_DECEPTION_ID] = {
            skillId = SKILL_DECEPTION_ID,
            pos     = {-0.973,0.1,0.76},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_INTIMIDATION_ID] = {
            skillId = SKILL_INTIMIDATION_ID,
            pos     = {-0.973,0.1,0.813},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_SKILL_PERSUASION_ID] = {
            skillId = SKILL_PERSUASION_ID,
            pos     = {-0.973,0.1,0.863},
            size    = 250,
            value   = 0,
            hideBG  = true
        },
        [DISPLAY_PASSIVE_PERCEPTION_ID] = {
            pos    = {-1.35,0.1,1.03},
            size   = 450,
            value  = 10,
            hideBG = true,
        },
        [DISPLAY_WEIGHT_CAPACITY_ID] = {
            pos    = {-0.225,0.1,2.085},
            size   = 450,
            value  = 150,
            hideBG = true,
        },
        [DISPLAY_RAISE_LIFT_AND_PULL_ID] = {
            pos    = {0.225,0.1,2.085},
            size   = 450,
            value  = 300,
            hideBG = true,
        },
        [DISPLAY_JUMP_HEIGHT_ID] = {
            pos    = {0.05,0.1,1.76},
            size   = 350,
            value  = 3,
            hideBG = true,
        },
        [DISPLAY_JUMP_DISTANCE_ID] = {
            pos    = {0.05,0.1,1.695},
            size   = 350,
            value  = 10,
            hideBG = true,
        },
        [DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID] = {
            pos    = {0.05,0.1,1.825},
            size   = 350,
            value  = 3,
            hideBG = true,
        },
        [DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID] = {
            pos    = {0.34,0.1,1.76},
            size   = 350,
            value  = 1,
            hideBG = true,
        },
        [DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID] = {
            pos    = {0.34,0.1,1.695},
            size   = 350,
            value  = 5,
            hideBG = true,
        },
        [DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID] = {
            pos     = {0.34,0.1,1.825},
            size   = 350,
            value  = 1,
            hideBG = true,
        },
        [DISPLAY_LEVEL_ID] = {
            pos    = {-1.35,0.1,-1.285},
            size   = 600,
            value  = 1,
            hideBG = true,
        },
        [DISPLAY_NEXT_LVL_ID] = {
            pos    = {1.27,0.1,-1.835},
            size   = 300,
            value  = '/ 300',
            hideBG = true,
        },
        [DISPLAY_PROFICIENCY_ID] = {
            pos    = {-1.35,0.1,-1.45},
            size   = 650,
            value  = '+2',
            hideBG = true,
        },
        [DISPLAY_HIT_DICES_LEFT_ID] = {
            pos    = {0.75,0.1,-1.38},
            size   = 450,
            value  = ' 1/ 1к',
            hideBG = true,
        },
        [DISPLAY_MONET_WEIGHT_ID] = {
            pos    = {-0.22,0.11,0.677},
            size   = 150,
            value  = NET_MONET_TEXT,
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
        [TEXTBOX_NAME_ID] = {
            pos       = {-0.825,0.1,-1.900},
            rows      = 1,
            width     = 5000,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_CLASS_LEVEL_ID] = {
            pos       = {0.075,0.1,-1.975},
            rows      = 1,
            width     = 2500,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_BACKGROUND_ID] = {
            pos       = {0.612,0.1,-1.975},
            rows      = 1,
            width     = 2600,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_PLAYERS_NAME_ID] = {
            pos       = {1.14,0.1,-1.975},
            rows      = 1,
            width     = 2400,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_RACE_ID] = {
            pos       = {0.075,0.1,-1.835},
            rows      = 1,
            width     = 2500,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_ALIGMENT_ID] = {
            pos       = {0.612,0.1,-1.835},
            rows      = 1,
            width     = 2600,
            font_size = 350,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_XP_ID] = {
            pos        = {1.015,0.1,-1.835},
            rows       = 1,
            width      = 1200,
            font_size  = 350,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_AGE_ID] = {
            pos        = {-0.671,0.1,1.24},
            rows       = 1,
            width      = 1200,
            font_size  = 300,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_AC_ID] = {
            pos        = {-0.265,0.1,-1.425},
            rows       = 1,
            width      = 750,
            font_size  = 450,
            value      = "10",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_HP_MAX_ID] = {
            pos        = {0.045,0.1,-1.425},
            rows       = 1,
            width      = 750,
            font_size  = 450,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_HP_TEMPORARY_ID] = {
            pos        = {0.355,0.1,-1.425},
            rows       = 1,
            width      = 750,
            font_size  = 450,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_HIT_DICES_ID] = {
            pos        = {0.93,0.1,-1.38},
            rows       = 1,
            width      = 500,
            font_size  = 450,
            value      = "",
            alignment  = 1,
            validation = 2,
        },
        [TEXTBOX_INITIATIVE_ID] = {
            pos       = {1.25,0.1,-1.45},
            rows      = 1,
            width     = 750,
            font_size = 450,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_SPEED_ID] = {
            pos       = {1.25,0.1,-1.225},
            rows      = 1,
            width     = 1000,
            font_size = 450,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_VISION_ID] = {
            pos       = {1.25,0.1,-1.0},
            rows      = 1,
            width     = 1500,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_CURRENT_HIT_POINTS_ID] = {
            pos        = {0.035,0.1,-1.09},
            rows       = 1,
            width      = 3800,
            font_size  = 750,
            value      = "",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_WEAPON_NAME_1_ID] = {
            pos       = {-0.08,0.1,-0.71 },
            rows      = 1,
            width     = 3350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_WEAPON_NAME_2_ID] = {
            pos       = {-0.08,0.1,-0.632},
            rows      = 1,
            width     = 3350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_WEAPON_NAME_3_ID] = {
            pos       = {-0.08,0.1,-0.554},
            rows      = 1,
            width     = 3350,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_WEAPON_NAME_4_ID] = {
            pos       = {-0.08,0.1,-0.476},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_WEAPON_NAME_5_ID] = {
            pos       = {-0.08,0.1,-0.398},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_WEAPON_NAME_6_ID] = {
            pos       = {-0.08,0.1,-0.320},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_WEAPON_NAME_7_ID] = {
            pos       = {-0.08,0.1,-0.242},
            rows      = 1,
            width     = 3350,
            font_size = 310,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_HIT_1_ID] = {
            pos       = {0.375, 0.1, -0.71},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_HIT_2_ID] = {
            pos       = {0.375, 0.1, -0.632},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_HIT_3_ID] = {
            pos       = {0.375, 0.1, -0.554},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_HIT_4_ID] = {
            pos       = {0.375, 0.1, -0.476},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_HIT_5_ID] = {
            pos       = {0.375, 0.1, -0.398},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_HIT_6_ID] = {
            pos       = {0.375, 0.1, -0.320},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_HIT_7_ID] = {
            pos       = {0.375, 0.1, -0.242},
            rows      = 1,
            width     = 800,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_1_ID] = {
            pos        = {0.5155,0.1,-0.71},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_2_ID] = {
            pos        = {0.5155,0.1,-0.632},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_3_ID] = {
            pos        = {0.5155,0.1,-0.554},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_4_ID] = {
            pos        = {0.5155,0.1,-0.476},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_5_ID] = {
            pos        = {0.5155,0.1,-0.398},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_6_ID] = {
            pos        = {0.5155,0.1,-0.320},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_COUNT_7_ID] = {
            pos        = {0.5155,0.1,-0.242},
            rows       = 1,
            width      = 420,
            font_size  = 300,
            value      = "",
            alignment  = 4,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_1_ID] = {
            pos        = {0.625,0.1,-0.71},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_2_ID] = {
            pos        = {0.625,0.1,-0.632},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_3_ID] = {
            pos        = {0.625,0.1,-0.554},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_4_ID] = {
            pos        = {0.625,0.1,-0.476},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_5_ID] = {
            pos        = {0.625,0.1,-0.398},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_6_ID] = {
            pos        = {0.625,0.1,-0.320},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_DICE_TYPE_7_ID] = {
            pos        = {0.625,0.1,-0.242},
            rows       = 1,
            width      = 400,
            font_size  = 300,
            value      = "",
            alignment  = 2,
            validation = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_1_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.71},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_2_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.632},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_3_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.554},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_4_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.476},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_5_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.398},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_6_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.320},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_DAMAGE_BONUS_7_ID] = {
            pos       = {-0.205 + 0.9475,0.1,-0.242},
            rows      = 1,
            width     = 600,
            font_size = 300,
            value     = "",
            alignment = 2,
        },
        [TEXTBOX_NOTES_1_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.71},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },

        [TEXTBOX_NOTES_2_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.632},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_NOTES_3_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.554},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_NOTES_4_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.476},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_NOTES_5_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.398},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_NOTES_6_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.320},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_NOTES_7_ID] = {
            pos       = {-0.151 + 1.29,0.1,-0.242},
            rows      = 1,
            width     = 3100,
            font_size = 300,
            value     = "",
            alignment = 3
        },
        [TEXTBOX_COPPER_COINS_ID] = {
            pos        = {-0.35,0.1,0.04},
            rows       = 1,
            width      = 850,
            font_size  = 280,
            value      = "",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SILVER_COINS_ID] = {
            pos        = {-0.35,0.1,0.18},
            rows       = 1,
            width      = 850,
            font_size  = 280,
            value      = "",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_ELECTRUM_COINS_ID] = {
            pos        = {-0.35,0.1,0.315},
            rows       = 1,
            width      = 850,
            font_size  = 280,
            value      = "",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_GOLD_COINS_ID] = {
            pos        = {-0.35,0.1,0.455},
            rows       = 1,
            width      = 850,
            font_size  = 280,
            value      = "",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_PLATINUM_COINS_ID] = {
            pos        = {-0.35,0.1,0.6},
            rows       = 1,
            width      = 850,
            font_size  = 280,
            value      = "",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_EQUIPMENT_1_ID] = {
            pos       = {0.1335,0.1,0.31},
            rows      = 11,
            width     = 3300,
            font_size = 300,
            value     = "",
            alignment = 2
        },
        [TEXTBOX_EQUIPMENT_2_ID] = {
            pos       = {0.015,0.1,1.1},
            rows      = 13,
            width     = 4425,
            font_size = 300,
            value     = "",
            alignment = 2
        },
        [TEXTBOX_CLASS_RACE_CHARACTERISTICS_ID] = {
            pos       = {1.01,0.1,1.02},
            rows      = 41,
            width     = 4550,
            font_size = 250,
            value     = "",
            alignment = 2
        },
        [TEXTBOX_HEIGHT_ID] = {
            pos        = {-0.671,0.1,1.315},
            rows       = 1,
            width      = 1200,
            font_size  = 300,
            value      = "0",
            alignment  = 3,
            validation = 3,
        },
        [TEXTBOX_WEIGHT_ID] = {
            pos        = {-0.671,0.1,1.39},
            rows       = 1,
            width      = 1200,
            font_size  = 300,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_PROFICIENCY_OTHER_ID] = {
            pos       = {-1,0.1,1.78},
            rows      = 10,
            width     = 4350,
            font_size = 300,
            value     = "",
            alignment = 2
        },
        [TEXTBOX_SKILL_STR_SAVETHROW_ID] = {
            skillId    = SKILL_STR_SAVETHROW_ID,
            pos        = {-1.055,0.1,-1.165},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_ATHLETICS_ID] = {
            skillId    = SKILL_ATHLETICS_ID,
            pos        = {-1.055,0.1,-1.1105},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_DEX_SAVETHROW_ID] = {
            skillId    = SKILL_DEX_SAVETHROW_ID,
            pos        = {-1.055,0.1,-0.8},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_ACROBATICS_ID] = {
            skillId    = SKILL_ACROBATICS_ID,
            pos        = {-1.055,0.1,-0.745},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_STEALTH_ID] = {
            skillId    = SKILL_STEALTH_ID,
            pos        = {-1.055,0.1,-0.695},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_SLEIGHT_OF_HAND_ID] = {
            skillId    = SKILL_SLEIGHT_OF_HAND_ID,
            pos        = {-1.055,0.1,-0.645},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_CON_SAVETHROW_ID] = {
            skillId    = SKILL_CON_SAVETHROW_ID,
            pos        = {-1.055,0.1,-0.435},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_INT_SAVETHROW_ID] = {
            skillId    = SKILL_INT_SAVETHROW_ID,
            pos        = {-1.055,0.1,-0.075},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_ARCANA_ID] = {
            skillId    = SKILL_ARCANA_ID,
            pos        = {-1.055,0.1,-0.0215},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_HISTORY_ID] = {
            skillId    = SKILL_HISTORY_ID,
            pos        = {-1.055,0.1,0.031},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_INVESTIGATION_ID] = {
            skillId    = SKILL_INVESTIGATION_ID,
            pos        = {-1.055,0.1,0.0825},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_NATURE_ID] = {
            skillId    = SKILL_NATURE_ID,
            pos        = {-1.055,0.1,0.135},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_RELIGION_ID] = {
            skillId    = SKILL_RELIGION_ID,
            pos        = {-1.055,0.1,0.185},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_WIT_SAVETHROW_ID] = {
            skillId    = SKILL_WIT_SAVETHROW_ID,
            pos        = {-1.055,0.1,0.29},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_ANIMAL_HANDLING_ID] = {
            skillId    = SKILL_ANIMAL_HANDLING_ID,
            pos        = {-1.055,0.1,0.345},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_INSIGHT_ID] = {
            skillId    = SKILL_INSIGHT_ID,
            pos        = {-1.055,0.1,0.395},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_MEDICINE_ID] = {
            skillId    = SKILL_MEDICINE_ID,
            pos        = {-1.055,0.1,0.445},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_PERCEPTION_ID] = {
            skillId    = SKILL_PERCEPTION_ID,
            pos        = {-1.055,0.1,0.495},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_SURVIVAL_ID] = {
            skillId    = SKILL_SURVIVAL_ID,
            pos        = {-1.055,0.1,0.55},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_CHA_SAVETHROW_ID] = {
            skillId    = SKILL_CHA_SAVETHROW_ID,
            pos        = {-1.055,0.1,0.655},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_PERFORMANCE_ID] = {
            skillId    = SKILL_PERFORMANCE_ID,
            pos        = {-1.055,0.1,0.708},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_DECEPTION_ID] = {
            skillId    = SKILL_DECEPTION_ID,
            pos        = {-1.055,0.1,0.76},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_INTIMIDATION_ID] = {
            skillId    = SKILL_INTIMIDATION_ID,
            pos        = {-1.055,0.1,0.813},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        [TEXTBOX_SKILL_PERSUASION_ID] = {
            skillId    = SKILL_PERSUASION_ID,
            pos        = {-1.055,0.1,0.863},
            rows       = 1,
            width      = TEXTBOX_SKILL_width,
            font_size  = TEXTBOX_SKILL_fontSize,
            value      = "0",
            alignment  = 3,
            validation = 2,
        },
        --End of textboxes
    },
    --Add display
    roll = {
        [ROLL_PARAM_STR_ID] = {
            pos       = {-1.355, 0.1, -0.95},
            paramId   = PARAM_STR_ID,
            width     = 1500,
            font_size = 250,
        },
        [ROLL_PARAM_DEX_ID] = {
            pos       = {-1.355, 0.1, -0.584},
            paramId   = PARAM_DEX_ID,
            width     = 1500,
            font_size = 250,
        },
        [ROLL_PARAM_CON_ID] = {
            pos       = {-1.355, 0.1, -0.218},
            paramId   = PARAM_CON_ID,
            width     = 1500,
            font_size = 210,
        },
        [ROLL_PARAM_INT_ID] = {
            pos       = {-1.355, 0.1, 0.148},
            paramId   = PARAM_INT_ID,
            width     = 1500,
            font_size = 250,
        },
        [ROLL_PARAM_WIT_ID] = {
            pos       = {-1.355, 0.1, 0.514},
            paramId   = PARAM_WIT_ID,
            width     = 1500,
            font_size = 250,
        },
        [ROLL_PARAM_CHA_ID] = {
            pos       = {-1.355, 0.1, 0.88},
            paramId   = PARAM_CHA_ID,
            width     = 1500,
            font_size = 250,
        },
        [ROLL_SKILL_STR_SAVETHROW_ID] = {
            pos       = {0.2 - 0.931, 0.1, -1.16+0.004},
            skillId   = SKILL_STR_SAVETHROW_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_ATHLETICS_ID] = {
            pos       = {0.2 - 0.931, 0.1, -1.11+0.004},
            skillId   = SKILL_ATHLETICS_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_DEX_SAVETHROW_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.795+0.004},
            skillId   = SKILL_DEX_SAVETHROW_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_ACROBATICS_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.745+0.004},
            skillId   = SKILL_ACROBATICS_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_STEALTH_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.695+0.004},
            skillId   = SKILL_STEALTH_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_SLEIGHT_OF_HAND_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.645+0.004},
            skillId   = SKILL_SLEIGHT_OF_HAND_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_CON_SAVETHROW_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.435+0.004},
            skillId   = SKILL_CON_SAVETHROW_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_INT_SAVETHROW_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.07+0.004},
            skillId   = SKILL_INT_SAVETHROW_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_ARCANA_ID] = {
            pos       = {0.2 - 0.931, 0.1, -0.0215+0.004},
            skillId   = SKILL_ARCANA_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_HISTORY_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.031+0.004},
            skillId   = SKILL_HISTORY_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_INVESTIGATION_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.0825+0.004},
            skillId   = SKILL_INVESTIGATION_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_NATURE_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.135+0.004},
            skillId   = SKILL_NATURE_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_RELIGION_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.185+0.004},
            skillId   = SKILL_RELIGION_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_WIT_SAVETHROW_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.295+0.004},
            skillId   = SKILL_WIT_SAVETHROW_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_ANIMAL_HANDLING_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.345+0.004},
            skillId   = SKILL_ANIMAL_HANDLING_ID,
            width     = 1950,
            height    = 180*1.4,
            font_size = 140,
        },
        [ROLL_SKILL_INSIGHT_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.395+0.004},
            skillId   = SKILL_INSIGHT_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_MEDICINE_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.445+0.004},
            skillId   = SKILL_MEDICINE_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_PERCEPTION_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.495+0.004},
            skillId   = SKILL_PERCEPTION_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_SURVIVAL_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.55+0.004},
            skillId   = SKILL_SURVIVAL_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_CHA_SAVETHROW_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.66+0.004},
            skillId   = SKILL_CHA_SAVETHROW_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_PERFORMANCE_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.708+0.004},
            skillId   = SKILL_PERFORMANCE_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_DECEPTION_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.76+0.004},
            skillId   = SKILL_DECEPTION_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_INTIMIDATION_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.813+0.004},
            skillId   = SKILL_INTIMIDATION_ID,
            width     = 1950,
            font_size = 180,
        },
        [ROLL_SKILL_PERSUASION_ID] = {
            pos       = {0.2 - 0.931, 0.1, 0.863+0.004},
            skillId   = SKILL_PERSUASION_ID,
            width     = 1950,
            font_size = 180,
        },
        -- End of Display
    },

    lvl = 1,
    lvlByExp = 1,
    lvlByExpProficiency = 2,
    hitDiceLeft = 1,
    monetWeight = 0,
}

local lvlUpdateBtnConditionOFF = {
    click_function = "click_none",
    color          = buttonColor,
    font_color     = buttonFontColor,
    font_size      = 0,
    function_owner = self,
    height         = 0,
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
        local loaded_data = JSON.decode(saved_data)
        ref_buttonData = loaded_data
        --ref_buttonData = defaultButtonData
    else
        ref_buttonData = defaultButtonData
    end

    spawnedButtonCount = 0

    createCheckbox()
    createCounter()
    createTextbox()
    createDisplay()
    createRolls()

    updateJumpAndWeight()
    createLvlUpdateBtn()
    createHitDiceCounters()
    updateMonetWeight()

    lvlRefresh()
end

--Click functions for buttons

--Checks or unchecks the given box
function click_checkbox(checkboxId)
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

    updateJumpAndWeight()
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

        -- Monet count change
        if (
               textboxId == TEXTBOX_COPPER_COINS_ID
            or textboxId == TEXTBOX_SILVER_COINS_ID
            or textboxId == TEXTBOX_ELECTRUM_COINS_ID
            or textboxId == TEXTBOX_GOLD_COINS_ID
            or textboxId == TEXTBOX_PLATINUM_COINS_ID
        ) then
            updateMonetWeight()
        end

        updateSave()
    end
end

function updateMonetWeight()
    local coinTextBoxIdList = {
        TEXTBOX_COPPER_COINS_ID,
        TEXTBOX_SILVER_COINS_ID,
        TEXTBOX_ELECTRUM_COINS_ID,
        TEXTBOX_GOLD_COINS_ID,
        TEXTBOX_PLATINUM_COINS_ID,
    }

    local singleCoinWeight = 0.02

    local coinTotalCount = 0
    for i, coinTextBoxId in ipairs(coinTextBoxIdList) do
        local coinCount = ref_buttonData.textbox[coinTextBoxId].value
        if not (coinCount == nil or coinCount == "") then
            coinTotalCount = coinTotalCount + tonumber(coinCount)
        end
    end

    local coinTotalWeight = math.ceil(singleCoinWeight * coinTotalCount)
    local kgTotalWeight = math.ceil(coinTotalWeight * POUND_PER_KG)
    local poundText = declensionRus(coinTotalWeight, 'фунт', 'фунта', 'фунтов')
    local text = "Вес монет: "..coinTotalWeight.." "..poundText.." ("..kgTotalWeight.." кг)"
    if coinTotalWeight == 0 then
        text = NET_MONET_TEXT
    end

    ref_buttonData.monetWeight = coinTotalWeight
    checkOvercumbrance()

    ref_buttonData.display[DISPLAY_MONET_WEIGHT_ID].value = text
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_MONET_WEIGHT_ID],
        label = text,
        value = text,
    })
end

function checkOvercumbrance()
    local redBtnParams = {
        color = { 1, 0, 0 },
        font_color = { 1, 1, 1 },
        width = 1500,
        height = 500,
        tooltip = 'Перегруз',
    }
    local normalBtnParams = {
        color = buttonColor,
        font_color = buttonFontColor,
        width = 0,
        height = 0,
        tooltip = nil,
    }

    local weightLimits = {
        DISPLAY_WEIGHT_CAPACITY_ID,
        DISPLAY_RAISE_LIFT_AND_PULL_ID,
    }
    for i, weightLimitDisplayId in ipairs(weightLimits) do
        if ref_buttonData.monetWeight > ref_buttonData.display[weightLimitDisplayId].value then
            local params = redBtnParams
            params.index = btnIndexByElementIdTable[weightLimitDisplayId]
            self.editButton(params)
        else
            local params = normalBtnParams
            params.index = btnIndexByElementIdTable[weightLimitDisplayId]
            self.editButton(params)
        end
    end
end

function declensionRus(num, singleText, doubleText, multipleText)
    local numPart = math.fmod(math.abs(num), 100)

    if numPart > 9 and numPart < 20 then
        return multipleText
    else
        local shortPart = math.fmod(numPart, 10)

        if shortPart == 1 then
            return singleText
        end
        if shortPart > 1 and shortPart < 5 then
            return doubleText
        else
            return multipleText
        end
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
    local weightCapacityKoef = 1
    if ref_buttonData.checkbox[CHECKBOX_WEIGHT_CAPACITY_X_2].state == true then
        weightCapacityKoef = 2
    end

    -- Update Weight Capacity
    weightCapacity = ref_buttonData.counter[COUNTER_PARAM_STR_ID].value * 15 * weightCapacityKoef
    ref_buttonData.display[DISPLAY_WEIGHT_CAPACITY_ID].value = weightCapacity
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_WEIGHT_CAPACITY_ID],
        label = weightCapacity,
    })

    -- Update Raise, Lift and Pull
    raiseLiftPullCapacity = weightCapacity * 2
    ref_buttonData.display[DISPLAY_RAISE_LIFT_AND_PULL_ID].value = raiseLiftPullCapacity
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_RAISE_LIFT_AND_PULL_ID],
        label = raiseLiftPullCapacity,
    })

    -- Update Jump Height
    jumpHeight = ref_buttonData.display[DISPLAY_PARAM_STR_ID].value + 3
    ref_buttonData.display[DISPLAY_JUMP_HEIGHT_ID].value = jumpHeight
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_ID],
        label = jumpHeight,
    })

    -- Update Jump Distance
    jumpDistance = ref_buttonData.counter[COUNTER_PARAM_STR_ID].value
    ref_buttonData.display[DISPLAY_JUMP_DISTANCE_ID].value = jumpDistance
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
    ref_buttonData.display[DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID].value = jumpHeightWithHands
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_WITH_HANDS_ID],
        label = jumpHeightWithHands,
    })

    -- Update Jump Height — no running
    jumpHeightNoRunning = math.floor(jumpHeight / 2)
    ref_buttonData.display[DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID].value = jumpHeightNoRunning
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_NO_RUNNING_ID],
        el = jumpHeightNoRunning,
    })

    -- Update Jump Distance — no running
    jumpDistanceNoRunning = math.floor(jumpDistance / 2)
    ref_buttonData.display[DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID].value = jumpDistanceNoRunning
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_DISTANCE_NO_RUNNING_ID],
        label = jumpDistanceNoRunning,
    })

    -- Update Jump Height with Hands — no running
    jumpHeightWithHandsNoRunning = jumpHeightNoRunning + characterOneAndHalfHeight
    ref_buttonData.display[DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID].value = jumpHeightWithHandsNoRunning
    self.editButton({
        index = btnIndexByElementIdTable[DISPLAY_JUMP_HEIGHT_WITH_HANDS_NO_RUNNING_ID],
        label = jumpHeightWithHandsNoRunning,
    })

    checkOvercumbrance()
end

-- Lvl update btn - Activate/Deactivate
function setLvlUpdateBtnCondition(doActivate)
    if doActivate then
        self.editButton({
            click_function = "onClickLvlUpdateBtn",
            color          = buttonColor,
            font_color     = buttonFontColor,
            font_size      = 350,
            function_owner = self,
            height         = 500,
            index          = btnIndexByElementIdTable.lvlUpdateBtn,
            label          = 'Обновить уровень ('..ref_buttonData.lvlByExp..')',
            position       = {1.040,0.1,-1.655},
            scale          = buttonScale,
            width          = 4000,
        })
    else
        lvlUpdateBtnConditionOFF.index = btnIndexByElementIdTable.lvlUpdateBtn
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

--Makes rolls
function createRolls()
    for rollId, data in pairs(ref_buttonData.roll) do
        local label = rollLabelCollection[rollId] or ''
        local tooltip = rollTextCollection[rollId]
        local height = data.height or data.font_size * 1.4

        local funcName = rollId
        local func = function(obj, playerColor)
            rollParam(rollId, data.paramId, data.skillId, obj, playerColor)
        end
        self.setVar(funcName, func)

        createBtnAndSaveIndex(
            rollId,
            {
                click_function = funcName,
                color          = buttonColor,
                font_color     = buttonFontColor,
                font_size      = data.font_size,
                function_owner = self,
                height         = height,
                label          = label,
                position       = data.pos,
                scale          = buttonScale,
                tooltip        = tooltip,
                width          = data.width,
            }
        )
    end
end

function colorToHex(color)
    local rHex, gHex, bHex = decimalToHex(color.r), decimalToHex(color.g), decimalToHex(color.b)

    return rHex .. '' .. gHex .. '' .. bHex
end

function decimalToHex(decimalNum)
    if decimalNum == 0 then
        return '00'
    else
        local hexStr = string.format("%X", math.floor(decimalNum * 256) - 1)
        local gapper = ''
        if string.len(hexStr) == 1 then
            gapper = '0'
        end

        return gapper .. hexStr
    end
end

function rollParam(rollId, paramId, skillId, obj, playerColor)
    local paramBonusText = ''
    local skillBonusText = ''

    local paramBonus = 0
    local skillBonus = 0

    if (skillId == nil) then
        paramBonus = ref_buttonData.display["display_"..paramId].value

        local paramBonusSign = '+'
        if paramBonus < 0 then
            paramBonusSign = '−'
        end
        paramBonusText = ' '..paramBonusSign..' '..math.abs(paramBonus)
    else
        skillBonus = tonumber(ref_buttonData.display["display_"..skillId].value)

        local skillBonusSign = '+'
        if skillBonus < 0 then
            skillBonusSign = '−'
        end

        skillBonusText = ' '..skillBonusSign..' '..math.abs(skillBonus)
    end

    local roll20 = d20()
    local result = roll20 + paramBonus + skillBonus

    local steam_name = Player[playerColor].steam_name
    local charSheetName = obj.getName()
    local playerColorRBB = convertColorNameIntoRgbString(playerColor)
    local charSheetColor = colorToHex(obj.getColorTint())
    local rollName = rollTextCollection[rollId]

    broadcastToAll(
        '['..playerColorRBB..']'..
        steam_name..'[-]: '
        ..rollName..' для ['..charSheetColor..'][i]'..charSheetName..'[/i][-]: '
        ..roll20
        ..paramBonusText
        ..skillBonusText
        ..' = [b]'..result..'[/b]'
    )
end

function convertColorNameIntoRgbString(colorName)
    -- See https://api.tabletopsimulator.com/player-color/
    local colorTable = {
        White = {r = 1, g = 1, b = 1},
        Brown = {r = 0.443, g = 0.231, b = 0.09},
        Red = {r = 0.856, g = 0.1, b = 0.094},
        Orange = {r = 0.956, g = 0.392, b = 0.113},
        Yellow = {r = 0.905, g = 0.898, b = 0.172},
        Green = {r = 0.192, g = 0.701, b = 0.168},
        Teal = {r = 0.129, g = 0.694, b = 0.607},
        Blue = {r = 0.118, g = 0.53, b = 1},
        Purple = {r = 0.627, g = 0.125, b = 0.941},
        Pink = {r = 0.96, g = 0.439, b = 0.807},
        Grey = {r = 0.5, g = 0.5, b = 0.5},
        Black = {r = 0.25, g = 0.25, b = 0.25},
    }

    return colorToHex(colorTable[colorName])
end

function d20()
    return dX(20)
end

function dX(diceSize)
    return math.random(1, diceSize)
end

--Makes textbox
function createTextbox()
    for textboxId, data in pairs(ref_buttonData.textbox) do
        --Sets up reference function
        local funcName = "textbox_"..textboxId
        local func = function(_, _, val, sel)
            click_textbox(val, sel, textboxId)
        end

        local validation = 1 -- None
        if data.validation then
            validation = data.validation
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
            validation     = validation,
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
