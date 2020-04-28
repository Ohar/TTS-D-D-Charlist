--[[    Character Sheet Template    by: MrStump
Customization Scripted_Sheet_DnD5e_PTv1_6 by: Nymeros

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
disableSave = true
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

--This is the button placement information
defaultButtonData = {
    --Add checkboxes
    checkbox = {
        --[[
        pos   = the position (pasted from the helper tool)
        size  = height/width/font_size for checkbox
        state = default starting value for checkbox (true=checked, false=not)
        ]]
        -- tableIndex Perícia {1 to 24} // Proficiency {25 to 30} // Jogadas de Morte {31 to 36}
        -- buttonIndex Perícia {0 to 23} // Proficiency {24 to 29} // Jogadas de Morte {30 to 35}

        -- 1 checkbox STR savethrow
        {
            pos   = {-1.123,0.1,-1.155},
            size  = 150,
            state = false
        },
        -- 2 checkbox Athletics
        {
            pos   = {-1.123,0.1,-1.10},
            size  = 150,
            state = false
        },
        -- 3 checkbox DEX savethrow
        {
            pos   = {-1.123,0.1,-0.79},
            size  = 150,
            state = false
        },
        -- 4 checkbox Acrobatics
        {
            pos   = {-1.123,0.1,-0.735},
            size  = 150,
            state = false
        },
        -- 5 checkbox Stealth
        {
            pos   = {-1.123,0.1,-0.685},
            size  = 150,
            state = false
        },
        -- 6 checkbox Sleight of hand
        {
            pos   = {-1.123,0.1,-0.630},
            size  = 150,
            state = false
        },
        -- 7 checkbox CON savethrow
        {
            pos   = {-1.123,0.1,-0.428},
            size  = 150,
            state = false
        },
        -- 8 checkbox INT savethrow
        {
            pos   = {-1.123,0.1,-0.070},
            size  = 150,
            state = false
        },
        -- 9 checkbox Arcane
        {
            pos   = {-1.123,0.1,-0.015},
            size  = 150,
            state = false
        },
        -- 10 checkbox History
        {
            pos   = {-1.123,0.1,0.040},
            size  = 150,
            state = false
        },
        -- 11 checkbox Investigation
        {
            pos   = {-1.123,0.1,0.095},
            size  = 150,
            state = false
        },
        -- 12 checkbox Nature
        {
            pos   = {-1.123,0.1,0.150},
            size  = 150,
            state = false
        },
        -- 13 checkbox Religion
        {
            pos   = {-1.123,0.1,0.202},
            size  = 150,
            state = false
        },
        -- 14 checkbox WIT savethrow
        {
            pos   = {-1.123,0.1,0.30},
            size  = 150,
            state = false
        },
        -- 15 checkbox Animal Handling
        {
            pos   = {-1.123,0.1,0.355},
            size  = 150,
            state = false
        },
        -- 16 checkbox Insight
        {
            pos   = {-1.123,0.1,0.410},
            size  = 150,
            state = false
        },
        -- 17 checkbox Medicine
        {
            pos   = {-1.123,0.1,0.46},
            size  = 150,
            state = false
        },
        -- 18 checkbox Perception
        {
            pos   = {-1.123,0.1,0.51},
            size  = 150,
            state = false
        },
        -- 19 checkbox Survival
        {
            pos   = {-1.123,0.1,0.565},
            size  = 150,
            state = false
        },
        -- 20 checkbox CHA savethrow
        {
            pos   = {-1.123,0.1,0.67},
            size  = 150,
            state = false
        },
        -- 21 checkbox Performance
        {
            pos   = {-1.123,0.1,0.725},
            size  = 150,
            state = false
        },
        -- 22 checkbox Deception
        {
            pos   = {-1.123,0.1,0.775},
            size  = 150,
            state = false
        },
        -- 23 checkbox Intimidation
        {
            pos   = {-1.123,0.1,0.82},
            size  = 150,
            state = false
        },
        -- 24 checkbox Persuasion
        {
            pos   = {-1.123,0.1,0.875},
            size  = 150,
            state = false
        },
        -- 25 checkbox Light Armor
        {
            pos   = {-1.430,0.1,1.26},
            size  = 150,
            state = false
        },
        -- 26 checkbox Medium Armor
        {
            pos   = {-1.430,0.1,1.30},
            size  = 150,
            state = false
        },
        -- 27 checkbox Heavy Armor
        {
            pos   = {-1.430,0.1,1.34},
            size  = 150,
            state = false
        },
        -- 28 checkbox Shield
        {
            pos   = {-1.430,0.1,1.38},
            size  = 150,
            state = false
        },
        -- 29 checkbox Simple Weapons
        {
            pos   = {-1.2,0.1,1.26},
            size  = 150,
            state = false
        },
        -- 30 checkbox Martial Weapons
        {
            pos   = {-1.2,0.1,1.30},
            size  = 150,
            state = false
        },
        -- 31 checkbox Death savethrow success 1
        {
            pos   = {0.825,0.1,-1.08},
            size  = 200,
            state = false
        },
        -- 32 checkbox Death savethrow success 2
        {
            pos   = {0.895,0.1,-1.08},
            size  = 200,
            state = false
        },
        -- 33 checkbox Death savethrow success 3
        {
            pos   = {0.96,0.1,-1.08},
            size  = 200,
            state = false
        },
        -- 34 checkbox Death savethrow fail 1
        {
            pos   = {0.825,0.1,-1.015},
            size  = 200,
            state = false
        },
        -- 35 checkbox Death savethrow fail 2
        {
            pos   = {0.895,0.1,-1.015},
            size  = 200,
            state = false
        },
        -- 36 checkbox Death savethrow fail 3
        {
            pos   = {0.96,0.1,-1.015},
            size  = 200,
            state = false
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
        {
            pos    = {-1.35,0.1,-1.025},
            size   = 450,
            value  = 10,
            hideBG = true
        },
        -- 2 counter DEX
        {
            pos    = {-1.35,0.1,-0.662},
            size   = 450,
            value  = 10,
            hideBG = true
        },
        -- 3 counter CON
        {
            pos    = {-1.35,0.1,-0.299},
            size   = 450,
            value  = 10,
            hideBG = true
        },
        -- 4 counter INT
        {
            pos    = {-1.35,0.1,0.064},
            size   = 450,
            value  = 10,
            hideBG = true
        },
        -- 5 counter WIT
        {
            pos    = {-1.35,0.1,0.427},
            size   = 450,
            value  = 10,
            hideBG = true
        },
        -- 6 counter CHA
        {
            pos    = {-1.35,0.1,0.790},
            size   = 450,
            value  = 10,
            hideBG = true
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
        {
            pos    = {-1.35,0.1,-1.14},
            size   = 450,
            value  = 0,
            hideBG = true
        },
        -- 2 display DEX
        {
            pos    = {-1.35,0.1,-0.77},
            size   = 450,
            value  = 0,
            hideBG = true
        },
        -- 3 display CON
        {
            pos    = {-1.35,0.1,-0.41},
            size   = 450,
            value  = 0,
            hideBG = true
        },
        -- 4 display INT
        {
            pos    = {-1.35,0.1,-0.05},
            size   = 450,
            value  = 0,
            hideBG = true
        },
        -- 5 display WIT
        {
            pos    = {-1.35,0.1,0.31},
            size   = 450,
            value  = 0,
            hideBG = true
        },
        -- 6 display CHA
        {
            pos    = {-1.35,0.1,0.68},
            size   = 450,
            value  = 0,
            hideBG = true
        },
        -- 7 display STR savethrow
        {
            pos    = {-0.973,0.1,-1.16},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 8 display Atletics
        {
            pos    = {-0.973,0.1,-1.11},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 9 display DEX savethrow
        {
            pos    = {-0.973,0.1,-0.795},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 10 display Acrobatics
        {
            pos    = {-0.973,0.1,-0.745},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 11 display Stealth
        {
            pos    = {-0.973,0.1,-0.695},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 12 display Sleight of Hand
        {
            pos    = {-0.973,0.1,-0.645},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 13 display CON savethrow
        {
            pos    = {-0.973,0.1,-0.435},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 14 display INT savethrow
        {
            pos    = {-0.973,0.1,-0.07},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 15 display Arcana
        {
            pos    = {-0.973,0.1,-0.0215},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 16 display History
        {
            pos    = {-0.973,0.1,0.031},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 17 display Investigation
        {
            pos    = {-0.973,0.1,0.0825},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 18 display Nature
        {
            pos    = {-0.973,0.1,0.135},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 19 display Religion
        {
            pos    = {-0.973,0.1,0.185},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 20 display WIT savethrow
        {
            pos    = {-0.973,0.1,0.295},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 21 display Animal Handling
        {
            pos    = {-0.973,0.1,0.345},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 22 display Insight
        {
            pos    = {-0.973,0.1,0.395},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 23 display Medicine
        {
            pos    = {-0.973,0.1,0.445},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 24 display Perception
        {
            pos    = {-0.973,0.1,0.495},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 25 display Survival
        {
            pos    = {-0.973,0.1,0.55},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 26 display CHA savethrow
        {
            pos    = {-0.973,0.1,0.66},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 27 display Performance
        {
            pos    = {-0.973,0.1,0.708},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 28 display Deception
        {
            pos    = {-0.973,0.1,0.76},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 29 display Intimidation
        {
            pos    = {-0.973,0.1,0.813},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 30 display Persuasion
        {
            pos    = {-0.973,0.1,0.863},
            size   = 250,
            value  = 0,
            hideBG = true
        },
        -- 31 display Passive Perception ButtonIndex 84
        {
            pos    = {-1.35,0.1,1.03},
            size   = 450,
            value  = 10,
            hideBG = true,
        },
        -- 32 display Weight Capacity
        {
            pos    = {-0.225,0.1,2.085},
            size   = 450,
            value  = 150,
            hideBG = true,
        },
        -- 33 display Raise, Lift and Pull
        {
            pos    = {0.225,0.1,2.085},
            size   = 450,
            value  = 300,
            hideBG = true,
        },
        -- 34 display Jump Height
        {
            pos     = {0.05,0.1,1.76},
            size   = 350,
            value  = 3,
            hideBG = true,
        },
        -- 35 display Jump Distance
        {
            pos    = {0.05,0.1,1.695},
            size   = 350,
            value  = 10,
            hideBG = true,
        },
        -- 36 display Jump Height with Hands
        {
            pos     = {0.05,0.1,1.825},
            size   = 350,
            value  = 3,
            hideBG = true,
        },
        -- 37 display Jump Height — no running
        {
            pos     = {0.34,0.1,1.76},
            size   = 350,
            value  = 1,
            hideBG = true,
        },
        -- 38 display Jump Distance — no running
        {
            pos    = {0.34,0.1,1.695},
            size   = 350,
            value  = 5,
            hideBG = true,
        },
        -- 39 display Jump Height with Hands — no running
        {
            pos     = {0.34,0.1,1.825},
            size   = 350,
            value  = 1,
            hideBG = true,
        },
        -- 40 Level
        {
            pos    = {-1.35,0.1,-1.285},
            size   = 600,
            value  = 1,
            hideBG = true,
        },
        -- 41 Exp for next LVL
        {
            pos    = {1.27,0.1,-1.835},
            size   = 300,
            value  = '/ 300',
            hideBG = true,
        },
        -- 42 Proficiency
        {
            pos    = {-1.35,0.1,-1.45},
            size   = 650,
            value  = '+2',
            hideBG = true,
        },
        -- 43 Hit Dices Left
        {
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
        label     = what is shown when there is no text. "" = nothing
        value     = text entered into box. "" = nothing
        alignment = Number to indicate how you want text aligned
                    (1=Automatic, 2=Left, 3=Center, 4=Right, 5=Justified)
        ]]
        -- Index (i) Card  {1 to 67} // Proficiency = 8 // Expertise {68 to 91}

        -- 1 textbox Name
        {
            pos       = {-0.825,0.1,-1.900},
            width     = 5000,
            font_size = 350,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 2 textbox Class & Level
        {
            pos       = {0.075,0.1,-1.975},
            width     = 2500,
            font_size = 350,
            label     = "Kласс",
            value     = "",
            alignment = 3
        },
        -- 3 textbox Background
        {
            pos       = {0.612,0.1,-1.975},
            width     = 2600,
            font_size = 350,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 4 textbox Player’s name
        {
            pos       = {1.14,0.1,-1.975},
            width     = 2400,
            font_size = 350,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 5 textbox Race
        {
            pos       = {0.075,0.1,-1.835},
            width     = 2500,
            font_size = 350,
            label     = "Pаса",
            value     = "",
            alignment = 3
        },
        -- 6 textbox Aligment
        {
            pos       = {0.612,0.1,-1.835},
            width     = 2600,
            font_size = 350,
            label     = "Mировоззрение",
            value     = "",
            alignment = 3
        },
        -- 7 textbox XP
        {
            pos       = {1.015,0.1,-1.835},
            width     = 1200,
            font_size = 350,
            label     = "Oпыт",
            value     = "0",
            alignment = 3,
            validation = 2
        },
        -- 8 textbox Damage Bonus 1
        {
            pos       = {0.7425,0.1,-0.71},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },
        -- 9 textbox Age
        {
            pos        = {-0.671,0.1,1.24},
            width      = 1200,
            font_size  = 300,
            label      = "Bозраст",
            value      = "0",
            alignment  = 3,
            validation = 2
        },
        -- 10 textbox AC
        {
            pos       = {-0.265,0.1,-1.425},
            width     = 750,
            font_size = 450,
            label     = "KД",
            value     = "10",
            alignment = 3,
            validation = 2
        },
        -- 11 textbox HP max
        {
            pos       = {0.045,0.1,-1.425},
            width     = 750,
            font_size = 450,
            label     = "",
            value     = "0",
            alignment = 3,
            validation = 2
        },
        -- 12 textbox HP temporary
        {
            pos       = {0.355,0.1,-1.425},
            width     = 750,
            font_size = 450,
            label     = "",
            value     = "0",
            alignment = 3,
            validation = 2
        },
        -- 13 textbox Hit Dices
        {
            pos       = {0.93,0.1,-1.38},
            width     = 500,
            font_size = 450,
            label     = "",
            value     = "",
            alignment = 1,
            validation = 2
        },
        -- 14 textbox Initiative
        {
            pos       = {1.25,0.1,-1.45},
            width     = 1800,
            font_size = 450,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 15 textbox Speed
        {
            pos       = {1.25,0.1,-1.225},
            width     = 1800,
            font_size = 450,
            label     = "30",
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 16 textbox Vision
        {
            pos       = {1.25,0.1,-1.0},
            width     = 1800,
            font_size = 400,
            label     = "обычное",
            value     = "",
            alignment = 3
        },
        -- 17 textbox Current Hit Points
        {
            pos       = {0.035,0.1,-1.09},
            width     = 3800,
            font_size = 750,
            label     = 0,
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 18 textbox Weapon Name1
        {
            pos       = {-0.08,0.1,-0.71 },
            width     = 3350,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 19 textbox Weapon Name2
        {
            pos       = {-0.08,0.1,-0.632},
            width     = 3350,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 20 textbox Weapon Name3
        {
            pos       = {-0.08,0.1,-0.554},
            width     = 3350,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 21 textbox Weapon Name4
        {
            pos       = {-0.08,0.1,-0.476},
            width     = 3350,
            font_size = 310,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 22 textbox Weapon Name5
        {
            pos       = {-0.08,0.1,-0.398},
            width     = 3350,
            font_size = 310,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 23 textbox Weapon Name6
        {
            pos       = {-0.08,0.1,-0.320},
            width     = 3350,
            font_size = 310,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 24 textbox Weapon Name7
        {
            pos       = {-0.08,0.1,-0.242},
            width     = 3350,
            font_size = 310,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 25 textbox Accuracy 1
        {
            pos       = {0.38,0.1,-0.71},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 26 textbox Accuracy 2
        {
            pos       = {0.38,0.1,-0.632},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 27 textbox Accuracy 3
        {
            pos       = {0.38,0.1,-0.554},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 28 textbox Accuracy 4
        {
            pos       = {0.38,0.1,-0.476},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 29 textbox Accuracy 5
        {
            pos       = {0.38,0.1,-0.398},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 30 textbox Accuracy 6
        {
            pos       = {0.38,0.1,-0.320},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 31 textbox Accuracy 7
        {
            pos       = {0.38,0.1,-0.242},
            width     = 800,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 3
        },
        -- 32 textbox Damage dice count 1
        {
            pos       = {0.52,0.1,-0.71},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 33 textbox Damage dice count 2
        {
            pos       = {0.52,0.1,-0.632},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 34 textbox Damage dice count 3
        {
            pos       = {0.52,0.1,-0.554},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 35 textbox Damage dice count 4
        {
            pos       = {0.52,0.1,-0.476},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 36 textbox Damage dice count 5
        {
            pos       = {0.52,0.1,-0.398},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 37 textbox Damage dice count 6
        {
            pos       = {0.52,0.1,-0.320},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 38 textbox Damage dice count 7
        {
            pos       = {0.52,0.1,-0.242},
            width     = 350,
            font_size = 300,
            label     = "1",
            value     = "",
            alignment = 4,
            validation = 2
        },
        -- 39 textbox Dice Type 1
        {
            pos       = {0.6275,0.1,-0.71},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 40 textbox Dice Type 2
        {
            pos       = {0.6275,0.1,-0.632},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 41 textbox Dice Type 3
        {
            pos       = {0.6275,0.1,-0.554},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 42 textbox Dice Type 4
        {
            pos       = {0.6275,0.1,-0.476},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 43 textbox Dice Type 5
        {
            pos       = {0.6275,0.1,-0.398},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 44 textbox Dice Type 6
        {
            pos       = {0.6275,0.1,-0.320},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 45 textbox Dice Type 7
        {
            pos       = {0.6275,0.1,-0.242},
            width     = 450,
            font_size = 300,
            label     = "6",
            value     = "",
            alignment = 2,
            validation = 2
        },
        -- 46 textbox Notes 1
        {
            pos       = {1.135,0.1,-0.71},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 47 textbox Notes 2
        {
            pos       = {1.135,0.1,-0.632},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 48 textbox Notes 3
        {
            pos       = {1.135,0.1,-0.554},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 49 textbox Notes 4
        {
            pos       = {1.135,0.1,-0.476},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 50 textbox Notes 5
        {
            pos       = {1.135,0.1,-0.398},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 51 textbox Notes 6
        {
            pos       = {1.135,0.1,-0.320},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 52 textbox Notes 7
        {
            pos       = {1.135,0.1,-0.242},
            width     = 3100,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 3
        },
        -- 53 textbox Copper coins
        {
            pos       = {-0.35,0.1,0.04},
            width     = 850,
            font_size = 280,
            label     = 0,
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 54 textbox Silver coins
        {
            pos       = {-0.35,0.1,0.18},
            width     = 850,
            font_size = 280,
            label     = 0,
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 55 textbox Electrum coins
        {
            pos       = {-0.35,0.1,0.315},
            width     = 850,
            font_size = 280,
            label     = 0,
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 56 textbox Gold coins
        {
            pos       = {-0.35,0.1,0.455},
            width     = 850,
            font_size = 280,
            label     = 0,
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 57 textbox Platinum coins
        {
            pos       = {-0.35,0.1,0.6},
            width     = 850,
            font_size = 280,
            label     = 0,
            value     = "",
            alignment = 3,
            validation = 2
        },
        -- 58 textbox Equipment
        {
            pos       = {0.1335,0.1,0.31},
            rows      = 11,
            width     = 3300,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 2
        },
        -- 59 textbox Equipment2
        {
            pos       = {0.015,0.1,1.1},
            rows      = 13,
            width     = 4425,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 2
        },
        -- 60 textbox Class and Race Characteristics
        {
            pos       = {1.01,0.1,1.02},
            rows      = 41,
            width     = 4550,
            font_size = 250,
            label     = "",
            value     = "",
            alignment = 2
        },
        -- 61 textbox Height
        {
            pos       = {-0.671,0.1,1.315},
            width     = 1200,
            font_size = 300,
            label     = "Pост",
            value     = "0",
            alignment = 3,
            validation = 3
        },
        -- 62 textbox Weight
        {
            pos       = {-0.671,0.1,1.39},
            width     = 1200,
            font_size = 300,
            label     = "Bес",
            value     = "0",
            alignment = 3,
            validation = 2
        },

        -- 63 textbox Proficiency3
        {
            pos       = {-1,0.1,1.78},
            rows      = 10,
            width     = 4350,
            font_size = 300,
            label     = "",
            value     = "",
            alignment = 2
        },
        -- 64 textbox Damage Bonus 2
        {
            pos       = {0.7425,0.1,-0.632},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },
        -- 65 textbox Damage Bonus 3
        {
            pos       = {0.7425,0.1,-0.554},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },
        -- 66 textbox Damage Bonus 4
        {
            pos       = {0.7425,0.1,-0.476},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },
        -- 67 textbox Damage Bonus 5
        {
            pos       = {0.7425,0.1,-0.398},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },
        -- 68 textbox STR savethrow
        {
            pos       = {-1.055,0.1,-1.165},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 69 textbox Atletics
        {
            pos       = {-1.055,0.1,-1.1105},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 70 textbox DEX savethrow
        {
            pos       = {-1.055,0.1,-0.8},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 71 textbox Acrobatics
        {
            pos       = {-1.055,0.1,-0.745},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 72 textbox Stealth
        {
            pos       = {-1.055,0.1,-0.695},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 73 textbox Sleight of Hand
        {
            pos       = {-1.055,0.1,-0.645},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 74 textbox CON savethrow
        {
            pos       = {-1.055,0.1,-0.435},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 75 textbox INT savethrow
        {
            pos       = {-1.055,0.1,-0.075},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 76 textbox Arcana
        {
            pos       = {-1.055,0.1,-0.0215},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 77 textbox History
        {
            pos       = {-1.055,0.1,0.031},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 78 textbox Investigation
        {
            pos       = {-1.055,0.1,0.0825},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 97 textbox Nature
        {
            pos       = {-1.055,0.1,0.135},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 80 textbox Religion
        {
            pos       = {-1.055,0.1,0.185},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 81 textbox WIT savethrow
        {
            pos       = {-1.055,0.1,0.29},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 82 textbox Animal Handling
        {
            pos       = {-1.055,0.1,0.345},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 83 textbox Insight
        {
            pos       = {-1.055,0.1,0.395},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 84 textbox Medicine
        {
            pos       = {-1.055,0.1,0.445},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 85 textbox Perception -- variable ind = 85
        {
            pos       = {-1.055,0.1,0.495},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 86 textbox Survival
        {
            pos       = {-1.055,0.1,0.55},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 87 textbox CHA savethrow
        {
            pos       = {-1.055,0.1,0.655},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 88 textbox Performance
        {
            pos       = {-1.055,0.1,0.708},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 89 textbox Deception
        {
            pos       = {-1.055,0.1,0.76},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 90 textbox Intimidation
        {
            pos       = {-1.055,0.1,0.813},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 91 textbox Persuasion
        {
            pos       = {-1.055,0.1,0.863},
            width     = 200,
            font_size = 200,
            label     = "",
            value     = "0",
            alignment = 3
        },
        -- 92 textbox Damage Bonus 6
        {
            pos       = {0.7425,0.1,-0.320},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },
        -- 92 textbox Damage Bonus 7
        {
            pos       = {0.7425,0.1,-0.242},
            width     = 450,
            font_size = 300,
            label     = "+0",
            value     = "",
            alignment = 2
        },

        --End of textboxes
    },

    lvl = 1,
    lvlByExp = 1,
    lvlByExpProficiency = 2,
    lvlWasTaken = true,
    hitDiceLeft = 1,
}

LVL_UPDATE_BTN = {
    index          = #defaultButtonData.checkbox + #defaultButtonData.counter * 3 + #defaultButtonData.display,
    function_owner = self,
}

lvlUpdateBtnConditionOFF = {
    index          = LVL_UPDATE_BTN.index,
    label          = '',
    click_function = "click_none",
    function_owner = self,
    function_owner = LVL_UPDATE_BTN.function_owner,
    position       = {0,0,0},
    height         = 0,
    width          = 0,
    font_size      = 0,
    scale          = {0,0,0},
    color          = buttonColor,
    font_color     = buttonFontColor
}


--Lua beyond this point.



--Save function
function updateSave()
    saved_data = JSON.encode(ref_buttonData)
    if disableSave==true then saved_data="" end
    self.script_state = saved_data
end

--Startup procedure
function onload(saved_data)
    if disableSave==true then saved_data="" end
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        ref_buttonData = loaded_data
        -- ref_buttonData = defaultButtonData
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

    if (ref_buttonData.lvlWasTaken) then
        lvlRefresh()
    end
end

--Click functions for buttons

--Checks or unchecks the given box
function click_checkbox(tableIndex, buttonIndex)
    -- tableIndex 1 to 24 // 18 Perception
    -- buttonIndex 0 to 23

    -- Saving the value of the Attribute Modifier Corresponding to the Checked Expertise
    if tableIndex < 3 then
        atributo = ref_buttonData.display[1].value
    end
    if tableIndex > 2 and tableIndex < 7 then
        atributo = ref_buttonData.display[2].value
    end
    if tableIndex == 7  then
        atributo = ref_buttonData.display[3].value
    end
    if tableIndex > 7 and tableIndex < 14 then
        atributo = ref_buttonData.display[4].value
    end
    if tableIndex > 13 and tableIndex < 20 then
        atributo = ref_buttonData.display[5].value
    end
    if tableIndex > 19 and tableIndex < 25 then
        atributo = ref_buttonData.display[6].value
    end
    -- Skill Point Total Value Calculation and Update - Proficiently Marked
    if ref_buttonData.checkbox[tableIndex].state == false then
        if tableIndex < 25 then
            local proficiency = ref_buttonData.display[42].value
            local bonus = ref_buttonData.textbox[tableIndex + 67].value
            tonumber(proficiency)
            tonumber(bonus)
            local newValue = atributo + bonus + proficiency
            ref_buttonData.display[tableIndex + 6].value = newValue  -- Index Proficiency Display ranges from 7 to 31
            self.editButton({index = tableIndex + 59, label = newValue}) -- Index do
        end
        ref_buttonData.checkbox[tableIndex].state = true
        self.editButton({index = buttonIndex, label = CHECKBOX_CHAR_FULL})
        -- Total Skill Calculation - Uncheck
    else
        if tableIndex < 25 then
            local bonus = ref_buttonData.textbox[tableIndex+67].value
            tonumber(bonus)
            ref_buttonData.display[tableIndex+6].value = atributo+bonus
            self.editButton({index = tableIndex+59, label=atributo+bonus})
        end
        ref_buttonData.checkbox[tableIndex].state = false
        self.editButton({index = buttonIndex, label = CHECKBOX_CHAR_EMPTY})
    end
    -- Passive Perception Update in CheckBox
    if tableIndex == 18 then
        local proficiency = ref_buttonData.display[42].value
        local bonus = ref_buttonData.textbox[tableIndex+67].value
        tonumber(proficiency)
        tonumber(bonus)

        if ref_buttonData.checkbox[tableIndex].state == true then
            ref_buttonData.display[31].value = 10+atributo+bonus+proficiency
            self.editButton({index=84, label=ref_buttonData.display[31].value})
        else
            ref_buttonData.display[31].value = 10+atributo+bonus
            self.editButton({index=84, label=ref_buttonData.display[31].value})
        end
    end

    updateSave()
end

--Applies value to given counter display
function click_counter(tableIndex, buttonIndex, amount)
    -- tableIndex 1 to 6 // 5 = Wisdom
    -- buttonIndex 36 to 53 // 48 = Wisdom

    -- Attribute Modifier Calculation
    if tableIndex < 7 then
        ref_buttonData.counter[tableIndex].value = ref_buttonData.counter[tableIndex].value + amount
        ref_buttonData.display[tableIndex].value = math.floor((ref_buttonData.counter[tableIndex].value-10)/2)
        -- Update Attribute - buttonIndex 36 to 53
        self.editButton({index=buttonIndex, label=ref_buttonData.counter[tableIndex].value})
        -- Update Attribute Modifier - buttonIndex 54 to 60
        self.editButton({index=tableIndex+53, label=ref_buttonData.display[tableIndex].value})
    end
    -- Declaring the Variables attribute and proficiency
    local atributo = ref_buttonData.display[tableIndex].value
    local proficiency = ref_buttonData.display[42].value
    tonumber(proficiency)

    -- Calculation and Update of Attribute Matching Skills
    -- ButtonIndex of Skill display from 60 to 84
    -- Strength Skill Calculation
    if tableIndex == 1 then
        for ind = 1, 2, 1 do
            -- Declaring Bonus Variable for Skill
            local bonus = ref_buttonData.textbox[ind+67].value
            tonumber(bonus)
            -- Skill Update With and Without Proficiency
            if ref_buttonData.checkbox[ind].state == true then
                ref_buttonData.display[ind+6].value = atributo + bonus + proficiency
                self.editButton({index=ind+59, label = atributo + bonus + proficiency})
            else
                ref_buttonData.display[ind+6].value = atributo + bonus
                self.editButton({index=ind+59, label = atributo + bonus})
            end
        end

        updateJumpAndWeight()
    end
    -- Dexterity Skill Calculation
    if tableIndex == 2 then
        for ind = 3, 6, 1 do
            local bonus = ref_buttonData.textbox[ind+67].value
            tonumber(bonus)
            if ref_buttonData.checkbox[ind].state == true then
                ref_buttonData.display[ind+6].value = atributo + bonus + proficiency
                self.editButton({index=ind+59, label = atributo + bonus + proficiency})
            else
                ref_buttonData.display[ind+6].value = atributo + bonus
                self.editButton({index=ind+59, label = atributo + bonus})
            end
        end
    end
    -- Constitution Skill Calculation
    if tableIndex == 3 then
        local ind=7
        local bonus = ref_buttonData.textbox[74].value
        tonumber(bonus)
        if ref_buttonData.checkbox[7].state == true then
            ref_buttonData.display[ind+6].value = atributo + bonus + proficiency
            self.editButton({index=66, label = atributo + bonus + proficiency})
        else
            ref_buttonData.display[ind+6].value = atributo + bonus
            self.editButton({index=66, label = atributo + bonus})
        end
    end
    -- Intelligence Skill Calculation
    if tableIndex == 4 then
        for ind = 8, 13, 1 do
            local bonus = ref_buttonData.textbox[ind+67].value
            tonumber(bonus)
            if ref_buttonData.checkbox[ind].state == true then
                ref_buttonData.display[ind+6].value = atributo + bonus + proficiency
                self.editButton({index=ind+59, label = atributo + bonus + proficiency})
            else
                ref_buttonData.display[ind+6].value = atributo + bonus
                self.editButton({index=ind+59, label = atributo + bonus})
            end
        end
    end
    -- Wisdom Skill Calculation
    if tableIndex == 5 then
        for ind = 14, 19, 1 do
            local bonus = ref_buttonData.textbox[ind+67].value
            tonumber(bonus)

            if ref_buttonData.checkbox[ind].state == true then
                ref_buttonData.display[ind+6].value = atributo + bonus + proficiency
                self.editButton({index=ind+59, label = atributo + bonus + proficiency})
            else
                ref_buttonData.display[ind+6].value = atributo + bonus
                self.editButton({index=ind+59, label = atributo + bonus})
            end
            -- Passive Perception Update
            if ind == 18 then
                -- With or Without Perception Proficiency
                if ref_buttonData.checkbox[ind].state == true then
                    ref_buttonData.display[31].value = 10 + atributo + bonus + proficiency
                    self.editButton({index=84, label = ref_buttonData.display[31].value})
                else
                    ref_buttonData.display[31].value = 10 + atributo + bonus
                    self.editButton({index=84, label=ref_buttonData.display[31].value})
                end
            end
        end
    end
    -- Charisma Skill Calculation
    if tableIndex == 6 then
        for ind = 20, 24, 1 do
            local bonus = ref_buttonData.textbox[ind+67].value
            tonumber(bonus)
            if ref_buttonData.checkbox[ind].state == true then
                ref_buttonData.display[ind+6].value = atributo + bonus + proficiency
                self.editButton({index=ind+59, label = atributo + bonus + proficiency})
            else
                ref_buttonData.display[ind+6].value = atributo + bonus
                self.editButton({index=ind+59, label = atributo + bonus})
            end
        end
    end
    --Updates saved value for given text box
    updateSave()
end

--Applies value to given textbox
function click_textbox(i, value, selected)
    if selected == false then
        ref_buttonData.textbox[i].value = value

        -- Declaring Proficiency Values
        updateSkillsByProficiency()

        -- Height Change — Jump Height with Hands update
        if i == 61 then
            updateJumpAndWeight()
        end

        -- Exp Change — Level update
        if i == 7 then
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
    proficiency = ref_buttonData.display[42].value
    tonumber(proficiency)
    -- Proficiency Value Change Skills Update
    for cont = 1, 24, 1 do -- cont Goes Through All Skills
        -- Selecting Skill Matching Attribute Modifiers
        if cont < 3 then
            atributo = ref_buttonData.display[1].value
        end
        if cont > 2 and cont < 7 then
            atributo = ref_buttonData.display[2].value
        end
        if cont == 7  then
            atributo = ref_buttonData.display[3].value
        end
        if cont > 7 and cont < 14 then
            atributo = ref_buttonData.display[4].value
        end
        if cont > 13 and cont < 20 then
            atributo = ref_buttonData.display[5].value
        end
        if cont > 19 and cont < 25 then
            atributo = ref_buttonData.display[6].value
        end

        -- Upgrading Skills Only as Proficiency
        local bonus = ref_buttonData.textbox[cont + 67].value
        tonumber(bonus)
        local nextValue = atributo + bonus
        if ref_buttonData.checkbox[cont].state == true then
            nextValue = atributo + bonus + proficiency
        end

        ref_buttonData.display[cont + 6].value = nextValue
        self.editButton({index = cont + 59, label = nextValue})

        -- Updating Passive Perception with Proficiency
        if cont == 18 then
            ref_buttonData.display[31].value = 10 + nextValue
            self.editButton({index = 84, label = ref_buttonData.display[31].value})
        end
    end
end

--Button creation

--Makes checkboxes
function updateJumpAndWeight()
    local strBtnIndex = 1
    -- Update Weight Capacity // line 579
    weightCapacity = ref_buttonData.counter[strBtnIndex].value * 15
    self.editButton({index = 85, label = weightCapacity})

    -- Update Raise, Lift and Pull // line 579
    raiseLiftPullCapacity = weightCapacity * 2
    self.editButton({index = 86, label = raiseLiftPullCapacity})

    -- Update Jump Height // line 593
    jumpHeight = ref_buttonData.display[strBtnIndex].value + 3
    self.editButton({index = 87, label = jumpHeight})

    -- Update Jump Distance // line 600
    jumpDistance = ref_buttonData.counter[strBtnIndex].value
    self.editButton({index = 88, label = jumpDistance})

    -- Update Jump Height with Hands // line 607
    characterHeight = ref_buttonData.textbox[61].value
    if characterHeight == '' then characterHeight = 0 end
    tonumber(characterHeight)
    characterOneAndHalfHeight = math.floor(characterHeight * 1.5)
    jumpHeightWithHands = jumpHeight + characterOneAndHalfHeight
    self.editButton({index = 89, label = jumpHeightWithHands})

    -- Update Jump Height — no running // line 614
    jumpHeightNoRunning = math.floor(jumpHeight / 2)
    self.editButton({index = 90, label = jumpHeightNoRunning})

    -- Update Jump Distance — no running // line 621
    jumpDistanceNoRunning = math.floor(jumpDistance / 2)
    self.editButton({index = 91, label = jumpDistanceNoRunning})

    -- Update Jump Height with Hands — no running // line 628
    jumpHeightWithHandsNoRunning = jumpHeightNoRunning + characterOneAndHalfHeight
    self.editButton({index = 92, label = jumpHeightWithHandsNoRunning})
end

-- Lvl update btn - Activate/Deactivate
function setLvlUpdateBtnCondition(doActivate)
    if doActivate then
        self.editButton({
            index          = LVL_UPDATE_BTN.index,
            label          = 'Обновить уровень ('..ref_buttonData.lvlByExp..')',
            click_function = "onClickLvlUpdateBtn",
            function_owner = LVL_UPDATE_BTN.function_owner,
            position       = {1.040,0.1,-1.655},
            height         = 500,
            width          = 4000,
            font_size      = 350,
            scale          = buttonScale,
            color          = buttonColor,
            font_color     = buttonFontColor,
        })
        ref_buttonData.lvlWasTaken = false
    else
        self.editButton(lvlUpdateBtnConditionOFF)
    end
end

-- Lvl update btn - Create
function createLvlUpdateBtn()
    self.createButton(lvlUpdateBtnConditionOFF)
end

-- Lvl refresh
function lvlRefresh()
    updateLevelByExp()
    onClickLvlUpdateBtn()
end

-- Lvl update btn - Click
function onClickLvlUpdateBtn()
    ref_buttonData.lvl = ref_buttonData.lvlByExp
    ref_buttonData.lvlWasTaken = true
    self.editButton({
        index = 93,
        label = ref_buttonData.lvlByExp,
        value = ref_buttonData.lvlByExp,
    })
    self.editButton({
        index = 94,
        label = ref_buttonData.nextLvlExp,
        value = ref_buttonData.nextLvlExp,
    })
    ref_buttonData.display[42].value = ref_buttonData.lvlByExpProficiency
    self.editButton({
        index = 95,
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
    local EXP_TEXTBOX_ID = 7

    exp = tonumber(ref_buttonData.textbox[EXP_TEXTBOX_ID].value) or EXP_MIN

    -- Исправить значение опыта
    if (exp < EXP_MIN or exp > EXP_MAX) then
        if (exp < EXP_MIN) then exp = EXP_MIN end
        if (exp > EXP_MAX) then exp = EXP_MAX end

        -- Исправить значение опыта на инпуте
        ref_buttonData.textbox[EXP_TEXTBOX_ID].value = exp
        Wait.time(function () self.editInput({index = EXP_INPUT_EDIT_ID, value = exp}) end, 0)
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

    self.createButton({
        label          = '+',
        click_function = "hitDiceIncrement",
        function_owner = self,
        position       = {0.68,0.1,-1.47},
        height         = size,
        width          = size,
        font_size      = size,
        scale          = buttonScale,
        color          = buttonColor,
        font_color     = buttonFontColor,
    })
    self.createButton({
        label          = '-',
        click_function = "hitDiceDecrement",
        function_owner = self,
        position       = {0.68,0.1,-1.29},
        height         = size,
        width          = size,
        font_size      = size,
        scale          = buttonScale,
        color          = buttonColor,
        font_color     = buttonFontColor,
    })

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

    ref_buttonData.display[43].value = hitDiceText
    self.editButton({
        index = 96,
        label = hitDiceText,
        value = hitDiceText,
    })
end

--Makes checkboxes
function createCheckbox()
    for i, data in ipairs(ref_buttonData.checkbox) do
        --Sets up reference function
        local buttonNumber = spawnedButtonCount
        local funcName = "checkbox"..i
        local func = function() click_checkbox(i, buttonNumber) end
        self.setVar(funcName, func)

        --Sets up label
        local label = CHECKBOX_CHAR_EMPTY
        if data.state==true then label = CHECKBOX_CHAR_FULL end

        --Creates button and counts it
        self.createButton({
            label=label, click_function=funcName, function_owner=self,
            position=data.pos, height=data.size, width=data.size,
            font_size=data.size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1
    end
end
--Makes counters
function createCounter()
    for i, data in ipairs(ref_buttonData.counter) do
        --Sets up display
        local displayNumber = spawnedButtonCount
        --Sets up label
        local label = data.value
        --Sets height/width for display
        local size = data.size
        if data.hideBG == true then size = 0 end
        --Creates button and counts it
        self.createButton({
            label=label, click_function="click_none", function_owner=self,
            position=data.pos, height=size, width=size,
            font_size=data.size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up add 1
        local funcName = "counterAdd"..i
        local func = function() click_counter(i, displayNumber, 1) end
        self.setVar(funcName, func)
        --Sets up label
        local label = "+"
        --Sets up position
        local offsetDistance = (data.size/2 + data.size/4) * (buttonScale[1] * 0.002)
        local pos = {data.pos[1] + offsetDistance, data.pos[2], data.pos[3]}
        --Sets up size
        local size = data.size / 2
        --Creates button and counts it
        self.createButton({
            label=label, click_function=funcName, function_owner=self,
            position=pos, height=size, width=size,
            font_size=size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up subtract 1
        local funcName = "counterSub"..i
        local func = function() click_counter(i, displayNumber, -1) end
        self.setVar(funcName, func)
        --Sets up label
        local label = "−"
        --Set up position
        local pos = {data.pos[1] - offsetDistance, data.pos[2], data.pos[3]}
        --Creates button and counts it
        self.createButton({
            label=label, click_function=funcName, function_owner=self,
            position=pos, height=size, width=size,
            font_size=size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1
    end
end
--Makes display
function createDisplay()
    for i, data in ipairs(ref_buttonData.display) do
        -- Sets up label
        local label = data.value
        -- Sets height/width for display
        local size = data.size
        local tooltip = data.tooltip or ''
        if data.hideBG == true then size = 0 end
        -- Create display button
        self.createButton({
            label          = label,
            click_function = "click_none",
            function_owner = self,
            position       = data.pos,
            height         = size,
            width          = size,
            font_size      = data.size,
            scale          = buttonScale,
            color          = buttonColor,
            font_color     = buttonFontColor,
            tooltip        = tooltip,
        })
    end
end
--Makes textbox
function createTextbox()
    for i, data in ipairs(ref_buttonData.textbox) do
        --Sets up reference function
        local funcName = "textbox"..i
        local func = function(_, _, val, sel) click_textbox(i, val, sel) end
        self.setVar(funcName, func)

        local rows = data.rows
        if (rows == nil) then
            rows = 1
        end

        local validation = data.validation
        if (validation == nil) then
            validation = 1
        end

        self.createInput({
            input_function = funcName,
            function_owner = self,
            label          = data.label,
            alignment      = data.alignment,
            position       = data.pos,
            scale          = buttonScale,
            width          = data.width,
            height         = (data.font_size * rows) + 24,
            font_size      = data.font_size,
            color          = buttonColor,
            font_color     = buttonFontColor,
            value          = data.value,
            validation     = validation,
        })
    end
end
