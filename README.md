# 🚀 Space Ship Battle - Assembly Language Game

A real-time, text-based space shooter game built with Assembly Language using the Irvine32 library. Command your spaceship through three challenging levels of intense space combat!

## 🎮 Game Overview

Space Ship Battle is an educational and entertaining console game that demonstrates core Assembly programming concepts including input handling, cursor manipulation, loops, procedures, and game logic implementation.

### 🎯 Objective

Control your spaceship and destroy enemy vessels before they reach your position. Progress through three increasingly difficult levels to achieve victory!

## 🕹️ Controls
| Key        | Action                        |
|------------|-------------------------------|
| `←` `→`    | Move spaceship left/right     |
| `Spacebar` | Fire bullets                  |
| `ESC`      | Exit game                     |
| `P`        | Pause game                    |

## 🎨 Game Elements

| Symbol      | Element     |
|-------------|-------------|
| `^` or `<^>`| Player Ship |
| `V` or `*`  | Enemy Ship  |
| `\|$`       | Bullet      |
| ` `         | Empty Space |
| `@`         | Super health|

## 📈 Game Levels

### 🟢 Level 1: Beginner
- **Enemies to defeat:** 5
- **Difficulty:** Easy
- **Features:** Slow enemy movement, minimal enemy fire

### 🟡 Level 2: Intermediate  
- **Enemies to defeat:** 10
- **Difficulty:** Medium
- **Features:** Faster enemies, side-to-side movement, enemy bullets

### 🔴 Level 3: Advanced
- **Enemies to defeat:** 15
- **Difficulty:** Hard  
- **Features:** Rapid enemy spawning, random movement patterns, intense enemy fire

## 🛠️ Technical Requirements

- **Platform:** Windows
- **IDE:** Visual Studio
- **Assembler:** MASM (Microsoft Macro Assembler)
- **Library:** Irvine32
- **Architecture:** x86/x64 compatible

## 📥 Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/noumanic/SpaceShip-Battle-Assembly.git
   cd SpaceShip-Battle-Assembly
   ```

2. **Prerequisites:**
   - Visual Studio (with MASM support)
   - Irvine32 library installed
   - Windows operating system

3. **Build and Run:**
   - Open `SpaceShipBattle.sln` in Visual Studio
   - Ensure Irvine32 library is properly linked
   - Build the project (Ctrl+Shift+B)
   - Run the executable from Debug folder

## 🎵 Audio Features

The game includes immersive sound effects:
- Welcome sound
- Menu navigation
- Shooting effects
- Victory/defeat sounds

## 📁 Project Structure

```
SpaceShipBattle/
├── main.asm                     # Main game source code  
├── Debug/                       # Compiled game + sound files
│   ├── SpaceShipBattle.exe     # Ready-to-run game!
│   └── *.wav                   # Audio files (required for gameplay)
├── assets/
│   ├── images/
│   │   ├── screenshots/         # Complete UI flow screenshots  
│   │   └── concept_art/         # Level design concepts
│   └── sounds/                 # Audio file references
├── docs/                       # Comprehensive documentation
├── SpaceShipBattle.sln         # Visual Studio solution
└── Scores.txt                  # High score data
```

## 🔧 Assembly Concepts Demonstrated

- **Input/Output Operations:** Keyboard input handling, console output
- **Memory Management:** Data structures and memory allocation
- **Control Flow:** Loops, conditional statements, procedure calls
- **System Calls:** Irvine32 library functions
- **Real-time Programming:** Game timing and synchronization
- **Modular Design:** Structured programming with procedures

## 📚 Learning Outcomes

This project helps understand:
- Low-level programming principles
- Assembly language syntax and structure
- Console application development
- Game loop implementation
- Real-time user interaction
- Procedural programming in Assembly

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for:
- Bug fixes
- Performance improvements
- New features
- Documentation updates

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎓 Educational Purpose

This game was developed as an educational project to demonstrate Assembly language programming skills and game development concepts at the low level. It serves as an excellent resource for students learning:
- Assembly language programming
- Game development fundamentals
- Console application design
- Real-time input handling

## 📸 Screenshots

📄 highest_score_screen10.png [.png] (264.4 KB)
📄 instructions_screen4.png [.png] (314.1 KB)
📄 level1_screen6.png [.png] (266.8 KB)
📄 level2_screen7.png [.png] (263.5 KB)
📄 level3_screen8.png [.png] (296.4 KB)
📄 menu_screen3.png [.png] (290.7 KB)
📄 name_input_screen5.png [.png] (262.5 KB)
📄 player_stats_screen9.png [.png] (313.6 KB)
📄 spaceship_battle_screen2.png [.png] (274.8 KB)
📄 thankyou_screen11.png [.png] (270.0 KB)
📄 welcome_screen1.png [.png] (283.7 KB)

## 🏆 Features

- ✅ Three progressive difficulty levels
- ✅ Real-time keyboard input
- ✅ Sound effects and audio feedback
- ✅ Score tracking system
- ✅ Player statistics
- ✅ Smooth console-based graphics
- ✅ Collision detection
- ✅ Enemy AI patterns

## 🚀 Future Enhancements

- [ ] Power-ups and special weapons
- [ ] Boss battles
- [ ] Multiplayer support
- [ ] Enhanced graphics
- [ ] More levels and challenges

---

**Made with ❤️ and Assembly Language**

*If you found this project helpful, please consider giving it a ⭐!*