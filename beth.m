% ****** WELCOME TO MY CME1026 ASSIGNMENT! *******
%This GUI was produced to show different data sets, with a range of tools
%--------------------------------------------------------------------------
%INITIALISATION CODE
%--------------------------------------------------------------------------
%This code intialises the GUI. !!!! IT MUST NOT BE EDITED!!!
function varargout = beth(varargin)
% This is the MATLAB GUI initialisation - DO NOT EDIT!!%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beth_OpeningFcn, ...
                   'gui_OutputFcn',  @beth_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code 

%--------------------------------------------------------------------------
%OPENING FUNCTION
%--------------------------------------------------------------------------
%This code executes just before the GUI is made visible.
%It contains data sets
function beth_OpeningFcn(hObject, ~, handles, varargin)
%This is the data used in the plots
handles.T =[273.15 283.15 293.15 303.15 313.15 323.15 333.15 343.15 353.15 363.15 373.15]; %Temperature/K
handles.H = [1.92 1.75 1.62 1.52 1.46 1.44 1.43 1.43 1.43 1.43 1.43]; %Hydrogen Solubility/mg/kgH20
handles.O = [69.93 54.34 44.33 37.32 33.03 29.89 27.89 26.17 25.17 24.60 24.60]; %Oxygen Solubility/mg/kgH20
handles.N = [29.14 23.06 19.22 16.62 14.63 13.52 12.65 12.15 11.90 11.78 11.78]; %Nitrogen Solubility/mg/kgH20
%End data
%This inputs how the GUI looks when it opens - the edit text boxes are
%disabled and the axis has no data.
handles.xlab=xlabel('Temperature (K)');                          %Sets the X axis label
handles.ylab=ylabel('Solubility (mg/kgH_2O)');                   %Sets the Y axis label
set(handles.findtempedit,'enable','off')            %Disables the edit text box for find temp
set(handles.findsoledit,'enable','off')             %Disables the edit text box for find sol
% This is the default command output
handles.output = hObject;
%This updates the handles structure
guidata(hObject, handles);
%This makes the first dialog box pop up, to tell the user to input data.
uiwait(helpdlg('Welcome to the UI! Please click "OK". When you have clicked "OK", the UI will start. Please then select the data set before continuing','UI Startup'));
 %End opening function

%--------------------------------------------------------------------------
%COMMAND LINE FUNCTION
%--------------------------------------------------------------------------
%This function can be used to return objects to the command window.
function varargout = beth_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
%End command line function

%--------------------------------------------------------------------------
%SELECT GAS DROPDOWN MENU
%--------------------------------------------------------------------------
%These two functions create and callback the select gas function
%The first  function is the callback, which tells the GUI what to do when
%an option is selected
function selectgas_Callback(hObject, eventdata, handles)
selectedgas = get(handles.selectgas,'Value'); %gets the value selected by the user
cla;                                          %clears the axis 
switch selectedgas                           %switches what the handles.currentdata is
    case 1                                    
        handles.currentdata = 0;
    case 2
        handles.currentdata = handles.O;
    case 3 
        handles.currentdata = handles.H;
    case 4
        handles.currentdata = handles.N;
end
if get(handles.selectgas,'Value')==1       %If the 'Select Data' option is selected, an error message comes up
    warndlg('Please select a data set.','ERROR');
else                                          %Otherwise, the colourbuttons function runs
   colourbuttons(hObject, eventdata, handles)
end
set(handles.findtempedit,'enable','off','String','Enter Solubility') %this resets the checkboxes for finding
set(handles.findsoledit,'enable','off','String','Enter Temperature') %temperature and solubilty
set(handles.findtempCheck,'Value',0)
set(handles.findsolCheck,'Value',0)
gridType(hObject,eventdata,handles)
handles.output=hObject;   %This passes handles out of the function
guidata(hObject,handles);



%This runs during object creation
function selectgas_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%End Select Gas Dropdown Menu Code

%--------------------------------------------------------------------------
%LINE COLOUR FUNCTION
%--------------------------------------------------------------------------
%The following code is for the line colour. Two codes were required, as
%putting the code to reset the checkboxes in the code meant that it broke
%the script, as it loops around. The two codes were used as compromise.
function colourbuttons(hObject,eventdata,handles)
cla
if handles.buttonPink.Value==1
   plot(handles.T,handles.currentdata,'-om');
elseif handles.buttonBlue.Value==1
   plot(handles.T,handles.currentdata,'-ob');
elseif handles.buttonBlack.Value==1
   plot(handles.T,handles.currentdata,'-ok');
end 
handles.xlab=xlabel('Temperature (K)')%The labels have to be set again
handles.ylab=ylabel('Solubility (mg/kgH_20)');
gridType(hObject,eventdata,handles)
changeline(hObject, eventdata, handles)


%The following three codes are just codes for the different colour buttons
function buttonPink_Callback(hObject, eventdata, handles)
colourbuttons(hObject,eventdata,handles)

% --- Executes on button press in buttonBlue.
function buttonBlue_Callback(hObject, eventdata, handles)
colourbuttons(hObject,eventdata,handles)

% --- Executes on button press in buttonBlack.
function buttonBlack_Callback(hObject, eventdata, handles)
colourbuttons(hObject,eventdata,handles)
%End Line Colour code


%--------------------------------------------------------------------------
%FIND TEMPERATURE EDIT BOX
%--------------------------------------------------------------------------
function findtempedit_Callback(hObject, eventdata, handles)
cla;                                             %Clears the data
colourbuttons(hObject,eventdata,handles);       %Runs olourbuttons function
b=str2double(get(hObject,'String'));            %Returns the string entered  to a value to be used 
if b<min(handles.currentdata)                   %Sends an error message if the number is too high or low
   warndlg('The solubility you have chosen is too low, please choose a higher solubility','!!! ERROR!!!')
   set(handles.findtempedit,'String','') 
elseif b>max(handles.currentdata)
   warndlg('The solubility you have chosen is too high, please choose a lower solubility','!!! ERROR!!!')
    set(handles.findtempedit,'String','')
else                                            %i.e. if the value is in the right range
    b=str2double(get(hObject,'String')); 
end 
a=gca;                                           %Gets the current axis
x=[a.XLim(1) a.XLim(2)];                         %Sets the X and Y values
y=[b b];
handles.lineT=line(x,y,'Color','k');             %Plots the line



%This runs during object creation
function findtempedit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%End Find Temperature Edit Button Code


%--------------------------------------------------------------------------
%FIND SOLUBILITY EDIT BOX
%--------------------------------------------------------------------------
%This section of code is essentially the same as the 'find temperature edit
%button' code. For any queries, see that section.
function findsoledit_Callback(hObject, eventdata, handles)
cla
colourbuttons(hObject,eventdata,handles)
c=str2double(get(hObject,'String'));
if c<min(handles.T)
    warndlg('The temperature you have chosen is too low, please choose a higher temperature','!!! ERROR!!!')
    set(handles.findsoledit,'String','')
elseif c>max(handles.T)
    warndlg('The temperature you have chosen is too high, please choose a lower temperature','!!! ERROR!!!')
    set(handles.findsoledit,'String','')
else
    c=str2double(get(hObject,'String'));
end
d=gca;
y=[d.YLim(1) d.YLim(2)];
x=[c c];
handles.lineS=line(x,y,'Color','k');


% Runs during object creation
function findsoledit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%End Find Solubility Edit Button Code 

%--------------------------------------------------------------------------
%FIND SOLUBILITY/TEMPERATURE CHECKBOXES
%--------------------------------------------------------------------------
% The following lines of code control when the user is able to input data
% into the 'Enter Solubility' and 'Enter Temperature' checkboxes, and also
% controls the clear button
%The following two functions link to the third function, which controls the
%checkboxes.

%Runs when the Find Temperature? checkbox is clicked
function findtempCheck_Callback(hObject, eventdata, handles)
editboxes(hObject,eventdata,handles); 

% Runs when the Find Solubility? checkboxed is clicked
function findsolCheck_Callback(hObject, eventdata, handles)
editboxes(hObject,eventdata,handles)

%This function is a custom function, used so the two checkboxes can be used
%in sync. 
function editboxes(hObject,eventdata,handles)
if get(handles.findtempCheck,'Value')==1 && get(handles.findsolCheck,'Value')==1
    warndlg('Too many options selected. Please only select temperature or solubility','!!!WARNING!!!')
    set(handles.findtempedit,'enable','off','String','Enter Solubility') %If both checkboxes are ticked, a warning dialog is started
    set(handles.findsoledit,'enable','off','String','Enter Temperature')
    set(handles.findtempCheck,'Value',0)
    set(handles.findsolCheck,'Value',0)
elseif get(handles.findtempCheck,'Value')==1 && get(handles.findsolCheck,'Value')==0
    set(handles.findtempedit,'enable','on' ,'String','') %These next two 'elseif' functions make is so the corresponding
    set(handles.findsoledit,'enable','off','String','Enter Temperature') %edit box becomes available if the checkbox is ticke
elseif get(handles.findtempCheck,'Value')==0 && get(handles.findsolCheck,'Value')==1
    set(handles.findtempedit,'enable','off','String','Enter Solubility')
    set(handles.findsoledit,'enable','on','String','')
elseif get(handles.findtempCheck,'Value')==0 && get(handles.findsolCheck,'Value')==0
    set(handles.findsoledit,'enable','off','String','Enter Temperature') %Neither checkboxes are ticked and so neither edit box
    set(handles.findtempedit,'enable','off','String','Enter Solubility') %becomes available.
    cla
    colourbuttons(hObject,eventdata,handles)
end 

%This is the clear box for the find temp/sol panel.
function buttonClear_Callback(hObject, eventdata, handles)
%The line of code below warns the user that the button clears inputted
%numbers and the line.
uiwait(warndlg('Pressing this button clears the inputted numbers and the line from the graph','!!! WARNING!!!!'));
set(handles.findtempedit,'enable','off','String','Enter Solubility') %If both checkboxes are ticked, a warning dialog is started
set(handles.findsoledit,'enable','off','String','Enter Temperature')
set(handles.findtempCheck,'Value',0)
set(handles.findsolCheck,'Value',0)
colourbuttons(hObject,eventdata,handles)
%Edit Solubility/Temperature Checkboxes code

%--------------------------------------------------------------------------
%ZOOM FUNCTION
%--------------------------------------------------------------------------
%Runs when the zoom in button is pressed 
function zoomin_Callback(hObject, eventdata, handles)
zoom(1.2);

%Runs when the zoom out button is pressed 
function zoomout_Callback(hObject, eventdata, handles)
zoom(0.8);
%End Zoom Function Code

%--------------------------------------------------------------------------
%PAN FUNCTION
%--------------------------------------------------------------------------
%Runs when left pan button is pressed
function panleft_Callback(hObject, eventdata, handles)
left = xlim;
xlim(left-0.5); %Moves the xlimit by -0.5

%Runs when right pan button is pressed 
function panright_Callback(hObject, eventdata, handles)
right = xlim;
xlim(right+0.5); %Moves the xlimit by +0.5

%Runs when down pan button is pressed 
function pandown_Callback(hObject, eventdata, handles)
down = ylim;
ylim(down-0.2);  %Moves the y limit down by 0.2


%Runs when up pan button is pressed
function panup_Callback(hObject, eventdata, handles)
up = ylim;
ylim(up+0.2); %Moves the y limit down by 0.2
%End Pan Function Code

%--------------------------------------------------------------------------
%DATA CURSOR FUNCTION
%--------------------------------------------------------------------------
%Executes when data cursor checkbox is ticket
function checkDatacursor_Callback(hObject, eventdata, handles)
if handles.checkDatacursor.Value==0
    datacursormode off          %Turns data cursor off when unticked
elseif handles.checkDatacursor.Value==1
    datacursormode on           %Turns data cursor on when ticked
end 
%End Cursor Function Code

%--------------------------------------------------------------------------
%GRID FUNCTION
%--------------------------------------------------------------------------
% The following two functions just run the third function. This is to
% ensure that the grids can work together, as there is only one 'grid off'
% function that turns off both grids.
% --- Executes on button press in checkGrid.
function checkGrid_Callback(hObject, eventdata, handles)
%When the Major grid button is checked, the UI runs the gridType function
gridType(hObject,eventdata,handles) 

% --- Executes on button press in checkMinor.
%When the Minor grid button is checked, the UI runs the gridType function
function checkMinor_Callback(hObject, eventdata, handles)
gridType(hObject,eventdata,handles)

%Controls the grid functions. 
function gridType(hObject,eventdata,handles)
    if get(handles.checkMinor,'Value')==1 && get(handles.checkGrid,'Value')==1
        grid off  %If both grids are checked, both grids are activated 
        grid on
        grid minor
    elseif get(handles.checkMinor,'Value')==1 && get(handles.checkGrid,'Value')==0
        grid off   %If the minor grid is checked, the minor grid is activated.
        grid minor
    elseif get(handles.checkMinor,'Value')==0 && get(handles.checkGrid,'Value')==1
        grid off  %If the major grid is checked, the major grid is activated.
        grid on 
    else 
        grid off  %At all other times,the grids are off.
    end 
%End Grid Function Code
           
%--------------------------------------------------------------------------
%RESET BUTTON
%--------------------------------------------------------------------------
%This code is for the 'Reset' button. It manually resets all values back to
%their original.
function buttonReset_Callback(hObject, eventdata, handles)
uiwait(warndlg('Pressing this button clears the entire GUI','!!! WARNING !!!')); %Warning dialog
set(handles.findtempedit, 'String', 'Enter Solubility'); %Changes the edit boxes text
set(handles.findsoledit,'String','Enter Temperature');
set(handles.selectgas,'Value',1) %Makes the dropdown list go back to 'SELECT GAS'
cla %clears the axis
set(handles.findsoledit,'enable','off') %Disables the edit boxes
set(handles.findtempedit,'enable','off')
set(handles.findtempCheck,'Value',0) %Unchecks all tickboxes
set(handles.findsolCheck,'Value',0)
set(handles.checkMinor,'Value',0)
set(handles.checkGrid,'Value',0)
set(handles.checkDatacursor,'Value',0)
set(handles.buttonPink,'Value',1)
grid off %turns the grids off
datacursormode off %turns the data cursor off
%--------------------------------------------------------------------------
%BACKGROUND COLOUR FUNCTION
%--------------------------------------------------------------------------
%The following set of functions control the background colour of the GUI
% --- Executes on slider movement.
function redslider_Callback(hObject, eventdata, handles)
changecolour(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function redslider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on green slider movement.
function greenslider_Callback(hObject, eventdata, handles)
changecolour(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function greenslider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on blue slider movement.
function blueslider_Callback(hObject, eventdata, handles)
changecolour(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function blueslider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%This is the function that changes the background colour 
function changecolour(hObject, eventdata, handles)
r=get(handles.redslider,'Value');
g=get(handles.greenslider,'Value');
b=get(handles.blueslider,'Value');
set(handles.background, 'Color',[r g b]);
set(handles.titlestring,'BackgroundColor', [r g b]);
gridType(hObject,eventdata,handles);
%--------------------------------------------------------------------------
%Text Colour Function
%--------------------------------------------------------------------------
%The following two functions execute when the white or black buttons are
%pressed
function whiteButton_Callback(hObject, eventdata, handles)
changeline(hObject, eventdata, handles);

function blackButton_Callback(hObject, eventdata, handles)
changeline(hObject, eventdata, handles);

%This is the function that changes the text colour
function changeline(hObject, eventdata, handles)
gridType(hObject,eventdata,handles);
if handles.whiteButton.Value==1
    set(handles.axes1, 'XColor',[1 1 1], 'YColor', [1 1 1]);
    set(handles.axes1, 'GridColor', [0 0 0],'MinorGridColor', [0 0 0]);
    set(handles.titlestring, 'ForegroundColor', [1 1 1]);
    
elseif handles.blackButton.Value==1
     set(handles.axes1, 'XColor',[0 0 0], 'YColor', [0 0 0]);
     set(handles.titlestring, 'ForegroundColor', [0 0 0]) ;
end 

%--------------------------------------------------------------------------
%DEBUG FUNCTION
%--------------------------------------------------------------------------
% --- Executes on button press in debugButton.
function debugButton_Callback(hObject, eventdata, handles)
uiwait(helpdlg('Pressing this button brings up the command window. If you type in a handle, for example, handles.axes1, you will be able to see  all properties attached to this handle.','Enter Debug Mode'));
keyboard;
