function varargout = part2Gui(varargin)
% PART2GUI MATLAB code for part2Gui.fig
%      PART2GUI, by itself, creates a new PART2GUI or raises the existing
%      singleton*.
%
%      H = PART2GUI returns the handle to a new PART2GUI or the handle to
%      the existing singleton*.
%
%      PART2GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PART2GUI.M with the given input arguments.
%
%      PART2GUI('Property','Value',...) creates a new PART2GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before part2Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to part2Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help part2Gui

% Last Modified by GUIDE v2.5 07-May-2015 23:09:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @part2Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @part2Gui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before part2Gui is made visible.
function part2Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to part2Gui (see VARARGIN)

% Choose default command line output for part2Gui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes part2Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.CC , 'ColumnEditable',true);
vecCol = 1:3;
vecRow = 1:2;
set(handles.CC , 'ColumnName',vecCol);
set(handles.CC , 'RowName',vecRow);
set(handles.outTable , 'ColumnName',vecRow);
set(handles.outTable , 'RowName',1);
vec2 = zeros(1,2);
z=zeros(2,3);
set(handles.CC , 'data',z);
set(handles.outTable , 'data',vec2);
set(handles.numberOE,'String',2)





% --- Outputs from this function are returned to the command line.
function varargout = part2Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in updateBtn.
function updateBtn_Callback(hObject, eventdata, handles)
% hObject    handle to updateBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in selectionMenu.
function selectionMenu_Callback(hObject, eventdata, handles)
% hObject    handle to selectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectionMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectionMenu


% --- Executes during object creation, after setting all properties.
function selectionMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in solveBtn.
function solveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to solveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.CC , 'Data');
k = str2num(get(handles.numberOE,'String'));
selecNum = get(handles.selectionMenu , 'Value');
check=find(isnan(data));
TF = isempty(check);
if(selecNum == 1 &&TF)
   tic
   res = gaussElimination(data(:,1:k) , data(:,k+1:k+1))';
   set(handles.outTable,'Data',res); 
   time=toc;
   set (handles.timer , 'string' , time);
elseif(selecNum == 2&&TF)
   tic;
   res = gaussJordanElimination(data(:,1:k) , data(:,k+1:k+1))';
   set(handles.outTable,'Data',res);
   time=toc;
   set (handles.timer , 'string' , time);
elseif(selecNum == 3&&TF)
    tic;
   res = Solve_LU(data(:,1:k) , data(:,k+1:k+1))';
   set(handles.outTable,'Data',res);
   time=toc;
   set (handles.timer , 'string' , time);
elseif(~TF)
    warndlg('matrix contain NAN values','Error');
else
    set (handles.timer , 'string' , '0');
    warndlg('you did not chose file or file has illegal input','Error');
end


function numberOE_Callback(hObject, eventdata, handles)
% hObject    handle to numberOE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOE as text
%        str2double(get(hObject,'String')) returns contents of numberOE as a double
k = str2num(get(handles.numberOE,'String'));
vecCol = 1:k+1;
vecRow = 1:k;
set(handles.CC , 'ColumnName',vecCol);
set(handles.CC , 'RowName',vecRow);
vecData = zeros(k,k+1);
set(handles.CC , 'data',vecData);
set(handles.outTable , 'ColumnName',vecRow);
set(handles.outTable , 'RowName',1);
vec2 = zeros(1,k);
set(handles.outTable , 'data',vec2);




% --- Executes during object creation, after setting all properties.
function numberOE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadingbutton.
function loadingbutton_Callback(hObject, eventdata, handles)
try
        [FileName,PathName] = uigetfile('*.txt','Select the File');
        data=dlmread(strcat(PathName,FileName));
        [m,n] = size(data);
    if(n~=(m+1))
        warndlg('Wrong Number Of equation','Error');
    else
        [m,n] = size(data);
        vecCol = 1:m+1;
        vecRow = 1:m;
        set(handles.CC , 'ColumnName',vecCol);
        set(handles.CC , 'RowName',vecRow);
        set(handles.CC , 'data',data);
        set(handles.outTable , 'ColumnName',vecRow);
        set(handles.outTable , 'RowName',1);
        vec2 = zeros(1,m);
        set(handles.outTable , 'data',vec2);
        set(handles.numberOE,'String',m)
    end 
catch
end
% hObject    handle to loadingbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function timer_Callback(hObject, eventdata, handles)
% hObject    handle to timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timer as text
%        str2double(get(hObject,'String')) returns contents of timer as a double


% --- Executes during object creation, after setting all properties.
function timer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
%main();
delete(hObject);
