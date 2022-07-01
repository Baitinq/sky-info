module Lib
    ( sky_info_main
    ) where


import Data.Astro.Types
import Data.Astro.Time.JulianDate

import Logic

sky_info_main :: IO ()
sky_info_main = do
    date <- return $ fromYMDHMS 2022 6 25 9 29 0
    location <- return $ GeoC (DD 4.23) (DD 8.17)
    sky <- return $ generateSky date
    relative_sky <- return $ relativize_sky sky location
    putStrLn $ show relative_sky