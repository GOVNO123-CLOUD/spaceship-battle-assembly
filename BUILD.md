# 🔨 Build Instructions

This document provides detailed instructions for building the Space Ship Battle game from source code.

## 📋 Prerequisites

### Required Software

1. **Visual Studio** (2019 or later recommended)
   - Download from: https://visualstudio.microsoft.com/
   - Ensure C++ build tools are installed

2. **Microsoft Macro Assembler (MASM)**
   - Usually included with Visual Studio C++ tools
   - Verify installation: Check for `ml.exe` in Visual Studio installation directory

3. **Irvine32 Library**
   - Download from: http://asmirvine.com/gettingStartedVS2019/index.htm
   - Follow the installation guide for Visual Studio integration

### System Requirements

- Windows 10/11 (32-bit or 64-bit)
- Minimum 4GB RAM
- 1GB free disk space
- Display capable of console text mode

## 🛠️ Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/noumanic/spaceship-battle-assembly.git
cd spaceship-battle-assembly
```

### Step 2: Install Irvine32 Library

1. Download the Irvine32 library files
2. Extract to a folder (e.g., `C:\Irvine`)
3. Copy the following files to your project directory:
   - `Irvine32.inc`
   - `Irvine32.lib`
   - `Kernel32.lib`
   - `User32.lib`

### Step 3: Configure Visual Studio

1. **Create New Project:**
   - File → New → Project
   - Choose "Empty Project" under Visual C++
   - Name: SpaceShipBattle

2. **Add Assembly File:**
   - Right-click project → Add → Existing Item
   - Select `main.asm`

3. **Configure Build Settings:**
   - Right-click on `main.asm` → Properties
   - Set "Item Type" to "Microsoft Macro Assembler"

4. **Set Project Properties:**
   - Right-click project → Properties
   - Configuration: All Configurations
   - Platform: Win32 (x86)

5. **Linker Settings:**
   - Go to Linker → Input
   - Additional Dependencies: Add
     ```
     kernel32.lib
     user32.lib
     irvine32.lib
     ```

6. **Include Directories:**
   - VC++ Directories → Include Directories
   - Add path to Irvine32 files

7. **Library Directories:**
   - VC++ Directories → Library Directories  
   - Add path to Irvine32 lib files

## 🏗️ Building the Project

### Method 1: Using Visual Studio IDE

1. Open the project in Visual Studio
2. Select "Debug" or "Release" configuration
3. Choose "x86" platform (important!)
4. Press `F7` or Build → Build Solution
5. The executable will be created in `Debug/` or `Release/` folder

### Method 2: Command Line Build

```bash

# Assemble the source file
ml /c /Fl main.asm

# Link the object file
link main.obj irvine32.lib kernel32.lib user32.lib /SUBSYSTEM:CONSOLE /OUT:SpaceShipBattle.exe

# Run the game
SpaceShipBattle.exe
```

## 🚨 Common Build Issues

### Issue 1: "Cannot open include file 'Irvine32.inc'"

**Solution:**
- Verify Irvine32.inc is in the project directory or include path
- Check that the file path doesn't contain special characters
- Ensure the filename case matches exactly

### Issue 2: "Unresolved external symbol"

**Solution:**
- Make sure `irvine32.lib` is linked properly
- Verify the library path in project settings
- Check that you're building for x86 (32-bit) platform

### Issue 3: "MASM not recognized"

**Solution:**
- Install Visual Studio C++ build tools
- Verify `ml.exe` exists in VS installation directory
- Restart Visual Studio after installation

### Issue 4: Runtime Error

**Solution:**
- Ensure console subsystem is set correctly
- Check that all required DLLs are available
- Run from command prompt to see error messages

## 🧪 Testing the Build

After successful build:

1. **Run the executable**
   ```bash
   cd Debug
   SpaceShipBattle.exe
   ```

2. **Test basic functionality:**
   - Game should display welcome screen
   - Arrow keys should move the player
   - Spacebar should fire bullets
   - ESC should exit the game

3. **Verify all levels:**
   - Complete Level 1 (5 enemies)
   - Complete Level 2 (10 enemies)
   - Complete Level 3 (15 enemies)

## 📦 Creating a Distribution

To create a distributable version:

1. **Build in Release mode**
2. **Copy required files:**
   ```
   SpaceShipBattle.exe
   (Any required DLLs)
   ```

3. **Test on clean system** without development tools

## 🔧 Advanced Configuration

### Custom Build Configurations

You can create custom build configurations for different purposes:

- **Debug:** Full symbols, no optimization
- **Release:** Optimized for performance
- **Testing:** With additional debug output

### Optimization Settings

For release builds, consider:
- Enable optimizations (`/Ox`)
- Strip debug symbols
- Use smaller alignment (`/Zp1`)

## 📞 Support

If you encounter build issues:

1. Check this document first
2. Verify all prerequisites are installed
3. Create an issue on GitHub with:
   - Error message
   - Visual Studio version
   - Build configuration
   - System specifications

---

**Happy Building! 🚀**