\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{msi-worksheet}
  [2017/07/25 v0.01 LaTeX package for MSI worksheets]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions \relax

\LoadClass[a4paper,12pt]{article}


  \def\be@mertypeis#1{FF\fi
   \edef\my@predicate{#1}%
   \edef\my@predicate{\expandafter\strip@prefix\meaning\my@predicate}%
   \edef\my@job{\be@mertype}%
   \ifx\be@mertype\my@predicate
  }

  \def\be@mertwo#1.#2\relax{#2}
  \def\be@merone#1.#2\relax{#1}

% Find out how many components jobname has.  Format is
% name[.type[.date]] where name has no dots, type is the type of
% output (default ``beamer'') and date is the date of the lecture to
% be produced, in ISO format of YYYYMMDD.

  \let\be@merdate\@empty

  \edef\be@mertest{\expandafter\be@merone\jobname.j\relax}
  \edef\my@jobname{\jobname}

  \ifx\be@mertest\my@jobname

% Only one component

   \def\be@mertype{beamer}
   \def\be@merfile{\jobname}
  \else
   \edef\be@mertest{\expandafter\be@merone\jobname\relax.\expandafter\expandafter\expandafter\be@merone\expandafter\be@mertwo\jobname.j\relax\relax}

   \ifx\be@mertest\my@jobname

% Only two components

    \edef\be@mertype{\expandafter\be@mertwo\jobname\relax}
    \edef\be@merfile{\expandafter\be@merone\jobname\relax}
   \else

% Three components

    \edef\be@merdate{\expandafter\expandafter\expandafter\expandafter\expandafter\expandafter\expandafter\be@merone\expandafter\expandafter\expandafter\be@mertwo\expandafter\be@mertwo\jobname\relax\relax.j\relax}
    \edef\be@mertype{\expandafter\expandafter\expandafter\be@merone\expandafter\be@mertwo\jobname\relax\relax}
    \edef\be@merfile{\expandafter\be@merone\jobname\relax}

  \g@addto@macro{\my@afterpackages}{%
    \expandafter\includeonlylecture\expandafter{\be@merdate}

  }

   \fi
  \fi

  \edef\be@merdefopts{12pt,t,xcolor=dvipsnames,ignorenonframetext}

\def\jobtype{\be@mertype}


\usepackage{amsmath, amssymb, amsfonts, latexsym}
\usepackage{setspace}
\usepackage{graphicx}
\usepackage{epstopdf}
\usepackage{fancyhdr}
\usepackage{color}
\usepackage{bm}
\usepackage[nomessages]{fp}

\usepackage[T1]{fontenc}
\usepackage{microtype}
\usepackage{ifthen}

% some people don't seem to have access to the Linux Libertine fonts on old
% installations, so we only loading them if they're there.
\IfFileExists{libertine.sty}{%
\usepackage{libertine}
\IfFileExists{newtxmath.sty}{%
\usepackage[libertine]{newtxmath}
}{}
}{}

\usepackage{silence}
\WarningFilter{latexfont}{Font shape}
\WarningFilter{latexfont}{Size substitutions}

\usepackage{tikz}

\newboolean{showanswer}
\newboolean{showgrade}

\setboolean{showanswer}{false}
\setboolean{showgrade}{false}

\if\be@mertypeis{solutions}
  \setboolean{showanswer}{true}
\fi


\usepackage{environ}
%-------------------------
% Show/Hide the answers
%-------------------------
\NewEnviron{answer}{
    \ifthenelse{\boolean{showanswer}}{
      {\color{blue}{\bf Answer} \it \BODY}
    }{}
}
\NewEnviron{grading}{
    \ifthenelse{\boolean{showgrade}}{
      \singlespace {\color{red}{\bf Grading Scheme:}  \tt \begin{itemize}\BODY \end{itemize}}
    }{}
}

\NewEnviron{hint}{
    {{\bf Hint:} \it \BODY}
}


\newcommand{\points}[1]{{\hspace*{\fill}\ifthenelse{\equal{#1}{1}}{\textit{1~pt}}{\textit{#1~pts}} }}
\newcommand{\subpoints}[1]{{\hspace*{\fill}\ifthenelse{\equal{#1}{1}}{\textit{1~pt}}{\textit{#1~pts}} }}

\def\qrule{
    \vspace{5pt}
    \hrule height 0.25pt depth 0.25pt
    \vspace{5pt}
    }

\newcounter{question}

\newenvironment{question}[2][]{
    \stepcounter{question}
    %\storequestion{#2}%
    \clearpage
    \noindent\textbf{\gdef\quest{\the\value{question}}Question \quest \ \ifthenelse{\equal{#1}{}}{}{(#1)} \quad\points{#2}}\qrule    
}{}

\newcommand{\bi}{{\mathbf i}}
\newcommand{\bj}{{\mathbf j}}
\newcommand{\bk}{{\mathbf k}}
%\newcommand{\ba}{{\mathbf a}}
\newcommand{\bb}{{\mathbf b}}
\newcommand{\bx}{{\mathbf x}}
\newcommand{\bv}{{\mathbf v}}
\newcommand{\bw}{{\mathbf w}}
\newcommand{\br}{{\mathbf r}}
\newcommand{\bu}{{\mathbf u}}
\newcommand{\by}{{\mathbf y}}
\newcommand{\bz}{{\mathbf z}}
%\newcommand{\bp}{{\mathbf p}}
%\newcommand{\bq}{{\mathbf q}}
\newcommand{\bc}{{\mathbf c}}
\newcommand{\bn}{{\mathbf n}}
\newcommand{\bR}{{\mathbb R}}
\newcommand{\bP}{\ensuremath{\mathbb P}}
%\newcommand{\nul}{\operatorname{Nul }}
%\newcommand{\col}{\operatorname{Col }}
\newcommand{\row}{\operatorname{Row}}
\newcommand{\ra}{\operatorname{Range}}
\newcommand{\Span}{\operatorname{Span}}
%\newcommand{\span}{\operatorname{Span}}
%\newcommand{\R}{\mathbb{R}}
%\newcommand{\bull}{\mathbf{\cdot}}
%\newcommand{\bti}{\ensuremath{\mathbf {\times}}}

\newcommand{\col}{\operatorname{col}}
\newcommand{\nul}{\operatorname{nul}}
\newcommand{\trace}{\operatorname{trace}}
\newcommand{\spanset}{\operatorname{span}}
\newcommand{\adj}{\operatorname{adj}}

\newcommand{\cB}{\ensuremath{\mathcal B}}
\newcommand{\cE}{\ensuremath{\mathcal E}}
\newcommand{\cC}{\ensuremath{\mathcal C}}
\newcommand{\cD}{\ensuremath{\mathcal D}}
\def\TBC {\hbox{\lower 4pt\hbox{$\buildrel \ \textstyle
T\over{\scriptscriptstyle\cal B\leftarrow\cal C}$}}}
\def\TCB {\hbox{\lower 4pt\hbox{$\buildrel \ \textstyle
T\over{\scriptscriptstyle\cal C\leftarrow\cal B}$}}}
