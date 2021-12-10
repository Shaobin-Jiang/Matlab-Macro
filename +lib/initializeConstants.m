function [keyboardBehavior, keys, mouseBehavior] = initializeConstants
keyboardBehavior = struct(...
    'DOWN', 1, ...
    'UP', 2, ...
    'PRESS', 3 ...
    );
keys = table(...
    {...
    'backspace'; 'tab'; 'enter'; 'shift'; 'ctrl'; 'alt'; 'capsLock'; 'esc'; ' '; 'pageup'; 'pagedown'; 'end'; 'home'; 'arrowleft'; 'arrowup'; 'arrowright'; 'arrowdown'; 'prtsc'; 'insert'; 'delete'; ...
    'a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'; 'i'; 'j'; 'k'; 'l'; 'm'; 'n'; 'o'; 'p'; 'q'; 'r'; 's'; 't'; 'u'; 'v'; 'w'; 'x'; 'y'; 'z'; ...
    '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; ...
    'F1'; 'F2'; 'F3'; 'F4'; 'F5'; 'F6'; 'F7'; 'F8'; 'F9'; 'F10'; 'F11'; 'F12'; ...
    ';'; '='; ','; '_'; '.'; '/'; '`'; '['; '\'; ']'; ''''; ...
    'numlock'; 'numpad0'; 'numpad1'; 'numpad2'; 'numpad3'; 'numpad4'; 'numpad5'; 'numpad6'; 'numpad7'; 'numpad8'; 'numpad9'; 'numpad*'; 'numpad+'; 'numpadenter'; 'numpad-'; 'numpad.'; 'numpad/'; ...
    ':'; '+'; '<'; '-'; '>'; '?'; '~'; '{'; '|'; '}'; '"'; ...
    ')'; '!'; '@'; '#'; '$'; '%'; '^'; '&'; '*'; '('; ...
    'A'; 'B'; 'C'; 'D'; 'E'; 'F'; 'G'; 'H'; 'I'; 'J'; 'K'; 'L'; 'M'; 'N'; 'O'; 'P'; 'Q'; 'R'; 'S'; 'T'; 'U'; 'V'; 'W'; 'X'; 'Y'; 'Z' ...
    }, ... % KeyName
    [...
    8; 9; 13; (16 : 18)'; 20; 27; (32 : 40)'; (44 : 46)'; ... % No-display (e.g., backspace, tab, ...)
    (65 : 90)'; ... % a - z (lowercase)
    (48 : 57)'; ... % 0 - 1 (not numpad)
    (112 : 123)'; ... % F1 - F12
    (186 : 192)'; (219 : 222)'; ... % Unshifted keys (not digits)
    144; (96 : 111)'; ... % Numpad
    (186 : 192)'; (219 : 222)'; ... % Shifted keys (not digits)
    (48 : 57)'; ... % Shifted keys (digit)
    (65 : 90)' ... % A - Z (uppercase)
    ], ... % KeyCode
    [...
    zeros(96, 1); ... % 0: press the key only
    ones(21, 1); ... % 1: press Shift + key
    2 * ones(26, 1) ... % 2: press Caps + key
    ], ... % Input option
    'VariableName', {'KeyName', 'KeyCode', 'InputOption'}...
    );
mouseBehavior = struct(...
    'LEFTDOWN', 1, ...
    'LEFTUP', 2, ...
    'RIGHTDOWN', 3, ...
    'RIGHTUP', 4, ...
    'MIDDLEDOWN', 5, ...
    'MIDDLEUP', 6, ...
    'LEFTCLICK', 7, ...
    'RIGHTCLICK', 8, ...
    'MIDDLECLICK', 9, ...
    'LEFTDOUBLECLICK', 10 ...
    );