% This document class provides a simple memo for LaTeX users.
% It is based on article.cls and inherits most of the functionality
% that class.
% 
% Author: Rob Oakes, Copyright 2010.  Released under the LGPL, version 3.
% A copy of the LGPL can be found at http://www.gnu.org/licenses/lgpl.html
% Forked By Abhi-1U (Abhishek U.) for GSoC Reports generated fortnightly
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texMemo}[2010/07/31 - Simple Memo Class, Including Logo]

%
\ifx\e@alloc\@undefined
  \RequirePackage{etex}
\fi
\RequirePackage{tikz}
\usetikzlibrary{backgrounds}
\usepackage{color}
\usepackage{tikz}
\usetikzlibrary{shapes, backgrounds}
\usepackage{numprint,fullpage} 
\usepackage{pgfplotstable} 
\usetikzlibrary{arrows}
% use customized header
\usepackage{fancyhdr}				
\pagestyle{fancy}
%
%------------------------------
%\RequirePackage{palatino}
% Abhi-1U : Changes in the font
\RequirePackage{bookman}
%------------------------------
% Load the Base Class
\LoadClassWithOptions{article}

% Begin Requirements
\RequirePackage{ifthen}

% Specialized memo Commands (To, From, Subject, Logo, Letterhead Address)

\def\@memoto{\relax}
\newcommand{\memoto}[1]{\gdef\@memoto{#1}}

\def\@memofrom{\relax}
\newcommand{\memofrom}[1]{\gdef\@memofrom{#1}}

\def\@memosubject{\relax}
\newcommand{\memosubject}[1]{\gdef\@memosubject{#1}}

\def\@memodate{\relax}
\newcommand{\memodate}[1]{\gdef\@memodate{#1}}

\def\@memologo{\relax}
\newcommand{\logo}[1]{\gdef\@memologo{\protect #1}}

%------------------------------
% Abhi-1U : For Second Logo
\def\@memologotwo{\relax}
\newcommand{\logotwo}[1]{\gdef\@memologotwo{\protect #1}}

%------------------------------
\def\@letterheadaddress{\relax}
\newcommand{\lhaddress}[1]{\gdef\@letterheadaddress{#1}}

% Custom Document Formatting
\newcommand\decorativeline[1][1pt]{
	\par\noindent%
	\rule[0.5ex]{\linewidth}{#1}\par
}

% Set the Paper Size and margins
\RequirePackage{geometry}
\geometry{margin=1.0in}

% Create the Letterhead and To/From Block

%------------------------------
% Abhi-1U : Added second logo and rearranged its position
\renewcommand{\maketitle}{\makememotitle}
\newcommand\makememotitle{
	\ifthenelse{\equal{\@memologo}{\relax}}{}
	{ % Create With Logo
	\begin{minipage}[t]{1\columnwidth}%
		\begin{flushright}
		    \vspace{-0.7in}
		    \hspace{-0.25in}
		    \@memologotwo
			\hfill
			\@memologo
			\vspace{0.1in}
			\hspace{0.1in}
		\par\end{flushright}%
	\end{minipage}
	}
%------------------------------
	% To, From, Subject Block
	\begin{description}
		\ifthenelse{\equal{\@memoto}{\relax}}{}{\item [{To:}] \@memoto}
		\ifthenelse{\equal{\@memofrom}{\relax}}{}{\item [{From:}] \@memofrom}
		\ifthenelse{\equal{\@memosubject}{\relax}}{}{\item [{Subject:}] \@memosubject}
		\ifthenelse{\equal{\@memodate}{\relax}}{}{\item [{Date:}] \@memodate}
	\end{description}
	\decorativeline\bigskip{}
}

%------------------------------
% Abhi-1U : All additions from here onwards are not available in the original version of this template
\def\tkzutil@empty{} 
\newif\iftkz@kiv@table 
\pgfkeys{%
/kiviat/.cd,
space/.code            =  {\def\tkz@kiv@sp{#1}}, 
gap/.code              =  {\def\tkz@kiv@gap{#1}},
lattice/.code          =  {\def\tkz@kiv@lattice{#1}},
step/.code             =  {\def\tkz@kiv@step{#1}},
radial style/.style    =  {->,>=latex'},
lattice style/.style   =  {thin,lightgray},
label style/.style     =  {text width=2 cm,align=center},
label space/.code      =  {\def\tkz@kiv@space{#1}},  
/kiviat/.unknown/.code =  {\let\searchname=\pgfkeyscurrentname
                            \pgfkeysalso{\searchname/.try=#1,
                            /tikz/\searchname/.retry=#1}}  
                           } 
\def\tkzKiviatDiagram{\pgfutil@ifnextchar[{\tkz@KiviatDiagram}{%
                                            \tkz@KiviatDiagram[]}} 
\def\tkz@KiviatDiagram[#1]#2{% 

\pgfkeys{/kiviat/.cd,
gap          = .5,
lattice      = 10,
space        = .5,
step         = 1,
label space  = 1.5
}
\pgfqkeys{/kiviat}{#1}%
\begingroup
\foreach \x [count=\rang from 1] in {#2}{%
\global\let\tkz@kiv@radial\rang}% 
\foreach \x [count=\rang from 0] in {#2}{%
   \draw[/kiviat/radial style]
 (0,0)--(360/\tkz@kiv@radial*\rang:\tkz@kiv@lattice*\tkz@kiv@gap+\tkz@kiv@sp);
   \path
(0,0)--(360/\tkz@kiv@radial*\rang:\tkz@kiv@lattice*\tkz@kiv@gap+\tkz@kiv@space) node[/kiviat/label style] {\x}; 

\foreach \y in {0,1,...,\tkz@kiv@lattice}{
   \draw[/kiviat/lattice style]%
     (360/\tkz@kiv@radial*\rang:\y*\tkz@kiv@gap)--%
        (360/\tkz@kiv@radial*\rang+360/\tkz@kiv@radial:\y*\tkz@kiv@gap);
     }
}
\endgroup
}
%<--------------------------------------------------------------------------->
%<--------------------------------------------------------------------------->
\pgfkeys{/kiviatline/.cd,
fill/.code = {\global\def\tkz@kivl@fill{#1}},
opacity/.code = {\global\def\tkz@kivl@opacity{#1}}, 
/kiviatline/.unknown/.code ={\let\searchname=\pgfkeyscurrentname
                             \pgfkeysalso{\searchname/.try=#1,
                             /tikz/\searchname/.retry=#1}}   
}  
%<--------------------------------------------------------------------------->
\def\tkzKiviatLine{\pgfutil@ifnextchar[{\tkz@KiviatLine}{%
                                            \tkz@KiviatLine[]}} 
\def\tkz@KiviatLine[#1](#2,#3){% 
\begingroup
\pgfkeys{/kiviatline/.cd,
fill= {},
opacity=.5
}
\pgfqkeys{/kiviatline}{#1}%   opacity ??????
\ifx\tkzutil@empty\tkz@kivl@fill \else 
\begin{scope}[on background layer]
 \path[fill=\tkz@kivl@fill,opacity=\tkz@kivl@opacity] (360/\tkz@kiv@radial*0:#2*\tkz@kiv@gap*\tkz@kiv@step)   
\foreach \v [count=\rang from 1] in {#3}{%  
 -- (360/\tkz@kiv@radial*\rang:\v*\tkz@kiv@gap*\tkz@kiv@step) } -- (360/\tkz@kiv@radial*0:#2*\tkz@kiv@gap*\tkz@kiv@step); 
 \end{scope}
 \fi       
\draw[#1,opacity=1] (0:#2*\tkz@kiv@gap) plot coordinates {(360/\tkz@kiv@radial*0:#2*\tkz@kiv@gap*\tkz@kiv@step)}  
\foreach \v [count=\rang from 1] in {#3}{%  
 -- (360/\tkz@kiv@radial*\rang:\v*\tkz@kiv@gap*\tkz@kiv@step) plot coordinates {(360/\tkz@kiv@radial*\rang:\v*\tkz@kiv@gap*\tkz@kiv@step)}} -- (360/\tkz@kiv@radial*0:#2*\tkz@kiv@gap*\tkz@kiv@step);   
\endgroup
}%  
%<--------------------------------------------------------------------------->
%<--------------------------------------------------------------------------->
\pgfkeys{/kiviatgrad/.cd,
graduation distance/.code = \def\tkz@kiv@grad{#1},
prefix/.code  = \def\tkz@kiv@prefix{#1},
suffix/.code = \def\tkz@kiv@suffix{#1},
unity/.code = \def\tkz@kiv@unity{#1}, 
/kiviatgrad/.unknown/.code ={\let\searchname=\pgfkeyscurrentname
                             \pgfkeysalso{\searchname/.try=#1,
                             /tikz/\searchname/.retry=#1}}   
}
%<--------------------------------------------------------------------------->
\def\tkzKiviatGrad{\pgfutil@ifnextchar[{\tkz@KiviatGrad}{\tkz@KiviatGrad[]}} 
\def\tkz@KiviatGrad[#1](#2){% 
\begingroup
\pgfkeys{/kiviatgrad/.cd,
graduation distance= 0 pt,
prefix ={},
suffix={},
unity=1
 }
 \pgfqkeys{/kiviatgrad}{#1}% 
\let\tikz@label@distance@tmp\tikz@label@distance
\global\let\tikz@label@distance\tkz@kiv@grad
 \foreach \nv in {1,...,\tkz@kiv@lattice}{
 \pgfmathparse{\tkz@kiv@unity*\nv} 
 \pgfmathtruncatemacro{\result}{\pgfmathresult}
 \protected@edef\tkz@kiv@gd{\tkz@kiv@prefix$\result$\tkz@kiv@suffix}
    \path[/kiviatgrad/.cd,#1] (0:0)--(360/\tkz@kiv@radial*#2:\nv*\tkz@kiv@gap) 
       node[label=(360/\tkz@kiv@radial*#2)-90:\tkz@kiv@gd] {}; 
      }
 \let\tikz@label@distance\tikz@label@distance@tmp  
\endgroup
}%
%<--------------------------------------------------------------------------->
%<--------------------------------------------------------------------------->
\pgfkeys{%
/kiviatfile/.cd,
space/.code            =  {\def\tkz@kiv@sp{#1}}, 
gap/.code              =  {\def\tkz@kiv@gap{#1}},
lattice/.code          =  {\def\tkz@kiv@lattice{#1}},
step/.code             =  {\def\tkz@kiv@step{#1}},
radial style/.style    =  {->,>=latex'}, 
lattice style/.style   =  {thin,lightgray},
label style/.style     =  {text width=2 cm,align=center},
label space/.code      =  {\def\tkz@kiv@space{#1}},  
/kiviatfile/.unknown/.code =  {\let\searchname=\pgfkeyscurrentname
                            \pgfkeysalso{\searchname/.try=#1,
                            /tikz/\searchname/.retry=#1}}  
}
%<--------------------------------------------------------------------------->
%<---------------------------------------------------------------------------> 
\def\tkzKiviatDiagramFromFile{\pgfutil@ifnextchar[{\tkz@KiviatFile}{%
                                                    \tkz@KiviatFile[]}} 
\def\tkz@KiviatFile[#1]#2{% 
\pgfkeys{/kiviatfile/.cd,
gap          = .5,
lattice      = 10,
space        = .5,
step         = 1,
label space  = 1.5,
table        = false 
}
\pgfqkeys{/kiviatfile}{#1}%
\begingroup
\pgfplotstablevertcat{\tkz@kivdata}{#2}
\pgfplotstablegetrowsof{\tkz@kivdata}
\pgfmathsetmacro{\nbrows}{\pgfplotsretval}
\pgfmathsetmacro{\rows}{\pgfplotsretval-1}
\pgfplotstablegetcolsof{\tkz@kivdata} 
\pgfmathsetmacro{\cols}{\pgfplotsretval-1}
\pgfplotstablevertcat{\tkz@kivdata}{\tkz@kivdata}
\pgfplotstablegetelem{0}{[index] 0}\of{\tkz@kivdata}
\edef\tkz@kiv@radial{\nbrows}
\foreach \x [count=\rang from 0] in {0,...,\rows}{%
 \pgfplotstablegetelem{\x}{[index] 0}\of{\tkz@kivdata} 
   \draw[/kiviatfile/radial style]
 (0,0)--(360/\tkz@kiv@radial*\rang:\tkz@kiv@lattice*\tkz@kiv@gap+\tkz@kiv@sp);
   \path
(0,0)--(360/\tkz@kiv@radial*\rang:\tkz@kiv@lattice*\tkz@kiv@gap+\tkz@kiv@space) node[/kiviatfile/label style] {\pgfplotsretval}; 

\foreach \y in {0,1,...,\tkz@kiv@lattice}{
   \draw[/kiviat/lattice style]%
     (360/\tkz@kiv@radial*\rang:\y*\tkz@kiv@gap)--%
        (360/\tkz@kiv@radial*\rang+360/\tkz@kiv@radial:\y*\tkz@kiv@gap);
     }
}
\endgroup
}   
%<--------------------------------------------------------------------------->
%<--------------------------------------------------------------------------->
\pgfkeys{/kiviatlinefile/.cd,
fill/.code = {\global\def\tkz@kivl@fill{#1}},
opacity/.code = {\global\def\tkz@kivl@opacity{#1}}, 
/kiviatlinefile/.unknown/.code ={\let\searchname=\pgfkeyscurrentname
                             \pgfkeysalso{\searchname/.try=#1,
                             /tikz/\searchname/.retry=#1}}   
}  
%<--------------------------------------------------------------------------->
\def\tkzKiviatLineFromFile{\pgfutil@ifnextchar[{\tkz@KiviatLineFile}{%
                                            \tkz@KiviatLineFile[]}} 
\def\tkz@KiviatLineFile[#1]#2#3{% 
\begingroup
\pgfkeys{/kiviatlinefile/.cd,
fill= {},
opacity=0.5
}
\pgfqkeys{/kiviatlinefile}{#1}% 
\pgfplotstablevertcat{\tkz@kivdata}{#2}
\pgfplotstablegetrowsof{\tkz@kivdata}
\pgfmathsetmacro{\nbrows}{\pgfplotsretval}
\pgfmathsetmacro{\rows}{\pgfplotsretval-1}
\pgfplotstablegetcolsof{\tkz@kivdata} 
\pgfmathsetmacro{\cols}{\pgfplotsretval-1}
\pgfplotstablevertcat{\tkz@kivdata}{\tkz@kivdata}
\pgfplotstablegetelem{0}{[index] 0}\of{\tkz@kivdata}
\edef\tkz@kiv@radial{\nbrows} 
\ifx\tkzutil@empty\tkz@kivl@fill \else 
\begin{scope}[on background layer] 
      \pgfplotstablegetelem{0}{[index] #3}\of{\tkz@kivdata}
    \let\actualval\pgfplotsretval   
\path[fill=\tkz@kivl@fill,opacity=\tkz@kivl@opacity]
 (0:\actualval*\tkz@kiv@gap*\tkz@kiv@step)
 \foreach \v [count=\rang from 1] in {1,...,\nbrows}{%  
  \pgfextra{\pgfplotstablegetelem{\v}{[index] #3}\of{\tkz@kivdata}}
      -- (360/\tkz@kiv@radial*\v:\pgfplotsretval*\tkz@kiv@gap*\tkz@kiv@step)
   };   
 \end{scope}  
 \fi       
 \foreach \v [count=\rang from 1] in {0,...,\nbrows}{%  
  \pgfplotstablegetelem{\v}{[index] #3}\of{\tkz@kivdata}
  \let\actualval\pgfplotsretval
    \pgfplotstablegetelem{\rang}{[index] #3}\of{\tkz@kivdata}
  \let\nextval\pgfplotsretval 
  \draw[#1,opacity=1] (360/\tkz@kiv@radial*\v:\actualval*\tkz@kiv@gap)    
  -- (360/\tkz@kiv@radial*\rang:\nextval*\tkz@kiv@gap*\tkz@kiv@step)
   plot coordinates {(360/\tkz@kiv@radial*\rang:\nextval*\tkz@kiv@gap*\tkz@kiv@step)};  
 }   
\endgroup
}%

%<--------------------------- the end --------------------------------------->
\endinput  





%------------------------------
