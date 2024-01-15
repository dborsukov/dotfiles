#!/bin/sh

BLANK='#21232c'
DEFAULT='#383c4a'
TEXT='#d3dae3'
WRONG='#e14245'
VERIFYING='#4877b1'

i3lock \
--insidever-color=$BLANK                                                \
--ringver-color=$VERIFYING                                              \
                                                                        \
--insidewrong-color=$BLANK                                              \
--ringwrong-color=$WRONG                                                \
                                                                        \
--inside-color=$BLANK                                                   \
--ring-color=$DEFAULT                                                   \
--line-color=$BLANK                                                     \
--separator-color=$DEFAULT                                              \
                                                                        \
--verif-color=$TEXT                                                     \
--wrong-color=$TEXT                                                     \
--time-color=$TEXT                                                      \
--date-color=$TEXT                                                      \
--layout-color=$TEXT                                                    \
--keyhl-color=$TEXT                                                     \
                                                                        \
--no-modkey-text                                                        \
--time-size=26                                                          \
--date-size=18                                                          \
--{layout,verif,wrong,greeter}-size=20                                  \
--{time,date,layout,verif,wrong,greeter}-font='Ubuntu'                  \
                                                                        \
--verif-text='Wait...'                                                  \
--wrong-text='Wrong!'                                                   \
--noinput-text='Clear'                                                  \
                                                                        \
--blur 10                                                               \
--clock                                                                 \
--indicator                                                             \
--show-failed-attempts                                                  \
--time-str="%H:%M:%S"                                                   \
--date-str="%d %b %Y"                                                   \
