Loop,	Read,	words.dic
   total_lines = %A_Index%
Random,	bolacha, 1,	%total_lines%
FileReadLine,	string,	words.dic,	%bolacha%
tamanho	:=	StrLen(string)
erros = 0
Loop,	%	tamanho
	if(A_Index=1)
		Gui,	Add,	Text,	x10	y10		w20	h30		vesc%A_Index%		Center		,	___
	else
		Gui,	Add,	Text,	xp+25	yp		w20	h30		vesc%A_Index%	Center		,	___
	size	:=	tamanho*25
Gui, Add, Picture,	x2	y40		w290	h300	vhangman	gtry							, %A_ScriptDir%\0.png
Gui,	Add,	Text,	x2	y340	w300	h40		vchutadas					Center
Gui,	Add,	Edit,	x2	y380	w300	h30		vchute		gtenta		Center
Gui,	Show
return
try:
if(gameover=1)	{
	Run,	https://www.google.com/search?q=%string%&rlz=1C1GCEU_pt-BRBR869BR869&oq=%string%&aqs=chrome.0.69i59.8543j0j7&sourceid=chrome&ie=UTF-8
	Reload
}
return
tenta:	;{
Gui,	Submit,	NoHide
if(instr(chutadas,chute)>0 or instr(acertou,chute)>0)	{
	MsgBox,,,	Letra já foi usada!, 1
	GuiControl,	,	chute
	GuiControl,	Focus,	chute
	return
}
if(instr(string,chute)>0)	{
	GuiControl,	,	chute
	GuiControl,	Focus,	chute
	posicao	:=	instr(string,chute)
	StringUpper,	chute,	chute,	T
	oculta[posicao]	:=	chute
	StringReplace,	tem,	string,	%chute%,	,	UseErrorLevel
	Loop,	%	ErrorLevel
	{
		acertos++
		posicao%A_Index%	:=	InStr(string,chute, ,1, A_Index)
		Esc	:=	posicao%A_Index%
		GuiControl,	,	esc%esc%,		%	chute
	}
	acertou	.=	chute
	if(acertos=tamanho)	{
		GuiControl,	,	hangman,	%A_ScriptDir%\%erros%w.png
		gameover = 1
	}
}
else
{
	erros++
	GuiControl,	,	hangman,	%A_ScriptDir%\%erros%.png
	GuiControl,	,	chute
	GuiControl,	Focus,	chute
	if(erros=10)	{
		GuiControl,	,	hangman,	%A_ScriptDir%\lose.png
		gameover = 1
	}
	if(erros=1)
		chutadas	:=	chutadas
	if(erros=5)
		chutadas	:=	chutadas	"`t"	chute "`n"
	else
		chutadas	:=	chutadas	"`t"	chute
	StringUpper,	chutadas,	chutadas, T
	GuiControl,	,	chutadas,	%	chutadas
}
return	;}

GuiClose:
ExitApp