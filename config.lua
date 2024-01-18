Config = {}

-- Enable or Disable the debug option
Config.Debug = true

-- Police required to start the heist
Config.RequiredCops = 10

-- Set Cooldown between each heist (in seconds)
Config.Cooldown = 20

-- Destroy The Security System / Thermite Minigame
Config.CorrectBlocks = 5
Config.IncorrectBlocks = 2
Config.TimeToShow = 5
Config.TimeToLose = 15

-- Set the different chances to steal an item
Config.ChanceForSamsungPhone = 85
Config.ChanceForIPhone = 70
Config.ChanceForTablet = 70
Config.ChanceForLaptop = 50

Config.Locations = {
    ["main"] = {
        x = -642.77,
        y = -285.82,
        z = 35.49,
    },
    ["thermite"] = {
        x = -708.98,
        y = -294.79,
        z = 37.0,
        isDone = false,
        isBusy = false,
    },
    ["takeables"] = {
        [1] = {
            x = -637.1, 
            y = -284.31,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "laptop", amount = 2},
        },
        [2] = {
            x = -635.66,
            y = -283.48,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "tablet", amount = 3},
        },
        [3] = {
            x = -634.16,
            y = -282.61,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "samsungphone", amount = 3},
        },
        [4] = {
            x = -632.33,
            y = -281.56,
            z =  35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "tablet", amount = 2},
        },
        [5] = {
            x = -630.55,
            y = -280.52, 
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "laptop", amount = 2},
        },
        [6] = {
            x = -631.93,
            y = -278.19,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "tablet", amount = 2},
        },
        [7] = {
            x = -633.82,
            y = -279.16,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "iphone", amount = 2},
        },
        [8] = {
            x = -635.73,
            y = -280.26,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "laptop", amount = 2},
        },
        [9] = {
            x = -637.4,
            y = -281.23,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "iphone", amount = 6},
        },
        [10] = {
            x = -638.92,
            y = -282.1,
            z = 35.58,
            isDone = false,
            isBusy = false,
            reward =  {name = "tablets", amount = 3},
        },
    },
    ["safe"] = {
        x = -625.37,
        y = -283.74,
        z = 35.57,
        isDone = false,
        isBusy = false,
    }
}

Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true,
    [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true,
    [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true,
    [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true,
    [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true,
    [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true,
    [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true,
    [153] = true, [157] = true, [161] = true, [165] = true,
}
