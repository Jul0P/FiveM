Config = {
    getSharedObject = "last", -- last : es_extended version >= 1.9.0 / old : es_extended version < 1.9.0
    Locale = GetConvar('esx:locale', 'fr'),
    Translate = TranslateCap, -- TranslateCap : es_extended version >= 1.9.0 / _U : es_extended version < 1.9.0
    MenuX = 0, -- position menu : top-left = 0 / top-right = 1450
    job = {
        name = "ltd",
        label = "LTD",
        ped = true,
        ped = {
            active = true,
            type = 'mp_m_shopkeep_01'
        },
        gestion = {
            blanchiment = true,
        },
        coffre = {
            upgrade = true, 
            capacity = {250, 500, 750, 1000},
        },
        vestiaire = {
            upgrade = true,
            capacity = {1, 3, 6, 10},
            outfit = {
                {
                    label = "",
                    clothes = {

                    }
                }
            }
        },
        blip = { -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 59,
            colour = 2,
            scale = 0.6
        },
        marker = {
            type = 6, -- https://docs.fivem.net/docs/game-references/markers/
            rotation = {
                x = -90.0,
                y = 0.0,
                z = 0.0
            },
            scale = {
                x = 0.5,
                y = 0.1,
                z = 0.5
            },
            color = { -- https://www.rapidtables.com/web/color/RGB_Color.html
                r = 0,
                g = 0,
                b = 0,
                a = 200
            },
            jump = false,
            rotate = false
        },
        markerbasket = {
            type = 29, -- https://docs.fivem.net/docs/game-references/markers/
            rotation = {
                x = 0.0,
                y = 0.0,
                z = 0.0
            },
            scale = {
                x = 0.8,
                y = 0.4,
                z = 0.8
            },
            color = { -- https://www.rapidtables.com/web/color/RGB_Color.html
                r = 0,
                g = 200,
                b = 0,
                a = 100
            },
            jump = false,
            rotate = true
        }
    },
    LTD = {
        {
            label = "Strawberry",
            position = {x = 24.25, y = -1345.63, z = 28.52, h = 266.0},
            coffre = {x = 25.01, y = -1339.41, z = 28.52},
            gestion = {x = 28.98, y = -1339.46, z = 28.52},
            salepoint = {
                {
                    label = "Nourriture",
                    position = {x = 29.32, y = -1345.30, z = 28.52},
                    content = {
                        {label = "Pain", name = "pain", price = 2},
                        {label = "Pomme", name = "pomme", price = 2},
                    }
                },
                {
                    label = "Boisson",
                    position = {x = 27.12, y = -1345.14, z = 28.52},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 2},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Fanta", name = "fanta", price = 3},
                        },
                    }
                }
            }
        },
        {
            label = "Little Seoul",
            position = {x = -705.73, y = -914.91, z = 18.24, h = 91.00},
            coffre = {x = -709.79, y = -906.55, z = 18.22},
            gestion = {x = -709.47, y = -904.11, z = 18.22},
            salepoint = {
                {
                    label = "Nourriture",
                    position = {x = -714.87, y = -912.5, z = 18.5},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Sandwich", name = "sandwich", price = 3},
                    }
                },
                {
                    label = "Boisson",
                    position = {x = -709.13, y = -913.02, z = 18.24},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                }
            }
        },
        {
            label = "Murrieta Heights",
            position = {x = 1134.25, y = -982.73, z = 45.41, h = 277.332},
            coffre = {x = 1130.72, y = -983.24, z = 45.42},
            gestion = {x = 1126.86, y = -980.43, z = 44.42},
            salepoint = {
                {
                    label = "Alcool",
                    position = {x = 1137.77, y = -981.86, z = 45.44},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                }
            }
        },
        {
            label = "Vespucci",
            position = {x = -1222.26, y = -908.55, z = 11.32, h = 34.654},
            coffre = {x = -1219.87, y = -911.03, z = 11.33},
            gestion = {x = -1220.45, y = -916.00, z = 10.33},
            salepoint = {
                {
                    label = "Alcool",
                    position = {x = -1226.45, y = -906.99, z = 11.36},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Boissons",
                    position = {x = -1221.49, y = -905.48, z = 11.36},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                }
            }
        },
        {
            label = "Morningwood",
            position = {x = -1485.97, y = -378.25, z = 39.16, h = 134.986},
            coffre = {x = -1484.05, y = -375.30, z = 39.16},
            gestion = {x = -1479.07, y = -375.05, z = 38.17},
            salepoint = {
                {
                    label = "Alcool",
                    position = {x = -1485.30, y = -381.19, z = 39.19},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
            }
        },
        {
            label = "Banham Canyon",
            position = {x = -2966.40, y = 390.50, z = 14.04, h = 86.336},
            coffre = {x = -2962.99, y = 390.97, z = 14.05},
            gestion = {x = -2959.31, y = 387.48, z = 13.05},
            salepoint = {
                {
                    label = "Alcool",
                    position = {x = -2969.67, y = 388.00, z = 14.07},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = -2968.00, y = 391.14, z = 14.07},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Sandwich", name = "sandwich", price = 3},
                    }
                },
            }
        },
        {
            label = "Ineseno Road",
            position = {x = -3038.87, y = 584.49, z = 6.90, h = 16.722},
            coffre = {x = -3046.76, y = 582.61, z = 6.93},
            gestion = {x = -3047.84, y = 586.45, z = 6.93},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = -3041.7, y = 586.38, z = 6.94},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = -3043.68, y = 592.28, z = 6.94},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = -3038.81, y = 586.69, z = 6.94},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = -3042.33, y = 588.20, z = 6.94},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Barbareno Road",
            position = {x = -3242.71, y = 999.95, z = 11.83, h = 350.643},
            coffre = {x = -3250.11, y = 1001.14, z = 11.85},
            gestion = {x = -3249.69, y = 1005.11, z = 11.85},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = -3244.11, y = 1003.14, z = 11.86},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = -3242.11, y = 1008.71, z = 11.86},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = -3241.33, y = 1001.88, z = 11.86},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = -3243.82, y = 1004.86, z = 11.86},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Chiliad",
            position = {x = 1727.79, y = 6415.23, z = 34.03, h = 237.870},
            coffre = {x = 1731.78, y = 6422.30, z = 34.05},
            gestion = {x = 1735.06, y = 6420.43, z = 34.05},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 1731.30, y = 6415.94, z = 34.06},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = 1732.76, y = 6415.09, z = 36.06},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 1729.53, y = 6413.42, z = 36.06},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 1732.76, y = 6415.09, z = 34.06},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Grapeseed",
            position = {x = 1697.62, y = 4923.12, z = 41.06, h = 321.338},
            coffre = {x = 1705.64, y = 4921.87, z = 41.07},
            gestion = {x = 1707.73, y = 4920.22, z = 41.07},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 1704.17, y = 4929.56, z = 41.09},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 1701.75, y = 4931.40, z = 41.09},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 1700.47, y = 4925.04, z = 41.09},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Grand Senora Desert",
            position = {x = 2678.15, y = 3279.27, z = 54.24, h = 329.443},
            coffre = {x = 2671.00, y = 3283.60, z = 54.24},
            gestion = {x = 2673.15, y = 3286.94, z = 54.27},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 2677.53, y = 3282.73, z = 54.27},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = 2680.63, y = 3288.53, z = 54.27},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 2679.99, y = 3280.72, z = 54.27},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 2678.44, y = 3284.20, z = 54.27},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Sandy Shores Forsaken",
            position = {x = 1392.02, y = 3606.19, z = 33.98, h = 198.687},
            coffre = {x = 1391.22, y = 3608.78, z = 34.02},
            gestion = {x = 1395.50, y = 3613.42, z = 34.02},
            salepoint = {
                {
                    label = "Alcool",
                    position = {x = 1398.96, y = 3605.49, z = 34.01},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Vins",
                    position = {x = 1389.34, y = 3603.08, z = 36.01},
                    content = {
                        {label = "Opus One", name = "opusone", price = 50},
                        {label = "Ridge Monte Bello", name = "ridgemonte", price = 30},
                        {label = "Caymus Vineyards", name = "caymusvine", price = 70},
                    }
                }
            }
        },
        {
            label = "Harmony",
            position = {x = 549.14, y = 2671.23, z = 41.15, h = 99.854},
            coffre = {x = 549.92, y = 2663.24, z = 41.17},
            gestion = {x = 545.89, y = 2662.91, z = 41.17},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 546.61, y = 2668.92, z = 41.18},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = 540.16, y = 2669.30, z = 41.15},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 546.85, y = 2671.88, z = 41.18},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 544.74, y = 2668.65, z = 41.18},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Grand Senora Desert",
            position = {x = 1166.11, y = 2710.87, z = 37.15, h = 180.121},
            coffre = {x = 1165.52, y = 2714.21, z = 37.16},
            gestion = {x = 1168.93, y = 2718.09, z = 36.16},
            salepoint = {
                {
                    label = "Alcool",
                    position = {x = 1168.94, y = 2708.52, z = 37.18},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 1165.86, y = 2709.11, z = 37.15},
                    content = {
                        {label = "Barre de céréale", name = "cerealbar", price = 3},
                    }
                },
            }
        },
        {
            label = "Tataviam",
            position = {x = 2557.01, y = 380.76, z = 107.62, h = 0.303},
            coffre = {x = 2549.12, y = 381.38, z = 107.62},
            gestion = {x = 2549.51, y = 385.26, z = 107.65},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 2555.15, y = 383.78, z = 107.65},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = 2557.04, y = 389.86, z = 108.65},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 2558.05, y = 382.81, z = 107.65},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 2555.42, y = 385.43, z = 107.65},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Mirror Park",
            position = {x = 1165.01, y = -324.10, z = 68.20, h = 93.551},
            coffre = {x = 1160.07, y = -316.74, z = 68.21},
            gestion = {x = 1159.79, y = -314.14, z = 68.21},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 1155.71, y = -322.84, z = 68.23},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = 1153.30, y = -325.39, z = 68.23},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 1156.06, y = -326.08, z = 68.23},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 1161.53, y = -322.68, z = 68.23},
                    content = {
                        {label = "Pain", name = "pain", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Davis",
            position = {x = -47.16, y = -1758.52, z = 28.42, h = 47.141},
            coffre = {x = -45.17, y = -1750.57, z = 28.43},
            gestion = {x = -43.30, y = -1748.69, z = 28.43},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = -52.91, y = -1751.24, z = 28.45},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = -56.11, y = -1750.54, z = 28.45},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = -54.94, y = -1753.46, z = 28.45},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = -48.77, y = -1755.28, z = 28.45},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Richman Glen",
            position = {x = -1819.28, y = 793.36, z = 137.08, h = 127.693},
            coffre = {x = -1827.24, y = 796.77, z = 137.19},
            gestion = {x = -1828.91, y = 798.90, z = 137.19},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = -1827.61, y = 789.30, z = 137.29},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = -1828.62, y = 786.01, z = 137.34},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = -1825.51, y = 786.54, z = 137.28},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = -1823.03, y = 792.50, z = 137.18},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Sandy Shores",
            position = {x = 1959.95, y = 3740.10, z = 31.34, h = 298.847},
            coffre = {x = 1956.34, y = 3747.08, z = 31.35},
            gestion = {x = 1959.69, y = 3748.89, z = 31.37},
            salepoint = {
                {
                    label = "Boisson",
                    position = {x = 1961.53, y = 3743.27, z = 31.37},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 1},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Ice-Tea", name = "icetea", price = 4},
                            {label = "Fanta", name = "fanta", price = 3},
                        }
                    }
                },
                {
                    label = "Alcool",
                    position = {x = 1967.64, y = 3745.35, z = 31.37},
                    content = {
                        {label = "Corona", name = "corana", price = 8},
                        {label = "Sierra Nevada Pale Ale", name = "sierra", price = 10},
                        {label = "Brewery", name = "brewery", price = 5},
                        {label = "Bud", name = "bud", price = 13},
                    }
                },
                {
                    label = "Fruits",
                    position = {x = 1962.37, y = 3740.25, z = 31.37},
                    content = {
                        {label = "Banane", name = "banana", price = 3},
                        {label = "Orange", name = "orange", price = 3},
                        {label = "Pomme", name = "apple", price = 3},
                        {label = "Poire", name = "pear", price = 3},
                        {label = "Ananas", name = "pineapple", price = 5},
                    }
                },
                {
                    label = "Nourriture",
                    position = {x = 1962.93, y = 3744.03, z = 31.37},
                    content = {
                        {label = "Pain", name = "bread", price = 2},
                        {label = "Yaourt", name = "yogurt", price = 1},
                        {label = "Nouilles", name = "nouilles", price = 5},
                    }
                },
            }
        },
        {
            label = "Vinewood Center",
            position = {x = 372.72, y = 328.18, z = 102.58, h = 257.95},
            coffre = {x = 374.82, y = 334.11, z = 102.58},
            gestion = {x = 378.54, y = 333.04, z = 102.58},
            salepoint = {
                {
                    label = "Nourriture",
                    position = {x = 377.94, y = 327.09, z = 102.58},
                    content = {
                        {label = "Pain", name = "pain", price = 2},
                        {label = "Pomme", name = "pomme", price = 2},
                    }
                },
                {
                    label = "Boisson",
                    position = {x = 375.78, y = 327.85, z = 102.58},
                    content = {
                        {label = "Bouteille d'Eau", name = "water", price = 2},
                        {label = "Jus d'Orange", name = "orangejuice", price = 2},
                        ["Soda"] = {
                            {label = "Pepsi", name = "pepsi", price = 3},
                            {label = "Coca-cola", name = "cocacola", price = 3},
                            {label = "Fanta", name = "fanta", price = 3},
                        },
                    }
                }
            }
        },
    }
}

arrayJobName = {}
double = {}

for k,v in pairs(Config.LTD) do
    local label = Config.job.name.."_"..v.label:sub(1,3):lower()

    if double[label] then
        double[label] = double[label] + 1
        label = label..double[label]
    else
        double[label] = 1
    end

    table.insert(arrayJobName, label)
end