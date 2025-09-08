; THIS CODE IS WRITTEN AND DOCUMENTED BY [MUHAMMAD NOUMAN HAFEEZ -> 21I-0416]
; Libraries

INCLUDE Irvine32.inc
includelib winmm.lib  ; added for the sound capabilities

.data

    ; Sound Handling
    PlaySoundA PROTO,
    pszSound:PTR BYTE,
    hmod:DWORD,
    fdwSound:DWORD

    goBOOM byte "main-player-sound.wav",0
    goDISHOOM byte "goDISHOOM.wav",0
    goTHANKYOU byte "goTHANKYOU.wav",0
    goMENU byte "goMENU.wav",0
    goWELCOME byte "goWELCOME.wav",0

    deviceConnect BYTE "DeviceConnect",0
    SND_ALIAS    DWORD 00010000h
    SND_RESOURCE DWORD 00040005h
    SND_FILENAME DWORD 00020000h


    ; File Handling
    RecordFileHandle dd ?
    filename byte "Scores.txt",0
    FILE_END = 2  ; For SetFilePointer to move to end of file
    levelStr byte "0",0,0  ; String to hold level value
    separatorLine byte "------------------------",0Dh,0Ah,0
    tempBuffer byte 1000 dup(0)  ; Buffer to read existing file content
    bytesRead dword ?


    ; Welcome screen ASCII art strings
    welcomeLine1 byte "          _______  _        _______  _______  _______  _______ ",0
    welcomeLine2 byte "|\     /|(  ____ \( \      (  ____ \(  ___  )(       )(  ____ \",0  
    welcomeLine3 byte "| )   ( || (    \/| (      | (    \/| (   ) || () () || (    \/",0
    welcomeLine4 byte "| | _ | || (__    | |      | |      | |   | || || || || (__    ",0
    welcomeLine5 byte "| |( )| ||  __)   | |      | |      | |   | || |(_)| ||  __)   ",0
    welcomeLine6 byte "| || || || (      | |      | |      | |   | || |   | || (      ",0
    welcomeLine7 byte "| () () || (____/\| (____/\| (____/\| (___) || )   ( || (____/\",0
    welcomeLine8 byte "(_______)(_______/(_______/(_______/(_______)|/     \|(_______/",0
    welcomeLine9 byte "                                                               ",0
    
    ; Welcome screen additional text
    welcomeSubtitle byte "SPACESHIP BATTLE GAME - ASSEMBLY VERSION",0
    welcomeInstructions1 byte "CONTROLS:",0
    welcomeInstructions2 byte "Arrow Keys - Move Player",0
    welcomeInstructions3 byte "Spacebar - Fire Bullets",0
    welcomeInstructions4 byte "P - Pause Game",0
    welcomeInstructions5 byte "X - Exit Game",0
    welcomePressKey byte "Press any key to start...",0


    ; DATA RECORD ASCII art header strings
    dataRecordLine1 byte " _______       ___   .___________.    ___         .______       _______   ______   ______   .______       _______  ",0
    dataRecordLine2 byte "|       \     /   \  |           |   /   \        |   _  \     |   ____| /      | /  __  \  |   _  \     |       \ ",0
    dataRecordLine3 byte "|  .--.  |   /  ^  \ `---|  |----`  /  ^  \       |  |_)  |    |  |__   |  ,----'|  |  |  | |  |_)  |    |  .--.  |",0
    dataRecordLine4 byte "|  |  |  |  /  /_\  \    |  |      /  /_\  \      |      /     |   __|  |  |     |  |  |  | |      /     |  |  |  |",0
    dataRecordLine5 byte "|  '--'  | /  _____  \   |  |     /  _____  \     |  |\  \----.|  |____ |  `----.|  `--'  | |  |\  \----.|  '--'  |",0
    dataRecordLine6 byte "|_______/ /__/     \__\  |__|    /__/     \__\    | _| `._____||_______| \______| \______/  | _| `._____||_______/ ",0
    dataRecordLine7 byte "                                                                                                                   ",0
    
    ; Decorative and instruction strings for DATA RECORD screen
    decorativeBorder byte "=========================================================================================================",0
    pressEnterMsg byte "Press Enter to continue...",0

    ; SPACESHIP BATTLE Screen ASCII art
    spaceshipLine1 byte "   _____ _____        _____ ______  _____ _    _ _____ _____    ____       _______ _______ _      ______ ",0
    spaceshipLine2 byte "  / ____|  __ \ /\   / ____|  ____|/ ____| |  | |_   _|  __ \  |  _ \   /\|__   __|__   __| |    |  ____|",0
    spaceshipLine3 byte " | (___ | |__) /  \ | |    | |__  | (___ | |__| | | | | |__) | | |_) | /  \  | |     | |  | |    | |__   ",0
    spaceshipLine4 byte "  \___ \|  ___/ /\ \| |    |  __|  \___ \|  __  | | | |  ___/  |  _ < / /\ \ | |     | |  | |    |  __|  ",0
    spaceshipLine5 byte "  ____) | |  / ____ \ |____| |____ ____) | |  | |_| |_| |      | |_) / ____ \| |     | |  | |____| |____ ",0
    spaceshipLine6 byte " |_____/|_| /_/    \_\_____|______|_____/|_|  |_|_____|_|      |____/_/    \_\_|     |_|  |______|______|",0
    spaceshipLine7 byte "                                                                                                         ",0
    spaceshipLine8 byte "                                                                                                         ",0

    ; Developer and technical information
    developerInfo byte "Developed by https://github.com/noumanic",0
    langInfo byte "Lang: Assembly Language",0
    archInfo byte "x86 Architecture",0
    ideInfo byte "IDE: Microsoft Visual Studio Community Edition",0
    libraryInfo byte "Library: Irvine32",0
    versionInfo byte "Version: 1.0 - Enhanced Edition",0
    pressEnterMenu byte "Press Enter to continue to Menu...",0
    decorativeBorder2 byte "============================================================================================",0


    ; Loading effect strings
    loadingText byte "LOADING",0
    loadingDots byte "   ",0  ; Space for dots
    loadingBar byte "[          ]",0  ; Progress bar
    loadingComplete byte "COMPLETE!",0



    ; MENU Screen ASCII art
    menuLine1 byte "$$\      $$\ $$$$$$$$\ $$\   $$\ $$\   $$\ ",0
    menuLine2 byte "$$$\    $$$ |$$ _____|$$$\  $$ |$$ |  $$ |",0
    menuLine3 byte "$$$$\  $$$$ |$$ |     $$$$\ $$ |$$ |  $$ |",0
    menuLine4 byte "$$\$$\$$ $$ |$$$$$\   $$ $$\$$ |$$ |  $$ |",0
    menuLine5 byte "$$ \$$$  $$ |$$  __|  $$ \$$$$ |$$ |  $$ |",0
    menuLine6 byte "$$ |\$  /$$ |$$ |     $$ |\$$$ |$$ |  $$ |",0
    menuLine7 byte "$$ | \_/ $$ |$$$$$$$$\ $$ | \$$ |\$$$$$$  |",0
    menuLine8 byte "\__|     \__|\________|\__|  \__| \______/ ",0

    ; INSTRUCTIONS Screen ASCII art  
    instructLine1 byte "$$$$$$\ $$\   $$\  $$$$$$\ $$$$$$$$\ $$$$$$$\  $$\   $$\  $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\  $$$$$$\  ",0
    instructLine2 byte "\_$$  _|$$$\  $$ |$$  __$$\\__$$  __|$$  __$$\ $$ |  $$ |$$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |$$  __$$\ ",0
    instructLine3 byte "  $$ |  $$$$\ $$ |$$ /  \__|  $$ |   $$ |  $$ |$$ |  $$ |$$ /  \__|  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |$$ /  \__|",0
    instructLine4 byte "  $$ |  $$ $$\$$ |\$$$$$$\    $$ |   $$$$$$$  |$$ |  $$ |$$ |        $$ |     $$ |  $$ |  $$ |$$ $$\$$ |\$$$$$$\  ",0
    instructLine5 byte "  $$ |  $$ \$$$$ | \____$$\   $$ |   $$  __$$< $$ |  $$ |$$ |        $$ |     $$ |  $$ |  $$ |$$ \$$$$ | \____$$\ ",0
    instructLine6 byte "  $$ |  $$ |\$$$ |$$\   $$ |  $$ |   $$ |  $$ |$$ |  $$ |$$ |  $$\   $$ |     $$ |  $$ |  $$ |$$ |\$$$ |$$\   $$ |",0
    instructLine7 byte "$$$$$$\ $$ | \$$ |\$$$$$$  |  $$ |   $$ |  $$ |\$$$$$$  |\$$$$$$  |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |\$$$$$$  |",0
    instructLine8 byte "\______|\__|  \__| \______/   \__|   \__|  \__| \______/  \______/   \__|   \______| \______/ \__|  \__| \______/ ",0

    ; Menu options text
    menuOption1 byte "1. See Instructions",0
    menuOption2 byte "2. Start Game",0  
    menuOption3 byte "3. Exit Game",0
    menuPrompt byte "Enter your choice (1-3): ",0


    ; Instruction text for the instructions screen
    gameInstructions1 byte "GAME CONTROLS:",0
    gameInstructions2 byte "Arrow Keys - Move your spaceship",0
    gameInstructions3 byte "Spacebar - Fire bullets at enemies",0  
    gameInstructions4 byte "P - Pause the game",0
    gameInstructions5 byte "X - Exit game anytime",0
    gameInstructions6 byte "-",0
    gameInstructions7 byte "OBJECTIVE:",0
    gameInstructions8 byte "Destroy all enemies to advance levels",0
    gameInstructions9 byte "Collect @ symbols for extra points and health",0
    gameInstructions10 byte "Avoid enemy bullets and collisions",0
    gameInstructions11 byte "Complete all 3 levels to win!",0
    pressAnyKeyInst byte "Press any key to continue...",0

    ; Highest score tracking variables
    highScoreName byte 256 dup(0)     ; Name of highest score player
    highScoreValue word 0             ; Highest score value
    highScoreLevel byte 0             ; Level of highest score player
    fileBuffer byte 2000 dup(0)       ; Buffer to read entire file
    currentName byte 256 dup(0)       ; Temporary name buffer
    currentScore word 0               ; Temporary score
    currentLevel byte 0               ; Temporary level
    parseIndex dword 0                ; Index for parsing

    ; Display strings for highest score screen
    strHighScore byte "HIGHEST SCORE RECORD",0
    strHighName byte "BEST PLAYER: ",0
    strHighScoreDisp byte "HIGHEST SCORE: ",0
    strHighLevel byte "ACHIEVED AT LEVEL: ",0
    strPressAny byte "Press any key to continue...",0
    strNoRecords byte "No records found in file!",0


    ; Color constants
    black = 0
    blue = 1
    green = 2
    cyan = 3
    red = 4
    magenta = 5
    brown = 6
    lightGray = 7
    darkGray = 8
    lightBlue = 9
    lightGreen = 10
    lightCyan = 11
    lightRed = 12
    lightMagenta = 13
    yellow = 14
    white = 15


    ; UI strings
    Write1 byte "Name : ",0
    Write2 byte "Score : ",0
    username byte 256 dup(?)
    newline byte 0Dh,0Ah,0
    helloJee13 db "ENTER YOUR NAME FOR OUR RECORD:",0
    strEnemies byte "Current Enemies: ",0
    strYouWon db "YOU WON!",0
    strYourName db "YOUR NAME: ",0
    strYourScore db "YOUR SCORE: ",0
    

    ; Game elements
    ground BYTE "########################################################################################################################",0
    ground1 BYTE "#",0ah,0
    ground2 BYTE "#",0
    

    ; Bullet data structure
    MAX_BULLETS = 10
    Bullet STRUCT
        xPos byte ?
        yPos byte ?
        active byte ?
    Bullet ENDS
    bullets Bullet MAX_BULLETS dup(<,,0>)
    

    ; Enemy bullet data structure
    MAX_ENEMY_BULLETS = 100
    EnemyBullet STRUCT
        xPos byte ?
        yPos byte ?
        active byte ?
    EnemyBullet ENDS
    enemyBullets EnemyBullet MAX_ENEMY_BULLETS dup(<,,0>)
    enemyFireCounter byte 0
    enemyFireDelay byte 8
    

    ; Super Food data structure
    MAX_SUPER_FOODS = 20
    SuperFood STRUCT
        xPos byte ?
        yPos byte ?
        active byte ?
        lifeCounter byte ?
    SuperFood ENDS
    superFoods SuperFood MAX_SUPER_FOODS dup(<,,0,0>)
    

    ; Enemy data structure
    MAX_ENEMIES = 15
    Enemy STRUCT
        xPos byte ?
        yPos byte ?
        active byte ?
        direction byte ?
        fireCounter byte ?
    Enemy ENDS
    enemies Enemy MAX_ENEMIES dup(<,,0,0>)
    currentEnemies byte 5
    enemySpeedCounter byte 0
    enemySpeedDelay byte 15
    enemyHorizontalCounter byte 0
    enemyHorizontalDelay byte 3
    enemyVerticalCounter byte 0
    enemyVerticalDelay byte 60
    

    ; Level 3 specific data
    level3RandomCounter byte 0
    level3RandomDelay byte 3
    

    ; Game state
    strResult db 16 dup (0)
    x_save byte ?
    y_save byte ?
    iteration byte 1
    count word 0
    lives byte 3
    level byte 1
    gamespeed byte 100
    strScore BYTE "SCORE : ",0
    strLives BYTE "LIVES : ",0
    strPause BYTE "PAUSE",0
    strLevel BYTE "LEVEL : ",0
    score word 1
    

    ; Player position
    xPos BYTE 60
    yPos BYTE 28
    
    inputChar BYTE ?
    checkport byte 0
    collision byte 0
    level2ResetFlag byte 0
    level3ResetFlag byte 0
    
    ; Border redraw flag
    borderRedrawCounter byte 0
    borderRedrawDelay byte 30

    ; Game Over screen decoration strings
    strGameOver byte "G A M E   O V E R",0
    strGameOverLine byte "==============================",0
    strPlayerStats byte "PLAYER STATISTICS",0
    strPlayerNameLabel byte "PLAYER NAME: ",0
    strFinalScoreLabel byte "FINAL SCORE: ",0
    strLevelReached byte "LEVEL REACHED: ",0
    strPressKeyToContinue byte "Press any key to continue...",0

    ; Performance messages
    strExcellentPerf byte "EXCELLENT PERFORMANCE!",0
    strGoodPerf byte "Good job, keep practicing!",0
    strTryAgainPerf byte "Better luck next time!",0



    ; THANK YOU Screen ASCII art
    thankYouLine1 byte " _________  ____  ____       *       *___  _____  ___  ____  ____  ____   ___   _____  _____  _  ",0
    thankYouLine2 byte "|  *   *  ||_   ||   *|     / \     |*   \|_   *||*  ||_  *||*  *||*  *|.'   `.|*   *||*   _|| | ",0
    thankYouLine3 byte "|_/ | | \_|  | |__| |      / * \      |   \ | |    | |*/ /    \ \  / / /  .-.  \ | |    | |  | | ",0
    thankYouLine4 byte "    | |      |  **  |     / **_ \     | |\ \| |    |  __'.     \ \/ /  | |   | | | '    ' |  | | ",0
    thankYouLine5 byte "   *| |*    *| |  | |*  */ /   \ \*  *| |*\   |_  *| |  \ \*   *|  |*  \  `-'  /  \ \__/ /   |_| ",0
    thankYouLine6 byte "  |_____|  |____||____||____| |____||_____|\____||____||____| |______|  `.___.'    `.__.'    (_) ",0
    thankYouLine7 byte "                                                                                                 ",0

    ; Thank you screen messages
    thankYouTitle byte "FOR PLAYING SPACESHIP BATTLE!",0
    thankYouMessage1 byte "We hope you enjoyed this Assembly language adventure!",0
    thankYouMessage2 byte "Your scores have been saved to our records.",0
    thankYouMessage3 byte "Challenge yourself to beat your high score next time!",0
    thankYouMessage4 byte "Developed with passion using x86 Assembly Language",0
    thankYouMessage5 byte "Thank you for supporting Rebirth Studio!",0
    thankYouFinalMsg byte "Press any key to exit the game...",0
    thankYouBorder byte "================================================================================",0

    strCongratulations byte "CONGRATULATIONS! YOU'VE COMPLETED ALL LEVELS!",0
    strWinnerStats byte "WINNER STATISTICS",0


.code
main PROC
    call DisplayWelcomeScreen
    call DisplaySpaceshipBattleScreen    ; NEW
    call DisplayLoadingEffect        ; Optional loading animation
    call DisplayMenuScreen               ; NEW
    call GetUserName
    call InitGame
    call GameMainLoop
    call EndGame
    exit
main ENDP


; Procedure to display the welcome screen

DisplayWelcomeScreen PROC
    INVOKE PlaySoundA, OFFSET goWELCOME, NULL, 20001H      ; SND_ASYNC | SND_FILENAME

    call clrscr
    
    ; Set title color (cyan on black)
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    
    ; Display ASCII art title (centered around column 10)
    mov dl, 10
    mov dh, 3
    call Gotoxy
    mov edx, offset welcomeLine1
    call WriteString
    
    mov dl, 10
    mov dh, 4
    call Gotoxy
    mov edx, offset welcomeLine2
    call WriteString
    
    mov dl, 10
    mov dh, 5
    call Gotoxy
    mov edx, offset welcomeLine3
    call WriteString
    
    mov dl, 10
    mov dh, 6
    call Gotoxy
    mov edx, offset welcomeLine4
    call WriteString
    
    mov dl, 10
    mov dh, 7
    call Gotoxy
    mov edx, offset welcomeLine5
    call WriteString
    
    mov dl, 10
    mov dh, 8
    call Gotoxy
    mov edx, offset welcomeLine6
    call WriteString
    
    mov dl, 10
    mov dh, 9
    call Gotoxy
    mov edx, offset welcomeLine7
    call WriteString
    
    mov dl, 10
    mov dh, 10
    call Gotoxy
    mov edx, offset welcomeLine8
    call WriteString
    
    mov dl, 10
    mov dh, 11
    call Gotoxy
    mov edx, offset welcomeLine9
    call WriteString
    
    ; Display subtitle in yellow
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 13
    call Gotoxy
    mov edx, offset welcomeSubtitle
    call WriteString
    
    ; Display instructions in light green
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    
    mov dl, 35
    mov dh, 16
    call Gotoxy
    mov edx, offset welcomeInstructions1
    call WriteString
    
    mov dl, 30
    mov dh, 18
    call Gotoxy
    mov edx, offset welcomeInstructions2
    call WriteString
    
    mov dl, 30
    mov dh, 19
    call Gotoxy
    mov edx, offset welcomeInstructions3
    call WriteString
    
    mov dl, 30
    mov dh, 20
    call Gotoxy
    mov edx, offset welcomeInstructions4
    call WriteString
    
    mov dl, 30
    mov dh, 21
    call Gotoxy
    mov edx, offset welcomeInstructions5
    call WriteString
    
    ; Display "Press any key" message in white
    mov eax, white + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 25
    call Gotoxy
    mov edx, offset welcomePressKey
    call WriteString
    
    ; Wait for key press
    call ReadChar
    
    ; Clear screen before proceeding
    call clrscr
    ret
DisplayWelcomeScreen ENDP

; Prcedure to Display SPACESHIP BATTLE screen with developer info
DisplaySpaceshipBattleScreen PROC
    call clrscr
    INVOKE PlaySoundA, OFFSET goDISHOOM, NULL, 20001H      ; SND_ASYNC | SND_FILENAME
    ; Set title color (cyan on black for the main title)
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    
    ; Display SPACESHIP BATTLE ASCII art (centered around column 5)
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, offset spaceshipLine1
    call WriteString
    
    mov dl, 5
    mov dh, 4
    call Gotoxy
    mov edx, offset spaceshipLine2
    call WriteString
    
    mov dl, 5
    mov dh, 5
    call Gotoxy
    mov edx, offset spaceshipLine3
    call WriteString
    
    mov dl, 5
    mov dh, 6
    call Gotoxy
    mov edx, offset spaceshipLine4
    call WriteString
    
    mov dl, 5
    mov dh, 7
    call Gotoxy
    mov edx, offset spaceshipLine5
    call WriteString
    
    mov dl, 5
    mov dh, 8
    call Gotoxy
    mov edx, offset spaceshipLine6
    call WriteString
    
    mov dl, 5
    mov dh, 9
    call Gotoxy
    mov edx, offset spaceshipLine7
    call WriteString
    
    mov dl, 5
    mov dh, 10
    call Gotoxy
    mov edx, offset spaceshipLine8
    call WriteString
    
    ; Display developer information in yellow
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 13
    call Gotoxy
    mov edx, offset developerInfo
    call WriteString
    
    ; Display technical specifications in different colors
    ; Language info in light green
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 16
    call Gotoxy
    mov edx, offset langInfo
    call WriteString
    
    ; Architecture info in light cyan
    mov eax, lightCyan + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 17
    call Gotoxy
    mov edx, offset archInfo
    call WriteString
    
    ; IDE info in light magenta
    mov eax, lightMagenta + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 18
    call Gotoxy
    mov edx, offset ideInfo
    call WriteString
    
    ; Library info in light red
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 19
    call Gotoxy
    mov edx, offset libraryInfo
    call WriteString
    
    ; Version info in white
    mov eax, white + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 20
    call Gotoxy
    mov edx, offset versionInfo
    call WriteString
    
    ; Add decorative border line
    mov eax, blue + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 22
    call Gotoxy
    mov edx, offset decorativeBorder2
    call WriteString
    
    ; Display "Press Enter to continue" message with blinking effect
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 24
    call Gotoxy
    mov edx, offset pressEnterMenu
    call WriteString
    
    ; Wait for Enter key specifically
DSBS_WaitLoop:
    call ReadChar
    cmp al, 0Dh  ; Check for Enter key (carriage return)
    jne DSBS_WaitLoop
    
    ; Clear screen before proceeding
    call clrscr
    ret
DisplaySpaceshipBattleScreen ENDP

; Procedure to Add a brief loading animation effect
DisplayLoadingEffect PROC
    ; Display "Loading..." with dots animation
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 40
    mov dh, 26
    call Gotoxy
    
    mov edx, offset loadingText
    call WriteString
    
    ; Animate dots
    mov ecx, 3
LoadingLoop:
    mov eax, 200
    call Delay
    mov al, '.'
    call WriteChar
    loop LoadingLoop
    
    mov eax, 500
    call Delay
    ret
DisplayLoadingEffect ENDP

; Prcodeure to Dispaly the MENU Screen
DisplayMenuScreen PROC
    INVOKE PlaySoundA, OFFSET goMENU, NULL, 20001H      ; SND_ASYNC | SND_FILENAME
    call clrscr
    
MenuLoop:
    ; Set title color (cyan on black)
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    
    ; Display MENU ASCII art (centered around column 30)
    mov dl, 30
    mov dh, 3
    call Gotoxy
    mov edx, offset menuLine1
    call WriteString
    
    mov dl, 30
    mov dh, 4
    call Gotoxy
    mov edx, offset menuLine2
    call WriteString
    
    mov dl, 30
    mov dh, 5
    call Gotoxy
    mov edx, offset menuLine3
    call WriteString
    
    mov dl, 30
    mov dh, 6
    call Gotoxy
    mov edx, offset menuLine4
    call WriteString
    
    mov dl, 30
    mov dh, 7
    call Gotoxy
    mov edx, offset menuLine5
    call WriteString
    
    mov dl, 30
    mov dh, 8
    call Gotoxy
    mov edx, offset menuLine6
    call WriteString
    
    mov dl, 30
    mov dh, 9
    call Gotoxy
    mov edx, offset menuLine7
    call WriteString
    
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, offset menuLine8
    call WriteString
    
    ; Display menu options in different colors
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 35
    mov dh, 14
    call Gotoxy
    mov edx, offset menuOption1
    call WriteString
    
    mov dl, 35
    mov dh, 16
    call Gotoxy
    mov edx, offset menuOption2
    call WriteString
    
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 35
    mov dh, 18
    call Gotoxy
    mov edx, offset menuOption3
    call WriteString
    
    ; Display prompt
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 22
    call Gotoxy
    mov edx, offset menuPrompt
    call WriteString
    
    ; Get user choice
    call ReadChar
    
    ; Process choice
    cmp al, '1'
    je Menu_Instructions
    cmp al, '2'
    je Menu_StartGame
    cmp al, '3'
    je Menu_Exit
    cmp al, 'x'
    je Menu_Exit
    cmp al, 'X'
    je Menu_Exit
    
    ; Invalid choice, loop back
    jmp MenuLoop
    
Menu_Instructions:
    call DisplayInstructions
    ret
    
Menu_StartGame:
    ret
    
Menu_Exit:
    call clrscr
    exit
    
DisplayMenuScreen ENDP


; Procedure to Display Instructions Screen
DisplayInstructions PROC
    call clrscr
    
    ; Set title color (magenta on black)
    mov eax, magenta + (black SHL 4)
    call SetTextColor
    
    ; Display INSTRUCTIONS ASCII art (centered around column 2 due to width)
    mov dl, 2
    mov dh, 2
    call Gotoxy
    mov edx, offset instructLine1
    call WriteString
    
    mov dl, 2
    mov dh, 3
    call Gotoxy
    mov edx, offset instructLine2
    call WriteString
    
    mov dl, 2
    mov dh, 4
    call Gotoxy
    mov edx, offset instructLine3
    call WriteString
    
    mov dl, 2
    mov dh, 5
    call Gotoxy
    mov edx, offset instructLine4
    call WriteString
    
    mov dl, 2
    mov dh, 6
    call Gotoxy
    mov edx, offset instructLine5
    call WriteString
    
    mov dl, 2
    mov dh, 7
    call Gotoxy
    mov edx, offset instructLine6
    call WriteString
    
    mov dl, 2
    mov dh, 8
    call Gotoxy
    mov edx, offset instructLine7
    call WriteString
    
    mov dl, 2
    mov dh, 9
    call Gotoxy
    mov edx, offset instructLine8
    call WriteString
    
    ; Display game instructions
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    
    mov dl, 15
    mov dh, 12
    call Gotoxy
    mov edx, offset gameInstructions1
    call WriteString
    
    mov eax, white + (black SHL 4)
    call SetTextColor
    
    mov dl, 15
    mov dh, 13
    call Gotoxy
    mov edx, offset gameInstructions2
    call WriteString
    
    mov dl, 15
    mov dh, 14
    call Gotoxy
    mov edx, offset gameInstructions3
    call WriteString
    
    mov dl, 15
    mov dh, 15
    call Gotoxy
    mov edx, offset gameInstructions4
    call WriteString
    
    mov dl, 15
    mov dh, 16
    call Gotoxy
    mov edx, offset gameInstructions5
    call WriteString
    
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    
    mov dl, 15
    mov dh, 18
    call Gotoxy
    mov edx, offset gameInstructions7
    call WriteString
    
    mov eax, white + (black SHL 4)
    call SetTextColor
    
    mov dl, 15
    mov dh, 19
    call Gotoxy
    mov edx, offset gameInstructions8
    call WriteString
    
    mov dl, 15
    mov dh, 20
    call Gotoxy
    mov edx, offset gameInstructions9
    call WriteString
    
    mov dl, 15
    mov dh, 21
    call Gotoxy
    mov edx, offset gameInstructions10
    call WriteString
    
    mov dl, 15
    mov dh, 22
    call Gotoxy
    mov edx, offset gameInstructions11
    call WriteString
    
    ; Display "Press any key" message
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 25
    call Gotoxy
    mov edx, offset pressAnyKeyInst
    call WriteString
    
    ; Wait for key press
    call ReadChar
    
    ; Clear screen before returning
    call clrscr
    ret
DisplayInstructions ENDP

; Procedure to Display Data Record Header
DisplayDataRecordHeader PROC
    ; Set header color (light cyan on black for modern look)
    mov eax, lightCyan + (black SHL 4)
    call SetTextColor
    
    ; Display DATA RECORD ASCII art header (centered around column 5)
    mov dl, 5
    mov dh, 2
    call Gotoxy
    mov edx, offset dataRecordLine1
    call WriteString
    
    mov dl, 5
    mov dh, 3
    call Gotoxy
    mov edx, offset dataRecordLine2
    call WriteString
    
    mov dl, 5
    mov dh, 4
    call Gotoxy
    mov edx, offset dataRecordLine3
    call WriteString
    
    mov dl, 5
    mov dh, 5
    call Gotoxy
    mov edx, offset dataRecordLine4
    call WriteString
    
    mov dl, 5
    mov dh, 6
    call Gotoxy
    mov edx, offset dataRecordLine5
    call WriteString
    
    mov dl, 5
    mov dh, 7
    call Gotoxy
    mov edx, offset dataRecordLine6
    call WriteString
    
    mov dl, 5
    mov dh, 8
    call Gotoxy
    mov edx, offset dataRecordLine7
    call WriteString
    
    ; Add decorative border line in yellow
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 10
    mov dh, 10
    call Gotoxy
    mov edx, offset decorativeBorder
    call WriteString
    
    ; Reset to white color for the name prompt
    mov eax, white + (black SHL 4)
    call SetTextColor
    
    ret
DisplayDataRecordHeader ENDP

; Procedure to get the User Name
GetUserName PROC
    call clrscr  ; Clear screen first
    
    ; Display the DATA RECORD header
    call DisplayDataRecordHeader
    
    ; Position cursor for name entry prompt
    mov dh, 15
    mov dl, 27
    call Gotoxy
    
    ; Set color for name prompt (light green)
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    
    mov edx, offset helloJee13
    call WriteString
    
    ; Set color for user input (white)
    mov eax, white + (black SHL 4)
    call SetTextColor
    
    ; Move cursor to next line for input
    mov dh, 17
    mov dl, 35
    call Gotoxy
    
    mov edx, offset username
    mov ecx, 255
    call ReadString
    
    ; Display "Press Enter to continue" message
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dh, 20
    mov dl, 35
    call Gotoxy
    mov edx, offset pressEnterMsg
    call WriteString
    
    ; Wait for Enter key
    call readchar
    call clrScr
    ret
GetUserName ENDP

; Procedure -> Game -> Initializer
InitGame PROC
    call InitWalls
    call InitPlayer
    call StartLevel1
    ret
InitGame ENDP

; Procedure -> Level1 -> Starter
StartLevel1 PROC
    mov currentEnemies, 5
    mov level, 1
    mov gamespeed, 100
    mov lives, 3
    mov level2ResetFlag, 0
    mov level3ResetFlag, 0
    mov enemyHorizontalDelay, 3
    mov enemyVerticalDelay, 60
    call InitLevel1Enemies
    call DrawPlayer
    ret
StartLevel1 ENDP

; Procedure -> Level2 -> Starter
StartLevel2 PROC
    mov currentEnemies, 10
    mov level, 2
    mov gamespeed, 75
    mov level2ResetFlag, 0
    
    ; ENHANCED Level 2 - Much faster movement
    mov enemyHorizontalCounter, 0
    mov enemyVerticalCounter, 0
    mov enemyHorizontalDelay, 1      ; Super fast horizontal movement
    mov enemyVerticalDelay, 25       ; Faster downward movement
    
    cmp level2ResetFlag, 1
    je SL2_Skip
    mov lives, 17
    
SL2_Skip:
    call InitLevel2Enemies
    call ClearAllBullets
    call ClearAllSuperFoods
    call DrawPlayer
    ret
StartLevel2 ENDP

; Procedure -> Level3 -> Starter
StartLevel3 PROC
    mov currentEnemies, 15
    mov level, 3
    mov gamespeed, 50
    
    cmp level3ResetFlag, 1
    je SL3_Skip
    mov lives, 9
    
SL3_Skip:
    ; ENHANCED Level 3 - Ultra fast random movement
    mov enemyHorizontalCounter, 0
    mov enemyVerticalCounter, 0
    mov level3RandomCounter, 0
    mov level3RandomDelay, 1         ; Ultra fast random movement
    
    call InitLevel3EnemiesRandom     ; NEW: Use random initialization
    call ClearAllBullets
    call ClearAllSuperFoods
    call DrawPlayer
    ret
StartLevel3 ENDP

; Procedure -> Level1 -> Enemies-> Initializer
InitLevel1Enemies PROC
    mov ecx, 5
    mov esi, OFFSET enemies
    mov ebx, 20
    
L1_Loop:
    mov (Enemy PTR [esi]).xPos, bl
    mov (Enemy PTR [esi]).yPos, 3
    mov (Enemy PTR [esi]).active, 1
    mov (Enemy PTR [esi]).direction, 1
    mov (Enemy PTR [esi]).fireCounter, 0
    
    call DrawEnemy
    add ebx, 20
    add esi, TYPE Enemy
    loop L1_Loop
    ret
InitLevel1Enemies ENDP

; Procedure -> Level2 -> Enemies-> Initializer
InitLevel2Enemies PROC
    mov ecx, 10
    mov esi, OFFSET enemies
    mov ebx, 12
    
L2_Loop:
    mov (Enemy PTR [esi]).xPos, bl
    mov (Enemy PTR [esi]).yPos, 3
    mov (Enemy PTR [esi]).active, 1
    mov (Enemy PTR [esi]).direction, 1
    call GetRandomFireDelayLevel2
    mov (Enemy PTR [esi]).fireCounter, al
    
    call DrawEnemy
    add ebx, 10
    add esi, TYPE Enemy
    loop L2_Loop
    ret
InitLevel2Enemies ENDP

; Procedure -> Level3 -> Enemies -> Random-> Initializer
InitLevel3EnemiesRandom PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
L3R_Loop:
    push ecx
    push esi
    
    ; Random X position between 2 and 117 (inside grid boundaries)
    mov eax, 116          ; 117-2+1 = 116
    call RandomRange
    add eax, 2            ; Range: 2 to 117
    pop esi
    mov (Enemy PTR [esi]).xPos, al
    
    ; Random Y position between 3 and 8 (top area below grid, inside boundaries)
    push esi
    mov eax, 6            ; 8-3+1 = 6
    call RandomRange
    add eax, 3            ; Range: 3 to 8
    pop esi
    mov (Enemy PTR [esi]).yPos, al
    
    mov (Enemy PTR [esi]).active, 1
    
    ; Random direction (0 or 1)
    push esi
    mov eax, 2
    call RandomRange
    pop esi
    mov (Enemy PTR [esi]).direction, al
    
    call GetRandomFireDelayLevel3
    mov (Enemy PTR [esi]).fireCounter, al
    
    call DrawEnemy
    
    pop ecx
    add esi, TYPE Enemy
    loop L3R_Loop
    ret
InitLevel3EnemiesRandom ENDP

; ORIGINAL Level 3 enemies (kept for compatibility but not used)
; Procedure -> Level1 -> Enemies-> Initializer (not used)
InitLevel3Enemies PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    mov ebx, 5
    
L3_Loop:
    mov (Enemy PTR [esi]).xPos, bl
    
    push ecx
    push esi
    mov eax, 12
    call RandomRange
    add eax, 4
    pop esi
    mov (Enemy PTR [esi]).yPos, al
    pop ecx
    
    mov (Enemy PTR [esi]).active, 1
    
    push ecx
    push esi
    mov eax, 2
    call RandomRange
    pop esi
    mov (Enemy PTR [esi]).direction, al
    
    call GetRandomFireDelayLevel3
    mov (Enemy PTR [esi]).fireCounter, al
    pop ecx
    
    call DrawEnemy
    add ebx, 7
    add esi, TYPE Enemy
    loop L3_Loop
    ret
InitLevel3Enemies ENDP

; Procedure -> Level2 -> Fire -> Delay
GetRandomFireDelayLevel2 PROC
    push edx
    push ecx
    mov eax, 8
    call RandomRange
    add eax, 2
    pop ecx
    pop edx
    ret
GetRandomFireDelayLevel2 ENDP

; Procedure -> Level3 -> Fire -> Delay
GetRandomFireDelayLevel3 PROC
    push edx
    push ecx
    mov eax, 3         ; ENHANCED - Much faster firing (range 1-3)
    call RandomRange
    add eax, 1
    pop ecx
    pop edx
    ret
GetRandomFireDelayLevel3 ENDP


; Procedure -> Game -> Main -> Loop
GameMainLoop PROC
MainLoop:
    call CheckPortal
    call CheckLives
    call UpdateIteration
    call ProcessInput
    call UpdateGame
    call DisplayInfo
    call CheckBorderRedraw
    call GameDelay
    jmp MainLoop
    
EndLoop:
    ret
GameMainLoop ENDP

; Procedure -> Border -> Draw
CheckBorderRedraw PROC
    inc borderRedrawCounter
    mov al, borderRedrawCounter
    cmp al, borderRedrawDelay
    jb CBR_End
    
    mov borderRedrawCounter, 0
    call RedrawBorders
    
CBR_End:
    ret
CheckBorderRedraw ENDP

CheckPortal PROC
    cmp count, 164
    jne CP_End
    mov count, 0
    call OpenPortal
    mov checkport, 1
    
CP_End:
    ret
CheckPortal ENDP

; Procedure -> Lives Checker of main Player ship(x)
CheckLives PROC
    cmp lives, 0
    je CL_GameOver
    ret
    
CL_GameOver:
    call EndGame
    exit
CheckLives ENDP

UpdateIteration PROC
    cmp iteration, 30
    jne UI_Inc
    mov iteration, 1
    jmp UI_End
    
UI_Inc:
    inc iteration
    
UI_End:
    ret
UpdateIteration ENDP

; Procedure to process -> Keyboard Input
ProcessInput PROC
    call ReadKey
    jz PI_End
    
    cmp al, 0
    jne PI_Standard
    call HandleArrows
    jmp PI_End
    
PI_Standard:
    mov inputChar, al
    cmp inputChar, "x"
    je PI_Exit
    cmp inputChar, "p"
    je PI_Pause
    cmp inputChar, "P"    ; Also check for uppercase P
    je PI_Pause
    cmp inputChar, ' '
    je PI_Fire
    jmp PI_End
    
PI_Fire:
    INVOKE PlaySoundA, OFFSET goBOOM, NULL, 20001H      ; SND_ASYNC | SND_FILENAME
    call CreateBullet
    jmp PI_End
    
PI_Pause:
    call PauseGame
    jmp PI_End
    
PI_Exit:
    call EndGame
    exit
    
PI_End:
    ret
ProcessInput ENDP

; Boss Procedure -> Arrow Keys Handler (MoveUp) + (MoveDown) + (MoveLeft) + (MoveRight)
HandleArrows PROC
    cmp ah, 48h
    je HA_Up
    cmp ah, 50h
    je HA_Down
    cmp ah, 4Bh
    je HA_Left
    cmp ah, 4Dh
    je HA_Right
    ret
    
HA_Up:
    call MoveUp
    ret
    
HA_Down:
    call MoveDown
    ret
    
HA_Left:
    call MoveLeft
    ret
    
HA_Right:
    call MoveRight
    ret
HandleArrows ENDP

MoveUp PROC
    cmp yPos, 3
    je MU_End
    call UpdatePlayer
    dec yPos
    call DrawPlayer
MU_End:
    ret
MoveUp ENDP

MoveDown PROC
    cmp yPos, 28
    je MD_End
    call UpdatePlayer
    inc yPos
    call DrawPlayer
MD_End:
    ret
MoveDown ENDP

MoveLeft PROC
    cmp xPos, 1
    je ML_End
    call UpdatePlayer
    dec xPos
    call DrawPlayer
ML_End:
    ret
MoveLeft ENDP

MoveRight PROC
    cmp xPos, 118
    je MR_End
    call UpdatePlayer
    inc xPos
    call DrawPlayer
MR_End:
    ret
MoveRight ENDP

; Boss -> Procedure -> Caller -> Data Updater
UpdateGame PROC
    call UpdateBullets
    call CheckEnemyUpdate
    call UpdateEnemyBullets
    call UpdateSuperFoods
    call CheckCollisions
    call CheckLevelComplete
    
    cmp level, 2
    jne UG_Level3
    call CheckEnemyRespawn
    jmp UG_End
    
UG_Level3:
    cmp level, 3
    jne UG_End
    call CheckLevel3EnemyCollisionRespawn  ; NEW: Check for collisions in Level 3
    
UG_End:
    ret
UpdateGame ENDP

CheckEnemyUpdate PROC
    inc enemySpeedCounter
    mov al, enemySpeedCounter
    cmp al, enemySpeedDelay
    jb CEU_Movement
    
    mov enemySpeedCounter, 0
    cmp level, 1
    je CEU_L1
    cmp level, 2
    je CEU_L2
    cmp level, 3
    je CEU_L3
    jmp CEU_Movement
    
CEU_L1:
    call UpdateLevel1Enemies
    jmp CEU_Movement
    
CEU_L2:
    call UpdateLevel2EnemyMovement
    jmp CEU_Movement
    
CEU_L3:
    call UpdateLevel3EnemiesRandomMovement  ; NEW: Use enhanced random movement
    
CEU_Movement:
    cmp level, 2
    jne CEU_CheckL3Fire
    call UpdateEnemyFiringLevel2
    jmp CEU_End
    
CEU_CheckL3Fire:
    cmp level, 3
    jne CEU_End
    call UpdateLevel3EnemyFiring
    
CEU_End:
    ret
CheckEnemyUpdate ENDP

; Procedure -> ENHANCED Level 2 Movement - Much faster
UpdateLevel2EnemyMovement PROC
    inc enemyHorizontalCounter
    mov al, enemyHorizontalCounter
    cmp al, enemyHorizontalDelay    ; Now 1 - super fast
    jb UL2EM_Vertical
    
    mov enemyHorizontalCounter, 0
    call MoveEnemiesHorizontalFast   ; Enhanced fast movement
    
UL2EM_Vertical:
    inc enemyVerticalCounter
    mov al, enemyVerticalCounter
    cmp al, enemyVerticalDelay      ; Now 25 - faster downward
    jb UL2EM_End
    
    mov enemyVerticalCounter, 0
    call MoveEnemiesVerticalFast    ; Enhanced downward movement
    
UL2EM_End:
    ret
UpdateLevel2EnemyMovement ENDP

; Procedure -> ENHANCED - Much faster horizontal movement for Level 2
MoveEnemiesHorizontalFast PROC
    mov ecx, 10
    mov esi, OFFSET enemies
    
MEHF_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne MEHF_Next
    
    call EraseEnemy
    
    ; Move 3 pixels at a time for ultra-fast movement
    cmp (Enemy PTR [esi]).direction, 1
    je MEHF_Right
    
    ; Move left (3 pixels)
    mov al, (Enemy PTR [esi]).xPos
    sub al, 3
    cmp al, 1
    jg MEHF_SetLeft
    mov (Enemy PTR [esi]).direction, 1
    mov (Enemy PTR [esi]).xPos, 1
    jmp MEHF_Draw
MEHF_SetLeft:
    mov (Enemy PTR [esi]).xPos, al
    jmp MEHF_Draw
    
MEHF_Right:
    ; Move right (3 pixels)
    mov al, (Enemy PTR [esi]).xPos
    add al, 3
    cmp al, 118
    jl MEHF_SetRight
    mov (Enemy PTR [esi]).direction, 0
    mov (Enemy PTR [esi]).xPos, 118
    jmp MEHF_Draw
MEHF_SetRight:
    mov (Enemy PTR [esi]).xPos, al
    
MEHF_Draw:
    call DrawEnemy
    
MEHF_Next:
    add esi, TYPE Enemy
    loop MEHF_Loop
    ret
MoveEnemiesHorizontalFast ENDP

; Procedure -> ENHANCED - Faster downward movement for Level 2
MoveEnemiesVerticalFast PROC
    mov ecx, 10
    mov esi, OFFSET enemies
    
MEVF_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne MEVF_Next
    
    call EraseEnemy
    add (Enemy PTR [esi]).yPos, 2    ; Move down 2 pixels at once
    
    cmp (Enemy PTR [esi]).yPos, 28
    jle MEVF_Draw
    mov (Enemy PTR [esi]).yPos, 28
    
MEVF_Draw:
    call DrawEnemy
    
MEVF_Next:
    add esi, TYPE Enemy
    loop MEVF_Loop
    ret
MoveEnemiesVerticalFast ENDP

; Procedure -> NEW: Enhanced Level 3 random movement system
UpdateLevel3EnemiesRandomMovement PROC
    inc level3RandomCounter
    mov al, level3RandomCounter
    cmp al, level3RandomDelay       ; Now 1 - ultra fast
    jb UL3RM_End
    
    mov level3RandomCounter, 0
    call MoveLevel3EnemiesRandomPattern
    
UL3RM_End:
    ret
UpdateLevel3EnemiesRandomMovement ENDP

;Procedure -> NEW: Level 3 random movement with boundary checking
MoveLevel3EnemiesRandomPattern PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
ML3RP_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne ML3RP_Next
    
    call EraseEnemy
    
    ; Enhanced random movement (0=left, 1=right, 2-4=down, 5=up)
    push ecx
    push esi
    mov eax, 6
    call RandomRange
    pop esi
    pop ecx
    
    cmp eax, 0
    je ML3RP_Left
    cmp eax, 1
    je ML3RP_Right
    cmp eax, 5
    je ML3RP_Up
    ; Cases 2,3,4 all go down
    jmp ML3RP_Down
    
ML3RP_Left:
    mov al, (Enemy PTR [esi]).xPos
    cmp al, 2
    jle ML3RP_Draw
    sub (Enemy PTR [esi]).xPos, 1
    jmp ML3RP_Draw
    
ML3RP_Right:
    mov al, (Enemy PTR [esi]).xPos
    cmp al, 117
    jge ML3RP_Draw
    inc (Enemy PTR [esi]).xPos
    jmp ML3RP_Draw
    
ML3RP_Down:
    mov al, (Enemy PTR [esi]).yPos
    cmp al, 27
    jge ML3RP_Draw
    inc (Enemy PTR [esi]).yPos
    jmp ML3RP_Draw
    
ML3RP_Up:
    mov al, (Enemy PTR [esi]).yPos
    cmp al, 4
    jle ML3RP_Draw
    dec (Enemy PTR [esi]).yPos
    
ML3RP_Draw:
    call DrawEnemy
    
ML3RP_Next:
    add esi, TYPE Enemy
    loop ML3RP_Loop
    ret
MoveLevel3EnemiesRandomPattern ENDP

;Procedure -> ENHANCED Level 3 - Ultra-fast random movement with more downward bias (OLD VERSION - KEPT FOR COMPATIBILITY)
UpdateLevel3Enemies PROC
    inc level3RandomCounter
    mov al, level3RandomCounter
    cmp al, level3RandomDelay       ; Now 1 - ultra fast
    jb UL3_End
    
    mov level3RandomCounter, 0
    call MoveLevel3EnemiesRandomFast
    
UL3_End:
    ret
UpdateLevel3Enemies ENDP

;Procedure -> ENHANCED - Much faster and more aggressive random movement (OLD VERSION)
MoveLevel3EnemiesRandomFast PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
ML3RF_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne ML3RF_Next
    
    call EraseEnemy
    
    ; Enhanced random movement with heavy downward bias
    ; (0=left, 1=right, 2-6=down, 7=up) - 70% chance for down movement
    push ecx
    push esi
    mov eax, 8
    call RandomRange
    pop esi
    pop ecx
    
    cmp eax, 0
    je ML3RF_Left
    cmp eax, 1
    je ML3RF_Right
    cmp eax, 7
    je ML3RF_Up
    ; Cases 2,3,4,5,6 all go down - heavy downward bias
    jmp ML3RF_Down
    
ML3RF_Left:
    cmp (Enemy PTR [esi]).xPos, 2
    jle ML3RF_Draw
    sub (Enemy PTR [esi]).xPos, 2    ; Move 2 pixels for faster movement
    jmp ML3RF_Draw
    
ML3RF_Right:
    cmp (Enemy PTR [esi]).xPos, 117
    jge ML3RF_Draw
    add (Enemy PTR [esi]).xPos, 2    ; Move 2 pixels for faster movement
    jmp ML3RF_Draw
    
ML3RF_Down:
    cmp (Enemy PTR [esi]).yPos, 26
    jge ML3RF_HitBottom
    add (Enemy PTR [esi]).yPos, 2    ; Move down 2 pixels for faster descent
    jmp ML3RF_Draw
    
ML3RF_HitBottom:
    call RespawnLevel3EnemiesRandom  ; NEW: Use random respawn
    ret
    
ML3RF_Up:
    cmp (Enemy PTR [esi]).yPos, 4
    jle ML3RF_Draw
    dec (Enemy PTR [esi]).yPos
    
ML3RF_Draw:
    call DrawEnemy
    
ML3RF_Next:
    add esi, TYPE Enemy
    loop ML3RF_Loop
    ret
MoveLevel3EnemiesRandomFast ENDP

;Procedure -> ENHANCED Level 3 firing - Much faster and more frequent
UpdateLevel3EnemyFiring PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
UL3EF_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne UL3EF_Next
    
    inc (Enemy PTR [esi]).fireCounter
    
    ; Super fast random fire delay (1-3 cycles only)
    push ecx
    push esi
    call GetRandomFireDelayLevel3
    pop esi
    mov bl, al
    pop ecx
    
    mov al, (Enemy PTR [esi]).fireCounter
    cmp al, bl
    jb UL3EF_Next
    
    mov (Enemy PTR [esi]).fireCounter, 0
    call CreateEnemyBulletFromEnemy
    
UL3EF_Next:
    add esi, TYPE Enemy
    loop UL3EF_Loop
    ret
UpdateLevel3EnemyFiring ENDP

UpdateEnemyFiringLevel2 PROC
    mov ecx, 10
    mov esi, OFFSET enemies
    
UEFL2_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne UEFL2_Next
    
    inc (Enemy PTR [esi]).fireCounter
    
    call GetRandomFireDelayLevel2
    mov bl, al
    
    mov al, (Enemy PTR [esi]).fireCounter
    cmp al, bl
    jb UEFL2_Next
    
    mov (Enemy PTR [esi]).fireCounter, 0
    call CreateEnemyBulletFromEnemy
    
UEFL2_Next:
    add esi, TYPE Enemy
    loop UEFL2_Loop
    ret
UpdateEnemyFiringLevel2 ENDP

; Procedure -> Level1 Enemies -> Updater
UpdateLevel1Enemies PROC
    mov ecx, 5
    mov esi, OFFSET enemies
    
UL1_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne UL1_Next
    
    call EraseEnemy
    inc (Enemy PTR [esi]).yPos
    
    cmp (Enemy PTR [esi]).yPos, 28
    jle UL1_Draw
    mov collision, 1
    jmp UL1_Next
    
UL1_Draw:
    call DrawEnemy
    
UL1_Next:
    add esi, TYPE Enemy
    loop UL1_Loop
    
    call CheckCollision
    ret
UpdateLevel1Enemies ENDP

;Procedure -> NEW: Random respawn for Level 3
RespawnLevel3EnemiesRandom PROC
    call ClearLevel3Enemies
    call ClearAllBullets
    call ClearAllSuperFoods
    call InitLevel3EnemiesRandom    ; Use random positioning
    mov currentEnemies, 15
    ret
RespawnLevel3EnemiesRandom ENDP

;Procedure -> OLD: Original Level 3 respawn (kept for compatibility)
RespawnLevel3Enemies PROC
    call ClearLevel3Enemies
    call ClearAllBullets
    
    mov ecx, 15
    mov esi, OFFSET enemies
    mov ebx, 5
    
RL3E_Loop:
    mov (Enemy PTR [esi]).xPos, bl
    
    push ecx
    push esi
    mov eax, 7
    call RandomRange
    add eax, 4
    pop esi
    mov (Enemy PTR [esi]).yPos, al
    
    mov (Enemy PTR [esi]).active, 1
    
    mov eax, 2
    call RandomRange
    mov (Enemy PTR [esi]).direction, al
    
    call GetRandomFireDelayLevel3
    mov (Enemy PTR [esi]).fireCounter, al
    pop ecx
    
    call DrawEnemy
    add ebx, 7
    add esi, TYPE Enemy
    loop RL3E_Loop
    
    mov currentEnemies, 15
    ret
RespawnLevel3Enemies ENDP

ClearLevel3Enemies PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
CL3E_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne CL3E_Next
    call EraseEnemy
    mov (Enemy PTR [esi]).active, 0
    
CL3E_Next:
    add esi, TYPE Enemy
    loop CL3E_Loop
    ret
ClearLevel3Enemies ENDP

;Procedure -> OLD: Original collision check (kept for compatibility)
CheckLevel3EnemyRespawn PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
CL3ER_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne CL3ER_Next
    
    cmp (Enemy PTR [esi]).yPos, 27
    jl CL3ER_Next
    
    call ResetLevel3
    ret
    
CL3ER_Next:
    add esi, TYPE Enemy
    loop CL3ER_Loop
    ret
CheckLevel3EnemyRespawn ENDP

; NEW: Enhanced collision detection for Level 3
CheckLevel3EnemyCollisionRespawn PROC
    mov ecx, 15
    mov esi, OFFSET enemies
    
CL3ECR_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne CL3ECR_Next
    
    ; Check if enemy reached bottom boundary (y >= 27)
    cmp (Enemy PTR [esi]).yPos, 27
    jge CL3ECR_Collision
    
    ; Check if enemy hit left or right boundary
    cmp (Enemy PTR [esi]).xPos, 1
    jle CL3ECR_Collision
    cmp (Enemy PTR [esi]).xPos, 118
    jge CL3ECR_Collision
    
    jmp CL3ECR_Next
    
CL3ECR_Collision:
    call ResetLevel3WithRandom    ; NEW: Use random reset
    ret
    
CL3ECR_Next:
    add esi, TYPE Enemy
    loop CL3ECR_Loop
    ret
CheckLevel3EnemyCollisionRespawn ENDP

;Procedure -> NEW: Level 3 reset with random positioning
ResetLevel3WithRandom PROC
    mov level3ResetFlag, 1
    call ResetGame
    call StartLevel3    ; This will call InitLevel3EnemiesRandom
    ret
ResetLevel3WithRandom ENDP

ResetLevel3 PROC
    mov level3ResetFlag, 1
    call ResetGame
    call StartLevel3
    ret
ResetLevel3 ENDP

CheckEnemyRespawn PROC
    cmp level, 2
    jne CER_End
    
    mov ecx, 10
    mov esi, OFFSET enemies
    
CER_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne CER_Next
    
    cmp (Enemy PTR [esi]).yPos, 28
    jne CER_Next
    
    call RespawnAllEnemies
    jmp CER_End
    
CER_Next:
    add esi, TYPE Enemy
    loop CER_Loop
    
CER_End:
    ret
CheckEnemyRespawn ENDP

RespawnAllEnemies PROC
    call ClearAllEnemies
    
    mov ecx, 10
    mov esi, OFFSET enemies
    mov ebx, 12
    
RAE_Loop:
    mov (Enemy PTR [esi]).xPos, bl
    mov (Enemy PTR [esi]).yPos, 3
    mov (Enemy PTR [esi]).active, 1
    mov (Enemy PTR [esi]).direction, 1
    call GetRandomFireDelayLevel2
    mov (Enemy PTR [esi]).fireCounter, al
    
    call DrawEnemy
    add ebx, 10
    add esi, TYPE Enemy
    loop RAE_Loop
    
    mov currentEnemies, 10
    ret
RespawnAllEnemies ENDP

; Procedure -> Enemies Kill Handler
ClearAllEnemies PROC
    mov ecx, 10
    mov esi, OFFSET enemies
    
CAE_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne CAE_Next
    call EraseEnemy
    mov (Enemy PTR [esi]).active, 0
    
CAE_Next:
    add esi, TYPE Enemy
    loop CAE_Loop
    ret
ClearAllEnemies ENDP

; (@)========== SUPER FOOD SYSTEM ==========(@)
; NEW: Enhanced Super Food creation for Level 3 bullet collisions
CreateSuperFoodFromBulletCollision PROC
    mov ecx, MAX_SUPER_FOODS
    mov esi, OFFSET superFoods
    
CSFBC_Find:
    cmp (SuperFood PTR [esi]).active, 0
    je CSFBC_Create
    add esi, TYPE SuperFood
    loop CSFBC_Find
    ret
    
CSFBC_Create:
    ; Use collision position from bullet collision
    mov al, (Bullet PTR [edi]).xPos
    mov (SuperFood PTR [esi]).xPos, al
    mov al, (Bullet PTR [edi]).yPos  
    mov (SuperFood PTR [esi]).yPos, al
    mov (SuperFood PTR [esi]).active, 1
    mov (SuperFood PTR [esi]).lifeCounter, 200    ; Longer life for Level 3
    
    call DrawSuperFoodGreen
    ret
CreateSuperFoodFromBulletCollision ENDP

CreateSuperFood PROC
    mov ecx, MAX_SUPER_FOODS
    mov esi, OFFSET superFoods
    
CSF_Find:
    cmp (SuperFood PTR [esi]).active, 0
    je CSF_Create
    add esi, TYPE SuperFood
    loop CSF_Find
    ret
    
CSF_Create:
    mov al, (Bullet PTR [edi]).xPos
    mov (SuperFood PTR [esi]).xPos, al
    mov al, (Bullet PTR [edi]).yPos  
    mov (SuperFood PTR [esi]).yPos, al
    mov (SuperFood PTR [esi]).active, 1
    mov (SuperFood PTR [esi]).lifeCounter, 150    ; Longer life for better gameplay
    
    call DrawSuperFood
    ret
CreateSuperFood ENDP

; NEW: Draw super food with green color and @ symbol
DrawSuperFoodGreen PROC
    push esi
    mov dl, (SuperFood PTR [esi]).xPos
    mov dh, (SuperFood PTR [esi]).yPos
    
    cmp dl, 1
    jle DSFG_Skip
    cmp dl, 118
    jge DSFG_Skip
    cmp dh, 3
    jle DSFG_Skip
    cmp dh, 27
    jg DSFG_Skip
    
    call Gotoxy
    mov eax, green + (black SHL 4)    ; Green color on black background
    call SetTextColor
    mov al, '@'                       ; @ symbol for super food
    call WriteChar
    
DSFG_Skip:
    pop esi
    ret
DrawSuperFoodGreen ENDP

DrawSuperFood PROC
    push esi
    mov dl, (SuperFood PTR [esi]).xPos
    mov dh, (SuperFood PTR [esi]).yPos
    
    cmp dl, 1
    jle DSF_Skip
    cmp dl, 118
    jge DSF_Skip
    cmp dh, 3
    jle DSF_Skip
    cmp dh, 27
    jg DSF_Skip
    
    call Gotoxy
    mov eax, green + (black SHL 4)
    call SetTextColor
    mov al, '@'                       ; Changed from 'S' to '@'
    call WriteChar
    
DSF_Skip:
    pop esi
    ret
DrawSuperFood ENDP

EraseSuperFood PROC
    push esi
    mov dl, (SuperFood PTR [esi]).xPos
    mov dh, (SuperFood PTR [esi]).yPos
    
    cmp dl, 1
    jle ESF_Skip
    cmp dl, 118
    jge ESF_Skip
    cmp dh, 3
    jle ESF_Skip
    cmp dh, 27
    jg ESF_Skip
    
    call Gotoxy
    mov al, ' '
    call WriteChar
    
ESF_Skip:
    pop esi
    ret
EraseSuperFood ENDP

UpdateSuperFoods PROC
    mov ecx, MAX_SUPER_FOODS
    mov esi, OFFSET superFoods
    
USF_Loop:
    cmp (SuperFood PTR [esi]).active, 1
    jne USF_Next
    
    dec (SuperFood PTR [esi]).lifeCounter
    
    cmp (SuperFood PTR [esi]).lifeCounter, 0
    jg USF_Next
    
    call EraseSuperFood
    mov (SuperFood PTR [esi]).active, 0
    
USF_Next:
    add esi, TYPE SuperFood
    loop USF_Loop
    ret
UpdateSuperFoods ENDP

CheckPlayerSuperFoodHit PROC
    mov ecx, MAX_SUPER_FOODS
    mov esi, OFFSET superFoods
    
CPSFH_Loop:
    cmp (SuperFood PTR [esi]).active, 1
    jne CPSFH_Next
    
    mov al, (SuperFood PTR [esi]).xPos
    cmp al, xPos
    jne CPSFH_Next
    
    mov al, (SuperFood PTR [esi]).yPos
    cmp al, yPos
    jne CPSFH_Next
    
    ; Player collected super food - +10 points
    call EraseSuperFood
    mov (SuperFood PTR [esi]).active, 0
    add score, 10
    
    push esi
    call FlashSuperFoodCollection
    pop esi
    
CPSFH_Next:
    add esi, TYPE SuperFood
    loop CPSFH_Loop
    ret
CheckPlayerSuperFoodHit ENDP

FlashSuperFoodCollection PROC
    mov eax, white + (green SHL 4)
    call SetTextColor
    call DrawPlayer
    
    mov eax, 30
    call Delay
    
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    call DrawPlayer
    ret
FlashSuperFoodCollection ENDP

ClearAllSuperFoods PROC
    mov ecx, MAX_SUPER_FOODS
    mov esi, OFFSET superFoods
    
CASF_Loop:
    cmp (SuperFood PTR [esi]).active, 1
    jne CASF_Skip
    call EraseSuperFood
CASF_Skip:
    mov (SuperFood PTR [esi]).active, 0
    add esi, TYPE SuperFood
    loop CASF_Loop
    ret
ClearAllSuperFoods ENDP

; (diffusion)========== ENHANCED COLLISION DETECTION ==========(diffusion)

; NEW: Enhanced player bullet hits enemy bullet collision for Level 3
CheckPlayerBulletEnemyBulletCollision PROC
    cmp level, 3
    jne CPBEBC_End    ; Only in Level 3
    
    mov edi, OFFSET bullets
    mov ecx, MAX_BULLETS
    
CPBEBC_BLoop:
    cmp (Bullet PTR [edi]).active, 1
    jne CPBEBC_BNext
    
    mov esi, OFFSET enemyBullets
    push ecx
    mov ecx, MAX_ENEMY_BULLETS
    
CPBEBC_EBLoop:
    cmp (EnemyBullet PTR [esi]).active, 1
    jne CPBEBC_EBNext
    
    ; Check if player bullet hits enemy bullet (exact position match)
    mov al, (Bullet PTR [edi]).xPos
    cmp al, (EnemyBullet PTR [esi]).xPos
    jne CPBEBC_EBNext
    
    mov al, (Bullet PTR [edi]).yPos
    cmp al, (EnemyBullet PTR [esi]).yPos
    jne CPBEBC_EBNext
    
    ; COLLISION DETECTED - Both bullets diffuse and create super food
    call EraseBullet
    call EraseEnemyBullet
    mov (Bullet PTR [edi]).active, 0
    mov (EnemyBullet PTR [esi]).active, 0
    
    ; Create green super food (@) at collision point
    call CreateSuperFoodFromBulletCollision
    
    ; +10 points for bullet diffusion
    add score, 10
    
    ; Increase player health by +2
    add lives, 2
    
    ; Ensure lives don't exceed maximum (optional, you can set a max if you want)
    cmp lives, 99
    jle CPBEBC_NoCap
    mov lives, 99
CPBEBC_NoCap:
    
    ; Flash player to show health increase
    push esi
    push edi
    call FlashPlayerHealthIncrease
    pop edi
    pop esi
    
    pop ecx
    jmp CPBEBC_BNext
    
CPBEBC_EBNext:
    add esi, TYPE EnemyBullet
    loop CPBEBC_EBLoop
    
    pop ecx
CPBEBC_BNext:
    add edi, TYPE Bullet
    loop CPBEBC_BLoop
    
CPBEBC_End:
    ret
CheckPlayerBulletEnemyBulletCollision ENDP

; NEW: Flash effect when player gains health
FlashPlayerHealthIncrease PROC
    mov eax, green + (black SHL 4)
    call SetTextColor
    call DrawPlayer
    
    mov eax, 100  ; Longer flash for health increase
    call Delay
    
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    call DrawPlayer
    ret
FlashPlayerHealthIncrease ENDP

; ENHANCED - Player bullet hits enemy bullet in Level 3 (OLD VERSION - KEPT FOR COMPATIBILITY)
CheckPlayerBulletEnemyBulletHit PROC
    cmp level, 3
    jne CPBEBH_End    ; Only in Level 3
    
    mov edi, OFFSET bullets
    mov ecx, MAX_BULLETS
    
CPBEBH_BLoop:
    cmp (Bullet PTR [edi]).active, 1
    jne CPBEBH_BNext
    
    mov esi, OFFSET enemyBullets
    push ecx
    mov ecx, MAX_ENEMY_BULLETS
    
CPBEBH_EBLoop:
    cmp (EnemyBullet PTR [esi]).active, 1
    jne CPBEBH_EBNext
    
    ; Check if player bullet hits enemy bullet
    mov al, (Bullet PTR [edi]).xPos
    cmp al, (EnemyBullet PTR [esi]).xPos
    jne CPBEBH_EBNext
    
    mov al, (Bullet PTR [edi]).yPos
    cmp al, (EnemyBullet PTR [esi]).yPos
    jne CPBEBH_EBNext
    
    ; COLLISION DETECTED - Enhanced effects for Level 3
    call CreateEnhancedBurstEffect
    call EraseBullet
    call EraseEnemyBullet
    mov (Bullet PTR [edi]).active, 0
    mov (EnemyBullet PTR [esi]).active, 0
    
    ; ENHANCED scoring - +2 points for bullet diffusion in Level 3
    add score, 2
    
    ; Create super food at collision point
    call CreateSuperFood
    
    pop ecx
    jmp CPBEBH_BNext
    
CPBEBH_EBNext:
    add esi, TYPE EnemyBullet
    loop CPBEBH_EBLoop
    
    pop ecx
CPBEBH_BNext:
    add edi, TYPE Bullet
    loop CPBEBH_BLoop
    
CPBEBH_End:
    ret
CheckPlayerBulletEnemyBulletHit ENDP

; ENHANCED burst effect for Level 3 bullet collisions
CreateEnhancedBurstEffect PROC
    push esi
    push edi
    
    mov dl, (Bullet PTR [edi]).xPos
    mov dh, (Bullet PTR [edi]).yPos
    
    ; Check level and set appropriate burst colors
    cmp level, 2
    je CEB_Level2
    cmp level, 3
    je CEB_Level3
    
    ; LEVEL 1 - Red bullets with white/red burst
    call Gotoxy
    mov eax, white + (red SHL 4)    ; Center burst - white on red
    call SetTextColor
    mov al, '*'
    call WriteChar
    
    ; Left expansion (yellow on red)
    cmp dl, 2
    jl CEB_Right1
    dec dl
    call Gotoxy
    mov eax, yellow + (red SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    inc dl
    
CEB_Right1:
    ; Right expansion (cyan on red)
    cmp dl, 117
    jg CEB_Up1
    inc dl
    call Gotoxy
    mov eax, cyan + (red SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    dec dl
    
CEB_Up1:
    ; Up expansion (magenta on red)
    cmp dh, 3
    jle CEB_Down1
    dec dh
    call Gotoxy
    mov eax, magenta + (red SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    inc dh
    
CEB_Down1:
    ; Down expansion (green on red)
    cmp dh, 27
    jge CEB_Delay
    inc dh
    call Gotoxy
    mov eax, green + (red SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    jmp CEB_Delay
    
CEB_Level2:
    ; LEVEL 2 - Brown bullets with white/brown burst
    call Gotoxy
    mov eax, white + (brown SHL 4)  ; Center burst - white on brown
    call SetTextColor
    mov al, '*'
    call WriteChar
    
    ; Left expansion (yellow on brown)
    cmp dl, 2
    jl CEB_Right2
    dec dl
    call Gotoxy
    mov eax, yellow + (brown SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    inc dl
    
CEB_Right2:
    ; Right expansion (cyan on brown)
    cmp dl, 117
    jg CEB_Up2
    inc dl
    call Gotoxy
    mov eax, cyan + (brown SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    dec dl
    
CEB_Up2:
    ; Up expansion (magenta on brown)
    cmp dh, 3
    jle CEB_Down2
    dec dh
    call Gotoxy
    mov eax, magenta + (brown SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    inc dh
    
CEB_Down2:
    ; Down expansion (green on brown)
    cmp dh, 27
    jge CEB_Delay
    inc dh
    call Gotoxy
    mov eax, green + (brown SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    jmp CEB_Delay
    
CEB_Level3:
    ; LEVEL 3 - Magenta bullets with white/magenta burst
    call Gotoxy
    mov eax, white + (magenta SHL 4) ; Center burst - white on magenta
    call SetTextColor
    mov al, '*'
    call WriteChar
    
    ; Left expansion (yellow on magenta)
    cmp dl, 2
    jl CEB_Right3
    dec dl
    call Gotoxy
    mov eax, yellow + (magenta SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    inc dl
    
CEB_Right3:
    ; Right expansion (cyan on magenta)
    cmp dl, 117
    jg CEB_Up3
    inc dl
    call Gotoxy
    mov eax, cyan + (magenta SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    dec dl
    
CEB_Up3:
    ; Up expansion (magenta on magenta - use different color)
    cmp dh, 3
    jle CEB_Down3
    dec dh
    call Gotoxy
    mov eax, lightRed + (magenta SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    inc dh
    
CEB_Down3:
    ; Down expansion (green on magenta)
    cmp dh, 27
    jge CEB_Delay
    inc dh
    call Gotoxy
    mov eax, green + (magenta SHL 4)
    call SetTextColor
    mov al, '*'
    call WriteChar
    
CEB_Delay:
    mov eax, 80  ; Delay for visual effect
    call Delay
    
    ; Clear the burst effect
    mov dl, (Bullet PTR [edi]).xPos
    mov dh, (Bullet PTR [edi]).yPos
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    ; Clear left
    cmp dl, 2
    jl CEB_ClearRight
    dec dl
    call Gotoxy
    mov al, ' '
    call WriteChar
    inc dl
    
CEB_ClearRight:
    ; Clear right
    cmp dl, 117
    jg CEB_ClearUp
    inc dl
    call Gotoxy
    mov al, ' '
    call WriteChar
    dec dl
    
CEB_ClearUp:
    ; Clear up
    cmp dh, 3
    jle CEB_ClearDown
    dec dh
    call Gotoxy
    mov al, ' '
    call WriteChar
    inc dh
    
CEB_ClearDown:
    ; Clear down
    cmp dh, 27
    jge CEB_End
    inc dh
    call Gotoxy
    mov al, ' '
    call WriteChar
    
CEB_End:
    pop edi
    pop esi
    ret
CreateEnhancedBurstEffect ENDP

; ========== COLLISION PROCEDURES ==========
CheckCollisions PROC
    call CheckBulletEnemyHit
    call CheckPlayerEnemyHit
    call CheckEnemyBulletPlayerHit
    call CheckPlayerSuperFoodHit
    call CheckPlayerBulletEnemyBulletCollision  ; NEW: Enhanced Level 3 feature
    ret
CheckCollisions ENDP

CheckBulletEnemyHit PROC
    mov edi, OFFSET bullets
    mov ecx, MAX_BULLETS
    
    ; Determine enemy count based on level
    mov ebx, 5
    cmp level, 2
    jne CBEH_CheckLevel3
    mov ebx, 10
    jmp CBEH_Start
    
CBEH_CheckLevel3:
    cmp level, 3
    jne CBEH_Start
    mov ebx, 15
    
CBEH_Start:
CBEH_BLoop:
    cmp (Bullet PTR [edi]).active, 1
    jne CBEH_BNext
    
    mov esi, OFFSET enemies
    push ecx
    mov ecx, ebx
    
CBEH_ELoop:
    cmp (Enemy PTR [esi]).active, 1
    jne CBEH_ENext
    
    mov al, (Bullet PTR [edi]).xPos
    cmp al, (Enemy PTR [esi]).xPos
    jne CBEH_ENext
    
    mov al, (Bullet PTR [edi]).yPos
    cmp al, (Enemy PTR [esi]).yPos
    jne CBEH_ENext
    
    ; Hit detected
    call EraseBullet
    call EraseEnemy
    mov (Bullet PTR [edi]).active, 0
    mov (Enemy PTR [esi]).active, 0
    add score, 5
    dec currentEnemies
    pop ecx
    jmp CBEH_BNext
    
CBEH_ENext:
    add esi, TYPE Enemy
    loop CBEH_ELoop
    
    pop ecx
CBEH_BNext:
    add edi, TYPE Bullet
    loop CBEH_BLoop
    ret
CheckBulletEnemyHit ENDP

CheckPlayerEnemyHit PROC
    ; Determine enemy count based on level
    mov ecx, 5
    cmp level, 2
    jne CPEH_CheckLevel3
    mov ecx, 10
    jmp CPEH_Start
    
CPEH_CheckLevel3:
    cmp level, 3
    jne CPEH_Start
    mov ecx, 15
    
CPEH_Start:
    mov esi, OFFSET enemies
    
CPEH_Loop:
    cmp (Enemy PTR [esi]).active, 1
    jne CPEH_Next
    
    mov al, (Enemy PTR [esi]).xPos
    cmp al, xPos
    jne CPEH_Next
    
    mov al, (Enemy PTR [esi]).yPos
    cmp al, yPos
    jne CPEH_Next
    
    dec lives
    mov (Enemy PTR [esi]).active, 0
    dec currentEnemies
    call EraseEnemy
    
CPEH_Next:
    add esi, TYPE Enemy
    loop CPEH_Loop
    ret
CheckPlayerEnemyHit ENDP

CheckEnemyBulletPlayerHit PROC
    mov ecx, MAX_ENEMY_BULLETS
    mov esi, OFFSET enemyBullets
    
CEBPH_Loop:
    cmp (EnemyBullet PTR [esi]).active, 1
    jne CEBPH_Next
    
    mov al, (EnemyBullet PTR [esi]).xPos
    cmp al, xPos
    jne CEBPH_Next
    
    mov al, (EnemyBullet PTR [esi]).yPos
    cmp al, yPos
    jne CEBPH_Next
    
    call EraseEnemyBullet
    mov (EnemyBullet PTR [esi]).active, 0
    dec lives
    
    push esi
    call FlashPlayer
    pop esi
    
CEBPH_Next:
    add esi, TYPE EnemyBullet
    loop CEBPH_Loop
    ret
CheckEnemyBulletPlayerHit ENDP

FlashPlayer PROC
    mov eax, red + (black SHL 4)
    call SetTextColor
    call DrawPlayer
    
    mov eax, 50
    call Delay
    
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    call DrawPlayer
    ret
FlashPlayer ENDP

; Procedure -> Level Completeness -> Checker
CheckLevelComplete PROC
    cmp currentEnemies, 0
    jne CLC_End
    
    cmp level, 1
    je CLC_L2
    cmp level, 2
    je CLC_L3
    cmp level, 3
    je CLC_Win
    jmp CLC_End
    
CLC_L2:
    call ResetGame
    call StartLevel2
    jmp CLC_End
    
CLC_L3:
    call ResetGame
    call StartLevel3
    jmp CLC_End
    
CLC_Win:
    call WinGame
    exit
    
CLC_End:
    ret
CheckLevelComplete ENDP

; Procedure WinGame
WinGame PROC
    call clrScr
    
    ; Display decorative border at top
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 3
    call Gotoxy
    mov edx, offset decorativeBorder
    call WriteString
    
    ; Display "YOU WON!" with bigger emphasis
    mov eax, green + (black SHL 4)
    call SetTextColor
    mov dl, 35
    mov dh, 6
    call Gotoxy
    mov edx, offset strYouWon
    call WriteString
    
    ; Add congratulations message
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 8
    call Gotoxy
    mov edx, offset strCongratulations
    call WriteString
    
    ; Display winner information
    mov eax, lightCyan + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 11
    call Gotoxy
    mov edx, offset strWinnerStats
    call WriteString
    
    ; Display winner name
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 14
    call Gotoxy
    mov edx, offset strYourName
    call WriteString
    
    mov eax, white + (green SHL 4)
    call SetTextColor
    mov edx, offset username
    call WriteString
    
    ; Display final score
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, offset strYourScore
    call WriteString
    
    mov eax, white + (yellow SHL 4)
    call SetTextColor
    movzx eax, score
    call writeDEC
    
    ; Display decorative border at bottom
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 20
    call Gotoxy
    mov edx, offset decorativeBorder
    call WriteString
    
    ; Display instruction to continue
    mov eax, white + (blue SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 23
    call Gotoxy
    mov edx, offset strPressKeyToContinue
    call WriteString
    
    ; Wait for user to press any key
    call ReadChar
    
    ; Save the win record using the same format as regular records
    call SaveRecord  ; Changed from SaveWinRecord to SaveRecord
    
    ; Display highest score screen
    call DisplayHighestScore
    
    ; Display Thank You screen after highest score
    call DisplayThankYouScreen
    
    ret
WinGame ENDP

; Procedure -> Display Thank You Screen
DisplayThankYouScreen PROC
    call clrscr
    INVOKE PlaySoundA, OFFSET goTHANKYOU, NULL, 20001H      ; SND_ASYNC | SND_FILENAME
    
    ; Set title color (cyan on black)
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    
    ; Display THANK YOU ASCII art (centered around column 10)
    mov dl, 10
    mov dh, 3
    call Gotoxy
    mov edx, offset thankYouLine1
    call WriteString
    
    mov dl, 10
    mov dh, 4
    call Gotoxy
    mov edx, offset thankYouLine2
    call WriteString
    
    mov dl, 10
    mov dh, 5
    call Gotoxy
    mov edx, offset thankYouLine3
    call WriteString
    
    mov dl, 10
    mov dh, 6
    call Gotoxy
    mov edx, offset thankYouLine4
    call WriteString
    
    mov dl, 10
    mov dh, 7
    call Gotoxy
    mov edx, offset thankYouLine5
    call WriteString
    
    mov dl, 10
    mov dh, 8
    call Gotoxy
    mov edx, offset thankYouLine6
    call WriteString
    
    mov dl, 10
    mov dh, 9
    call Gotoxy
    mov edx, offset thankYouLine7
    call WriteString
    
    ; Display subtitle in yellow
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 11
    call Gotoxy
    mov edx, offset thankYouTitle
    call WriteString
    
    ; Add decorative border
    mov eax, blue + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 13
    call Gotoxy
    mov edx, offset thankYouBorder
    call WriteString
    
    ; Display thank you messages in different colors
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 15
    call Gotoxy
    mov edx, offset thankYouMessage1
    call WriteString
    
    mov eax, white + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 17
    call Gotoxy
    mov edx, offset thankYouMessage2
    call WriteString
    
    mov eax, lightCyan + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 19
    call Gotoxy
    mov edx, offset thankYouMessage3
    call WriteString
    
    mov eax, lightMagenta + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 21
    call Gotoxy
    mov edx, offset thankYouMessage4
    call WriteString
    
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 23
    call Gotoxy
    mov edx, offset thankYouMessage5
    call WriteString
    
    ; Add another decorative border
    mov eax, blue + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 25
    call Gotoxy
    mov edx, offset thankYouBorder
    call WriteString
    
    ; Display final message with blinking effect simulation
    mov eax, white + (lightGreen SHL 4)    ; White text on light green background
    call SetTextColor
    mov dl, 25
    mov dh, 27
    call Gotoxy
    mov edx, offset thankYouFinalMsg
    call WriteString
    
    ; Wait for key press
    call ReadChar
    
    ; Clear screen before exiting
    call clrscr
    ret
DisplayThankYouScreen ENDP


CheckCollision PROC
    cmp collision, 1
    jne CC_End
    mov level, 1
    call ResetGame
    call StartLevel1
CC_End:
    ret
CheckCollision ENDP

; ========== ENEMY BULLET PROCEDURES ==========
CreateEnemyBulletFromEnemy PROC
    push ecx
    push esi
    
    mov ecx, MAX_ENEMY_BULLETS
    mov edi, OFFSET enemyBullets
    
CEBFE_Slot:
    cmp (EnemyBullet PTR [edi]).active, 0
    je CEBFE_Create
    add edi, TYPE EnemyBullet
    loop CEBFE_Slot
    
    pop esi
    pop ecx
    ret
    
CEBFE_Create:
    mov al, (Enemy PTR [esi]).xPos
    mov (EnemyBullet PTR [edi]).xPos, al
    
    mov al, (Enemy PTR [esi]).yPos
    inc al
    cmp al, 28
    jge CEBFE_Skip
    mov (EnemyBullet PTR [edi]).yPos, al
    mov (EnemyBullet PTR [edi]).active, 1
    
    push esi
    mov esi, edi
    call DrawEnemyBullet
    pop esi
    
CEBFE_Skip:
    pop esi
    pop ecx
    ret
CreateEnemyBulletFromEnemy ENDP

UpdateEnemyBullets PROC
    mov ecx, MAX_ENEMY_BULLETS
    mov esi, OFFSET enemyBullets
    
UEB_Loop:
    cmp (EnemyBullet PTR [esi]).active, 1
    jne UEB_Next
    
    call EraseEnemyBullet
    inc (EnemyBullet PTR [esi]).yPos
    
    cmp (EnemyBullet PTR [esi]).yPos, 28
    jg UEB_Deact
    
    call DrawEnemyBullet
    jmp UEB_Next
    
UEB_Deact:
    mov (EnemyBullet PTR [esi]).active, 0
    
UEB_Next:
    add esi, TYPE EnemyBullet
    loop UEB_Loop
    ret
UpdateEnemyBullets ENDP

; ========== DRAWING PROCEDURES ==========
DrawEnemy PROC
    push esi
    mov dl, (Enemy PTR [esi]).xPos
    mov dh, (Enemy PTR [esi]).yPos
    call Gotoxy
    mov eax, red + (black SHL 4)
    call SetTextColor
    mov al, 'V'
    call WriteChar
    pop esi
    ret
DrawEnemy ENDP

EraseEnemy PROC
    push esi
    mov dl, (Enemy PTR [esi]).xPos
    mov dh, (Enemy PTR [esi]).yPos
    call Gotoxy
    mov al, ' '
    call WriteChar
    pop esi
    ret
EraseEnemy ENDP

DrawEnemyBullet PROC
    push esi
    mov dl, (EnemyBullet PTR [esi]).xPos
    mov dh, (EnemyBullet PTR [esi]).yPos
    
    cmp dl, 1
    jle DEB_Skip
    cmp dl, 118
    jge DEB_Skip
    cmp dh, 3
    jle DEB_Skip
    cmp dh, 27
    jg DEB_Skip
    
    call Gotoxy
    
    ; Check level and set appropriate color
    cmp level, 2
    je DEB_Level2
    cmp level, 3
    je DEB_Level3
    
    ; Default color (Level 1)
    mov eax, red + (black SHL 4)
    jmp DEB_Draw
    
DEB_Level2:
    mov eax, brown + (black SHL 4)  ; Brown for Level 2
    jmp DEB_Draw
    
DEB_Level3:
    mov eax, magenta + (black SHL 4) ; Magenta for Level 3
    
DEB_Draw:
    call SetTextColor
    mov al, '$'    ; Enemy bullet symbol
    call WriteChar
    
DEB_Skip:
    pop esi
    ret 
DrawEnemyBullet ENDP


EraseEnemyBullet PROC
    push esi
    mov dl, (EnemyBullet PTR [esi]).xPos
    mov dh, (EnemyBullet PTR [esi]).yPos
    
    cmp dl, 1
    jle EEB_Skip
    cmp dl, 118
    jge EEB_Skip
    cmp dh, 3
    jle EEB_Skip
    cmp dh, 27
    jg EEB_Skip
    
    call Gotoxy
    mov al, ' '
    call WriteChar
    
EEB_Skip:
    pop esi
    ret
EraseEnemyBullet ENDP

DrawPlayer PROC
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov al, "x"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov al, " "
    call WriteChar
    ret
UpdatePlayer ENDP

RedrawBorders PROC
    mov eax, blue + (black SHL 4)
    call SetTextColor
    
    mov dl, 0
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    
    mov dl, 0
    mov dh, 29
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    
    mov x_save, 0
    mov y_save, 2
    mov ecx, 27
RB_Left:
    mov dl, x_save
    mov dh, y_save
    call Gotoxy
    mov al, '#'
    call WriteChar
    inc y_save
    loop RB_Left
    
    mov x_save, 119
    mov y_save, 2
    mov ecx, 27
RB_Right:
    mov dl, x_save
    mov dh, y_save
    call Gotoxy
    mov al, '#'
    call WriteChar
    inc y_save
    loop RB_Right
    ret
RedrawBorders ENDP

; ========== BULLET PROCEDURES ==========
CreateBullet PROC
    mov ecx, MAX_BULLETS
    mov esi, OFFSET bullets
    
CB_Find:
    cmp (Bullet PTR [esi]).active, 0
    je CB_Create
    add esi, TYPE Bullet
    loop CB_Find
    ret
    
CB_Create:
    mov al, xPos
    mov (Bullet PTR [esi]).xPos, al
    mov al, yPos
    dec al
    mov (Bullet PTR [esi]).yPos, al
    mov (Bullet PTR [esi]).active, 1
    
    mov dl, (Bullet PTR [esi]).xPos
    mov dh, (Bullet PTR [esi]).yPos
    call Gotoxy
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov al, 'I'
    call WriteChar
    ret
CreateBullet ENDP

UpdateBullets PROC
    mov ecx, MAX_BULLETS
    mov esi, OFFSET bullets
    
UB_Loop:
    cmp (Bullet PTR [esi]).active, 1
    jne UB_Next
    
    mov dl, (Bullet PTR [esi]).xPos
    mov dh, (Bullet PTR [esi]).yPos
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    dec (Bullet PTR [esi]).yPos
    
    cmp (Bullet PTR [esi]).yPos, 2
    jle UB_Deact
    
    mov dl, (Bullet PTR [esi]).xPos
    mov dh, (Bullet PTR [esi]).yPos
    call Gotoxy
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov al, 'I'
    call WriteChar
    jmp UB_Next
    
UB_Deact:
    mov (Bullet PTR [esi]).active, 0
    
UB_Next:
    add esi, TYPE Bullet
    loop UB_Loop
    ret
UpdateBullets ENDP

EraseBullet PROC
    push edi
    mov dl, (Bullet PTR [edi]).xPos
    mov dh, (Bullet PTR [edi]).yPos
    call Gotoxy
    mov al, ' '
    call WriteChar
    pop edi
    ret
EraseBullet ENDP

; ========== UTILITY PROCEDURES ==========
ClearAllBullets PROC
    mov ecx, MAX_BULLETS
    mov esi, OFFSET bullets
CAB_Loop:
    cmp (Bullet PTR [esi]).active, 1
    jne CAB_Skip
    call EraseBullet
CAB_Skip:
    mov (Bullet PTR [esi]).active, 0
    add esi, TYPE Bullet
    loop CAB_Loop
    
    mov ecx, MAX_ENEMY_BULLETS
    mov esi, OFFSET enemyBullets
CAB_Loop2:
    cmp (EnemyBullet PTR [esi]).active, 1
    jne CAB_Skip2
    call EraseEnemyBullet
CAB_Skip2:
    mov (EnemyBullet PTR [esi]).active, 0
    add esi, TYPE EnemyBullet
    loop CAB_Loop2
    ret
ClearAllBullets ENDP

ResetGame PROC
    call Clrscr
    mov InputChar, " "
    mov xPos, 60
    mov yPos, 28
    call UpdatePlayer
    call DrawPlayer
    call InitWalls
    call ClearAllBullets
    call ClearAllSuperFoods
    mov iteration, 1
    mov collision, 0
    mov enemyHorizontalCounter, 0
    mov enemyVerticalCounter, 0
    mov level3RandomCounter, 0
    mov borderRedrawCounter, 0
    
    ; Set enhanced speeds based on level
    cmp level, 2
    jne RG_CheckLevel3
    mov enemyHorizontalDelay, 1
    mov enemyVerticalDelay, 25
    jmp RG_End
RG_CheckLevel3:
    cmp level, 3
    jne RG_End
    mov level3RandomDelay, 1
RG_End:
    ret
ResetGame ENDP

InitWalls PROC
    mov eax, blue + (black SHL 4)
    call SetTextColor
    
    mov dl, 0
    mov dh, 29
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    
    mov dl, 0
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    
    mov x_save, 0
    mov y_save, 2
    mov ecx, 27
IW_Left:
    mov dl, x_save
    mov dh, y_save
    call Gotoxy
    mov edx, OFFSET ground2
    call WriteString
    inc y_save
    loop IW_Left
    
    mov x_save, 119
    mov y_save, 2
    mov ecx, 27
IW_Right:
    mov dl, x_save
    mov dh, y_save
    call Gotoxy
    mov edx, OFFSET ground2
    call WriteString
    inc y_save
    loop IW_Right
    ret
InitWalls ENDP

InitPlayer PROC
    mov xPos, 60
    mov yPos, 28
    ret
InitPlayer ENDP

DisplayInfo PROC
    ; Display SCORE in yellow
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 0
    mov dh, 0
    call Gotoxy
    mov edx, OFFSET strScore
    call WriteString
    
    ; Clear score area before writing new score
    mov dl, 8
    mov dh, 0
    call Gotoxy
    mov al, ' '
    call WriteChar    ; Clear first digit
    call WriteChar    ; Clear second digit
    call WriteChar    ; Clear third digit
    
    ; Position cursor back and write score
    mov dl, 8
    mov dh, 0
    call Gotoxy
    movzx eax, score
    call writeDEC
    
    ; Display LEVEL in cyan
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    mov dl, 100
    mov dh, 0
    call Gotoxy
    mov edx, offset strLevel
    call WriteString
    
    ; Clear level area and write level
    mov dl, 108
    mov dh, 0
    call Gotoxy
    mov al, ' '
    call WriteChar    ; Clear level digit
    
    mov dl, 108
    mov dh, 0
    call Gotoxy
    movzx eax, level
    call writeDEC
    
    ; Display LIVES in light green
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 0
    mov dh, 1
    call Gotoxy
    mov edx, OFFSET strLives
    call WriteString
    
    ; FIXED: Clear lives display area before writing new value
    mov dl, 8
    mov dh, 1
    call Gotoxy
    mov al, ' '
    call WriteChar    ; Clear first digit position
    call WriteChar    ; Clear second digit position
    
    ; Position cursor back to start of lives number and write lives
    mov dl, 8
    mov dh, 1
    call Gotoxy
    movzx eax, lives
    call writeDEC
    
    ; Display Current Enemies in light red
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 100
    mov dh, 1
    call Gotoxy
    mov edx, offset strEnemies
    call WriteString
    
    ; Clear enemy count area before writing new value
    mov dl, 117
    mov dh, 1
    call Gotoxy
    mov al, ' '
    call WriteChar    ; Clear first digit position
    call WriteChar    ; Clear second digit position
    
    ; Position cursor back and write enemy count
    mov dl, 117
    mov dh, 1  
    call Gotoxy
    movzx eax, currentEnemies
    call writeDEC
    
    ; Reset to default color (white on black) for other text
    mov eax, white + (black SHL 4)
    call SetTextColor
    
    ret
DisplayInfo ENDP


GameDelay PROC
    movzx eax, gamespeed
    call Delay
    ret
GameDelay ENDP

OpenPortal PROC
    mov eax, brown + (black SHL 4)
    call SetTextColor
    mov al, "P"
    mov dh, 28
    mov dl, 119
    call Gotoxy
    call Writechar
    ret
OpenPortal ENDP

; Pause game -> Feature Handler
PauseGame PROC
    mov dh, 0
    mov dl, 50
    call gotoxy
    mov edx, offset strPause
    call WriteString
    call ReadChar
    
    mov al, " "
    mov ecx, 5
    mov dl, 50
    mov dh, 0
PG_Clear:
    call gotoxy
    call writechar
    inc dl
    loop PG_Clear
    ret
PauseGame ENDP

; End Game -> Feature Handler
EndGame PROC
    call clrScr
    
    ; Display decorative border at top
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 3
    call Gotoxy
    mov edx, offset decorativeBorder
    call WriteString
    
    ; Display "GAME OVER" title in large letters
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 35
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET strGameOver
    call WriteString
    
    ; Display decorative separator
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 7
    call Gotoxy
    mov edx, offset strGameOverLine
    call WriteString
    
    ; Display player information box header
    mov eax, lightCyan + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, offset strPlayerStats
    call WriteString
    
    ; Display player name with decoration
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 13
    call Gotoxy
    mov edx, offset strPlayerNameLabel
    call WriteString
    
    mov eax, white + (red SHL 4)  ; White text on green background for emphasis
    call SetTextColor
    mov edx, offset username
    call WriteString
    
    ; Display final score with decoration
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 15
    call Gotoxy
    mov edx, offset strFinalScoreLabel
    call WriteString
    
    mov eax, white + (red SHL 4)  ; White text on yellow background for emphasis
    call SetTextColor
    movzx eax, score
    call writeDEC
    
    ; Display level reached
    mov eax, red + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 17
    call Gotoxy
    mov edx, offset strLevelReached
    call WriteString
    
    mov eax, white + (red SHL 4)  ; White text on magenta background
    call SetTextColor
    movzx eax, level
    call writeDEC
    
    ; Display performance message based on score
    call DisplayPerformanceMessage
    
    ; Display decorative border at bottom
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    mov dl, 15
    mov dh, 22
    call Gotoxy
    mov edx, offset decorativeBorder
    call WriteString
    
    ; Display instruction to continue
    mov eax, white + (blue SHL 4)  ; White on blue for visibility
    call SetTextColor
    mov dl, 25
    mov dh, 25
    call Gotoxy
    mov edx, offset strPressKeyToContinue
    call WriteString
    
    ; Wait for user to press any key (not just Enter)
    call ReadChar
    
    ; Save the record first
    call SaveRecord
    
    ; Display highest score screen
    call DisplayHighestScore
    
    ; Display Thank You screen after highest score
    call DisplayThankYouScreen
    
    call clrScr
    ret
EndGame ENDP

; Procedure -> Individual Player Statisitcs -> Displayer
DisplayPerformanceMessage PROC
    ; Determine performance based on score and level
    movzx eax, score
    cmp eax, 100
    jge DPM_Excellent
    cmp eax, 50
    jge DPM_Good
    jmp DPM_TryAgain
    
DPM_Excellent:
    mov eax, green + (black SHL 4)
    call SetTextColor
    mov dl, 22
    mov dh, 19
    call Gotoxy
    mov edx, offset strExcellentPerf
    call WriteString
    ret
    
DPM_Good:
    mov eax, lightBlue + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 19
    call Gotoxy
    mov edx, offset strGoodPerf
    call WriteString
    ret
    
DPM_TryAgain:
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 27
    mov dh, 19
    call Gotoxy
    mov edx, offset strTryAgainPerf
    call WriteString
    ret
DisplayPerformanceMessage ENDP



; Enhanced SaveRecord procedure with consistent format and proper separator placement
SaveRecord PROC
    ; Convert score to string
    movzx eax, score
    mov ecx, 10
    xor bx, bx
SR_Divide:
    xor edx, edx
    div ecx
    push dx
    inc bx
    test eax, eax
    jnz SR_Divide
    
    mov cx, bx
    lea esi, strResult
SR_Digit:
    pop ax
    add al, '0'
    mov [esi], al
    inc esi
    loop SR_Digit
    mov byte ptr [esi], 0  ; Null terminate
    
    ; Convert level to string
    movzx eax, level
    add al, '0'           ; Convert to ASCII
    mov levelStr[0], al
    mov levelStr[1], 0    ; Null terminate
    
    ; Try to read existing file first
    mov edx, OFFSET filename
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    
    ; File exists, read its content
    mov ebx, eax          ; Save file handle
    mov edx, OFFSET tempBuffer
    mov ecx, 1000
    call ReadFromFile
    mov bytesRead, eax    ; Save number of bytes read
    mov eax, ebx
    call CloseFile
    
    ; Now create/overwrite the file with old content + new content
    mov edx, OFFSET filename
    call CreateOutputFile
    mov RecordFileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    je SR_End
    
    ; Write back the old content first
    cmp bytesRead, 0
    je SR_WriteNew        ; No old content
    mov eax, RecordFileHandle
    mov edx, OFFSET tempBuffer
    mov ecx, bytesRead
    call WriteToFile
    
SR_WriteNew:
    ; Write opening separator line
    mov eax, RecordFileHandle
    mov edx, OFFSET separatorLine
    mov ecx, 26           ; Length of separator line
    call WriteToFile
    
    ; Write "Name : "
    mov eax, RecordFileHandle
    mov edx, OFFSET Write1
    mov ecx, 7            ; Length of "Name : "
    call WriteToFile
    
    ; Write username (calculate length)
    mov esi, OFFSET username
    mov ecx, 0
SR_CountName:
    cmp byte ptr [esi + ecx], 0
    je SR_WriteName
    inc ecx
    cmp ecx, 255
    jl SR_CountName
    
SR_WriteName:
    mov eax, RecordFileHandle
    mov edx, OFFSET username
    call WriteToFile
    
    ; Write newline
    mov eax, RecordFileHandle
    mov edx, OFFSET newline
    mov ecx, 2            ; Length of 0Dh,0Ah
    call WriteToFile
    
    ; Write "Score : "
    mov eax, RecordFileHandle
    mov edx, OFFSET Write2
    mov ecx, 8            ; Length of "Score : "
    call WriteToFile
    
    ; Write score (calculate length)
    mov esi, OFFSET strResult
    mov ecx, 0
SR_CountScore:
    cmp byte ptr [esi + ecx], 0
    je SR_WriteScore
    inc ecx
    cmp ecx, 16
    jl SR_CountScore
    
SR_WriteScore:
    mov eax, RecordFileHandle
    mov edx, OFFSET strResult
    call WriteToFile
    
    ; Write newline
    mov eax, RecordFileHandle
    mov edx, OFFSET newline
    mov ecx, 2
    call WriteToFile
    
    ; Write "LEVEL : " (using consistent format)
    mov eax, RecordFileHandle
    mov edx, OFFSET strLevel
    mov ecx, 8            ; Length of "LEVEL : "
    call WriteToFile
    
    ; Write level
    mov eax, RecordFileHandle
    mov edx, OFFSET levelStr
    mov ecx, 1
    call WriteToFile
    
    ; Write newline to complete the record
    mov eax, RecordFileHandle
    mov edx, OFFSET newline
    mov ecx, 2
    call WriteToFile
    
SR_End:
    mov eax, RecordFileHandle
    call CloseFile
    ret
SaveRecord ENDP

; Procedure to display highest score screen -> Feature Handler
DisplayHighestScore PROC
    call ReadAndParseScores
    
    ; Clear screen and set title color
    call clrScr
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    
    ; Display title
    mov dl, 25
    mov dh, 5
    call Gotoxy
    mov edx, offset strHighScore
    call WriteString
    
    ; Check if we found any scores
    cmp highScoreValue, 0
    je DHS_NoRecords
    
    ; Display best player name
    mov eax, cyan + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 8
    call Gotoxy
    mov edx, offset strHighName
    call WriteString
    
    mov eax, white + (black SHL 4)
    call SetTextColor
    mov edx, offset highScoreName
    call WriteString
    
    ; Display highest score
    mov eax, lightGreen + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 10
    call Gotoxy
    mov edx, offset strHighScoreDisp
    call WriteString
    
    mov eax, yellow + (black SHL 4)
    call SetTextColor
    movzx eax, highScoreValue
    call WriteDec
    
    ; Display level achieved
    mov eax, lightRed + (black SHL 4)
    call SetTextColor
    mov dl, 20
    mov dh, 12
    call Gotoxy
    mov edx, offset strHighLevel
    call WriteString
    
    mov eax, magenta + (black SHL 4)
    call SetTextColor
    movzx eax, highScoreLevel
    call WriteDec
    
    jmp DHS_Continue
    
DHS_NoRecords:
    mov eax, red + (black SHL 4)
    call SetTextColor
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, offset strNoRecords
    call WriteString
    
DHS_Continue:
    ; Display "Press any key" message
    mov eax, white + (black SHL 4)
    call SetTextColor
    mov dl, 25
    mov dh, 18
    call Gotoxy
    mov edx, offset strPressAny
    call WriteString
    
    ; Wait for key press
    call ReadChar
    
    ; Clear screen before returning
    call clrScr
    ret
DisplayHighestScore ENDP

; File Handling Parsing -> Feature
ReadAndParseScores PROC
    ; Initialize highest score tracking
    mov highScoreValue, 0
    mov highScoreLevel, 0
    
    ; Clear the name buffer
    mov ecx, 256
    mov edi, offset highScoreName
    mov al, 0
    rep stosb
    
    ; Try to open the scores file
    mov edx, offset filename
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je RAPS_End  ; File doesn't exist or can't open
    
    ; Read entire file into buffer
    mov ebx, eax  ; Save file handle
    mov edx, offset fileBuffer
    mov ecx, 2000
    call ReadFromFile
    mov bytesRead, eax
    
    ; Close file
    mov eax, ebx
    call CloseFile
    
    ; Only parse if we read something
    cmp bytesRead, 0
    je RAPS_End
    
    ; Parse the buffer to find scores
    call SimpleParseRecords
    
RAPS_End:
    ret
ReadAndParseScores ENDP

; COMPLETELY REWRITTEN: Simple, linear parsing approach
SimpleParseRecords PROC
    mov esi, offset fileBuffer
    mov parseIndex, 0
    
SPR_MainLoop:
    mov eax, parseIndex
    cmp eax, bytesRead
    jge SPR_End
    
    ; Skip separator lines and empty lines
    call SkipNonDataLines
    
    ; Check if we've reached the end
    mov eax, parseIndex
    cmp eax, bytesRead
    jge SPR_End
    
    ; Try to find and parse a complete record
    call ParseSingleRecord
    
    ; Continue to next record
    jmp SPR_MainLoop
    
SPR_End:
    ret
SimpleParseRecords ENDP

; Skip separator lines, empty lines, and other non-data lines
SkipNonDataLines PROC
    mov esi, offset fileBuffer
    
SNDL_Loop:
    mov eax, parseIndex
    cmp eax, bytesRead
    jge SNDL_End
    
    mov bl, byte ptr [esi + eax]
    
    ; Skip if line starts with '-' (separator)
    cmp bl, '-'
    je SNDL_SkipLine
    
    ; Skip if empty line (CR or LF)
    cmp bl, 0Dh
    je SNDL_SkipChar
    cmp bl, 0Ah
    je SNDL_SkipChar
    
    ; Skip spaces
    cmp bl, ' '
    je SNDL_SkipChar
    
    ; If we reach here, we found actual content
    ret
    
SNDL_SkipChar:
    inc eax
    mov parseIndex, eax
    jmp SNDL_Loop
    
SNDL_SkipLine:
    ; Skip entire line
SNDL_SkipLineLoop:
    mov eax, parseIndex
    cmp eax, bytesRead
    jge SNDL_End
    mov bl, byte ptr [esi + eax]
    inc eax
    mov parseIndex, eax
    cmp bl, 0Ah  ; Found line feed, line is skipped
    je SNDL_Loop
    jmp SNDL_SkipLineLoop
    
SNDL_End:
    ret
SkipNonDataLines ENDP

; Parse a single complete record (Name, Score, Level)
ParseSingleRecord PROC
    ; Clear current record variables
    mov currentScore, 0
    mov currentLevel, 0
    
    ; Clear currentName buffer
    push edi
    mov edi, offset currentName
    mov ecx, 256
    mov al, 0
    rep stosb
    pop edi
    
    ; Look for name field
    call FindAndExtractName
    cmp eax, 0  ; 0 = success, -1 = failure
    jne PSR_End
    
    ; Look for score field
    call FindAndExtractScore
    cmp eax, 0
    jne PSR_End
    
    ; Look for level field (optional)
    call FindAndExtractLevel
    ; Don't check return value - level is optional
    
    ; Check if this is a new high score
    mov ax, currentScore
    cmp ax, highScoreValue
    jle PSR_End
    
    ; New high score found!
    mov highScoreValue, ax
    mov al, currentLevel
    mov highScoreLevel, al
    
    ; Copy name to high score name
    push esi
    push edi
    mov esi, offset currentName
    mov edi, offset highScoreName
    mov ecx, 256
    rep movsb
    pop edi
    pop esi
    
PSR_End:
    ret
ParseSingleRecord ENDP

; Procedure: Find and extract name with proper string matching
FindAndExtractName PROC
    mov esi, offset fileBuffer
    
    ; Search for "Name :" pattern
    call SearchForPattern
    .data
    namePattern byte "Name :",0
    .code
    
    cmp eax, -1
    jne FAEN_FoundName
    
    ; Try "YOUR NAME:" pattern
    call SearchForYourName
    cmp eax, -1
    jne FAEN_FoundName
    
    ; Name not found
    mov eax, -1
    ret
    
FAEN_FoundName:
    ; Extract the name after the pattern
    call ExtractNameValue
    mov eax, 0  ; Success
    ret
FindAndExtractName ENDP

; Procedure: Search for "Name :" pattern using simple character-by-character comparison
SearchForPattern PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
SFP_Loop:
    cmp eax, bytesRead
    jge SFP_NotFound
    
    ; Check for 'N'
    cmp byte ptr [esi + eax], 'N'
    jne SFP_Next
    
    ; Check remaining characters "ame :"
    push eax
    inc eax
    cmp byte ptr [esi + eax], 'a'
    jne SFP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'm'
    jne SFP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'e'
    jne SFP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ':'
    jne SFP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFP_CheckNoSpace
    inc eax
    
SFP_CheckNoSpace:
    ; Found "Name :" - update parse index to point after the colon and space
    mov parseIndex, eax
    pop eax  ; Clean stack
    mov eax, 0  ; Success
    ret
    
SFP_NoMatch:
    pop eax
    
SFP_Next:
    inc eax
    jmp SFP_Loop
    
SFP_NotFound:
    mov eax, -1
    ret
SearchForPattern ENDP

; Procedure: Search for "YOUR NAME:" pattern
SearchForYourName PROC
    mov esi, offset fileBuffer  
    mov eax, parseIndex
    
SFYN_Loop:
    cmp eax, bytesRead
    jge SFYN_NotFound
    
    ; Check for 'Y'
    cmp byte ptr [esi + eax], 'Y'
    jne SFYN_Next
    
    ; Check remaining characters "OUR NAME:"
    push eax
    inc eax
    cmp byte ptr [esi + eax], 'O'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'U'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'R'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'N'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'A'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'M'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'E'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ':'
    jne SFYN_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFYN_CheckNoSpace
    inc eax
    
SFYN_CheckNoSpace:
    ; Found "YOUR NAME:" - update parse index
    mov parseIndex, eax
    pop eax  ; Clean stack
    mov eax, 0  ; Success
    ret
    
SFYN_NoMatch:
    pop eax
    
SFYN_Next:
    inc eax
    jmp SFYN_Loop
    
SFYN_NotFound:
    mov eax, -1
    ret
SearchForYourName ENDP

; Extract name value after pattern is found
ExtractNameValue PROC
    mov esi, offset fileBuffer
    mov edi, offset currentName
    mov eax, parseIndex
    mov ecx, 0
    
ENV_Loop:
    cmp eax, bytesRead
    jge ENV_End
    
    mov bl, byte ptr [esi + eax]
    
    ; Stop at end of line
    cmp bl, 0Dh
    je ENV_End
    cmp bl, 0Ah
    je ENV_End
    
    ; Add character to name
    mov byte ptr [edi + ecx], bl
    inc eax
    inc ecx
    cmp ecx, 255  ; Prevent buffer overflow
    jl ENV_Loop
    
ENV_End:
    ; Null terminate the name
    mov byte ptr [edi + ecx], 0
    
    ; Skip to next line
    call SkipToNextLine
    ret
ExtractNameValue ENDP

; Procedure: Find and extract score
FindAndExtractScore PROC
    mov esi, offset fileBuffer
    
    ; Search for "Score :" pattern
    call SearchForScorePattern
    cmp eax, -1
    jne FAES_FoundScore
    
    ; Try "YOUR SCORE:" pattern
    call SearchForYourScore
    cmp eax, -1
    jne FAES_FoundScore
    
    ; Score not found
    mov eax, -1
    ret
    
FAES_FoundScore:
    ; Extract the score number
    call ExtractScoreValue
    mov eax, 0  ; Success
    ret
FindAndExtractScore ENDP

; Search for "Score :" pattern
SearchForScorePattern PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
SFSP_Loop:
    cmp eax, bytesRead
    jge SFSP_NotFound
    
    ; Check for 'S'
    cmp byte ptr [esi + eax], 'S'
    jne SFSP_Next
    
    ; Check remaining characters "core :"
    push eax
    inc eax
    cmp byte ptr [esi + eax], 'c'
    jne SFSP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'o'
    jne SFSP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'r'
    jne SFSP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'e'
    jne SFSP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFSP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ':'
    jne SFSP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFSP_CheckNoSpace
    inc eax
    
SFSP_CheckNoSpace:
    ; Found "Score :" - update parse index
    mov parseIndex, eax
    pop eax  ; Clean stack
    mov eax, 0  ; Success
    ret
    
SFSP_NoMatch:
    pop eax
    
SFSP_Next:
    inc eax
    jmp SFSP_Loop
    
SFSP_NotFound:
    mov eax, -1
    ret
SearchForScorePattern ENDP

; Search for "YOUR SCORE:" pattern
SearchForYourScore PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
SFYS_Loop:
    cmp eax, bytesRead
    jge SFYS_NotFound
    
    ; Check for 'Y'
    cmp byte ptr [esi + eax], 'Y'
    jne SFYS_Next
    
    ; Check remaining characters "OUR SCORE:"
    push eax
    inc eax
    cmp byte ptr [esi + eax], 'O'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'U'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'R'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'S'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'C'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'O'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'R'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'E'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ':'
    jne SFYS_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFYS_CheckNoSpace
    inc eax
    
SFYS_CheckNoSpace:
    ; Found "YOUR SCORE:" - update parse index
    mov parseIndex, eax
    pop eax  ; Clean stack
    mov eax, 0  ; Success
    ret
    
SFYS_NoMatch:
    pop eax
    
SFYS_Next:
    inc eax
    jmp SFYS_Loop
    
SFYS_NotFound:
    mov eax, -1
    ret
SearchForYourScore ENDP

; Extract score value (digits only)
ExtractScoreValue PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    mov currentScore, 0
    
    ; Skip any leading spaces
ESV_SkipSpaces:
    cmp eax, bytesRead
    jge ESV_End
    cmp byte ptr [esi + eax], ' '
    jne ESV_StartDigits
    inc eax
    jmp ESV_SkipSpaces
    
ESV_StartDigits:
ESV_Loop:
    cmp eax, bytesRead
    jge ESV_End
    
    mov bl, byte ptr [esi + eax]
    
    ; Check if it's a digit
    cmp bl, '0'
    jl ESV_End
    cmp bl, '9'
    jg ESV_End
    
    ; Convert ASCII digit to number
    sub bl, '0'
    movzx ebx, bl
    
    ; Multiply current score by 10 and add new digit
    movzx ecx, currentScore
    imul ecx, 10
    add ecx, ebx
    mov currentScore, cx
    
    inc eax
    jmp ESV_Loop
    
ESV_End:
    mov parseIndex, eax
    ; Skip to next line
    call SkipToNextLine
    ret
ExtractScoreValue ENDP

; Procedure: Find and extract level
FindAndExtractLevel PROC
    mov esi, offset fileBuffer
    
    ; Search for "LEVEL :" pattern
    call SearchForLevelPattern
    cmp eax, -1
    je FAEL_NotFound
    
    ; Extract the level number
    call ExtractLevelValue
    mov eax, 0  ; Success
    ret
    
FAEL_NotFound:
    ; Level not found - set default to 1
    mov currentLevel, 1
    mov eax, 0  ; Still success (level is optional)
    ret
FindAndExtractLevel ENDP

; Procedure: Search for "LEVEL :" pattern
SearchForLevelPattern PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
SFLP_Loop:
    cmp eax, bytesRead
    jge SFLP_NotFound
    
    ; Check for 'L'
    cmp byte ptr [esi + eax], 'L'
    jne SFLP_Next
    
    ; Check remaining characters "EVEL :"
    push eax
    inc eax
    cmp byte ptr [esi + eax], 'E'
    jne SFLP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'V'
    jne SFLP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'E'
    jne SFLP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], 'L'
    jne SFLP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFLP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ':'
    jne SFLP_NoMatch
    inc eax
    cmp byte ptr [esi + eax], ' '
    jne SFLP_CheckNoSpace
    inc eax
    
SFLP_CheckNoSpace:
    ; Found "LEVEL :" - update parse index
    mov parseIndex, eax
    pop eax  ; Clean stack
    mov eax, 0  ; Success
    ret
    
SFLP_NoMatch:
    pop eax
    
SFLP_Next:
    inc eax
    jmp SFLP_Loop
    
SFLP_NotFound:
    mov eax, -1
    ret
SearchForLevelPattern ENDP

; Procedure: Extract level value (single digit)
ExtractLevelValue PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    mov currentLevel, 1  ; Default level
    
    ; Skip any leading spaces
ELV_SkipSpaces:
    cmp eax, bytesRead
    jge ELV_End
    cmp byte ptr [esi + eax], ' '
    jne ELV_StartDigit
    inc eax
    jmp ELV_SkipSpaces
    
ELV_StartDigit:
    cmp eax, bytesRead
    jge ELV_End
    
    mov bl, byte ptr [esi + eax]
    
    ; Check if it's a digit
    cmp bl, '0'
    jl ELV_End
    cmp bl, '9'
    jg ELV_End
    
    ; Convert ASCII digit to number
    sub bl, '0'
    mov currentLevel, bl
    
ELV_End:
    ; Skip to next line or end
    call SkipToNextLine
    ret
ExtractLevelValue ENDP

; Helper: Skip to next line
SkipToNextLine PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
STNL_Loop:
    cmp eax, bytesRead
    jge STNL_End
    
    mov bl, byte ptr [esi + eax]
    inc eax
    
    ; Look for line feed to mark end of line
    cmp bl, 0Ah
    je STNL_Found
    
    jmp STNL_Loop
    
STNL_Found:
STNL_End:
    mov parseIndex, eax
    ret
SkipToNextLine ENDP


; Find next "Name :" or "YOUR NAME:" in buffer
FindNextName PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
FNN_Loop:
    cmp byte ptr [esi + eax], 0
    je FNN_NotFound
    
    ; Check for "Name :"
    cmp byte ptr [esi + eax], 'N'
    jne FNN_CheckYour
    cmp byte ptr [esi + eax + 1], 'a'
    jne FNN_CheckYour
    cmp byte ptr [esi + eax + 2], 'm'
    jne FNN_CheckYour
    cmp byte ptr [esi + eax + 3], 'e'
    jne FNN_CheckYour
    cmp byte ptr [esi + eax + 4], ' '
    jne FNN_CheckYour
    cmp byte ptr [esi + eax + 5], ':'
    jne FNN_CheckYour
    
    add eax, 7  ; Skip "Name : "
    mov parseIndex, eax
    ret
    
FNN_CheckYour:
    ; Check for "YOUR NAME:"
    cmp byte ptr [esi + eax], 'Y'
    jne FNN_Next
    cmp dword ptr [esi + eax], 'RUOY'  ; "YOUR" backwards due to little endian
    jne FNN_Next
    cmp dword ptr [esi + eax + 4], 'N '
    jne FNN_Next
    
    ; Find the colon and skip it
    add eax, 11  ; Skip "YOUR NAME: "
    mov parseIndex, eax
    ret
    
FNN_Next:
    inc eax
    jmp FNN_Loop
    
FNN_NotFound:
    mov eax, -1
    ret
FindNextName ENDP

; Procedure: Fixed ExtractName procedure
ExtractName PROC
    mov esi, offset fileBuffer
    mov edi, offset currentName
    mov eax, parseIndex
    mov ecx, 0
    
    ; Clear current name buffer
    push edi
    push ecx
    mov ecx, 256
    mov al, 0
    rep stosb
    pop ecx
    pop edi
    
    ; Skip any leading spaces
    mov eax, parseIndex
EN_SkipSpaces:
    mov bl, byte ptr [esi + eax]
    cmp bl, ' '
    jne EN_StartExtract
    inc eax
    jmp EN_SkipSpaces
    
EN_StartExtract:
    mov ecx, 0  ; Reset character counter
    
EN_Loop:
    mov bl, byte ptr [esi + eax]
    cmp bl, 0Dh  ; Carriage return (end of line)
    je EN_End
    cmp bl, 0Ah  ; Line feed
    je EN_End
    cmp bl, 0    ; Null terminator
    je EN_End
    
    ; Add character to name (including spaces within the name)
    mov byte ptr [edi + ecx], bl
    inc eax
    inc ecx
    cmp ecx, 255
    jl EN_Loop
    
EN_End:
    ; Remove trailing spaces
    dec ecx
EN_RemoveTrailing:
    cmp ecx, 0
    jl EN_NullTerminate
    cmp byte ptr [edi + ecx], ' '
    jne EN_NullTerminate
    mov byte ptr [edi + ecx], 0
    dec ecx
    jmp EN_RemoveTrailing
    
EN_NullTerminate:
    inc ecx
    mov byte ptr [edi + ecx], 0  ; Null terminate
    
    ; Skip to next line
EN_SkipToNextLine:
    mov bl, byte ptr [esi + eax]
    cmp bl, 0
    je EN_UpdateIndex
    cmp bl, 0Ah  ; Look for line feed
    je EN_FoundNewline
    inc eax
    jmp EN_SkipToNextLine
    
EN_FoundNewline:
    inc eax  ; Move past the line feed
    
EN_UpdateIndex:
    mov parseIndex, eax
    ret
ExtractName ENDP
; Fixed FindNextScore procedure
FindNextScore PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
FNS_Loop:
    cmp byte ptr [esi + eax], 0
    je FNS_NotFound
    
    ; Check for "Score : " (with space after Score)
    cmp byte ptr [esi + eax], 'S'
    jne FNS_CheckYour
    cmp byte ptr [esi + eax + 1], 'c'
    jne FNS_CheckYour
    cmp byte ptr [esi + eax + 2], 'o'
    jne FNS_CheckYour
    cmp byte ptr [esi + eax + 3], 'r'
    jne FNS_CheckYour
    cmp byte ptr [esi + eax + 4], 'e'
    jne FNS_CheckYour
    cmp byte ptr [esi + eax + 5], ' '
    jne FNS_CheckYour
    cmp byte ptr [esi + eax + 6], ':'
    jne FNS_CheckYour
    
    add eax, 8  ; Skip "Score : "
    mov parseIndex, eax
    ret
    
FNS_CheckYour:
    ; Check for "YOUR SCORE: "
    cmp byte ptr [esi + eax], 'Y'
    jne FNS_Next
    
    ; Simple pattern match for "YOUR SCORE: "
    push eax
    add eax, 12  ; Skip "YOUR SCORE: "
    pop ebx
    
    ; Verify it's actually "YOUR SCORE:"
    mov cl, byte ptr [esi + ebx + 1]
    cmp cl, 'O'
    jne FNS_Next
    mov cl, byte ptr [esi + ebx + 2]
    cmp cl, 'U'
    jne FNS_Next
    mov cl, byte ptr [esi + ebx + 3]
    cmp cl, 'R'
    jne FNS_Next
    
    mov parseIndex, eax
    ret
    
FNS_Next:
    inc eax
    jmp FNS_Loop
    
FNS_NotFound:
    mov eax, -1
    ret
FindNextScore ENDP

; Procedure: Fixed ExtractScore procedure
ExtractScore PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    mov currentScore, 0
    
    ; Skip any leading spaces
ES_SkipSpaces:
    mov bl, byte ptr [esi + eax]
    cmp bl, ' '
    jne ES_StartExtract
    inc eax
    jmp ES_SkipSpaces
    
ES_StartExtract:
ES_Loop:
    mov bl, byte ptr [esi + eax]
    cmp bl, '0'
    jl ES_End
    cmp bl, '9'
    jg ES_End
    
    ; Convert ASCII digit to number and add to score
    sub bl, '0'
    movzx ebx, bl
    movzx ecx, currentScore
    imul ecx, 10
    add ecx, ebx
    mov currentScore, cx
    
    inc eax
    jmp ES_Loop
    
ES_End:
    ; Skip to next line
ES_SkipToNextLine:
    mov bl, byte ptr [esi + eax]
    cmp bl, 0
    je ES_UpdateIndex
    cmp bl, 0Ah  ; Look for line feed
    je ES_FoundNewline
    inc eax
    jmp ES_SkipToNextLine
    
ES_FoundNewline:
    inc eax  ; Move past the line feed
    
ES_UpdateIndex:
    mov parseIndex, eax
    ret
ExtractScore ENDP

; Procedure: Fixed FindNextLevel procedure
FindNextLevel PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    
FNL_Loop:
    cmp byte ptr [esi + eax], 0
    je FNL_NotFound
    
    ; Check for "LEVEL : " (uppercase as in your file)
    cmp byte ptr [esi + eax], 'L'
    jne FNL_Next
    cmp byte ptr [esi + eax + 1], 'E'
    jne FNL_Next
    cmp byte ptr [esi + eax + 2], 'V'
    jne FNL_Next
    cmp byte ptr [esi + eax + 3], 'E'
    jne FNL_Next
    cmp byte ptr [esi + eax + 4], 'L'
    jne FNL_Next
    cmp byte ptr [esi + eax + 5], ' '
    jne FNL_Next
    cmp byte ptr [esi + eax + 6], ':'
    jne FNL_Next
    
    add eax, 8  ; Skip "LEVEL : "
    mov parseIndex, eax
    ret
    
FNL_Next:
    inc eax
    jmp FNL_Loop
    
FNL_NotFound:
    mov eax, -1
    ret
FindNextLevel ENDP


; Fixed ExtractLevel procedure
ExtractLevel PROC
    mov esi, offset fileBuffer
    mov eax, parseIndex
    mov currentLevel, 0
    
    ; Skip any leading spaces
EL_SkipSpaces:
    mov bl, byte ptr [esi + eax]
    cmp bl, ' '
    jne EL_StartExtract
    inc eax
    jmp EL_SkipSpaces
    
EL_StartExtract:
    mov bl, byte ptr [esi + eax]
    cmp bl, '0'
    jl EL_End
    cmp bl, '9'
    jg EL_End
    
    sub bl, '0'
    mov currentLevel, bl
    inc eax
    
    ; Skip to end of line or next record
EL_SkipToEnd:
    mov bl, byte ptr [esi + eax]
    cmp bl, 0
    je EL_End
    cmp bl, 0Ah  ; Line feed
    je EL_FoundNewline
    inc eax
    jmp EL_SkipToEnd
    
EL_FoundNewline:
    inc eax  ; Move past line feed
    
EL_End:
    mov parseIndex, eax
    ret
ExtractLevel ENDP

; Procedure: Copy current name to highest score name
CopyCurrentNameToHigh PROC
    mov esi, offset currentName
    mov edi, offset highScoreName
    mov ecx, 0
    
CCNTH_Loop:
    mov al, byte ptr [esi + ecx]
    mov byte ptr [edi + ecx], al
    cmp al, 0
    je CCNTH_End
    inc ecx
    cmp ecx, 255
    jl CCNTH_Loop
    
CCNTH_End:
    ret
CopyCurrentNameToHigh ENDP

END main