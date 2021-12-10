classdef Macro < handle
    % Macro - Provides convenient simulations of keyboard / mouse behaviors.
    %     m = Macro creates a Macro class, that allows for the basic simulation of:
    %          - Key presses
    %          - Mouse moves
    %          - Mouse clicks
    %
    %     Aside from that, higher-level functions are also available, such as:
    %          - Simulating the use of shortcuts
    %          - Simulating the input of entire lines
    %
    %     A few PsychToolbox styled methods are also supported, such as:
    %          - GetMouse
    %          - KbCheck
    %
    %     Note:
    %     -----
    %     PsychToolbox-related methods will only function if PsychToolbox is installed
    %     Otherwise, calling these methods will do absolutely nothing
    %
    %     It is possible to enable or disable the Macro class with only one line of code:
    %         m = Macro; % Enabled by default
    %         m.enabled = 0; % Now disabled
    %
    
    properties (Access = private)
        enabled % Logical: the Macro class is enabled if this value is TRUE
        keyboardBehavior % Struct: define the keyboard behavior
        keys % Table: containing key names, key codes, and input options
        mouseBehavior % Struct: define the mouse behavior
        resolutionX % Double: original width of the screen
        systemHasPsychtoolbox % Logical: this value being TRUE indicates that PsychToolbox is installed
    end
    
    methods
        function this = Macro(varargin)
            this.enabled = true;
            
            [this.keyboardBehavior, this.keys, this.mouseBehavior] = lib.initializeConstants;
            
            this.resolutionX = java.awt.Toolkit.getDefaultToolkit.getScreenSize.width;
            
            this.systemHasPsychtoolbox = (exist('PsychtoolboxVersion', 'file') == 2);
        end
        
        function enable(this)
            % Enable the Macro Class
            this.enabled = true;
        end
        
        function disable(this)
            % Disable the Macro Class
            this.enabled = false;
        end
        
        function t = getKeyNames(this)
            % Print all available key names
            t = table(this.keys.KeyName, 'VariableName', {'KeyName'});
        end
        
        function keyboard(this, varargin)
            % Input from keyboard; receives 1 or 2 argument(s)
            % Key - Char: name of the key; case sensitive
            % Behavior - Char / Optional:
            %     - Case insensitive
            %     - 'PRESS' by default
            %     - 'DOWN' / 'UP' / 'PRESS'
            % Examples:
            %     m = Macro;
            %     m.keyboard('a');
            %     m.keyboard('a', 'PRESS');
            if this.enabled
                narginchk(2, 3);
                
                key = varargin{1};
                if length(key) > 1
                    key = lower(key);
                end
                if nargin == 2
                    behavior = 'PRESS';
                else
                    behavior = upper(varargin{2});
                end
                
                % Handle input errors
                if ~ischar(key)
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid key name! Key name must be a char, not a %s.', class(key)));
                elseif size(key, 1) ~= 1
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid key name! Key name must not be an array.'));
                end
                if ~ischar(behavior)
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid keyboard behavior! Keyboard behavior must be a char, not a %s or an array of char.', class(key)));
                elseif size(behavior, 1) ~= 1
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid key name! Key name must not be an array.'));
                end
                if ~any(cellfun(@(x) isequal(behavior, x), {'PRESS', 'UP', 'DOWN'}))
                    throw(MException('InvalidInput:NonExistentKeyboardBehavior', 'Invalid keybord behavior! Choose from ''PRESS'', ''DOWN'' and ''UP''.'));
                end
                
                [code, option] = this.findKey(key);
                switch option
                    case 0
                        lib.Keyboard(code, this.keyboardBehavior.(behavior));
                    case 1
                        lib.Keyboard(16, 1); % HOLD Shift
                        lib.Keyboard(code, this.keyboardBehavior.(behavior));
                        lib.Keyboard(16, 2); % LIFT Shift
                    case 2
                        lib.Keyboard(20, 3); % PRESS Capslock
                        lib.Keyboard(code, this.keyboardBehavior.(behavior));
                        lib.Keyboard(20, 3); % PRESS Capslock again to cancel it
                end
            end
        end
        
        function button(this, varargin)
            % Mouse click; receives 0 or 1 argument
            % Behavior - Char / Optional:
            %     - Case insensitive
            %     - 'LEFTCLICK' by default
            %     - 'LEFTDOWN' / 'LEFTUP' / 'RIGHTDOWN' / 'RIGHTUP' / 'MIDDLEDOWN' / 'MIDDLEUP' / 'LEFTCLICK' / 'RIGHTCLICK' / 'MIDDLECLICK' / 'LEFTDOUBLECLICK'
            % Examples:
            %     m = Macro;
            %     m.button;
            %     m.button('a', 'LEFTCLICK');
            if this.enabled
                narginchk(1, 2);
                if nargin == 1
                    behavior = 'LEFTCLICK';
                else
                    behavior = upper(varargin{1});
                end
                
                % Handle input errors
                if ~ischar(behavior)
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid keyboard behavior! Keyboard behavior must be a char, not a %s or an array of char.', class(key)));
                elseif size(behavior, 1) ~= 1
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid key name! Key name must not be an array.'));
                end
                if ~any(cellfun(@(x) isequal(behavior, x), {'LEFTDOWN', 'LEFTUP', 'RIGHTDOWN', 'RIGHTUP', 'MIDDLEDOWN', 'MIDDLEUP', 'LEFTCLICK', 'RIGHTCLICK', 'MIDDLECLICK', 'LEFTDOUBLECLICK'}))
                    throw(MException('InvalidInput:NonExistentKeyboardBehavior', 'Invalid keybord behavior! Choose from ''LEFTDOWN'', ''LEFTUP'', ''RIGHTDOWN'', ''RIGHTUP'', ''MIDDLEDOWN'', ''MIDDLEUP'', ''LEFTCLICK'', ''RIGHTCLICK'', ''MIDDLECLICK'' and ''LEFTDOUBLECLICK''.'));
                end
                
                lib.MouseClick(this.mouseBehavior.(behavior));
            end
        end
        
        function mouseMoveTo(this, x, y)
            % The cursor jumps to the target position; receives 2 arguments
            % x - Numeric: distance from the left of the screen
            % y - Numeric: distance from the top of the screen
            % Examples:
            %     m = Macro;
            %     m.mouseMoveTo(960, 540);
            if this.enabled
                % Handle input errors
                if ~isnumeric(x) || ~isequal(size(x), [1 1])
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid coordinate! X must be a single numeric.'));
                end
                if ~isnumeric(y) || ~isequal(size(y), [1 1])
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid coordinate! Y must be a single numeric.'));
                end
                lib.MouseMove(x, y);
            end
        end
        
        function shortcut(this, combination)
            % Simulate shortcuts like Ctrl + c; receives one argument
            % combination - Cell of Char: the combination of keys
            % Examples:
            %     m = Macro;
            %     m.shortcut({'ctrl', 'a'});
            if this.enabled
                % Handle input errors
                if ~iscell(combination)
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid combination! Combination must be a cell, not a %s.', class(combination)));
                elseif min(size(combination)) ~= 1
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid combination! Combination must be either an 1 * n or an n * 1 cell.'));
                end
                
                for ii = 1 : length(combination)
                    this.keyboard(combination{ii}, 'DOWN');
                end
                
                for ii = length(combination) : -1 : 1
                    this.keyboard(combination{ii}, 'UP');
                end
            end
        end
        
        function type(this, varargin)
            % Input an entire line
            % text - char: the line of text awaiting input
            % pauseTime - double:
            %     - Time to pause between the input of two characters
            %     - In seconds
            %     - Default value being 0.01
            % Examples:
            %     m = Macro;
            %     m.type('Hello world');
            if this.enabled
                narginchk(2, 3);
                
                text = varargin{1};
                
                if nargin == 2
                    pauseTime = 0.01;
                else
                    pauseTime = varargin{2};
                end
                
                % Handle input errors
                if ~ischar(text)
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid key name! Text must be a char, not a %s.', class(text)));
                elseif size(text, 1) ~= 1
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid key name! Text must not be an array.'));
                end
                if ~isnumeric(pauseTime) || ~isequal(size(pauseTime), [1 1]) || pauseTime <= 0
                    throw(MException('InvalidInput:ArgumentTypeError', 'Invalid coordinate! PauseTime must be a single positive numeric.'));
                end
                
                for ii = 1 : length(text)
                    this.keyboard(text(ii), 'PRESS');
                    pause(pauseTime);
                end
            end
        end
        
        function [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(this, key)
            % A copy of the PsychToolbox KbCheck function
            % Key down -> KbCheck -> Key up
            % key: same as that in Macro.keyboard
            if this.systemHasPsychtoolbox
                if this.enabled
                    this.keyboard(key, 'DOWN');
                    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
                    this.keyboard(key, 'UP');
                else
                    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck;
                end
            end
        end
        
        function [x, y, buttons, focus, valuators, valinfo] = GetMouse(this, button, posX, posY)
            % A copy of the PsychToolbox GetMouse function
            % Left button down -> KbCheck -> Right button up
            % button: the button to press, including 'LEFT', 'MIDDLE' and 'RIGHT'; case insensitive
            % x / y: same as those in Macro.mouseMoveTo
            if this.systemHasPsychtoolbox
                if this.enabled == 1
                    this.mouseMoveTo(posX, posY);
                    this.button([button 'DOWN']);
                    [x, y, buttons, focus, valuators, valinfo] = GetMouse;
                    this.Click([button 'UP']);
                else
                    [x, y, buttons, focus, valuators, valinfo] = GetMouse;
                end
            end
        end
    end
    
    methods (Static)
        function [x, y] = getCursorPos()
            % Get the current position of the cursor
            coord = lib.GetCursorPos;
            x = coord(1);
            y = coord(2);
        end
    end
    
    methods (Access = private)
        function [code, option] = findKey(this, key)
            % Find key code and input option according to the key name
            row = find(cellfun(@(x) isequal(x, key), this.keys.KeyName));
            if ~isempty(row)
                code = this.keys.KeyCode(row);
                option = this.keys.InputOption(row);
            else
                code = -1;
                option = -1;
                error('Invalid key name: %s', key);
            end
        end
    end
end