module Logic where

import Data.Astro.Types
import Data.Astro.Time.JulianDate
import Data.Astro.Coordinate
import Data.Astro.Planet

data SkyT = Sky { s_date :: JulianDate,
                  objects :: [SkyObjectT]
                  } deriving (Show)

data RelativeSkyT = RelativeSky { rs_date :: JulianDate,
                  nonVisibleObjects :: [SkyObjectT],
                  visibleObjects :: [SkyObjectT]
                  } deriving (Show)

data SkyObjectT = SkyObject {
    so_name :: String,
    coordinates :: EquatorialCoordinates1
} deriving (Show)

data RelativeSkyObjectT = RelativeSkyObject {
    rso_name :: String
    --m_relative_coordinates :: HorizonCoordinates
} deriving (Show)

generateSky :: JulianDate -> SkyT
generateSky date = Sky { 
                            s_date = date,
                            objects = predictSkyObjects date
                        }

trackedObjects :: [Planet]
trackedObjects = [Mercury, Venus, Mars, Jupiter, Saturn, Neptune, Uranus] --Moon?

predictSkyObjects :: JulianDate -> [SkyObjectT]
predictSkyObjects date = do
                            object <- trackedObjects
                            objectDetails <- return $ j2010PlanetDetails object
                            earthDetails <- return $ j2010PlanetDetails Earth
                            objectPosition <- return $ planetPosition planetTrueAnomaly1 objectDetails earthDetails date
                            return SkyObject { so_name = show object, coordinates = objectPosition }

relativize_sky :: SkyT -> GeographicCoordinates -> RelativeSkyT
relativize_sky sky location = RelativeSky {
                                             rs_date = s_date sky,
                                             nonVisibleObjects = objects sky,
                                             visibleObjects = []
                                          }