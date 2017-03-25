import XMonad
import XMonad.Core

import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.Simplest
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName

import XMonad.Actions.WorkspaceNames


import XMonad.Util.EZConfig
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.IO

main = do
   myStatusBarPipe <- spawnPipe myStatusBar
   conkyBar <- spawnPipe myConkyBarRight
   conkyBar <- spawnPipe myConkyBarLeft
   xmonad $ withUrgencyHook NoUrgencyHook $ def
      { terminal = myTerminal
      , manageHook = fullscreenManageHook <+> myManageHook <+> manageDocks <+> manageHook def
      , layoutHook = fullscreenFull $ avoidStruts $ myLayoutHook
      , focusedBorderColor = myCurrentWsBgColor
      , normalBorderColor = myVisibleWsBgColor
      , startupHook = myStartupHook
      , handleEventHook = fullscreenEventHook
      , logHook = dynamicLogWithPP $ myDzenPP myStatusBarPipe
      , modMask = mod4Mask
      , keys = myKeys
      , workspaces = myWorkspaces
      }

---
-- Set terminal
---
myTerminal = "urxvtc"

---
-- Paths
---
myBitmapsPath = ".xmonad/dzen2/"
myScriptsPath = ".xmonad/scripts/"

---
-- Font
---
myFont = "Open Sans:Regular:size=9"

---
-- Colors
---
myBgBgColor = "#000000"
myFgColor = "#ffffff"
myBgColor = "#212121"
myHighlightedFgColor = "#ffffff"
myHighlightedBgColor = "#818181"

myCurrentWsFgColor = "#ffffff"
myCurrentWsBgColor = "#282828"
myVisibleWsFgColor = "#818181"
myVisibleWsBgColor = "#212121"
myHiddenWsFgColor = "#dddddd"
myHiddenEmptyWsFgColor = "#818181"
myUrgentWsFgColor = "#3465a4"

-- dzen general options
myDzenOptions = "-fg '" ++ myFgColor ++ "' -bg '" ++ myBgColor ++ "' -fn '" ++ myFont ++ "' -h '20' -e 'button2=;'"

-- Status Bar
myStatusBar = "dzen2 -x 738 -w 444 -ta r " ++ myDzenOptions

-- Conky Bar
myConkyBarRight = "conky -c ~/.xmonad/data/conkyrcright | dzen2 -x 1182 -w 738 -ta r " ++ myDzenOptions
myConkyBarLeft = "conky -c ~/.xmonad/data/conkyrcleft | dzen2 -x 0 -w 738 -ta l " ++ myDzenOptions

---
-- Manage Hook
---
myManageHook = composeAll
   [ className =? "feh" --> doIgnore
   , className =? "dzen2" --> doIgnore
   ]

---
-- Layouts
---
myLayoutHook =
   windowNavigation $
   addTabs shrinkText myTabTheme $
   boringWindows $
   noBorders $
   gaps [(U, 20)] $
   subLayout [] (Simplest) $
      halfNHalf ||| Mirror halfNHalf
   where
      halfNHalf = ResizableTall nmaster delta ratio []
      nmaster = 1
      delta = 2/100
      ratio = 1/2

myTabTheme = def
   { fontName = "xft:Open Sans:pixelsize=12"
   , activeColor = myBgColor
   , inactiveColor = myCurrentWsBgColor
   , activeBorderColor = myBgColor
   , inactiveBorderColor = myCurrentWsBgColor
   , activeTextColor = myCurrentWsFgColor
   , inactiveTextColor = myFgColor
   , urgentColor = myCurrentWsBgColor
   , urgentTextColor = myUrgentWsFgColor
   , urgentBorderColor = myCurrentWsBgColor
   }

---
-- Startup Hook
---
myStartupHook = do
   setWMName "XMonad"
   spawn "urxvtd"

---
-- Workspaces
---
myWorkspaces = clickable $
   [
   "        ^i(" ++ myBitmapsPath ++ "/1.xbm)        ",
   "        ^i(" ++ myBitmapsPath ++ "/2.xbm)        ",
   "        ^i(" ++ myBitmapsPath ++ "/3.xbm)        ",
   "        ^i(" ++ myBitmapsPath ++ "/4.xbm)        ",
   "        ^i(" ++ myBitmapsPath ++ "/5.xbm)        ",
   "        ^i(" ++ myBitmapsPath ++ "/6.xbm)        ",
   "        ^i(" ++ myBitmapsPath ++ "/7.xbm)        "
   ]
   where clickable l = [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                       (i,ws) <- zip [1..] l,
                       let n = i
                       ]

---
-- Union default and new key bindings
---
myKeys x  = M.union (M.fromList (newKeys x)) (keys def x)

---
-- Add new and/or redefine key bindings
---
newKeys conf@(XConfig {XMonad.modMask = modm}) =
   [ ((modm,                   xK_Escape), spawn (myScriptsPath ++ "lock"))
   , ((modm,                   xK_space ), spawn (myScriptsPath ++ "dmenu"))
   , ((modm,                   xK_Return), spawn myTerminal)
   -- Kill current window
   , ((modm,                   xK_q     ), kill)
   -- Rotate through the available layout algorithms
   , ((modm .|. controlMask,   xK_Tab   ), sendMessage NextLayout)
   --  Reset the layouts on the current workspace to default
   , ((modm .|. shiftMask,     xK_space ), setLayout $ XMonad.layoutHook conf)
   -- Resize viewed windows to the correct size
   , ((modm .|. mod1Mask,      xK_space ), refresh)
   -- Move focus to the next window
   , ((mod1Mask,               xK_Tab   ), windows W.focusUp)
   , ((modm .|. shiftMask,     xK_Tab   ), onGroup W.focusUp')
   -- Move focus to the next window
   , ((mod1Mask .|. shiftMask, xK_Tab   ), windows W.focusDown)
   , ((modm,                   xK_Tab   ), onGroup W.focusDown')
   -- Swap the focused window and the master window
   , ((modm .|. mod1Mask,      xK_Return), windows W.swapMaster)
   -- Swap the focused window with the next window
   , ((modm .|. shiftMask,     xK_Right ), windows W.swapDown)
   , ((modm .|. shiftMask,     xK_Down  ), windows W.swapDown)
   -- Swap the focused window with the previous window
   , ((modm .|. shiftMask,     xK_Left  ), windows W.swapUp)
   , ((modm .|. shiftMask,     xK_Up    ), windows W.swapUp)
   -- Shrink the master area
   , ((modm,                   xK_Left  ), sendMessage Shrink)
   , ((modm,                   xK_Up    ), sendMessage Shrink)
   -- Expand the master area
   , ((modm,                   xK_Right ), sendMessage Expand)
   , ((modm,                   xK_Down  ), sendMessage Expand)
   -- Push window back into tiling
   , ((modm .|. controlMask,   xK_space ), withFocused $ windows . W.sink)
   -- Increase the number of windows in the master area
   , ((modm,                   xK_equal ), sendMessage (IncMasterN 1))
   -- Decrease the number of windows in the master area
   , ((modm,                   xK_minus ), sendMessage (IncMasterN (-1)))
   -- Shove a window into a tabbed sublayout
   , ((modm .|. controlMask,   xK_Up    ), sendMessage $ pushGroup U)
   , ((modm .|. controlMask,   xK_Left  ), sendMessage $ pushGroup L)
   , ((modm .|. controlMask,   xK_Right ), sendMessage $ pushGroup R)
   -- Separate a tabbed sublayout
   , ((modm .|. controlMask,   xK_Down  ), withFocused (sendMessage . UnMerge))
   -- Do not leave useless conky, dzen and xxkb after restart
   , ((modm .|. shiftMask,     xK_q     ), spawn "killall conky dzen2; xmonad --recompile; xmonad --restart")
   ]
   ++

   ---
   -- Media keys
   ---
   -- Volume toggle mute
   [ ((0,                      0x1008ff12), spawn (myScriptsPath ++ "vol.sh mute toggle"))
   -- Volume raise
   , ((0,                      0x1008FF13), spawn (myScriptsPath ++ "vol.sh volume +5%"))
   -- Volume lower
   , ((0,                      0x1008FF11), spawn (myScriptsPath ++ "vol.sh volume -5%"))
   -- Play/pause music
   , ((0,                      0x1008FF14), spawn (myScriptsPath ++ "cmu.sh -u"))
   -- Next song
   , ((0,                      0x1008FF17), spawn (myScriptsPath ++ "cmu.sh -n"))
   -- Previous song
   , ((0,                      0x1008FF16), spawn (myScriptsPath ++ "cmu.sh -r"))
   -- Raise music volume
   , ((shiftMask,              0x1008FF13), spawn (myScriptsPath ++ "cmu.sh -v +5%"))
   -- Lower music volume
   , ((shiftMask,              0x1008FF11), spawn (myScriptsPath ++ "cmu.sh -v -5%"))
   -- Raise brightness
   , ((0,                      0x1008FF02), spawn (myScriptsPath ++ "bri.sh inc"))
   -- Lower Brightness
   , ((0,                      0x1008FF03), spawn (myScriptsPath ++ "bri.sh dec"))
   -- Take screenshot
   , ((0,                      xK_Print  ), spawn "gnome-screenshot")
   ]
   ++

   ---
   -- Remove these keybinds
   ---
   [ ((modm .|. shiftMask,     xK_Return), return ())
   , ((modm,                   xK_p     ), return ())
   , ((modm .|. shiftMask,     xK_p     ), return ())
   , ((modm .|. shiftMask,     xK_c     ), return ())
   , ((modm,                   xK_j     ), return ())
   , ((modm,                   xK_h     ), return ())
   , ((modm,                   xK_l     ), return ())
   , ((modm,                   xK_k     ), return ())
   , ((modm,                   xK_m     ), return ())
   , ((modm .|. shiftMask,     xK_j     ), return ())
   , ((modm .|. shiftMask,     xK_k     ), return ())
   , ((modm,                   xK_t     ), return ())
   , ((modm,                   xK_comma ), return ())
   , ((modm,                   xK_period), return ())
   , ((modm .|. shiftMask,     xK_slash ), return ())
   ]

---
-- Dzen2 config
---
myDzenPP h = def {
   ppOutput = hPutStrLn h,
   ppSep = "",
   ppWsSep = "",
   ppCurrent = wrapBg myCurrentWsBgColor,
   ppVisible = wrapFgBg myVisibleWsFgColor myVisibleWsBgColor,
   ppHiddenNoWindows = wrapFg myHiddenEmptyWsFgColor,
   ppUrgent = wrapFg myUrgentWsFgColor,
   ppTitle = const "",
   ppLayout  = const ""
   }
   where
      wrapFgBg fgColor bgColor content= wrap ("^fg(" ++ fgColor ++ ")^bg(" ++ bgColor ++ ")") "^fg()^bg()" content
      wrapFg color content = wrap ("^fg(" ++ color ++ ")") "^fg()" content
      wrapBg color content = wrap ("^bg(" ++ color ++ ")") "^bg()" content