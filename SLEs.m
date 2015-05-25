function varargout = SLEs(varargin)
% SLES MATLAB code for SLEs.fig
%      SLES, by itself, creates a new SLES or raises the existing
%      singleton*.
%
%      H = SLES returns the handle to a new SLES or the handle to
%      the existing singleton*.
%
%      SLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLES.M with the given input arguments.
%
%      SLES('Property','Value',...) creates a new SLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SLEs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SLEs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SLEs

% Last Modified by GUIDE v2.5 09-May-2015 18:50:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SLEs_OpeningFcn, ...
                   'gui_OutputFcn',  @SLEs_OutputFcn, ...
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


% --- Executes just before SLEs is made visible.
function SLEs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SLEs (see VARARGIN)

% Choose default command line output for SLEs
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes SLEs wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.Equations , 'ColumnEditable',true);
vecCol = 0;
vecRow = 0;
set(handles.Equations , 'ColumnName',vecCol);
set(handles.Equations , 'RowName',vecRow);
set(handles.Solutions , 'ColumnName',vecRow);
set(handles.Solutions , 'RowName',1);
vec2 = zeros(1);
z=zeros(1);
set(handles.Equations , 'data',z);
set(handles.Solutions , 'data',vec2);
set(handles.No_E,'String','_')





% --- Outputs from this function are returned to the command line.
function varargout = SLEs_OutputFcn(hObject, eventdata, handles) 
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
clc;
Ab = get(handles.Equations , 'Data');
k = str2num(get(handles.No_E,'String'));
disp(Ab);
disp('No of Equations given : ');disp(k);
selecNum = get(handles.selectionMenu , 'Value');
check = find(isnan(Ab));
TF = isempty(check);
if(selecNum == 1 &&TF)
    clc;
   tic;
   x = Solve_Naive_Gauss(Ab(:,1:k) , Ab(:,k+1:k+1))';
   set(handles.Solutions,'Data',x); 
   time = toc;
   set (handles.Elapsed_Time , 'string' , time);
elseif(selecNum == 2&&TF)
   tic;
   A = Ab(:,1:k);
   b = Ab(:,k+1:k+1);
   Aug = [ A , b ];
   x = Solve_Gauss_jordan(Aug);
   set(handles.Solutions,'Data',x);
   time=toc;
   set (handles.Elapsed_Time , 'string' , time);
elseif(selecNum == 3&&TF)
    tic;
   x = Solve_LU(Ab(:,1:k) , Ab(:,k+1:k+1))';
   set(handles.Solutions,'Data',x);
   time = toc;
   set (handles.Elapsed_Time , 'string' , time);
elseif(~TF)
    warndlg('matrix contain NAN values','Error');
else
    set (handles.Elapsed_Time , 'string' , '0');
    warndlg('you did not chose file or file has illegal input','Error');
end


function No_E_Callback(hObject, eventdata, handles)
% hObject    handle to No_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of No_E as text
%        str2double(get(hObject,'String')) returns contents of No_E as a double
k = str2num(get(handles.No_E,'String'));
vecCol = 1:k+1;
vecRow = 1:k;
set(handles.Equations , 'ColumnName',vecCol);
set(handles.Equations , 'RowName',vecRow);
vecData = zeros(k,k+1);
set(handles.Equations , 'data',vecData);
set(handles.Solutions , 'ColumnName',vecRow);
set(handles.Solutions , 'RowName',1);
vec2 = zeros(1,k);
set(handles.Solutions , 'data',vec2);




% --- Executes during object creation, after setting all properties.
function No_E_CreateFcn(hObject, eventdata, handles)
% hObject    handle to No_E (see GCBO)
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
        set(handles.Equations , 'ColumnName',vecCol);
        set(handles.Equations , 'RowName',vecRow);
        set(handles.Equations , 'data',data);
        set(handles.Solutions , 'ColumnName',vecRow);
        set(handles.Solutions , 'RowName',1);
        vec2 = zeros(1,m);
        set(handles.Solutions , 'data',vec2);
        set(handles.No_E,'String',m)
    end 
catch
end
% hObject    handle to loadingbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Elapsed_Time_Callback(hObject, eventdata, handles)
% hObject    handle to Elapsed_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Elapsed_Time as text
%        str2double(get(hObject,'String')) returns contents of Elapsed_Time as a double


% --- Executes during object creation, after setting all properties.
function Elapsed_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Elapsed_Time (see GCBO)
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


% --- Executes when entered data in editable cell(s) in Equations.
function Equations_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Equations (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
