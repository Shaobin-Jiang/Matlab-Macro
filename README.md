# Matlab Macro

![](https://shields.io/badge/Version-0.0.1_--_beta-brightgreen.svg?style=plastic) ![](https://shields.io/badge/License-MIT-informational.svg?style=plastic) ![](https://shields.io/badge/System-Windows_10-critical.svg?style=plastic) ![](https://shields.io/badge/Tested_on-Matlab_R2019a-orange.svg?style=plastic) ![](https://shields.io/badge/Contributions-Welcome-salmon.svg?style=plastic)

Matlab-Macro provides **convenient simulations of keyboard / mouse behaviors** (i.e., automated keyboard presses and mouse clicks) in **Matlab**, but also more than that. Offered as well are some **higher-level functions**, such as the simulation of the input of entire lines.

Matlab-Macro can also be **used together with PsychToolbox**, some methods of which can be replaced by their counterparts in the current tool.

The Matlab-Macro can be turned on / off with one line of code, so that ideally, one does not need to make numerous modifications to the code when switching from the development stage to real production.

## Table of Contents

- [Requirements](#requirements)
- [Install](#install)
- [Getting Started](#getting-started)
- [API Methods](#api-methods)
- [Maintainer](#maintainer)
- [Contributing](#contributing)
- [License](#license)

## Requirements

The mex files in the current repositories are compiled on **64-bit Windows 10**, and the entire set of tools is tested with **Matlab R2019a**. Ideally, one should be able to run the tool with these requirements satisfied.

Nevertheless, this **does not** mean that you need all these mentioned above to use the tool. It will probably work with other versions of Matlab as well; **it simply has not been tested yet**.

What really needs paying attention to is the operating system you are using. Because of the use of the mex files, you will need to compile the C files by yourself if you are not using a 64-bit Windows 10 operating system.

## Install

All you have to do is to **download the source code** and **add the directory where the `Macro.m` file is to Matlab's search path**.

An alternative is to run the `install.m` script. This will do exactly the same thing as in the first way of installing.

If you need also to build the C files from source, use the `mex` function to do that. Do not forget to put the compiled mex files into the `+lib` folder and remove the ones in the original repository.

## Getting Started

Using the Matlab-Macro is easy! One needs only to initialize a `Macro` class, and then call the built-in methods to automate keyboard and mouse input.

For example, let us first have the `Macro` class type `hello world` for us:

```matlab
m = Macro; % Initialize the Macro class
str = 'hello world';
for c = str
    m.keyboard(c); % Type each character in the string
    pause(0.01); % Let's slow it down, shall we
end
```

Copy the code above into the command line, make sure it has focus, and press <kbd style="font-family: Calibri;">Enter</kbd> to run the code. You should see the characters typed one by one as if by an invisible hand.

The `Macro.keyboard` method receives a **key name** each time it is called. It is **case sensitive** for certain inputs; for example, `keyboard('a')` and `keyboard('A')` will generate different outputs. There are also certain cases when the input argument of this method is **not case sensitive**, such as pressing `backspace` and `enter`. `keyboard('backspace')` and `keyboard('BACKSPACE')` would do abosolutely the same thing.

We will learn later that the `Macro` class has a built in method that simulates the input of entire lines, so that you actually do not need to write this many lines of codes. There are also other built-in methods, which we can learn in the [API methods](#api-methods) section.

## API Methods

### List of Methods

- [Macro.button](#macrobutton)
- [Macro.disable](#macrodisable)
- [Macro.enable](#macroenable)
- [Macro.getCursorPos](#macrogetcursorpos)
- [Macro.getKeyNames](#macrogetkeynames)
- [Macro.keyboard](#macrokeyboard)
- [Macro.mouseMoveTo](#macromousemoveto)
- [Macro.shortcut](#macroshortcut)
- [Macro.type](#macrotype)
- [Macro.GetMouse](#macrogetmouse)
- [Macro.KbCheck](#macrokbcheck)

### Macro.button

The `Macro.button` method simulates mouse clicks.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `behavior` | `char` | `'LEFTCLICK'` | `No` | Defines mouse behavior. If left blank, calling this method will simulate a single left button click (down and then up). Available values include `'LEFTDOWN'` / `'LEFTUP'` / `'RIGHTDOWN'` / `'RIGHTUP'` / `'MIDDLEDOWN'` / `'MIDDLEUP'` / `'LEFTCLICK'` / `'RIGHTCLICK'` / `'MIDDLECLICK'` / `'LEFTDOUBLECLICK'`. It is case-insensitive. |

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.button('LEFTDOUBLECLICK'); % Simulate a left button double click
```

[See full list of API methods](#list-of-methods)

### Macro.disable

The `Macro.disable` method disables the `Macro` class, which is enabled by default. All `Macro` methods called after disabling `Macro` will not function, with the exception of the **PsychToolbox specific** methods, which will then function as normal PsychToolbox methods.

**Input Arguments:**

*None*

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.keyboard('a'); % Character 'a' is typed
m.disable;
m.keyboard('b'); % This will not work
m.KbCheck('f'); % This will work the same way as KbCheck
```

[See full list of API methods](#list-of-methods)

### Macro.enable

The `Macro.enable` method enables the `Macro` class.

**Input Arguments:**

*None*

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.keyboard('a'); % Character 'a' is typed
m.disable;
m.keyboard('b'); % This will not work
m.enable;
m.keyboard('c'); % Character 'c' is typed
```

[See full list of API methods](#list-of-methods)

### Macro.getCursorPos

The `Macro.getCursorPos` is a **static** method that returns the current position of the cursor. It will still function when `Macro` is disabled.

**Input Arguments:**

*None*

**Return Values:**

| Value | Type | Description |
| :---: | :--: | :---------: |
| `x` | `double` | The distance between the current position of the cursor and the left side of the screen. |
| `y` | `double` | The distance between the current position of the cursor and the top side of the screen. |

**Example:**

```matlab
[x, y] = Macro.getCursorPos;
```

[See full list of API methods](#list-of-methods)

### Macro.getKeyNames

The `Macro.getKeyName` returns valid key names for the `Macro.keyboard` method.

**Input Arguments:**

*None*

**Return Values:**

| Value | Type | Description |
| :---: | :--: | :---------: |
| `t` | `table` | A 1-column table containing all valid key names. |

**Example:**

```matlab
m = Macro;
disp(m.getKeyName);
```

[See full list of API methods](#list-of-methods)

### Macro.keyboard

The `Macro.keyboard` method simulates keyboard inputs.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `key` | `char` | `-` | `Yes` | The name of the key awaiting input. For a list of valid key names, call the `Macro.getKeyName` method or check below. |
| `behavior` | `char` | `'PRESS'` | `No` | Defines input option. If left blank, calling this method will simulate a single key press (down and then up). Available values include `'DOWN'` / `'UP'` / `'PRESS'`. It is case-insensitive. |

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.keyboard('a'); % Simulate the pressing of the key 'a'
```

**List of Key Names:**

| Key | Case Sensitive | Key | Case Sensitive | Key | Case Sensitive |
| :-: | :------------: | :-: | :------------: | :-: | :------------: |
| <kbd style="font-family: Calibri;">backspace</kbd> | `No` | <kbd style="font-family: Calibri;">tab</kbd> | `No` | <kbd style="font-family: Calibri;">enter</kbd> | `No` |
| <kbd style="font-family: Calibri;">shift</kbd> | `No` | <kbd style="font-family: Calibri;">ctrl</kbd> | `No` | <kbd style="font-family: Calibri;">alt</kbd> | `No` |
| <kbd style="font-family: Calibri;">capsLock</kbd> | `No` | <kbd style="font-family: Calibri;">esc</kbd> | `No` | <kbd style="font-family: Calibri;">&nbsp;</kbd>(Space) | `No` |
| <kbd style="font-family: Calibri;">pageup</kbd> | `No` | <kbd style="font-family: Calibri;">pagedown</kbd> | `No` | <kbd style="font-family: Calibri;">end</kbd> | `No` |
| <kbd style="font-family: Calibri;">home</kbd> | `No` | <kbd style="font-family: Calibri;">arrowleft</kbd> | `No` | <kbd style="font-family: Calibri;">arrowup</kbd> | `No` |
| <kbd style="font-family: Calibri;">arrowright</kbd> | `No` | <kbd style="font-family: Calibri;">arrowdown</kbd> | `No` | <kbd style="font-family: Calibri;">prtsc</kbd> | `No` |
| <kbd style="font-family: Calibri;">insert</kbd> | `No` | <kbd style="font-family: Calibri;">delete</kbd> | `No` | <kbd style="font-family: Calibri;">a</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">b</kbd> | `Yes` | <kbd style="font-family: Calibri;">c</kbd> | `Yes` | <kbd style="font-family: Calibri;">d</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">e</kbd> | `Yes` | <kbd style="font-family: Calibri;">f</kbd> | `Yes` | <kbd style="font-family: Calibri;">g</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">h</kbd> | `Yes` | <kbd style="font-family: Calibri;">i</kbd> | `Yes` | <kbd style="font-family: Calibri;">j</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">k</kbd> | `Yes` | <kbd style="font-family: Calibri;">l</kbd> | `Yes` | <kbd style="font-family: Calibri;">m</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">n</kbd> | `Yes` | <kbd style="font-family: Calibri;">o</kbd> | `Yes` | <kbd style="font-family: Calibri;">p</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">q</kbd> | `Yes` | <kbd style="font-family: Calibri;">r</kbd> | `Yes` | <kbd style="font-family: Calibri;">s</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">t</kbd> | `Yes` | <kbd style="font-family: Calibri;">u</kbd> | `Yes` | <kbd style="font-family: Calibri;">v</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">w</kbd> | `Yes` | <kbd style="font-family: Calibri;">x</kbd> | `Yes` | <kbd style="font-family: Calibri;">y</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">z</kbd> | `Yes` | <kbd style="font-family: Calibri;">0</kbd> | `No` | <kbd style="font-family: Calibri;">1</kbd> | `No` |
| <kbd style="font-family: Calibri;">2</kbd> | `No` | <kbd style="font-family: Calibri;">3</kbd> | `No` | <kbd style="font-family: Calibri;">4</kbd> | `No` |
| <kbd style="font-family: Calibri;">5</kbd> | `No` | <kbd style="font-family: Calibri;">6</kbd> | `No` | <kbd style="font-family: Calibri;">7</kbd> | `No` |
| <kbd style="font-family: Calibri;">8</kbd> | `No` | <kbd style="font-family: Calibri;">9</kbd> | `No` | <kbd style="font-family: Calibri;">F1</kbd> | `No` |
| <kbd style="font-family: Calibri;">F2</kbd> | `No` | <kbd style="font-family: Calibri;">F3</kbd> | `No` | <kbd style="font-family: Calibri;">F4</kbd> | `No` |
| <kbd style="font-family: Calibri;">F5</kbd> | `No` | <kbd style="font-family: Calibri;">F6</kbd> | `No` | <kbd style="font-family: Calibri;">F7</kbd> | `No` |
| <kbd style="font-family: Calibri;">F8</kbd> | `No` | <kbd style="font-family: Calibri;">F9</kbd> | `No` | <kbd style="font-family: Calibri;">F10</kbd> | `No` |
| <kbd style="font-family: Calibri;">F11</kbd> | `No` | <kbd style="font-family: Calibri;">F12</kbd> | `No` | <kbd style="font-family: Calibri;">;</kbd> | `No` |
| <kbd style="font-family: Calibri;">=</kbd> | `No` | <kbd style="font-family: Calibri;">,</kbd> | `No` | <kbd style="font-family: Calibri;">_</kbd> | `No` |
| <kbd style="font-family: Calibri;">.</kbd> | `No` | <kbd style="font-family: Calibri;">/</kbd> | `No` | <kbd style="font-family: Calibri;">\`</kbd> | `No` |
| <kbd style="font-family: Calibri;">[</kbd> | `No` | <kbd style="font-family: Calibri;">\\</kbd> | `No` | <kbd style="font-family: Calibri;">]</kbd> | `No` |
| <kbd style="font-family: Calibri;">'</kbd> | `No` | <kbd style="font-family: Calibri;">numlock</kbd> | `No` | <kbd style="font-family: Calibri;">numpad0</kbd> | `No` |
| <kbd style="font-family: Calibri;">numpad1</kbd> | `No` | <kbd style="font-family: Calibri;">numpad2</kbd> | `No` | <kbd style="font-family: Calibri;">numpad3</kbd> | `No` |
| <kbd style="font-family: Calibri;">numpad4</kbd> | `No` | <kbd style="font-family: Calibri;">numpad5</kbd> | `No` | <kbd style="font-family: Calibri;">numpad6</kbd> | `No` |
| <kbd style="font-family: Calibri;">numpad7</kbd> | `No` | <kbd style="font-family: Calibri;">numpad8</kbd> | `No` | <kbd style="font-family: Calibri;">numpad9</kbd> | `No` |
| <kbd style="font-family: Calibri;">numpad*</kbd> | `No` | <kbd style="font-family: Calibri;">numpad+</kbd> | `No` | <kbd style="font-family: Calibri;">numpadenter</kbd> | `No` |
| <kbd style="font-family: Calibri;">numpad-</kbd> | `No` | <kbd style="font-family: Calibri;">numpad.</kbd> | `No` | <kbd style="font-family: Calibri;">numpad/</kbd> | `No` |
| <kbd style="font-family: Calibri;">:</kbd> | `No` | <kbd style="font-family: Calibri;">+</kbd> | `No` | <kbd style="font-family: Calibri;"><</kbd> | `No` |
| <kbd style="font-family: Calibri;">-</kbd> | `No` | <kbd style="font-family: Calibri;">></kbd> | `No` | <kbd style="font-family: Calibri;">?</kbd> | `No` |
| <kbd style="font-family: Calibri;">~</kbd> | `No` | <kbd style="font-family: Calibri;">{</kbd> | `No` | <kbd style="font-family: Calibri;">\|</kbd> | `No` |
| <kbd style="font-family: Calibri;">}</kbd> | `No` | <kbd style="font-family: Calibri;">"</kbd> | `No` | <kbd style="font-family: Calibri;">)</kbd> | `No` |
| <kbd style="font-family: Calibri;">!</kbd> | `No` | <kbd style="font-family: Calibri;">@</kbd> | `No` | <kbd style="font-family: Calibri;">#</kbd> | `No` |
| <kbd style="font-family: Calibri;">$</kbd> | `No` | <kbd style="font-family: Calibri;">%</kbd> | `No` | <kbd style="font-family: Calibri;">^</kbd> | `No` |
| <kbd style="font-family: Calibri;">&</kbd> | `No` | <kbd style="font-family: Calibri;">*</kbd> | `No` | <kbd style="font-family: Calibri;">(</kbd> | `No` |
| <kbd style="font-family: Calibri;">A</kbd> | `Yes` | <kbd style="font-family: Calibri;">B</kbd> | `Yes` | <kbd style="font-family: Calibri;">C</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">D</kbd> | `Yes` | <kbd style="font-family: Calibri;">E</kbd> | `Yes` | <kbd style="font-family: Calibri;">F</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">G</kbd> | `Yes` | <kbd style="font-family: Calibri;">H</kbd> | `Yes` | <kbd style="font-family: Calibri;">I</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">J</kbd> | `Yes` | <kbd style="font-family: Calibri;">K</kbd> | `Yes` | <kbd style="font-family: Calibri;">L</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">M</kbd> | `Yes` | <kbd style="font-family: Calibri;">N</kbd> | `Yes` | <kbd style="font-family: Calibri;">O</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">P</kbd> | `Yes` | <kbd style="font-family: Calibri;">Q</kbd> | `Yes` | <kbd style="font-family: Calibri;">R</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">S</kbd> | `Yes` | <kbd style="font-family: Calibri;">T</kbd> | `Yes` | <kbd style="font-family: Calibri;">U</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">V</kbd> | `Yes` | <kbd style="font-family: Calibri;">W</kbd> | `Yes` | <kbd style="font-family: Calibri;">X</kbd> | `Yes` |
| <kbd style="font-family: Calibri;">Y</kbd> | `Yes` | <kbd style="font-family: Calibri;">Z</kbd> | `Yes` |  |  |


[See full list of API methods](#list-of-methods)

### Macro.mouseMoveTo

The `Macro.mouseMoveTo` method moves the cursor to the target position.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `x` | `double` | `-` | `Yes` | The distance between the target position of the cursor and the left side of the screen. |
| `y` | `double` | `-` | `Yes` | The distance between the target position of the cursor and the top side of the screen. |

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.mouseMoveTo(960, 540);
```

[See full list of API methods](#list-of-methods)

### Macro.shortcut

The `Macro.shortcut` method simulates the use of shortcuts, such as <kbd style="font-family: Calibri;">Ctrl</kbd> + <kbd style="font-family: Calibri;">v</kbd>.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `combination` | `cell` | `-` | `Yes` | The combination of keys in their correct order. |

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.shortcut({'ctrl', 'a'});
```

[See full list of API methods](#list-of-methods)

### Macro.type

The `Macro.type` method automates the input of an entire line.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `text` | `char` | `-` | `Yes` | The line of text awaiting input. The method processes a single character each time, so `'backspace'` will be treated as 9 single characters instead of one key name. |
| `pauseTime` | `double` | `0.01` | `No` | A **positive** value indicating the time in **seconds** to pause between the typing of two characters. If left blank, the pause time between two key pressings will be set to 0.01s. |

**Return Values:**

*None*

**Example:**

```matlab
m = Macro;
m.type('Hello world');
```

[See full list of API methods](#list-of-methods)

### Macro.GetMouse

The `Macro.GetMouse` method is a PsychToolbox specific function, and will only function if PsychToolbox is installed. Otherwise, it will do absolutely nothing. When enabled, the `Macro.GetMouse` method will simulate a button down, call PsychToolbox `GetMouse` method, and then simulate a button up. When disabled, the `Macro.GetMouse` method functions the same way as directly calling the PsychToolbox `GetMouse` method.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `button` | `char` | `-` | `Yes` | Indicating which button to press. Available values include `LEFT` / `RIGHT` / `MIDDLE`. It is case-insensitive. |
| `posX` | `double` | `-` | `Yes` | The `x` coordinate of where to execute the button press. |
| `posY` | `double` | `-` | `Yes` | The `y` coordinate of where to execute the button press. |

**Return Values:**

Same as the PsychToolbox `GetMouse` method.

**Example:**

```matlab
m = Macro;
[x, y, buttons, focus, valuators, valinfo] = m.GetMouse('LEFT', 960, 540);
```

[See full list of API methods](#list-of-methods)

### Macro.KbCheck

The `Macro.KbCheck` method is a PsychToolbox specific function, and will only function if PsychToolbox is installed. Otherwise, it will do absolutely nothing. When enabled, the `Macro.KbCheck` method will simulate a key down, call PsychToolbox `KbCheck` method, and then simulate a key up. When disabled, the `Macro.KbCheck` method functions the same way as directly calling the PsychToolbox `KbCheck` method.

**Input Arguments:**

| Parameter | Type | Default | Required | Description |
| :-------: | :--: | :-----: | :------: | :---------- |
| `key` | `char` | `-` | `Yes` | The name of the key to press. It follows the same rule as in the `Macro.keyboard` method. |

**Return Values:**

Same as the PsychToolbox `KbCheck` method.

**Example:**

```matlab
m = Macro;
[keyIsDown, secs, keyCode, deltaSecs] = m.KbCheck('f');
```

[See full list of API methods](#list-of-methods)

## Maintainer

[@Shaobin Jiang](https://github.com/Shaobin-Jiang)

## Contributing

Feel free to [open an issue](https://github.com/Shaobin-Jiang/Matlab-Macro/issues/new) or submit PRs.

## License

[MIT](LICENSE) &copy; Shaobin Jiang