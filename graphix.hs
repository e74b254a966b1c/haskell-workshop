import Graphics.Rendering.Cairo
import Graphics.UI.Gtk

main = do
  initGUI
  window <- windowNew
  window `on` deleteEvent $ liftIO mainQuit >> return False 
  populate window
  widgetShowAll window
  mainGUI

populate w = do 
  windowSetDefaultSize w 800 600
  mainVBox <- vBoxNew False 0
  btn <- buttonNewWithLabel "Sart game"
  boxPackStart mainVBox btn PackNatural 5
  table <- tableNew 11 7 True
  populateTable table
  boxPackEnd mainVBox table PackGrow 5
  w `containerAdd` mainVBox
  return ()

positions = [(a, b) | a <- [1, 5], b <- [1 .. 9]] ++ 
            [(a, b) | a <- [2, 3, 4], b <- [1, 5, 9]]

populateTable tb = do
  images <- mapM (attachImg tb "imgs/empty.png") 
            [(x, y) | x <- [0 .. 6], y <- [0 .. 10]]
  mapM_ (flip imageSetFromFile "imgs/road.png" . snd) $
        filter ((`elem` positions) . fst) images
  return ()


attachImg tb path (x, y) = do
  img <- imageNewFromFile path
  tableAttach tb img x (x + 1) y (y + 1) [] [] 1 1
  return ((x, y), img)
