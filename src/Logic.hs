module Logic where

import Data.Astro.Types
import Data.Astro.Time.JulianDate
import Data.Astro.Coordinate

data SkyT = Sky { date :: JulianDate,
                  nonVisibleObjects :: [SkyObjectT],
                  visibleObjects :: [SkyObjectT]
                  } deriving (Show)

data SkyObjectT = SkyObject {
    name :: String
    --coordinates :: EquatorialCoordinates1
    --m_relative_coordinates :: Maybe HorizonCoordinates
} deriving (Show)

generateSky :: JulianDate -> SkyT
generateSky date = let
                                (nonVisibleObjects, visibleObjects) = predictSkyObjects date
                            in 
                                Sky { 
                                    date = date,
                                    nonVisibleObjects=nonVisibleObjects, 
                                    visibleObjects=visibleObjects
                                 }

predictSkyObjects :: JulianDate -> ([SkyObjectT], [SkyObjectT])
predictSkyObjects date = ([SkyObject { name="test" }], [SkyObject { name= "uwu" }])

relativize_sky :: SkyT -> GeographicCoordinates -> SkyT
relativize_sky sky location = sky